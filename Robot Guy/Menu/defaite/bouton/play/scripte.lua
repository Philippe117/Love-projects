function B.init(B)
	B.X = 100
	B.Y = love.graphics.getHeight()-300
end
function B.clic(B)
	set_menu(menu_play)
	menu.load(menu)
end

