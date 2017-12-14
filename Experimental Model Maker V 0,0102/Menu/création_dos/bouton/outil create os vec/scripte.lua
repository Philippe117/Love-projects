function B.load(B)				
	B.pos.X = TTX
	B.pos.Y = TTY+120
	B.Width = 60
	B.Height = 60
	B.popup_text = "Choisir l'outil de création d'os en mode tete relative."
end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		tool_tag_Y = B.pos.Y+5
		set_mode(B)
	end
end


function B.useMP(mx,my,bu)
	if mouse.eta == 1 then
		if bu == "l" then
			if mouse.canselect then
				mouse.eta = "creating_os"
				mouse.base = { tipe = 1}
				mouse.base.pos = mouse.canselect.chef.tete.pos
				mouse.base.vec = mouse.canselect.chef.tete.vec
				mouse.base.posid = mouse.canselect.id
			else
				mouse.eta = "creating_os"
				mouse.base = {tipe = 0}
				mouse.base.pos = {X=mouse.pos.X,Y=mouse.pos.Y}
				mouse.base.vec = {D=0}
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
		end
	end
end
function B.useMR(mx,my,bu)
	if mouse.eta == "creating_os" then
		if bu == "l" then
			mouse.eta = 1
			local L = math.sqrt((mouse.base.pos.X-mouse.pos.X)^2+(mouse.base.pos.Y-mouse.pos.Y)^2)
			if mouse.canselect then
				add_bone_to_selectable(create_bone(model_edit,create_new_bone(model_data_edit,mouse.base,{tipe=2,pos=mouse.canselect.id})))
			else
				local L = math.sqrt((mouse.base.pos.X-mouse.pos.X)^2+(mouse.base.pos.Y-mouse.pos.Y)^2)
				local D = math.atan2(mouse.pos.Y-mouse.base.pos.Y,mouse.pos.X-mouse.base.pos.X)-mouse.base.vec.D
				add_bone_to_selectable(create_bone(model_edit,create_new_bone(model_data_edit,mouse.base,{tipe=1,vec={D=D,L=L}})))
			end
			if not love.keyboard.isDown( "lshift" ) and not love.keyboard.isDown( "rshift" ) then
				set_mode(bouton_curseur)
				tool_tag_Y = zero_tool
			end
		end
	elseif mouse.eta == "pan" then
		if bu == "m" then
			mouse.eta = 1
		end
	end
end




function B.useupdate(dot)

	choose_canselect()

	if mouse.eta == 1 then
		choose_canselect()
	elseif mouse.eta == "pan" then
		camera.vpos.X = mouse.camX+(mouse.panX-love.mouse.getX())/ratio(0)/camera.zoom
		camera.vpos.Y = mouse.camY+(mouse.panY-love.mouse.getY())/ratio(0)/camera.zoom
	end
end


function B.useDraw()
	if mouse.eta == "creating_os" then
		local X1 , Y1 = pos_world_to_screen(mouse.base.pos.X,mouse.base.pos.Y,0)
		love.graphics.line( X1, Y1 , love.mouse.getX() , love.mouse.getY() )
	end
end






function B.condition()
	return(true)
end
function B.draw()
end





