runup = false
counter = 100
rotation = 0
function run()
	
	goal1_x,goal1_y,goal1_z = GetGoal1Position()
	goal2_x,goal2_y,goal2_z = GetGoal2Position()
	print("Goal1 ".. goal1_x .. ", " .. goal1_y .. ", " .. goal1_z)
	print("Goal2 ".. goal2_x .. ", " .. goal2_y .. ", " .. goal2_z)
	while AllowedToRun() do
        x,y,z = GetOwnLocation()
        ballX, ballY, ballZ = GetBallPosition()
        
        if(math.abs(x-ballX)<150 and math.abs(y-ballY)<150) then
			--print("Kick")
           Kick(goal1_x-x, goal1_y-y,0,10000)
        end
		if not (ballZ == 0 and ballY == 0 and ballX == 0) then
			--MoveTo(ballX, ballY, 100)
        else
			--print("Run To goal")
            --MoveTo(goal2_x+500,goal2_y)
			rotation = rotation + 10
			Rotate(rotation)
        end  

	end
end