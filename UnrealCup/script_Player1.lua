runup = false
--counter = 0
function run()
   while AllowedToRun() do
	   x,y,z = GetOwnLocation()
	   --counter = counter +1
	   
	   --i = 1
	   --while i  <= 100000 do
		--	 i = i + 1
	   --end
	   
	   --if (counter%100000 == 0) then
		 --print("running")
	   --end
	   if (y<-2000) and (not runup) then
          Rotate(90)
		  runup=true
	   end
	   if (y>2000) and (runup) then
		  Rotate(270)
		  runup=false
	   end

	   MoveForward(2)
   end
end

