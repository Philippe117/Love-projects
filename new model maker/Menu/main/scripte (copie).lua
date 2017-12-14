function I.load(I)
	cadre = load_image("cadre")



end
function I.demare(I)
	tempo = 0
	tool = "souris"
	base = {pos = { X = 0 , Y = 0 }}

	pointe_anim = 0
end
function I.deload(I)
end
function I.MP(I,mx,my,bu)
	if bu == "l"
	and pointer == 0 then

		if tool_mode == 0 then

			if love.mouse.getX() > timeline.X
			and love.mouse.getX() < timeline.X+800
			and love.mouse.getY() > timeline.Y
			and love.mouse.getY() < timeline.Y+50 then
				tool_mode = "move"
				model_blink_anim(model,model.anim,(love.mouse.getX()-timeline.X)/800*20)
				model.speed = 0
			end


		end
		--if tool_mode ~= "move" then



			if love.mouse.getX() < timeline.X
			or love.mouse.getX() > timeline.X+800
			or love.mouse.getY() < timeline.Y
			or love.mouse.getY() > timeline.Y+50 then
				select = canselect
			end
			if tool == "os" then
				if love.mouse.getX() < timeline.X
				or love.mouse.getX() > timeline.X+800
				or love.mouse.getY() < timeline.Y
				or love.mouse.getY() > timeline.Y+50 then
					base = {}
					if select == 0 then
						base.pos = { X = moux , Y = mouy }
						base.A = {0}
						base.tipe = 0
					else
						base.pos = select
						base.tipe = 1
					end
				end
			elseif tool == "anim_os" then
				--if select ~= 0 then
				--	tool_mode = "grab"
				--end
				if canselect ~= 0 then
					tool_mode = "grab_os_1"
					model.speed = 0
					mix = moux
					miy = mouy
				end


				if pointe_anim ~= 0 then
					tool_mode = "grab_anim_1"
					anim_os_sel = pointe_anim
					grx = love.mouse.getX()
					if anim_os_sel ~= 0
					and select ~= 0 then
						model_blink_anim(model,model.anim,model.model_data.bone[select].tete.anim[model.anim][anim_os_sel].temp)
						if model.speed ~= 0 then
							bout_play.clic_gauche(bout_play)
						end
					end
				end
			elseif tool == "anim_sprite" then
				if pointe_anim ~= 0 then
					tool_mode = "grab_anim_1"
					anim_os_sel = pointe_anim
					grx = love.mouse.getX()
					if anim_os_sel ~= 0
					and sprite_sel ~= table.maxn(model.sprite)+1 then
						model_blink_anim(model,model.anim,model.model_data.sprite[sprite_sel].anim[model.anim][anim_os_sel].temp)
						if model.speed ~= 0 then
							bout_play.clic_gauche(bout_play)
						end
					end
				end

			end


		--end

	else
		base = nil
	end
end
function I.MR(I,mx,my,bu)
	if tool == "os" then
		if bu == "l"
		and base ~= nil
		and pointer == 0 then
			local newbone = {}
			newbone.base = {}
			newbone.tete = {}
			local x = 0
			local y = 0
			local a = 0
			if base.tipe == 0 then
				newbone.base.pos = base.pos
				newbone.base.tipe = 0
				x = base.pos.X
				y = base.pos.Y
				a = 0
			elseif base.tipe == 1 then
				newbone.base.pos = select
				newbone.base.tipe = 1
				x = model.bone[base.pos].tete.pos.X
				y = model.bone[base.pos].tete.pos.Y
				a = model.bone[base.pos].tete.A[1]
			end
			newbone.tete.L = math.sqrt((moux-x)^2+(mouy-y)^2)
			newbone.tete.eritrot = tool_mode2
			newbone.tete.anim = {}
			if canselect ~= 0 then
				newbone.tete.tipe = 2
				newbone.tete.pos = canselect
			elseif tool_mode == 0 then
				newbone.tete.tipe = 0
				for i,h in ipairs(model.model_data.anim) do
					newbone.tete.anim[i] = {{ temp = .5 , pos = { X = moux , Y = mouy }}}
					if newbone.tete.input ~= nil then
						newbone.tete.anim[i][1].input = 0
					end
				end
			else
				newbone.tete.tipe = 1
				local D = math.atan2(mouy-y,moux-x)
				if tool_mode2 == 1 then
					D = D-a
				end
				for i,h in ipairs(model.model_data.anim) do
					newbone.tete.anim[i] = {{ temp = .5 , vec = { D = D , L = newbone.tete.L}}}
					if newbone.tete.input ~= nil then
						newbone.tete.anim[i][1].input = 0
					end
				end
			end
			if newbone.tete.L > 15/zoom then
				table.insert( model.model_data.bone , newbone )
				table.insert( model.bone , create_bone(model,newbone ) )
				local sp = model.speed
				model.speed = .00000001
				update_model(model,0)
				model.speed = sp
				model.fin_anim = model.fin_anim+1
			end
		end
	elseif tool == "anim_os" then
		--if tool_mode == "grab" then
		--	tool_mode = 0
		--end
		if tool_mode == "grab_anim_1"
		or tool_mode == "grab_anim_2"
		or tool_mode == "grab_os_1"
		or tool_mode == "grab_os_2" then
			tool_mode = 0
		end
	elseif tool == "anim_sprite" then
		--if tool_mode == "grab" then
		--	tool_mode = 0
		--end
		if tool_mode == "grab_anim_1"
		or tool_mode == "grab_anim_2" then
			tool_mode = 0
		end

	end
	if tool_mode == "move" then
		tool_mode = 0
	end


end
function I.KP(I,k)
	if k == "escape" then
		love.event.push('quit')
	elseif k == "delete" then
		remove_bone(select)
	end
end
function I.KR(I,k)
end
function I.update(I,dot)
	if pointer == 0 then
		canselect = 0
		local near_dist = 15/zoom
		for i,h in ipairs(model.bone) do	
			if h ~= select then
				local dist = math.sqrt((h.tete.pos.X-math.cos(h.tete.pos.A)/10-moux)^2+(h.tete.pos.Y-math.sin(h.tete.pos.A)/10-mouy)^2)
				if dist < near_dist then
					near_dist = dist
					canselect = i
				end
			end
		end
	end
	if pointer == 0 then
		if tool == "anim_os" then
			if select ~= 0
			and model.model_data.bone[select].tete.tipe ~= 2 then
				if tool_mode == "grab_os_1" then
					local dist = math.sqrt((moux-mix)^2+(mouy-miy)^2)
					if dist > 5/zoom then
						model.model_data.anim[model.anim].temp = math.max(model.model_data.anim[model.anim].temp,model.temp)

						tool_mode = "grab_os_2"
						local cache = {temp = model.temp}
						if model.model_data.bone[select].tete.tipe == 0 then
							cache.pos = { X = moux , Y = mouy }
						elseif model.model_data.bone[select].tete.tipe == 1 then

							local L = math.sqrt((moux-model.bone[select].base.pos.X)^2+(mouy-model.bone[select].base.pos.Y)^2)
							local D = math.atan2(mouy-model.bone[select].base.pos.Y,moux-model.bone[select].base.pos.X)
							if model.model_data.bone[select].tete.eritrot == 1 then
								D = D-model.bone[select].base.A[1]
							end
							cache.vec = { D = D , L = L }

						end





					end
				elseif tool_mode == "grab_os_2" then
					local cache = {temp = model.temp}
					if model.model_data.bone[select].tete.tipe == 0 then
						cache.pos = { X = moux , Y = mouy }
					elseif model.model_data.bone[select].tete.tipe == 1 then


						local L = 1
						if affect_long == 0 then
							L = math.sqrt((model.bone[select].tete.pos.X-model.bone[select].base.pos.X)^2+(model.bone[select].tete.pos.Y-model.bone[select].base.pos.Y)^2)

						else
							L = math.sqrt((moux-model.bone[select].base.pos.X)^2+(mouy-model.bone[select].base.pos.Y)^2)
						end


						local D = math.atan2(mouy-model.bone[select].base.pos.Y,moux-model.bone[select].base.pos.X)
						if model.model_data.bone[select].tete.eritrot == 1 then
							D = D-model.bone[select].base.A[1]
						end
						cache.vec = { D = D , L = L }

					end
					model.model_data.bone[select].tete.anim[model.anim][truck] = cache


					model_blink_anim(model,model.anim,model.temp)	



				else
					pointe_anim = 0
					if math.abs((timeline.Y+15)-love.mouse.getY()) < 10 then
						local near = 8
						for i,h in ipairs(model.model_data.bone[select].tete.anim[model.anim]) do
							local dist = math.abs((timeline.X+5+40*h.temp)-love.mouse.getX())
							if dist < near then
								pointe_anim = i
							end
						end
					end
				end
			end
			if anim_os_sel ~= 0 then
		
				if tool_mode == "grab_anim_1" then
					if math.abs(grx-love.mouse.getX()) > 3 then
						tool_mode = "grab_anim_2"
						wert = model.model_data.anim[model.anim].temp
					end
				elseif tool_mode == "grab_anim_2" then

					local min = 0
					local max = 0
					local val = (love.mouse.getX()-timeline.X)/40
					if anim_os_sel == 1 then
						min = 0
					else
						min = model.model_data.bone[select].tete.anim[model.anim][anim_os_sel-1].temp+.05
					end
					if anim_os_sel == table.maxn(model.model_data.bone[select].tete.anim[model.anim]) then
						max = 1000
						model.model_data.anim[model.anim].temp = math.max(wert,val)
					else
						max = model.model_data.bone[select].tete.anim[model.anim][anim_os_sel+1].temp-.05
					end
					model.model_data.bone[select].tete.anim[model.anim][anim_os_sel].temp = math.min(math.min(val,max),max)
					model_blink_anim(model,model.anim,val)
				end
			end

		elseif tool == "anim_sprite" then

			if anim_os_sel ~= 0 then
		
				if tool_mode == "grab_anim_1" then
					if math.abs(grx-love.mouse.getX()) > 3 then
						tool_mode = "grab_anim_2"
						wert = model.model_data.anim[model.anim].temp
					end
				elseif tool_mode == "grab_anim_2" then

					local min = 0
					local max = 0
					local val = (love.mouse.getX()-timeline.X)/40
					if anim_os_sel == 1 then
						min = 0
					else
						min = model.model_data.sprite[sprite_sel].anim[model.anim][anim_os_sel-1].temp+.05
					end
					if anim_os_sel == table.maxn(model.model_data.sprite[sprite_sel].anim[model.anim]) then
						max = 1000
						model.model_data.anim[model.anim].temp = math.max(wert,val)
					else
						max = model.model_data.sprite[sprite_sel].anim[model.anim][anim_os_sel+1].temp-.05
					end
					model.model_data.sprite[sprite_sel].anim[model.anim][anim_os_sel].temp = math.min(math.min(val,max),max)
					model_blink_anim(model,model.anim,val)

				end
			end


			pointe_anim = 0
			if math.abs((timeline.Y+15)-love.mouse.getY()) < 10 then
				local near = 8
				for i,h in ipairs(model.model_data.sprite[sprite_sel].anim[model.anim]) do
					local dist = math.abs((timeline.X+5+40*h.temp)-love.mouse.getX())
					if dist < near then
						pointe_anim = i
					end
				end
			end




		end






		if tool_mode == "move" then
			model_blink_anim(model,model.anim,math.max(.2,(love.mouse.getX()-timeline.X)/800*20))
		end


	end
	update_model(model,dot)
end
function I.draw(I)
	love.graphics.setColor(255,255,255)
	love.graphics.draw( grille ,	(0-cam_x  )*zoom+love.graphics.getWidth()/2 ,
					(0-cam_y  )*zoom+love.graphics.getHeight()/2 ,
					0,zoom,zoom,200,200)
	--if draw_mode == 1 then
		draw_bone(model,255)
	--elseif draw_mode == 2 then
	--	draw_sprite(model,255)
	--	draw_bone(model,255)
	--elseif draw_mode == 3 then
	--	draw_sprite(model,255)
	--end


if false then

	love.graphics.draw( 	cadre ,
				0 ,
				500,
				0,
				.5 )
	local i = table.maxn(model.sprite)+1
	while i > 1 do
		i = i-1
		local h = model.sprite[i]
		love.graphics.setColor(255,255,255)
		local ey = 500-math.sqrt(math.sqrt(i-sprite_sel))*100
		local ex = -math.abs(i-sprite_sel)*20
		if (i-sprite_sel) < 0 then
			ey = 500+math.sqrt(math.sqrt(sprite_sel-i))*100
		end
		if i == sprite_sel then
			love.graphics.setColor(255,255,255,h.alpha)
		else
			love.graphics.setColor(155,155,155,h.alpha)
		end
		local img = model.model_data.sprite_list[model.model_data.sprite[i].sprite][h.frame]
		love.graphics.draw( 	img ,
					ex+4+50 ,
					ey+4+50 ,
					0 ,
					math.min(92/img:getWidth(),92/img:getHeight()) ,
					math.min(92/img:getWidth(),92/img:getHeight()) ,					
					img:getWidth()/2 ,
					img:getHeight()/2 )
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw( 	cadre ,
				love.graphics.getWidth()-100 ,
				504,
				0,
				.5 )
	local img = model.model_data.sprite_list[sprite_choisi][1]
	love.graphics.draw( 	img ,
				love.graphics.getWidth()-96 ,
				504 ,
				0,
				math.min(92/img:getWidth(),92/img:getHeight()))

end

	love.graphics.setColor(255,255,255)
		if tool == "anim_os" then
			if select ~= 0
			and model.model_data.bone[select].tete.tipe ~= 2 then
				for i,h in ipairs(model.model_data.bone[select].tete.anim[model.anim]) do
					if anim_os_sel == i then
						love.graphics.setColor(0,255,0)
						if pointe_anim == i then
							love.graphics.setColor(255,180,0)
						end
					elseif pointe_anim == i then
						love.graphics.setColor(255,255,0)
					else
						love.graphics.setColor(255,255,255)
					end
					love.graphics.draw(	pointe ,
					timeline.X+40*h.temp ,
					timeline.Y+2 ,
					0 ,
					.6 ,
					.8
						)
				end
			end
		elseif tool == "anim_sprite" then
			if sprite_sel ~= table.maxn(model.sprite)+1 then
				for i,h in ipairs(model.model_data.sprite[sprite_sel].anim[model.anim]) do
					if anim_os_sel == i then
						love.graphics.setColor(0,255,0)
						if pointe_anim == i then
							love.graphics.setColor(255,180,0)
						end
					elseif pointe_anim == i then
						love.graphics.setColor(255,255,0)
					else
						love.graphics.setColor(255,255,255)
					end				
					love.graphics.draw(	pointe ,
					timeline.X+40*h.temp ,
					timeline.Y ,
					0 ,
					.6 ,
					.8
						)
				end
			end





		end
		draw_atach(model,255)

		love.graphics.setColor(255,255,255)
	--	love.graphics.draw(	pointe_demi ,
	--				timeline.X+12+40*model.model_data.anim[model.anim].temp ,
	--				timeline.Y ,
	--				0 ,
	--				-1 ,
	--				1.2
	--				)

	if model ~= nil then
		draw_ligne_du_temp(255)
	end




	love.graphics.print( 	""..(math.floor(model.orloge*100)/100).."" ,
				timeline.X-90 ,
				timeline.Y+10 )



	love.graphics.setColor(255,255,255)
	love.graphics.setFont( ff )
	love.graphics.print( "speed = "..(math.floor(model.speed*100)/100).."" , 500 , 60 )
--	love.graphics.print( "tool = "..tool.."" , 0 , 200 )
--	love.graphics.print( "toolmode = "..tool_mode.."" , 0 , 250 )

--	love.graphics.print( "sel = "..anim_os_sel.."" , 200 , 80 )
--	love.graphics.print( "temp = "..model.temp.."" , 200 , 100 )
--	love.graphics.print( "ratio = "..(math.floor((1+(tempo-crono)/animation[anim][nextframe].tempo)*10)/10).."" , 220 , 120 )
--	love.graphics.print( "-ratio = "..1-(math.floor((1+(tempo-crono)/animation[anim][nextframe].tempo)*10)/10).."" , 220 , 140 )
end

