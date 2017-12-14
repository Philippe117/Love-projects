function B.load(B)				
	B.pos.X = LINX+103
	B.pos.Y = LINY+30
	B.Width = 80
	B.Height = 30
	B.popup_text = "Permet d'ajuster la linéarité des fin de mouvement d'animation."



end
function B.MR(B,mx,my,bu)
	if bu == "wu" then
		for i,h in ipairs(bones.selection) do
			if h.anim[h.anim_index].temps == Psel.temps then
				h.anim[h.anim_index].Sari = math.min(5,h.anim[h.anim_index].Sari*1.1)
			end
		end
	elseif bu == "wd" then
		for i,h in ipairs(bones.selection) do
			if h.anim[h.anim_index].temps == Psel.temps then
				h.anim[h.anim_index].Sari = math.max(.1,h.anim[h.anim_index].Sari*.9)
			end
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





