function B.load(B)				
	B.pos.X = 300
	B.pos.Y = 0
	B.Width = 200
	B.Height = 60
	bouton_set_text(B,"Animer")

	B.popup_text = "Passer en mode animation"
end
function B.MR(B,mx,my,bu)
	remove_menu(creation_dos)
	animation = load_menu("Menu","animation")
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





