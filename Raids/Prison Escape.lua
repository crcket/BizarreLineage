local CountNpcViaNames = getgenv().CountNpcViaNames
local FightNPC = getgenv().FightNPC

local Requests = game.ReplicatedStorage.requests.character

repeat task.wait() until CountNpcViaNames("Prisoner") >= 16

		for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) then
				FightNPC(v)
			end
		end

        repeat task.wait() until CountNpcViaNames("Police") >= 8

		for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) then
				FightNPC(v)
			end
		end

        repeat task.wait() until CountNpcViaNames("Pucci") >= 1

        for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) and v.Name:find("Pucci") then
				FightNPC(v)
			end
		end

        task.wait(2)
        
        for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) and v.Name:find("Pucci") then
				FightNPC(v)
			end
		end

        task.wait(2)
        
        for _, v in workspace.Live:GetChildren() do
			if not v.Name:find("Server") and not v.Name:find(LocalPlayer.Name) and v.Name:find("Pucci") then
				FightNPC(v)
			end
		end
        Requests.retryraid:FireServer()