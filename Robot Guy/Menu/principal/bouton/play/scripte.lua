function B.init(B)
	B.X = love.graphics.getWidth()/2-385
	B.Y = 60
end
function B.clic(B)
	set_menu(menu_preparation)
	menu.load(menu)
end

