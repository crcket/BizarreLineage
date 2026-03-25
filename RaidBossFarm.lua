if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 74747090658891 then return end

if getgenv().Settings.LowGFX then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
end

local Moves = {
    ["M1"] = {["Key"] = "M1", ["Cooldown"] = 0.5,   ["Uses"] = 4, ["UseDuration"] = 3},
    ["E"]  = {["Key"] = "E",  ["Cooldown"] = 12.5,  ["Uses"] = 1, ["UseDuration"] = 2.1},
	["R"]  = {["Key"] = "R",  ["Cooldown"] = 10,    ["Uses"] = 1, ["UseDuration"] = 2},
	["X"]  = {["Key"] = "X",  ["Cooldown"] = 10,    ["Uses"] = 1, ["UseDuration"] = 2},
}

local Combo = {
    Moves.M1,
    Moves.E,
    Moves.M1,
	Moves.R,
	Moves.M1,
	Moves.X,
	Moves.M1
}

local MovesOnCooldown = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Requests = ReplicatedStorage.requests.character

local LocalPlayer = Players.LocalPlayer

local SkipLoaderRemote = Requests.spawn

SkipLoaderRemote:FireServer()

LocalPlayer.CharacterAdded:Wait()

task.spawn(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/crcket/BizarreLineage/refs/heads/main/Background/LoadingScreenAI.lua"))()
end)
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
			task.spawn(function()
            	Humanoid.Sit = true
            	Root.CFrame = torso.CFrame * CFrame.new(0, -5.5, 0)
            	Root.CFrame = CFrame.lookAt(Root.Position, torso.Position)
			end)
			task.spawn(function()
				for _, v in Combo do
					if table.find(MovesOnCooldown, v) then continue end
						if v.Key == "M1" then
							for amt = 1, v.Uses do
									M1:FireServer(true, false)
								task.wait(v.Cooldown)
							end
						else
						table.insert(MovesOnCooldown, v)
						for amt = 1, v.Uses do
								Skill:FireServer(v.Key, true)
							Skill:FireServer(v.Key, false)
						end
						task.wait(v.UseDuration)
						table.remove(MovesOnCooldown, table.find(MovesOnCooldown, v))
					end
				end
			end)
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
		workspace.Live.ChildAdded:Connect(function(v)
			if v.Name:find("Jotaro") then
				KillNPC(v)
				print("he died")
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
