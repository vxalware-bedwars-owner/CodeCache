local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "CodeCache Lite",
    Icon = "moon-star",
    Author = "Beta Release",
    Folder = "Lite",

    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = false,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
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

-- runWithNotify API
local _runWithNotify_firstRun = {}
local function runWithNotify(title, fn, opts)
    -- API Directions:
    -- kind = "dropdown" | "toggle" | nil
    -- getLabel = function() -> string  (for dropdowns)
    -- getState = function() -> boolean (for toggles)
    -- suppressNone = true|false (for dropdowns)
    opts = opts or {}
    local kind = opts.kind
    local getLabel = opts.getLabel
    local getState = opts.getState
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

    -- Success run | Universal
    WindUI:Notify({
        Title = "Success",
        Content = "Successfully ran "..tostring(title),
        Duration = 1.5,
    })
end

local supportedGames = {
  [16732694052] = { Title = "Fisch", Icon = "fish" },
  [116061507956332] = { Title = "+1 SPRNG", Icon = "dices" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [17625359962] = { Title = "Rivals", Icon = "flame" },
  [6872265039] = { Title = "Bedwars", Icon = "bed" },
  [109983668079237] = { Title = "SAB", Icon = "package" },
  [126884695634066] = { Title = "GAG", Icon = "hand-fist" },
  [18687417158] = { Title = "Forsaken", Icon = "hand-fist" },
  [103754275310547] = { Title = "Hunty Zombie", Icon = "hand-fist" },
  [79546208627805] = { Title = "99 NITF", Icon = "hand-fist" },
  [12625784503] = { Title = "Saber Shwdwn", Icon = "hand-fist" },
  [2753915549] = { Title = "Blox Fruits", Icon = "hand-fist" },
  [4855457388] = { Title = "Demon Fall", Icon = "hand-fist" },
  [1537690962] = { Title = "Bee Swarm", Icon = "hand-fist" },
  [301549746] = { Title = "Counter Blox", Icon = "hand-fist" },
  [13772394625] = { Title = "Blade Ball", Icon = "hand-fist" },
  [10449761463] = { Title = "Car Crshrs 2", Icon = "hand-fist" },
  [10449761463] = { Title = "Peta X2", Icon = "hand-fist" },
  [10449761463] = { Title = "Death Ball", Icon = "hand-fist" },
  [10449761463] = { Title = "Slap Battles", Icon = "hand-fist" },
  [10449761463] = { Title = "Cmbt Wrriors", Icon = "hand-fist" },
  [] = { Title = "Hypershot", Icon = "" },
  [] = { Title = "Tsunami Game", Icon = "" },
  [] = { Title = "Islands", Icon = "" },
  [] = { Title = "FTAP", Icon = "" },
  [] = { Title = "Beaks", Icon = "" },
  [] = { Title = "Dead Rails", Icon = "" },
  [] = { Title = "BABFT", Icon = "" },
  [] = { Title = "Ink Game", Icon = "" },
  [] = { Title = "Arsenal", Icon = "" },
  [] = { Title = "Mr vs Sh", Icon = "" },
  [] = { Title = "Ninja Leg.", Icon = "" },
  [] = { Title = "Muscle Leg.", Icon = "" },
  [] = { Title = "Leg. f Speed", Icon = "" },
  [] = { Title = "Zombie Attck", Icon = "" },
  [] = { Title = "King Legacy", Icon = "" },
  [] = { Title = "Fantom 4rces", Icon = "" },
  [] = { Title = "Da Strike", Icon = "" },
  [] = { Title = "Adopt Me", Icon = "" },
  [] = { Title = "Bridge Duels", Icon = "" },
  [] = { Title = "Sol's Rng", Icon = "" },
  [] = { Title = "Blckot Rvivl", Icon = "" },
  [] = { Title = "Da Hood", Icon = "" },
  [] = { Title = "Dig", Icon = "" },
  [] = { Title = "Funky Friday", Icon = "" },
  [] = { Title = "Feed ur Pet", Icon = "" },
  [] = { Title = "Big Pntbll 2", Icon = "" },
  [] = { Title = "FPWC", Icon = "" },
  [] = { Title = "Prison Life", Icon = "" },
  [] = { Title = "NDS", Icon = "" },
  [] = { Title = "Prject Smash", Icon = "" },
  [] = { Title = "Aooni Nitemr", Icon = "" },
  [] = { Title = "Vllibll Leg.", Icon = "" },
  [] = { Title = "Jjtsu Inf.", Icon = "" },
  [] = { Title = "Jail Break", Icon = "" },
  [] = { Title = "Doors", Icon = "" },
  [] = { Title = "Evade", Icon = "" },
  [] = { Title = "A. Lst Stnd", Icon = "" },
  [] = { Title = "Hero Battle.", Icon = "" },
  [] = { Title = "Ur Bizre Adv", Icon = "" },
  [] = { Title = "Anime Power", Icon = "" },
  [] = { Title = "Anime Saga", Icon = "" },
  [] = { Title = "Gun Grnd FFA", Icon = "" },
  [] = { Title = "LBB", Icon = "" },
  [] = { Title = "Anime Vangrd", Icon = "" },
  [] = { Title = "Pets Go", Icon = "" },
  [] = { Title = "Pet Sim 99", Icon = "" },
  [] = { Title = "Eat e World", Icon = "" },
  [] = { Title = "Arise Crsovr", Icon = "" },
  [] = { Title = "Anime Rngr X", Icon = "" },
  [] = { Title = "Mrdr Mstry 2", Icon = "" },
  [] = { Title = "Meme Sea", Icon = "" },
  [] = { Title = "ASTD", Icon = "" },
  [] = { Title = "Jjtsu Shigns", Icon = "" },
  [] = { Title = "One Fruits", Icon = "" },
  [] = { Title = "The Mimic", Icon = "" },
  [] = { Title = "Buble Gm Inf", Icon = "" },
  [] = { Title = "BL. Rivals", Icon = "" },
  [] = { Title = "Sky wars", Icon = "" },
}

local placeId = game.PlaceId
local gameInfo = supportedGames[placeId]

local GameTab
if gameInfo then
    GameTab = Window:Tab({
        Title = gameInfo.Title,
        Icon = gameInfo.Icon,
        Locked = false,
    })
else
    GameTab = Window:Tab({
        Title = "Unknown",
        Icon = "boxes",
        Locked = false,
    })
end

if placeId == 6872265039 then
    GameTab:Button({
        Title = "",
        Desc = "The Best Free, Keyless  Script",
        Locked = false,
        Callback = function()
            runWithNotify("", function()
                loadstring(game:HttpGet("",true))()
            end)
        end
    })
elseif placeId == 8236395285 then
    GameTab:Button({
        Title = "",
        Desc = "The Best Free, Keyless  Script",
        Locked = false,
        Callback = function()
            runWithNotify("", function()
                loadstring(game:HttpGet("",true))()
            end)
        end
    })
else
    GameTab:Button({
        Title = "Unknown",
        Desc = "Game Not Supported!",
        Locked = false,
        Callback = function()
            print("Game Not Supported!")
        end
    })
end

local UniversalTab = Window:Tab({
    Title = "Universal",
    Icon = "atom",
    Locked = false,
})

UniversalTab:Button({
    Title = "",
    Locked = false,
    Callback = function()
        print("")
    end
})

local StuffsTab = Window:Tab({
    Title = "Stuffs",
    Icon = "circle-user",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "CodeCache Lite",
    Desc = "You are running this script on the Lite edition. Please use V3 or Premium for a wider range of scripts",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "Credits",
    Desc = "Credits to Fotagesus, SynthX, and the various owners of the scripts.",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "Keybind",
    Desc = "If you didn't read the message at the start of the script execution, press 'K' to toggle the GUI",
    Locked = false,
})

WindUI:Notify({
    Title = "Successfully Loaded!",
    Content = "Thank you for using CodeCache. Press 'K' to toggle GUI",
    Duration = 5,
    Icon = "check"
})
