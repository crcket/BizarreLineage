repeat task.wait() until game:IsLoaded()

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- GUI Setup
local Loading = Instance.new("ScreenGui")
Loading.ClipToDeviceSafeArea = false
Loading.IgnoreGuiInset = true
Loading.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
Loading.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Loading.Name = "Loading"
Loading.Parent = CoreGui

local Main = Instance.new("Frame")
Main.BackgroundColor3 = Color3.fromRGB(5, 25, 55)
Main.BorderSizePixel = 0
Main.Size = UDim2.new(1, 0, 1, 0)
Main.Name = "Main"
Main.Parent = Loading

-- Background
local Background = Instance.new("Frame")
Background.AnchorPoint = Vector2.new(0.5, 0.5)
Background.BackgroundColor3 = Color3.fromRGB(7, 36, 80)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.5, 0, 0.5, 0)
Background.Size = UDim2.new(0, 315, 0, 225)
Background.Name = "Background"
Background.Parent = Main

local BGCorner = Instance.new("UICorner")
BGCorner.CornerRadius = UDim.new(0, 15)
BGCorner.Parent = Background

local BGStroke = Instance.new("UIStroke")
BGStroke.Color = Color3.fromRGB(255, 255, 255)
BGStroke.Thickness = 1.2
BGStroke.Parent = Background

local BGGradient = Instance.new("UIGradient")
BGGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 55, 121)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(54, 74, 162)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 55, 121))
}
BGGradient.Rotation = -180
BGGradient.Parent = BGStroke

-- Progress Label
local InProgress = Instance.new("TextLabel")
InProgress.Font = Enum.Font.GothamBold
InProgress.Text = "Progress: 0%"
InProgress.TextColor3 = Color3.fromRGB(255, 255, 255)
InProgress.TextSize = 25
InProgress.TextWrapped = true
InProgress.AnchorPoint = Vector2.new(0.5, 0.5)
InProgress.BackgroundTransparency = 1
InProgress.BorderSizePixel = 0
InProgress.Position = UDim2.new(0.5, 0, 0.55, 0)
InProgress.Size = UDim2.new(0, 200, 0, 50)
InProgress.Parent = Background

-- Boss HP Bar
local BossBarHolder = Instance.new("CanvasGroup")
BossBarHolder.AnchorPoint = Vector2.new(0.5, 0.5)
BossBarHolder.BackgroundColor3 = Color3.fromRGB(5, 26, 57)
BossBarHolder.BorderSizePixel = 0
BossBarHolder.Position = UDim2.new(0.5, 0, 0.8, 0)
BossBarHolder.Size = UDim2.new(0, 265, 0, 6)
BossBarHolder.Parent = Background

Instance.new("UICorner").Parent = BossBarHolder

local BossBarStroke = Instance.new("UIStroke")
BossBarStroke.Color = Color3.fromRGB(255, 255, 255)
BossBarStroke.Thickness = 1.2
BossBarStroke.Parent = BossBarHolder

local BossBarStrokeGradient = Instance.new("UIGradient")
BossBarStrokeGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(132, 33, 32)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 33, 32))
}
BossBarStrokeGradient.Rotation = 7
BossBarStrokeGradient.Parent = BossBarStroke

local ProgressBar = Instance.new("Frame")
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.AnchorPoint = Vector2.new(0, 0)
ProgressBar.Position = UDim2.new(0, 0, 0, 0)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.Parent = BossBarHolder

local ProgressBarGradient = Instance.new("UIGradient")
ProgressBarGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(191, 48, 46)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(154, 39, 37))
}
ProgressBarGradient.Parent = ProgressBar

Instance.new("UICorner").Parent = ProgressBar

-- Active Frame
local Active = Instance.new("Frame")
Active.AnchorPoint = Vector2.new(0.5, 0.5)
Active.BackgroundColor3 = Color3.fromRGB(21, 165, 2)
Active.BackgroundTransparency = 0.5
Active.BorderSizePixel = 0
Active.Position = UDim2.new(0.5, 0, 0.415, 0)
Active.Size = UDim2.new(0, 230, 0, 50)
Active.Parent = Main

local ActiveCorner = Instance.new("UICorner")
ActiveCorner.CornerRadius = UDim.new(0, 15)
ActiveCorner.Parent = Active

local ActiveStroke = Instance.new("UIStroke")
ActiveStroke.Color = Color3.fromRGB(255, 255, 255)
ActiveStroke.Thickness = 1.2
ActiveStroke.Parent = Active

local ActiveGradient = Instance.new("UIGradient")
ActiveGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 188, 2)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(161, 226, 9)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 188, 2))
}
ActiveGradient.Rotation = -180
ActiveGradient.Parent = ActiveStroke

local CircleActive = Instance.new("Frame")
CircleActive.AnchorPoint = Vector2.new(0.5, 0.5)
CircleActive.BackgroundColor3 = Color3.fromRGB(29, 230, 3)
CircleActive.BorderSizePixel = 0
CircleActive.Position = UDim2.new(0.1, 0, 0.5, 0)
CircleActive.Size = UDim2.new(0, 10, 0, 10)
CircleActive.Parent = Active

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = CircleActive

local ActiveLabel = Instance.new("TextLabel")
ActiveLabel.Font = Enum.Font.GothamBold
ActiveLabel.Text = "AUTOFARM ACTIVE"
ActiveLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
ActiveLabel.TextSize = 20
ActiveLabel.TextWrapped = true
ActiveLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ActiveLabel.BackgroundTransparency = 1
ActiveLabel.BorderSizePixel = 0
ActiveLabel.Position = UDim2.new(0.55, 0, 0.5, 0)
ActiveLabel.Size = UDim2.new(0, 200, 0, 50)
ActiveLabel.Parent = Active

-- Gradient Rotations
local bgGradientRot = BGGradient.Rotation
local activeGradientRot = ActiveGradient.Rotation
local bossBarGradientRot = BossBarStrokeGradient.Rotation

RunService.Heartbeat:Connect(function(dt)
	bgGradientRot = (bgGradientRot + 72 * dt) % 360
	BGGradient.Rotation = bgGradientRot

	activeGradientRot = (activeGradientRot + 72 * dt) % 360
	ActiveGradient.Rotation = activeGradientRot

	bossBarGradientRot = (bossBarGradientRot + 24 * dt) % 360
	BossBarStrokeGradient.Rotation = bossBarGradientRot
end)

-- Circle Pulse
local circleTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, -1, true)
TweenService:Create(CircleActive, circleTweenInfo, {BackgroundTransparency = 1}):Play()

workspace:WaitForChild("Live").ChildAdded:Connect(function(v)
	task.wait()
	print(v)
	if v.Name:find("Jotaro") or v.Name:find("DIO") then
		bossHum = v:WaitForChild("Humanoid")
	end
end)
repeat task.wait() until bossHum
local barTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

ProgressBar.Size = UDim2.new(bossHum.Health / bossHum.MaxHealth, 0, 1, 0)

bossHum:GetPropertyChangedSignal("Health"):Connect(function()
	InProgress.Text = `Boss HP: {math.round((bossHum.Health / bossHum.MaxHealth)*100)}%`
	TweenService:Create(ProgressBar, barTweenInfo, {
		Size = UDim2.new(bossHum.Health / bossHum.MaxHealth, 0, 1, 0)
	}):Play()
end)
