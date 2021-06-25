

local function mainclass()
	
	local function kick(player, text)
		local target = game.Players:FindFirstChild(tostring(text))
		if target ~= nil then
			target:Kick("You have been kicked")
		else
			script.Parent.UserInput.Text = "Invalid Input"
		end
	end
	
	local function votekick(player, text)
		local target = game.Players:FindFirstChild(tostring(text))
		
		local kicked = false

		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= script.Parent.Parent.Parent.Parent.Name and v.Name ~= target.Name then
				v.PlayerGui.BanPlayers.Enabled = true
				v.PlayerGui.BanPlayers.Frame.Visible = false
				v.PlayerGui.BanPlayers.Votekick.Visible = true
				v.PlayerGui.BanPlayers.Votekick.NameText.Text = "Kick "..tostring(target.Name).."?"
			end
		end

		local function fired()

			local yes = game.Workspace.People

			local count = 0

			if target ~= nil then
				for i, v in pairs(game.Players:GetPlayers()) do
					count = count + 1
				end
				
				local length = 30
				while wait() do
					wait(1) 
					if yes.Value >= (count / 2) then
						print((player.Name).." has been kicked!")
						kicked = true
						for i, v in pairs(game.Players:GetPlayers()) do
							v.PlayerGui.BanPlayers.Enabled = false
							v.PlayerGui.BanPlayers.Votekick.Visible = false 
						end
						yes.Value = 0
						break
					elseif yes.Value < (count / 2) then
						length -= 1
						print("Not there yet")
						for i, v in pairs(game.Players:GetPlayers()) do
							v.PlayerGui.BanPlayers.Votekick.Wait.Text = length.." Seconds" 
						end
						if length == 0 then
							for i, v in pairs(game.Players:GetPlayers()) do
								v.PlayerGui.BanPlayers.Votekick.Visible = false 
							end
							break
						end
					end
				end
				if kicked == true then
					target:Kick("You have been vote-kicked.")
				end
			else
				return "invalid"
			end
		end

		fired()
	end
	
	local function serverbanned(player, text)
		local target = game.Players:FindFirstChild(tostring(text))

		local banned = {}

		if target ~= nil then
			if target ~= script.Parent.Parent.Parent.Parent.Name then
				target:Kick("You have been server-banned")
				table.insert(banned, {tostring(target.Name)})

				game.Players.PlayerAdded:Connect(function(player)
					for i, v in pairs(banned) do
						if player.Name == banned[v] then
							player:Kick("You have been server-banned")
						elseif player.Name ~= banned[v] then
							return "Not a banned person"		
						end
					end
				end)


			else
				script.Parent.UserInput.Text = "Cannot ban yourself"
			end
		else
			script.Parent.UserInput.Text = "Invalid Input"
		end

		while wait(1) do
			if game.Players:GetChildren() == false then
				for i in pairs(banned) do
					banned[i] = nil
				end
			end
		end

		print("pro")
	end
	
	script.Parent.KickEvent.OnServerEvent:Connect(kick)
	script.Parent.VoteKickEvent.OnServerEvent:Connect(votekick)
	script.Parent.ServerBannedEvent.OnServerEvent:Connect(serverbanned)
end

mainclass()
