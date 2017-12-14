S.load = {prio = 23}
function S.load.F()
	input = load_image("input")
	croi = load_image("croi")
	ligne = load_image("ligne")
end
function start_input(model)

end
function add_input(model,nom)
	table.insert( model.model_data.input , {nom = model.model_data.input,clavier.texte})
	table.insert( model.input , { 0 , 0 } )



	local new = table.maxn(model.model_data.input)
	model.input[nom] = new
end
function remove_input(model,input)
	_G["model_data_"..model.model_data.id.."_input_"..model.model_data.input[input].nom..""] = nil
	table.remove(model.model_data.input , input )
	table.remove(model.input , input )
	for i,h in ipairs(model.model_data.bone) do
		if h.tete.input ~= nil then
			if h.tete.input > input then
				h.tete.input = h.tete.input-1
			elseif h.tete.input == input then
				h.tete.input = nil
			end
		end
	end
end
--faire des eta d'input séparé 
function remove_input_intel(model,input)
	local possi = true
	for i,h in ipairs(model.model_data.bone) do
		if h.tete.input ~= nil then
			if h.tete.input == input then
				possi = false
			end
		end
	end
	if possi then
		remove_input(model,input)
	end
end
function draw_input(model)
	love.graphics.setColor(100,255,100,150)
	for i,h in ipairs(model.bone) do
		if model.model_data.bone[i].tete.input ~= nil then


			if model.model_data.bone[i].tete.tipe == 0 then
				love.graphics.draw(	croi ,
							X_world_to_screen(model.input[model.model_data.bone[i].tete.input][1]) ,
							Y_world_to_screen(model.input[model.model_data.bone[i].tete.input][2]) , 0 ,1 ,1 ,croi:getWidth()/2 , croi:getHeight()/2 )




			elseif model.model_data.bone[i].tete.tipe == 1 then


				love.graphics.draw(	ligne ,
							X_world_to_screen(h.base.pos.X) ,
							Y_world_to_screen(h.base.pos.Y) ,
							model.input[model.model_data.bone[i].tete.input][1] ,
							model.model_data.bone[i].tete.L*h.tete.pos.scale*camera.zoom*1.2/ligne:getWidth() ,
							1 , 0 , 3 )




			end
		end

	end




end

