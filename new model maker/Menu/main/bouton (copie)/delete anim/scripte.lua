function B.init(B)				
	B.X = 300
	B.Y = 50
	B.text = "delete anim"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "suprime l'animation"
end
function B.clic_gauche(B)
--txt = table.maxn(model.model_data.bone[1].tete.anim)

	table.remove( model.model_data.anim , model.anim )

	for i,h in ipairs(model.model_data.bone) do
		if h.tete.tipe == 0 then
			table.remove( h.tete.anim , model.anim )
		elseif h.tete.tipe == 1 then
			table.remove( h.tete.anim , model.anim )
		end
	end
	for i,h in ipairs(model.model_data.sprite) do
		table.remove( h.anim , model.anim )
	end
	if model.model_data.anim[model.anim] == nil then
		model.anim = model.anim-1
	end

end

function B.clic_droit(B)

end
function B.update_popup(B)

end
function B.condition()

		return( model.anim ~= 1 )

end
