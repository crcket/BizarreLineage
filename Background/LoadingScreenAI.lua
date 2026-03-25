repeat task.wait() until game:IsLoaded()

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- GUI Setup
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.IgnoreGuiInset = true
LoadingScreen.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
LoadingScreen.ResetOnSpawn = false
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Parent = CoreGui

local Background = Instance.new("Frame")
Background.AnchorPoint = Vector2.new(0.5, 0.5)
Background.BackgroundColor3 = Color3.fromRGB(26, 31, 46)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.5, 0, 0.5, 0)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Parent = LoadingScreen

-- Box
local Box = Instance.new("CanvasGroup")
Box.AnchorPoint = Vector2.new(0.5, 0.5)
Box.BackgroundColor3 = Color3.fromRGB(27, 34, 53)
Box.BorderSizePixel = 0
Box.Position = UDim2.new(0.5, 0, 0.5, 0)
Box.Size = UDim2.new(0, 250, 0, 200)
Box.Name = "Box"
Box.Parent = Background

Instance.new("UICorner").Parent = Box

local BoxStroke = Instance.new("UIStroke")
BoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BoxStroke.Color = Color3.fromRGB(42, 53, 80)
BoxStroke.Thickness = 2
BoxStroke.Parent = Box

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.BackgroundColor3 = Color3.fromRGB(15, 21, 32)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 250, 0, 35)
TopBar.Parent = Box

local TopBarStroke = Instance.new("UIStroke")
TopBarStroke.Color = Color3.fromRGB(42, 53, 80)
TopBarStroke.Thickness = 2
TopBarStroke.Parent = TopBar

local TopBarLabel = Instance.new("TextLabel")
TopBarLabel.Font = Enum.Font.GothamBold
TopBarLabel.Text = "AUTO FARM"
TopBarLabel.TextColor3 = Color3.fromRGB(74, 96, 128)
TopBarLabel.TextSize = 14
TopBarLabel.TextWrapped = true
TopBarLabel.TextXAlignment = Enum.TextXAlignment.Left
TopBarLabel.AnchorPoint = Vector2.new(0, 0.5)
TopBarLabel.BackgroundTransparency = 1
TopBarLabel.BorderSizePixel = 0
TopBarLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
TopBarLabel.Size = UDim2.new(0, 120, 0, 35)
TopBarLabel.Parent = TopBar

-- Active Display
local ActiveDisplay = Instance.new("Frame")
ActiveDisplay.AnchorPoint = Vector2.new(0.5, 0)
ActiveDisplay.BackgroundColor3 = Color3.fromRGB(14, 43, 24)
ActiveDisplay.BorderSizePixel = 0
ActiveDisplay.Position = UDim2.new(0.5, 0, 0.25, 0)
ActiveDisplay.Size = UDim2.new(0, 220, 0, 35)
ActiveDisplay.Parent = Box

local ActiveDisplayCorner = Instance.new("UICorner")
ActiveDisplayCorner.CornerRadius = UDim.new(0, 5)
ActiveDisplayCorner.Parent = ActiveDisplay

local ActiveDisplayStroke = Instance.new("UIStroke")
ActiveDisplayStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ActiveDisplayStroke.Color = Color3.fromRGB(26, 92, 46)
ActiveDisplayStroke.Thickness = 0.85
ActiveDisplayStroke.Parent = ActiveDisplay

local Dot = Instance.new("Frame")
Dot.AnchorPoint = Vector2.new(0.5, 0.5)
Dot.BackgroundColor3 = Color3.fromRGB(0, 179, 65)
Dot.BackgroundTransparency = 0.5
Dot.BorderSizePixel = 0
Dot.Position = UDim2.new(0.204545453, 0, 0.5, 0)
Dot.Size = UDim2.new(0, 8, 0, 8)
Dot.Parent = ActiveDisplay

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = Dot

local ActiveLabel = Instance.new("TextLabel")
ActiveLabel.Font = Enum.Font.GothamBold
ActiveLabel.Text = "AUTOFARM ACTIVE"
ActiveLabel.TextColor3 = Color3.fromRGB(0, 179, 65)
ActiveLabel.TextSize = 14
ActiveLabel.TextXAlignment = Enum.TextXAlignment.Right
ActiveLabel.AnchorPoint = Vector2.new(0, 0.5)
ActiveLabel.BackgroundTransparency = 1
ActiveLabel.BorderSizePixel = 0
ActiveLabel.Position = UDim2.new(1.6, 0, 0.5, 0)
ActiveLabel.Size = UDim2.new(0, 120, 0, 35)
ActiveLabel.Parent = Dot

-- HP Labels
local HPLabel = Instance.new("TextLabel")
HPLabel.Font = Enum.Font.GothamBold
HPLabel.Text = "BOSS HP"
HPLabel.TextColor3 = Color3.fromRGB(61, 80, 112)
HPLabel.TextSize = 13
HPLabel.TextXAlignment = Enum.TextXAlignment.Left
HPLabel.TextYAlignment = Enum.TextYAlignment.Bottom
HPLabel.BackgroundTransparency = 1
HPLabel.BorderSizePixel = 0
HPLabel.Position = UDim2.new(0.06, 0, 0.5, 0)
HPLabel.Size = UDim2.new(0, 200, 0, 15)
HPLabel.Parent = Box

local Percentage = Instance.new("TextLabel")
Percentage.Font = Enum.Font.GothamBold
Percentage.Text = "100%"
Percentage.TextColor3 = Color3.fromRGB(255, 255, 255)
Percentage.TextScaled = true
Percentage.TextWrapped = true
Percentage.BackgroundTransparency = 1
Percentage.BorderSizePixel = 0
Percentage.Position = UDim2.new(0.06, 0, 0.575, 0)
Percentage.Size = UDim2.new(0, 49, 0, 30)
Percentage.Parent = Box

-- HP Bar
local HPBarBG = Instance.new("CanvasGroup")
HPBarBG.AnchorPoint = Vector2.new(0.5, 0)
HPBarBG.BackgroundColor3 = Color3.fromRGB(13, 17, 32)
HPBarBG.BorderSizePixel = 0
HPBarBG.Position = UDim2.new(0.5, 0, 0.75, 0)
HPBarBG.Size = UDim2.new(0, 220, 0, 15)
HPBarBG.ZIndex = -1
HPBarBG.Parent = Box

local HPBarBGCorner = Instance.new("UICorner")
HPBarBGCorner.CornerRadius = UDim.new(0, 3)
HPBarBGCorner.Parent = HPBarBG

local HPBar = Instance.new("Frame")
HPBar.AnchorPoint = Vector2.new(0, 0.5)
HPBar.BackgroundColor3 = Color3.fromRGB(204, 34, 34)
HPBar.BorderSizePixel = 0
HPBar.Position = UDim2.new(0, 0, 0.5, 0)
HPBar.Size = UDim2.new(1, 0, 1, 0)
HPBar.Parent = HPBarBG

local HPBarCorner = Instance.new("UICorner")
HPBarCorner.CornerRadius = UDim.new(0, 3)
HPBarCorner.Parent = HPBar

-- Shining Outline
local ShiningOutline = Instance.new("UIStroke")
ShiningOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ShiningOutline.Color = Color3.fromRGB(255, 255, 255)
ShiningOutline.Thickness = 2
ShiningOutline.ZIndex = 2
ShiningOutline.Parent = Box

local ShiningGradient = Instance.new("UIGradient")
ShiningGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(68, 87, 130)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 87, 130))
}
ShiningGradient.Rotation = 180
ShiningGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 0.9),
	NumberSequenceKeypoint.new(0.399, 1),
	NumberSequenceKeypoint.new(0.4, 0),
	NumberSequenceKeypoint.new(0.6, 0),
	NumberSequenceKeypoint.new(0.601, 1),
	NumberSequenceKeypoint.new(1, 0.9)
}
ShiningGradient.Parent = ShiningOutline

-- Dot Pulse
local circleTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, -1, true)
TweenService:Create(Dot, circleTweenInfo, {BackgroundTransparency = 1}):Play()

-- Shining Outline Rotation
local outlineRot = ShiningGradient.Rotation
RunService.Heartbeat:Connect(function(dt)
	outlineRot = (outlineRot + 72 * dt) % 360
	ShiningGradient.Rotation = outlineRot
end)

workspace:WaitForChild("Live").ChildAdded:Connect(function(v)
	task.wait()
	print(v)
	if v.Name:find("Jotaro") or v.Name:find("DIO") then
		bossHum = v:WaitForChild("Humanoid")
	end
end)
repeat task.wait() until bossHum
local barTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

HPBar.Size = UDim2.new(bossHum.Health / bossHum.MaxHealth, 0, 1, 0)

bossHum:GetPropertyChangedSignal("Health"):Connect(function()
	Percentage.Text = `{math.round((bossHum.Health / bossHum.MaxHealth)*100)}%`
	TweenService:Create(HPBar, barTweenInfo, {
		Size = UDim2.new(bossHum.Health / bossHum.MaxHealth, 0, 1, 0)
	}):Play()
end)
