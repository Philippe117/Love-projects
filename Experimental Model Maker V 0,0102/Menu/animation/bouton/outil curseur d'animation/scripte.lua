function B.load(B)				
	B.pos.X = TTX
	B.pos.Y = TTY
	B.Width = 60
	B.Height = 60
	--bouton_set_text(B,"exit")
	zero_tool = B.pos.Y+5
	tool_tag_Y = zero_tool
	bouton_curseur = B
	B.popup_text = "Choisir l'outil qui permet de sélectionner ou déplacer des os."
	mouse.time = 0


end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		tool_tag_Y = B.pos.Y+5
		set_mode(B)
		mouse.eta = 1
	end
end
function find_Pcansel()

	if model_edit.animation and love.mouse.getX() > TLX and math.abs(love.mouse.getY()-(TLY-30)) < 15 then
		local Pmin = 10
		for i,h in ipairs(model_edit.anim_points[model_edit.animation]) do
			local minus = math.abs(love.mouse.getX()-Timeline_to_screen(h.temps))
			if minus < Pmin then
				Pcansel = h
				Pmin = minus
			end
		end
		if Pmin == 10 then
			if Pcansel then
				for i,h in ipairs(Pcansel.bone) do
					h.eta.preselected = false
				end
			end
			Pcansel = nil
		elseif Pcansel then
			for i,h in ipairs(Pcansel.bone) do
				h.eta.preselected = true
			end
		end
	elseif Pcansel then
		for i,h in ipairs(Pcansel.bone) do
			h.eta.preselected = false
		end
		Pcansel = nil
	end


	return (Pcansel or false)
end

function B.useupdate(dot)
	txt = mouse.eta
	if mouse.eta == 1 then
		choose_canselect()
		if love.mouse.getX() > TLX and love.mouse.getY() > TLY-100 then
			mouse.eta = "anim"
		end
	elseif mouse.eta == "pan" then
		camera.vpos.X = mouse.camX+(mouse.panX-love.mouse.getX())/ratio(0)/camera.zoom
		camera.vpos.Y = mouse.camY+(mouse.panY-love.mouse.getY())/ratio(0)/camera.zoom
	elseif mouse.eta == "selz" then
		clear_list(bones.preselection)
		election_in_a_list(bones.selectable,bones.preselection,bone_dans_le_carre)
	elseif mouse.eta == "anim" then
		find_Pcansel()
		if not( love.mouse.getX() > TLX and love.mouse.getY() > TLY-100) then
			mouse.eta = 1
		end
	elseif mouse.eta == "grabtime" then
		TLO = math.max(0,TLO-(math.max(0,TLX+100-love.mouse.getX())*dot/TLZ)*2)
		TLO = TLO-(math.min(0,love.graphics.getWidth()-100-love.mouse.getX())*dot/TLZ)*2
		if find_Pcansel() then
			mouse.time = Pcansel.temps
			model_set_anim(model_edit,NC,mouse.time,0,.1)
		else
			mouse.time = math.floor(screen_to_Timeline(love.mouse.getX())*20+.5)/20
			model_set_anim(model_edit,NC,mouse.time,0,.1)
		end
	elseif mouse.eta == "grabpoint" then
		local time = math.max(math.floor(screen_to_Timeline(love.mouse.getX())*20)/20,mouse.lim)
		if chrono > mouse.T or math.abs(time-mouse.oldtime) > .1 then
			--Psel.temps = time
			for i = mouse.i ,table.maxn(model_edit.anim_points[model_edit.animation]) do

				local h = model_edit.anim_points[model_edit.animation][i]
				h.temps = h.oldtime+time-mouse.oldtime
			end
			for e,g in ipairs(model_edit.data.anim[model_edit.animation].bone) do
				if g[0] then
					for i = g.mid , table.maxn(g) do
						local h = g[i]
						h.temps = h.oldtime+time-mouse.oldtime
					end
				end
			end
			model_set_anim(model_edit,NC,Pcansel.temps,0,.2)
			--txt2 = txt2+1
		end
	elseif mouse.eta == "pantime" then

		mouse.TLO = math.max(0,mouse.TLO+(math.max(0,TLX+100-love.mouse.getX())*dot/TLZ)*2)
		mouse.TLO = mouse.TLO+(math.min(0,love.graphics.getWidth()-100-love.mouse.getX())*dot/TLZ)*2
		TLO = math.max(0,mouse.TLO+(mouse.panX-love.mouse.getX())/TLZ)



	elseif mouse.eta == "clicking_os" then

		if (mouse.oX-mouse.pos.X)^2+(mouse.oY-mouse.pos.Y)^2 > (15/camera.zoom)^2 or mouse.T < chrono then
			if mouse.canselect.data.tete.tipe ~= 2 then
				clear_list(bones.selection)
				add_data_to_a_list(bones.selection,mouse.canselect)

				Pbsel  = determine_animation_point(mouse.canselect)
				mouse.eta = "animating_os"
				model_set_anim(model_edit,NC,NC,0)
				
			else
				clear_list(bones.selection)
				mouse.canselect.pointed = nil
				mouse.canselect = mouse.canselect.tete.pos.chef
				mouse.canselect.pointed = true
				add_data_to_a_list(bones.selection,mouse.canselect)
			end

		end

	elseif mouse.eta == "animating_os" then

		local bn = bones.selection[1]
		if bn.data.tete.tipe == 0 then
			Pbsel.pos.X = mouse.pos.X
			Pbsel.pos.Y = mouse.pos.Y

		elseif bn.data.tete.tipe == 1 then
			Pbsel.vec.L = math.sqrt((bn.base.pos.X-mouse.pos.X)^2+(bn.base.pos.Y-mouse.pos.Y)^2)
			Pbsel.vec.D = math.atan2(mouse.pos.Y-bn.base.pos.Y,mouse.pos.X-bn.base.pos.X)-2*bn.base.vec.D*bn.tete.vec.eritrot
		end





	end
end






function B.useMP(mx,my,bu)
	if mouse.eta == 1 then
		if mouse.canselect then
			if bu == "l" then
				mouse.eta = "clicking_os"
				mouse.T = chrono+.5
				mouse.oX = mouse.pos.X
				mouse.oY = mouse.pos.Y
			end
		elseif bu == "wd" then
			if camera.zoom > .02 then
				camera.vzoom = .9*camera.vzoom
				camera.vpos.X =camera.vpos.X+.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/camera.zoom/ratio(0)
				camera.vpos.Y =camera.vpos.Y+.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/camera.zoom/ratio(0)
			end
		elseif bu == "wu" then
			if camera.zoom < 20 then
				camera.vzoom = 1.1*camera.vzoom
				camera.vpos.X = camera.vpos.X-.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/camera.zoom/ratio(0)
				camera.vpos.Y = camera.vpos.Y-.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/camera.zoom/ratio(0)
			end
		elseif bu == "m" then
			mouse.eta = "pan"
			mouse.panX , mouse.panY = love.mouse.getX() , love.mouse.getY()
			mouse.camX , mouse.camY = camera.pos.X , camera.pos.Y
		elseif bu == "l" then
			mouse.eta = "selz"
			mouse.selzX , mouse.selzY = mouse.pos.X , mouse.pos.Y
		end
	elseif  mouse.eta == "anim" then
		if bu == "l" then
			if Pcansel then
				mouse.T = chrono+.5
				mouse.oldtime = math.floor(screen_to_Timeline(love.mouse.getX())*20)/20
				model_set_anim(model_edit,NC,Pcansel.temps,0,.2)
				Psel = Pcansel
				copy_list(Pcansel.bone,bones.selection)
				mouse.eta = "grabpoint"
				
				mouse.time = Psel.temps
				for i,h in ipairs(model_edit.anim_points[model_edit.animation]) do
					h.oldtime = h.temps
					if h.temps <= Psel.temps then
						mouse.i = i
					end
				end
				mouse.lim = 0

				for e,g in ipairs(model_edit.data.anim[model_edit.animation].bone) do
					if g[0] then
						for i = 0 , table.maxn(g) do
							local h = g[i]
							h.oldtime = h.temps
							if h.temps <= Psel.temps then
								g.mid = i
								if h.temps < Psel.temps then
									mouse.lim = h.temps+0.05
								end
							end
						end
					end
				end

			else
				mouse.eta = "grabtime"
			end

		elseif bu == "wd" then
			if TLZ > 10 then
				TLZ = .9*TLZ
				TLO =math.max(0,TLO-.1*(love.mouse.getX()-TLX)/TLZ)

			end
		elseif bu == "wu" then
			if TLZ < 400 then
				TLZ = 1.1*TLZ
				TLO =math.max(0,TLO+.1*(love.mouse.getX()-TLX)/TLZ)
			end
		elseif bu == "m" then
			mouse.eta = "pantime"
			mouse.panX = love.mouse.getX()
			mouse.TLO = TLO


		end
	end
end
function B.useMR(mx,my,bu)
	if mouse.eta == 1 then
		if mouse.canselect then
			execute_en_silence(mouse.canselect.MR,mouse.canselect,mx,my,bu)
		end
	elseif mouse.eta == "pan" then
		if bu == "m" then
			mouse.eta = 1
		end
	elseif mouse.eta == "clicking_os" then
		if bu == "l" then
			clear_list(bones.selection)
			add_data_to_a_list(bones.selection,mouse.canselect)
			mouse.eta = 1
		end
	elseif mouse.eta == "selz" then
		if bu == "l" then
			mouse.eta = 1
			if not love.keyboard.isDown( "lshift" ) and not love.keyboard.isDown( "rshift" ) then
				copy_list( bones.preselection , bones.selection )
				clear_list( bones.preselection )
			else
				add_list( bones.preselection , bones.selection )
				clear_list( bones.preselection )
			end
		end
	elseif mouse.eta == "grabtime" then
		if bu == "l" then
			if Pcansel then
				Psel = Pcansel
				copy_list(Pcansel.bone,bones.selection)
			else
				Psel = nil
			end
			mouse.eta = "anim"
		end
	elseif mouse.eta == "grabpoint" then
		if bu == "l" then
			mouse.eta = 1
		end
	elseif mouse.eta == "pantime" then
		if bu == "m" then
			mouse.eta = 1
		end
	elseif mouse.eta == "animating_os" then
		mouse.eta = 1
	end
end
function B.useDraw()
	if mouse.eta == "selz" then
		local sX = (mouse.selzX-mouse.pos.X)*ratio(0)*camera.zoom
		local sY = (mouse.selzY-mouse.pos.Y)*ratio(0)*camera.zoom
		love.graphics.rectangle( "line", love.mouse.getX() , love.mouse.getY(), sX , sY )
	end
end
function B.condition()
	return(true)
end
function B.draw()
end





