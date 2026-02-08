-- SimpleDungeonMaps - Localization file
local addonName, addon = ...
addon.L = {}

-- Current language (defaults to English)
addon.currentLanguage = "en"

local L = addon.L

-- German translations
L["de"] = {
    ["Simple Dungeon Maps"] = "Einfache Dungeonkarten",
    ["Dungeon Info"] = "Dungeon-Informationen",
    ["Level:"] = "Stufe:",
    ["Location:"] = "Ort:",
    ["Tips:"] = "Tipps:",
    ["Select an expansion and dungeon to view the map."] = "Wählen Sie eine Erweiterung und einen Dungeon aus, um die Karte anzuzeigen.",
    ["Classic"] = "Klassisch",
    ["Burning Crusade"] = "Brennender Kreuzzug",
    ["Select Dungeon"] = "Dungeon auswählen",
    ["Language"] = "Sprache",
    ["English"] = "Englisch",
    ["German"] = "Deutsch",
    ["Click to open dungeon maps"] = "Klicken, um Dungeonkarten zu öffnen",
    ["loaded! Type /sdm or /dungeonmaps to open"] = "geladen! Geben Sie /sdm oder /dungeonmaps zum Öffnen ein",
    ["Clear"] = "Löschen",
    ["Draw"] = "Zeichnen",
    ["Marker"] = "Markierung",
    ["Syncing drawings..."] = "Synchronisierung der Zeichnungen...",
    -- Colors
    ["Red"] = "Rot",
    ["Green"] = "Grün",
    ["Blue"] = "Blau",
    ["Gold"] = "Gold",
    ["White"] = "Weiß",
    ["Import/Export String"] = "Import/Export Zeichenkette",
    ["Close"] = "Schließen",
    ["Paste a string to import, or copy this one to share:"] = "Einfügen zum Importieren, oder Kopieren zum Teilen:",
    -- Raid Markers
    ["Skull"] = "Totenkopf",
    ["Cross"] = "Kreuz",
    ["Square"] = "Quadrat",
    ["Moon"] = "Mond",
    ["Triangle"] = "Dreieck",
    ["Diamond"] = "Diamant",
    ["Circle"] = "Kreis",
    ["Star"] = "Stern",
    -- Regions
    ["Eastern Kingdoms"] = "Östliche Königreiche",
    ["Kalimdor"] = "Kalimdor",
    ["Hellfire Citadel"] = "Höllenfeuerzitadelle",
    ["Coilfang Reservoir"] = "Eidechsenkessel",
    ["Auchindoun"] = "Auchindoun",
    ["Tempest Keep"] = "Festung der Stürme",
    ["Caverns of Time"] = "Höhlen der Zeit",
    ["Other Dungeons"] = "Andere Dungeons",
    ["Raids"] = "Schlachtzüge",
    ["Isle of Quel'Danas"] = "Insel von Quel'Danas",
}

-- English translations (default)
L["en"] = {
    ["Simple Dungeon Maps"] = "Simple Dungeon Maps",
    ["Dungeon Info"] = "Dungeon Info",
    ["Level:"] = "Level:",
    ["Location:"] = "Location:",
    ["Tips:"] = "Tips:",
    ["Select an expansion and dungeon to view the map."] = "Select an expansion and dungeon to view the map.",
    ["Classic"] = "Classic",
    ["Burning Crusade"] = "Burning Crusade",
    ["Select Dungeon"] = "Select Dungeon",
    ["Language"] = "Language",
    ["English"] = "English",
    ["German"] = "German",
    ["Click to open dungeon maps"] = "Click to open dungeon maps",
    ["loaded! Type /sdm or /dungeonmaps to open"] = "loaded! Type /sdm or /dungeonmaps to open",
    ["Clear"] = "Clear",
    ["Draw"] = "Draw",
    ["Marker"] = "Marker",
    ["Syncing drawings..."] = "Syncing drawings...",
    -- Colors
    ["Red"] = "Red",
    ["Green"] = "Green",
    ["Blue"] = "Blue",
    ["Gold"] = "Gold",
    ["White"] = "White",
    ["Import/Export String"] = "Import/Export String",
    ["Close"] = "Close",
    ["Paste a string to import, or copy this one to share:"] = "Paste a string to import, or copy this one to share:",
    -- Raid Markers
    ["Skull"] = "Skull",
    ["Cross"] = "Cross",
    ["Square"] = "Square",
    ["Moon"] = "Moon",
    ["Triangle"] = "Triangle",
    ["Diamond"] = "Diamond",
    ["Circle"] = "Circle",
    ["Star"] = "Star",
    -- Regions
    ["Eastern Kingdoms"] = "Eastern Kingdoms",
    ["Kalimdor"] = "Kalimdor",
    ["Hellfire Citadel"] = "Hellfire Citadel",
    ["Coilfang Reservoir"] = "Coilfang Reservoir",
    ["Auchindoun"] = "Auchindoun",
    ["Tempest Keep"] = "Tempest Keep",
    ["Caverns of Time"] = "Caverns of Time",
    ["Other Dungeons"] = "Other Dungeons",
    ["Raids"] = "Raids",
    ["Isle of Quel'Danas"] = "Isle of Quel'Danas",
}

-- Get text based on current language
function addon:GetText(key)
    local lang = addon.currentLanguage or "en"
    if L[lang] and L[lang][key] then
        return L[lang][key]
    end
    -- Fallback to English
    if L["en"] and L["en"][key] then
        return L["en"][key]
    end
    return key
end
