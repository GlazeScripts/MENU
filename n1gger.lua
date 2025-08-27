--// Services
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

--// Root ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZysumeHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

--// Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -35)
ToggleButton.Text = "Glaze\nScripts"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextStrokeTransparency = 0
ToggleButton.TextStrokeColor3 = Color3.fromRGB(100, 100, 100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = true
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Visible = false
ToggleButton.BackgroundTransparency = 1
ToggleButton.TextTransparency = 1
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local ToggleUIStroke = Instance.new("UIStroke", ToggleButton)
ToggleUIStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleUIStroke.Thickness = 1

--// Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame)
local UIStrokeMain = Instance.new("UIStroke", MainFrame)
UIStrokeMain.Color = Color3.fromRGB(255, 255, 255)
UIStrokeMain.Thickness = 1

local scale = Instance.new("UIScale", MainFrame)
scale.Scale = 0

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Glaze Hub Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.LayoutOrder = 0

-- Layout
local UIListLayout = Instance.new("UIListLayout", MainFrame)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.FillDirection = Enum.FillDirection.Vertical

-- Button creator with animation
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.AutoButtonColor = true
    btn.LayoutOrder = 10

    Instance.new("UICorner", btn)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1

    btn.MouseButton1Click:Connect(function()
        local particle = Instance.new("ParticleEmitter")
        particle.Texture = "rbxassetid://241837157"
        particle.Lifetime = NumberRange.new(0.3)
        particle.Rate = 100
        particle.Speed = NumberRange.new(2)
        particle.SpreadAngle = Vector2.new(360, 360)
        particle.Parent = btn
        particle:Emit(20)
        Debris:AddItem(particle, 0.5)

        local originalSize = btn.Size
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 5, originalSize.Y.Scale, originalSize.Y.Offset - 5)
        }):Play()
        task.delay(0.1, function()
            TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = originalSize
            }):Play()
        end)

        if callback then
            task.spawn(callback)
        end
    end)
end

-- Buttons
createButton("Zysume Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ZusumeHub/ZusumeHub/refs/heads/main/UpdateZysume"))()
end)

createButton("Trade Freezer", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GlazeScripts/TradeFreezerV1/refs/heads/main/GlazeHub.lua"))()
end)

createButton("Dark Spawner", function()
    local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()
    if Spawner and Spawner.Load then
        Spawner.Load()
    end
end)

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.BackgroundTransparency = 1
Footer.Text = "Made by GlazeOnTop"
Footer.TextColor3 = Color3.fromRGB(255, 255, 255)
Footer.TextSize = 14
Footer.Font = Enum.Font.Gotham
Footer.LayoutOrder = 999

--// IMPORTANT Pop-up
local ImportantFrame = Instance.new("Frame")
ImportantFrame.Size = UDim2.new(0, 420, 0, 260) -- Bigger size
ImportantFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ImportantFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ImportantFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ImportantFrame.Visible = false
ImportantFrame.Parent = ScreenGui

Instance.new("UICorner", ImportantFrame).CornerRadius = UDim.new(0.1, 0)
local ImportantStroke = Instance.new("UIStroke", ImportantFrame)
ImportantStroke.Color = Color3.fromRGB(255, 255, 255)
ImportantStroke.Thickness = 1

-- Title
local ImportantTitle = Instance.new("TextLabel", ImportantFrame)
ImportantTitle.Size = UDim2.new(1, 0, 0, 40)
ImportantTitle.Position = UDim2.new(0, 0, 0, 10)
ImportantTitle.BackgroundTransparency = 1
ImportantTitle.Text = "⚠️IMPORTANT⚠️"
ImportantTitle.TextColor3 = Color3.fromRGB(255, 255, 0)
ImportantTitle.Font = Enum.Font.GothamBold
ImportantTitle.TextSize = 26
ImportantTitle.TextStrokeTransparency = 0
ImportantTitle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

-- Instructions (Formatted)
local Instructions = Instance.new("TextLabel", ImportantFrame)
Instructions.Size = UDim2.new(1, -40, 0, 140)
Instructions.Position = UDim2.new(0, 20, 0, 60)
Instructions.BackgroundTransparency = 1
Instructions.Text = "1. Rejoin\n2. Go to Delta settings\n3. Turn off Verify Teleport, Anti Scam, Anti AFK\n4. Execute the script again\n5. You're all set!"
Instructions.TextColor3 = Color3.fromRGB(220, 220, 220)
Instructions.Font = Enum.Font.Gotham
Instructions.TextSize = 18
Instructions.TextWrapped = true
Instructions.TextYAlignment = Enum.TextYAlignment.Top
Instructions.TextXAlignment = Enum.TextXAlignment.Left

-- Got It Button
local GotItButton = Instance.new("TextButton", ImportantFrame)
GotItButton.Size = UDim2.new(0, 140, 0, 40)
GotItButton.Position = UDim2.new(0.5, -70, 1, -50)
GotItButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
GotItButton.Text = "Got it!"
GotItButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GotItButton.Font = Enum.Font.GothamBold
GotItButton.TextSize = 18
Instance.new("UICorner", GotItButton).CornerRadius = UDim.new(0.2, 0)

local hasClickedGotIt = false

GotItButton.MouseButton1Click:Connect(function()
    if hasClickedGotIt then return end
    hasClickedGotIt = true

    -- Hide the IMPORTANT pop-up
    ImportantFrame.Visible = false

    -- Show menu
    MainFrame.Visible = true
    scale.Scale = 0
    MainFrame.BackgroundTransparency = 1

    TweenService:Create(scale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play()

    TweenService:Create(MainFrame, TweenInfo.new(0.4), {
        BackgroundTransparency = 0.25
    }):Play()

   -- Show toggle button with bounce (only once)
    if not ToggleButton.Parent then
        ToggleButton.Parent = ScreenGui
        ToggleButton.Visible = true
        ToggleButton.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 70, 0, 70),
            BackgroundTransparency = 0,
            TextTransparency = 0
        }):Play()
    end

    isOpen = true -- sync toggle state
end)

local isOpen = true -- starts open after "Got it!" is clicked

ToggleButton.MouseButton1Click:Connect(function()
    if isOpen then
        -- Close the menu
        TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Scale = 0
        }):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.25), {
            BackgroundTransparency = 1
        }):Play()
        task.delay(0.25, function()
            MainFrame.Visible = false
        end)
    else
        -- Open the menu
        MainFrame.Visible = true
        scale.Scale = 0
        MainFrame.BackgroundTransparency = 1
        TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.35), {
            BackgroundTransparency = 0.25
        }):Play()
    end
    isOpen = not isOpen
end)

-- Loading Screen Setup
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "GlazeLoading"
LoadingGui.ResetOnSpawn = false
LoadingGui.Parent = game.CoreGui

local DimOverlay = Instance.new("Frame")
DimOverlay.Parent = LoadingGui
DimOverlay.Size = UDim2.new(1, 0, 1, 0)
DimOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DimOverlay.BackgroundTransparency = 0.7
DimOverlay.ZIndex = 0

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = LoadingGui
LoadingFrame.Size = UDim2.new(0, 441, 0, 176)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoadingFrame.BackgroundTransparency = 0
LoadingFrame.ZIndex = 1

Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0.1, 0)
local stroke = Instance.new("UIStroke", LoadingFrame)
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local LoadingPrefix = Instance.new("TextLabel", LoadingFrame)
LoadingPrefix.Size = UDim2.new(0, 130, 0, 40)
LoadingPrefix.Position = UDim2.new(0.5, -135, 0, 10)
LoadingPrefix.BackgroundTransparency = 1
LoadingPrefix.Text = "Loading"
LoadingPrefix.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingPrefix.Font = Enum.Font.GothamBold
LoadingPrefix.TextSize = 24
LoadingPrefix.TextStrokeTransparency = 0
LoadingPrefix.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
LoadingPrefix.TextXAlignment = Enum.TextXAlignment.Right
LoadingPrefix.ZIndex = 2

local GlazeHubText = Instance.new("TextLabel", LoadingFrame)
GlazeHubText.Size = UDim2.new(0, 180, 0, 40)
GlazeHubText.Position = UDim2.new(0.5, 5, 0, 10)
GlazeHubText.BackgroundTransparency = 1
GlazeHubText.Text = "Glaze Hub..."
GlazeHubText.Font = Enum.Font.GothamBold
GlazeHubText.TextSize = 24
GlazeHubText.TextStrokeTransparency = 0
GlazeHubText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
GlazeHubText.TextXAlignment = Enum.TextXAlignment.Left
GlazeHubText.ZIndex = 2

-- Animate "Glaze Hub..." color
task.spawn(function()
    local colors = {
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(150, 150, 150),
        Color3.fromRGB(0, 0, 0)
    }
    while LoadingGui and LoadingGui.Parent do
        for _, targetColor in ipairs(colors) do
            TweenService:Create(GlazeHubText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                TextColor3 = targetColor
            }):Play()
            task.wait(0.7)
        end
    end
end)

local ProgressBarBG = Instance.new("Frame", LoadingFrame)
ProgressBarBG.Size = UDim2.new(1, -40, 0, 40)
ProgressBarBG.Position = UDim2.new(0, 20, 0, 70)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBarBG.BorderSizePixel = 0
ProgressBarBG.ZIndex = 2

local ProgressBarFill = Instance.new("Frame", ProgressBarBG)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 3
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(0.5, 0)

local PercentLabel = Instance.new("TextLabel", ProgressBarBG)
PercentLabel.Size = UDim2.new(1, 0, 1, 0)
PercentLabel.Position = UDim2.new(0, 0, 0, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 16
PercentLabel.TextXAlignment = Enum.TextXAlignment.Center
PercentLabel.TextYAlignment = Enum.TextYAlignment.Center
PercentLabel.ZIndex = 4

local SubscribeText = Instance.new("TextLabel", LoadingFrame)
SubscribeText.Size = UDim2.new(1, 0, 0, 26)
SubscribeText.Position = UDim2.new(0, 0, 1, -30)
SubscribeText.BackgroundTransparency = 1
SubscribeText.Text = "Subscribe To GlazeOnTop"
SubscribeText.TextColor3 = Color3.fromRGB(255, 255, 255)
SubscribeText.Font = Enum.Font.GothamBold
SubscribeText.TextSize = 18
SubscribeText.ZIndex = 2

-- Progress bar skip animation
local skipValues = {1, 15, 32, 50, 73, 100}
task.spawn(function()
    for i = 1, #skipValues do
        local percent = skipValues[i]
        PercentLabel.Text = percent .. "%"

        TweenService:Create(ProgressBarFill, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(percent / 100, 0, 1, 0)
        }):Play()

        task.wait(1.5)
    end
end)

-- Fade out and reveal IMPORTANT pop-up
task.delay(9, function()
    local fadeTween = TweenService:Create(LoadingFrame, TweenInfo.new(1), {
        BackgroundTransparency = 1
    })
    local prefixFade = TweenService:Create(LoadingPrefix, TweenInfo.new(1), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    })
    local hubFade = TweenService:Create(GlazeHubText, TweenInfo.new(1), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    })
    local subFade = TweenService:Create(SubscribeText, TweenInfo.new(1), {
        TextTransparency = 1
    })
    local barFade = TweenService:Create(ProgressBarFill, TweenInfo.new(1), {
        BackgroundTransparency = 1
    })
    local percentFade = TweenService:Create(PercentLabel, TweenInfo.new(1), {
        TextTransparency = 1
    })
    local overlayFade = TweenService:Create(DimOverlay, TweenInfo.new(1), {
        BackgroundTransparency = 1
    })

    fadeTween:Play()
    prefixFade:Play()
    hubFade:Play()
    subFade:Play()
    barFade:Play()
    percentFade:Play()
    overlayFade:Play()

    fadeTween.Completed:Connect(function()
        LoadingGui:Destroy()
        ImportantFrame.Visible = true
    end)
end)
