function B.init(B)
	B.X = 50
	B.Y = love.graphics.getHeight()-120
end
function B.clic(B)
	menu.deload(menu)
	set_menu(menu_principal)
	menu.load(menu)

end

