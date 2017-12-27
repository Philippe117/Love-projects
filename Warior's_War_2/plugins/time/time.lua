--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 20/12/17
-- Time: 7:09 PM
-- To change this template use File | Settings | File Templates.
--

time = {}
time.time = 0
time.simspeed = 0
time.desiredRate = 1/60

function plugin.update(dt)
    time.time = time.time + time.desiredRate
    time.simspeed = dt/time.desiredRate
end

function plugin.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("fps="..(math.floor(100*love.timer.getFPS())/100).."", 240, 10)
    love.graphics.print("time="..(math.floor(100*time.time)/100).."", 240, 20)
    love.graphics.print("simspeed="..(math.floor(100*time.simspeed)/100).."", 240, 30)
end
