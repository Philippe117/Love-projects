local new = new_function(fonction,"start",12)
function new.F()
	objet_create(objet_data.plateau_test,0,0,0,0,1,1)
	objet_create(objet_data.carte_mana_bleu,100,100,0,0,1,1)

end
local new = new_function(fonction,"KP",0)
function new.F(k)
	if k == "escape" then
		love.event.push('q')
	end
end
local new = new_function(fonction,"draw",0)
function new.F(k)
	draw_camera()
end

