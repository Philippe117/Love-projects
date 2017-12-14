function B.init(B)				
	B.X = 300
	B.Y = 0
	B.text = "anim 1"
	B_anim = B
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "clic droit pour +\nclic gauche pour -"
end
function B.clic_gauche(B)
--txt = table.maxn(model.model_data.bone[1].tete.anim)
	if model.anim < table.maxn(model.model_data.anim) then
		model_change_anim(model,model.anim+1)
	else
		model.model_data.anim[model.anim+1] = { temp = .5 ,
							nom = "sans nom"}

		for i,h in ipairs(model.model_data.bone) do
			if h.tete.tipe == 0 then
				h.tete.anim[model.anim+1] = { { temp = .1 , pos = { X = h.tete.anim[1][1].pos.X , Y = h.tete.anim[1][1].pos.Y } } }
			elseif h.tete.tipe == 1 then
				h.tete.anim[model.anim+1] = { { temp = .1 , vec = { D = h.tete.anim[1][1].vec.D , L =h.tete.anim[1][1].vec.L } } }
			end
		end

		for i,h in ipairs(model.model_data.sprite) do
			h.anim[model.anim+1] = { { temp = .1 , frame = 1 , alpha = 255 } }
		end

		model_change_anim(model,model.anim+1)
	end
end

function B.clic_droit(B)
	if model.anim > 1 then
		model_change_anim(model,model.anim-1)
	end
end
function B.autre(B,bu)
	if bu == "wu" then
		if model.anim < table.maxn(model.model_data.anim) then
			model_change_anim(model,model.anim+1)
		end
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update_popup(B)

end
function B.condition()
		B_anim.text = "anim "..model.anim.."/"..table.maxn(model.model_data.anim)..""
		return( true )

end
