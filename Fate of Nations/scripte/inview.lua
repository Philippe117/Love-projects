function inview(ex,ey,tol)
	if ex > cam_x-(love.graphics.getWidth()/2)/zoom-tol
	and ex < cam_x+(love.graphics.getWidth()/2)/zoom+tol
	and ey > cam_y-(love.graphics.getHeight()/2)/zoom-tol
	and ey < cam_y+(love.graphics.getHeight()/2)/zoom+tol then
		return (true)
	else
		return (false)
	end


end
