if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId ~= 14890802310 then return end
if not isfolder("PolnareffTracker") then makefolder("PolnareffTracker") end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Requests = ReplicatedStorage.requests.character
game:GetService("RunService"):Set3dRenderingEnabled(false)
local function SetupCharacter()
	Requests.spawn:FireServer()
	LocalPlayer.CharacterAdded:Wait()
	local Character = LocalPlayer.Character
	LocalPlayer.PlayerGui:WaitForChild("Main Menu").Enabled = false
	return Character
end

local Character = SetupCharacter()
local Root = Character:WaitForChild("HumanoidRootPart")

task.wait(1)

local JoinLink = `https://deepblox.vercel.app/experiences/start?placeId=14890802310&gameInstanceId={game.JobId}`

Character:PivotTo(CFrame.new(1435, 910, 1320))

local function HopServer()
	local Servers, Cursor = {}, ""
	repeat
		local ok, Result = pcall(function()
			return HttpService:JSONDecode(
				game:HttpGet(`https://games.roblox.com/v1/games/{game.PlaceId}/Servers/Public?sortOrder=Asc&limit=100&cursor={Cursor}`)
			)
		end)
		if ok and Result and Result.data then
			for _, Server in ipairs(Result.data) do
				if Server.playing <= 10 and Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
					table.insert(Servers, Server.id)
				end
			end
			Cursor = Result.nextPageCursor or ""
		else
			break
		end
	until Cursor == "" or #Servers >= 1

	if #Servers > 0 then
		TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1, #Servers)], LocalPlayer)
	else
		warn("No available servers found.")
	end
end

local Serverhop = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Cesare0328/my-scripts/refs/heads/main/CachedServerhop.lua"))()
end

repeat task.wait() until #workspace.Live:GetChildren() >= 15
task.wait(1)

local foundJean, JH = false, nil
for _, v in workspace.Live:GetChildren() do
	if v.Name:find("Jean") or v.Name:find("Pierre") or v.Name:find("Polnareff") then
		foundJean = true
		writefile("PolnareffTracker/" .. tostring(math.random(1, 99999)) .. ".txt", v.Name)
		JH = v.Humanoid
		break
	end
end

local hp = JH and JH.Health or -1

local ClosestP, ClosestDist = nil, math.huge
for _, v in pairs(Players:GetPlayers()) do
	task.wait()
	if v == LocalPlayer or not v.Character then continue end
	local hrp = v.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then continue end
	local dist = LocalPlayer:DistanceFromCharacter(hrp.Position)
	if dist < ClosestDist then
		ClosestDist = dist
		ClosestP = v
	end
end

local closestName = ClosestP and ClosestP.Name or "Nobody"
local closestDistText = ClosestDist == math.huge and "unknown" or tostring(math.floor(ClosestDist))

if foundJean then
	local data = HttpService:JSONEncode({
		embeds = {{
			color = 2040124,
			description = "# POLNAREFF FOUND IN SERVER\n# [🎮 Join Server](" .. JoinLink .. ")\nClosest player is **" .. closestName .. "** — " .. closestDistText .. " studs away!\n\# of players: " .. tostring(#Players:GetChildren()) .. "\n**HP: " .. tostring(hp) .. "**",
			image = { url = "https://files.catbox.moe/7gawc0.webp" }
		}}
	})
	request({
		Url = getgenv().DiscordURL,
		Method = "POST",
		Headers = { ["Content-Type"] = "application/json" },
		Body = data
	})
end

Serverhop()
