nom = "image"
function load_image(lieux1,lieux2,lieux3)
	local lieux = lieux1
	if lieux2 ~= nil then
		lieux = ""..lieux.."/"..lieux2..""
	end
	if lieux3 ~= nil then
		lieux = ""..lieux.."/"..lieux3..""
	end

	if love.filesystem.exists(""..lieux..".png") then
		return(love.graphics.newImage(""..lieux..".png"))
	elseif love.filesystem.exists(""..lieux..".gif") then
		local new = love.graphics.newImage(""..lieux..".gif")
		new:setFilter( "nearest","nearest" )
		return(new)
	else
		return(rien_img_bl)
	end
end
function create_image(image,pos,A,sx,sy,centre)
	if image == nil then
		image = rien_img
	end
	if A == nil then
		A = 0
		sx = 1
		sy = 1
		centre = { cx = image:getWidth()/2 , cy = image:getHeight()/2 }
	elseif sx == nil then
		sx = 1
		sy = 1
		centre = { cx = image:getWidth()/2 , cy = image:getHeight()/2 }
	elseif sy == nil then
		sy = sx
		centre = { cx = image:getWidth()/2 , cy = image:getHeight()/2 }
	elseif centre == nil then
		centre = { cx = image:getWidth()/2 , cy = image:getHeight()/2 }
	end

	local new = {	draw_function = draw_image ,
			image = image ,
			pos = pos ,
			A = A ,
			sx = sx ,
			sy = sy ,
			decal = { X = 0 , Y = 0 , Z = 0 } ,
			centre = centre
					}

	create_draw_fonction(new)

	return (new)
end

function draw_image( image )
	draw_func( 	image.image ,
			{	X = image.pos.X+image.decal.X , 
				Y = image.pos.Y+image.decal.Y , 
				Z = image.pos.Z+image.decal.Z } ,
			image.A ,
			image.sx ,
			image.sy ,
			image.centre )
end





