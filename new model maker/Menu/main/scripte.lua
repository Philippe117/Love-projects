function I.load(I)
	const = load_image("constante.png")
	anim = load_image("anim.png")
	outil = load_image("outils.png")
	decal = 0
	decal2 = 0
	decal3 = 0
	decal4 = 0
	decal5 = 0
end
function I.demare(I)
	mode = "editer"
	base = {pos = { X = 0 , Y = 0 }}
	pointe_anim = 0
	select = 0
	start_bone()
	start_sprite()
	start_input (model)
	start_ligne_du_temp()
end
function I.deload(I)
end
function I.MP(I,mx,my,bu)

	if mode_edit == "edit bone" then
		MP_bone(mx,my,bu)
	elseif mode_edit == "edit sprite" then
		MP_sprite(mx,my,bu)
	end
	MP_ligne_du_temp(mx,my,bu)
end
function I.MR(I,mx,my,bu)

	if mode_edit == "edit bone" then
		MR_bone(mx,my,bu)
	elseif mode_edit == "edit sprite" then
		MP_sprite(mx,my,bu)
	end
	MR_ligne_du_temp(mx,my,bu)
end
function I.KP(I,k)
	if k == "escape" then
		love.event.push('quit')
	elseif k == " " then
		bout_play.clic_gauche(bout_play)
	elseif k == "a" then
		add_bone(model,{tipe = 0,pos = {X = 14 , Y = 14}},{tipe = 0},0)
	end
end
function I.KR(I,k)
end
function I.update(I,dot)

	decal = 0
	decal2 = 0
	decal3 = 0
	decal4 = 0
	decal5 = 0

	update_bone(dot)
	update_sprite(dot)
	update_ligne_du_temp(dot)
	update_model(model,dot)
end
function I.draw(I)
	love.graphics.setColor(255,255,255)
	love.graphics.draw( grille ,	X_world_to_screen(0) ,
					Y_world_to_screen(0) ,
					0,camera.zoom,camera.zoom,200,200)
	if mode == "visioner" then
			love.graphics.setColor(255,255,255,255)
			draw_in_world(draw_model,model,0,0)

	elseif mode == "editer" then
		if mode_edit == "edit bone" then
			love.graphics.setColor(255,255,255,255)

			draw_in_world(draw_model,model,0,0)

			draw_bone_edit(model,255)
			draw_atach(model,100)
			draw_input(model)
		elseif mode_edit == "edit sprite" then
			draw_sprite_edit(model,255)
			draw_bone(model,100)
		end
	end
	love.graphics.setColor(70,100,120)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 100 )
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-120, love.graphics.getWidth(), 120 )
	love.graphics.rectangle("fill", 0, 100, 200, love.graphics.getHeight()-220 )
	love.graphics.rectangle("fill", love.graphics.getWidth()-200, 100, 200, love.graphics.getHeight()-220 )
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("line", 200, 100, love.graphics.getWidth()-400, love.graphics.getHeight()-220 )

	love.graphics.setColor(255,255,255)
	if model ~= nil then
		draw_ligne_du_temp(255)
	end
	if mode == "editer" then
		if mode_edit == "edit bone" then

			love.graphics.draw(const ,
						love.graphics.getWidth()-200 ,
						love.graphics.getHeight()-325 )

			love.graphics.draw(anim ,
						love.graphics.getWidth()-100 ,
						love.graphics.getHeight()-325 )



			love.graphics.draw( outil ,
						love.graphics.getWidth()-150 ,
						250 )
			draw_bone_interface()
		elseif mode_edit == "edit sprite" then
		--	love.graphics.draw( outil ,
		--				love.graphics.getWidth()-150 ,
		--				100 )


			draw_sprite_interface()
			love.graphics.draw(const ,
						0 ,
						310 )

			love.graphics.draw(anim ,
						100 ,
						325 )

		end
	end
	love.graphics.setColor(255,255,255)
	love.graphics.print( "model : "..model.model_data.nom.."" , 200 , 50 )
	--love.graphics.print( saving , love.graphics.getWidth()/2-120 , 0 )
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( ff )
--	love.graphics.print( model.orloge , 0 , 200 )
--	love.graphics.print( "tool = "..tool.."" , 0 , 200 )
--	love.graphics.print( "toolmode = "..tool_mode.."" , 0 , 250 )
--	love.graphics.print( "sel = "..anim_os_sel.."" , 200 , 80 )
--	love.graphics.print( "temp = "..model.temp.."" , 200 , 100 )
--	love.graphics.print( "ratio = "..(math.floor((1+(tempo-crono)/animation[anim][nextframe].tempo)*10)/10).."" , 220 , 120 )
--	love.graphics.print( "-ratio = "..1-(math.floor((1+(tempo-crono)/animation[anim][nextframe].tempo)*10)/10).."" , 220 , 140 )
end
