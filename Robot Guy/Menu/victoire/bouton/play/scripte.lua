function B.init(B)
	B.X = love.graphics.getWidth()/2-113
	B.Y = 596
end
function B.clic(B)
	set_menu(menu_preparation)
	menu.load(menu)
end

