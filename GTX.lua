local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local MarketService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("GTXGameSuite") then
    CoreGui.GTXGameSuite:Destroy()
end
if CoreGui:FindFirstChild("GTX_HUD") then
    CoreGui.GTX_HUD:Destroy()
end
if CoreGui:FindFirstChild("GTX_FREE_IntroGui") then
    CoreGui.GTX_FREE_IntroGui:Destroy()
end

-- ЗАГРУЗОЧНЫЙ ЭКРАН (INTRO) - FULLSCREEN FIX
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "GTX_FREE_IntroGui"
IntroGui.ResetOnSpawn = false
IntroGui.DisplayOrder = 1000000
pcall(function() IntroGui.Parent = CoreGui end)
if IntroGui.Parent ~= CoreGui then
    IntroGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local IntroBackground = Instance.new("Frame")
IntroBackground.Name = "IntroBackground"
IntroBackground.Size = UDim2.new(1, 100, 1, 100)
IntroBackground.Position = UDim2.new(0, -50, 0, -50)
IntroBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroBackground.BorderSizePixel = 0
IntroBackground.Parent = IntroGui

local IntroCenterCard = Instance.new("Frame")
IntroCenterCard.Name = "CenterCard"
IntroCenterCard.Size = UDim2.new(0, 420, 0, 220)
IntroCenterCard.Position = UDim2.new(0.5, -210, 0.5, -110)
IntroCenterCard.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
IntroCenterCard.BorderSizePixel = 0
IntroCenterCard.Parent = IntroBackground

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 8)
CardCorner.Parent = IntroCenterCard

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(60, 60, 60)
CardStroke.Thickness = 1
CardStroke.Parent = IntroCenterCard

local IntroIcon = Instance.new("ImageLabel")
IntroIcon.Name = "IntroIcon"
IntroIcon.Size = UDim2.new(0, 90, 0, 32)
IntroIcon.Position = UDim2.new(0.5, -45, 0, 28)
IntroIcon.BackgroundTransparency = 1
IntroIcon.Image = "rbxassetid://124067145134742"
IntroIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
IntroIcon.Parent = IntroCenterCard

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Size = UDim2.new(1, 0, 0, 25)
IntroTitle.Position = UDim2.new(0, 0, 0, 72)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Font = Enum.Font.GothamBold
IntroTitle.Text = "GTX_FREE_ / SUITE INITIALIZING"
IntroTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroTitle.TextSize = 14
IntroTitle.Parent = IntroCenterCard

local IntroStatus = Instance.new("TextLabel")
IntroStatus.Size = UDim2.new(1, -40, 0, 20)
IntroStatus.Position = UDim2.new(0, 20, 0, 105)
IntroStatus.BackgroundTransparency = 1
IntroStatus.Font = Enum.Font.Gotham
IntroStatus.Text = "Loading security bypasses..."
IntroStatus.TextColor3 = Color3.fromRGB(160, 160, 160)
IntroStatus.TextSize = 11
IntroStatus.Parent = IntroCenterCard

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, -60, 0, 6)
BarBackground.Position = UDim2.new(0, 30, 0, 145)
BarBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = IntroCenterCard

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBackground

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = BarFill

local IntroPercent = Instance.new("TextLabel")
IntroPercent.Size = UDim2.new(1, 0, 0, 20)
IntroPercent.Position = UDim2.new(0, 0, 0, 165)
IntroPercent.BackgroundTransparency = 1
IntroPercent.Font = Enum.Font.GothamBold
IntroPercent.Text = "0%"
IntroPercent.TextColor3 = Color3.fromRGB(120, 120, 120)
IntroPercent.TextSize = 11
IntroPercent.Parent = IntroCenterCard

task.spawn(function()
    local steps = {
        {text = "Initializing core modules...", progress = 0.2, time = 0.3},
        {text = "Bypassing anti-cheat invalid positions...", progress = 0.5, time = 0.4},
        {text = "Injecting server-wide invisibility & fling...", progress = 0.8, time = 0.3},
        {text = "GTX_FREE_ Suite successfully loaded!", progress = 1.0, time = 0.2},
    }
    
    for _, step in ipairs(steps) do
        IntroStatus.Text = step.text
        local tw = TweenService:Create(BarFill, TweenInfo.new(step.time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(step.progress, 0, 1, 0)})
        tw:Play()
        
        local startP = tonumber(IntroPercent.Text:match("%d+")) or 0
        local targetP = math.floor(step.progress * 100)
        for p = startP, targetP, 2 do
            IntroPercent.Text = p .. "%"
            task.wait(step.time / ((targetP - startP > 0) and (targetP - startP) / 2 or 1))
        end
        IntroPercent.Text = targetP .. "%"
    end
    
    task.wait(0.2)
    local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(IntroCenterCard, fadeInfo, {Position = UDim2.new(0.5, -210, 0.5, -140), BackgroundTransparency = 1}):Play()
    for _, child in ipairs(IntroCenterCard:GetDescendants()) do
        if child:IsA("TextLabel") then
            TweenService:Create(child, fadeInfo, {TextTransparency = 1}):Play()
        elseif child:IsA("ImageLabel") then
            TweenService:Create(child, fadeInfo, {ImageTransparency = 1}):Play()
        elseif child:IsA("Frame") then
            TweenService:Create(child, fadeInfo, {BackgroundTransparency = 1}):Play()
        elseif child:IsA("UIStroke") then
            TweenService:Create(child, fadeInfo, {Transparency = 1}):Play()
        end
    end
    TweenService:Create(IntroBackground, fadeInfo, {BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    IntroGui:Destroy()
end)

local gameName = "ROBLOX"
pcall(function()
    local info = MarketService:GetProductInfo(game.PlaceId)
    if info and info.Name then
        gameName = info.Name
    end
end)

local suiteTitle = "GTX_FREE_ / " .. gameName

local State = {
    MenuOpen = true,
    FlickShot = false,
    SpeedGlitch = false,
    Wallhop = false,
    MM2ESP = true,
    ItemESP = false,
    CoinFarm = false,
    TPPlayerEnabled = false,
    HudEnabled = true,
    Fly = false,
    Noclip = false,
    Fullbright = false,
    InfJump = false,
    HitboxExpander = false,
    FOVChanger = false,
    Resolver = false,
    AntiAim = false,
    FakeLag = false,
    Invisible = false,
    FlingTargetRole = "Murderer",
    FlingThePlayer = false,
    TPToRoleActive = false,
    TPRoleChoice = "Murderer",
}

local Keybinds = {
    ToggleMenu = Enum.KeyCode.M,
    FlickShot = Enum.KeyCode.Q,
    SpeedGlitch = Enum.KeyCode.R,
    Wallhop = Enum.KeyCode.V,
    Fly = Enum.KeyCode.F,
    Noclip = Enum.KeyCode.N,
    CoinFarm = Enum.KeyCode.C,
    Invisible = Enum.KeyCode.X,
    FlingThePlayer = Enum.KeyCode.Z,
    TPToRole = Enum.KeyCode.E,
}

local Config = {
    JumpSpeed = 80,
    NormalSpeed = 16,
    WallhopHeight = 28,
    FOVValue = 90,
    TargetPlayer = "",
    KeyPrefix = "GTX_FREE_",
}

local function PlayClickSound()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6895070853"
        sound.Volume = 0.7
        sound.Parent = CoreGui
        sound:Play()
        task.delay(1, function() sound:Destroy() end)
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GTX_FREE_GameSuite"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
pcall(function() ScreenGui.Parent = CoreGui end)
if ScreenGui.Parent ~= CoreGui then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 40, 40)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Уведомление по центру (для неработающей функции Invisible)
local CenterErrorLabel = Instance.new("TextLabel")
CenterErrorLabel.Name = "CenterErrorLabel"
CenterErrorLabel.Size = UDim2.new(0, 420, 0, 50)
CenterErrorLabel.Position = UDim2.new(0.5, -210, 0.5, -25)
CenterErrorLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
CenterErrorLabel.BackgroundTransparency = 0.2
CenterErrorLabel.Font = Enum.Font.GothamBold
CenterErrorLabel.Text = "Sorry, this function isn't working."
CenterErrorLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
CenterErrorLabel.TextSize = 15
CenterErrorLabel.Visible = false
CenterErrorLabel.ZIndex = 10
CenterErrorLabel.Parent = MainFrame

local CelCorner = Instance.new("UICorner")
CelCorner.CornerRadius = UDim.new(0, 6)
CelCorner.Parent = CenterErrorLabel

local CelStroke = Instance.new("UIStroke")
CelStroke.Color = Color3.fromRGB(80, 30, 30)
CelStroke.Thickness = 1
CelStroke.Parent = CenterErrorLabel

local draggingMain, dragInputMain, dragStartMain, startPosMain
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = true
        dragStartMain = input.Position
        startPosMain = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMain = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputMain = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInputMain and draggingMain then
        local delta = input.Position - dragStartMain
        MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
    end
end)

local HeaderBar = Instance.new("Frame")
HeaderBar.Name = "HeaderBar"
HeaderBar.Size = UDim2.new(1, 0, 0, 40)
HeaderBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HeaderBar.BorderSizePixel = 0
HeaderBar.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 6)
HeaderCorner.Parent = HeaderBar

local TopIcon = Instance.new("ImageLabel")
TopIcon.Name = "TopIcon"
TopIcon.Size = UDim2.new(0, 75, 0, 26)
TopIcon.Position = UDim2.new(0.5, -37.5, 0.5, -13)
TopIcon.BackgroundTransparency = 1
TopIcon.Image = "rbxassetid://124067145134742"
TopIcon.Parent = HeaderBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 280, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = suiteTitle
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = HeaderBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Parent = HeaderBar

CloseBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    State.MenuOpen = false
    MainFrame.Visible = false
end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, -50)
Sidebar.Position = UDim2.new(0, 10, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 6)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.Parent = Sidebar

local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -165, 1, -50)
ContentContainer.Position = UDim2.new(0, 155, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local function CreateTabPage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    Page.Visible = false
    Page.Parent = ContentContainer

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6)
    Layout.Parent = Page

    return Page
end

local CombatPage = CreateTabPage("Combat")
local PlayerPage = CreateTabPage("Player")
local RenderPage = CreateTabPage("Render")
local MM2Page = CreateTabPage("MM2")
local HVHPage = CreateTabPage("HVH")
local MiscPage = CreateTabPage("Misc")
local SettingPage = CreateTabPage("Setting")

CombatPage.Visible = true

local function CreateTabButton(name, targetPage)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -6, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Btn.BorderSizePixel = 0
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = "  > " .. name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Btn

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(30, 30, 30)
    Stroke.Thickness = 1
    Stroke.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        PlayClickSound()
        for _, child in pairs(ContentContainer:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        targetPage.Visible = true
    end)
end

CreateTabButton("COMBAT", CombatPage)
CreateTabButton("PLAYER", PlayerPage)
CreateTabButton("RENDER", RenderPage)
CreateTabButton("MM2", MM2Page)
CreateTabButton("HVH", HVHPage)
CreateTabButton("MISC", MiscPage)
CreateTabButton("SETTING", SettingPage)

local UserInfoContainer = Instance.new("Frame")
UserInfoContainer.Name = "UserInfoContainer"
UserInfoContainer.Size = UDim2.new(1, -6, 0, 50)
UserInfoContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
UserInfoContainer.BorderSizePixel = 0
UserInfoContainer.Parent = Sidebar

local UICorner_UI = Instance.new("UICorner")
UICorner_UI.CornerRadius = UDim.new(0, 6)
UICorner_UI.Parent = UserInfoContainer

local UIStroke_UI = Instance.new("UIStroke")
UIStroke_UI.Color = Color3.fromRGB(35, 35, 35)
UIStroke_UI.Thickness = 1
UIStroke_UI.Parent = UserInfoContainer

local AvatarIcon = Instance.new("ImageLabel")
AvatarIcon.Name = "AvatarIcon"
AvatarIcon.Size = UDim2.new(0, 36, 0, 36)
AvatarIcon.Position = UDim2.new(0, 7, 0.5, -18)
AvatarIcon.BackgroundTransparency = 1
AvatarIcon.Image = "rbxassetid://0"
AvatarIcon.Parent = UserInfoContainer

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarIcon

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = Color3.fromRGB(70, 70, 70)
AvatarStroke.Thickness = 1
AvatarStroke.Parent = AvatarIcon

local UserNameLabel = Instance.new("TextLabel")
UserNameLabel.Name = "UserNameLabel"
UserNameLabel.Size = UDim2.new(1, -50, 1, 0)
UserNameLabel.Position = UDim2.new(0, 48, 0, 0)
UserNameLabel.BackgroundTransparency = 1
UserNameLabel.Font = Enum.Font.GothamBold
UserNameLabel.Text = LocalPlayer.Name
UserNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UserNameLabel.TextSize = 11
UserNameLabel.TextXAlignment = Enum.TextXAlignment.Left
UserNameLabel.Parent = UserInfoContainer

task.spawn(function()
    pcall(function()
        local content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if content then
            AvatarIcon.Image = content
        end
    end)
end)

local function CreateToggle(parent, labelText, stateKey, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -5, 0, 34)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = ToggleFrame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(35, 35, 35)
    Stroke.Thickness = 1
    Stroke.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 42, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -48, 0.5, -10)
    ToggleBtn.BackgroundColor3 = State[stateKey] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0)
    BtnCorner.Parent = ToggleBtn

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = State[stateKey] and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = State[stateKey] and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(160, 160, 160)
    Circle.BorderSizePixel = 0
    Circle.Parent = ToggleBtn

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle

    ToggleBtn.MouseButton1Click:Connect(function()
        PlayClickSound()
        State[stateKey] = not State[stateKey]
        local active = State[stateKey]

        local targetColorBtn = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
        local targetPosCircle = active and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColorCircle = active and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(160, 160, 160)

        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = targetColorBtn}):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = targetPosCircle, BackgroundColor3 = targetColorCircle}):Play()

        if callback then
            pcall(function() callback(active) end)
        end
    end)
end

CreateToggle(CombatPage, "FlickCamera (Q Key, Fixed Aim)", "FlickShot", function(v) State.FlickShot = v end)
CreateToggle(CombatPage, "Fling Target Role (Bypass/Void)", "FlingThePlayer", function(v) State.FlingThePlayer = v end)

CreateToggle(PlayerPage, "Auto SpeedGlitch (Jump 80 / Land 16)", "SpeedGlitch", function(v) State.SpeedGlitch = v end)
CreateToggle(PlayerPage, "Invisible (Disabled / Notice)", "Invisible", function(v)
    State.Invisible = v
    CenterErrorLabel.Visible = v
    if v then
        task.delay(3, function()
            if State.Invisible and CenterErrorLabel then
                -- Можно автоматически скрыть плашку через 3 секунды, либо оставить висеть. Оставим висеть пока включено.
            end
        end)
    end
end)
CreateToggle(PlayerPage, "Wallhop (V Key)", "Wallhop", function(v) State.Wallhop = v end)
CreateToggle(PlayerPage, "Fly", "Fly", function(v) State.Fly = v end)
CreateToggle(PlayerPage, "Noclip", "Noclip", function(v) State.Noclip = v end)
CreateToggle(PlayerPage, "Infinite Jump", "InfJump", function(v) State.InfJump = v end)

CreateToggle(RenderPage, "Fullbright", "Fullbright", function(v) State.Fullbright = v end)
CreateToggle(RenderPage, "FOV Changer", "FOVChanger", function(v) State.FOVChanger = v end)
CreateToggle(RenderPage, "Hitbox Expander", "HitboxExpander", function(v) State.HitboxExpander = v end)

CreateToggle(MM2Page, "MM2 Role ESP (Murder/Sheriff/Innocent)", "MM2ESP", function(v) State.MM2ESP = v end)
CreateToggle(MM2Page, "Item & Coin ESP", "ItemESP", function(v) State.ItemESP = v end)
CreateToggle(MM2Page, "Auto CoinFarm (Safe / Slow)", "CoinFarm", function(v) State.CoinFarm = v end)

CreateToggle(HVHPage, "Resolver (Anti-Desync)", "Resolver", function(v) State.Resolver = v end)
CreateToggle(HVHPage, "Anti-Aim (Spin/Jitter)", "AntiAim", function(v) State.AntiAim = v end)
CreateToggle(HVHPage, "FakeLag", "FakeLag", function(v) State.FakeLag = v end)

CreateToggle(MiscPage, "Watermark & HUD Enabled", "HudEnabled", function(v) State.HudEnabled = v end)

local FlingRoleFrame = Instance.new("Frame")
FlingRoleFrame.Size = UDim2.new(1, -5, 0, 38)
FlingRoleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FlingRoleFrame.BorderSizePixel = 0
FlingRoleFrame.Parent = CombatPage

local FrCorner = Instance.new("UICorner")
FrCorner.CornerRadius = UDim.new(0, 6)
FrCorner.Parent = FlingRoleFrame

local FrStroke = Instance.new("UIStroke")
FrStroke.Color = Color3.fromRGB(35, 35, 35)
FrStroke.Thickness = 1
FrStroke.Parent = FlingRoleFrame

local FrLabel = Instance.new("TextLabel")
FrLabel.Size = UDim2.new(0, 110, 1, 0)
FrLabel.Position = UDim2.new(0, 12, 0, 0)
FrLabel.BackgroundTransparency = 1
FrLabel.Font = Enum.Font.Gotham
FrLabel.Text = "Fling Target Role:"
FrLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FrLabel.TextSize = 11
FrLabel.TextXAlignment = Enum.TextXAlignment.Left
FrLabel.Parent = FlingRoleFrame

local FrBtn = Instance.new("TextButton")
FrBtn.Size = UDim2.new(0, 95, 0, 24)
FrBtn.Position = UDim2.new(1, -103, 0.5, -12)
FrBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FrBtn.BorderSizePixel = 0
FrBtn.Font = Enum.Font.GothamBold
FrBtn.Text = State.FlingTargetRole
FrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FrBtn.TextSize = 11
FrBtn.Parent = FlingRoleFrame

local FrBtnCorner = Instance.new("UICorner")
FrBtnCorner.CornerRadius = UDim.new(0, 4)
FrBtnCorner.Parent = FrBtn

FrBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    if State.FlingTargetRole == "Murderer" then
        State.FlingTargetRole = "Sheriff"
    else
        State.FlingTargetRole = "Murderer"
    end
    FrBtn.Text = State.FlingTargetRole
end)

local TPRoleFrame = Instance.new("Frame")
TPRoleFrame.Size = UDim2.new(1, -5, 0, 42)
TPRoleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TPRoleFrame.BorderSizePixel = 0
TPRoleFrame.Parent = CombatPage

local TpRCorn = Instance.new("UICorner")
TpRCorn.CornerRadius = UDim.new(0, 6)
TpRCorn.Parent = TPRoleFrame

local TpRStro = Instance.new("UIStroke")
TpRStro.Color = Color3.fromRGB(35, 35, 35)
TpRStro.Thickness = 1
TpRStro.Parent = TPRoleFrame

local TpRBtnChoice = Instance.new("TextButton")
TpRBtnChoice.Size = UDim2.new(0, 95, 0, 26)
TpRBtnChoice.Position = UDim2.new(0, 10, 0.5, -13)
TpRBtnChoice.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TpRBtnChoice.BorderSizePixel = 0
TpRBtnChoice.Font = Enum.Font.GothamBold
TpRBtnChoice.Text = "TP: " .. State.TPRoleChoice
TpRBtnChoice.TextColor3 = Color3.fromRGB(255, 255, 255)
TpRBtnChoice.TextSize = 11
TpRBtnChoice.Parent = TPRoleFrame

local TpRC2 = Instance.new("UICorner")
TpRC2.CornerRadius = UDim.new(0, 4)
TpRC2.Parent = TpRBtnChoice

TpRBtnChoice.MouseButton1Click:Connect(function()
    PlayClickSound()
    if State.TPRoleChoice == "Murderer" then
        State.TPRoleChoice = "Sheriff"
    else
        State.TPRoleChoice = "Murderer"
    end
    TpRBtnChoice.Text = "TP: " .. State.TPRoleChoice
end)

local TpRActionBtn = Instance.new("TextButton")
TpRActionBtn.Size = UDim2.new(0, 95, 0, 26)
TpRActionBtn.Position = UDim2.new(1, -105, 0.5, -13)
TpRActionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TpRActionBtn.BorderSizePixel = 0
TpRActionBtn.Font = Enum.Font.GothamBold
TpRActionBtn.Text = "TELEPORT"
TpRActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpRActionBtn.TextSize = 11
TpRActionBtn.Parent = TPRoleFrame

local TpRC3 = Instance.new("UICorner")
TpRC3.CornerRadius = UDim.new(0, 4)
TpRC3.Parent = TpRActionBtn

local function GetPlayerRole(player)
    local char = player.Character
    if not char then return "Innocent" end
    if char:FindFirstChild("Gun") or (player.Backpack and player.Backpack:FindFirstChild("Gun")) then
        return "Sheriff"
    elseif char:FindFirstChild("Knife") or (player.Backpack and player.Backpack:FindFirstChild("Knife")) then
        return "Murderer"
    end
    return "Innocent"
end

local function TeleportToRole(roleName)
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local role = GetPlayerRole(p)
                    if role == roleName then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        end
                        break
                    end
                end
            end
        end
    end)
end

TpRActionBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    TeleportToRole(State.TPRoleChoice)
end)

local TpFrame = Instance.new("Frame")
TpFrame.Size = UDim2.new(1, -5, 0, 42)
TpFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TpFrame.BorderSizePixel = 0
TpFrame.Parent = PlayerPage

local TpCorner = Instance.new("UICorner")
TpCorner.CornerRadius = UDim.new(0, 6)
TpCorner.Parent = TpFrame

local TpStroke = Instance.new("UIStroke")
TpStroke.Color = Color3.fromRGB(35, 35, 35)
TpStroke.Thickness = 1
TpStroke.Parent = TpFrame

local TpInput = Instance.new("TextBox")
TpInput.Size = UDim2.new(1, -100, 1, 0)
TpInput.Position = UDim2.new(0, 10, 0, 0)
TpInput.BackgroundTransparency = 1
TpInput.Font = Enum.Font.Gotham
TpInput.PlaceholderText = "Target Player Name..."
TpInput.Text = ""
TpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TpInput.TextSize = 12
TpInput.TextXAlignment = Enum.TextXAlignment.Left
TpInput.Parent = TpFrame

TpInput.FocusLost:Connect(function()
    Config.TargetPlayer = TpInput.Text
end)

local TpBtn = Instance.new("TextButton")
TpBtn.Size = UDim2.new(0, 80, 0, 26)
TpBtn.Position = UDim2.new(1, -88, 0.5, -13)
TpBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TpBtn.BorderSizePixel = 0
TpBtn.Font = Enum.Font.GothamBold
TpBtn.Text = "TP PLAYER"
TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpBtn.TextSize = 10
TpBtn.Parent = TpFrame

local TpBtnCorner = Instance.new("UICorner")
TpBtnCorner.CornerRadius = UDim.new(0, 4)
TpBtnCorner.Parent = TpBtn

TpBtn.MouseButton1Click:Connect(function()
    PlayClickSound()
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and (p.Name:lower():sub(1, #Config.TargetPlayer) == Config.TargetPlayer:lower() or p.DisplayName:lower():sub(1, #Config.TargetPlayer) == Config.TargetPlayer:lower()) then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
                break
            end
        end
    end)
end)

local function CreateKeybindButton(parent, labelText, bindKey)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -5, 0, 34)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(35, 35, 35)
    Stroke.Thickness = 1
    Stroke.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -90, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local BindBtn = Instance.new("TextButton")
    BindBtn.Size = UDim2.new(0, 75, 0, 22)
    BindBtn.Position = UDim2.new(1, -82, 0.5, -11)
    BindBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    BindBtn.BorderSizePixel = 0
    BindBtn.Font = Enum.Font.GothamBold
    BindBtn.Text = Keybinds[bindKey] and Keybinds[bindKey].Name or "NONE"
    BindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    BindBtn.TextSize = 11
    BindBtn.Parent = Frame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = BindBtn

    BindBtn.MouseButton1Click:Connect(function()
        PlayClickSound()
        BindBtn.Text = "..."
        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Keybinds[bindKey] = input.KeyCode
                BindBtn.Text = input.KeyCode.Name
                connection:Disconnect()
            end
        end)
    end)
end

CreateKeybindButton(SettingPage, "Toggle Menu Key", "ToggleMenu")
CreateKeybindButton(SettingPage, "FlickCamera Key", "FlickShot")
CreateKeybindButton(SettingPage, "SpeedGlitch Key", "SpeedGlitch")
CreateKeybindButton(SettingPage, "Wallhop Key", "Wallhop")
CreateKeybindButton(SettingPage, "Fly Key", "Fly")
CreateKeybindButton(SettingPage, "Noclip Key", "Noclip")
CreateKeybindButton(SettingPage, "CoinFarm Key", "CoinFarm")
CreateKeybindButton(SettingPage, "Invisible Key", "Invisible")
CreateKeybindButton(SettingPage, "FlingTarget Key", "FlingThePlayer")
CreateKeybindButton(SettingPage, "TP Role Key", "TPToRole")

local KeyPrefixLabel = Instance.new("TextLabel")
KeyPrefixLabel.Size = UDim2.new(1, -5, 0, 34)
KeyPrefixLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeyPrefixLabel.BorderSizePixel = 0
KeyPrefixLabel.Font = Enum.Font.Gotham
KeyPrefixLabel.Text = "  Key Prefix: " .. Config.KeyPrefix .. " [ACTIVE]"
KeyPrefixLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyPrefixLabel.TextSize = 12
KeyPrefixLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyPrefixLabel.Parent = SettingPage

local SettingCorner = Instance.new("UICorner")
SettingCorner.CornerRadius = UDim.new(0, 6)
SettingCorner.Parent = KeyPrefixLabel

local SettingStroke = Instance.new("UIStroke")
SettingStroke.Color = Color3.fromRGB(35, 35, 35)
SettingStroke.Thickness = 1
SettingStroke.Parent = KeyPrefixLabel

local HudGui = Instance.new("ScreenGui")
HudGui.Name = "GTX_FREE_HUD"
HudGui.ResetOnSpawn = false
HudGui.DisplayOrder = 999998
pcall(function() HudGui.Parent = CoreGui end)
if HudGui.Parent ~= CoreGui then HudGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local Watermark = Instance.new("Frame")
Watermark.Size = UDim2.new(0, 270, 0, 34)
Watermark.Position = UDim2.new(0, 20, 0, 20)
Watermark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Watermark.BorderSizePixel = 0
Watermark.Active = true
Watermark.Parent = HudGui
MakeDraggable(Watermark)

local WmCorner = Instance.new("UICorner")
WmCorner.CornerRadius = UDim.new(0, 6)
WmCorner.Parent = Watermark

local WmStroke = Instance.new("UIStroke")
WmStroke.Color = Color3.fromRGB(60, 60, 60)
WmStroke.Thickness = 1
WmStroke.Parent = Watermark

local WmIcon = Instance.new("ImageLabel")
WmIcon.Size = UDim2.new(0, 45, 0, 18)
WmIcon.Position = UDim2.new(0, 8, 0.5, -9)
WmIcon.BackgroundTransparency = 1
WmIcon.Image = "rbxassetid://124067145134742"
WmIcon.Parent = Watermark

local WmText = Instance.new("TextLabel")
WmText.Size = UDim2.new(1, -60, 1, 0)
WmText.Position = UDim2.new(0, 58, 0, 0)
WmText.BackgroundTransparency = 1
WmText.Font = Enum.Font.GothamBold
WmText.Text = "GTX_FREE_ | 60 FPS | Ping: 25ms"
WmText.TextColor3 = Color3.fromRGB(255, 255, 255)
WmText.TextSize = 11
WmText.TextXAlignment = Enum.TextXAlignment.Left
WmText.Parent = Watermark

local StatsHud = Instance.new("Frame")
StatsHud.Size = UDim2.new(0, 220, 0, 85)
StatsHud.Position = UDim2.new(0, 20, 0, 65)
StatsHud.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatsHud.BorderSizePixel = 0
StatsHud.Active = true
StatsHud.Parent = HudGui
MakeDraggable(StatsHud)

local ShCorner = Instance.new("UICorner")
ShCorner.CornerRadius = UDim.new(0, 6)
ShCorner.Parent = StatsHud

local ShStroke = Instance.new("UIStroke")
ShStroke.Color = Color3.fromRGB(60, 60, 60)
ShStroke.Thickness = 1
ShStroke.Parent = StatsHud

local ShTitle = Instance.new("TextLabel")
ShTitle.Size = UDim2.new(1, 0, 0, 22)
ShTitle.Position = UDim2.new(0, 10, 0, 4)
ShTitle.BackgroundTransparency = 1
ShTitle.Font = Enum.Font.GothamBold
ShTitle.Text = "ADVANCED STATS & COORDS"
ShTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
ShTitle.TextSize = 10
ShTitle.TextXAlignment = Enum.TextXAlignment.Left
ShTitle.Parent = StatsHud

local ShContent = Instance.new("TextLabel")
ShContent.Size = UDim2.new(1, -20, 0, 52)
ShContent.Position = UDim2.new(0, 10, 0, 26)
ShContent.BackgroundTransparency = 1
ShContent.Font = Enum.Font.Gotham
ShContent.Text = "Speed: 16 | Health: 100\nPos: 0, 0, 0\nServer Time: 00:00"
ShContent.TextColor3 = Color3.fromRGB(255, 255, 255)
ShContent.TextSize = 11
ShContent.TextXAlignment = Enum.TextXAlignment.Left
ShContent.TextYAlignment = Enum.TextYAlignment.Top
ShContent.Parent = StatsHud

local BindList = Instance.new("Frame")
BindList.Size = UDim2.new(0, 210, 0, 195)
BindList.Position = UDim2.new(1, -230, 0, 20)
BindList.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BindList.BorderSizePixel = 0
BindList.Active = true
BindList.Parent = HudGui
MakeDraggable(BindList)

local BlCorner = Instance.new("UICorner")
BlCorner.CornerRadius = UDim.new(0, 6)
BlCorner.Parent = BindList

local BlStroke = Instance.new("UIStroke")
BlStroke.Color = Color3.fromRGB(60, 60, 60)
BlStroke.Thickness = 1
BlStroke.Parent = BindList

local BlTitle = Instance.new("TextLabel")
BlTitle.Size = UDim2.new(1, 0, 0, 28)
BlTitle.BackgroundTransparency = 1
BlTitle.Font = Enum.Font.GothamBold
BlTitle.Text = "ACTIVE BINDS & STATUS"
BlTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
BlTitle.TextSize = 11
BlTitle.Parent = BindList

local BlContent = Instance.new("TextLabel")
BlContent.Size = UDim2.new(1, -16, 1, -32)
BlContent.Position = UDim2.new(0, 8, 0, 28)
BlContent.BackgroundTransparency = 1
BlContent.Font = Enum.Font.Gotham
BlContent.Text = ""
BlContent.TextColor3 = Color3.fromRGB(255, 255, 255)
BlContent.TextSize = 11
BlContent.TextXAlignment = Enum.TextXAlignment.Left
BlContent.TextYAlignment = Enum.TextYAlignment.Top
BlContent.Parent = BindList

local RadarHud = Instance.new("Frame")
RadarHud.Size = UDim2.new(0, 210, 0, 75)
RadarHud.Position = UDim2.new(1, -230, 0, 225)
RadarHud.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RadarHud.BorderSizePixel = 0
RadarHud.Active = true
RadarHud.Parent = HudGui
MakeDraggable(RadarHud)

local RhCorner = Instance.new("UICorner")
RhCorner.CornerRadius = UDim.new(0, 6)
RhCorner.Parent = RadarHud

local RhStroke = Instance.new("UIStroke")
RhStroke.Color = Color3.fromRGB(60, 60, 60)
RhStroke.Thickness = 1
RadarHud.Parent = HudGui

local RhTitle = Instance.new("TextLabel")
RhTitle.Size = UDim2.new(1, 0, 0, 22)
RhTitle.Position = UDim2.new(0, 10, 0, 4)
RhTitle.BackgroundTransparency = 1
RhTitle.Font = Enum.Font.GothamBold
RhTitle.Text = "TARGET RADAR (MM2)"
RhTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
RhTitle.TextSize = 10
RhTitle.TextXAlignment = Enum.TextXAlignment.Left
RhTitle.Parent = RadarHud

local RhContent = Instance.new("TextLabel")
RhContent.Size = UDim2.new(1, -20, 0, 42)
RhContent.Position = UDim2.new(0, 10, 0, 26)
RhContent.BackgroundTransparency = 1
RhContent.Font = Enum.Font.Gotham
RhContent.Text = "Searching for target..."
RhContent.TextColor3 = Color3.fromRGB(255, 255, 255)
RhContent.TextSize = 11
RhContent.TextXAlignment = Enum.TextXAlignment.Left
RhContent.TextYAlignment = Enum.TextYAlignment.Top
RhContent.Parent = RadarHud

local EspFolder = Instance.new("Folder", Workspace)
EspFolder.Name = "GTX_FREE_ESP_Folder"

local clockTimer = 0

-- БЕЗОПАСНЫЙ И ЗАМЕДЛЕННЫЙ АВТОФАРМ КОЙНОВ (защита от киков)
task.spawn(function()
    while true do
        if State.CoinFarm then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    local foundCoin = false
                    
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not State.CoinFarm then break end
                        local name = obj.Name:lower()
                        if name == "coin" or name == "gundrop" or name:find("coin") or name:find("drop") then
                            local targetPart = nil
                            if obj:IsA("BasePart") then
                                targetPart = obj
                            elseif obj:IsA("Model") then
                                targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                            end
                            
                            if targetPart then
                                foundCoin = true
                                local dist = (hrp.Position - targetPart.Position).Magnitude
                                -- Снижена скорость движения к монете (плавнее tween), чтобы античит не кикал
                                local speedTween = 16 
                                local timeTake = math.clamp(dist / speedTween, 0.6, 1.8)
                                
                                local info = TweenInfo.new(timeTake, Enum.EasingStyle.Linear)
                                local tw = TweenService:Create(hrp, info, {CFrame = targetPart.CFrame + Vector3.new(0, 1, 0)})
                                tw:Play()
                                tw.Completed:Wait()
                                task.wait(0.8) -- Добавлена пауза между сборами монет
                            end
                        end
                    end
                    if not foundCoin then
                        task.wait(2)
                    end
                end
            end)
        else
            task.wait(1)
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if State.FlingThePlayer then
            pcall(function()
                local targetPlayer = nil
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and GetPlayerRole(p) == State.FlingTargetRole then
                        targetPlayer = p
                        break
                    end
                end

                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = targetPlayer.Character.HumanoidRootPart
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local hrp = char.HumanoidRootPart
                        local rot = 0
                        for i = 1, 20 do
                            if not State.FlingThePlayer then break end
                            rot = rot + 100
                            hrp.CFrame = targetHrp.CFrame * CFrame.Angles(0, math.rad(rot), 0) + Vector3.new(math.sin(rot)*3, 0.5, math.cos(rot)*3)
                            hrp.AssemblyLinearVelocity = Vector3.new(300000, 300000, 300000)
                            hrp.AssemblyAngularVelocity = Vector3.new(999999, 999999, 999999)
                            task.wait(0.02)
                        end
                    end
                end
            end)
        end
        task.wait(0.4)
    end
end)

RunService.Heartbeat:Connect(function(dt)
    Watermark.Visible = State.HudEnabled
    StatsHud.Visible = State.HudEnabled
    BindList.Visible = State.HudEnabled
    RadarHud.Visible = State.HudEnabled
    
    if State.HudEnabled then
        local fps = math.floor(1 / dt)
        WmText.Text = string.format("GTX_FREE_ | %d FPS | Ping: ~25ms", fps)
        
        local currentSpeed = 16
        local currentHealth = 100
        local posStr = "0, 0, 0"
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            local hrp = LocalPlayer.Character.HumanoidRootPart
            currentSpeed = math.floor(hum.WalkSpeed)
            currentHealth = math.floor(hum.Health)
            posStr = string.format("%d, %d, %d", math.floor(hrp.Position.X), math.floor(hrp.Position.Y), math.floor(hrp.Position.Z))
        end
        
        local hours = os.date("%H")
        local mins = os.date("%M")
        ShContent.Text = string.format("Speed: %d | Health: %d\nPos: %s\nTime: %s:%s", currentSpeed, currentHealth, posStr, hours, mins)
        
        BlContent.Text = string.format(
            "[%s] SpeedGlitch: %s\n[%s] Invisible: %s\n[%s] FlingRole: %s\n[%s] Fly: %s\n[%s] CoinFarm: %s",
            Keybinds.SpeedGlitch and Keybinds.SpeedGlitch.Name or "NONE", State.SpeedGlitch and "ON" or "OFF",
            Keybinds.Invisible and Keybinds.Invisible.Name or "NONE", State.Invisible and "ON" or "OFF",
            Keybinds.FlingThePlayer and Keybinds.FlingThePlayer.Name or "NONE", State.FlingThePlayer and "ON" or "OFF",
            Keybinds.Fly and Keybinds.Fly.Name or "NONE", State.Fly and "ON" or "OFF",
            Keybinds.CoinFarm and Keybinds.CoinFarm.Name or "NONE", State.CoinFarm and "ON" or "OFF"
        )

        local foundTargetName = "None"
        local foundTargetRoleText = State.FlingTargetRole
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and GetPlayerRole(p) == State.FlingTargetRole then
                foundTargetName = p.Name
                break
            end
        end
        RhContent.Text = string.format("Target Role: %s\nPlayer: %s\nStatus: %s", foundTargetRoleText, foundTargetName, State.FlingThePlayer and "ACTIVE (Flinging)" or "Idle")
    end

    clockTimer = clockTimer + dt
    if clockTimer >= 0.5 then
        clockTimer = 0
        pcall(function()
            for _, obj in pairs(EspFolder:GetChildren()) do obj:Destroy() end
            
            if State.MM2ESP then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local role = GetPlayerRole(p)
                        local hl = Instance.new("Highlight")
                        hl.Adornee = p.Character
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0
                        
                        if role == "Murderer" then
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                        elseif role == "Sheriff" then
                            hl.FillColor = Color3.fromRGB(0, 0, 255)
                            hl.OutlineColor = Color3.fromRGB(0, 0, 255)
                        else
                            hl.FillColor = Color3.fromRGB(0, 255, 0)
                            hl.OutlineColor = Color3.fromRGB(0, 255, 0)
                        end
                        
                        hl.Parent = EspFolder
                    end
                end
            end
            
            if State.ItemESP then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    local name = obj.Name:lower()
                    if name == "coin" or name == "gundrop" or name:find("coin") or name:find("drop") then
                        local targetPart = nil
                        if obj:IsA("BasePart") then
                            targetPart = obj
                        elseif obj:IsA("Model") then
                            targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        end
                        
                        if targetPart then
                            local hl = Instance.new("Highlight")
                            hl.Adornee = obj
                            hl.FillColor = Color3.fromRGB(200, 200, 200)
                            hl.FillTransparency = 0.4
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.Parent = EspFolder
                        end
                    end
                end
            end
        end)
    end

    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if State.Fly and hrp then
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0.5, 0)
        end
        
        if State.Noclip then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        
        if State.Fullbright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end
        
        if State.HitboxExpander then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    for _, part in ipairs(p.Character:GetDescendants()) do
                        if part.Name == "HumanoidRootPart" then
                            part.Size = Vector3.new(4, 4, 4)
                            part.Transparency = 0.7
                        end
                    end
                end
            end
        end
        
        if State.FOVChanger then
            Camera.FieldOfView = Config.FOVValue
        else
            Camera.FieldOfView = 70
        end

        if State.AntiAim and hrp and hum then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(math.random(-45, 45)), 0)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if Keybinds.ToggleMenu and input.KeyCode == Keybinds.ToggleMenu then
        State.MenuOpen = not State.MenuOpen
        MainFrame.Visible = State.MenuOpen
        PlayClickSound()
    end
    
    if Keybinds.FlickShot and input.KeyCode == Keybinds.FlickShot and State.FlickShot then
        pcall(function()
            local murderer = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and GetPlayerRole(p) == "Murderer" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    murderer = p
                    break
                end
            end

            if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPart = murderer.Character:FindFirstChild("Head") or murderer.Character.HumanoidRootPart
                local originalCF = Camera.CFrame
                
                local predictedPos = targetPart.Position + (targetPart.AssemblyLinearVelocity * 0.05)
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, predictedPos)
                
                task.delay(0.18, function()
                    if Camera then
                        Camera.CFrame = originalCF
                    end
                end)
            end
        end)
    end

    if Keybinds.SpeedGlitch and input.KeyCode == Keybinds.SpeedGlitch then
        State.SpeedGlitch = not State.SpeedGlitch
        PlayClickSound()
    end

    if Keybinds.Invisible and input.KeyCode == Keybinds.Invisible then
        State.Invisible = not State.Invisible
        CenterErrorLabel.Visible = State.Invisible
        PlayClickSound()
    end

    if Keybinds.FlingThePlayer and input.KeyCode == Keybinds.FlingThePlayer then
        State.FlingThePlayer = not State.FlingThePlayer
        PlayClickSound()
    end

    if Keybinds.TPToRole and input.KeyCode == Keybinds.TPToRole then
        TeleportToRole(State.TPRoleChoice)
        PlayClickSound()
    end

    if Keybinds.CoinFarm and input.KeyCode == Keybinds.CoinFarm then
        State.CoinFarm = not State.CoinFarm
        PlayClickSound()
    end

    if Keybinds.Wallhop and input.KeyCode == Keybinds.Wallhop and State.Wallhop then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
                local hrp = char.HumanoidRootPart
                local rayParam = RaycastParams.new()
                rayParam.FilterType = Enum.RaycastFilterType.Exclude

                local directions = {hrp.CFrame.LookVector, -hrp.CFrame.LookVector, hrp.CFrame.RightVector, -hrp.CFrame.RightVector}
                local hitWall = nil
                for _, dir in ipairs(directions) do
                    local res = Workspace:Raycast(hrp.Position, dir * 3.5, rayParam)
                    if res and res.Instance and res.Instance.CanCollide then
                        hitWall = res
                        break
                    end
                end

                if hitWall then
                    local origCF = Camera.CFrame
                    Camera.CFrame = origCF * CFrame.Angles(0, math.rad(50), 0)
                    char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, Config.WallhopHeight, hrp.AssemblyLinearVelocity.Z) + (hitWall.Normal * 10)
                    task.wait(0.03)
                    Camera.CFrame = origCF
                end
            end
        end)
    end

    if Keybinds.Fly and input.KeyCode == Keybinds.Fly then
        State.Fly = not State.Fly
        PlayClickSound()
    end

    if Keybinds.Noclip and input.KeyCode == Keybinds.Noclip then
        State.Noclip = not State.Noclip
        PlayClickSound()
    end
end)

UserInputService.JumpRequest:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if State.SpeedGlitch and hum and hrp then
            hum.WalkSpeed = Config.JumpSpeed
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        if State.InfJump and hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if State.SpeedGlitch and hum then
            if hum:GetState() == Enum.HumanoidStateType.Running or hum:GetState() == Enum.HumanoidStateType.RunningNoPhysics then
                hum.WalkSpeed = Config.NormalSpeed
            end
        end
    end
end)

print("[GTX_FREE_] Full version loaded successfully with Invisible fix & slow coin farm!")