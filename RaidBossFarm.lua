if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 74747090658891 then
	return
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Requests = ReplicatedStorage.requests.character
local LocalPlayer = Players.LocalPlayer

local function LoadAudio()
	if not isfile("BizarreLineage/Jotaro.mp3") then
		local data = request({
			Url = "https://raw.githubusercontent.com/crcket/BizarreLineage/refs/heads/main/Background/JotaroTheme.mp3"
		}).Body
		writefile("BizarreLineage/Jotaro.mp3", data)
	end

	local JotaroTheme = getcustomasset("BizarreLineage/Jotaro.mp3")
	local Sound = Instance.new("Sound", workspace)
	Sound.SoundId = JotaroTheme
	return Sound
end

local Sound = LoadAudio()

local function SetupCharacter()
	Requests.spawn:FireServer()
	LocalPlayer.CharacterAdded:Wait()

	local Character = LocalPlayer.Character
	local SummonStandRemote = Character:WaitForChild("client_character_controller").SummonStand
	local Humanoid = Character:WaitForChild("Humanoid")
	local Root = Character:WaitForChild("HumanoidRootPart")

	LocalPlayer.PlayerGui:WaitForChild("Main Menu").Enabled = false

	return Character, SummonStandRemote, Humanoid, Root
end

local Character, SummonStandRemote, Humanoid, Root = SetupCharacter()

local function IsPlayer(model)
	for _, player in Players:GetPlayers() do
		if player.Character == model then
			return true
		end
	end
	return false
end

local function RefreshCharacter()
	Character = LocalPlayer.Character
	if not Character then return false end

	Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
	Root = Character:FindFirstChild("HumanoidRootPart")

	return Humanoid ~= nil and Root ~= nil
end

local function AttackNPC(NPC)
	local torso = NPC:FindFirstChild("Torso") or NPC:FindFirstChild("HumanoidRootPart")
	if not torso then return end

	Humanoid.Sit = true
	Root.CFrame = torso.CFrame * CFrame.new(0, -5.5, 0)
	Root.CFrame = CFrame.lookAt(Root.Position, torso.Position)

	local controller = Character:FindFirstChild("client_character_controller")
	if not controller then return end

	for _, move in getgenv().Settings.UseMoves do
		controller:WaitForChild("Skill"):FireServer(move, true)
		controller:WaitForChild("Skill"):FireServer(move, false)
	end

	controller:WaitForChild("M1"):FireServer(true, false)
end

local function FightNPC(NPC, stopCondition)
	if IsPlayer(NPC) then return end

	local NPCHumanoid = NPC:FindFirstChildWhichIsA("Humanoid", true)
	if not NPCHumanoid then return end

	stopCondition = stopCondition or function()
		return NPCHumanoid.Health > 0 and NPC.Parent ~= nil
	end

	while stopCondition() do
		if not RefreshCharacter() then
			task.wait(1)
			continue
		end
		AttackNPC(NPC)
		task.wait()
	end
end

local function OpenChests()
	for _, v in pairs(getgenv().Settings.OpenChests) do
		Requests:WaitForChild("use_item"):FireServer(v .. " Chest", { UseAll = true })
		task.wait(0.5)
	end
end

local function BuyRaidItems()
	for _, v in pairs(getgenv().Settings.BuyRaidItems) do
		Requests:WaitForChild("raid_shop"):FireServer(v, "Jotaro Kujo")
		task.wait(0.5)
		Requests:WaitForChild("raid_shop"):FireServer(v, "DIO")
	end
end

local RaidOptions = {
	["DIO"] = function()
		repeat task.wait() until #workspace:WaitForChild("Live"):GetChildren() >= 12

		for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) then
				FightNPC(v)
			end
		end

		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("DIO") then
				FightNPC(v)
				Requests.retryraid:FireServer()
			end
		end)
	end,

	["Jotaro Kujo"] = function()
		Sound:Play()
		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("Jotaro") then
				FightNPC(v)
				Requests.retryraid:FireServer()
			end
		end)
	end,

	["Death 13"] = function()
		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("Death") then
				FightNPC(v)
				Requests.retryraid:FireServer()
			end
		end)
	end,

	["Heaven Ascension DIO"] = function()
		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("DIO") then
				FightNPC(v, function()
					return workspace.CurrentCamera.CameraSubject.Name == "Humanoid" and v.Parent ~= nil -- stop condition
				end)
				for _, child in workspace.Live:GetChildren() do
					if not child.Name:find("Server") and not child.Name:find(LocalPlayer.Name) and child.Name:find("star") then
						FightNPC(child)
					end
				end
				for _, child in workspace.Live:GetChildren() do
					if not child.Name:find("Server") and not child.Name:find(LocalPlayer.Name) then
						FightNPC(child,function()
                            return child.Parent ~= nil
                        end)
                        Requests.retryraid:FireServer()
					end
				end
			end
		end)
	end,
}

for _, v in workspace.Map:GetChildren() do
	if RaidOptions[v.Name] then
		RaidOptions[v.Name]()
        task.wait(3)
        SummonStandRemote:FireServer()
	end
end

task.spawn(OpenChests)
task.spawn(BuyRaidItems)
