if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 74747090658891 then return end

if getgenv().Settings.LowGFX then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
	task.spawn(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/crcket/BizarreLineage/refs/heads/main/Background/LoadingScreenAI.lua"))()
	end)
end

if not isfile("BizarreLineage/Jotaro.mp3") then
	local data = request({Url = "https://raw.githubusercontent.com/crcket/BizarreLineage/refs/heads/main/Background/JotaroTheme.mp3"}).Body
	writefile("BizarreLineage/Jotaro.mp3",data)
end

local JotaroTheme = getcustomasset("BizarreLineage/Jotaro.mp3")
local Sound = Instance.new("Sound",workspace)
Sound.SoundId = JotaroTheme

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Requests = ReplicatedStorage.requests.character

local LocalPlayer = Players.LocalPlayer

local SkipLoaderRemote = Requests.spawn

SkipLoaderRemote:FireServer()

LocalPlayer.CharacterAdded:Wait()

local Character = LocalPlayer.Character

local SummonStandRemote = Character:WaitForChild("client_character_controller").SummonStand
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

SummonStandRemote:FireServer()


LocalPlayer.PlayerGui:WaitForChild("Main Menu").Enabled = false

local function KillNPC(NPC)
local NPCHumanoid = NPC:FindFirstChildWhichIsA("Humanoid", true)
if not NPCHumanoid then 
return 
end

while NPCHumanoid.Health > 0 and NPC.Parent do
    Character = LocalPlayer.Character
    if not Character then task.wait(1) continue end
    Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
    Root = Character:FindFirstChild("HumanoidRootPart")
    if not Humanoid or not Root then task.wait(1) continue end
	
    local torso = NPC:FindFirstChild("Torso") or NPC:FindFirstChild("HumanoidRootPart")
    if torso then
        Humanoid.Sit = true
        Root.CFrame = torso.CFrame * CFrame.new(0, -5.5, 0)
        Root.CFrame = CFrame.lookAt(Root.Position, torso.Position)

		for i,v in getgenv().Settings.UseMoves do
			Character:FindFirstChild("client_character_controller"):WaitForChild("Skill"):FireServer(v,true)
        	Character:FindFirstChild("client_character_controller"):WaitForChild("Skill"):FireServer(v,false)
		end
        Character:FindFirstChild("client_character_controller"):WaitForChild("M1"):FireServer(true,false)
    end
    task.wait()
    end
end



local RaidOptions = {
	["DIO"] = function()
		repeat task.wait() until #workspace:WaitForChild("Live"):GetChildren() >=12
		for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) then
				KillNPC(v)
			end
		end

		for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) then
				KillNPC(v)
			end
		end

		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("DIO") then
				KillNPC(v)
				Requests.retryraid:FireServer()
			end
		end)
	end,
	["Jotaro Kujo"] = function()
		Sound:Play()
		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("Jotaro") then
				KillNPC(v)
				Requests.retryraid:FireServer()
			end
		end)
	end,
	["Death 13"] = function()
		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("Death") then
				KillNPC(v)
				Requests.retryraid:FireServer()
			end
		end)
	end
}

for i,v in workspace.Map:GetChildren() do
	if RaidOptions[v.Name] then
		RaidOptions[v.Name]()
	end
end
task.spawn(function()
	for i, v in pairs(getgenv().Settings.OpenChests) do
	    Requests:WaitForChild("use_item"):FireServer(v .. " Chest", {UseAll = true})
	    task.wait(0.5)
	end
end)
task.spawn(function()
	for i, v in pairs(getgenv().Settings.BuyRaidItems) do
	    Requests:WaitForChild("raid_shop"):FireServer(v, "Jotaro Kujo")
	    task.wait(0.5)
	    Requests:WaitForChild("raid_shop"):FireServer(v, "DIO")
	    task.wait(0.5)
	end
end)
