S.load = {prio = 14}
function S.load.F()
	atach = load_image("atach")
	atach_out = load_image("atach out")
end
function add_atach(model,os)
	local new = {}
	new.nom = "new_atach"
	new.chef = os
	table.insert(model.model_data.atach,new)
	for i,h in ipairs(model.model_data.atach) do
		h.id = i
	end
	return (new)
end

function remove_atach(model,atach)
	_G["model_"..model.id.."_atach_"..model.model_data.atach[atach].nom..""] = nil
	table.remove(model.model_data.atach , atach )
	table.remove(model.atach , atach )
	for i,h in ipairs(model.model_data.atach) do
		h.id = i
	end
	
	return (new)
end
function draw_atach(model)
	love.graphics.setColor(255,255,255,50)
	for i,h in ipairs(model.atach) do


		love.graphics.draw( atach ,	(model.X+h.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(model.Y+h.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.A ,
						zoom*h.scale*.1 ,
						zoom*h.scale*.1 ,
						30 ,
						30 )
		love.graphics.draw( atach_out ,	(model.X+h.X-cam_x)*zoom+love.graphics.getWidth()/2 ,
						(model.Y+h.Y-cam_y)*zoom+love.graphics.getHeight()/2 ,
						h.A ,
						zoom*.1 ,
						zoom*.1 ,
						30 ,
						30 )
	end
end


