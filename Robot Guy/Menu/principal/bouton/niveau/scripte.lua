function B.init(B)
	B.X = love.graphics.getWidth()/2-113
	B.Y = 60
end
function B.clic(B)
	set_menu(menu_Selection_de_niveau)
	menu.load(menu)
end

