function B.init(B)
	B.X = love.graphics.getWidth()-277
	B.Y = love.graphics.getHeight()-120
end
function B.clic(B)
	set_menu(menu_play)
	menu.load(menu)
end

