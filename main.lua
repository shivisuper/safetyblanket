WIDTH = 512
HEIGHT = 384
SCALE = 2

ResMgr = require("resmgr")
local Ingame = require("ingame")

local state

function love.load()
	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE, {fullscreen=false, vsync=true})
	switchState(Ingame)
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
	love.graphics.scale(SCALE, SCALE)
	state:draw()
end

function love.mousepressed(x, y, button)
	x = x / SCALE
	y = y / SCALE
	state:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	x = x / SCALE
	y = y / SCALE
	state:mousereleased(x, y, button)
end

function switchState(stateclass, ...)
	if state then
		state:leave()
	end
	state = setmetatable({}, stateclass)
	state:enter(...)
end

local oldMouseGetPosition = love.mouse.getPosition
function love.mouse.getPosition()
	local mx, my = oldMouseGetPosition()
	return mx/SCALE, my/SCALE
end