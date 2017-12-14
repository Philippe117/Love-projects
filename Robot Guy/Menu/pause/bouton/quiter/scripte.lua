function B.init(B)
	B.X = love.graphics.getWidth()/2-114
	B.Y = love.graphics.getHeight()/2+36
end
function B.clic(B)
	menu.deload(menu)
	set_menu(menu_principal)
	menu.load(menu)

end

