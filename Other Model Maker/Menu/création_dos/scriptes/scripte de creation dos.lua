function M.load(M)

	const = load_image("constante.png")
	anim = load_image("anim.png")
	outil = load_image("outils.png")
	M.plaque = load_image(""..M.lieux.."/plaque")

	model_data_edit = load_model("ressource","model")
	model_edit = create_model(model_data_edit)
	model_edit.Z = 1
	model_edit.draw_cam = draw_model_edit
	add_to_camera(model_edit)
	make_model_selectable(model_edit)

	jump_model(model_edit)



end
function M.deload(M)
end
function M.update(M,dot)
	--txt = dot+1
	update_model(model_edit,dot)
	--txt = txt+1
end
function M.KP(M,k)
	if k == " " then
		jump_model(model_edit,"stand", 0 , 2 )
	elseif k == "z" then
		jump_model(model_edit)
	elseif k == "s" then
		save_model(model_edit.data,"models/model_de_test")
	elseif k == "w" then
		world.speed = world.speed+.2
	elseif k == "q" then
		world.speed = world.speed-.2
	elseif k == "v" then
		rapporter_erreur("camera.selectable = {")
		for i,h in ipairs(camera.selectable) do
			rapporter_erreur("	"..i.."")
		end
		rapporter_erreur("}")
	elseif k == "delete" then
		for i,h in ipairs(bones.selection) do
			remove_bone(h)
		end
	end
end
function M.KR(M,k)
end
function M.update(M,dot)
	update_model(model_edit,dot)
end
function draw_model_edit()
	for i,h in ipairs(model_edit.bone) do
		draw_in_world(draw_bone,h)
	end
	for i,h in ipairs(model_edit.bone) do
		draw_in_world(draw_bone2,h)
	end
	draw_selection()

end
function M.draw(M)
	love.graphics.setColor(255,255,255)
	draw_in_world( 	love.graphics.draw , grille , 0.5 , 0.5 , 0 , 0 , 1 , 1 , 200 , 200 )
	love.graphics.draw(M.plaque,0,410,0,80/M.plaque:getWidth(),220/M.plaque:getHeight())

draw_camera()


	love.graphics.draw(tool_tag,25,tool_tag_Y)



	draw_list(model_edit.data.anim[1].bone,"nom",200,100)
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( ff )


end
