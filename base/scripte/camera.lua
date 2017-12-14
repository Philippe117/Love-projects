
local new = new_function(fonction,"load",0)
function new.F()
	camera = {}
	mouse = {}
end
local new = new_function(fonction,"start",0)
function new.F()
	camera.X = 0
	camera.Y = 0
	camera.zoom = 1
	camera.drawlist = add_list_to_collect_routine(add_list_to_sort_routine({},"Y",-1,false),"camera",true)
end
function add_to_camera(data)
	add_data_to_a_list(camera.drawlist,data)
end
local new = new_function(fonction,"MP",0)
function new.F(mx,my,bu)
	if pointer == 0 then
		if bu == "wd" then
			if camera.zoom > .02 then
				camera.zoom = .9*camera.zoom
				camera.X = camera.X+.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/camera.zoom
				camera.Y = camera.Y+.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/camera.zoom
			end
		end
		if bu == "wu" then
			if camera.zoom < 20 then
				camera.zoom = 1.1*camera.zoom
				camera.X = camera.X-.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/camera.zoom
				camera.Y = camera.Y-.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/camera.zoom
			end
		end
	end
end
local new = new_function(fonction,"update",0)
function new.F(dot)
	mouse.X = X_screen_to_world(love.mouse.getX())
	mouse.Y = Y_screen_to_world(love.mouse.getY())
	if love.keyboard.isDown("up") then
		camera.Y = camera.Y-800*dot/camera.zoom
	end
	if love.keyboard.isDown("down") then
		camera.Y = camera.Y+800*dot/camera.zoom
	end
	if love.keyboard.isDown("left") then
		camera.X = camera.X-800*dot/camera.zoom
	end
	if love.keyboard.isDown("right") then
		camera.X = camera.X+800*dot/camera.zoom
	end
	--txt = camera.drawlist.Y
end

function draw_camera()
	for i,h in ipairs(camera.drawlist) do
		execute(h.draw_cam,h)
	end
end
function X_world_to_screen(X)
	return( (X-camera.X)*camera.zoom+love.graphics.getWidth()/2 )
end
function Y_world_to_screen(Y,Z)
	return( (Y-camera.Y-Z)*camera.zoom+love.graphics.getHeight()/2 )
end
function X_screen_to_world(X)
	return( (X-love.graphics.getWidth()/2)/camera.zoom+camera.X )
end
function Y_screen_to_world(Y)
	return( (Y-love.graphics.getHeight()/2)/camera.zoom+camera.Y )
end
function draw_in_world(func,img,X,Y,Z,A,sx,sy,p1,p2,p3,p4,p5,p6)
	if Z == nil then
		Z = 0
		A = 0
		sx = 1
		sy = 1
	elseif A == nil then
		A = 0
		sx = 1
		sy = 1
	elseif sx == nil then
		sx = 1
		sy = 1
	elseif sy == nil then
		sy = sx
	end
	func( 	img ,
		X_world_to_screen(X) ,
		Y_world_to_screen(Y,Z) ,
		A ,
		sx*camera.zoom*1000/(1000-Z) ,
		sy*camera.zoom*1000/(1000-Z) ,
		p1,p2,p3,p4,p5,p6)
end
function inview(X,Y,Z,tol)
	if X > camera.X-love.graphics.getWidth()/2/camera.zoom-tol
	and X < camera.X+love.graphics.getWidth()/2/camera.zoom+tol
	and Y-Z > camera.Y-love.graphics.getHeight()/2/camera.zoom-tol
	and Y-Z < camera.Y+love.graphics.getHeight()/2/camera.zoom+tol then
		return (true)
	else
		return (false)
	end
end

