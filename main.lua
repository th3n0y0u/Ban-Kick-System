function kick()
	
	local target = game.Players:FindFirstChild(tostring(script.Parent.UserInput.Text))
	if target ~= nil then
		target:Kick("You have been kicked")
	else
		script.Parent.UserInput.Text = "Invalid Input"
	end
	
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

script.Parent.Kick.MouseButton1Down:Connect(kick)
script.Parent.ServerBan.MouseButton1Down:Connect(serverbanned)