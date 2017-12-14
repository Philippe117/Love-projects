function B.load(B)				
	B.pos.X = LINX
	B.pos.Y = LINY-60
	B.Width = 200
	B.Height = 60
	bouton_set_text(B,"Remove anim point")
	B.popup_text = "Permet effacer le mouvement d'animation des os selectionnes."



end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		for i,h in ipairs(bones.selection) do
			table.remove(h.anim[h.anim_index])
		end
	end
end
function B.drag(B,k,X,Y)
	
end
function B.update(B)

end
function B.condition()
	return Psel  and table.maxn(bones.selection) ~= 0
end
function B.draw()
end





