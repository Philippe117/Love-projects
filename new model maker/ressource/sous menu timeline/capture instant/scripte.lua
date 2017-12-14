function B.init(B)				
	B.X = 0
	B.Y = love.graphics.getHeight()-150
	B.text = "capture position"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "cree un point ou tout les os et les sprite on une reference"
end
function B.clic_gauche(B)
	local sprsel = sprite.select
	for i,h in ipairs(model.sprite) do
		sprite.select = i
		sprite_timeline_add_anim(model)
	end
	sprite.select = sprsel


	local bosel = bone.select
	for i,h in ipairs(model.bone) do
		bone.select = i
		if model.model_data.bone[bone.select].tete.tipe ~= 2 then

			bone_timeline_add_anim(model)
		end

	end
	bone.select = bosel






end
function B.clic_droit(B)

end

function B.update(B,dot)
end
function B.condition(B)
	return( mode == "editer" )
end
