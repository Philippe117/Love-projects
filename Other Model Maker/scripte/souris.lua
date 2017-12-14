local new = new_function(fonction,"load",0)
function new.F()
	mouse = {}
	mouse.eta = 1
	mouse.pos = {X=0,Y=0}
	tool_tag = load_image("curceur doutil")
	tool_tag_Y = 0
	mouse.pretool = 0
	mouse.tool = 0
	mouse.selectable = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",-1,false),"selectable",true)
end
local new = new_function(fonction,"update",0)
function new.F(dot)
	txt = mouse.eta
	mouse.pos.X , mouse.pos.Y = pos_screen_to_world(love.mouse.getX(),love.mouse.getY(),0)
	if mouse.eta == 1 then
		if mouse.canselect then mouse.canselect.pointed = nil end
		mouse.canselect = nil
		local oldval = 100000
		for i,h in ipairs(mouse.selectable) do
			local sel , val = execute_en_silence(h.amIselectable,h)
			if sel and ( not val or val < oldval ) then
				if mouse.canselect then mouse.canselect.pointed = nil end
				mouse.canselect = h
				h.pointed = true
				oldval = val or oldval
				--txt = oldval
			end

		end
	elseif mouse.eta == "pan" then
		camera.vpos.X = mouse.camX+(mouse.panX-mouse.pos.X)*9
		camera.vpos.Y = mouse.camY+(mouse.panY-mouse.pos.Y)*9
	elseif mouse.eta == "creating_os" then


		if mouse.canselect then
			if mouse.canselect.tete then mouse.canselect.tete.pointed = nil end
			if mouse.canselect.point then mouse.canselect.point.pointed = nil end
		end
		mouse.canselect = nil
		local oldval = 100000
		for i,h in ipairs(bones.selectable) do
			--h.pointed = nil
			local sel , val = execute_en_silence(h.tete.amIselectable,h.tete)
			if sel and ( not val or val < oldval ) then
				if mouse.canselect then
					mouse.canselect.tete.pointed = nil
					mouse.canselect.point.pointed = nil
				end
				mouse.canselect = h
				h.tete.pointed = true
				oldval = val or oldval
				--txt = oldval
			end
			local sel , val = execute_en_silence(h.point.amIselectable,h.point)
			if sel and ( not val or val < oldval ) then
				if mouse.canselect then
					mouse.canselect.tete.pointed = nil
					mouse.canselect.point.pointed = nil
				end
				mouse.canselect = h
				h.tete.pointed = true
				oldval = val or oldval
				--txt = oldval
			end



		end

	elseif mouse.eta == "clicking_os" then
		if (mouse.oX-mouse.pos.X)^2+(mouse.oY-mouse.pos.Y)^2 > (15/camera.zoom)^2 or mouse.T < chrono then
			mouse.eta = "moving_os"
		--	if mouse.canselect.chef.data.tete.tipe == 2 then
		--		if mouse.tool == "create_os_coord" then
		--			mouse.canselect.chef.data.tete = {tipe=0}
		--			mouse.canselect.chef.data.tete.pos = {X=mouse.pos.X,Y=mouse.pos.Y}
		--		elseif mouse.tool == "create_os_vector" then
		--		end
		--	end
		end
	elseif mouse.eta == "moving_os" then
		if mouse.canselect.chef.data.tete.tipe == 0 then
			mouse.canselect.chef.data.tete.pos.X = mouse.pos.X
			mouse.canselect.chef.data.tete.pos.Y = mouse.pos.Y
			mouse.canselect.chef.L = math.sqrt((mouse.canselect.chef.base.pos.X-mouse.pos.X)^2+(mouse.canselect.chef.base.pos.Y-mouse.pos.Y)^2)
		elseif mouse.canselect.chef.data.tete.tipe == 1 then
			mouse.canselect.chef.data.tete.vec.L = math.sqrt((mouse.canselect.chef.base.pos.X-mouse.pos.X)^2+(mouse.canselect.chef.base.pos.Y-mouse.pos.Y)^2)
			mouse.canselect.chef.data.tete.vec.D = math.atan2(mouse.pos.Y-mouse.canselect.chef.base.pos.Y,mouse.pos.X-mouse.canselect.chef.base.pos.X)-mouse.canselect.chef.base.vec.D
			mouse.canselect.chef.data.tete.L = mouse.canselect.chef.data.tete.vec.L
		end

	end
end
local new = new_function(fonction,"KP",0)
function new.F(mx,my,bu)
	if k == "escape" then mouse.tool = 0 end
end

local new = new_function(fonction,"MP",0)
function new.F(mx,my,bu)
	if mouse.eta == 1 then
		if not mouse.canselect then
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
				mouse.panX , mouse.panY = mouse.pos.X , mouse.pos.Y
				mouse.camX , mouse.camY = camera.pos.X , camera.pos.Y
			elseif bu == "l" then
				if mouse.tool == 0 then
					mouse.eta = "selz"
					mouse.selzX , mouse.selzY = mouse.pos.X , mouse.pos.Y
				elseif mouse.tool == "create_os_coord" or mouse.tool == "create_os_vector" then
					mouse.eta = "creating_os"
					mouse.base = {tipe = 0}
					mouse.base.pos = {X=mouse.pos.X,Y=mouse.pos.Y}
					mouse.base.vec = {D=0}
				end
			end
		else
			execute_en_silence(mouse.canselect.MP,mouse.canselect,mx,my,bu)
		end
	end

end
local new = new_function(fonction,"MR",0)
function new.F(mx,my,bu)

	if mouse.eta == 1 then
		if mouse.canselect then
			execute_en_silence(mouse.canselect.MR,mouse.canselect,mx,my,bu)
		end
	elseif mouse.eta == "pan" then
		if bu == "m" then
			mouse.eta = 1
		end
	elseif mouse.eta == "creating_os" then
		if bu == "l" then
			if mouse.canselect then
				execute_en_silence(mouse.canselect.tete.MR,mouse.canselect.tete,mx,my,bu)
			else
				mouse.eta = 1

				if mouse.tool == "create_os_coord" then
					add_bone_to_selectable(create_bone(model_edit,create_new_bone(model_data_edit,mouse.base,{tipe=0,pos={X=mouse.pos.X,Y=mouse.pos.Y}})))
				elseif mouse.tool == "create_os_vector" then
					local L = math.sqrt((mouse.base.pos.X-mouse.pos.X)^2+(mouse.base.pos.Y-mouse.pos.Y)^2)
					local D = math.atan2(mouse.pos.Y-mouse.base.pos.Y,mouse.pos.X-mouse.base.pos.X)-mouse.base.vec.D
					add_bone_to_selectable(create_bone(model_edit,create_new_bone(model_data_edit,mouse.base,{tipe=1,vec={D=D,L=L}})))	
				end

				if not love.keyboard.isDown( "lshift" ) and not love.keyboard.isDown( "rshift" ) then
					mouse.tool = 0
					tool_tag_Y = zero_tool
				end
			end
		end

	elseif mouse.eta == "clicking_os" then
		execute_en_silence(mouse.canselect.MR,mouse.canselect,mx,my,bu)
		mouse.eta = 1
	elseif mouse.eta == "moving_os" then
		mouse.eta = 1
		add_historique(model_edit)
	end
end


local new = new_function(fonction,"draw",-10)
function new.F(dot)
	if mouse.eta == "selz" then
		local sX = (mouse.selzX-mouse.pos.X)*ratio(0)*camera.zoom
		local sY = (mouse.selzY-mouse.pos.Y)*ratio(0)*camera.zoom
		love.graphics.rectangle( "line", love.mouse.getX() , love.mouse.getY(), sX , sY )
	elseif mouse.eta == "creating_os" then

		local X1 , Y1 = pos_world_to_screen(mouse.base.pos.X,mouse.base.pos.Y,0)

		love.graphics.line( X1, Y1 , love.mouse.getX() , love.mouse.getY() )

	end
end


