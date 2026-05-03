-- PREMIUM AIMBOT + ESP WITH WINDUI - FINAL VERSION
-- Max Distance + Visible Check + Fly + Animated Loading

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- ANIMATED LOADING SCREEN
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingScreen"
LoadingGui.ResetOnSpawn = false
LoadingGui.IgnoreGuiInset = true
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    LoadingGui.Parent = game:GetService("CoreGui")
end)
if not LoadingGui.Parent then
    LoadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Background
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Parent = LoadingGui
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Background.BorderSizePixel = 0
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundTransparency = 0

-- Gradient
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
Gradient.Rotation = 45
Gradient.Parent = Background

-- Animated gradient
spawn(function()
    while Background.Parent do
        for i = 0, 360, 2 do
            if not Background.Parent then break end
            Gradient.Rotation = i
            wait(0.03)
        end
    end
end)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = Background
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.ClipsDescendants = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 20)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(138, 43, 226)
Stroke.Thickness = 3
Stroke.Transparency = 0
Stroke.Parent = MainFrame

-- Animate stroke color
spawn(function()
    while MainFrame.Parent do
        for i = 0, 1, 0.01 do
            if not MainFrame.Parent then break end
            Stroke.Color = Color3.fromHSV(i, 0.8, 1)
            wait(0.03)
        end
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 30)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ PREMIUM CHEAT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 32
Title.TextTransparency = 1

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 85)
Subtitle.Size = UDim2.new(1, 0, 0, 30)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Loading WindUI..."
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.TextSize = 16
Subtitle.TextTransparency = 1

-- Loading Bar Background
local BarBg = Instance.new("Frame")
BarBg.Name = "BarBg"
BarBg.Parent = MainFrame
BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
BarBg.BorderSizePixel = 0
BarBg.Position = UDim2.new(0.1, 0, 0, 140)
BarBg.Size = UDim2.new(0.8, 0, 0, 8)
BarBg.BackgroundTransparency = 1

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBg

-- Loading Bar
local LoadingBar = Instance.new("Frame")
LoadingBar.Name = "LoadingBar"
LoadingBar.Parent = BarBg
LoadingBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
LoadingBar.BorderSizePixel = 0
LoadingBar.Size = UDim2.new(0, 0, 1, 0)

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(1, 0)
LoadingCorner.Parent = LoadingBar

-- Gradient on loading bar
local BarGradient = Instance.new("UIGradient")
BarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
BarGradient.Parent = LoadingBar

-- Percentage
local Percentage = Instance.new("TextLabel")
Percentage.Name = "Percentage"
Percentage.Parent = MainFrame
Percentage.BackgroundTransparency = 1
Percentage.Position = UDim2.new(0, 0, 0, 160)
Percentage.Size = UDim2.new(1, 0, 0, 30)
Percentage.Font = Enum.Font.GothamBold
Percentage.Text = "0%"
Percentage.TextColor3 = Color3.fromRGB(138, 43, 226)
Percentage.TextSize = 20
Percentage.TextTransparency = 1

-- Status
local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Parent = MainFrame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 0, 0, 200)
Status.Size = UDim2.new(1, 0, 0, 60)
Status.Font = Enum.Font.Gotham
Status.Text = "Initializing..."
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.TextSize = 14
Status.TextTransparency = 1
Status.TextWrapped = true

-- Animate frame opening
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 500, 0, 300)
}):Play()

wait(0.3)

-- Fade in text
TweenService:Create(Title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
TweenService:Create(Subtitle, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
TweenService:Create(BarBg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
TweenService:Create(Percentage, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
TweenService:Create(Status, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

wait(0.5)

-- Loading stages
local stages = {
    {text = "Loading services...", percent = 20},
    {text = "Connecting to WindUI...", percent = 40},
    {text = "Initializing aimbot...", percent = 60},
    {text = "Setting up ESP...", percent = 80},
    {text = "Finalizing...", percent = 100}
}

for _, stage in ipairs(stages) do
    Status.Text = stage.text
    TweenService:Create(LoadingBar, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(stage.percent / 100, 0, 1, 0)
    }):Play()
    
    -- Animate percentage
    for i = tonumber(Percentage.Text:match("%d+")) or 0, stage.percent do
        Percentage.Text = i .. "%"
        wait(0.01)
    end
    
    wait(0.3)
end

-- Load WindUI
Status.Text = "Loading WindUI library..."
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not success or not WindUI then
    Status.Text = "❌ Failed to load WindUI!"
    Status.TextColor3 = Color3.fromRGB(255, 50, 50)
    wait(3)
    LoadingGui:Destroy()
    warn("Failed to load WindUI! Using fallback...")
    return
end

Status.Text = "✓ WindUI loaded successfully!"
Status.TextColor3 = Color3.fromRGB(100, 255, 100)
wait(0.5)

-- Close animation
TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
    Size = UDim2.new(0, 0, 0, 0)
}):Play()

TweenService:Create(Background, TweenInfo.new(0.5), {
    BackgroundTransparency = 1
}):Play()

wait(0.5)
LoadingGui:Destroy()

print("✓ WindUI loaded successfully!")

-- Config
local Config = {
    AimbotEnabled = false,
    AimbotToggleMode = false,
    AimbotActive = false,
    AimbotKey = Enum.KeyCode.E,
    AimAssist = false,
    AimAssistStrength = 0.3,
    ShowFOVCircle = true,
    AimbotFOV = 150,
    AimbotSmooth = 3,
    TeamCheck = false,
    VisibleCheck = true,
    MaxDistance = 500,
    AimPart = "Head",
    PredictMovement = true,
    ESPEnabled = false,
    ESPBox = true,
    ESPSkeleton = true,
    ESPChams = true,
    ESPName = true,
    ESPHealth = true,
    ESPDistance = true,
    ESPTracers = false,
    TracerPosition = "Bottom",
    FlyEnabled = false,
    FlySpeed = 50,
    NoClip = false,
}

local Colors = {
    FOVColor = Color3.fromRGB(138, 43, 226),
    BoxColor = Color3.fromRGB(138, 43, 226),
    SkeletonColor = Color3.fromRGB(138, 43, 226),
    ChamsColor = Color3.fromRGB(138, 43, 226),
    TracerColor = Color3.fromRGB(138, 43, 226)
}

local ESPObjects = {}
local FOVCircle
local Connections = {}
local MenuToggleKey = Enum.KeyCode.Insert
local FlyConnection
local BodyVelocity

-- FOV Circle
if Drawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 2
    FOVCircle.NumSides = 64
    FOVCircle.Radius = Config.AimbotFOV
    FOVCircle.Filled = false
    FOVCircle.Visible = false
    FOVCircle.ZIndex = 999
    FOVCircle.Transparency = 1
    FOVCircle.Color = Colors.FOVColor
end

-- Create Window
local Window = WindUI:CreateWindow({
    Title = "⚡ Premium Aimbot + ESP",
    Icon = "solar:folder-2-bold-duotone",
    Folder = "PremiumCheat",
    NewElements = true
})

-- Create Tabs
local AimbotTab = Window:Tab({Title = "Aimbot", Icon = "solar:target-bold"})
local ESPTab = Window:Tab({Title = "ESP", Icon = "solar:eye-bold"})
local MiscTab = Window:Tab({Title = "Misc (RISKY)", Icon = "solar:danger-bold"})
local ConfigTab = Window:Tab({Title = "Config", Icon = "solar:settings-bold"})

-- Menu Toggle
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == MenuToggleKey then
        Window:Toggle()
    end
end)

-- AIMBOT TAB
AimbotTab:Toggle({
    Title = "Enable Aimbot",
    Value = false,
    Callback = function(v)
        Config.AimbotEnabled = v
        if v then
            WindUI:Notify({
                Title = "🎯 Aimbot Enabled",
                Content = "Hold " .. Config.AimbotKey.Name:upper() .. " to lock on target",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Aimbot Disabled",
                Content = "Aimbot turned off",
                Duration = 2
            })
        end
    end
})

AimbotTab:Toggle({
    Title = "Toggle Mode (Press key to toggle)",
    Value = false,
    Callback = function(v)
        Config.AimbotToggleMode = v
        if v then
            WindUI:Notify({
                Title = "🔄 Toggle Mode Enabled",
                Content = "Press " .. Config.AimbotKey.Name:upper() .. " to toggle aimbot ON/OFF",
                Duration = 3
            })
        else
            Config.AimbotActive = false
            WindUI:Notify({
                Title = "Toggle Mode Disabled",
                Content = "Hold " .. Config.AimbotKey.Name:upper() .. " to use aimbot",
                Duration = 3
            })
        end
    end
})

AimbotTab:Toggle({
    Title = "Aim Assist (Sticky Aim)",
    Value = false,
    Callback = function(v)
        Config.AimAssist = v
        if v then
            WindUI:Notify({
                Title = "🎯 Aim Assist Enabled",
                Content = "Your aim will stick to targets automatically",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Aim Assist Disabled",
                Content = "Sticky aim turned off",
                Duration = 2
            })
        end
    end
})

AimbotTab:Slider({
    Title = "Aim Assist Strength",
    Step = 1,
    Value = {Min = 1, Max = 100, Default = 30},
    Callback = function(v)
        Config.AimAssistStrength = v / 100
    end
})

AimbotTab:Toggle({
    Title = "Show FOV Circle",
    Value = true,
    Callback = function(v)
        Config.ShowFOVCircle = v
    end
})

AimbotTab:Slider({
    Title = "FOV Size",
    Step = 5,
    Value = {Min = 50, Max = 300, Default = 150},
    Callback = function(v)
        Config.AimbotFOV = v
        if FOVCircle then
            FOVCircle.Radius = v
        end
    end
})

AimbotTab:Slider({
    Title = "Smoothness",
    Step = 1,
    Value = {Min = 1, Max = 20, Default = 3},
    Callback = function(v)
        Config.AimbotSmooth = v
    end
})

AimbotTab:Slider({
    Title = "Max Distance (studs)",
    Step = 50,
    Value = {Min = 100, Max = 2000, Default = 500},
    Callback = function(v)
        Config.MaxDistance = v
    end
})

AimbotTab:Dropdown({
    Title = "Aim Part",
    Values = {"Head", "Torso", "HumanoidRootPart"},
    Value = "Head",
    Callback = function(v)
        Config.AimPart = v
    end
})

AimbotTab:Toggle({
    Title = "Team Check",
    Value = false,
    Callback = function(v)
        Config.TeamCheck = v
    end
})

AimbotTab:Toggle({
    Title = "Visible Check (Wall Check)",
    Value = true,
    Callback = function(v)
        Config.VisibleCheck = v
    end
})

AimbotTab:Toggle({
    Title = "Movement Prediction",
    Value = true,
    Callback = function(v)
        Config.PredictMovement = v
    end
})

AimbotTab:Button({
    Title = "Change Aimbot Key: " .. Config.AimbotKey.Name:upper(),
    Desc = "Click to change aimbot activation key",
    Callback = function()
        WindUI:Notify({
            Title = "Change Key",
            Content = "Press any key...",
            Duration = 3
        })
        local conn
        conn = UserInputService.InputBegan:Connect(function(input, gp)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Config.AimbotKey = input.KeyCode
                WindUI:Notify({
                    Title = "Key Changed",
                    Content = "New key: " .. input.KeyCode.Name:upper(),
                    Duration = 2
                })
                if conn then conn:Disconnect() end
            end
        end)
    end
})

-- Aimbot Toggle Key Handler
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Config.AimbotKey and Config.AimbotEnabled and Config.AimbotToggleMode then
        Config.AimbotActive = not Config.AimbotActive
        if Config.AimbotActive then
            WindUI:Notify({
                Title = "🎯 Aimbot ON",
                Content = "Aimbot is now active!",
                Duration = 2
            })
        else
            WindUI:Notify({
                Title = "Aimbot OFF",
                Content = "Aimbot is now inactive",
                Duration = 2
            })
        end
    end
end)

-- ESP TAB
ESPTab:Toggle({
    Title = "Enable ESP",
    Value = false,
    Callback = function(v)
        Config.ESPEnabled = v
        if v then
            WindUI:Notify({
                Title = "👁️ ESP Enabled",
                Content = "You can now see all players!",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "ESP Disabled",
                Content = "ESP turned off",
                Duration = 2
            })
        end
        if not v then
            for _, esp in pairs(ESPObjects) do
                pcall(function()
                    if esp.UpdateConnection then esp.UpdateConnection:Disconnect() end
                    if esp.Folder then esp.Folder:Destroy() end
                    if esp.Skeleton then
                        for _, l in pairs(esp.Skeleton) do
                            if l and l.Line then l.Line:Remove() end
                        end
                    end
                    if esp.Box then
                        for _, l in pairs(esp.Box) do
                            if l and l.Line then l.Line:Remove() end
                        end
                    end
                    if esp.Tracer then esp.Tracer:Remove() end
                end)
            end
            ESPObjects = {}
        end
    end
})

ESPTab:Toggle({
    Title = "ESP Box",
    Value = true,
    Callback = function(v)
        Config.ESPBox = v
    end
})

ESPTab:Toggle({
    Title = "ESP Skeleton",
    Value = true,
    Callback = function(v)
        Config.ESPSkeleton = v
    end
})

ESPTab:Toggle({
    Title = "ESP Chams (Highlight)",
    Value = true,
    Callback = function(v)
        Config.ESPChams = v
    end
})

ESPTab:Toggle({
    Title = "ESP Name",
    Value = true,
    Callback = function(v)
        Config.ESPName = v
    end
})

ESPTab:Toggle({
    Title = "ESP Health",
    Value = true,
    Callback = function(v)
        Config.ESPHealth = v
    end
})

ESPTab:Toggle({
    Title = "ESP Distance",
    Value = true,
    Callback = function(v)
        Config.ESPDistance = v
    end
})

ESPTab:Toggle({
    Title = "ESP Tracers",
    Value = false,
    Callback = function(v)
        Config.ESPTracers = v
    end
})

ESPTab:Dropdown({
    Title = "Tracer Position",
    Values = {"Top", "Bottom", "Cursor"},
    Value = "Bottom",
    Callback = function(v)
        Config.TracerPosition = v
    end
})

-- MISC TAB (RISKY)
MiscTab:Toggle({
    Title = "⚠️ FLY (RISKY)",
    Value = false,
    Callback = function(v)
        Config.FlyEnabled = v
        
        if v then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                
                BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                BodyVelocity.Parent = hrp
                
                FlyConnection = RunService.Heartbeat:Connect(function()
                    if not Config.FlyEnabled or not char or not char.Parent or not hrp.Parent then
                        if FlyConnection then FlyConnection:Disconnect() end
                        if BodyVelocity then BodyVelocity:Destroy() end
                        return
                    end
                    
                    local velocity = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        velocity = velocity + (Camera.CFrame.LookVector * Config.FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        velocity = velocity - (Camera.CFrame.LookVector * Config.FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        velocity = velocity - (Camera.CFrame.RightVector * Config.FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        velocity = velocity + (Camera.CFrame.RightVector * Config.FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        velocity = velocity + Vector3.new(0, Config.FlySpeed, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        velocity = velocity - Vector3.new(0, Config.FlySpeed, 0)
                    end
                    
                    BodyVelocity.Velocity = velocity
                end)
                
                WindUI:Notify({
                    Title = "Fly Enabled",
                    Content = "WASD to move, Space/Shift for up/down",
                    Duration = 5
                })
            end
        else
            if FlyConnection then
                FlyConnection:Disconnect()
                FlyConnection = nil
            end
            if BodyVelocity then
                BodyVelocity:Destroy()
                BodyVelocity = nil
            end
            WindUI:Notify({
                Title = "Fly Disabled",
                Content = "Fly mode turned off",
                Duration = 3
            })
        end
    end
})

MiscTab:Slider({
    Title = "Fly Speed",
    Step = 5,
    Value = {Min = 10, Max = 200, Default = 50},
    Callback = function(v)
        Config.FlySpeed = v
    end
})

MiscTab:Toggle({
    Title = "⚠️ NoClip (RISKY)",
    Value = false,
    Callback = function(v)
        Config.NoClip = v
        
        if v then
            WindUI:Notify({
                Title = "NoClip Enabled",
                Content = "Walk through walls!",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "NoClip Disabled",
                Content = "NoClip turned off",
                Duration = 3
            })
        end
    end
})

MiscTab:Button({
    Title = "⚠️ WARNING",
    Desc = "Fly and NoClip are VERY RISKY and can get you banned!",
    Callback = function()
        WindUI:Notify({
            Title = "⚠️ RISK WARNING",
            Content = "Use Fly/NoClip at your own risk! High ban chance!",
            Duration = 5
        })
    end
})

-- CONFIG TAB
ConfigTab:Button({
    Title = "Menu Toggle Key: " .. MenuToggleKey.Name:upper(),
    Desc = "Press to change menu open/close key",
    Callback = function()
        WindUI:Notify({
            Title = "Change Menu Key",
            Content = "Press any key...",
            Duration = 3
        })
        local conn
        conn = UserInputService.InputBegan:Connect(function(input, gp)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                MenuToggleKey = input.KeyCode
                WindUI:Notify({
                    Title = "Menu Key Changed",
                    Content = "New key: " .. input.KeyCode.Name:upper(),
                    Duration = 2
                })
                if conn then conn:Disconnect() end
            end
        end)
    end
})

ConfigTab:Colorpicker({
    Title = "FOV Color",
    Default = Color3.fromRGB(138, 43, 226),
    Callback = function(c)
        Colors.FOVColor = c
        if FOVCircle then FOVCircle.Color = c end
    end
})

ConfigTab:Colorpicker({
    Title = "Box Color",
    Default = Color3.fromRGB(138, 43, 226),
    Callback = function(c)
        Colors.BoxColor = c
    end
})

ConfigTab:Colorpicker({
    Title = "Skeleton Color",
    Default = Color3.fromRGB(138, 43, 226),
    Callback = function(c)
        Colors.SkeletonColor = c
    end
})

ConfigTab:Colorpicker({
    Title = "Chams Color",
    Default = Color3.fromRGB(138, 43, 226),
    Callback = function(c)
        Colors.ChamsColor = c
    end
})

ConfigTab:Colorpicker({
    Title = "Tracer Color",
    Default = Color3.fromRGB(138, 43, 226),
    Callback = function(c)
        Colors.TracerColor = c
    end
})

-- Helper Functions
local function IsRealPlayer(plr)
    if not Players:FindFirstChild(plr.Name) then return false end
    if plr.UserId <= 0 then return false end
    if not plr:IsA("Player") then return false end
    return true
end

local function GetClosest()
    local closest, shortestDist = nil, Config.AimbotFOV
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            local aimPart = char:FindFirstChild(Config.AimPart)
            
            if hum and hum.Health > 0 and root and aimPart then
                -- Team Check
                if Config.TeamCheck and plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Distance Check
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    if distance > Config.MaxDistance then
                        continue
                    end
                end
                
                local targetPos = aimPart.Position
                
                -- Movement Prediction
                if Config.PredictMovement then
                    local vel = root.AssemblyLinearVelocity or root.Velocity or Vector3.new(0, 0, 0)
                    local dist = (Camera.CFrame.Position - targetPos).Magnitude
                    targetPos = targetPos + (vel * (dist / 1000))
                end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
                if onScreen then
                    -- Visible Check (Wall Check)
                    if Config.VisibleCheck then
                        local ray = Ray.new(Camera.CFrame.Position, (aimPart.Position - Camera.CFrame.Position).Unit * 1000)
                        local part = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
                        if part and not char:IsAncestorOf(part) then
                            continue
                        end
                    end
                    
                    local mousePos = UserInputService:GetMouseLocation()
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    if dist < shortestDist then
                        closest = plr
                        shortestDist = dist
                    end
                end
            end
        end
    end
    
    return closest
end

-- ESP Function
local function CreateESP(plr)
    if plr == LocalPlayer or not plr.Character or not IsRealPlayer(plr) then return end
    
    local char = plr.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if not root or not hum then return end
    
    -- Clean old ESP
    if ESPObjects[plr.Name] then
        pcall(function()
            if ESPObjects[plr.Name].UpdateConnection then
                ESPObjects[plr.Name].UpdateConnection:Disconnect()
            end
            if ESPObjects[plr.Name].Folder then
                ESPObjects[plr.Name].Folder:Destroy()
            end
            if ESPObjects[plr.Name].Skeleton then
                for _, l in pairs(ESPObjects[plr.Name].Skeleton) do
                    if l and l.Line then l.Line:Remove() end
                end
            end
            if ESPObjects[plr.Name].Box then
                for _, l in pairs(ESPObjects[plr.Name].Box) do
                    if l and l.Line then l.Line:Remove() end
                end
            end
            if ESPObjects[plr.Name].Tracer then
                ESPObjects[plr.Name].Tracer:Remove()
            end
        end)
    end
    
    ESPObjects[plr.Name] = {Skeleton = {}, Box = {}}
    
    -- Create folder
    local folder = Instance.new("Folder", char)
    folder.Name = "ESP_" .. plr.Name
    ESPObjects[plr.Name].Folder = folder
    
    -- Highlight (Chams)
    local highlight
    pcall(function()
        highlight = Instance.new("Highlight", folder)
        highlight.Adornee = char
        highlight.FillColor = Colors.ChamsColor
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    end)
    ESPObjects[plr.Name].Highlight = highlight
    
    -- Billboard (Name, Health, Distance)
    local bb = Instance.new("BillboardGui", folder)
    bb.Adornee = root
    bb.Size = UDim2.new(0, 200, 0, 100)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    
    local txt = Instance.new("TextLabel", bb)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 15
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.TextStrokeTransparency = 0
    txt.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Box ESP
    if Drawing then
        pcall(function()
            for i = 1, 4 do
                local line = Drawing.new("Line")
                line.Thickness = 2
                line.Color = Colors.BoxColor
                line.Transparency = 1
                line.Visible = false
                line.ZIndex = 2
                table.insert(ESPObjects[plr.Name].Box, {Line = line})
            end
        end)
    end
    
    -- Skeleton ESP
    if Drawing then
        pcall(function()
            local conns = {
                {"Head", "UpperTorso"},
                {"UpperTorso", "LowerTorso"},
                {"UpperTorso", "LeftUpperArm"},
                {"LeftUpperArm", "LeftLowerArm"},
                {"UpperTorso", "RightUpperArm"},
                {"RightUpperArm", "RightLowerArm"},
                {"LowerTorso", "LeftUpperLeg"},
                {"LeftUpperLeg", "LeftLowerLeg"},
                {"LowerTorso", "RightUpperLeg"},
                {"RightUpperLeg", "RightLowerLeg"}
            }
            
            local r6Conns = {
                {"Head", "Torso"},
                {"Torso", "Left Arm"},
                {"Torso", "Right Arm"},
                {"Torso", "Left Leg"},
                {"Torso", "Right Leg"}
            }
            
            local isR15 = char:FindFirstChild("UpperTorso") ~= nil
            local useConns = isR15 and conns or r6Conns
            
            for _, c in pairs(useConns) do
                local p1 = char:FindFirstChild(c[1])
                local p2 = char:FindFirstChild(c[2])
                if p1 and p2 then
                    local line = Drawing.new("Line")
                    line.Thickness = 2
                    line.Color = Colors.SkeletonColor
                    line.Transparency = 1
                    line.Visible = false
                    line.ZIndex = 2
                    table.insert(ESPObjects[plr.Name].Skeleton, {Line = line, Part1 = p1, Part2 = p2})
                end
            end
        end)
    end
    
    -- Tracer
    local tracer
    if Drawing then
        pcall(function()
            tracer = Drawing.new("Line")
            tracer.Thickness = 2
            tracer.Color = Colors.TracerColor
            tracer.Transparency = 0.7
            tracer.Visible = false
            tracer.ZIndex = 1
        end)
    end
    ESPObjects[plr.Name].Tracer = tracer
    
    -- Update Loop
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not Config.ESPEnabled or not folder.Parent or not plr.Character or not char.Parent then
            if conn then conn:Disconnect() end
            return
        end
        
        pcall(function()
            -- Update Highlight
            if highlight then
                highlight.Enabled = Config.ESPChams
                highlight.FillColor = Colors.ChamsColor
            end
            
            -- Update Billboard Text
            bb.Enabled = Config.ESPName or Config.ESPHealth or Config.ESPDistance
            local text = ""
            
            if Config.ESPName then
                text = text .. plr.Name .. "\n"
            end
            
            if Config.ESPHealth and hum then
                local hp = math.floor(hum.Health)
                local maxHp = math.floor(hum.MaxHealth)
                local pct = math.floor((hp / maxHp) * 100)
                text = text .. "HP: " .. hp .. " (" .. pct .. "%)\n"
                
                if pct > 75 then
                    txt.TextColor3 = Color3.fromRGB(100, 255, 100)
                elseif pct > 50 then
                    txt.TextColor3 = Color3.fromRGB(255, 255, 100)
                else
                    txt.TextColor3 = Color3.fromRGB(255, 50, 50)
                end
            else
                txt.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
            
            if Config.ESPDistance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                text = text .. math.floor(dist) .. "m"
            end
            
            txt.Text = text

            -- Update Box
            if ESPObjects[plr.Name].Box and #ESPObjects[plr.Name].Box > 0 and Config.ESPBox then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")
                
                if hrp and head then
                    local headPos = head.Position + Vector3.new(0, head.Size.Y / 2, 0)
                    local rootPos = hrp.Position
                    local legOffset = Vector3.new(0, -2.5, 0)
                    
                    local topPos, topVis = Camera:WorldToViewportPoint(headPos)
                    local bottomPos, bottomVis = Camera:WorldToViewportPoint(rootPos + legOffset)
                    local centerPos, centerVis = Camera:WorldToViewportPoint(rootPos)
                    
                    if (topVis or bottomVis or centerVis) and topPos.Z > 0 then
                        local height = math.abs(topPos.Y - bottomPos.Y)
                        local width = height / 2
                        
                        local centerX = centerPos.X
                        local topY = topPos.Y
                        local bottomY = bottomPos.Y
                        
                        local minX = centerX - width / 2
                        local maxX = centerX + width / 2
                        local minY = topY
                        local maxY = bottomY
                        
                        local topLeft = Vector2.new(minX, minY)
                        local topRight = Vector2.new(maxX, minY)
                        local bottomLeft = Vector2.new(minX, maxY)
                        local bottomRight = Vector2.new(maxX, maxY)
                        
                        for i = 1, 4 do
                            local lineData = ESPObjects[plr.Name].Box[i]
                            if lineData and lineData.Line then
                                if i == 1 then
                                    lineData.Line.From = topLeft
                                    lineData.Line.To = topRight
                                elseif i == 2 then
                                    lineData.Line.From = topRight
                                    lineData.Line.To = bottomRight
                                elseif i == 3 then
                                    lineData.Line.From = bottomRight
                                    lineData.Line.To = bottomLeft
                                elseif i == 4 then
                                    lineData.Line.From = bottomLeft
                                    lineData.Line.To = topLeft
                                end
                                lineData.Line.Color = Colors.BoxColor
                                lineData.Line.Visible = true
                            end
                        end
                    else
                        for _, lineData in pairs(ESPObjects[plr.Name].Box) do
                            if lineData and lineData.Line then
                                lineData.Line.Visible = false
                            end
                        end
                    end
                else
                    for _, lineData in pairs(ESPObjects[plr.Name].Box) do
                        if lineData and lineData.Line then
                            lineData.Line.Visible = false
                        end
                    end
                end
            else
                if ESPObjects[plr.Name].Box then
                    for _, lineData in pairs(ESPObjects[plr.Name].Box) do
                        if lineData and lineData.Line then
                            lineData.Line.Visible = false
                        end
                    end
                end
            end
            
            -- Update Skeleton
            if ESPObjects[plr.Name].Skeleton then
                for _, ld in pairs(ESPObjects[plr.Name].Skeleton) do
                    if ld and ld.Line and ld.Part1 and ld.Part2 and ld.Part1.Parent and ld.Part2.Parent then
                        if Config.ESPSkeleton then
                            local pos1, on1 = Camera:WorldToViewportPoint(ld.Part1.Position)
                            local pos2, on2 = Camera:WorldToViewportPoint(ld.Part2.Position)
                            
                            if on1 and on2 then
                                ld.Line.From = Vector2.new(pos1.X, pos1.Y)
                                ld.Line.To = Vector2.new(pos2.X, pos2.Y)
                                ld.Line.Color = Colors.SkeletonColor
                                ld.Line.Visible = true
                            else
                                ld.Line.Visible = false
                            end
                        else
                            ld.Line.Visible = false
                        end
                    end
                end
            end
            
            -- Update Tracer
            if tracer and root.Parent then
                if Config.ESPTracers then
                    local sp, on = Camera:WorldToViewportPoint(root.Position)
                    if on then
                        local ss = Camera.ViewportSize
                        local fromPos
                        
                        if Config.TracerPosition == "Top" then
                            fromPos = Vector2.new(ss.X / 2, 0)
                        elseif Config.TracerPosition == "Cursor" then
                            fromPos = UserInputService:GetMouseLocation()
                        else
                            fromPos = Vector2.new(ss.X / 2, ss.Y)
                        end
                        
                        tracer.From = fromPos
                        tracer.To = Vector2.new(sp.X, sp.Y)
                        tracer.Color = Colors.TracerColor
                        tracer.Visible = true
                    else
                        tracer.Visible = false
                    end
                else
                    tracer.Visible = false
                end
            end
        end)
    end)
    
    ESPObjects[plr.Name].UpdateConnection = conn
end

-- NoClip Function
RunService.Stepped:Connect(function()
    if Config.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Main Loops
table.insert(Connections, RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if FOVCircle then
        local mp = UserInputService:GetMouseLocation()
        FOVCircle.Position = mp
        
        local showCircle = Config.ShowFOVCircle and (Config.AimbotEnabled or Config.AimAssist)
        if Config.AimbotToggleMode and Config.AimbotEnabled then
            showCircle = showCircle and Config.AimbotActive
        end
        
        FOVCircle.Visible = showCircle
        FOVCircle.Radius = Config.AimbotFOV
        
        -- Change color based on aimbot state
        if Config.AimbotToggleMode and Config.AimbotActive then
            FOVCircle.Color = Color3.fromRGB(100, 255, 100)
        else
            FOVCircle.Color = Colors.FOVColor
        end
    end
    
    local target = GetClosest()
    
    -- Aim Assist (Sticky Aim)
    if Config.AimAssist and target and target.Character then
        local aimPart = target.Character:FindFirstChild(Config.AimPart)
        if aimPart then
            local tp = aimPart.Position
            
            if Config.PredictMovement then
                local rt = target.Character:FindFirstChild("HumanoidRootPart")
                if rt then
                    local vel = rt.AssemblyLinearVelocity or rt.Velocity or Vector3.new(0, 0, 0)
                    local dist = (Camera.CFrame.Position - tp).Magnitude
                    tp = tp + (vel * (dist / 1000))
                end
            end
            
            local aimPos, on = Camera:WorldToViewportPoint(tp)
            if on then
                local mp = UserInputService:GetMouseLocation()
                mousemoverel(
                    (aimPos.X - mp.X) * Config.AimAssistStrength,
                    (aimPos.Y - mp.Y) * Config.AimAssistStrength
                )
            end
        end
    end
    
    -- Aimbot (Hold Key or Toggle)
    local shouldAim = false
    if Config.AimbotEnabled then
        if Config.AimbotToggleMode then
            shouldAim = Config.AimbotActive
        else
            shouldAim = UserInputService:IsKeyDown(Config.AimbotKey)
        end
    end
    
    if shouldAim and target and target.Character then
        local aimPart = target.Character:FindFirstChild(Config.AimPart)
        if aimPart then
            local tp = aimPart.Position
            
            if Config.PredictMovement then
                local rt = target.Character:FindFirstChild("HumanoidRootPart")
                if rt then
                    local vel = rt.AssemblyLinearVelocity or rt.Velocity or Vector3.new(0, 0, 0)
                    local dist = (Camera.CFrame.Position - tp).Magnitude
                    tp = tp + (vel * (dist / 1000))
                end
            end
            
            local aimPos, on = Camera:WorldToViewportPoint(tp)
            if on then
                local mp = UserInputService:GetMouseLocation()
                mousemoverel(
                    (aimPos.X - mp.X) / Config.AimbotSmooth,
                    (aimPos.Y - mp.Y) / Config.AimbotSmooth
                )
            end
        end
    end
end))

-- ESP Update Loop
table.insert(Connections, RunService.Heartbeat:Connect(function()
    if Config.ESPEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and IsRealPlayer(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not ESPObjects[plr.Name] or not ESPObjects[plr.Name].Folder or not ESPObjects[plr.Name].Folder.Parent then
                    pcall(function()
                        CreateESP(plr)
                    end)
                end
            end
        end
    end
end))

-- Player Events
Players.PlayerAdded:Connect(function(plr)
    if IsRealPlayer(plr) then
        plr.CharacterAdded:Connect(function()
            wait(0.5)
            if Config.ESPEnabled then
                CreateESP(plr)
            end
        end)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if ESPObjects[plr.Name] then
        pcall(function()
            if ESPObjects[plr.Name].UpdateConnection then
                ESPObjects[plr.Name].UpdateConnection:Disconnect()
            end
            if ESPObjects[plr.Name].Folder then
                ESPObjects[plr.Name].Folder:Destroy()
            end
            if ESPObjects[plr.Name].Skeleton then
                for _, l in pairs(ESPObjects[plr.Name].Skeleton) do
                    if l and l.Line then l.Line:Remove() end
                end
            end
            if ESPObjects[plr.Name].Box then
                for _, l in pairs(ESPObjects[plr.Name].Box) do
                    if l and l.Line then l.Line:Remove() end
                end
            end
            if ESPObjects[plr.Name].Tracer then
                ESPObjects[plr.Name].Tracer:Remove()
            end
        end)
        ESPObjects[plr.Name] = nil
    end
end)

-- Success Notification with animation
local NotifFrame = Instance.new("Frame")
NotifFrame.Name = "SuccessNotif"
NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
NotifFrame.BorderSizePixel = 0
NotifFrame.Position = UDim2.new(1, 10, 0.9, 0)
NotifFrame.Size = UDim2.new(0, 350, 0, 100)

local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "SuccessNotification"
NotifGui.ResetOnSpawn = false
NotifGui.IgnoreGuiInset = true
pcall(function() NotifGui.Parent = game:GetService("CoreGui") end)
if not NotifGui.Parent then NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

NotifFrame.Parent = NotifGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 15)
NotifCorner.Parent = NotifFrame

local NotifStroke = Instance.new("UIStroke")
NotifStroke.Color = Color3.fromRGB(100, 255, 100)
NotifStroke.Thickness = 2
NotifStroke.Parent = NotifFrame

local NotifTitle = Instance.new("TextLabel")
NotifTitle.Parent = NotifFrame
NotifTitle.BackgroundTransparency = 1
NotifTitle.Position = UDim2.new(0, 15, 0, 10)
NotifTitle.Size = UDim2.new(1, -30, 0, 30)
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.Text = "✓ CHEAT LOADED!"
NotifTitle.TextColor3 = Color3.fromRGB(100, 255, 100)
NotifTitle.TextSize = 20
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

local NotifText = Instance.new("TextLabel")
NotifText.Parent = NotifFrame
NotifText.BackgroundTransparency = 1
NotifText.Position = UDim2.new(0, 15, 0, 45)
NotifText.Size = UDim2.new(1, -30, 0, 45)
NotifText.Font = Enum.Font.Gotham
NotifText.Text = "Press " .. MenuToggleKey.Name:upper() .. " to open menu\nAll features ready!"
NotifText.TextColor3 = Color3.fromRGB(200, 200, 200)
NotifText.TextSize = 14
NotifText.TextXAlignment = Enum.TextXAlignment.Left
NotifText.TextYAlignment = Enum.TextYAlignment.Top
NotifText.TextWrapped = true

-- Slide in animation
TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -360, 0.9, 0)
}):Play()

-- Pulse animation
spawn(function()
    for i = 1, 3 do
        TweenService:Create(NotifStroke, TweenInfo.new(0.5), {Thickness = 4}):Play()
        wait(0.5)
        TweenService:Create(NotifStroke, TweenInfo.new(0.5), {Thickness = 2}):Play()
        wait(0.5)
    end
end)

-- Auto close after 5 seconds
wait(5)
TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
    Position = UDim2.new(1, 10, 0.9, 0)
}):Play()
wait(0.3)
NotifGui:Destroy()

-- CREATE DYNAMIC HUD
local HudGui = Instance.new("ScreenGui")
HudGui.Name = "DynamicHUD"
HudGui.ResetOnSpawn = false
HudGui.IgnoreGuiInset = true
HudGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() HudGui.Parent = game:GetService("CoreGui") end)
if not HudGui.Parent then HudGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- HUD Frame
local HudFrame = Instance.new("Frame")
HudFrame.Name = "HudFrame"
HudFrame.Parent = HudGui
HudFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
HudFrame.BackgroundTransparency = 0.3
HudFrame.BorderSizePixel = 0
HudFrame.Position = UDim2.new(0, 10, 0, 10)
HudFrame.Size = UDim2.new(0, 250, 0, 0)
HudFrame.ClipsDescendants = true

local HudCorner = Instance.new("UICorner")
HudCorner.CornerRadius = UDim.new(0, 12)
HudCorner.Parent = HudFrame

local HudStroke = Instance.new("UIStroke")
HudStroke.Color = Color3.fromRGB(138, 43, 226)
HudStroke.Thickness = 2
HudStroke.Transparency = 0.5
HudStroke.Parent = HudFrame

-- Animate HUD stroke
spawn(function()
    while HudStroke.Parent do
        for i = 0, 1, 0.01 do
            if not HudStroke.Parent then break end
            HudStroke.Color = Color3.fromHSV(i, 0.8, 1)
            wait(0.05)
        end
    end
end)

-- HUD Title
local HudTitle = Instance.new("TextLabel")
HudTitle.Parent = HudFrame
HudTitle.BackgroundTransparency = 1
HudTitle.Position = UDim2.new(0, 10, 0, 5)
HudTitle.Size = UDim2.new(1, -20, 0, 25)
HudTitle.Font = Enum.Font.GothamBold
HudTitle.Text = "⚡ PREMIUM CHEAT"
HudTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HudTitle.TextSize = 16
HudTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Status indicators
local StatusContainer = Instance.new("Frame")
StatusContainer.Parent = HudFrame
StatusContainer.BackgroundTransparency = 1
StatusContainer.Position = UDim2.new(0, 10, 0, 35)
StatusContainer.Size = UDim2.new(1, -20, 1, -40)

local function createStatusLine(text, yPos)
    local Line = Instance.new("TextLabel")
    Line.Parent = StatusContainer
    Line.BackgroundTransparency = 1
    Line.Position = UDim2.new(0, 0, 0, yPos)
    Line.Size = UDim2.new(1, 0, 0, 20)
    Line.Font = Enum.Font.Gotham
    Line.Text = text
    Line.TextColor3 = Color3.fromRGB(150, 150, 150)
    Line.TextSize = 12
    Line.TextXAlignment = Enum.TextXAlignment.Left
    return Line
end

local AimbotStatus = createStatusLine("🎯 Aimbot: OFF", 0)
local ESPStatus = createStatusLine("👁️ ESP: OFF", 25)
local FlyStatus = createStatusLine("⚡ Fly: OFF", 50)
local TargetStatus = createStatusLine("🎯 Target: None", 75)
local FPSStatus = createStatusLine("📊 FPS: 0", 100)

-- Animate HUD opening
TweenService:Create(HudFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 250, 0, 135)
}):Play()

-- Update HUD in real-time
spawn(function()
    while HudFrame.Parent do
        -- Aimbot status
        if Config.AimbotEnabled then
            if Config.AimbotToggleMode then
                if Config.AimbotActive then
                    AimbotStatus.Text = "🎯 Aimbot: ON (ACTIVE)"
                    AimbotStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                else
                    AimbotStatus.Text = "🎯 Aimbot: ON (READY)"
                    AimbotStatus.TextColor3 = Color3.fromRGB(255, 255, 100)
                end
            else
                AimbotStatus.Text = "🎯 Aimbot: ON (HOLD)"
                AimbotStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
        else
            AimbotStatus.Text = "🎯 Aimbot: OFF"
            AimbotStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        -- ESP status
        if Config.ESPEnabled then
            local count = 0
            for _ in pairs(ESPObjects) do count = count + 1 end
            ESPStatus.Text = "👁️ ESP: ON (" .. count .. " players)"
            ESPStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            ESPStatus.Text = "👁️ ESP: OFF"
            ESPStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        -- Fly status
        if Config.FlyEnabled then
            FlyStatus.Text = "⚡ Fly: ON (" .. Config.FlySpeed .. " speed)"
            FlyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            FlyStatus.Text = "⚡ Fly: OFF"
            FlyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        -- Target status
        local target = GetClosest()
        if target and Config.AimbotEnabled then
            local dist = 0
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude)
            end
            TargetStatus.Text = "🎯 Target: " .. target.Name .. " (" .. dist .. "m)"
            TargetStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            TargetStatus.Text = "🎯 Target: None"
            TargetStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        -- FPS
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        FPSStatus.Text = "📊 FPS: " .. fps
        if fps >= 50 then
            FPSStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif fps >= 30 then
            FPSStatus.TextColor3 = Color3.fromRGB(255, 255, 100)
        else
            FPSStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        
        wait(0.1)
    end
end)

WindUI:Notify({
    Title = "Premium Cheat Ready!",
    Content = "Press " .. MenuToggleKey.Name:upper() .. " to toggle menu",
    Duration = 5
})

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✓ PREMIUM CHEAT WITH WINDUI LOADED!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("Menu Toggle: " .. MenuToggleKey.Name:upper())
print("Aimbot Key: " .. Config.AimbotKey.Name:upper())
print("Max Distance: " .. Config.MaxDistance .. " studs")
print("⚠️ FLY AND NOCLIP ARE RISKY!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
