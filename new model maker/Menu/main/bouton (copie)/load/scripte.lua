function B.init(B)				
	B.X = 0
	B.Y = 100
	B.text = "load"

	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+50
	B.popup.text = "loader le model"
end
function B.clic_gauche(B)
	set_menu(menu_load)
	menu.load(menu)


--	model_data = load_model_data("mod")
--	model = create_model(model_data,{ X = 0 , Y = 0 , A = 0 },1)
end
function B.clic_droit(B)
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
