function B.init(B)
	B.X = love.graphics.getWidth()/2-114
	B.Y = love.graphics.getHeight()/2-36
end
function B.clic(B)
	sourmode = 0
	set_menu(menu_play)
	love.audio.resume(musi)
end

