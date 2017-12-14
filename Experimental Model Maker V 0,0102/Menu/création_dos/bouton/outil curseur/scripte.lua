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
end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		tool_tag_Y = B.pos.Y+5
		set_mode(B)
		mouse.eta = 1
	end
end



function B.useupdate(dot)
	txt = mouse.eta
	if mouse.eta == 1 then
		choose_canselect()
	elseif mouse.eta == "pan" then
		camera.vpos.X = mouse.camX+(mouse.panX-love.mouse.getX())/ratio(0)/camera.zoom
		camera.vpos.Y = mouse.camY+(mouse.panY-love.mouse.getY())/ratio(0)/camera.zoom
	elseif mouse.eta == "clicking_os" then
		if (mouse.oX-mouse.pos.X)^2+(mouse.oY-mouse.pos.Y)^2 > (15/camera.zoom)^2 or mouse.T < chrono then
			mouse.eta = "moving_os"
			clear_list(bones.selection)
			add_data_to_a_list(bones.selection,mouse.canselect)
		end
	elseif mouse.eta == "moving_os" then
		local bonesel = bones.selection[1]
		if bonesel.data.tete.tipe ~= 2 then
			bonesel.L = math.sqrt((bonesel.base.pos.X-mouse.pos.X)^2+(bonesel.base.pos.Y-mouse.pos.Y)^2)
			if bonesel.data.tete.tipe == 0 then
				bonesel.data.tete.pos.X = mouse.pos.X
				bonesel.data.tete.pos.Y = mouse.pos.Y
			elseif bonesel.data.tete.tipe == 1 then
				bonesel.data.tete.vec.L = bonesel.L
				bonesel.data.tete.vec.D = math.atan2(mouse.pos.Y-bonesel.base.pos.Y,mouse.pos.X-bonesel.base.pos.X)-bonesel.base.vec.D
				bonesel.data.tete.L = bonesel.data.tete.vec.L
			end
			bonesel.tete.pos.X = mouse.pos.X
			bonesel.tete.pos.Y = mouse.pos.Y
			bonesel.tete.vec.D = math.atan2( bonesel.tete.pos.Y-bonesel.base.pos.Y , bonesel.tete.pos.X-bonesel.base.pos.X )-bonesel.base.vec.D
			bonesel.tete.vec.L = bonesel.L
			bonesel.tete.scale = 1
			bonesel.tete.pos.vec.D = math.atan2( bonesel.tete.pos.Y , bonesel.tete.pos.X )
			bonesel.tete.pos.vec.L = math.sqrt((bonesel.tete.pos.X)^2+(bonesel.tete.pos.Y)^2)
		else
			clear_list(bones.selection)
			mouse.canselect.pointed = nil
			mouse.canselect = bonesel.tete.pos.chef
			mouse.canselect.pointed = true
			add_data_to_a_list(bones.selection,mouse.canselect)
		end
		for i,h in ipairs(model_edit.bone) do
			h.tete.pos.scale = 1
			h.L = math.sqrt((h.base.pos.X-h.tete.pos.X)^2+(h.base.pos.Y-h.tete.pos.Y)^2)
		end
	elseif mouse.eta == "selz" then
		clear_list(bones.preselection)
		election_in_a_list(bones.selectable,bones.preselection,bone_dans_le_carre)
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
		else
			--txt = txt+1
			if bu == "wd" then
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
		--execute_en_silence(mouse.canselect.MR,mouse.canselect,mx,my,bu)
		clear_list(bones.selection)
		add_data_to_a_list(bones.selection,mouse.canselect)
		mouse.eta = 1
	elseif mouse.eta == "moving_os" then
		mouse.eta = 1
		add_historique(model_edit)
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





