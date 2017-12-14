function B.load(B)				
	B.pos.X = LINX+103
	B.pos.Y = LINY+60
	B.Width = 80
	B.Height = 40

	bouton_set_text(B,"Lineaire")
	B.popup_text = "linéarise le mouvement d'animation."



end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		for i,h in ipairs(bones.selection) do
			if h.anim[h.anim_index].temps == Psel.temps  and h.data.tete.tipe ~= 2 then
				h.anim[h.anim_index].Sdep = 1
				h.anim[h.anim_index].Sari = 1
			end
		end
	end
end
function B.drag(B,k,X,Y)
	
end
function B.update(B)

end
function B.condition()
	return Psel and table.maxn(bones.selection) ~= 0
end
function B.draw()
end





