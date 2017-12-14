function B.init(B)				
	B.X = 0
	B.Y = 50
	B.text = "retour"

	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+50
	B.popup.text = "retour a l'edition"
end
function B.clic_gauche(B)
	set_menu(menu_main)
	menu.load(menu)
end
function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
