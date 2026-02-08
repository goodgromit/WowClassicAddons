-- SimpleDungeonMaps - A simple dungeon map viewer
local addonName, addon = ...
local PREFIX = "SDM_SYNC"
SimpleDungeonMapsDB = SimpleDungeonMapsDB or {}

local function L(key)
    if not addon or not addon.GetText then return key end
    return addon:GetText(key) or key
end

local frame = CreateFrame("Frame", "SimpleDungeonMapsFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(780, 500)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, relativePoint, x, y = self:GetPoint()
    SimpleDungeonMapsDB.position = { point = point, relativePoint = relativePoint, x = x, y = y }
end)
frame:Hide()
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.title:SetPoint("TOP", 0, -5)
frame.title:SetText(L("Simple Dungeon Maps"))

local mapTexture = frame:CreateTexture(nil, "ARTWORK")
mapTexture:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -60)
mapTexture:SetSize(512, 384)
addon.mapTexture = mapTexture

local canvas = CreateFrame("Frame", "SimpleDungeonMapsCanvas", frame)
canvas:SetAllPoints(mapTexture)
canvas:SetFrameLevel(frame:GetFrameLevel() + 5)
canvas:EnableMouse(true)
addon.canvas = canvas
canvas.markers, canvas.lines, canvas.tool = {}, {}, "none"
canvas.selectedMarker, canvas.selectedColor = 8, { r = 1, g = 1, b = 1 } 

local tipsPanel = CreateFrame("Frame", nil, frame, "InsetFrameTemplate")
tipsPanel:SetPoint("TOPLEFT", mapTexture, "TOPRIGHT", 10, 0)
tipsPanel:SetSize(220, 384)

local tipsTitle = tipsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
tipsTitle:SetPoint("TOP", tipsPanel, "TOP", 0, -10)
tipsTitle:SetText(L("Dungeon Info"))

local tipsText = tipsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
tipsText:SetPoint("TOPLEFT", tipsPanel, "TOPLEFT", 10, -35)
tipsText:SetPoint("TOPRIGHT", tipsPanel, "TOPRIGHT", -10, -35)
tipsText:SetJustifyH("LEFT")
tipsText:SetJustifyV("TOP")
tipsText:SetWordWrap(true)
addon.tipsText = tipsText

local selectedExpansion, currentMapKey = "classic", nil

local function GetLocalizedValue(tbl)
    if not tbl then return "" end
    if type(tbl) == "string" then return tbl end
    return tbl[addon.currentLanguage or "en"] or tbl["en"] or ""
end

local function SendSync(msg)
    if IsInGroup() then
        C_ChatInfo.SendAddonMessage(PREFIX, msg, IsInRaid() and "RAID" or "PARTY")
    end
end

local function SaveState()
    if not currentMapKey then return end
    SimpleDungeonMapsDB.lastMapKey = currentMapKey
    SimpleDungeonMapsDB[currentMapKey] = SimpleDungeonMapsDB[currentMapKey] or { markers = {}, lines = {} }
    local saved = SimpleDungeonMapsDB[currentMapKey]
    saved.markers = {}
    saved.lines = {}
    
    for id, m in pairs(canvas.markers) do 
        local _, _, _, xOfs, yOfs = m:GetPoint()
        if xOfs and yOfs then
            table.insert(saved.markers, { x = xOfs/canvas:GetWidth(), y = yOfs/canvas:GetHeight(), id = id }) 
        end
    end
    for _, l in ipairs(canvas.lines) do 
        table.insert(saved.lines, { x1 = l.x1, y1 = l.y1, x2 = l.x2, y2 = l.y2, r = l.r, g = l.g, b = l.b }) 
    end
end

local function ClearCanvas(noSync, noSave)
    for _, m in pairs(canvas.markers) do m:Hide() end
    for _, l in ipairs(canvas.lines) do if l.obj then l.obj:Hide() end end
    canvas.markers, canvas.lines = {}, {}
    if not noSync then SendSync("CLEAR") end
    if not noSave then SaveState() end
end

local function AddMarker(x, y, midx, noSync, noSave)
    local idx = midx or canvas.selectedMarker or 8
    local m = canvas.markers[idx]
    if not m then
        m = canvas:CreateTexture(nil, "OVERLAY")
        m:SetSize(16, 16)
        m:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
        local col, row = (idx - 1) % 4, math.floor((idx - 1) / 4)
        m:SetTexCoord(col * 0.25, (col + 1) * 0.25, row * 0.25, (row + 1) * 0.25)
        canvas.markers[idx] = m
    end
    m:ClearAllPoints()
    m:SetPoint("CENTER", canvas, "BOTTOMLEFT", x * canvas:GetWidth(), y * canvas:GetHeight())
    m:Show()
    if not noSync then SendSync(string.format("M:%.3f:%.3f:%d", x, y, idx)) end
    if not noSave then SaveState() end
end

local function AddLine(x1, y1, x2, y2, r, g, b, noSync)
    local lr, lg, lb = r or canvas.selectedColor.r, g or canvas.selectedColor.g, b or canvas.selectedColor.b
    local lObj = nil
    if canvas.CreateLine then
        lObj = canvas:CreateLine(nil, "OVERLAY")
        lObj:SetThickness(2)
        lObj:SetColorTexture(lr, lg, lb, 0.8)
        lObj:SetStartPoint("BOTTOMLEFT", canvas, x1 * canvas:GetWidth(), y1 * canvas:GetHeight())
        lObj:SetEndPoint("BOTTOMLEFT", canvas, x2 * canvas:GetWidth(), y2 * canvas:GetHeight())
    end
    table.insert(canvas.lines, { x1 = x1, y1 = y1, x2 = x2, y2 = y2, r = lr, g = lg, b = lb, obj = lObj })
    if not noSync then SendSync(string.format("P:%.3f:%.3f:%.3f:%.3f:%.2f:%.2f:%.2f", x1, y1, x2, y2, lr, lg, lb)) end
end

canvas:SetScript("OnMouseDown", function(self, btn)
    if canvas.tool == "none" then return end
    local x, y = GetCursorPosition()
    local s = self:GetEffectiveScale()
    x, y = (x/s) - self:GetLeft(), (y/s) - self:GetBottom()
    x, y = x / self:GetWidth(), y / self:GetHeight()
    if canvas.tool == "marker" then 
        AddMarker(x, y) 
    elseif canvas.tool == "draw" then 
        self.isDrawing = true
        self.lastX, self.lastY = x, y 
    end
end)

canvas:SetScript("OnUpdate", function(self)
    if self.isDrawing then
        local x, y = GetCursorPosition()
        local s = self:GetEffectiveScale()
        x, y = (x/s) - self:GetLeft(), (y/s) - self:GetBottom()
        x, y = x / self:GetWidth(), y / self:GetHeight()
        if not self.lastX then self.lastX, self.lastY = x, y return end
        local dist = math.sqrt((x-self.lastX)^2 + (y-self.lastY)^2)
        if dist > 0.005 then 
            AddLine(self.lastX, self.lastY, x, y)
            self.lastX, self.lastY = x, y 
        end
    end
end)

canvas:SetScript("OnMouseUp", function(self) 
    self.isDrawing = false
    self.lastX, self.lastY = nil, nil
    SaveState() 
end)

local function GetExportString()
    if not currentMapKey then return "" end
    local s = "SDM:2:" .. currentMapKey .. ":"
    for id, m in pairs(canvas.markers) do 
        local _, _, _, xOfs, yOfs = m:GetPoint()
        if xOfs and yOfs then
            s = s .. string.format("%.3f,%.3f,%d|", xOfs/canvas:GetWidth(), yOfs/canvas:GetHeight(), id) 
        end
    end
    s = s .. ":"
    for _, l in ipairs(canvas.lines) do 
        s = s .. string.format("%.3f,%.3f,%.3f,%.3f,%.2f,%.2f,%.2f|", l.x1, l.y1, l.x2, l.y2, l.r, l.g, l.b) 
    end
    return s
end

local function LoadFromExportString(s)
    if not s or not s:find("^SDM:") then return end
    local parts = {strsplit(":", s)}
    local mapKey, mStr, pStr = parts[3], parts[4], parts[5]
    if not mapKey then return end
    addon.ShowMap(mapKey, true)
    if mStr and mStr ~= "" then 
        for _, m in ipairs({strsplit("|", mStr)}) do 
            if m ~= "" then 
                local x, y, i = strsplit(",", m)
                if x and y and i then AddMarker(tonumber(x), tonumber(y), tonumber(i), true, true) end 
            end 
        end 
    end
    if pStr and pStr ~= "" then 
        for _, p in ipairs({strsplit("|", pStr)}) do 
            if p ~= "" then 
                local b = {strsplit(",", p)}
                if b[1] then AddLine(tonumber(b[1]), tonumber(b[2]), tonumber(b[3]), tonumber(b[4]), tonumber(b[5] or 1), tonumber(b[6] or 1), tonumber(b[7] or 1), true) end 
            end 
        end 
    end
    SaveState()
end

local shareFrame = CreateFrame("Frame", "SimpleDungeonMapsShareFrame", frame, "BasicFrameTemplateWithInset")
shareFrame:SetSize(400, 200)
shareFrame:SetPoint("CENTER")
shareFrame:SetFrameLevel(frame:GetFrameLevel() + 20)
shareFrame:Hide()
shareFrame.title = shareFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
shareFrame.title:SetPoint("TOP", 0, -5)
shareFrame.title:SetText(L("Import/Export String"))

local editBox = CreateFrame("EditBox", nil, shareFrame, "InputBoxTemplate")
editBox:SetSize(370, 30)
editBox:SetPoint("TOP", 0, -80)
editBox:SetAutoFocus(false)
editBox:SetScript("OnEscapePressed", function(self) shareFrame:Hide() end)

local importBtn = CreateFrame("Button", nil, shareFrame, "UIPanelButtonTemplate")
importBtn:SetSize(100, 25)
importBtn:SetPoint("BOTTOMLEFT", 80, 20)
importBtn:SetText(L("Import"))
importBtn:SetScript("OnClick", function() LoadFromExportString(editBox:GetText()); shareFrame:Hide() end)

local closeBtn = CreateFrame("Button", nil, shareFrame, "UIPanelButtonTemplate")
closeBtn:SetSize(100, 25)
closeBtn:SetPoint("BOTTOMRIGHT", -80, 20)
closeBtn:SetText(L("Close"))
closeBtn:SetScript("OnClick", function() shareFrame:Hide() end)

local expansionDropdown, dungeonDropdown, languageDropdown, markerDropdown, DungeonDropdown_Initialize

local function ShowMap(mapKey, forceClear)
    if not mapKey then return end
    local data = addon.dungeonMaps[mapKey]
    if not data then return end
    
    if forceClear or mapKey ~= currentMapKey then
        ClearCanvas(true, true)
        currentMapKey = mapKey
        local saved = SimpleDungeonMapsDB[mapKey]
        if saved then 
            if saved.markers then for _, m in ipairs(saved.markers) do AddMarker(m.x, m.y, m.id, true, true) end end
            if saved.lines then for _, l in ipairs(saved.lines) do AddLine(l.x1, l.y1, l.x2, l.y2, l.r, l.g, l.b, true) end end 
        end
        SimpleDungeonMapsDB.lastMapKey = mapKey
    end
    
    mapTexture:SetTexture("Interface\\AddOns\\SimpleDungeonMaps\\Images\\" .. mapKey)
    frame.title:SetText(GetLocalizedValue(data.name))
    
    local tips = "|cffffffff" .. GetLocalizedValue(data.name) .. "|r\n\n"
    if data.levelRange then tips = tips .. "|cffffcc00" .. L("Level:") .. "|r " .. data.levelRange .. "\n\n" end
    if data.location then tips = tips .. "|cffffcc00" .. L("Location:") .. "|r " .. GetLocalizedValue(data.location) .. "\n\n" end
    if data.tips then tips = tips .. "|cffffcc00" .. L("Tips:") .. "|r\n" .. GetLocalizedValue(data.tips) end
    tipsText:SetText(tips)
    
    if dungeonDropdown then UIDropDownMenu_SetText(dungeonDropdown, GetLocalizedValue(data.name) .. " (" .. data.levelRange .. ")") end
end
addon.ShowMap = ShowMap

local toolbar = CreateFrame("Frame", nil, frame)
toolbar:SetSize(750, 40)
toolbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 15, 10)

local function CreateToolBtn(text, x, tool, width)
    local btn = CreateFrame("Button", nil, toolbar, "UIPanelButtonTemplate")
    btn:SetSize(width or 60, 22)
    btn:SetPoint("LEFT", x, 0)
    btn:SetText(text)
    btn:SetScript("OnClick", function() canvas.tool = tool end)
    return btn
end

local btnMarker = CreateToolBtn(L("Marker"), 0, "marker", 80)
local btnDraw = CreateToolBtn(L("Draw"), 85, "draw", 75)
local colorIndicator = toolbar:CreateTexture(nil, "OVERLAY")
colorIndicator:SetSize(22, 22)
colorIndicator:SetPoint("LEFT", btnDraw, "RIGHT", 5, 0)
colorIndicator:SetColorTexture(1, 1, 1, 1)

local palette = {{1,1,1},{1,0,0},{0,1,0},{0,0,1},{1,0.8,0},{1,0,1},{0,1,1},{0,0,0}}
for i, rgb in ipairs(palette) do 
    local b = CreateFrame("Button", nil, toolbar)
    b:SetSize(14, 14)
    b:SetPoint("LEFT", colorIndicator, "RIGHT", 5 + (i-1)*16, 0)
    local t = b:CreateTexture(nil, "BACKGROUND")
    t:SetAllPoints()
    t:SetColorTexture(rgb[1], rgb[2], rgb[3], 1)
    b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    b:SetScript("OnClick", function() 
        canvas.selectedColor = { r=rgb[1], g=rgb[2], b=rgb[3] }
        colorIndicator:SetColorTexture(rgb[1], rgb[2], rgb[3], 1) 
        SimpleDungeonMapsDB.selectedColor = canvas.selectedColor
    end)
end

local btnClear = CreateFrame("Button", nil, toolbar, "UIPanelButtonTemplate")
btnClear:SetSize(70, 22)
btnClear:SetPoint("LEFT", colorIndicator, "RIGHT", 145, 0)
btnClear:SetText(L("Clear"))
btnClear:SetScript("OnClick", function() ClearCanvas() end)

local markerIcon = toolbar:CreateTexture(nil, "OVERLAY")
markerIcon:SetSize(20, 20)
markerIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
markerIcon:SetPoint("LEFT", btnClear, "RIGHT", 10, 0)

local btnExp = CreateFrame("Button", nil, toolbar, "UIPanelButtonTemplate")
btnExp:SetSize(60, 22)
btnExp:SetPoint("RIGHT", toolbar, "RIGHT", -70, 0)
btnExp:SetText("Export")
btnExp:SetScript("OnClick", function() editBox:SetText(GetExportString()); editBox:HighlightText(); editBox:SetFocus(); shareFrame:Show() end)

local btnImp = CreateFrame("Button", nil, toolbar, "UIPanelButtonTemplate")
btnImp:SetSize(60, 22)
btnImp:SetPoint("RIGHT", toolbar, "RIGHT", -5, 0)
btnImp:SetText("Import")
btnImp:SetScript("OnClick", function() editBox:SetText(""); editBox:SetFocus(); shareFrame:Show() end)

local markers = {{text="Star",icon=1},{text="Circle",icon=2},{text="Diamond",icon=3},{text="Triangle",icon=4},{text="Moon",icon=5},{text="Square",icon=6},{text="Cross",icon=7},{text="Skull",icon=8}}

local function UpdateUI()
    local midx = canvas.selectedMarker or 8
    local mName = "Skull"
    for _, it in ipairs(markers) do if it.icon == midx then mName = it.text break end end
    if markerDropdown then UIDropDownMenu_SetText(markerDropdown, L(mName)) end
    
    local c, r = (midx-1)%4, math.floor((midx-1)/4)
    markerIcon:SetTexCoord(c*0.25, (c+1)*0.25, r*0.25, (r+1)*0.25)
    colorIndicator:SetColorTexture(canvas.selectedColor.r, canvas.selectedColor.g, canvas.selectedColor.b, 1)
    
    if btnMarker then btnMarker:SetText(L("Marker")) end
    if btnDraw then btnDraw:SetText(L("Draw")) end
    if btnClear then btnClear:SetText(L("Clear")) end
    if btnExp then btnExp:SetText("Export") end
    if btnImp then btnImp:SetText("Import") end
    if tipsTitle then tipsTitle:SetText(L("Dungeon Info")) end
    
    if languageDropdown then UIDropDownMenu_SetText(languageDropdown, addon.currentLanguage == "de" and L("German") or L("English")) end
    if expansionDropdown then UIDropDownMenu_SetText(expansionDropdown, L(selectedExpansion == "classic" and "Classic" or "Burning Crusade")) end
    if currentMapKey then ShowMap(currentMapKey) end
end

DungeonDropdown_Initialize = function(self)
    local list = addon.dungeonsByExpansion[selectedExpansion] or {}
    for _, entry in ipairs(list) do
        local info = UIDropDownMenu_CreateInfo()
        if entry.isHeader then 
            info.text, info.isTitle, info.notCheckable, info.disabled = "|cffffcc00" .. L(entry.name) .. "|r", true, true, true
            UIDropDownMenu_AddButton(info)
        else 
            local d = addon.dungeonMaps[entry.mapKey]
            if d then 
                info.text, info.notCheckable = "    " .. GetLocalizedValue(d.name) .. " (" .. d.levelRange .. ")", true
                info.func = function() ShowMap(entry.mapKey, true); CloseDropDownMenus() end
                UIDropDownMenu_AddButton(info) 
            end 
        end
    end
end

languageDropdown = CreateFrame("Frame", "SimpleDungeonMapsLanguageDropdown", frame, "UIDropDownMenuTemplate")
languageDropdown:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -30)
UIDropDownMenu_SetWidth(languageDropdown, 100)
UIDropDownMenu_Initialize(languageDropdown, function()
    local info = UIDropDownMenu_CreateInfo()
    info.text = L("English")
    info.func = function() 
        addon.currentLanguage = "en"
        SimpleDungeonMapsDB.language = "en"
        UpdateUI()
        CloseDropDownMenus() 
    end
    info.checked = (addon.currentLanguage == "en")
    UIDropDownMenu_AddButton(info)
    info.text = L("German")
    info.func = function() 
        addon.currentLanguage = "de"
        SimpleDungeonMapsDB.language = "de"
        UpdateUI()
        CloseDropDownMenus() 
    end
    info.checked = (addon.currentLanguage == "de")
    UIDropDownMenu_AddButton(info)
end)

local function SetExpansion(exp)
    selectedExpansion = exp
    SimpleDungeonMapsDB.expansion = exp
    UIDropDownMenu_Initialize(dungeonDropdown, DungeonDropdown_Initialize)
    UpdateUI()
    local list = addon.dungeonsByExpansion[exp]
    if list then
        for _, entry in ipairs(list) do
            if not entry.isHeader and entry.mapKey then
                ShowMap(entry.mapKey, true)
                break
            end
        end
    end
end

expansionDropdown = CreateFrame("Frame", "SimpleDungeonMapsExpansionDropdown", frame, "UIDropDownMenuTemplate")
expansionDropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -30)
UIDropDownMenu_SetWidth(expansionDropdown, 120)
UIDropDownMenu_Initialize(expansionDropdown, function()
    local info = UIDropDownMenu_CreateInfo()
    info.text = L("Classic")
    info.func = function() SetExpansion("classic"); CloseDropDownMenus() end
    UIDropDownMenu_AddButton(info)
    info.text = L("Burning Crusade")
    info.func = function() SetExpansion("tbc"); CloseDropDownMenus() end
    UIDropDownMenu_AddButton(info)
end)

dungeonDropdown = CreateFrame("Frame", "SimpleDungeonMapsDungeonDropdown", frame, "UIDropDownMenuTemplate")
dungeonDropdown:SetPoint("LEFT", expansionDropdown, "RIGHT", 0, 0)
UIDropDownMenu_SetWidth(dungeonDropdown, 250)
UIDropDownMenu_Initialize(dungeonDropdown, DungeonDropdown_Initialize)

markerDropdown = CreateFrame("Frame", "SimpleDungeonMapsMarkerDropdown", toolbar, "UIDropDownMenuTemplate")
markerDropdown:SetPoint("LEFT", markerIcon, "RIGHT", -15, 0)
UIDropDownMenu_SetWidth(markerDropdown, 70)
UIDropDownMenu_Initialize(markerDropdown, function()
    for _, it in ipairs(markers) do
        local info = UIDropDownMenu_CreateInfo()
        info.text, info.checked, info.icon = L(it.text), canvas.selectedMarker == it.icon, "Interface\\TargetingFrame\\UI-RaidTargetingIcons"
        local c, r = (it.icon-1)%4, math.floor((it.icon-1)/4)
        info.tCoordLeft, info.tCoordRight, info.tCoordTop, info.tCoordBottom = c*0.25, (c+1)*0.25, r*0.25, (r+1)*0.25
        info.func = function() 
            canvas.selectedMarker = it.icon; 
            SimpleDungeonMapsDB.selectedMarker = it.icon
            UpdateUI(); 
            CloseDropDownMenus() 
        end
        UIDropDownMenu_AddButton(info)
    end
end)

SLASH_SIMPLEDUNGEONMAPS1 = "/sdm"
SlashCmdList["SIMPLEDUNGEONMAPS"] = function() if frame:IsShown() then frame:Hide() else frame:Show() end end

local mmBtn = CreateFrame("Button", "SimpleDungeonMapsMinimapButton", Minimap)
mmBtn:SetSize(32, 32)
mmBtn:SetFrameStrata("MEDIUM")
mmBtn:SetFrameLevel(Minimap:GetFrameLevel() + 10)
mmBtn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
local mmIcon = mmBtn:CreateTexture(nil, "BACKGROUND")
mmIcon:SetSize(20, 20)
mmIcon:SetTexture("Interface\\AddOns\\SimpleDungeonMaps\\sdm_icon")
mmIcon:SetPoint("CENTER")
local mmBorder = mmBtn:CreateTexture(nil, "OVERLAY")
mmBorder:SetSize(52, 52)
mmBorder:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
mmBorder:SetPoint("CENTER", mmBtn, "CENTER", 10, -12)

local function UpdateMinimapButton(angle)
    local a = angle or (SimpleDungeonMapsDB and SimpleDungeonMapsDB.mmAngle) or (math.pi/2)
    mmBtn:ClearAllPoints()
    mmBtn:SetPoint("CENTER", Minimap, "CENTER", math.cos(a)*80, math.sin(a)*80)
end

mmBtn:SetScript("OnClick", function() if frame:IsShown() then frame:Hide() else frame:Show() end end)
mmBtn:RegisterForDrag("LeftButton")
mmBtn:SetScript("OnDragStart", function(self) self.isDrawing = true end)
mmBtn:SetScript("OnDragStop", function(self) self.isDrawing = false end)
mmBtn:SetScript("OnUpdate", function(self) 
    if self.isDrawing then
        local mx, my = Minimap:GetCenter()
        local px, py = GetCursorPosition()
        local s = Minimap:GetEffectiveScale()
        px, py = px/s, py/s
        local a = math.atan2(py-my, px-mx)
        SimpleDungeonMapsDB.mmAngle = a
        UpdateMinimapButton(a)
    end 
end)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("CHAT_MSG_ADDON")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, prefix, text, channel, sender)
    if event == "ADDON_LOADED" and prefix == addonName then 
        SimpleDungeonMapsDB = SimpleDungeonMapsDB or {}
        if SimpleDungeonMapsDB.language then
            addon.currentLanguage = SimpleDungeonMapsDB.language
        end
        if SimpleDungeonMapsDB.expansion then
            selectedExpansion = SimpleDungeonMapsDB.expansion
        end
        if SimpleDungeonMapsDB.selectedMarker then
            canvas.selectedMarker = SimpleDungeonMapsDB.selectedMarker
        end
        if SimpleDungeonMapsDB.selectedColor then
            canvas.selectedColor = SimpleDungeonMapsDB.selectedColor
        end
        if SimpleDungeonMapsDB.position then
            local p = SimpleDungeonMapsDB.position
            frame:ClearAllPoints()
            frame:SetPoint(p.point, UIParent, p.relativePoint, p.x, p.y)
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
        UpdateUI()
        UpdateMinimapButton()
        local target = SimpleDungeonMapsDB.lastMapKey or "TheDeadminesA"
        ShowMap(target, true)
    elseif event == "CHAT_MSG_ADDON" and prefix == PREFIX then
        if Ambiguate(sender, "none") == UnitName("player") then return end
        local type, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = strsplit(":", text)
        if type == "CLEAR" then 
            ClearCanvas(true, true)
        elseif type == "M" then 
            AddMarker(tonumber(arg1 or 0), tonumber(arg2 or 0), tonumber(arg3 or 8), true, true)
        elseif type == "P" then 
            AddLine(tonumber(arg1 or 0), tonumber(arg2 or 0), tonumber(arg3 or 0), tonumber(arg4 or 0), tonumber(arg5 or 1), tonumber(arg6 or 1), tonumber(arg7 or 1), true) 
        end
    end
end)

print("|cff00ff00Simple Dungeon Maps loaded!|r Type |cffffff00/sdm|r to open.")
