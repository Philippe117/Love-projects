local new = new_function(fonction,"start",12)
function new.F()
	objet_create(objet_data.plateau_test,0,0,0,0,1,1)



	for e = 0,0 do
		for i = 0,1 do
			objet_create(carte,e*150,i*200,0,0,1,1)
		end
	end
--	for e = 0,1 do
--		for i = 0,1 do
--			objet_create(objet_data.objet_test2,1600+e*150+450*i,200,-400,0,1,1)
--		end
--	end
end
local new = new_function(fonction,"KP",0)
function new.F(k)
	if k == "escape" then
		love.event.quit()
	end
end
local new = new_function(fonction,"draw",0)
function new.F(k)
	draw_camera()
end
