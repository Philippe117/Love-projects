camera = {}
camera.X = 0
camera.Y = 0
camera.zoom = 1
camera.drawlist = {}
mouse = {}
mouse.X = 0
mouse.Y = 0


S.MP = {prio = 0}
function S.MP.F(mx,my,bu)
	if pointer == 0 then
		if bu == "wd" then
			if camera.zoom > .2 then
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
S.update = {prio = 100}
function S.update.F(dot)
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
end
function X_world_to_screen(X)
	return( (X-camera.X)*camera.zoom+love.graphics.getWidth()/2 )
end
function Y_world_to_screen(Y)
	return( (Y-camera.Y)*camera.zoom+love.graphics.getHeight()/2 )
end
function X_screen_to_world(X)
	return( (X-love.graphics.getWidth()/2)/camera.zoom+camera.X )
end
function Y_screen_to_world(Y)
	return( (Y-love.graphics.getHeight()/2)/camera.zoom+camera.Y )
end
function draw_in_world(func,img,X,Y,A,sx,sy,p1,p2,p3,p4,p5,p6)
	if A == nil then
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
		Y_world_to_screen(Y) ,
		A ,
		sx*camera.zoom ,
		sy*camera.zoom ,
		p1,p2,p3,p4,p5,p6)

end

