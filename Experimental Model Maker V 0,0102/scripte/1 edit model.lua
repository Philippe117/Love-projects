

function load_model_for_edit(lieux,nom)
	rapporter_erreur( "(------------(  chargement du model : "..lieux.."/"..nom.." pour édition  )------------)")
	model_data_edit = load_model(lieux,nom)
	model_edit = create_model(model_data_edit)
	model_edit.Z = 1
	model_edit.draw_cam = draw_model_edit
	add_to_camera(model_edit)
	make_model_selectable(model_edit)

end





function make_model_selectable(model)
	model.animation = 0
	model.anim_points = add_list_to_collect_routine({},"anim_edit",true)
	for i,h in ipairs(model.bone) do
		add_bone_to_selectable(h)
	end

	for i,h in ipairs(model.data.anim) do
		local ani = add_data_to_a_list( model.anim_points , add_list_to_collect_routine(add_list_to_sort_routine({},"temps",-1,true),"anim_edit",true))
		for e,g in ipairs(h.bone) do
			if g[0] then
				local bn = model.bone[e]
				for a = 0 , table.maxn(g) do
					local t = g[a]
					local rep = false
					for u,k in ipairs(ani) do
						if k.temps == t.temps then
							rep = k
						end
					end
					if rep then
						add_data_to_a_list(rep.bone, bn )
					else
						rep = add_data_to_a_list(ani,{ temps = t.temps , bone = add_list_to_collect_routine({},"anim_edit",true) })
						add_data_to_a_list(rep.bone, bn )
					end
					
				end
			end
		end
	end
	return model
end







function draw_model_edit()
	for i,h in ipairs(model_edit.bone) do
		if get_eta(h,"selected") then
			if h.pointed or get_eta(h,"preselected") then
				love.graphics.setColor(150,255,40)
			else
				love.graphics.setColor(60,200,40)
			end
		else
			if h.pointed or get_eta(h,"preselected") then
				love.graphics.setColor(250,230,0)
			else
				love.graphics.setColor(255,255,255)

			end

		end
		draw_in_world(draw_bone,h)
	end
	for i,h in ipairs(model_edit.bone) do
		if get_eta(h,"selected") then
			if h.pointed or get_eta(h,"preselected") then
				love.graphics.setColor(150,255,40)
			else
				love.graphics.setColor(60,200,40)
			end
		else
			if h.pointed or get_eta(h,"preselected") then
				love.graphics.setColor(250,230,0)
			else
				love.graphics.setColor(255,255,255)

			end

		end
		draw_in_world(draw_bone2,h)
	end
	draw_selection()
end








