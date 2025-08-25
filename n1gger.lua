--// UI Variables
local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local UICornerMain = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local UIStrokeMain = Instance.new("UIStroke")
local UIListLayout = Instance.new("UIListLayout")
local Footer = Instance.new("TextLabel")
local ToggleUICorner = Instance.new("UICorner")
local ToggleUIStroke = Instance.new("UIStroke")

--// Enable GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "ZysumeHubUI"

--// Toggle Button (Circle)
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -35)
ToggleButton.Text = "Glaze\nScripts"
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.TextStrokeTransparency = 0
ToggleButton.TextStrokeColor3 = Color3.fromRGB(100,100,100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = true
ToggleButton.Active = true
ToggleButton.Draggable = true

ToggleUICorner.Parent = ToggleButton
ToggleUICorner.CornerRadius = UDim.new(1,0)
ToggleUIStroke.Parent = ToggleButton
ToggleUIStroke.Color = Color3.fromRGB(255,255,255)
ToggleUIStroke.Thickness = 1
ToggleUIStroke.Transparency = 0 -- fully visible
ToggleUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

--// Toggle Button Text Fade Animation
task.spawn(function()
	local colors = {
		Color3.fromRGB(255, 255, 255),
		Color3.fromRGB(150, 150, 150),
		Color3.fromRGB(0, 0, 0)
	}
	while true do
		for _, targetColor in ipairs(colors) do
			local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				TextColor3 = targetColor
			})
			tween:Play()
			task.wait(0.6)
		end
	end
end)

--// Main Frame
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 220)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

UICornerMain.Parent = MainFrame
UIStrokeMain.Parent = MainFrame
UIStrokeMain.Color = Color3.fromRGB(255,255,255)
UIStrokeMain.Thickness = 1

--// UIScale for shrink animation
local scale = Instance.new("UIScale")
scale.Parent = MainFrame
scale.Scale = 0

--// Title
Title.Parent = MainFrame
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Glaze Hub Menu"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.LayoutOrder = 0

--// Layout
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0,10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.FillDirection = Enum.FillDirection.Vertical

--// Button Creator with Animation
local function createButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Parent = MainFrame
	btn.Size = UDim2.new(0.85, 0, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.TextSize = 16
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.AutoButtonColor = true

	local stroke = Instance.new("UIStroke")
	stroke.Parent = btn
	stroke.Color = Color3.fromRGB(255,255,255)
	stroke.Thickness = 1

	local corner = Instance.new("UICorner")
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		-- Particle effect
		local particle = Instance.new("ParticleEmitter")
		particle.Texture = "rbxassetid://241837157"
		particle.Lifetime = NumberRange.new(0.3)
		particle.Rate = 100
		particle.Speed = NumberRange.new(2)
		particle.SpreadAngle = Vector2.new(360,360)
		particle.Parent = btn
		particle:Emit(20)
		game.Debris:AddItem(particle, 0.5)

		-- Shrink + bounce animation
		local originalSize = btn.Size
		local shrinkTween = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 5, originalSize.Y.Scale, originalSize.Y.Offset - 5)
		})
		shrinkTween:Play()
		shrinkTween.Completed:Connect(function()
			local bounceTween = TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = originalSize
			})
			bounceTween:Play()
		end)

		if callback then
			callback()
		end
	end)
end

--// Buttons
createButton("Zysume Hub", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZusumeHub/ZusumeHub/refs/heads/main/UpdateZysume"))()
end)

createButton("Trade Freezer", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/GlazeScripts/TradeFreezerV1/refs/heads/main/GlazeHub.lua"))()
end)

--// Info Message with Electric Blue Pulse
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = MainFrame
InfoLabel.Size = UDim2.new(1, -20, 0, 30)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "MORE WILL BE ADDED SOON!"
InfoLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
InfoLabel.TextStrokeTransparency = 0.5
InfoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
InfoLabel.TextSize = 14
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.LayoutOrder = 998

-- Electric Blue Pulse Animation
task.spawn(function()
	while true do
		for i = 0, 1, 0.02 do
			local g = 170 + (85 * i)
			InfoLabel.TextColor3 = Color3.fromRGB(0, g, 255)
			task.wait(0.05)
		end
		for i = 1, 0, -0.02 do
			local g = 170 + (85 * i)
			InfoLabel.TextColor3 = Color3.fromRGB(0, g, 255)
			task.wait(0.05)
		end
	end
end)

--// Footer
Footer.Parent = MainFrame
Footer.Size = UDim2.new(1,0,0,30)
Footer.BackgroundTransparency = 1
Footer.Text = "Made by GlazeOnTop"
Footer.TextColor3 = Color3.fromRGB(255,255,255)
Footer.TextSize = 14
Footer.Font = Enum.Font.Gotham
Footer.LayoutOrder = 999

--// Toggle Animation (True Shrink In/Out)
local isOpen = false
ToggleButton.MouseButton1Click:Connect(function()
	isOpen = not isOpen

	if isOpen then
		MainFrame.Visible = true
		scale.Scale = 0
		MainFrame.BackgroundTransparency = 1

		TweenService:Create(scale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = 1
		}):Play()

		TweenService:Create(MainFrame, TweenInfo.new(0.4), {
			BackgroundTransparency = 0.25
		}):Play()
	else
		local shrinkTween = TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Scale = 0
		})
		local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {
			BackgroundTransparency = 1
		})

		shrinkTween:Play()
		fadeTween:Play()

		shrinkTween.Completed:Connect(function()
			MainFrame.Visible = false
		end)
	end
end)
--// Loading Screen Setup
local TweenService = game:GetService("TweenService")
local LoadingGui = Instance.new("ScreenGui")
local DimOverlay = Instance.new("Frame")
local LoadingFrame = Instance.new("Frame")
local LoadingPrefix = Instance.new("TextLabel")
local GlazeHubText = Instance.new("TextLabel")
local ProgressBarBG = Instance.new("Frame")
local ProgressBarFill = Instance.new("Frame")
local PercentLabel = Instance.new("TextLabel")
local SubscribeText = Instance.new("TextLabel")

LoadingGui.Parent = game.CoreGui
LoadingGui.Name = "GlazeLoading"
LoadingGui.ResetOnSpawn = false

-- Dimmed background
DimOverlay.Parent = LoadingGui
DimOverlay.Size = UDim2.new(1, 0, 1, 0)
DimOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DimOverlay.BackgroundTransparency = 0.4
DimOverlay.ZIndex = 0

-- Loading frame
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

-- "Loading" label
LoadingPrefix.Parent = LoadingFrame
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

-- "Glaze Hub..." label
GlazeHubText.Parent = LoadingFrame
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
    while true do
        for _, targetColor in ipairs(colors) do
            local tween = TweenService:Create(GlazeHubText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                TextColor3 = targetColor
            })
            tween:Play()
            task.wait(0.7)
        end
    end
end)

-- Progress bar background
ProgressBarBG.Parent = LoadingFrame
ProgressBarBG.Size = UDim2.new(1, -40, 0, 40)
ProgressBarBG.Position = UDim2.new(0, 20, 0, 70)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBarBG.BorderSizePixel = 0
ProgressBarBG.ZIndex = 2

-- Progress bar fill
ProgressBarFill.Parent = ProgressBarBG
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 3
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(0.5, 0)

-- Percentage label
PercentLabel.Parent = ProgressBarBG
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

-- Subscribe message
SubscribeText.Parent = LoadingFrame
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

-- Fade out and reveal UI
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

        -- Show toggle button with bounce
        ToggleButton.Visible = true
        ToggleButton.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 70, 0, 70),
            BackgroundTransparency = 0,
            TextTransparency = 0
        }):Play()
    end)
end)
