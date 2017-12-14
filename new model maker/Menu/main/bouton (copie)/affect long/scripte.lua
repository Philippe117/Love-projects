function B.init(B)				
	B.X = 200
	B.Y = 350
	B.text = "affecte long:oui"

	affect_long = 0
	Bout_afflong = B
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "la longueur des os en mode angle peut etre modifier"
end
function B.clic_gauche(B)
	if affect_long == 0 then
		B.text = "affecte long:oui"
		affect_long = 1
		B.popup.text = "la longueur des os en mode angle peut etre modifier"
	else
		B.text = "affecte long:non"
		affect_long = 0
		B.popup.text = "la longueur des os en mode angle est verouiller"
	end
end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()


	if affect_long == 1 then
		Bout_afflong.text = "affecte long:oui"
		Bout_afflong.popup.text = "la longueur des os en mode angle peut etre modifier"
	else
		Bout_afflong.text = "affecte long:non"
		Bout_afflong.popup.text = "la longueur des os en mode angle est verouiller"
	end

	if tool == "anim_os" then
		return(true)
	else
		return(false)
	end
end
