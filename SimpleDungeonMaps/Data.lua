-- SimpleDungeonMaps - Data file
-- Contains dungeon maps organized by region with localization support

local addonName, addon = ...

-- Helper function to get localized value
local function L(tbl)
    local lang = addon.currentLanguage or "en"
    return tbl[lang] or tbl["en"] or ""
end

-- Dungeon maps data
-- name, location, and tips are tables with 'en' and 'de' keys
addon.dungeonMaps = {
    -- ================================
    -- CLASSIC DUNGEONS
    -- ================================
    RagefireChasm = {
        name = { en = "Ragefire Chasm", de = "Flammenschlund" },
        levelRange = "13-18",
        location = { en = "Orgrimmar", de = "Orgrimmar" },
        region = "Kalimdor",
        tips = { 
            en = "Short dungeon, good for new players. Located beneath Orgrimmar's Cleft of Shadow.", 
            de = "Kurzer Dungeon, gut für neue Spieler. Befindet sich unter Orgrimmars Kluft der Schatten." 
        },
    },
    TheDeadminesA = {
        name = { en = "The Deadmines", de = "Die Todesminen" },
        levelRange = "17-26",
        location = { en = "Westfall", de = "Westfall" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Famous dungeon with Edwin VanCleef. Bring CC for the ship. Watch out for Mr. Smite's weapon switches!", 
            de = "Berühmter Dungeon mit Edwin VanCleef. Bringt CC für das Schiff mit. Achtet auf Mr. Peinigers Waffenwechsel!" 
        },
    },
    WailingCaverns = {
        name = { en = "Wailing Caverns", de = "Die Höhlen des Wehklagens" },
        levelRange = "17-24",
        location = { en = "The Barrens", de = "Brachland" },
        region = "Kalimdor",
        tips = { 
            en = "Long winding dungeon. Complete Druid of the Fang quest for good rewards. Escort Disciple of Naralex at the end.", 
            de = "Langer, gewundener Dungeon. Schließt die Quest 'Die Druiden des Giftzahns' für gute Belohnungen ab. Eskortiert am Ende den Jünger von Naralex." 
        },
    },
    BlackfathomDeeps = {
        name = { en = "Blackfathom Deeps", de = "Tiefschwarze Grotte" },
        levelRange = "20-30",
        location = { en = "Ashenvale", de = "Eschenwald" },
        region = "Kalimdor",
        tips = { 
            en = "Underwater sections. Jump puzzle event for Aku'mai. Best wand for early levels from quest.", 
            de = "Unterwasserabschnitte. Sprungrätsel-Event für Aku'mai. Bester Zauberstab für frühe Level aus Quest." 
        },
    },
    ShadowfangKeep = {
        name = { en = "Shadowfang Keep", de = "Burg Schattenfang" },
        levelRange = "22-30",
        location = { en = "Silverpine Forest", de = "Silberwald" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Great for Horde early leveling. Drops rare twink items. Arugal is on the top floor.", 
            de = "Großartig für das frühe Leveln der Horde. Lässt seltene Twink-Gegenstände fallen. Arugal befindet sich in der obersten Etage." 
        },
    },
    TheStockade = {
        name = { en = "The Stockade", de = "Das Verlies" },
        levelRange = "22-30",
        location = { en = "Stormwind City", de = "Sturmwind" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Alliance only. Quick dungeon run. Multiple quests available from Stormwind.", 
            de = "Nur für Allianz. Schneller Dungeon-Durchgang. Mehrere Quests in Sturmwind verfügbar." 
        },
    },
    Gnomeregan = {
        name = { en = "Gnomeregan", de = "Gnomeregan" },
        levelRange = "29-38",
        location = { en = "Dun Morogh", de = "Dun Morogh" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Long dungeon with many pulls. Use the backdoor for faster runs. Watch out for the Grubbis event.", 
            de = "Langer Dungeon mit vielen Gegnergruppen. Nutzt den Hintereingang für schnellere Durchgänge. Achtet auf das Grubbis-Event." 
        },
    },
    RazorfenKraul = {
        name = { en = "Razorfen Kraul", de = "Der Kral von Razorfen" },
        levelRange = "30-40",
        location = { en = "The Barrens", de = "Brachland" },
        region = "Kalimdor",
        tips = { 
            en = "Escort Willix the Importer for extra loot. Good leather drops for this level range.", 
            de = "Eskortiert Willix den Importeur für zusätzliche Beute. Gute Leder-Drops für diesen Stufenbereich." 
        },
    },
    ScarletMonastery = {
        name = { en = "Scarlet Monastery", de = "Das Scharlachrote Kloster" },
        levelRange = "26-45",
        location = { en = "Tirisfal Glades", de = "Iteris de Tirisfal" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Four wings: Graveyard (28-32), Library (32-36), Armory (36-40), Cathedral (38-45). Great gear upgrades!", 
            de = "Vier Flügel: Friedhof (28-32), Bibliothek (32-36), Waffenkammer (36-40), Kathedrale (38-45). Tolle Ausrüstungs-Upgrades!" 
        },
    },
    RazorfenDowns = {
        name = { en = "Razorfen Downs", de = "Die Hügel von Razorfen" },
        levelRange = "40-50",
        location = { en = "The Barrens", de = "Brachland" },
        region = "Kalimdor",
        tips = { 
            en = "Bring fire for the gong event. Amnennar drops a nice caster staff.", 
            de = "Bringt Feuer für das Gong-Event mit. Amnennar lässt einen schönen Zauberstab fallen." 
        },
    },
    Uldaman = {
        name = { en = "Uldaman", de = "Uldaman" },
        levelRange = "42-52",
        location = { en = "Badlands", de = "Ödland" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Long instance with archaeology theme. Staff of Prehistoria quest is worthwhile. Archaedas requires killing adds first.", 
            de = "Lange Instanz mit Archäologie-Thema. Die Quest 'Stab der Prähistorie' lohnt sich. Archaedas erfordert zuerst das Töten von Adds." 
        },
    },
    ZulFarrak = {
        name = { en = "Zul'Farrak", de = "Zul'Farrak" },
        levelRange = "44-54",
        location = { en = "Tanaris", de = "Tanaris" },
        region = "Kalimdor",
        tips = { 
            en = "Famous stairs event! Sul'thraze the Lasher is a popular sword. Divino-matic Rod quest here.", 
            de = "Berühmtes Treppen-Event! Sul'thraze der Peitscher ist ein beliebtes Schwert. Quest für die Divino-matik-Rute hier." 
        },
    },
    Maraudon = {
        name = { en = "Maraudon", de = "Maraudon" },
        levelRange = "46-55",
        location = { en = "Desolace", de = "Desolace" },
        region = "Kalimdor",
        tips = { 
            en = "Three wings: Purple, Orange, and Inner. Scepter quests unlock Princess runs. Great nature resist gear.", 
            de = "Drei Flügel: Lila, Orange und Inneres. Szepter-Quests schalten Prinzessinnen-Runs frei. Gute Naturresistenz-Ausrüstung." 
        },
    },
    TheSunkenTemple = {
        name = { en = "Sunken Temple", de = "Der Versunkene Tempel" },
        levelRange = "50-60",
        location = { en = "Swamp of Sorrows", de = "Sümpfe des Elends" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Confusing layout - follow the dragon statues. Class quests available. Kill mini-bosses before Jammal'an.", 
            de = "Verwirrendes Layout - folgt den Drachenstatuen. Klassenquests verfügbar. Tötet Mini-Bosse vor Jammal'an." 
        },
    },
    BlackrockDepths = {
        name = { en = "Blackrock Depths", de = "Schwarzfelstiefen" },
        levelRange = "52-60",
        location = { en = "Blackrock Mountain", de = "Der Schwarzfels" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Massive dungeon. Emperor run is endgame. Get Shadowforge Key for shortcuts. Bar has rare spawn Plugger.", 
            de = "Riesiger Dungeon. Imperator-Run ist Endgame. Holt euch den Schattenfuchsschlüssel für Abkürzungen. Die Bar hat den seltenen Spawn Plugger." 
        },
    },
    LowerBlackrockSpire = {
        name = { en = "Lower Blackrock Spire", de = "Untere Schwarzfelsspitze" },
        levelRange = "55-60",
        location = { en = "Blackrock Mountain", de = "Der Schwarzfels" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "10-man dungeon. UBRS key quest starts here. Good pre-raid gear. Beware of patrols!", 
            de = "10-Mann-Dungeon. Die UBRS-Schlüsselquest beginnt hier. Gute Pre-Raid-Ausrüstung. Vorsicht vor Patrouillen!" 
        },
    },
    CL_BlackrockSpireUpper = {
        name = { en = "Upper Blackrock Spire", de = "Obere Schwarzfelsspitze" },
        levelRange = "55-60",
        location = { en = "Blackrock Mountain", de = "Der Schwarzfels" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "10-man raid. Rend Blackhand and General Drakkisath. Get Onyxia key and UBRS key.", 
            de = "10-Mann-Raid. Rend Schwarzfaust und General Drakkisath. Holt euch den Onyxia-Schlüssel und den UBRS-Schlüssel." 
        },
    },
    DireMaulEast = {
        name = { en = "Dire Maul East", de = "Düsterbruch Ost" },
        levelRange = "55-60",
        location = { en = "Feralas", de = "Feralas" },
        region = "Kalimdor",
        tips = { 
            en = "Shortest DM wing. Pusillin chase for Crescent Key. Lethtendris drops nice caster gear.", 
            de = "Kürzester DB-Flügel. Pusillin-Jagd für den Mondsichelschlüssel. Lethtendris lässt gute Zauberer-Ausrüstung fallen." 
        },
    },
    DireMaulNorth = {
        name = { en = "Dire Maul North", de = "Düsterbruch Nord" },
        levelRange = "55-60",
        location = { en = "Feralas", de = "Feralas" },
        region = "Kalimdor",
        tips = { 
            en = "Tribute runs for extra loot! Don't kill bosses for maximum reward. King's tribute is valuable.", 
            de = "Tribut-Runs für zusätzliche Beute! Tötet keine Bosse für maximale Belohnung. Der Tribut des Königs ist wertvoll." 
        },
    },
    DireMaulWest = {
        name = { en = "Dire Maul West", de = "Düsterbruch West" },
        levelRange = "55-60",
        location = { en = "Feralas", de = "Feralas" },
        region = "Kalimdor",
        tips = { 
            en = "Hardest DM wing. Prince drops Quel'Serrar book for warriors. Need Crescent Key.", 
            de = "Schwerster DB-Flügel. Der Prinz lässt das Quel'Serrar-Buch für Krieger fallen. Mondsichelschlüssel erforderlich." 
        },
    },
    Scholomance = {
        name = { en = "Scholomance", de = "Scholomance" },
        levelRange = "58-60",
        location = { en = "Western Plaguelands", de = "Westliche Pestländer" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Pre-raid essential. Need Skeleton Key. Darkmaster Gandling teleports players randomly. Great caster loot.", 
            de = "Unerlässlich vor dem Raid. Skelettschlüssel erforderlich. Dunkelmeister Gandling teleportiert Spieler zufällig. Tolle Zauberer-Beute." 
        },
    },
    StratholmeCrusader = {
        name = { en = "Stratholme (Live)", de = "Stratholme (Lebend)" },
        levelRange = "58-60",
        location = { en = "Eastern Plaguelands", de = "Östliche Pestländer" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Two sides: Live (Crusaders) and Undead (Baron). 45-min Baron run for mount! Bring extra Stratholme Holy Water.", 
            de = "Zwei Seiten: Lebend (Kreuzzug) und Untot (Baron). 45-Minuten-Baron-Run für das Reittier! Bringt zusätzliches Heiliges Wasser von Stratholme mit." 
        },
    },
    StratholmeGauntlet = {
        name = { en = "Stratholme (Undead)", de = "Stratholme (Untot)" },
        levelRange = "58-60",
        location = { en = "Eastern Plaguelands", de = "Östliche Pestländer" },
        region = "Eastern Kingdoms",
        tips = { 
            en = "Undead side (Service Entrance). Baron Rivendare drops mount at low rate. Lots of abominations.", 
            de = "Untoten-Seite (Hintereingang). Baron Totenschwur lässt Reittier selten fallen. Viele Monstrositäten." 
        },
    },
    
    -- ================================
    -- CLASSIC RAIDS
    -- ================================
    MoltenCore = {
        name = { en = "Molten Core", de = "Geschmolzener Kern" },
        levelRange = "60 (Raid)",
        location = { en = "Blackrock Mountain", de = "Der Schwarzfels" },
        region = "Raids",
        tips = { 
            en = "40-man raid. Fire resist needed! Douse runes to summon Majordomo. Ragnaros is the Fire Lord.", 
            de = "40-Mann-Raid. Feuerwiderstand benötigt! Löscht Runen, um Majordomo zu beschwören. Ragnaros ist der Feuerlord." 
        },
    },
    BlackwingLair = {
        name = { en = "Blackwing Lair", de = "Pechschwingenhort" },
        levelRange = "60 (Raid)",
        location = { en = "Blackrock Mountain", de = "Der Schwarzfels" },
        region = "Raids",
        tips = { 
            en = "40-man raid. Need Onyxia Scale Cloak for Nefarian. Vaelastrasz is the guild breaker.", 
            de = "40-Mann-Raid. Benötigt Onyxiaschuppenumhang für Nefarian. Vaelastrasz ist der Gildenbrecher." 
        },
    },
    TheRuinsofAhnQiraj = {
        name = { en = "Ruins of Ahn'Qiraj (AQ20)", de = "Ruinen von Ahn'Qiraj (AQ20)" },
        levelRange = "60 (Raid)",
        location = { en = "Silithus", de = "Silithus" },
        region = "Raids",
        tips = { 
            en = "20-man raid. Skill books drop here. Ossirian the Unscarred requires kiting to crystals.", 
            de = "20-Mann-Raid. Fertigkeitsbücher droppen hier. Ossirian der Narbenlose muss zu Kristallen gekitet werden." 
        },
    },
    TheTempleofAhnQiraj = {
        name = { en = "Temple of Ahn'Qiraj (AQ40)", de = "Tempel von Ahn'Qiraj (AQ40)" },
        levelRange = "60 (Raid)",
        location = { en = "Silithus", de = "Silithus" },
        region = "Raids",
        tips = { 
            en = "40-man raid. C'Thun is an Old God. Twin Emperors require coordination. Mounts drop inside.", 
            de = "40-Mann-Raid. C'Thun ist ein Alter Gott. Zwillingsimperatoren erfordern Koordination. Reittiere droppen drinnen." 
        },
    },
    CL_ZulGurub = {
        name = { en = "Zul'Gurub", de = "Zul'Gurub" },
        levelRange = "60 (Raid)",
        location = { en = "Stranglethorn Vale", de = "Schlingendorntal" },
        region = "Raids",
        tips = { 
            en = "20-man raid. Tiger and Raptor mounts! Hakkar the Soulflayer is the end boss. Hex sticks needed.", 
            de = "20-Mann-Raid. Tiger- und Raptorreittiere! Hakkar der Seelenschinder ist der Endboss. Verhexungsstöcke benötigt." 
        },
    },
    CL_OnyxiasLair = {
        name = { en = "Onyxia's Lair", de = "Onyxias Hort" },
        levelRange = "60 (Raid)",
        location = { en = "Dustwallow Marsh", de = "Düstermarschen" },
        region = "Raids",
        tips = { 
            en = "40-man raid. Single boss. Watch the tail! Deep Breath kills everyone. Drops T2 helms.", 
            de = "40-Mann-Raid. Einzelboss. Achtet auf den Schwanz! Tiefer Atem tötet alle. Droppt T2-Helme." 
        },
    },
    CL_Naxxramas = {
        name = { en = "Naxxramas", de = "Naxxramas" },
        levelRange = "60 (Raid)",
        location = { en = "Eastern Plaguelands", de = "Östliche Pestländer" },
        region = "Raids",
        tips = { 
            en = "40-man raid. Hardest Classic content. 4 wings + Sapphiron/Kel'Thuzad. Tier 3 sets.", 
            de = "40-Mann-Raid. Schwerster Classic-Content. 4 Flügel + Sapphiron/Kel'Thuzad. Tier 3 Sets." 
        },
    },
    
    -- ================================
    -- BURNING CRUSADE DUNGEONS
    -- ================================
    HCHellfireRamparts = {
        name = { en = "Hellfire Ramparts", de = "Höllenfeuerbollwerk" },
        levelRange = "60-62",
        location = { en = "Hellfire Peninsula", de = "Höllenfeuerhalbinsel" },
        region = "Hellfire Citadel",
        tips = { 
            en = "First TBC dungeon. Fast clears. Watch dragon at the end - don't stand in fire!", 
            de = "Erster TBC-Dungeon. Schnelle Durchgänge. Achtet am Ende auf den Drachen - steht nicht im Feuer!" 
        },
    },
    HCBloodFurnace = {
        name = { en = "The Blood Furnace", de = "Der Blutkessel" },
        levelRange = "61-63",
        location = { en = "Hellfire Peninsula", de = "Höllenfeuerhalbinsel" },
        region = "Hellfire Citadel",
        tips = { 
            en = "Broggok event requires killing waves. Keli'dan does big AoE - run out when he channels!", 
            de = "Broggok-Event erfordert das Töten von Wellen. Keli'dan macht großen AoE - lauft raus, wenn er kanalisiert!" 
        },
    },
    HCTheShatteredHalls = {
        name = { en = "The Shattered Halls", de = "Die Zerschmetterten Hallen" },
        levelRange = "70",
        location = { en = "Hellfire Peninsula", de = "Höllenfeuerhalbinsel" },
        region = "Hellfire Citadel",
        tips = { 
            en = "Heroic requires Flamewrought Key. Timed run for extra chest. Lots of trash, bring CC!", 
            de = "Heroisch erfordert den geschmiedeten Schlüssel. Zeit-Run für zusätzliche Truhe. Viel Trash, bringt CC mit!" 
        },
    },
    CFRTheSlavePens = {
        name = { en = "The Slave Pens", de = "Die Sklavenunterkünfte" },
        levelRange = "62-64",
        location = { en = "Zangarmarsh", de = "Zangarmarschen" },
        region = "Coilfang Reservoir",
        tips = { 
            en = "Quagmirran is nature damage heavy. Good for leveling. Relatively short instance.", 
            de = "Quagmirran ist sehr naturveranlagt. Gut zum Leveln. Relativ kurze Instanz." 
        },
    },
    CFRTheUnderbog = {
        name = { en = "The Underbog", de = "Der Tiefensumpf" },
        levelRange = "63-65",
        location = { en = "Zangarmarsh", de = "Zangarmarschen" },
        region = "Coilfang Reservoir",
        tips = { 
            en = "Black Stalker does levitate - stay grouped. Sanguine Hibiscus for Sporeggar rep.", 
            de = "Der Schwarze Pirschner macht Levitation - bleibt zusammen. Blutrote Hibiskus für Sporeggar-Ruf." 
        },
    },
    CFRTheSteamvault = {
        name = { en = "The Steamvault", de = "Die Dampfkammer" },
        levelRange = "70",
        location = { en = "Zangarmarsh", de = "Zangarmarschen" },
        region = "Coilfang Reservoir",
        tips = { 
            en = "Requires Reservoir Key for heroic. Kalithresh destroys tanks - control adds. Coilfang Armaments for rep.", 
            de = "Erfordert den Behälterschlüssel für Heroisch. Kalithresh vernichtet Tanks - kontrolliert die Adds. Coilfang-Rüstungsteile für Ruf." 
        },
    },
    AuchManaTombs = {
        name = { en = "Mana-Tombs", de = "Managruft" },
        levelRange = "64-66",
        location = { en = "Terokkar Forest", de = "Wälder von Terokkar" },
        region = "Auchindoun",
        tips = { 
            en = "Ethereal themed. Shaffar has adds - focus them down. Watch out for mana burn mobs.", 
            de = "Ätherisches Thema. Shaffar hat Adds - fokussiert sie. Achtet auf Mobs mit Manabrand." 
        },
    },
    AuchAuchenaiCrypts = {
        name = { en = "Auchenai Crypts", de = "Auchenai-Krypta" },
        levelRange = "65-67",
        location = { en = "Terokkar Forest", de = "Wälder von Terokkar" },
        region = "Auchindoun",
        tips = { 
            en = "Undead heavy - bring holy damage. Maladaar summons Avatar of the Martyred.", 
            de = "Untoten-lastig - bringt Heiligschaden mit. Maladaar beschwört den Avatar des Gemarterten." 
        },
    },
    AuchSethekkHalls = {
        name = { en = "Sethekk Halls", de = "Sethekkhallen" },
        levelRange = "67-69",
        location = { en = "Terokkar Forest", de = "Wälder von Terokkar" },
        region = "Auchindoun",
        tips = { 
            en = "Arakkoa themed. Ikiss does Arcane Explosion - hide behind pillars! Swift Flight Form quest here.", 
            de = "Arakkoa-Thema. Ikiss macht Arkane Explosion - versteckt euch hinter Säulen! Quest für die schnelle Fluggestalt hier." 
        },
    },
    AuchShadowLabyrinth = {
        name = { en = "Shadow Labyrinth", de = "Schattenlabyrinth" },
        levelRange = "70",
        location = { en = "Terokkar Forest", de = "Wälder von Terokkar" },
        region = "Auchindoun",
        tips = { 
            en = "Hardest Auchindoun dungeon. Murmur is unique - don't stand close! Requires Auchenai Key for heroic.", 
            de = "Schwerster Auchindoun-Dungeon. Murmur ist einzigartig - steht nicht zu nah! Erfordert den Auchenaischlüssel für Heroisch." 
        },
    },
    TempestKeepMechanar = {
        name = { en = "The Mechanar", de = "Die Mechanar" },
        levelRange = "69-70",
        location = { en = "Netherstorm", de = "Nethersturm" },
        region = "Tempest Keep",
        tips = { 
            en = "Shortest TK dungeon. Pathaleon has adds. Good badge farming in heroic.", 
            de = "Kürzester FdS-Dungeon. Pathaleon hat Adds. Gutes Sammeln von Abzeichen auf Heroisch." 
        },
    },
    TempestKeepBotanica = {
        name = { en = "The Botanica", de = "Die Botanica" },
        levelRange = "70",
        location = { en = "Netherstorm", de = "Nethersturm" },
        region = "Tempest Keep",
        tips = { 
            en = "Plant themed. Warp Splinter heals from treants - kill them fast! Primal Life farm spot.", 
            de = "Pflanzen-Thema. Verzerrerheiler heilt durch Treants - tötet sie schnell! Farmplatz für Urleben." 
        },
    },
    TempestKeepArcatraz = {
        name = { en = "The Arcatraz", de = "Die Arcatraz" },
        levelRange = "70",
        location = { en = "Netherstorm", de = "Nethersturm" },
        region = "Tempest Keep",
        tips = { 
            en = "Prison themed. Skyriss splits into 3 copies. Key from Mechanar/Botanica or flying.", 
            de = "Gefängnis-Thema. Skyriss teilt sich in 3 Kopien. Schlüssel von Mechanar/Botanica oder Fliegen." 
        },
    },
    CoTOldHillsbrad = {
        name = { en = "Old Hillsbrad Foothills", de = "Vorgebirge des Alten Hügellands" },
        levelRange = "66-68",
        location = { en = "Tanaris", de = "Tanaris" },
        region = "Caverns of Time",
        tips = { 
            en = "Help Thrall escape! Plant bombs in Durnholde. Don't let Thrall die during escort.", 
            de = "Helft Thrall bei der Flucht! Platziert Bomben in Durnholde. Lasst Thrall während des Eskorts nicht sterben." 
        },
    },
    CoTBlackMorass = {
        name = { en = "The Black Morass", de = "Der Schwarze Morast" },
        levelRange = "70",
        location = { en = "Tanaris", de = "Tanaris" },
        region = "Caverns of Time",
        tips = { 
            en = "Protect Medivh! Waves of portals. Use Chrono-beacons wisely. Attunement for Karazhan.", 
            de = "Beschützt Medivh! Wellen von Portalen. Benutzt Chrono-Leuchtfeuer weise. Vorquest für Karazhan." 
        },
    },
    MagistersTerrace = {
        name = { en = "Magisters' Terrace", de = "Terrasse der Magister" },
        levelRange = "70",
        location = { en = "Isle of Quel'Danas", de = "Insel von Quel'Danas" },
        region = "Isle of Quel'Danas",
        tips = { 
            en = "Sunwell patch dungeon. Kael'thas returns! Delrissa party varies. Phoenix mount drops from Kael!", 
            de = "Sonnenbrunnen-Patch-Dungeon. Kael'thas kehrt zurück! Delrissa-Gruppe variiert. Phönix-Reittier droppt von Kael!" 
        },
    },
    KarazhanStart = {
        name = { en = "Karazhan", de = "Karazhan" },
        levelRange = "70 (Raid)",
        location = { en = "Deadwind Pass", de = "Gebirgspass der Totenwinde" },
        region = "Raids",
        tips = { 
            en = "10-man raid tower. Many optional bosses. Chess event is unique. Prince is final boss. Attunement required!", 
            de = "10-Mann-Raid-Turm. Viele optionale Bosse. Schach-Event ist einzigartig. Der Prinz ist der Endboss. Vorquest erforderlich!" 
        },
    },
    KarazhanEnd = {
        name = { en = "Karazhan (Top)", de = "Karazhan (Oben)" },
        levelRange = "70 (Raid)",
        location = { en = "Deadwind Pass", de = "Gebirgspass der Totenwinde" },
        region = "Raids",
        tips = { 
            en = "Includes Chess Event, Netherspite, and Prince Malchezaar.", 
            de = "Beinhaltet Schach-Event, Netherspite und Prinz Malchezaar." 
        },
    },
    GruulsLair = {
        name = { en = "Gruul's Lair", de = "Gruuls Unterschlupf" },
        levelRange = "70 (Raid)",
        location = { en = "Blade's Edge Mountains", de = "Schergrat" },
        region = "Raids",
        tips = { 
            en = "25-man raid. Two bosses only. High King is a council fight. Gruul does growing shatter damage.", 
            de = "25-Mann-Raid. Nur zwei Bosse. Hochkönig ist ein Ratskampf. Gruul macht wachsenden Zerschmettern-Schaden." 
        },
    },
    HCMagtheridonsLair = {
        name = { en = "Magtheridon's Lair", de = "Magtheridons Kammer" },
        levelRange = "70 (Raid)",
        location = { en = "Hellfire Peninsula", de = "Höllenfeuerhalbinsel" },
        region = "Raids",
        tips = { 
            en = "25-man single boss. Click cubes to interrupt! Coordination is key. Tank gear drops.", 
            de = "25-Mann Einzelboss. Klickt auf Würfel zum Unterbrechen! Koordination ist der Schlüssel. Tank-Ausrüstung droppt." 
        },
    },
    ZulAman = {
        name = { en = "Zul'Aman", de = "Zul'Aman" },
        levelRange = "70 (Raid)",
        location = { en = "Ghostlands", de = "Geisterlande" },
        region = "Raids",
        tips = { 
            en = "10-man timed raid. Save hostages for extra loot. War Bear mount possible! Animal bosses.", 
            de = "10-Mann Zeit-Raid. Rettet Geiseln für zusätzliche Beute. Kriegsbär-Reittier möglich! Tier-Bosse." 
        },
    },
    CFRSerpentshrineCavern = {
        name = { en = "Serpentshrine Cavern", de = "Höhle des Schlangenschreins" },
        levelRange = "70 (Raid)",
        location = { en = "Zangarmarsh", de = "Zangarmarschen" },
        region = "Raids",
        tips = { 
            en = "25-man raid. Lady Vashj is end boss. Elevator boss is deadly! T5 gear tokens.", 
            de = "25-Mann-Raid. Lady Vashj ist Endboss. Aufzugboss ist tödlich! T5-Ausrüstungstokens." 
        },
    },
    TempestKeepTheEye = {
        name = { en = "The Eye (Tempest Keep)", de = "Das Auge (Festung der Stürme)" },
        levelRange = "70 (Raid)",
        location = { en = "Netherstorm", de = "Nethersturm" },
        region = "Raids",
        tips = { 
            en = "25-man raid. Kael'thas drops Ashes of Al'ar. Legendary weapons during Kael fight.", 
            de = "25-Mann-Raid. Kael'thas droppt Al'ars Asche. Legendäre Waffen während des Kael-Kampfes." 
        },
    },
    CoTHyjal = {
        name = { en = "Hyjal Summit", de = "Hyjalgipfel" },
        levelRange = "70 (Raid)",
        location = { en = "Caverns of Time", de = "Höhlen der Zeit" },
        region = "Raids",
        tips = { 
            en = "25-man raid. Wave defense. Archimonde is end boss - ensure you have tears/parachutes!", 
            de = "25-Mann-Raid. Wellenverteidigung. Archimonde ist Endboss - stellt sicher, dass ihr Tränen/Fallschirme habt!" 
        },
    },
    BlackTempleStart = {
        name = { en = "Black Temple (Ground)", de = "Schwarzer Tempel (Boden)" },
        levelRange = "70 (Raid)",
        location = { en = "Shadowmoon Valley", de = "Schattenmondtal" },
        region = "Raids",
        tips = { 
            en = "25-man raid. Illidan is waiting. First map checks specifically for entrance/sewers area.", 
            de = "25-Mann-Raid. Illidan wartet. Erste Karte prüft speziell den Eingangs-/Kanalbereich." 
        },
    },
    BlackTempleBasement = {
        name = { en = "Black Temple (Basement)", de = "Schwarzer Tempel (Keller)" },
        levelRange = "70 (Raid)",
        location = { en = "Shadowmoon Valley", de = "Schattenmondtal" },
        region = "Raids",
        tips = { 
            en = "Includes Supremus and Shade of Akama areas.", 
            de = "Beinhaltet Supremus- und Akamas Schemen-Bereiche." 
        },
    },
    BlackTempleTop = {
        name = { en = "Black Temple (Top)", de = "Schwarzer Tempel (Oben)" },
        levelRange = "70 (Raid)",
        location = { en = "Shadowmoon Valley", de = "Schattenmondtal" },
        region = "Raids",
        tips = { 
            en = "Upper levels. Illidari Council and Illidan Stormrage.", 
            de = "Obere Ebenen. Rat der Illidari und Illidan Sturmgrimm." 
        },
    },
    SunwellPlateau = {
        name = { en = "Sunwell Plateau", de = "Sonnenbrunnenplateau" },
        levelRange = "70 (Raid)",
        location = { en = "Isle of Quel'Danas", de = "Insel von Quel'Danas" },
        region = "Raids",
        tips = { 
            en = "Hardest TBC raid. Kil'jaeden emerges from the Sunwell. Top tier loot.", 
            de = "Schwerster TBC-Raid. Kil'jaeden entsteigt dem Sonnenbrunnen. Beste Beute." 
        },
    },
}

-- Dungeons by expansion and region for dropdown population
-- Regions are keys in Locales.lua
addon.dungeonsByExpansion = {
    classic = {
        -- Eastern Kingdoms
        { isHeader = true, name = "Eastern Kingdoms" },
        { mapKey = "TheDeadminesA" },
        { mapKey = "ShadowfangKeep" },
        { mapKey = "TheStockade" },
        { mapKey = "Gnomeregan" },
        { mapKey = "ScarletMonastery" },
        { mapKey = "Uldaman" },
        { mapKey = "TheSunkenTemple" },
        { mapKey = "BlackrockDepths" },
        { mapKey = "LowerBlackrockSpire" },
        { mapKey = "CL_BlackrockSpireUpper" },
        { mapKey = "Scholomance" },
        { mapKey = "StratholmeCrusader" },
        { mapKey = "StratholmeGauntlet" },
        -- Kalimdor
        { isHeader = true, name = "Kalimdor" },
        { mapKey = "RagefireChasm" },
        { mapKey = "WailingCaverns" },
        { mapKey = "BlackfathomDeeps" },
        { mapKey = "RazorfenKraul" },
        { mapKey = "RazorfenDowns" },
        { mapKey = "ZulFarrak" },
        { mapKey = "Maraudon" },
        { mapKey = "DireMaulEast" },
        { mapKey = "DireMaulNorth" },
        { mapKey = "DireMaulWest" },
        -- Raids
        { isHeader = true, name = "Raids" },
        { mapKey = "MoltenCore" },
        { mapKey = "BlackwingLair" },
        { mapKey = "TheRuinsofAhnQiraj" },
        { mapKey = "TheTempleofAhnQiraj" },
        { mapKey = "CL_ZulGurub" },
        { mapKey = "CL_OnyxiasLair" },
        { mapKey = "CL_Naxxramas" },
    },
    tbc = {
        -- Hellfire Citadel
        { isHeader = true, name = "Hellfire Citadel" },
        { mapKey = "HCHellfireRamparts" },
        { mapKey = "HCBloodFurnace" },
        { mapKey = "HCTheShatteredHalls" },
        -- Coilfang Reservoir
        { isHeader = true, name = "Coilfang Reservoir" },
        { mapKey = "CFRTheSlavePens" },
        { mapKey = "CFRTheUnderbog" },
        { mapKey = "CFRTheSteamvault" },
        -- Auchindoun
        { isHeader = true, name = "Auchindoun" },
        { mapKey = "AuchManaTombs" },
        { mapKey = "AuchAuchenaiCrypts" },
        { mapKey = "AuchSethekkHalls" },
        { mapKey = "AuchShadowLabyrinth" },
        -- Tempest Keep
        { isHeader = true, name = "Tempest Keep" },
        { mapKey = "TempestKeepMechanar" },
        { mapKey = "TempestKeepBotanica" },
        { mapKey = "TempestKeepArcatraz" },
        -- Caverns of Time
        { isHeader = true, name = "Caverns of Time" },
        { mapKey = "CoTOldHillsbrad" },
        { mapKey = "CoTBlackMorass" },
        -- Other
        { isHeader = true, name = "Other Dungeons" },
        { mapKey = "MagistersTerrace" },
        -- Raids
        { isHeader = true, name = "Raids" },
        { mapKey = "KarazhanStart" },
        { mapKey = "KarazhanEnd" },
        { mapKey = "GruulsLair" },
        { mapKey = "HCMagtheridonsLair" },
        { mapKey = "ZulAman" },
        { mapKey = "CFRSerpentshrineCavern" },
        { mapKey = "TempestKeepTheEye" },
        { mapKey = "CoTHyjal" },
        { mapKey = "BlackTempleStart" },
        { mapKey = "BlackTempleBasement" },
        { mapKey = "BlackTempleTop" },
        { mapKey = "SunwellPlateau" },
    },
}

