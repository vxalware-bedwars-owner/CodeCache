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
  [6872265039] = { Title = "Bedwars", Icon = "star" },
  [8236395285] = { Title = "Rivals", Icon = "star" }
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
        Title = "Vxalware",
        Desc = "The Best Free, Keyless Bedwars Script",
        Locked = false,
        Callback = function()
            print("Vxalware button pressed")
        end
    })
elseif placeId == 8236395285 then
    GameTab:Button({
        Title = "Rift Hub",
        Desc = "The Best Free, Keyless Rivals Script",
        Locked = false,
        Callback = function()
            print("Rift Hub button pressed")
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
    Title = "Infinite Yield",
    Locked = false,
    Callback = function()
        print("Infinite Yield button pressed")
    end
})
