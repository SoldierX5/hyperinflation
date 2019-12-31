-- include useful files
execScript("utils.lua")
execScript("common.lua")
execScript("commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then pAltBarrage(math.random(2, 3), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 3 then pTunnel(math.random(1, 3))
	elseif mKey == 4 then pMirrorWallStrip(1, 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(1, 2), 1)
	elseif mKey == 6 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 7 then pRandomBarrage(math.random(2, 6), 2.25)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 3, 7, 7, 7 }
keys = shuffle(keys)
index = 0
lowerBound = 3
upperBound = 8
lowerBeat = -15
upperBeat = 15



-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	log("level onLoad")
	execEvent("swapEvent")
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	setLevelValueInt("sides", math.random(lowerBound, upperBound))

	setLevelValueInt("beatpulse_max", math.random(lowerBeat, upperBeat))
	setStyleValueInt("3D_depth", math.random(20))
	setStyleValueInt("3D_spacing", math.random(9))
	setLevelValueFloat("rotation_speed", math.random(0.5, 0.83))
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == table.getn(keys) then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 1000

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if isFastSpinning() == false then
			setLevelValueFloat("rotation_speed", getLevelValueFloat("rotation_speed") * -1)
			dirChangeTime = 1000
		end
	end 
end