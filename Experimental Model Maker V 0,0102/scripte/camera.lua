local new = new_function(fonction,"load",0)
function new.F()
	camera = {}
end
local new = new_function(fonction,"start",0)
function new.F()
	camera.pos = {	X = 0,	--réel
					Y = 0,
					Z = 1000}
	camera.zoom = 1
	camera.vpos = {	X = 0,	--voulut
					Y = 0,
					Z = 1000}
	camera.vzoom = 1
	camera.sX = .1	--tau (s)
	camera.sY = .1
	camera.sZ = .1
	camera.szoom = .1
	camera.drawlist = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",-1,false),"camera",true)

end
function add_to_camera(drawable) --doit contenir la fonction draw_cam
	if drawable.draw_cam ~= nil then
		add_data_to_a_list(camera.drawlist,drawable)
	else
		rapporter_erreur("camera: Un objet ne possédant pas la fonction draw_cam à tenté de s'ajouter à la drawlist")
	end
	return (drawable)
end
local new = new_function(fonction,"update",0)
function new.F(dot)

	if love.keyboard.isDown("up") then
		camera.vpos.Z = camera.vpos.Z-800*dot/camera.zoom
	end
	if love.keyboard.isDown("down") then
		camera.vpos.Z = camera.vpos.Z+800*dot/camera.zoom
	end
	if love.keyboard.isDown("left") then
		camera.vpos.X = camera.vpos.X-800*dot/camera.zoom
	end
	if love.keyboard.isDown("right") then
		camera.vpos.X = camera.vpos.X+800*dot/camera.zoom
	end
	if love.keyboard.isDown("-") then
		camera.vpos.Y = camera.vpos.Y+400*dot/camera.zoom
	end
	if love.keyboard.isDown("=") then
		camera.vpos.Y = camera.vpos.Y-400*dot/camera.zoom
	end

	camera.pos.X = filter(camera.pos.X,camera.vpos.X,dot,camera.sX)
	camera.pos.Y = filter(camera.pos.Y,camera.vpos.Y,dot,camera.sY)
	camera.pos.Z = filter(camera.pos.Z,camera.vpos.Z,dot,camera.sZ)
	camera.zoom = filter(camera.zoom,camera.vzoom,dot,camera.szoom)

--	camera.pos.X = camera.pos.X+(camera.vpos.X-camera.pos.X)*camera.sX*dot
--	camera.pos.Y = camera.pos.Y+(camera.vpos.Y-camera.pos.Y)*camera.sY*dot
--	camera.pos.Z = camera.pos.Z+(camera.vpos.Z-camera.pos.Z)*camera.sZ*dot
--	camera.zoom = camera.zoom+(camera.vzoom-camera.zoom)*camera.szoom*dot
end
function draw_camera()
	for i,h in ipairs(camera.drawlist) do
		execute(h.draw_cam,h)
	end
end
function ratio(Z)
	return(math.abs(1000/(camera.pos.Z-Z)))
end
function X_world_to_screen(X,Z)
	Z = Z or 0
	return( (X-camera.pos.X)*ratio(Z)*camera.zoom+love.graphics.getWidth()/2  )
end
function Y_world_to_screen(Y,Z)
	Z = Z or 0
	return( (Y-camera.pos.Y)*ratio(Z)*camera.zoom+love.graphics.getHeight()/2 )
end
function pos_world_to_screen(X,Y,Z)
	Z = Z or 0
	return (X-camera.pos.X)*ratio(Z)*camera.zoom+love.graphics.getWidth()/2 , (Y-camera.pos.Y)*ratio(Z)*camera.zoom+love.graphics.getHeight()/2
end
function X_screen_to_world(X,Z)
	Z = Z or 0
	return( (X-love.graphics.getWidth()/2)/camera.zoom/ratio(Z)+camera.pos.X )
end
function Y_screen_to_world(Y,Z)
	Z = Z or 0
	return( (Y-love.graphics.getHeight()/2)/camera.zoom/ratio(Z)+camera.pos.Y )
end
function pos_screen_to_world(X,Y,Z)
	X = X or 0
	Y = Y or 0
	Z = Z or 0
	return (X-love.graphics.getWidth()/2)/camera.zoom/ratio(Z)+camera.pos.X , (Y-love.graphics.getHeight()/2)/camera.zoom/ratio(Z)+camera.pos.Y
end
function draw_in_world(func,img,X,Y,Z,A,sx,sy,p1,p2,p3,p4,p5,p6)
	X = X or 0
	Y = Y or 0
	Z = Z or 0
	Z = Z or 0
	A = A or 0
	sx = sx or 1
	sy = sy or sx
	func( 	img ,
		X_world_to_screen(X,Z) ,
		Y_world_to_screen(Y,Z) ,
		A ,
		sx*camera.zoom*ratio(Z) ,
		sy*camera.zoom*ratio(Z) ,
		p1,p2,p3,p4,p5,p6)
end
function inview(X,Y,Z,tolx,toly)
	X = X or 0
	Y = Y or 0
	Z = Z or 0
	tolx = tolx or 0
	toly = toly or 0
	return ( 	X_world_to_screen(X+tolx,Z) > 0
			and X_world_to_screen(X-tolx,Z) < love.graphics.getWidth()
			and Y_world_to_screen(Y+toly,Z) > 0
			and Y_world_to_screen(Y-toly,Z) < love.graphics.getHeight()
			and Z < camera.pos.Z )
end
