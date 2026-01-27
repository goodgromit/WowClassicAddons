--[[ 
VendorPriceTip.lua
Version: 1.1.1
Author: Gyroglle-Netherwing
Description: Shows vendor sell price on item tooltips, multiplied by stack size (bags & quest rewards), hiding Blizzard's native vendor price.
Compatible: TBC Classic 2.5.2 (private servers)
]]

-- TBC Classic Anniversary (2.5.5) container API compatibility
if C_Container then
    GetContainerItemInfo = C_Container.GetContainerItemInfo
    GetContainerItemLink = C_Container.GetContainerItemLink
end


local function AddVendorPrice(tooltip)
    if not tooltip then return end
    local _, link = tooltip:GetItem()
    if not link then return end

    local function getItemID(l)
        if not l then return nil end
        local id = l:match("item:(%d+):")
        return id and tonumber(id) or nil
    end

    local itemID = getItemID(link)
    if not itemID then return end

    -- Get vendor sell price
    local _, _, _, _, _, _, _, _, _, _, sellPrice = GetItemInfo(link)
    if not sellPrice or sellPrice <= 0 then return end

    local count = 1
    local owner = tooltip:GetOwner()
    local ownerName = owner and owner.GetName and owner:GetName() or ""
    local parent = owner and owner.GetParent and owner:GetParent()
    local parentName = parent and parent.GetName and parent:GetName() or ""
    local grandparent = parent and parent.GetParent and parent:GetParent()
    local grandparentName = grandparent and grandparent.GetName and grandparent:GetName() or ""

    -- === Quest frame handling ===
    local isQuestFrame =
        (ownerName and ownerName:match("^QuestFrame")) or
        (parentName and parentName:match("^QuestFrame")) or
        (grandparentName and grandparentName:match("^QuestFrame"))

    if isQuestFrame then
        if ownerName:match("^QuestRewardItem%d+$") then
            local idx = owner:GetID()
            local _, _, qty = GetQuestItemInfo("reward", idx)
            if qty and qty > 1 then count = qty end
        elseif parentName:match("^QuestProgressItem%d+$") or parentName:match("^QuestChoiceItem%d+$") then
            local idx = parent:GetID()
            local _, _, qty = GetQuestItemInfo("required", idx)
            if not qty or qty == 0 then
                _, _, qty = GetQuestItemInfo("reward", idx)
            end
            if qty and qty > 1 then count = qty end
        end
    else
        -- === BAG HANDLING (fixed) ===
        local found = nil

        -- Try to infer bag & slot directly from owner hierarchy
        if owner and owner.GetID and parent and parent.GetID then
            local slot = owner:GetID()
            local bag = parent:GetID()
            if type(bag) == "number" and type(slot) == "number" then
                -- TBC Classic uses 0–4 for bags
                local ok, texture, itemCount, locked, quality, readable, lootable, link2 = pcall(GetContainerItemInfo, bag, slot)
                if ok and itemCount and itemCount > 0 then
                    local ok2, contLink = pcall(GetContainerItemLink, bag, slot)
                    if ok2 and contLink and getItemID(contLink) == itemID then
                        found = itemCount
                    end
                end
            end
        end

        -- Fallback: if owner hierarchy didn't provide bag/slot info, but tooltip can tell us explicitly
        if not found and tooltip.GetBagItem then
            local bag, slot = tooltip:GetBagItem()
            if bag and slot then
                local ok, texture, itemCount = pcall(GetContainerItemInfo, bag, slot)
                if ok and itemCount and itemCount > 0 then
                    found = itemCount
                end
            end
        end

        if found and found > 0 then
            count = found
        end
    end

    -- === Compose total vendor price ===
    local totalPrice = sellPrice * count
    local copper = totalPrice % 100
    local silver = math.floor((totalPrice % 10000) / 100)
    local gold = math.floor(totalPrice / 10000)

    local priceText = ""
    if gold > 0 then priceText = priceText .. gold .. " |TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0|t " end
    if silver > 0 then priceText = priceText .. silver .. " |TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0|t " end
    if copper > 0 or (gold == 0 and silver == 0) then
        priceText = priceText .. copper .. " |TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t"
    end

    -- Avoid duplicates
    local tname = tooltip:GetName()
    if tname then
        for i = 1, tooltip:NumLines() do
            local line = _G[tname .. "TextLeft" .. i]
            if line and line:GetText() and line:GetText():find("UI%-GoldIcon") then
                return
            end
        end
    end

    tooltip:AddLine(" ")
    tooltip:AddLine(priceText)
    tooltip:Show()
end


-- === Hide Blizzard's native vendor price (after it appears) ===
-- Make a safe no-op for nil-safe tostring checks
local function safeGetText(fs)
    if not fs or not fs.GetText then return nil end
    return fs:GetText()
end

-- Attempt to silently remove native sell-price visuals by clearing text and setting alpha 0
local function removeNativeSellPriceSilently(tooltip)
    if not tooltip then return false end
    local tname = tooltip:GetName()
    if not tname then return false end

    local changed = false
    local sellLabel = ITEM_SELL_PRICE or "Sell Price"

    -- MoneyFrame children: set alpha to 0 instead of Hide
    for i = 1, 10 do
        local mf = _G[tname.."MoneyFrame"..i]
        if mf and mf:IsShown() and mf.SetAlpha then
            mf:SetAlpha(0)
            changed = true
        end
    end

    -- Fontstrings: clear visible text and set alpha to 0 to keep layout stable
    for i = 1, tooltip:NumLines() do
        local left = _G[tname.."TextLeft"..i]
        local right = _G[tname.."TextRight"..i]

        local ltxt = safeGetText(left)
        if ltxt and (ltxt:find(sellLabel, 1, true) or ltxt:find("UI%-GoldIcon")) then
            if left.SetText then left:SetText("") end
            if left.SetAlpha then left:SetAlpha(0) end
            changed = true
        end

        local rtxt = safeGetText(right)
        if rtxt and (rtxt:find(sellLabel, 1, true) or rtxt:find("UI%-GoldIcon")) then
            if right.SetText then right:SetText("") end
            if right.SetAlpha then right:SetAlpha(0) end
            changed = true
        end
    end

    return changed
end

-- Sequenceed attempts while the merchant UI is open; stops if merchant closes
local function HideNativeVendorPriceDelayed(tooltip)
    if not tooltip then return end

    if not MerchantFrame or not MerchantFrame:IsShown() then
        return
    end

    local delays = {0, 0.06, 0.18}
    for _, d in ipairs(delays) do
        C_Timer.After(d, function()
            if not tooltip then return end
            if not MerchantFrame or not MerchantFrame:IsShown() then return end

            local changed = removeNativeSellPriceSilently(tooltip)
            if changed and tooltip:IsShown() then
                tooltip:Show()
            end
        end)
    end
end

-- Hook once (keep AddVendorPrice as before)
GameTooltip:HookScript("OnTooltipSetItem", AddVendorPrice)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddVendorPrice)
GameTooltip:HookScript("OnTooltipSetItem", HideNativeVendorPriceDelayed)
ItemRefTooltip:HookScript("OnTooltipSetItem", HideNativeVendorPriceDelayed)