function draw_ligne(image,x1,y1,x2,y2,sc)
	local dist = math.sqrt((x1-x2)^2+(y1-y2)^2)
	local angle = math.atan2((y2-y1),(x2-x1))
	if sc == nil then
		sc = 1
	end
	love.graphics.draw( 	image ,
				x1 ,
				y1 ,
				angle ,
				dist/image:getWidth() ,
				sc ,
				0 ,
				image:getHeight()/2 )
end
