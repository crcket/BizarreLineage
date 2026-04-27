local FightNPC = getgenv().FightNPC

local Requests = game.ReplicatedStorage.requests.character

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