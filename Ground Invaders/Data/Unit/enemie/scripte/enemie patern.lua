function S.load(D)
	D.sprite = load_sprite(""..D.lieux.."/ressource/dino")
	D.timer = 0
end
function S.creation(O)
	O.sprite = create_sprite(O.data.sprite)
	O.txt = 1
	O.mX = 0
	O.mY = 0
	O.mZ = 0
	O.sens = 1
end
local new = new_function( 0, "objet_update" , 12 )
new.obj = S
function new.F(D,dot)
	for i,O in ipairs(D.objet) do
		if O.eta.camera then
			if not inview( O.X , O.Y , O.Z , 200 ,200) then
				O.eta.camera = false
			else
				update_sprite(O.model,dot)





			end
		else
			if inview( O.X , O.Y , O.Z , 200 ,200) then
				add_to_camera(O)
			end
		end
		O.X = O.X+O.mX
		O.Y = O.Y+O.mY
	end
end
function S.draw_cam(O)
--	love.graphics.setColor(	125+125*math.sin(crono+O.c),
--				125+125*math.sin(2*math.pi/crono+O.c+math.pi/3*2),
--				125+125*math.sin(2*math.pi/crono+O.c-math.pi/3*2)  )
	love.graphics.setColor(255,255,255)
	--draw_in_world( love.graphics.draw , O.data.img , O.X , O.Y , O.Z , 0 , 1,1,200,200)
	draw_in_world( draw_sprite , O.model , O.X , O.Y , O.Z , 0 , O.sens , 1 )
	--draw_in_world( love.graphics.print , O.data.nom , O.X , O.Y , O.Z )
end

