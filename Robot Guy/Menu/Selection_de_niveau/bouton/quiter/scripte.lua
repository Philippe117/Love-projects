function B.init(B)
	B.X = 30
	B.Y = love.graphics.getHeight()-95
end
function B.clic(B)
	set_menu(menu_principal)
	menu.load(menu)
end

