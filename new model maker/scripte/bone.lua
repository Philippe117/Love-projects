S.load = {prio = 14}
function S.load.F()
	point = load_image("point")
	ligne2 = load_image("ligne 2")
	os = load_image("os")
	--txt = txt+34
	bone = {}
end
function start_bone()
	bone.eta = 0
	bone.select = 0
	bone.canselect = 0
	bone.controle = 0
	bone.tool = "positionnement"
	load_bouton("ressource/sous menu bone")
end
function MP_bone(mx,my,bu)
	if mode == "editer" then
		if bone.tool == "positionnement" then
			if bone.eta  == 0 then
				if bu == "l" then
					if bone.canselect ~= 0 then
						bone.select = bone.canselect
						bone.ref = { X = mouse.X , Y = mouse.Y }
						bone.timer = crono+.4
						bone.eta = 1
					end
				end
			elseif bone.eta  == 1 then
			elseif bone.eta  == 2 and pointer == 0 then
				bone.eta = 0
			end
		elseif bone.tool == "creation" then
			if bone.eta  == 0 then
				if bu == "l" then
					if bone.canselect ~= 0 then
						bone.base = { tipe = 1 , pos = bone.canselect }
					else
						bone.base = {tipe = 0 , pos = {X = mouse.X , Y = mouse.Y}}
					end
					bone.eta  = 1
					bone.ref = { X = mouse.X , Y = mouse.Y }
					bone.timer = crono+.4
				end
			elseif bone.eta  == 1 then
			elseif bone.eta  == 2 and pointer == 0 then
				bone.eta = 0
			end
		end
	end
end
function MR_bone(mx,my,bu)
	if mode == "editer" then
		if bone.tool == "creation" then
			if bone.eta == 0 then
				if bu == "r" then
					if bone.canselect ~= 0 then
						bone.select = bone.canselect
						bone.ref = { X = mx , Y = my }
						bone.eta = 2
					end
				end
			elseif bone.eta  == 1 or bone.eta  == 1.1 then
				bone.eta = 0
				if bone.canselect ~= 0 and bone.select ~= 0 then
					model.model_data.bone[bone.select].tete.tipe = 2
					model.model_data.bone[bone.select].tete.pos = bone.canselect
					model.bone[bone.select].tete.pose = model.bone[bone.canselect].tete.pos
					bone_eradicate_anim(model.model_data,bone.select)
				end
			elseif bone.eta  == 2 then
				bone.eta = 0
			end
		elseif bone.tool == "positionnement" then
			if bone.eta  == 0 then
				if bu == "r" then
					if bone.canselect ~= 0 then
						bone.select = bone.canselect
						bone.ref = { X = mx , Y = my }
						bone.eta = 2
					end
				end
			elseif bone.eta  == 1 or bone.eta  == 1.1 then
				bone.eta = 0
			elseif bone.eta  == 2 then
				bone.eta = 0
			end
		end
	end
end
function update_bone(dot)
	if mode == "editer" then
		if bone.eta  == -1 then
			if love.mouse.getX() > 200 and love.mouse.getX() < love.graphics.getWidth()-200
			and love.mouse.getY() > 100 and love.mouse.getY() < love.graphics.getHeight()-120 then
				bone.eta  = 0
			else
				bone.canselect = 0
			end
		else
			if love.mouse.getX() < 200 or love.mouse.getX() > love.graphics.getWidth()-200
			or love.mouse.getY() < 100 or love.mouse.getY() > love.graphics.getHeight()-120 then
				bone.eta  = -1
			end
			if pointer == 0 then
				bone.canselect = 0
				local near_dist = 15/camera.zoom
				for i,h in ipairs(model.bone) do
					local dist = math.sqrt((h.tete.pos.X-math.cos(h.tete.pos.A)/10-mouse.X)^2+(h.tete.pos.Y-math.sin(h.tete.pos.A)/10-mouse.Y)^2)
					if dist < near_dist then
						near_dist = dist
						bone.canselect = i
					end
				end
			end
			if mode_edit == "edit bone" then
				if bone.tool == "creation" then
					if bone.eta  == 0 then
					elseif bone.eta  == 1 then
						if bone.timer < crono
						or math.sqrt((mouse.X-bone.ref.X)^2+(mouse.Y-bone.ref.Y)^2) > 10/camera.zoom then
							bone.eta  = 1.1
							model.speed = 0
							local newbone = add_bone(model,bone.base,{tipe = bone.create_mode},1)
							bone.controle = bone_timeline_add_anim(model)
						end
						model_jump(model,model.anim,model.temp+20)
						model_jump(model,model.anim,model.temp-20)
					elseif bone.eta  == 1.1 then
						bone.canselect = 0
						local near_dist = 15/camera.zoom
						for i,h in ipairs(model.bone) do
							if i ~= bone.select then
								local dist = math.sqrt((h.tete.pos.X-math.cos(h.tete.pos.A)/10-mouse.X)^2+(h.tete.pos.Y-math.sin(h.tete.pos.A)/10-mouse.Y)^2)
								if dist < near_dist then
									near_dist = dist
									bone.canselect = i
								end
							end
						end
						local mx = mouse.X
						local my = mouse.Y
						if bone.canselect ~= 0 then
							mx = model.bone[bone.canselect].tete.pos.X
							my = model.bone[bone.canselect].tete.pos.Y
						end
						if model.model_data.bone[bone.controle.os].tete.tipe == 0 then
							bone.controle.prestep.pos.X = mx
							bone.controle.prestep.pos.Y = my
							model.model_data.bone[bone.controle.os].tete.L = math.sqrt((model.bone[bone.controle.os].base.pos.X-mx)^2+(model.bone[bone.controle.os].base.pos.Y-my)^2)
						elseif model.model_data.bone[bone.controle.os].tete.tipe == 1 then
							local ang = math.atan2((my-model.bone[bone.controle.os].base.pos.Y),(mx-model.bone[bone.controle.os].base.pos.X))
							bone.controle.prestep.pos.D = ang-angle(ang,model.bone[bone.controle.os].base.pos.A+ang)*bone.controle.prestep.eritrot
							bone.controle.prestep.pos.L = math.sqrt((model.bone[bone.controle.os].base.pos.X-mx)^2+(model.bone[bone.controle.os].base.pos.Y-my)^2)
							model.model_data.bone[bone.controle.os].tete.L = bone.controle.prestep.pos.L
						end
						model_jump(model,model.anim,model.temp+20)
						model_jump(model,model.anim,model.temp-20)
					end
				elseif bone.tool == "positionnement" then
					if bone.eta  == 0 then
					elseif bone.eta  == 1 then
						if bone.timer < crono
						or math.sqrt((mouse.X-bone.ref.X)^2+(mouse.Y-bone.ref.Y)^2) > 10/camera.zoom then
							bone.eta  = 1.1
							model.speed = 0
							bone.controle = bone_timeline_add_anim(model)
						end
					elseif bone.eta  == 1.1 then
						if model.model_data.bone[bone.controle.os].tete.tipe == 0 then
							bone.controle.prestep.pos.X = mouse.X
							bone.controle.prestep.pos.Y = mouse.Y
						elseif model.model_data.bone[bone.controle.os].tete.tipe == 1 then
							local ang = math.atan2((mouse.Y-model.bone[bone.controle.os].base.pos.Y),(mouse.X-model.bone[bone.controle.os].base.pos.X))
							bone.controle.prestep.pos.D = ang-angle(ang,model.bone[bone.controle.os].base.pos.A+ang)*bone.controle.prestep.eritrot
							if bone.affectlong then
								bone.controle.prestep.pos.L = math.sqrt((model.bone[bone.controle.os].base.pos.X-mouse.X)^2+(model.bone[bone.controle.os].base.pos.Y-mouse.Y)^2)
							end
						end
						model_jump(model,model.anim,model.temp+20)
						model_jump(model,model.anim,model.temp-20)
					end
				end
			end
		end
	end
end
function draw_bone(model,alpha)
	for i,h in ipairs(model.bone) do
		if i == bone.select then
			if i == bone.canselect then
				love.graphics.setColor(255,255,0,alpha)
			else
				love.graphics.setColor(0,255,0,alpha)
			end
		elseif i == bone.canselect then
			love.graphics.setColor(255,180,120,alpha)
		else
			love.graphics.setColor(255,255,255,alpha)
		end
		love.graphics.draw( os ,	(h.base.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 ,
						(h.base.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 ,
						h.tete.pos.A ,
						math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)/400*camera.zoom ,
						.4 ,
						0 ,
						25 )
	end
	for i,h in ipairs(model.bone) do
		if i == bone.select then
			if i == bone.canselect then
				love.graphics.setColor(255,255,0,alpha)
			else
				love.graphics.setColor(0,255,0,alpha)
			end
		elseif i == bone.canselect then
			love.graphics.setColor(255,180,120,alpha)
		else
			love.graphics.setColor(255,255,255,alpha)
		end
		if model.model_data.bone[i].tete.tipe ~= 2 then
			love.graphics.draw( point ,	(h.tete.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 ,
							(h.tete.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 ,
							h.tete.pos.A ,
							1 ,
							1 ,
							10 ,
							10 )
		end
	end
end
function draw_bone_edit(model,alpha)
	if timeline.select ~= 0 then
		love.graphics.setColor(255,200,0,alpha)
		for e,g in ipairs(model.model_data.anim[model.anim][timeline.select].bone) do
			love.graphics.draw( point ,
				(model.bone[g.os].tete.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 ,
				(model.bone[g.os].tete.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 ,
				model.bone[g.os].tete.pos.A ,
				1.4 ,
				1.4 ,
				10 ,
				10 )
		end
	end
	if timeline.canselect ~= 0 then
		love.graphics.setColor(255,255,100,alpha)
		for e,g in ipairs(model.model_data.anim[model.anim][timeline.canselect].bone) do
			love.graphics.draw( point ,
				(model.bone[g.os].tete.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 ,
				(model.bone[g.os].tete.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 ,
				model.bone[g.os].tete.pos.A ,
				1.3 ,
				1.3 ,
				10 ,
				10 )
		end
	end
	for i,h in ipairs(model.bone) do
		if i == bone.select then
			if i == bone.canselect then
				love.graphics.setColor(255,255,0,alpha)
			else
				love.graphics.setColor(0,255,0,alpha)
			end
		elseif i == bone.canselect then
			love.graphics.setColor(255,180,120,alpha)
		else
			love.graphics.setColor(255,255,255,alpha)
		end
		love.graphics.draw( os ,	(h.base.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 ,
						(h.base.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 ,
						h.tete.pos.A ,
						math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)/400*camera.zoom ,
						.4 ,
						0 ,
						25 )
	end
	for i,h in ipairs(model.bone) do
		if i == bone.select then
			if i == bone.canselect then
				love.graphics.setColor(255,255,0,alpha)
			else
				love.graphics.setColor(0,255,0,alpha)
			end
		elseif i == bone.canselect then
			love.graphics.setColor(255,180,120,alpha)
		else
			love.graphics.setColor(255,255,255,alpha)
		end
		if model.model_data.bone[i].tete.tipe ~= 2 then
			love.graphics.draw( point ,	(h.tete.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 ,
							(h.tete.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 ,
							h.tete.pos.A ,
							1 ,
							1 ,
							10 ,
							10 )
		end
	--	love.graphics.print( 	""..model.model_data.anim[model.anim][h.tete.anipos.passer.step].temp..","..model.model_data.anim[model.anim][h.tete.anipos.futur.step].temp.."" ,
	--				(model.pos.X+h.tete.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2+10 ,
	--				(model.pos.Y+h.tete.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2  )
	end
	if timeline.mode == "bone" then
		for i,h in ipairs(model.model_data.anim[model.anim]) do
			if i == timeline.select then
				if i ~= timeline.canselect then
					for u,k in ipairs(h.bone) do
						love.graphics.setColor(	125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2) , alpha )
						love.graphics.draw( bloom , (model.bone[k.os].base.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 , (model.bone[k.os].base.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 , model.bone[k.os].tete.pos.A , math.sqrt((model.bone[k.os].tete.pos.X-model.bone[k.os].base.pos.X)^2+(model.bone[k.os].tete.pos.Y-model.bone[k.os].base.pos.Y)^2)/361*camera.zoom , 1.1 , 0 , 5 )
					end
				else
					for u,k in ipairs(h.bone) do
						love.graphics.setColor(	125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2) , alpha )
						love.graphics.draw( bloom , (model.bone[k.os].base.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 , (model.bone[k.os].base.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 , model.bone[k.os].tete.pos.A , math.sqrt((model.bone[k.os].tete.pos.X-model.bone[k.os].base.pos.X)^2+(model.bone[k.os].tete.pos.Y-model.bone[k.os].base.pos.Y)^2)/361*camera.zoom , 1.1 , 0 , 5 )
					end
				end
			else
				if i == timeline.canselect then
					for u,k in ipairs(h.bone) do
						love.graphics.setColor(	50+50*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os),
									50+50*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2),
									50+50*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2) , alpha )
						love.graphics.draw( bloom , (model.bone[k.os].base.pos.X-camera.X)*camera.zoom+love.graphics.getWidth()/2 , (model.bone[k.os].base.pos.Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 , model.bone[k.os].tete.pos.A , math.sqrt((model.bone[k.os].tete.pos.X-model.bone[k.os].base.pos.X)^2+(model.bone[k.os].tete.pos.Y-model.bone[k.os].base.pos.Y)^2)/361*camera.zoom , 1.1 , 0 , 5 )
					end
				end
			end
		end
	end
end
function draw_bone_interface()
	if bone.select ~= 0 then
		love.graphics.setColor(0,255,0)
		for i,h in ipairs(model.model_data.anim[model.anim]) do
			for u,k in ipairs(h.bone) do
				if k.os == bone.select then
					if k.prestep.step > k.step then
						draw_ligne( ligne2 ,
								timeline.X+40*(model.model_data.anim[model.anim][k.prestep.step].tempo) ,
								timeline.Y+58 ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp) ,
								timeline.Y+58 , 1 )
						if i ~= 1 then
							draw_ligne( fleche , timeline.X , timeline.Y+58 , timeline.X+40*(h.tempo) , timeline.Y+58 , 1 )
						end
						love.graphics.draw(	colone ,
									timeline.X+40*(h.tempo) ,
									timeline.Y+70 , 0 , .5 , .5 ,
									colone:getWidth()/2 ,
									colone:getHeight() )
					else
						draw_ligne( fleche , timeline.X+40*(model.model_data.anim[model.anim][k.prestep.step].tempo) , timeline.Y+58 , timeline.X+40*(h.tempo) , timeline.Y+58 , 1 )
						love.graphics.draw(	colone ,
									timeline.X+40*(h.tempo) ,
									timeline.Y+70 , 0 , .5 , .5 ,
									colone:getWidth()/2 ,
									colone:getHeight() )
					end
				end
			end
		end
	end
	if bone.canselect ~= 0 then
		love.graphics.setColor(255,180,120)
	end
		love.graphics.print( 	bone.eta , 200 , 200  )
end
