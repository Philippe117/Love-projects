function S.load(D)
	D.sprR = load_sprite(""..D.lieux.."/ressource","droite")
	D.sprU = load_sprite(""..D.lieux.."/ressource","haut")
	D.sprL = load_sprite(""..D.lieux.."/ressource","gauche")
	D.sprD = load_sprite(""..D.lieux.."/ressource","bas")

	D.timer = 0
end
function S.creation(O)

	O.config_groupe = {}

	O.app = create_sprite(O.data.sprD)


	O.txt = 1

	O.nom = chef

	O.mX = 0
	O.mY = 0
	O.mZ = 0
	O.sens = 1
	O.direction = 0
--------------------------------------------------------------------------------------------
	O.groupe = add_list_to_collect_routine( {} , "chef" , false )
	for e,g in ipairs(O.config_groupe) do
		g.unit = add_list_to_collect_routine( {} , "groupe" , false )
		for S,T in ipairs(T) do
			for i = 1,T.nb do
				local new = create_unit(unit_data[T.nom],O.team,O.X+100*(i-1-T.nb/2),O.Y,O.Z,O.A)
				new.chef = O
				add_data_to_a_list(g.unit,new)
				add_data_to_a_list(O.groupe,new)
			end
		end
	end

--------------------------------------------------------------------------------------------

end
function S.destroy(O)
	O.groupe = nil

end
local new = new_function( 0, "objet_update" , 12 )
new.obj = S
function new.F(D,dot)
	for i,O in ipairs(D.objet) do




		if love.keyboard.isDown("up") then
			O.mZ = O.mZ-dot*10
		end
		if love.keyboard.isDown("down") then
			O.mZ = O.mZ+dot*10
		end
		if love.keyboard.isDown("left") then
			O.mX = O.mX-dot*10
		end
		if love.keyboard.isDown("right") then
			O.mX = O.mX+dot*10
		end



		if O.eta.camera then
			if not inview( O.X , O.Y , O.Z , 200 ,200) then
				O.eta.camera = false
			else
				update_model(O.model,dot)
			end
		else
			if inview( O.X , O.Y , O.Z , 200 ,200) then
				add_to_camera(O)
			end
		end




		O.mX = O.mX*(1-8*dot)
		O.mY = O.mY*(1-8*dot)
		O.mZ = O.mZ*(1-8*dot)
		O.X = O.X+O.mX
		O.Y = O.Y+O.mY
		O.Z = O.Z+O.mZ
		O.direction = math.atan2(O.mZ,O.mX)
		O.speed = math.sqrt(O.mZ^2+O.mX^2+O.mY^2)


		O.app.data = selector4(O.data.sprU,O.data.sprD,O.data.sprL,O.data.sprR,-O.direction)
		O.app.speed = O.speed*10
		update_sprite(O.app,dot)



		camera.vZ = O.Z+1000
		camera.vX = O.X
	end
end
function S.draw_cam(O)
	love.graphics.setColor(255,255,255)
	draw_in_world( draw_sprite , O.app , O.X , O.Y , O.Z , 0 , O.sens*5 , 5 , O.app.data.Width/2 , O.app.data.Height )
	draw_in_world( love.graphics.print , O.data.nom , O.X , O.Y , O.Z )
end

