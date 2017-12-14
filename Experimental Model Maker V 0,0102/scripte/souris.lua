
mouse = {}

mouse.eta = 1
mouse.pos = {X=0,Y=0}
tool_tag = load_image("curceur doutil")
tool_tag_Y = 0
mouse.pretool = 0
mouse.tool = 0
mouse.selectable = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",-1,false),"selectable",true)


function set_mode(B)
	if B then
		mouse.actual_MP = B.useMP or mouse.normal_MP
		mouse.actual_MR = B.useMR or mouse.normal_MR
		mouse.actual_update = B.useupdate or mouse.normal_update
		mouse.actual_Draw = B.useDraw or mouse.normal_Draw
	else 
		mouse.actual_MP = mouse.normal_MP
		mouse.actual_MR = mouse.normal_MR
		mouse.actual_update = mouse.normal_update
		mouse.actual_Draw = mouse.normal_Draw
	end
end

local new = new_function(fonction,"KP",8)
function new.F(mx,my,bu)
	if k == "escape" then set_mode(bouton_curseur) end
end

function mouse.normal_update(dot)
	if mouse.eta == "pan" then
		camera.vpos.X = mouse.camX+(mouse.panX-love.mouse.getX())/ratio(0)/camera.zoom
		camera.vpos.Y = mouse.camY+(mouse.panY-love.mouse.getY())/ratio(0)/camera.zoom

	end
end
mouse.actual_update = mouse.normal_update

local new = new_function(fonction,"update",8)
function new.F(dot)
	mouse.pos.X , mouse.pos.Y = pos_screen_to_world(love.mouse.getX(),love.mouse.getY(),0)
	if not mouse.canbeclicked then
		mouse.actual_update(dot)
	end
end



function mouse.normal_MP(mx,my,bu)
	if mouse.eta == 1 then
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

		end
	end

end
mouse.actual_MP = mouse.normal_MP
local new = new_function(fonction,"MP",8)
function new.F(mx,my,bu)
	if not mouse.canbeclicked then
		mouse.actual_MP(mx,my,bu)
	end
end



function mouse.normal_MR(mx,my,bu)
	if mouse.eta == 1 then
		if mouse.canbeclicked then
			execute_en_silence(mouse.canbeclicked.MR,mouse.canbeclicked,mx,my,bu)
		end
	elseif mouse.eta == "pan" then
		if bu == "m" then
			mouse.eta = 1
		end
	end
end
mouse.actual_MR = mouse.normal_MR
local new = new_function(fonction,"MR",0)
function new.F(mx,my,bu)
	if not mouse.canbeclicked then
		mouse.actual_MR(mx,my,bu)
	end
end


function mouse.normal_Draw()

end
mouse.actual_Draw = mouse.normal_Draw
local new = new_function(fonction,"draw",-10)
function new.F()
	mouse.actual_Draw()
end
