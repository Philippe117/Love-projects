function B.init(B)				
	B.X = love.graphics.getWidth()-200
	B.Y = 450
	B.text = "add sprite"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "ajouter un sprite"
end
function B.clic_gauche(B)

	local new = {	sprite = sprite_choisi ,
			chef = select ,
			eritrot = 1 ,
			eritscale = 1 ,
			X = 0 ,
			Y = 0 ,
			A = 0 ,
			sx = 1 ,
			sy = 1 ,
			anim = {}
											}

	for i,h in ipairs(model.model_data.bone[1].tete.anim) do
		new.anim[i] = {	{temp = .5 , frame = 1 , alpha = 255 }}
	end

	
	local cache2 = new
	local cache = 1
	local w = math.min(sprite_sel+1,table.maxn(model.model_data.sprite)+1)
	local max = table.maxn(model.model_data.sprite)+1
	while w <= max do
		cache = model.model_data.sprite[w]
		model.model_data.sprite[w] = cache2
		cache2 = cache
		model.sprite[w] = create_sprite(model,model.model_data.sprite[w])
		w = w+1
	end
	model.fin_anim = model.fin_anim+1
	sprite_sel = sprite_sel+1
end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()

		return( select ~= 0 )

end
