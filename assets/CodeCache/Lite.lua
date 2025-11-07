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

local supportedGames = {
  [16732694052] = { Title = "Fisch", Icon = "fish" },
  [116061507956332] = { Title = "+1 SPRNG", Icon = "dices" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
  [10449761463] = { Title = "TSB", Icon = "hand-fist" },
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
            print("")
        end
    })
    
elseif placeId == 8236395285 then
    GameTab:Button({
        Title = "",
        Desc = "The Best Free, Keyless  Script",
        Locked = false,
        Callback = function()
            print("")
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
    Desc = "Credits to Fotagesus, SynthX, and the various owners of the scripts. Without these people CodeCache Lite would not have been possible",
    Locked = false,
})

local Paragraph = StuffsTab:Paragraph({
    Title = "Keybind",
    Desc = "If you didn't read the message at the start of the script execution, press 'K' to toggle the GUI",
    Locked = false,
})
