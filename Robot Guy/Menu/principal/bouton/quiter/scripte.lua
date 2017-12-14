function B.init(B)
	B.X = love.graphics.getWidth()/2+158
	B.Y = 60
end
function B.clic(B)
	love.event.push("quit")
end

