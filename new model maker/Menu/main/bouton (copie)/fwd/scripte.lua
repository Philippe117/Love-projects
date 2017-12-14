function B.init(B)

				
	B.X = 620
	B.Y = 0
	B.text = ""


end
function B.clic_gauche(B)

	model.speed = model.speed+.1

end
function B.clic_droit(B)
	model.speed = model.speed-.1
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
