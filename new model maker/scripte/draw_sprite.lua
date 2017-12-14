S.load = {prio = 14}
function S.load.F()
	cadre = load_image("cadre")
	cadre2 = load_image("cadre 2")
end


function draw_sprite_edit(model,alpha,select)

	for i,h in ipairs(model.sprite) do

		local img = model.model_data.sprite_list[model.model_data.sprite[i].sprite][h.frame]
		local a = model.bone[model.model_data.sprite[i].chef].tete.pos.A
		local A = model.bone[model.model_data.sprite[i].chef].tete.pos.A*model.model_data.sprite[i].eritrot+model.model_data.sprite[i].A
		local scale = model.bone[model.model_data.sprite[i].chef].tete.pos.scale
		local X = 0
		local Y = 0


		love.graphics.setColor(0,0,0,0)
		if model.model_data.sprite[i].eritscale == 0 then
			X = model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].L*math.cos(model.model_data.sprite[i].D+a)
			Y = model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].L*math.sin(model.model_data.sprite[i].D+a)

			if sprite.select == i then
				love.graphics.setColor(20,255,0,150)
			elseif sprite.select > i then
				love.graphics.setColor(0,0,0,250)
			end
			love.graphics.polygon( "fill", 	
						X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) )
			love.graphics.setColor(255,255,255,h.alpha/255*alpha)
			if sprite.select ~= 0 and sprite.select ~= i then
				love.graphics.setColor(150,150,150,h.alpha/255*alpha/2)
			end

			love.graphics.draw( 	img ,
						X_world_to_screen(X) ,
						Y_world_to_screen(Y) ,
						A ,
						model.model_data.sprite[i].sx*camera.zoom ,
						model.model_data.sprite[i].sy*camera.zoom ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		elseif model.model_data.sprite[i].eritscale == 1 then
			X = model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].X*math.cos(a)*scale+model.model_data.sprite[i].Y*math.sin(a)
			Y = model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].X*math.sin(a)*scale-model.model_data.sprite[i].Y*math.cos(a)
			if sprite.select == i then
				love.graphics.setColor(20,255,0,150)
			elseif sprite.select > i then
				love.graphics.setColor(0,0,0,250)
			end
			love.graphics.polygon( "fill", 	
						X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) )
			love.graphics.setColor(255,255,255,h.alpha/255*alpha)
			if sprite.select ~= 0 and sprite.select ~= i then
				love.graphics.setColor(150,150,150,h.alpha/255*alpha/2)
			end
			love.graphics.draw( 	img,
						X_world_to_screen(X) ,
						Y_world_to_screen(Y) ,
						A ,
						model.model_data.sprite[i].sx*camera.zoom*(1-(1-scale)*math.abs(math.cos(model.model_data.sprite[i].A))) ,
						model.model_data.sprite[i].sy*camera.zoom*(1-(1-scale)*math.abs(math.sin(model.model_data.sprite[i].A))) ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		elseif model.model_data.sprite[i].eritscale == 2 then
			X = model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].L*math.cos(model.model_data.sprite[i].D+a)*scale
			Y = model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].L*math.sin(model.model_data.sprite[i].D+a)*scale
			if sprite.select == i then
				love.graphics.setColor(20,255,0,150)
			elseif sprite.select > i then
				love.graphics.setColor(0,0,0,250)
			end
			love.graphics.polygon( "fill", 	
						X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

						X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
						Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) )

			love.graphics.setColor(255,255,255,h.alpha/255*alpha)
			if sprite.select ~= 0 and sprite.select ~= i then
				love.graphics.setColor(150,150,150,h.alpha/255*alpha/2)
			end
			love.graphics.draw( 	img ,
						X_world_to_screen(X) ,
						Y_world_to_screen(Y) ,
						A ,
						model.model_data.sprite[i].sx*camera.zoom*scale ,
						model.model_data.sprite[i].sy*camera.zoom*scale ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		end



		love.graphics.setColor(	127+127*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*i),
					127+127*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*i+math.pi/3*2),
					127+127*math.sin(2*math.pi/table.maxn(model.model_data.sprite)*i-math.pi/3*2)	)





		love.graphics.polygon( "line", 	
					X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
					Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

					X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
					Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

					X_world_to_screen(X+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
					Y_world_to_screen(Y+scale*(model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,

					X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
					Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) )

		love.graphics.print( i ,
					X_world_to_screen(X+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.cos(A)+model.model_data.sprite[i].sy*img:getHeight()/2*math.sin(A))) ,
					Y_world_to_screen(Y+scale*(-model.model_data.sprite[i].sx*img:getWidth()/2*math.sin(A)-model.model_data.sprite[i].sy*img:getHeight()/2*math.cos(A))) ,
					A
)


	end
end
function draw_sprite_interface()

--	love.graphics.draw( 	cadre ,
--				love.graphics.getWidth()-150 ,
--				125 ,
--				0 ,
--				1 ,
--				1 ,
--				3 ,
--				3 )
	if sprite.choix ~= 0 then
	--	math.floor(crono)-math.floor(crono/table.maxn(model.model_data.sprite_list[sprite.choix]))*table.maxn(model.model_data.sprite_list[sprite.choix])+1

	local img = model.model_data.sprite_list[sprite.choix][math.floor(2*crono)-math.floor(2*crono/table.maxn(model.model_data.sprite_list[sprite.choix]))*table.maxn(model.model_data.sprite_list[sprite.choix])+1]
	love.graphics.draw( 	img ,
				love.graphics.getWidth()-150 ,
				175 ,
				0 ,
				math.min(92/img:getWidth(),92/img:getHeight()) ,
				math.min(92/img:getWidth(),92/img:getHeight()) ,
				img:getWidth()/2 ,
				img:getHeight()/2 )
	end


	local i = table.maxn(model.sprite)
	while i > 0 do
		local h = model.sprite[i]
		local img = model.model_data.sprite_list[model.model_data.sprite[i].sprite][h.frame]

		local dec = math.sqrt(math.sqrt(100*math.abs(i-sprite.decsel)))
		if i > sprite.decsel then
			dec = -dec
		end
		love.graphics.draw( 	img ,
					175-1.2*math.abs(i-sprite.decsel) ,
					sprite.possel+25-15*dec ,
					0 ,
					math.min(50/img:getWidth(),50/img:getHeight()) ,
					math.min(50/img:getWidth(),50/img:getHeight()) ,
					img:getWidth()/2 ,
					img:getHeight()/2 )
		i = i-1
	end


	if sprite.select ~= 0 then
		love.graphics.setColor(0,255,0)
		for i,h in ipairs(model.model_data.anim[model.anim]) do
			for u,k in ipairs(h.sprite) do
				if k.spr == sprite.select then
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
	if sprite.canselect ~= 0 then
		love.graphics.setColor(255,180,120)
	end


end

