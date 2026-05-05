local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LoadingScreen = Instance.new("ScreenGui",game.CoreGui)
LoadingScreen.IgnoreGuiInset=true

-- Background
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
Box.Size = UDim2.new(0, 400, 0, 200)
Box.Parent = Background

local uc = Instance.new("UICorner")
uc.Parent = Box
uc.CornerRadius = UDim.new(0,5)

local BoxStroke = Instance.new("UIStroke")
BoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BoxStroke.Color = Color3.fromRGB(42, 53, 80)
BoxStroke.Thickness = 2
BoxStroke.Parent = Box

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.BackgroundColor3 = Color3.fromRGB(15, 21, 32)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(0, 400, 0, 35)
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

-- Active Frame
local ActiveFrame = Instance.new("Frame")
ActiveFrame.AnchorPoint = Vector2.new(0.5, 0)
ActiveFrame.BackgroundColor3 = Color3.fromRGB(14, 43, 24)
ActiveFrame.BorderSizePixel = 0
ActiveFrame.Position = UDim2.new(0.5, 0, 0.25, 0)
ActiveFrame.Size = UDim2.new(0, 380, 0, 35)
ActiveFrame.Parent = Box

local ActiveFrameCorner = Instance.new("UICorner")
ActiveFrameCorner.CornerRadius = UDim.new(0, 5)
ActiveFrameCorner.Parent = ActiveFrame

local ActiveFrameStroke = Instance.new("UIStroke")
ActiveFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ActiveFrameStroke.Color = Color3.fromRGB(26, 92, 46)
ActiveFrameStroke.Thickness = 0.85
ActiveFrameStroke.Parent = ActiveFrame

local Dot = Instance.new("Frame")
Dot.AnchorPoint = Vector2.new(0.5, 0.5)
Dot.BackgroundColor3 = Color3.fromRGB(0, 179, 65)
Dot.BackgroundTransparency = 0.5
Dot.BorderSizePixel = 0
Dot.Position = UDim2.new(0.262, 0, 0.5, 0)
Dot.Size = UDim2.new(0, 8, 0, 8)
Dot.Parent = ActiveFrame

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = Dot

local ActiveLabel = Instance.new("TextLabel")
ActiveLabel.Font = Enum.Font.GothamBold
ActiveLabel.Text = "AUTOFARM ACTIVE - 999s"
ActiveLabel.TextColor3 = Color3.fromRGB(0, 179, 65)
ActiveLabel.TextSize = 14
ActiveLabel.TextXAlignment = Enum.TextXAlignment.Right
ActiveLabel.AnchorPoint = Vector2.new(0, 0.5)
ActiveLabel.BackgroundTransparency = 1
ActiveLabel.BorderSizePixel = 0
ActiveLabel.Position = UDim2.new(6.6, 0, 0.5, 0)
ActiveLabel.Size = UDim2.new(0, 120, 0, 35)
ActiveLabel.Parent = Dot

-- HP Labels
local BossHPLabel = Instance.new("TextLabel")
BossHPLabel.Font = Enum.Font.GothamBold
BossHPLabel.Text = "BOSS HP"
BossHPLabel.TextColor3 = Color3.fromRGB(61, 80, 112)
BossHPLabel.TextSize = 13
BossHPLabel.TextXAlignment = Enum.TextXAlignment.Left
BossHPLabel.TextYAlignment = Enum.TextYAlignment.Bottom
BossHPLabel.BackgroundTransparency = 1
BossHPLabel.BorderSizePixel = 0
BossHPLabel.Position = UDim2.new(0.025, 0, 0.5, 0)
BossHPLabel.Size = UDim2.new(0, 200, 0, 15)
BossHPLabel.Parent = Box

local Percentage = Instance.new("TextLabel")
Percentage.Font = Enum.Font.GothamBold
Percentage.Text = "100%"
Percentage.TextColor3 = Color3.fromRGB(255, 255, 255)
Percentage.TextScaled = true
Percentage.TextWrapped = true
Percentage.BackgroundTransparency = 1
Percentage.BorderSizePixel = 0
Percentage.Position = UDim2.new(0.025, 0, 0.575, 0)
Percentage.Size = UDim2.new(0, 50, 0, 30)
Percentage.Parent = Box

-- Boss Bar
local BossBarHolder = Instance.new("CanvasGroup")
BossBarHolder.AnchorPoint = Vector2.new(0.5, 0)
BossBarHolder.BackgroundColor3 = Color3.fromRGB(13, 17, 32)
BossBarHolder.BorderSizePixel = 0
BossBarHolder.Position = UDim2.new(0.5, 0, 0.75, 0)
BossBarHolder.Size = UDim2.new(0, 380, 0, 15)
BossBarHolder.ZIndex = 1
BossBarHolder.Parent = Box

local BossBarHolderCorner = Instance.new("UICorner")
BossBarHolderCorner.CornerRadius = UDim.new(0, 3)
BossBarHolderCorner.Parent = BossBarHolder

local HPBar = Instance.new("Frame")
HPBar.AnchorPoint = Vector2.new(0, 0.5)
HPBar.BackgroundColor3 = Color3.fromRGB(204, 34, 34)
HPBar.BorderSizePixel = 0
HPBar.Position = UDim2.new(0, 0, 0.5, 0)
HPBar.Size = UDim2.new(1, 0, 1, 0)
HPBar.Parent = BossBarHolder

local HPBarCorner = Instance.new("UICorner")
HPBarCorner.CornerRadius = UDim.new(0, 3)
HPBarCorner.Parent = HPBar

-- Outline Shine
local OutlineShine = Instance.new("UIStroke")
OutlineShine.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OutlineShine.Color = Color3.fromRGB(255, 255, 255)
OutlineShine.Thickness = 2
OutlineShine.ZIndex = 2
OutlineShine.Parent = Box

local OutlineGradient = Instance.new("UIGradient")
OutlineGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(68, 87, 130)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 87, 130))
}
OutlineGradient.Rotation = 180
OutlineGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 0.9),
	NumberSequenceKeypoint.new(0.399, 1),
	NumberSequenceKeypoint.new(0.4, 0),
	NumberSequenceKeypoint.new(0.6, 0),
	NumberSequenceKeypoint.new(0.601, 1),
	NumberSequenceKeypoint.new(1, 0.9)
}
OutlineGradient.Parent = OutlineShine

-- Dot Pulse
local dotTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, -1, true)
TweenService:Create(Dot, dotTweenInfo, {BackgroundTransparency = 1}):Play()

-- Outline Rotation
local outlineRot = OutlineGradient.Rotation
RunService.Heartbeat:Connect(function(dt)
	outlineRot = (outlineRot + 72 * dt) % 360
	OutlineGradient.Rotation = outlineRot
	ActiveLabel.Text = `AUTOFARM ACTIVE — {math.round(workspace.DistributedGameTime)}s`
end)

	local bob = workspace:WaitForChild("Live").ChildAdded:Connect(function(v)
		task.wait()
		print(v)
		if v.Name:find("Jotaro") or v.Name:find("DIO") or v.Name:find("13") or v.Name:find("Ascend") or v.Name:find("Avdol") then
			bossHum = v:WaitForChild("Humanoid")
		end
	end)

local barTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

Percentage.Text = `???%`

repeat task.wait() until bossHum
HPBar.Size = UDim2.new(bossHum.Health / bossHum.MaxHealth, 0, 1, 0)
bob:Disconnect()
bossHum:GetPropertyChangedSignal("Health"):Connect(function()
	Percentage.Text = `{math.round((bossHum.Health / bossHum.MaxHealth)*100)}%`
	TweenService:Create(HPBar, barTweenInfo, {
		Size = UDim2.new(bossHum.Health / bossHum.MaxHealth, 0, 1, 0)
	}):Play()
end)


