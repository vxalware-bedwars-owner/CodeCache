local Version = "1.6.61"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "CodeCache V3",
    Icon = "moon-star",
    Author = "Unreleased",
    Folder = "CCV3",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = false,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("user check")
        end,
    },
})

Window:SetToggleKey(Enum.KeyCode.K)
Window:SetIconSize(26)
Window:EditOpenButton({
    Title = "Open CodeCache",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FFFFFF"), 
        Color3.fromHex("FFFFFF")
    ),
    OnlyMobile = true,
    Enabled = true,
    Draggable = true,
})

-- safeWriteConfig API
local HttpService = game:GetService("HttpService")
local folderName = "Vxalware"
local configFilePath = folderName .. "/VXConfig.json"

local hasFileApi = (type(isfolder) == "function")
               and (type(makefolder) == "function")
               and (type(isfile) == "function")
               and (type(readfile) == "function")
               and (type(writefile) == "function")

local config = {
    dropdown = {},
    toggle = {},
    slider = {},
}

local function safeWriteConfig()
    if not hasFileApi then return false end
    local ok, err = pcall(function()
        writefile(configFilePath, HttpService:JSONEncode(config))
    end)
    return ok
end

local function loadConfig()
    if not hasFileApi then return end
    if not isfolder(folderName) then
        pcall(makefolder, folderName)
    end
    if isfile(configFilePath) then
        local ok, data = pcall(readfile, configFilePath)
        if ok and data then
            local succ, decoded = pcall(HttpService.JSONDecode, HttpService, data)
            if succ and type(decoded) == "table" then
                -- keep defaults
                config.dropdown = decoded.dropdown or config.dropdown
                config.toggle = decoded.toggle or config.toggle
                config.slider = decoded.slider or config.slider
            end
        end
    else
        safeWriteConfig()
    end
end

loadConfig()

if not hasFileApi then
    WindUI:Notify({
        Title = "Config Disabled",
        Content = "API Unreachable — config will not be saved.",
        Duration = 5,
        Icon = "x",
    })
end

-- runWithNotify API
local _runWithNotify_firstRun = {}
local function runWithNotify(title, fn, opts)
    -- API Directions:
    -- kind = "dropdown", "toggle", or "slider"
    -- getLabel = function() -> string  (for dropdowns)
    -- getState = function() -> boolean (for toggles)
    -- getValue = function() -> value (for sliders)
    -- suppressNone = true/false (for dropdowns)
    opts = opts or {}
    local kind = opts.kind
    local getLabel = opts.getLabel
    local getState = opts.getState
    local getValue = opts.getValue
    local suppressNone = opts.suppressNone

    -- Silent run | Error run
    if not _runWithNotify_firstRun[title] then
        _runWithNotify_firstRun[title] = true

        if kind == "dropdown" or kind == "toggle" then
            local ok, err = pcall(fn)
            if not ok then
                WindUI:Notify({
                    Title = "Error",
                    Content = "Failed to run "..tostring(title).."\n"..tostring(err),
                    Duration = 5,
                    Icon = "x",
                })
            end
            return
        end
    end

    -- Normal run | Error run
    local ok, err = pcall(fn)
    if not ok then
        WindUI:Notify({
            Title = "Error",
            Content = "Failed to run "..tostring(title).."\n"..tostring(err),
            Duration = 5,
            Icon = "x",
        })
        return
    end

    -- Success run | Dropdown
    if kind == "dropdown" and type(getLabel) == "function" then
        local label = getLabel()
        if suppressNone and tostring(label) == "None" then
            return
        end
        WindUI:Notify({
            Title = "Success",
            Content = "Successfully executed "..tostring(label),
            Duration = 1.5,
        })
        return
    end

    -- Success run | Toggle
    if kind == "toggle" and type(getState) == "function" then
        local state = getState()
        if state then
            WindUI:Notify({
                Title = "Success",
                Content = "Successfully executed "..tostring(title),
                Duration = 1.5,
            })
        else
            WindUI:Notify({
                Title = "Success",
                Content = "Successfully unexecuted "..tostring(title),
                Duration = 1.5,
            })
        end
        return
    end

    -- Success run | Slider
    if kind == "slider" and type(getValue) == "function" then
        local value = getValue()
        local valueStr = tostring(value)
        if type(value) == "number" then
            valueStr = tostring(tonumber(string.format("%.6f", value))):gsub("%.?0+$", "")
        end
        WindUI:Notify({
            Title = "Success",
            Content = tostring(title) .. " set to " .. valueStr,
            Duration = 1.5,
        })
        return
    end

    -- Success run | Universal
    WindUI:Notify({
        Title = "Success",
        Content = "Successfully ran "..tostring(title),
        Duration = 1.5,
    })
end

-- Universal
local UniverTab = Window:Tab({ Title = "Universal", Icon = "earth" })
local Button = UniverTab:Button({
    Title = "Universal",
    Callback = function()
        runWithNotify("Universal Button", function()
            print("Universal")
        end)
    end
})

Window:Divider() -- Divider | Fisch
local FischTab = Window:Tab({ Title = "Fisch", Icon = "fish-symbol" })
local Button = FischTab:Button({
    Title = "Fisch",
    Callback = function()
        runWithNotify("Fisch Button", function()
            print("Fisch")
        end)
    end
})

-- +1 Speed per RNG
local SPRNGTab = Window:Tab({ Title = "+1 SPRNG", Icon = "dices" })
local Button = SPRNGTab:Button({
    Title = "+1 SPRNG",
    Callback = function()
        runWithNotify("+1 SPRNG Button", function()
            print("+1 SPRNG")
        end)
    end
})

-- TSB
local TSBTab = Window:Tab({ Title = "TSB", Icon = "hand-fist" })
local Button = TSBTab:Button({
    Title = "TSB",
    Callback = function()
        runWithNotify("TSB Button", function()
            print("TSB")
        end)
    end
})

-- Rivals
local RivalsTab = Window:Tab({ Title = "Rivals", Icon = "flame" })
local Button = RivalsTab:Button({
    Title = "Rivals",
    Callback = function()
        runWithNotify("Rivals Button", function()
            print("Rivals")
        end)
    end
})

-- Bedwars
local BedwarsTab = Window:Tab({ Title = "Bedwars", Icon = "bed" })
local Button = BedwarsTab:Button({
    Title = "Bedwars",
    Callback = function()
        runWithNotify("Bedwars Button", function()
            print("Bedwars")
        end)
    end
})

-- SAB
local SABTab = Window:Tab({ Title = "SAB", Icon = "worm" })
local Button = SABTab:Button({
    Title = "SAB",
    Callback = function()
        runWithNotify("SAB Button", function()
            print("SAB")
        end)
    end
})

-- GAG
local GAGTab = Window:Tab({ Title = "GAG", Icon = "leaf" })
local Button = GAGTab:Button({
    Title = "GAG",
    Callback = function()
        runWithNotify("GAG Button", function()
            print("GAG")
        end)
    end
})

-- Forsaken
local ForsakenTab = Window:Tab({ Title = "Forsaken", Icon = "person-standing" })
local Button = ForsakenTab:Button({
    Title = "Forsaken",
    Callback = function()
        runWithNotify("Forsaken Button", function()
            print("Forsaken")
        end)
    end
})

-- Hunty Zombie
local HuntyZombieTab = Window:Tab({ Title = "Hunty Zombie", Icon = "hand-helping" })
local Button = HuntyZombieTab:Button({
    Title = "Hunty Zombie",
    Callback = function()
        runWithNotify("Hunty Zombie Button", function()
            print("Hunty Zombie")
        end)
    end
})

-- 99 NITF
local NITFTab = Window:Tab({ Title = "99 NITF", Icon = "hand-fist" })
local Button = NITFTab:Button({
    Title = "99 NITF",
    Callback = function()
        runWithNotify("99 NITF Button", function()
            print("99 NITF")
        end)
    end
})

-- Saber Shwdwn
local SaberShwdwnTab = Window:Tab({ Title = "Saber Shwdwn", Icon = "hand-fist" })
local Button = SaberShwdwnTab:Button({
    Title = "Saber Shwdwn",
    Callback = function()
        runWithNotify("Saber Shwdwn Button", function()
            print("Saber Shwdwn")
        end)
    end
})

-- Blox Fruits
local BloxFruitsTab = Window:Tab({ Title = "Blox Fruits", Icon = "hand-fist" })
local Button = BloxFruitsTab:Button({
    Title = "Blox Fruits",
    Callback = function()
        runWithNotify("Blox Fruits Button", function()
            print("Blox Fruits")
        end)
    end
})

-- Demon Fall
local DemonFallTab = Window:Tab({ Title = "Demon Fall", Icon = "hand-fist" })
local Button = DemonFallTab:Button({
    Title = "Demon Fall",
    Callback = function()
        runWithNotify("Demon Fall Button", function()
            print("Demon Fall")
        end)
    end
})

-- Bee Swarm
local BeeSwarmTab = Window:Tab({ Title = "Bee Swarm", Icon = "hand-fist" })
local Button = BeeSwarmTab:Button({
    Title = "Bee Swarm",
    Callback = function()
        runWithNotify("Bee Swarm Button", function()
            print("Bee Swarm")
        end)
    end
})

-- Counter Blox
local CounterBloxTab = Window:Tab({ Title = "Counter Blox", Icon = "hand-fist" })
local Button = CounterBloxTab:Button({
    Title = "Counter Blox",
    Callback = function()
        runWithNotify("Counter Blox Button", function()
            print("Counter Blox")
        end)
    end
})

-- Blade Ball
local BladeBallTab = Window:Tab({ Title = "Blade Ball", Icon = "hand-fist" })
local Button = BladeBallTab:Button({
    Title = "Blade Ball",
    Callback = function()
        runWithNotify("Blade Ball Button", function()
            print("Blade Ball")
        end)
    end
})

-- Car Crshrs 2
local CarCrshrs2Tab = Window:Tab({ Title = "Car Crshrs 2", Icon = "hand-fist" })
local Button = CarCrshrs2Tab:Button({
    Title = "Car Crshrs 2",
    Callback = function()
        runWithNotify("Car Crshrs 2 Button", function()
            print("Car Crshrs 2")
        end)
    end
})

-- Peta X2
local PetaX2Tab = Window:Tab({ Title = "Peta X2", Icon = "hand-fist" })
local Button = PetaX2Tab:Button({
    Title = "Peta X2",
    Callback = function()
        runWithNotify("Peta X2 Button", function()
            print("Peta X2")
        end)
    end
})

-- Death Ball
local DeathBallTab = Window:Tab({ Title = "Death Ball", Icon = "hand-fist" })
local Button = DeathBallTab:Button({
    Title = "Death Ball",
    Callback = function()
        runWithNotify("Death Ball Button", function()
            print("Death Ball")
        end)
    end
})

-- Slap Battles
local SlapBattlesTab = Window:Tab({ Title = "Slap Battles", Icon = "hand-fist" })
local Button = SlapBattlesTab:Button({
    Title = "Slap Battles",
    Callback = function()
        runWithNotify("Slap Battles Button", function()
            print("Slap Battles")
        end)
    end
})

-- Cmbt Wrriors
local CmbtWrriorsTab = Window:Tab({ Title = "Cmbt Wrriors", Icon = "hand-fist" })
local Button = CmbtWrriorsTab:Button({
    Title = "Cmbt Wrriors",
    Callback = function()
        runWithNotify("Cmbt Wrriors Button", function()
            print("Cmbt Wrriors")
        end)
    end
})

-- Hypershot
local HypershotTab = Window:Tab({ Title = "Hypershot", Icon = "" })
local Button = HypershotTab:Button({
    Title = "Hypershot",
    Callback = function()
        runWithNotify("Hypershot Button", function()
            print("Hypershot")
        end)
    end
})

-- Tsunami Game
local TsunamiTab = Window:Tab({ Title = "Tsunami Game", Icon = "" })
local Button = TsunamiTab:Button({
    Title = "Tsunami Game",
    Callback = function()
        runWithNotify("Tsunami Game Button", function()
            print("Tsunami Game")
        end)
    end
})

-- Islands
local IslandsTab = Window:Tab({ Title = "Islands", Icon = "" })
local Button = IslandsTab:Button({
    Title = "Islands",
    Callback = function()
        runWithNotify("Islands Button", function()
            print("Islands")
        end)
    end
})

-- FTAP
local FTAPTab = Window:Tab({ Title = "FTAP", Icon = "" })
local Button = FTAPTab:Button({
    Title = "FTAP",
    Callback = function()
        runWithNotify("FTAP Button", function()
            print("FTAP")
        end)
    end
})

-- Beaks
local BeaksTab = Window:Tab({ Title = "Beaks", Icon = "" })
local Button = BeaksTab:Button({
    Title = "Beaks",
    Callback = function()
        runWithNotify("Beaks Button", function()
            print("Beaks")
        end)
    end
})

-- Dead Rails
local DeadRailsTab = Window:Tab({ Title = "Dead Rails", Icon = "" })
local Button = DeadRailsTab:Button({
    Title = "Dead Rails",
    Callback = function()
        runWithNotify("Dead Rails Button", function()
            print("Dead Rails")
        end)
    end
})

-- BABFT
local BABFTTab = Window:Tab({ Title = "BABFT", Icon = "" })
local Button = BABFTTab:Button({
    Title = "BABFT",
    Callback = function()
        runWithNotify("BABFT Button", function()
            print("BABFT")
        end)
    end
})

-- Ink Game
local InkGameTab = Window:Tab({ Title = "Ink Game", Icon = "" })
local Button = InkGameTab:Button({
    Title = "Ink Game",
    Callback = function()
        runWithNotify("Ink Game Button", function()
            print("Ink Game")
        end)
    end
})

-- Arsenal
local ArsenalTab = Window:Tab({ Title = "Arsenal", Icon = "" })
local Button = ArsenalTab:Button({
    Title = "Arsenal",
    Callback = function()
        runWithNotify("Arsenal Button", function()
            print("Arsenal")
        end)
    end
})

-- Mr vs Sh
local MrVsShTab = Window:Tab({ Title = "Mr vs Sh", Icon = "" })
local Button = MrVsShTab:Button({
    Title = "Mr vs Sh",
    Callback = function()
        runWithNotify("Mr vs Sh Button", function()
            print("Mr vs Sh")
        end)
    end
})

-- Ninja Leg.
local NinjaLegTab = Window:Tab({ Title = "Ninja Leg.", Icon = "" })
local Button = NinjaLegTab:Button({
    Title = "Ninja Leg.",
    Callback = function()
        runWithNotify("Ninja Leg. Button", function()
            print("Ninja Leg.")
        end)
    end
})

-- Muscle Leg.
local MuscleLegTab = Window:Tab({ Title = "Muscle Leg.", Icon = "" })
local Button = MuscleLegTab:Button({
    Title = "Muscle Leg.",
    Callback = function()
        runWithNotify("Muscle Leg. Button", function()
            print("Muscle Leg.")
        end)
    end
})

-- Leg. f Speed
local LegFSpeedTab = Window:Tab({ Title = "Leg. f Speed", Icon = "" })
local Button = LegFSpeedTab:Button({
    Title = "Leg. f Speed",
    Callback = function()
        runWithNotify("Leg. f Speed Button", function()
            print("Leg. f Speed")
        end)
    end
})

-- Zombie Attck
local ZombieAttckTab = Window:Tab({ Title = "Zombie Attck", Icon = "" })
local Button = ZombieAttckTab:Button({
    Title = "Zombie Attck",
    Callback = function()
        runWithNotify("Zombie Attck Button", function()
            print("Zombie Attck")
        end)
    end
})

-- King Legacy
local KingLegacyTab = Window:Tab({ Title = "King Legacy", Icon = "" })
local Button = KingLegacyTab:Button({
    Title = "King Legacy",
    Callback = function()
        runWithNotify("King Legacy Button", function()
            print("King Legacy")
        end)
    end
})

-- Fantom 4rces
local Fantom4rcesTab = Window:Tab({ Title = "Fantom 4rces", Icon = "" })
local Button = Fantom4rcesTab:Button({
    Title = "Fantom 4rces",
    Callback = function()
        runWithNotify("Fantom 4rces Button", function()
            print("Fantom 4rces")
        end)
    end
})

-- Da Strike
local DaStrikeTab = Window:Tab({ Title = "Da Strike", Icon = "" })
local Button = DaStrikeTab:Button({
    Title = "Da Strike",
    Callback = function()
        runWithNotify("Da Strike Button", function()
            print("Da Strike")
        end)
    end
})

-- Adopt Me
local AdoptMeTab = Window:Tab({ Title = "Adopt Me", Icon = "" })
local Button = AdoptMeTab:Button({
    Title = "Adopt Me",
    Callback = function()
        runWithNotify("Adopt Me Button", function()
            print("Adopt Me")
        end)
    end
})

-- Sol's Rng
local SolsRngTab = Window:Tab({ Title = "Sol's Rng", Icon = "" })
local Button = SolsRngTab:Button({
    Title = "Sol's Rng",
    Callback = function()
        runWithNotify("Sol's Rng Button", function()
            print("Sol's Rng")
        end)
    end
})

-- Blckot Rvivl
local BlckotRvivlTab = Window:Tab({ Title = "Blckot Rvivl", Icon = "" })
local Button = BlckotRvivlTab:Button({
    Title = "Blckot Rvivl",
    Callback = function()
        runWithNotify("Blckot Rvivl Button", function()
            print("Blckot Rvivl")
        end)
    end
})

-- Da Hood
local DaHoodTab = Window:Tab({ Title = "Da Hood", Icon = "" })
local Button = DaHoodTab:Button({
    Title = "Da Hood",
    Callback = function()
        runWithNotify("Da Hood Button", function()
            print("Da Hood")
        end)
    end
})

-- Dig
local DigTab = Window:Tab({ Title = "Dig", Icon = "" })
local Button = DigTab:Button({
    Title = "Dig",
    Callback = function()
        runWithNotify("Dig Button", function()
            print("Dig")
        end)
    end
})

-- Funky Friday
local FunkyFridayTab = Window:Tab({ Title = "Funky Friday", Icon = "" })
local Button = FunkyFridayTab:Button({
    Title = "Funky Friday",
    Callback = function()
        runWithNotify("Funky Friday Button", function()
            print("Funky Friday")
        end)
    end
})

-- Feed ur Pet
local FeedUrPetTab = Window:Tab({ Title = "Feed ur Pet", Icon = "" })
local Button = FeedUrPetTab:Button({
    Title = "Feed ur Pet",
    Callback = function()
        runWithNotify("Feed ur Pet Button", function()
            print("Feed ur Pet")
        end)
    end
})

-- Big Pntbll 2
local BigPntbll2Tab = Window:Tab({ Title = "Big Pntbll 2", Icon = "" })
local Button = BigPntbll2Tab:Button({
    Title = "Big Pntbll 2",
    Callback = function()
        runWithNotify("Big Pntbll 2 Button", function()
            print("Big Pntbll 2")
        end)
    end
})

-- FPWC
local FPWCTab = Window:Tab({ Title = "FPWC", Icon = "" })
local Button = FPWCTab:Button({
    Title = "FPWC",
    Callback = function()
        runWithNotify("FPWC Button", function()
            print("FPWC")
        end)
    end
})

-- Prison Life
local PrisonLifeTab = Window:Tab({ Title = "Prison Life", Icon = "" })
local Button = PrisonLifeTab:Button({
    Title = "Prison Life",
    Callback = function()
        runWithNotify("Prison Life Button", function()
            print("Prison Life")
        end)
    end
})

-- NDS
local NDSTab = Window:Tab({ Title = "NDS", Icon = "" })
local Button = NDSTab:Button({
    Title = "NDS",
    Callback = function()
        runWithNotify("NDS Button", function()
            print("NDS")
        end)
    end
})

-- Prject Smash
local PrjectSmashTab = Window:Tab({ Title = "Prject Smash", Icon = "" })
local Button = PrjectSmashTab:Button({
    Title = "Prject Smash",
    Callback = function()
        runWithNotify("Prject Smash Button", function()
            print("Prject Smash")
        end)
    end
})

-- Aooni Nitemr
local AooniNitemrTab = Window:Tab({ Title = "Aooni Nitemr", Icon = "" })
local Button = AooniNitemrTab:Button({
    Title = "Aooni Nitemr",
    Callback = function()
        runWithNotify("Aooni Nitemr Button", function()
            print("Aooni Nitemr")
        end)
    end
})

-- Vllibll Leg.
local VllibllLegTab = Window:Tab({ Title = "Vllibll Leg.", Icon = "" })
local Button = VllibllLegTab:Button({
    Title = "Vllibll Leg.",
    Callback = function()
        runWithNotify("Vllibll Leg. Button", function()
            print("Vllibll Leg.")
        end)
    end
})

-- Jjtsu Inf.
local JjtsuInfTab = Window:Tab({ Title = "Jjtsu Inf.", Icon = "" })
local Button = JjtsuInfTab:Button({
    Title = "Jjtsu Inf.",
    Callback = function()
        runWithNotify("Jjtsu Inf. Button", function()
            print("Jjtsu Inf.")
        end)
    end
})

-- Jail Break
local JailBreakTab = Window:Tab({ Title = "Jail Break", Icon = "" })
local Button = JailBreakTab:Button({
    Title = "Jail Break",
    Callback = function()
        runWithNotify("Jail Break Button", function()
            print("Jail Break")
        end)
    end
})

-- Doors
local DoorsTab = Window:Tab({ Title = "Doors", Icon = "" })
local Button = DoorsTab:Button({
    Title = "Doors",
    Callback = function()
        runWithNotify("Doors Button", function()
            print("Doors")
        end)
    end
})

-- Evade
local EvadeTab = Window:Tab({ Title = "Evade", Icon = "" })
local Button = EvadeTab:Button({
    Title = "Evade",
    Callback = function()
        runWithNotify("Evade Button", function()
            print("Evade")
        end)
    end
})

-- A. Lst Stnd
local ALstStndTab = Window:Tab({ Title = "A. Lst Stnd", Icon = "" })
local Button = ALstStndTab:Button({
    Title = "A. Lst Stnd",
    Callback = function()
        runWithNotify("A. Lst Stnd Button", function()
            print("A. Lst Stnd")
        end)
    end
})

-- Hero Battle.
local HeroBattleTab = Window:Tab({ Title = "Hero Battle.", Icon = "" })
local Button = HeroBattleTab:Button({
    Title = "Hero Battle.",
    Callback = function()
        runWithNotify("Hero Battle. Button", function()
            print("Hero Battle.")
        end)
    end
})

-- Ur Bizre Adv
local UrBizreAdvTab = Window:Tab({ Title = "Ur Bizre Adv", Icon = "" })
local Button = UrBizreAdvTab:Button({
    Title = "Ur Bizre Adv",
    Callback = function()
        runWithNotify("Ur Bizre Adv Button", function()
            print("Ur Bizre Adv")
        end)
    end
})

-- Anime Power
local AnimePowerTab = Window:Tab({ Title = "Anime Power", Icon = "" })
local Button = AnimePowerTab:Button({
    Title = "Anime Power",
    Callback = function()
        runWithNotify("Anime Power Button", function()
            print("Anime Power")
        end)
    end
})

-- Anime Saga
local AnimeSagaTab = Window:Tab({ Title = "Anime Saga", Icon = "" })
local Button = AnimeSagaTab:Button({
    Title = "Anime Saga",
    Callback = function()
        runWithNotify("Anime Saga Button", function()
            print("Anime Saga")
        end)
    end
})

-- Gun Grnd FFA
local GunGrndFFATab = Window:Tab({ Title = "Gun Grnd FFA", Icon = "" })
local Button = GunGrndFFATab:Button({
    Title = "Gun Grnd FFA",
    Callback = function()
        runWithNotify("Gun Grnd FFA Button", function()
            print("Gun Grnd FFA")
        end)
    end
})

-- LBB
local LBBTab = Window:Tab({ Title = "LBB", Icon = "" })
local Button = LBBTab:Button({
    Title = "LBB",
    Callback = function()
        runWithNotify("LBB Button", function()
            print("LBB")
        end)
    end
})

-- Anime Vangrd
local AnimeVangrdTab = Window:Tab({ Title = "Anime Vangrd", Icon = "" })
local Button = AnimeVangrdTab:Button({
    Title = "Anime Vangrd",
    Callback = function()
        runWithNotify("Anime Vangrd Button", function()
            print("Anime Vangrd")
        end)
    end
})

-- Pets Go
local PetsGoTab = Window:Tab({ Title = "Pets Go", Icon = "" })
local Button = PetsGoTab:Button({
    Title = "Pets Go",
    Callback = function()
        runWithNotify("Pets Go Button", function()
            print("Pets Go")
        end)
    end
})

-- Pet Sim 99
local PetSim99Tab = Window:Tab({ Title = "Pet Sim 99", Icon = "" })
local Button = PetSim99Tab:Button({
    Title = "Pet Sim 99",
    Callback = function()
        runWithNotify("Pet Sim 99 Button", function()
            print("Pet Sim 99")
        end)
    end
})

-- Eat e World
local EatEWorldTab = Window:Tab({ Title = "Eat e World", Icon = "" })
local Button = EatEWorldTab:Button({
    Title = "Eat e World",
    Callback = function()
        runWithNotify("Eat e World Button", function()
            print("Eat e World")
        end)
    end
})

-- Arise Crsovr
local AriseCrsovrTab = Window:Tab({ Title = "Arise Crsovr", Icon = "" })
local Button = AriseCrsovrTab:Button({
    Title = "Arise Crsovr",
    Callback = function()
        runWithNotify("Arise Crsovr Button", function()
            print("Arise Crsovr")
        end)
    end
})

-- Anime Rngr X
local AnimeRngrXTab = Window:Tab({ Title = "Anime Rngr X", Icon = "" })
local Button = AnimeRngrXTab:Button({
    Title = "Anime Rngr X",
    Callback = function()
        runWithNotify("Anime Rngr X Button", function()
            print("Anime Rngr X")
        end)
    end
})

-- Mrdr Mstry 2
local MrdrMstry2Tab = Window:Tab({ Title = "Mrdr Mstry 2", Icon = "" })
local Button = MrdrMstry2Tab:Button({
    Title = "Mrdr Mstry 2",
    Callback = function()
        runWithNotify("Mrdr Mstry 2 Button", function()
            print("Mrdr Mstry 2")
        end)
    end
})

-- Meme Sea
local MemeSeaTab = Window:Tab({ Title = "Meme Sea", Icon = "" })
local Button = MemeSeaTab:Button({
    Title = "Meme Sea",
    Callback = function()
        runWithNotify("Meme Sea Button", function()
            print("Meme Sea")
        end)
    end
})

-- ASTDX
local ASTDXTab = Window:Tab({ Title = "ASTDX", Icon = "" })
local Button = ASTDXTab:Button({
    Title = "ASTDX",
    Callback = function()
        runWithNotify("ASTDX Button", function()
            print("ASTDX")
        end)
    end
})

-- Jjtsu Shigns
local JjtsuShignsTab = Window:Tab({ Title = "Jjtsu Shigns", Icon = "" })
local Button = JjtsuShignsTab:Button({
    Title = "Jjtsu Shigns",
    Callback = function()
        runWithNotify("Jjtsu Shigns Button", function()
            print("Jjtsu Shigns")
        end)
    end
})

-- One Fruit
local OneFruitTab = Window:Tab({ Title = "One Fruit", Icon = "" })
local Button = OneFruitTab:Button({
    Title = "One Fruit",
    Callback = function()
        runWithNotify("One Fruit Button", function()
            print("One Fruit")
        end)
    end
})

-- The Mimic
local TheMimicTab = Window:Tab({ Title = "The Mimic", Icon = "" })
local Button = TheMimicTab:Button({
    Title = "The Mimic",
    Callback = function()
        runWithNotify("The Mimic Button", function()
            print("The Mimic")
        end)
    end
})

-- Buble Gm Inf
local BubleGmInfTab = Window:Tab({ Title = "Buble Gm Inf", Icon = "" })
local Button = BubleGmInfTab:Button({
    Title = "Buble Gm Inf",
    Callback = function()
        runWithNotify("Buble Gm Inf Button", function()
            print("Buble Gm Inf")
        end)
    end
})

-- BL. Rivals
local BLRivalsTab = Window:Tab({ Title = "BL. Rivals", Icon = "" })
local Button = BLRivalsTab:Button({
    Title = "BL. Rivals",
    Callback = function()
        runWithNotify("BL. Rivals Button", function()
            print("BL. Rivals")
        end)
    end
})

-- Sky wars
local SkyWarsTab = Window:Tab({ Title = "Sky wars", Icon = "" })
local Button = SkyWarsTab:Button({
    Title = "Sky wars",
    Callback = function()
        runWithNotify("Skywars Button", function()
            print("Sky wars")
        end)
    end
})

-- Credits tab
local CreditsTab = Window:Tab({ Title = "Credits", Icon = "star" })
local Paragraph = CreditsTab:Paragraph({
    Title = "Wind UI",
    Desc = "This script is made by SynthX. All credits go to footagesus for making the UI Library",
    Locked = false,
})

local Paragraph = CreditsTab:Paragraph({
    Title = "Scripts",
    Desc = "All credits go to the various owners of the given scripts used in this script",
    Locked = false,
})

local Paragraph = CreditsTab:Paragraph({
    Title = "Keybind",
    Desc = "If you didn't read the message at the start of the script execution, press 'K' to toggle the GUI",
    Locked = false,
})

-- Notification
WindUI:Notify({
    Title = "Successfully Loaded!",
    Content = "Thank you for using CodeCache. Press 'K' to toggle GUI",
    Duration = 5,
    Icon = "check"
})
