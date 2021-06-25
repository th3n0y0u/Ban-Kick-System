local function mainclass()

	local function kick()
		script.Parent.KickEvent:FireServer(script.Parent.UserInput.Text)
	end

	local function votekick()
		script.Parent.VoteKickEvent:FireServer(script.Parent.UserInput.Text)
	end

	local function serverbanned()
		script.Parent.ServerBannedEvent:FireServer(script.Parent.UserInput.Text)
	end

	script.Parent.VoteKick.MouseButton1Down:Connect(votekick)
	script.Parent.Kick.MouseButton1Down:Connect(kick)
	script.Parent.ServerBan.MouseButton1Down:Connect(serverbanned)
end 

mainclass()
