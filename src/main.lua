
local redRect, blueRect, greenRect, yellowRect
local collection = {};
local round = 1;
local go
local checker = 0
i = 0;
local flash
local sequence = {}
local restartButton;
local deletebits;
snakebits = {}
local textStart
local snake
local seqListener
gameover = true
math.randomseed(os.time())

local function reset(event)
	sequence = {}
	round = 1
	checker = 0
	i = 0
	rate = 2
	restartButton:removeSelf();
	gameover = false;
	timer.performWithDelay(1000,go)

end


local function setup()

	redRect = display.newRect(0,0,display.contentWidth/2,display.contentHeight/2)
	redRect:setReferencePoint(display.TopLeftReferencePoint);
	redRect:setFillColor(200,50,40)
	redRect.id = 1

	blueRect = display.newRect(0,display.contentHeight/2,display.contentWidth/2,display.contentHeight/2)
	blueRect:setReferencePoint(display.TopLeftReferencePoint);
	blueRect:setFillColor(50,50,210)
	blueRect.id = 4

	greenRect = display.newRect(display.contentWidth/2,0,display.contentWidth/2,display.contentHeight/2)
	greenRect:setReferencePoint(display.TopLeftReferencePoint);
	greenRect:setFillColor(60,250,40)
	greenRect.id = 3

	yellowRect = display.newRect(display.contentWidth/2 ,display.contentHeight/2,display.contentWidth/2,display.contentHeight/2)
	yellowRect:setReferencePoint(display.TopLeftReferencePoint);
	yellowRect:setFillColor(250,250,5)
	yellowRect.id = 2;

	collection = {redRect, yellowRect, greenRect,blueRect}

end
setup()

local gsText
function removeGs ()

gsText:removeSelf()

end

endgame = function()

gameover = true
			deletebits()
			
			gsText = display.newText("GAMEOVER",display.contentWidth/23, display.contentHeight/2.0, native.systemFont, 100)
			gsText:setTextColor(0,0,0)
			transition.to(gsText, {alpha = 0, delay = 1000, time = 1000, onComplete=removeGs})	
			restartButton = display.newText("RESTART",display.contentWidth/16, display.contentHeight/2.9, native.systemFont, 100)

			restartButton:addEventListener("tap", reset)
			redRect:removeEventListener("tap", seqListener)
			blueRect:removeEventListener("tap", seqListener)
			yellowRect:removeEventListener("tap", seqListener)
			greenRect:removeEventListener("tap", seqListener)

end

seqListener = function (event)



	if (checker < round) then
		if (event.target.id==sequence[checker+1] and gameover == false) then
			print("entered here")
			flash(collection[sequence[checker+1]], true)
			checker = checker + 1


		else
		
			
			endgame()
			
						
			

		end

	end






end

local textSS
local function removeText()

	textSS:removeSelf();

end

local function endInput()

	if(checker == round) then

		deletebits()
		redRect:removeEventListener("tap", seqListener)
		blueRect:removeEventListener("tap", seqListener)
		yellowRect:removeEventListener("tap", seqListener)
		greenRect:removeEventListener("tap", seqListener)

		textSS= display.newText(tostring(round),display.contentWidth/2.3, display.contentHeight/2, native.systemFont, 60)
		transition.to(textSS, { size = 100, time = 500, alpha = 0.0, onComplete=removeText})

		print("called go here")
		i = 0;
		round = round + 1;
		timer.performWithDelay(800,go)
		checker = 0;
		rate = rate * 1.01
	end



end




flash = function (obj, once)



	if (once == false and i < round and gameover == false) then
		transition.to(obj, {time=200, alpha = 0.5})
		transition.to(obj, {time=200, delay = 250, alpha = 1.0, onComplete=go})
	else
		transition.to(obj, {time=100, alpha = 0.5})
		transition.to(obj, {time=100, delay = 100, alpha = 1.0, onComplete=endInput})

	end


end



go = function()

if (gameover == false) then


	if (i == 0) then

		sequence[#sequence+1] = math.random(1,4);

	end

	print("value of #sequence".. " " ..tostring(#sequence))
	print("value of i".. " " ..tostring(i))
	print("value of round".. " " ..tostring(round))

	if (i < round) then

		next = sequence[i+1];
		print("value of next".. " " ..tostring(next))
		flash(collection[next], false);
		i = i + 1;

	else



		Runtime:addEventListener("enterFrame", snake)
	
		
		redRect:addEventListener("tap", seqListener)
		blueRect:addEventListener("tap", seqListener)
		yellowRect:addEventListener("tap", seqListener)
		greenRect:addEventListener("tap", seqListener)


	end

end

end



local function start(event)
	gameover = false
	textStart:removeSelf()
	timer.performWithDelay(1000,go)
	
end

textStart= display.newText("START",display.contentWidth/4, display.contentHeight/2.9, native.systemFont, 100)

textStart:addEventListener("tap", start)


x = 0
y = 0
local function addHead()


end

updown = 0;
leftright=1;
rate = 2



deletebits = function()

for i = 1,  #snakebits do

	snakebits[i]:removeSelf()
	

end 
Runtime:removeEventListener("enterFrame", snake)
  snakebits = {}
  x = 0;
  y = 0;
  updown = 0
  leftright = 1

end


snake = function(event)

	if (updown == 0 and leftright == 1) then

		y = 0;
		x = x + rate
		if (x > display.contentWidth - 20) then

			updown = -1
			leftright = 0

		end


	elseif (updown == -1 and leftright == 0) then

		print("in case 2")
		x = display.contentWidth-10
		y = y + rate

		if (y > display.contentHeight - 10) then

			updown = 0
			leftright = -1

		end


	elseif (updown == 0 and leftright == -1) then


		y = display.contentHeight - 10

		x = x - rate

		if (x < 10) then

			updown = 1
			leftright = 0


		end


	elseif (updown == 1 and leftright == 0) then


			x = 0
			y = y - rate

			if (y < 10) then

				endgame()
				updown = 0
				leftright = 1


			end


		end


		print(tostring(x)..","..tostring(y))
		bit = display.newRect(x,y,10,10)
		bit:setFillColor(math.random(0,244), math.random(0,244), math.random(0,244))
		snakebits[#snakebits+1] = bit
		
		
		
	end
	
	





