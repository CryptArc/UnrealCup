runup = false
counter = 100
rotation = 0
function run()
	
	goal1_x,goal1_y,goal1_z = GetGoal1Position()
	goal2_x,goal2_y,goal2_z = GetGoal2Position()
    teamId = GetTeamId()
    startx, starty, startz = GetOwnLocation()

	while AllowedToRun() do
        x,y,z = GetOwnLocation()
		stamina = GetStamina()
        kickoff = IsKickoff()
        ballX, ballY, ballZ = GetBallPosition()
        playerHasBall = hasBall()
		text = Listen()
		if (text ~= "") then
			--print(text)
		end
        
         if(kickoff > -1) then
            if(kickoff == 0) then
                MoveTo(startx, starty, 100)
                while(kickoff == 0) do
                    kickoff = IsKickoff()
                end
            end
            if(kickoff == teamId) then
                --print("kickoff: own team: my team: " .. teamId .. "; kickoff-team: " .. kickoff)
                --cont playing
            else
                --print("kickoff: enemy team: my team: " .. teamId .. "; kickoff-team: " .. kickoff)
                --wait
                while(kickoff > -1) do
                    kickoff = IsKickoff()
                end
            end
        end
		
        if (playerHasBall) then
			ownAbs = math.pow(goal2_x-x, 2)+math.pow(goal2_y-y, 2) - 300
			pass = false
			pass_x = 0
			pass_y = 0
			for i = 1, #player, 1 do
				if (player[i][1] == 2) then
					 playerAbs = math.pow(goal2_x-player[i][3], 2)+math.pow(goal2_y -player[i][4], 2)
					 if (playerAbs < ownAbs) then
						ownAbs = playerAbs
						pass_x = player[i][3] - x
						pass_y = player[i][4] - y
						pass = true
					 end
				 end
			end
			
			--Gegner in der nähe?
			if (pass == false) then
				for i = 1, #player, 1 do
					if (player[i][1] == 1) then
						 enemyAbs = math.sqrt(math.pow(x-player[i][3], 2)+math.pow(x -player[i][4], 2))
						 if (enemyAbs < 1000) then
							pass = true
							for j = 1, #player, 1 do
								if (player[j][1] == 1) then
									pass_x = player[j][3] - x
									pass_y = player[j][4] - y
									break
								 end
							end
							break
						 end
					 end
				end
			end
			
			
			
			if (pass) then
				if (stamina > 50) then
					Kick(pass_x, pass_y,0,100)
				end
			else
				Kick(goal2_x-x, goal2_y-y,0,10)
			end
           
        end
		if not (ballZ == 0 and ballY == 0 and ballX == 0) then
			ownAbs = math.pow(x-ballX, 2)+math.pow(y-ballY, 2)
			run = true
			player = GetVisiblePlayers()
			for i = 1, #player, 1 do
				if (player[i][1] == 2) then
					 playerAbs = math.pow(player[i][3]-ballX, 2)+math.pow(player[i][4]-ballY, 2)
					 if (playerAbs < ownAbs) then
						run = false
						break
					 end
				 end
			end
		
		
			if (run) then
				MoveTo(ballX, ballY, 100)
			end
        else
			rotation = rotation + 10
			Rotate(rotation)
        end  

	end
end