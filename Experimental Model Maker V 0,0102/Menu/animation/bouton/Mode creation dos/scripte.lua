function B.load(B)				
	B.pos.X = 300
	B.pos.Y = 0
	B.Width = 200
	B.Height = 60
	bouton_set_text(B,"Creation")

	B.popup_text = "Passer en mode creation d'os"
end
function B.MR(B,mx,my,bu)
	remove_menu(animation)
	creation_dos = load_menu("Menu","création_dos")
end
function B.drag(B,k,X,Y)
	
end
function B.update(B)

end
function B.condition()
	return(true)
end
function B.draw()
end





