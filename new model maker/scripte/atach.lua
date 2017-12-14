S.load = {prio = 0}
function S.load.F()
	atach = load_image("atach")
	atach_out = load_image("atach out.png")
end
function draw_atach2(model,alpha)
	for i,h in ipairs(model.atach) do
		if model.bone[select] == h.chef then
			love.graphics.setColor(0,255,0,alpha*.8)
			love.graphics.draw( 	atach ,
						(h.pos.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(h.pos.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.pos.A ,
						.8 ,
						.8 ,
						atach:getWidth()/2 ,
						atach:getHeight()/2 )
			love.graphics.setColor(255,255,255,alpha)
			love.graphics.draw( 	atach_out ,
						(h.pos.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(h.pos.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.pos.A ,
						h.chef.tete.scale*.8 ,
						h.chef.tete.scale*.8 ,
						atach_out:getWidth()/2 ,
						atach_out:getHeight()/2 )
			love.graphics.setColor(255,255,255,alpha)
			love.graphics.setFont( ff )
			love.graphics.print( 	model.model_data.atach[i].nom ,
						(h.pos.X-cam_x)*zoom+love.graphics.getWidth()/2+10 ,
						(h.pos.Y-cam_y)*zoom+love.graphics.getHeight()/2-5 )
		elseif model.bone[canselect] == h.chef then
			love.graphics.setColor(255,220,0,alpha)
			love.graphics.draw( 	atach ,
						(h.pos.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(h.pos.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.pos.A ,
						.8 ,
						.8 ,
						atach:getWidth()/2 ,
						atach:getHeight()/2 )
			love.graphics.setColor(255,255,255,alpha)
			love.graphics.draw( 	atach_out ,
						(h.pos.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(h.pos.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.pos.A ,
						h.chef.tete.scale*.8 ,
						h.chef.tete.scale*.8 ,
						atach_out:getWidth()/2 ,
						atach_out:getHeight()/2 )
			love.graphics.setFont( ff )
			love.graphics.print( 	model.model_data.atach[i].nom ,
						h.pos.X+10 ,
						h.pos.Y-5 )
		else
			love.graphics.setColor(255,255,255,alpha)
			love.graphics.draw( 	atach ,
						(h.pos.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(h.pos.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.pos.A ,
						.8 ,
						.8 ,
						atach:getWidth()/2 ,
						atach:getHeight()/2 )
		end
	end
end
