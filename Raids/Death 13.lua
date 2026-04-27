local FightNPC = getgenv().FightNPC

local Requests = game.ReplicatedStorage.requests.character


workspace.Live.ChildAdded:Connect(function(v)
	if v.Name:find("Death") then
		FightNPC(v)
		Requests.retryraid:FireServer()
	end
end)