S.load = {prio = 0}
function S.load.F()
	pointe = load_image("pointe.png")
	pointe2 = load_image("pointe2.png")
	triangle = load_image("triangle.png")
	pointe_demi = load_image("pointe demi.png")
	barre = load_image("barre.png")
	bloom = load_image("bloom.png")
	ligne = load_image("ligne.png")
	colone = load_image("colone.png")
	fleche = load_image("fleche.png")
	timeline = {}
	timeline.long = 800
	timeline.X = 340
	timeline.Y = love.graphics.getHeight()-60
end
function start_ligne_du_temp()
	timeline.select = 0
	timeline.canselect = 0
	time_eta = 0
	timeline.timer = 0
	timeline.mode = "bone"
	load_bouton("ressource/sous menu timeline")
end
function add_point(model_data,anim,tempo)
	local tempe = tempo
	local orloge = model.orloge

	model_jump(model,model.anim,model.orloge+.1)
	local new = {	bone = {} ,
		sprite = {} ,
		temp = .1 ,
		tempo = tempo ,
		id = "new"
				}
	local fin = tempo
	if table.maxn(model_data.anim[anim]) ~= 0 then
		fin = model_data.anim[anim][table.maxn(model_data.anim[anim])].tempo+model_data.anim[anim][table.maxn(model_data.anim[anim])].temp
	end
	local last = new
	local w = 1
	while w <= table.maxn(model_data.anim[anim]) do
		if last.tempo < model_data.anim[anim][w].tempo then
			last,model_data.anim[anim][w] = model_data.anim[anim][w],last
		end
		w = w+1
	end
	model_data.anim[anim][w] = last
	for i,h in ipairs(model_data.anim[anim]) do--  ¦3  (¬_¬) (ó_ò) (ò_ó) (ô_ô) (>_<) (o_o) (ò_ò) (ó_ó) (Ò_Ó) (@_@) (3_3)
		h.step = i			--     (u_u) (g_g) (ú_ù) (Ì_Í) (I_I) (0_¬) :) ¦) :( ¦( ;)   (>¸<) (=¸=)  Xb  XD
		if i > 1 then
			h.prestep = model_data.anim[anim][i-1]
			h.prestep.temp = h.tempo-h.prestep.tempo
		else
			h.prestep = model_data.anim[anim][table.maxn(model_data.anim[anim])]
			h.prestep.temp = fin-h.prestep.tempo
	--txt = h.tempo
		end
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		g.step = e
		for i,h in ipairs(g.bone) do
			h.step = e
		end
		for i,h in ipairs(g.sprite) do
			h.step = e
		end
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
		for i,h in ipairs(g.sprite) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
	end
	model_jump(model,model.anim,tempe)
	model.orloge = orloge
	return (new.step)
end
function remove_point(model_data,anim,step)
	local tempe = model.temp--model.orloge
	--model_jump(model,model.anim,model.orloge)
	local fin = model_data.anim[anim][table.maxn(model_data.anim[anim])].tempo+model_data.anim[anim][table.maxn(model_data.anim[anim])].temp

	for i,h in ipairs(model_data.anim[anim][step].bone) do
		h.prestep.pos = h.pos
	end
	for i,h in ipairs(model_data.anim[anim][step].sprite) do
		h.prestep.eta = h.eta
	end
	for i,h in ipairs(model_data.anim[anim]) do
		for e,g in ipairs(h.bone) do
			if g.prestep.step == step then
				g.prestep = g.prestep.prestep
			end
		end
		for e,g in ipairs(h.sprite) do
			if g.prestep.step == step then
				g.prestep = g.prestep.prestep
			end
		end
	end

	table.remove(model_data.anim[anim],step)
	for i,h in ipairs(model_data.anim[anim]) do
		h.step = i
		if i > 1 then
			h.prestep = model_data.anim[anim][i-1]
			h.prestep.temp = h.tempo-h.prestep.tempo
		else
			h.prestep = model_data.anim[anim][table.maxn(model_data.anim[anim])]
			h.prestep.temp = fin-h.prestep.tempo
	--txt = h.tempo
		end
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			h.step = e
		end
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
		for i,h in ipairs(g.sprite) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
	end
	model_jump(model,model.anim,model.orloge)
	model_jump(model,model.anim,tempe)
end
function MP_ligne_du_temp(mx,my,bu)
	if bu == "r" then
		if time_eta == 1 then
			timeline.timer = crono+.4
		end
	elseif bu == "l" then
		if timeline.canselect ~= 0 then
			if mode == "editer" then
				timeline.select = timeline.canselect
				model_jump(model,model.anim,model.orloge+model_data.anim[model.anim][timeline.select].tempo)
				time_eta = 2
				crono_mouse_ref = crono_mouse
			end
		else
			timeline.timer = crono
		end
	end
end
function MR_ligne_du_temp(mx,my,bu)
	if time_eta == 3
	or time_eta == 3.5 then
		time_eta = 0
	else
		if bu == "r" then
			if time_eta == 1 then
				if timeline.timer < crono then
					if timeline.canselect ~= 0 then
						timeline.select = timeline.canselect
						model.speed = 0
					end
				elseif mode == "editer" then
					if timeline.canselect == 0 then
						time_eta = 3
						timeline.ref = crono_mouse
						model_jump(model,model.anim,crono_mouse)
						model.speed = 0
					else
						time_eta = 3.5
						timeline.ref = model.model_data.anim[model.anim][timeline.canselect].tempo
						timeline.select = timeline.canselect
						model_jump(model,model.anim,model.orloge+model_data.anim[model.anim][timeline.select].tempo)
						model.speed = 0
					end
				end
			end
		elseif bu == "l" then
			if timeline.canselect ~= 0 then
				timeline.select = timeline.canselect
				model.speed = 0
			end
			if time_eta == 2
			or time_eta == 2.5 then
				time_eta = 0
			end
		end
	end
end
function update_ligne_du_temp(dot)
	timeline.canselect = 0
	if pointer == 0
	and love.mouse.getX() > timeline.X-15
	and love.mouse.getX() < timeline.X+timeline.long
	and love.mouse.getY() > timeline.Y-25
	and love.mouse.getY() < timeline.Y+50 then
		crono_mouse = math.max(0,(love.mouse.getX()-timeline.X)/timeline.long*20)
		if time_eta ==0 then
			time_eta = 1
		elseif time_eta == 1 then
			timeline.canselect = 0
			if love.mouse.getY() > timeline.Y-20
			and love.mouse.getY() < timeline.Y+15 then
				local near = .15
				for i,h in ipairs(model.model_data.anim[model.anim]) do
					local dist = math.abs(h.tempo-crono_mouse)
					if dist < near then
						near = dist
						timeline.canselect = i
					end
					if i == 1 then
						dist = math.abs(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp-crono_mouse)
						if dist < near then
							near = dist
							timeline.canselect = i
						end
					end
				end
			end
			if love.mouse.isDown("r") then
				if timeline.timer < crono then
					if timeline.canselect ~= 0 then
						model_jump(model,model.anim,model.orloge+model.model_data.anim[model.anim][timeline.canselect].tempo)
						--timeline.select = timeline.canselect
					else
						model_jump(model,model.anim,model.orloge+crono_mouse)
					end
					model.speed = 0
				end
			elseif love.mouse.isDown("l") then
				if timeline.canselect == 0 then
					model_jump(model,model.anim,model.orloge+crono_mouse)
				else
					model_jump(model,model.anim,model.orloge+model.model_data.anim[model.anim][timeline.canselect].tempo)

				end
				model.speed = 0
			end
		elseif time_eta == 2 then
			if math.abs(crono_mouse-crono_mouse_ref) > .05 then
				time_eta = 2.5
			end
		elseif time_eta == 2.5 then
			local round_crono_mouse = math.floor(crono_mouse*40)/40
--------------------------------------------------------------------------------------------------------------rrrrrrrrrrrreeeeeeeaf
			local tempe = model.temp
			model_jump(model,model.anim,model.orloge)
			--model.orloge = 0
			if timeline.select == 1 then
				model.model_data.anim[model.anim][timeline.select].prestep.temp = math.max(.1,round_crono_mouse-model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo)
			else
				round_crono_mouse = math.max(round_crono_mouse,model.model_data.anim[model.anim][timeline.select].prestep.tempo+.1)
				model.model_data.anim[model.anim][timeline.select].tempo = round_crono_mouse
				model.model_data.anim[model.anim][timeline.select].prestep.temp = math.max(.1,round_crono_mouse-model.model_data.anim[model.anim][timeline.select].prestep.tempo)
			end
			local temp = 0
			for e,g in ipairs(model_data.anim[model.anim]) do
				g.tempo = temp
				temp = temp+g.temp
			end
			for e,g in ipairs(model_data.anim[model.anim]) do
				for i,h in ipairs(g.bone) do
					if h.step >= h.prestep.step then
						h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
					else
						h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
					end
				end
				for i,h in ipairs(g.sprite) do
					if h.step >= h.prestep.step then
						h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
					else
						h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
					end
				end
			end
			model_jump(model,model.anim,tempe)
		end
	else
		if time_eta ~= 3
		and time_eta ~= 3.5 then
			time_eta = 0
		end
	end
end
function draw_ligne_du_temp(alpha)
	love.graphics.draw(	pointe_demi ,
				timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp) ,
				timeline.Y+8 ,
				0 ,
				1 ,
				1 	)
	love.graphics.draw(	pointe_demi ,
				timeline.X ,
				timeline.Y+8 ,
				0 ,
				-1 ,
				1	)
	love.graphics.setColor(255,255,255)
	for i,h in ipairs(model.model_data.anim[model.anim]) do
		if i == timeline.select then
			if i == timeline.canselect then
				love.graphics.setColor(255,225,100)
			else
				love.graphics.setColor(255,200,0)
			end
		else
			if i == timeline.canselect then
				love.graphics.setColor(255,255,200)
			else
				love.graphics.setColor(200,200,200)
			end
		end
		draw_ligne(	triangle ,
				timeline.X+40*(h.tempo) ,
				timeline.Y+18 ,
				timeline.X+40*(h.tempo+h.temp) ,
				timeline.Y+32 ,
				1 )
	end
	love.graphics.setFont( f )
	for i,h in ipairs(model.model_data.anim[model.anim]) do
--		for u,k in ipairs(h.bone) do
--			love.graphics.setColor(	125+125*math.sin(math.pi/table.maxn(model.model_data.bone)*k.os), 125+125*math.sin(math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2), 125+125*math.sin(math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2)	)
--			draw_ligne( fleche , timeline.X+40*(model.model_data.anim[model.anim][k.prestep.step].tempo) , timeline.Y-25*k.os , timeline.X+40*(h.tempo) , timeline.Y-25*k.os , 1 )
--		end
		if i == 1 then
			if i == timeline.select then
				if i == timeline.canselect then
					love.graphics.setColor(255,225,100)
					love.graphics.draw(	pointe ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp) ,
								timeline.Y+39 , 0 , 1.25 , 1.25 ,
								pointe:getWidth()/2 ,
								pointe:getHeight() )
					love.graphics.setColor(0,0,0)
					love.graphics.print( 	1 ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp)-6 ,
								timeline.Y-18 ,
								0 , 1.25 , 1.25 )
				else
					love.graphics.setColor(255,200,0)
					love.graphics.draw(	pointe ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp) ,
								timeline.Y+39 , 0 , 1.2 , 1.2 ,
								pointe:getWidth()/2 ,
								pointe:getHeight() )
					love.graphics.setColor(0,0,0)
					love.graphics.print( 	1 ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp)-6 ,
								timeline.Y-16 ,
								0 , 1.2 , 1.2 )
				end
			else
				if i == timeline.canselect then
					love.graphics.setColor(255,255,200)
					love.graphics.draw(	pointe ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp) ,
								timeline.Y+39 , 0 , 1.2 , 1.2 ,
								pointe:getWidth()/2 ,
								pointe:getHeight() )
					love.graphics.setColor(0,0,0)
					love.graphics.print( 	1 ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp)-6 ,
								timeline.Y-16 ,
								0 , 1.2 , 1.2 )
				else
					love.graphics.setColor(200,200,200)
					love.graphics.draw(	pointe ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp) ,
								timeline.Y+39 , 0 , 1 , 1 ,
								pointe:getWidth()/2 ,
								pointe:getHeight() )
					love.graphics.setColor(0,0,0)
					love.graphics.print( 	1 ,
								timeline.X+40*(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp)-5 ,
								timeline.Y-6 ,
								0 , 1 , 1 )
				end
			end
		end
		if i == timeline.select then
			if i == timeline.canselect then
				if timeline.mode == "bone" then
					for u,k in ipairs(h.bone) do
						love.graphics.setColor(	180+75*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os),
									180+75*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2),
									180+75*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2)	)
						draw_ligne( ligne , timeline.X+40*(h.tempo) , timeline.Y-2*k.os , timeline.X+40*(h.tempo+k.temp) , timeline.Y-2*k.os , 1 )
						
					end
				elseif timeline.mode == "sprite" then
					for u,k in ipairs(h.sprite) do
						love.graphics.setColor(	125+125*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr+math.pi/3*2),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr-math.pi/3*2)	)
						draw_ligne( ligne , timeline.X+40*(h.tempo) , timeline.Y-2*k.spr , timeline.X+40*(h.tempo+k.temp) , timeline.Y-2*k.spr , 1 )
					end
				end
				love.graphics.setColor(255,225,100)
				love.graphics.draw(	colone ,
							timeline.X+40*(h.tempo) ,
							timeline.Y , 0 , 1 , (1+table.maxn(model.model_data.bone))/50 ,
							colone:getWidth()/2 ,
							colone:getHeight() )
				love.graphics.draw(	pointe ,
							timeline.X+40*(h.tempo) ,
							timeline.Y+39 , 0 , 1.25 , 1.25 ,
							pointe:getWidth()/2 ,
							pointe:getHeight() )
				love.graphics.setColor(0,0,0)
				love.graphics.print( 	i ,
							timeline.X+40*(h.tempo)-6 ,
							timeline.Y-18 ,
							0 , 1.25 , 1.25 )
			else
				if timeline.mode == "bone" then
					for u,k in ipairs(h.bone) do
						love.graphics.setColor(	125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2)	)
						draw_ligne( ligne , timeline.X+40*(h.tempo) , timeline.Y-2*k.os , timeline.X+40*(h.tempo+k.temp) , timeline.Y-2*k.os , 1 )


					end
				elseif timeline.mode == "sprite" then
					for u,k in ipairs(h.sprite) do
						love.graphics.setColor(	125+125*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr+math.pi/3*2),
									125+125*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr-math.pi/3*2)	)
						draw_ligne( ligne , timeline.X+40*(h.tempo) , timeline.Y-2*k.spr , timeline.X+40*(h.tempo+k.temp) , timeline.Y-2*k.spr , 1 )
					end
				end
				love.graphics.setColor(255,200,0)
				love.graphics.draw(	colone ,
							timeline.X+40*(h.tempo) ,
							timeline.Y , 0 , 1 , (1+table.maxn(model.model_data.bone))/50 ,
							colone:getWidth()/2 ,
							colone:getHeight() )
				love.graphics.draw(	pointe ,
							timeline.X+40*(h.tempo) ,
							timeline.Y+39 , 0 , 1.2 , 1.2 ,
							pointe:getWidth()/2 ,
							pointe:getHeight() )
				love.graphics.setColor(0,0,0)
				love.graphics.print( 	i ,
							timeline.X+40*(h.tempo)-6 ,
							timeline.Y-16 ,
							0 , 1.2 , 1.2 )
			end
		else
			if i == timeline.canselect then
				if timeline.mode == "bone" then
					for u,k in ipairs(h.bone) do
						love.graphics.setColor(	50+50*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os),
									50+50*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os+math.pi/3*2),
									50+50*math.sin(2*math.pi/table.maxn(model.model_data.bone)*k.os-math.pi/3*2)	)
						draw_ligne( ligne , timeline.X+40*(h.tempo) , timeline.Y-2*k.os , timeline.X+40*(h.tempo+k.temp) , timeline.Y-2*k.os , 1 )

					end
				elseif timeline.mode == "sprite" then
					for u,k in ipairs(h.sprite) do
						love.graphics.setColor(	50+50*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr),
									50+50*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr+math.pi/3*2),
									50+50*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*k.spr-math.pi/3*2)	)
						draw_ligne( ligne , timeline.X+40*(h.tempo) , timeline.Y-2*k.spr , timeline.X+40*(h.tempo+k.temp) , timeline.Y-2*k.spr , 1 )
					end
				end
				love.graphics.setColor(255,255,200)
				love.graphics.draw(	colone ,
							timeline.X+40*(h.tempo) ,
							timeline.Y , 0 , 1 , (1+table.maxn(model.model_data.bone))/50 ,
							colone:getWidth()/2 ,
							colone:getHeight() )
				love.graphics.draw(	pointe ,
							timeline.X+40*(h.tempo) ,
							timeline.Y+39 , 0 , 1.2 , 1.2 ,
							pointe:getWidth()/2 ,
							pointe:getHeight() )
				love.graphics.setColor(0,0,0)
				love.graphics.print( 	i ,
							timeline.X+40*(h.tempo)-6 ,
							timeline.Y-16 ,
							0 , 1.2 , 1.2 )
			else
				love.graphics.setColor(200,200,200)
				love.graphics.draw(	pointe ,
							timeline.X+40*(h.tempo) ,
							timeline.Y+39 , 0 , 1 , 1 ,
							pointe:getWidth()/2 ,
							pointe:getHeight() )
				love.graphics.setColor(0,0,0)
				love.graphics.print( 	i ,
							timeline.X+40*(h.tempo)-5 ,
							timeline.Y-6 ,
							0 , 1 , 1 )
			end
			--	love.graphics.print( 	h.id ,
			--				timeline.X+40*(h.tempo)-5 ,
			--				timeline.Y-60 ,
			--				0 , 1 , 1 )
		end
	end
	love.graphics.setFont( ff )
	love.graphics.setColor(0,255,0)
	love.graphics.draw(	pointe2 ,
				timeline.X+40*(model.temp-model.orloge) ,
				timeline.Y+50 ,
				0 ,
				1 ,
				1 ,
				pointe2:getWidth()/2 ,
				pointe2:getHeight()	 )
	local fin = model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp
	if model.temp-model.orloge > fin-.5 then
		love.graphics.draw(	pointe2 ,
					timeline.X+40*(model.temp-fin-model.orloge) ,
					timeline.Y+50 ,
					0 ,
					math.min(1,math.abs((model.temp-model.orloge)-(fin-.5))/.5) ,
					math.min(1,math.abs((model.temp-model.orloge)-(fin-.5))/.5) ,
					pointe2:getWidth()/2 ,
					pointe2:getHeight()	 )
	elseif model.temp-model.orloge < .5 then
		love.graphics.draw(	pointe2 ,
					timeline.X+40*(model.temp+fin-model.orloge) ,
					timeline.Y+50 ,
					0 ,
					math.min(1,math.abs(.5-(model.temp-model.orloge))/.5) ,
					math.min(1,math.abs(.5-(model.temp-model.orloge))/.5) ,
					pointe2:getWidth()/2 ,
					pointe2:getHeight()	 )
	end
	--if bone.select ~= 0 then
	--	for e,g in ipairs(model.model_data.anim[model.anim]) do
	--		for i,h in ipairs(h.bone) do
	--			if h.os = 
	--				love.graphics.draw(	triangle ,
	--							timeline.X+40*(h.tempo-model.model_data.anim[model.anim][1].tempo) ,
	--							timeline.Y+30 , 0 ,
	--							1.25 ,
	--							1 ,
	--							0 ,
	--							pointe:getHeight() )
	--	end
	--end
	if time_eta == 1 then
		love.graphics.print( 	math.floor((crono_mouse)*20)/20 ,
					love.mouse.getX() ,
					timeline.Y-28 )
	elseif time_eta == 2 or time_eta == 2.5 then
		love.graphics.print( 	math.floor((crono_mouse)*20)/20 ,
					love.mouse.getX() ,
					timeline.Y-28 )
	elseif time_eta == 3 then
		love.graphics.print( 	math.floor((timeline.ref)*20)/20 ,
			timeline.X+40*(timeline.ref) ,
			timeline.Y-4 )
		love.graphics.setColor(180,180,180)
		love.graphics.draw(	pointe2 ,
					timeline.X+40*(timeline.ref) ,
					timeline.Y+50 ,
					0 ,
					1 ,
					1 ,
					pointe2:getWidth()/2 ,
					pointe2:getHeight()	 )
	elseif time_eta == 3.5 then
		love.graphics.print( 	math.floor((timeline.ref)*20)/20 ,
			timeline.X+40*(timeline.ref) ,
			timeline.Y-4 )
		love.graphics.setColor(180,180,180)
		love.graphics.draw(	pointe2 ,
					timeline.X+40*(timeline.ref) ,
					timeline.Y+50 ,
					0 ,
					1 ,
					1 ,
					pointe2:getWidth()/2 ,
					pointe2:getHeight()	 )
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw(	barre ,
				timeline.X-5 ,
				timeline.Y+10 ,
				0 ,
				.5 ,
				.5	 )
--	love.graphics.print( 	"time_eta="..time_eta.."" ,
--				timeline.X ,
--				timeline.Y-150 )
--	love.graphics.setColor(	125+125*math.sin(math.pi/10*crono),
--				125+125*math.sin(math.pi/10*crono+math.pi/3*2),
--				125+125*math.sin(math.pi/10*crono-math.pi/3*2)	)
	love.graphics.print( 	"frame="..model.frame.."" ,
				timeline.X-220 ,
				timeline.Y-20 )
	love.graphics.print( 	"temp="..(math.floor((model.temp-model.orloge)*20)/20).." s" ,
				timeline.X-260 ,
				timeline.Y+10 )
	love.graphics.print( ""..(math.floor(model.speed*100)/100).."" ,
				timeline.X-150 ,
				timeline.Y-110 )
end
