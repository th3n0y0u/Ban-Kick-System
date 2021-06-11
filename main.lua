local function mainclass()
	function kick()

		local target = game.Players:FindFirstChild(tostring(script.Parent.UserInput.Text))
		if target ~= nil then
			target:Kick("You have been kicked")
		else
			script.Parent.UserInput.Text = "Invalid Input"
		end

	end

	function votekick()

		local target = game.Players:FindFirstChild(tostring(script.Parent.UserInput.Text))

		for _,v in pairs(game.Players:GetPlayers()) do
			v.PlayerGui.BanPlayers.Votekick.Visible = true
			v.PlayerGui.BanPlayers.Votekick.NameText.Text = "Kick "..tostring(target.Name).."?"
		end

		local function fired()

			local yes = game.Workspace.People.Value

			local count = 0

			local totalneeded = 0

			if target ~= nil then
				for _,v in pairs(game.Players:GetPlayers()) do
					count += 1
				end

				if count / 2 > 1 then
					totalneeded = (count / 2) + 0.5
				elseif count / 2 == 1 then
					totalneeded = count / 2
				end

				while wait() do
					wait(1)
					local i = 30
					yes -= 1
					i -= 1
					script.Parent.Parent.Votekick.Wait.Text = "Wait("..i..")" 

					if yes == totalneeded then
						target:Kick("You have been votekicked")
						for _,v in pairs(game.Players:GetPlayers()) do
							v.PlayerGui.BanPlayers.Votekick.Visible = false 
						end
						break
					else
					    print("Not there yet")
					end
				end
			else
				return "invalid"
			end
		end

		fired()
	end

	function serverbanned()

		local target = game.Players:FindFirstChild(tostring(script.Parent.UserInput.Text))

		local banned = {}

		if target ~= nil then
			if target ~= script.Parent.Parent.Parent.Parent.Name then
				target:Kick("You have been server-banned")
				table.insert(banned, {tostring(target.Name)})

				game.Players.PlayerAdded:Connect(function(player)
					for _,v in pairs(banned) do
						if player.Name == banned[v] then
							player:Kick("You have been server-banned")
						elseif player.Name ~= banned[v] then
							print("Not a banned person")			
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

	script.Parent.VoteKick.MouseButton1Down:Connect(votekick)
	script.Parent.Kick.MouseButton1Down:Connect(kick)
	script.Parent.ServerBan.MouseButton1Down:Connect(serverbanned)
end

mainclass()
