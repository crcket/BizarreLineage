-- AutofarmWaitScreen.lua
-- LocalScript inside StarterPlayerScripts

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player    = Players.LocalPlayer
local playerGui = game.CoreGui

-- ════════════════════════════════════════════
--  ScreenGui
-- ════════════════════════════════════════════
local screenGui = Instance.new("ScreenGui")
screenGui.Name           = "AutofarmWaitScreen"
screenGui.ResetOnSpawn   = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent         = playerGui

-- ════════════════════════════════════════════
--  Full-screen background
-- ════════════════════════════════════════════
local bg = Instance.new("Frame", screenGui)
bg.Name                   = "Background"
bg.Size                   = UDim2.fromScale(1, 1)
bg.Position               = UDim2.fromScale(0, 0)
bg.BackgroundColor3       = Color3.fromRGB(15, 24, 48)
bg.BorderSizePixel        = 0
bg.BackgroundTransparency = 1

for _, yPos in ipairs({ UDim2.new(0,0,0,0), UDim2.new(0,0,1,-3) }) do
    local bar = Instance.new("Frame", bg)
    bar.Size             = UDim2.new(1, 0, 0, 3)
    bar.Position         = yPos
    bar.BackgroundColor3 = Color3.fromRGB(72, 132, 232)
    bar.BorderSizePixel  = 0
end

-- ════════════════════════════════════════════
--  Centre card
-- ════════════════════════════════════════════
local card = Instance.new("Frame", bg)
card.Name                   = "Card"
card.AnchorPoint            = Vector2.new(0.5, 0.5)
card.Size                   = UDim2.new(0, 460, 0, 290)
card.Position               = UDim2.new(0.5, 0, 0.58, 0)
card.BackgroundColor3       = Color3.fromRGB(22, 36, 70)
card.BorderSizePixel        = 0
card.BackgroundTransparency = 1

Instance.new("UICorner", card).CornerRadius = UDim.new(0, 22)

local stroke = Instance.new("UIStroke", card)
stroke.Color        = Color3.fromRGB(72, 132, 232)
stroke.Transparency = 0.65
stroke.Thickness    = 1

-- ════════════════════════════════════════════
--  Status badge
-- ════════════════════════════════════════════
local badge = Instance.new("Frame", card)
badge.Name                   = "StatusBadge"
badge.AnchorPoint            = Vector2.new(0.5, 0)
badge.Size                   = UDim2.new(0, 192, 0, 30)
badge.Position               = UDim2.new(0.5, 0, 0, 28)
badge.BackgroundColor3       = Color3.fromRGB(18, 52, 30)
badge.BorderSizePixel        = 0
badge.BackgroundTransparency = 1

Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 99)

local badgeStroke = Instance.new("UIStroke", badge)
badgeStroke.Color        = Color3.fromRGB(76, 210, 110)
badgeStroke.Transparency = 0.55
badgeStroke.Thickness    = 1

local badgeLayout = Instance.new("UIListLayout", badge)
badgeLayout.FillDirection       = Enum.FillDirection.Horizontal
badgeLayout.VerticalAlignment   = Enum.VerticalAlignment.Center
badgeLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
badgeLayout.Padding             = UDim.new(0, 7)

local badgePadding = Instance.new("UIPadding", badge)
badgePadding.PaddingLeft  = UDim.new(0, 14)
badgePadding.PaddingRight = UDim.new(0, 14)

local dot = Instance.new("Frame", badge)
dot.Name             = "GreenDot"
dot.Size             = UDim2.new(0, 9, 0, 9)
dot.BackgroundColor3 = Color3.fromRGB(72, 220, 110)
dot.BorderSizePixel  = 0
dot.LayoutOrder      = 1
Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

local statusLabel = Instance.new("TextLabel", badge)
statusLabel.Size                   = UDim2.new(0, 148, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text                   = "AUTOFARM ACTIVE"
statusLabel.TextColor3             = Color3.fromRGB(72, 220, 110)
statusLabel.TextSize               = 11
statusLabel.Font                   = Enum.Font.GothamBold
statusLabel.TextXAlignment         = Enum.TextXAlignment.Center
statusLabel.LayoutOrder            = 2

-- ════════════════════════════════════════════
--  Title & subtitle
-- ════════════════════════════════════════════
local title = Instance.new("TextLabel", card)
title.Size                   = UDim2.new(1, -48, 0, 40)
title.Position               = UDim2.new(0, 24, 0, 82)
title.BackgroundTransparency = 1
title.Text                   = "Running in Background"
title.TextColor3             = Color3.fromRGB(218, 232, 255)
title.TextSize               = 27
title.Font                   = Enum.Font.GothamBold
title.TextXAlignment         = Enum.TextXAlignment.Center
title.TextTransparency       = 1

local sub = Instance.new("TextLabel", card)
sub.Size                   = UDim2.new(1, -48, 0, 24)
sub.Position               = UDim2.new(0, 24, 0, 128)
sub.BackgroundTransparency = 1
sub.Text                   = "Killing those stupid NPCs.."
sub.TextColor3             = Color3.fromRGB(100, 142, 196)
sub.TextSize               = 14
sub.Font                   = Enum.Font.Gotham
sub.TextXAlignment         = Enum.TextXAlignment.Center
sub.TextTransparency       = 1

-- ════════════════════════════════════════════
--  Bubble holder  (NO UIListLayout)
--  Each bubble is anchored to its own centre
--  so growing/shrinking never nudges siblings
-- ════════════════════════════════════════════
local holder = Instance.new("Frame", card)
holder.AnchorPoint            = Vector2.new(0.5, 0.5)
holder.Size                   = UDim2.new(0, 148, 0, 48)
holder.Position               = UDim2.new(0.5, 0, 0.5, 68)
holder.BackgroundTransparency = 1

-- Fixed X centres for the 3 bubbles inside the 148px-wide holder
--   left: 24px  mid: 74px  right: 124px
local BUBBLE_X = { 24, 74, 124 }
local BUBBLE_COLORS = {
    Color3.fromRGB(50,  100, 205),
    Color3.fromRGB(80,  144, 245),
    Color3.fromRGB(145, 188, 255),
}

local bubbles = {}
for i = 1, 3 do
    local b = Instance.new("Frame", holder)
    b.Name             = "Bubble" .. i
    -- AnchorPoint centres the frame on its Position point
    b.AnchorPoint      = Vector2.new(0.5, 0.5)
    b.Size             = UDim2.new(0, 15, 0, 15)
    -- Y = 0.5 so it stays vertically centred; X is fixed per bubble
    b.Position         = UDim2.new(0, BUBBLE_X[i], 0.5, 0)
    b.BackgroundColor3       = BUBBLE_COLORS[i]
    b.BackgroundTransparency = 0.6
    b.BorderSizePixel        = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    bubbles[i] = b
end

-- ════════════════════════════════════════════
--  Green dot pulse
-- ════════════════════════════════════════════
local dotInfo = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local function loopDotPulse()
    while dot and dot.Parent do
        TweenService:Create(dot, dotInfo, { BackgroundTransparency = 0.05 }):Play()
        task.wait(0.75)
        TweenService:Create(dot, dotInfo, { BackgroundTransparency = 0.70 }):Play()
        task.wait(0.75)
    end
end
task.spawn(loopDotPulse)

-- ════════════════════════════════════════════
--  Bubble animation
--  AnchorPoint = 0.5,0.5 means the bubble
--  expands equally in all directions from its
--  fixed centre — no sideways movement at all
-- ════════════════════════════════════════════
local STAGGER     = 0.25
local GROW_TIME   = 0.45
local SHRINK_TIME = 0.2
local REST_TIME   = 1

local BASE_SIZE = UDim2.new(0, 15, 0, 15)
local BIG_SIZE  = UDim2.new(0, 27, 0, 27)

local growInfo   = TweenInfo.new(GROW_TIME,   Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local shrinkInfo = TweenInfo.new(SHRINK_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local function loopBubble(b)
    while b and b.Parent do
        TweenService:Create(b, growInfo,   { Size = BIG_SIZE,  BackgroundTransparency = 0.0 }):Play()
        task.wait(GROW_TIME)
        TweenService:Create(b, shrinkInfo, { Size = BASE_SIZE, BackgroundTransparency = 0.6 }):Play()
        task.wait(SHRINK_TIME + REST_TIME)
    end
end

for i, b in ipairs(bubbles) do
    task.delay((i - 1) * STAGGER, function()
        loopBubble(b)
    end)
end

-- ════════════════════════════════════════════
--  Entrance animation
-- ════════════════════════════════════════════
TweenService:Create(bg, TweenInfo.new(0.70, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { BackgroundTransparency = 0 }):Play()

TweenService:Create(card, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0,
    Position = UDim2.fromScale(0.5, 0.5),
}):Play()

task.delay(0.20, function()
    TweenService:Create(badge, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundTransparency = 0 }):Play()
end)
task.delay(0.30, function()
    TweenService:Create(title, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextTransparency = 0 }):Play()
end)
task.delay(0.45, function()
    TweenService:Create(sub, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextTransparency = 0 }):Play()
end)