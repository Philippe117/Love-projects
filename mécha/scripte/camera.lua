local new = new_function(fonction,"load",0)
function new.F()
	camera = {}
	mouse = {}
	mouse.action = 0

end
local new = new_function(fonction,"start",0)
function new.F()
	camera.X = 0	--réel
	camera.Y = 0
	camera.Z = 1000
	camera.zoom = 1
	camera.A = 0

	camera.vX = 0	--voulut
	camera.vY = 0
	camera.vZ = 1000
	camera.vzoom = 1
	camera.vA = 0

	camera.sX = 5	--speed
	camera.sY = 5
	camera.sZ = 5
	camera.szoom = 5
	camera.sA = 5

	mouse.canselect = 0
	mouse.select = 0
	camera.drawlist = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",-1,false),"camera",true)
	camera.selectable = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",1,false),"selectable",true)

end
function add_to_camera(data)
	add_data_to_a_list(camera.drawlist,data)
end
local new = new_function(fonction,"MP",0)
function new.F(mx,my,bu)
	if pointer == 0 then
		if bu == "wd" then
			if camera.zoom > .02 then
				camera.vzoom = .9*camera.vzoom
				camera.vX = camera.vX+.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/camera.zoom/ratio(0,0)
				camera.vY = camera.vY+.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/camera.zoom/ratio(0,0)
			end
		end
		if bu == "wu" then
			if camera.zoom < 20 then
				camera.vzoom = 1.1*camera.vzoom
				camera.vX = camera.vX-.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/camera.zoom/ratio(0,0)
				camera.vY = camera.vY-.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/camera.zoom/ratio(0,0)
			end
		end
	end
end
local new = new_function(fonction,"update",0)
function new.F(dot)
	mouse.X = X_screen_to_world(love.mouse.getX(),0,0)
	mouse.Y = Y_screen_to_world(love.mouse.getY(),0)



	if false then
		if love.keyboard.isDown("up") then
			camera.vZ = camera.vZ-800*dot/camera.zoom
		end
		if love.keyboard.isDown("down") then
			camera.vZ = camera.vZ+800*dot/camera.zoom
		end
		if love.keyboard.isDown("left") then
			camera.vX = camera.vX-800*dot/camera.zoom
		end
		if love.keyboard.isDown("right") then
			camera.vX = camera.vX+800*dot/camera.zoom
		end
	end

	if love.keyboard.isDown("-") then
		camera.vY = camera.vY+400*dot/camera.zoom
	end
	if love.keyboard.isDown("=") then
		camera.vY = camera.vY-400*dot/camera.zoom
	end

	if love.keyboard.isDown("1") then
		camera.vA = camera.vA+dot
	end
	if love.keyboard.isDown("2") then
		camera.vA = camera.vA-dot/camera.zoom
	end

	local i = 1
	while i <= table.maxn(camera.selectable) do
		local h = camera.selectable[i]
		if execute(h.amIselectable,h) then
			mouse.canselect = h
			i = 100000000
		end
		i = i+1
	end



	camera.X = camera.X+(camera.vX-camera.X)*camera.sX*dot
	camera.Y = camera.Y+(camera.vY-camera.Y)*camera.sY*dot
	camera.Z = camera.Z+(camera.vZ-camera.Z)*camera.sZ*dot
	camera.A = camera.A+(camera.vA-camera.A)*camera.sA*dot
	camera.zoom = camera.zoom+(camera.vzoom-camera.zoom)*camera.szoom*dot
end
function draw_camera()
	for i,h in ipairs(camera.drawlist) do
		execute(h.draw_cam,h)
	end
end
function ratio(Y,Z)
	return(1000/math.sqrt((Y-camera.Y)^2+(Z-camera.Z)^2))
end
function AOAY(Y,Z)
	return((Y-camera.Y)*math.cos(camera.A)+(Z-camera.Z)*math.sin(camera.A))
end
function AOAZ(Y,Z)
	return((Z-camera.Z)*math.cos(camera.A)-(Y-camera.Y)*math.sin(camera.A))
end
function AOA(Y,Z)
	return((Y-camera.Y)*math.cos(camera.A)+(Z-camera.Z)*math.sin(camera.A)) , ((Z-camera.Z)*math.cos(camera.A)-(Y-camera.Y)*math.sin(camera.A))
end
function X_world_to_screen(X,Y,Z)
	return( (X-camera.X)*ratio(Y,Z)*camera.zoom+love.graphics.getWidth()/2  )
end
function Y_world_to_screen(Y,Z)
	return( AOAY(Y,Z)*ratio(Y,Z)*camera.zoom+love.graphics.getHeight()/2 )
end
function X_screen_to_world(X,Y,Z)
	return( (X-love.graphics.getWidth()/2)/camera.zoom/ratio(Y,Z)+camera.X )
end
function Y_screen_to_world(Y,Z)
	return( (Y-love.graphics.getHeight()/2)/camera.zoom/ratio(Y,Z)+camera.Y )
end
function get_screen_to_world(Z,X,Y)
	if Y == nil then
		X = X.X
		Y = X.Y
	end
	return( (X-love.graphics.getWidth()/2)/camera.zoom/ratio(Z)+camera.X ) , ( (Y-love.graphics.getHeight()/2)/camera.zoom/ratio(Z)+camera.Y )
end
function draw_in_world(func,img,X,Y,Z,A,sx,sy,p1,p2,p3,p4,p5,p6)
	local dist = math.sqrt((X-camera.X)^2+(Y-camera.Y)^2+(Z-camera.Z)^2)
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
		X_world_to_screen(X,Y,Z) ,
		Y_world_to_screen(Y,Z) ,
		A ,
		sx*camera.zoom*ratio(Y,Z) ,
		sy*camera.zoom*ratio(Y,Z) ,
		p1,p2,p3,p4,p5,p6)
end
function inview(X,Y,Z,tolx,toly)
	return ( 	X_world_to_screen(X+tolx,Y,Z) > 0
			and X_world_to_screen(X-tolx,Y,Z) < love.graphics.getWidth()
			and Y_world_to_screen(Y+toly,Z) > 0
			and Y_world_to_screen(Y-toly,Z) < love.graphics.getHeight()
			and AOAZ(Y,Z) < 0 )
end
