
local new = new_function(fonction,"start",12)
function new.F()

--	for e = 1,8 do
--		for i = 1,2 do
--			local new = objet_create(objet_data.objet_test,-200*i,200*e,0,0,1,1)
--			new.mX = (e-4.5)*.1
--			new.mY = (i-0.5)*.1
--		end
--	end
end
function S.load(D)
	--D.dino = load_model(""..S.lieux.."/ressource","dino")
	D.img = love.graphics.newImage(""..S.lieux.."/ressource/bule.png")
	D.img:setFilter( "nearest","nearest" )
	D.timer = 0
end
function S.creation(O)
	--O.dino = create_model(O.data.dino)
	O.txt = 1
	O.mX = 0
	O.mY = 0
	O.mZ = 0
	O.c = math.random()
	O.sens = 1
end
local new = new_function( 0, "objet_update" , 12 )
new.obj = S
function new.F(D,dot)

	for i,O in ipairs(D.objet) do
		if i < table.maxn(D.objet) then
			for P = i+1,table.maxn(D.objet) do
				local dist = math.sqrt((O.X-D.objet[P].X)^2+(O.Y-D.objet[P].Y)^2)
				local mX = ((D.objet[P].X-O.X)/dist^2)*.05
				local mY = ((D.objet[P].Y-O.Y)/dist^2)*.05
				O.mX = O.mX+mX
				O.mY = O.mY+mY
				D.objet[P].mX = D.objet[P].mX-mX
				D.objet[P].mY = D.objet[P].mY-mY
			end
		end
	end




	for i,O in ipairs(D.objet) do
		if O.eta.camera then
			if not inview( O.X , O.Y , O.Z , 200 ,200 ) then
				O.eta.camera = false
			end
		--	O.dino.input.direction[1] = math.atan((mouse.Y-O.Y+O.Z+100)/math.abs(mouse.X-O.X))


		--	O.sens = O.sens+10*(((mouse.X-O.X)/math.abs(mouse.X-O.X))-O.sens)*dot
		--	if O.sens == 0 then
		--		O.sens = .000001
		--	end
		--	update_model(O.dino,dot)
		else
			if inview( O.X , O.Y , O.Z , 200 ,200 ) then
				add_to_camera(O)
			end
		end
	--	local dist = math.sqrt((O.X-mouse.X)^2+(O.Y-mouse.Y)^2)

	--	O.mX = O.mX+(math.random()-.5)*dot*0+((mouse.X-O.X)/dist^2)*dot*100
	--	O.mY = O.mY+(math.random()-.5)*dot*0+((mouse.Y-O.Y)/dist^2)*dot*100
	--	O.c = O.c+(.99*O.c+math.random()/50-O.c)*dot
		O.X = O.X+O.mX

		O.Y = O.Y+O.mY

	end
end
function S.draw_cam(O)

--	love.graphics.setColor(	125+125*math.sin(crono+O.c),
--				125+125*math.sin(2*math.pi/crono+O.c+math.pi/3*2),
--				125+125*math.sin(2*math.pi/crono+O.c-math.pi/3*2)  )
love.graphics.setColor(255,255,255)

	draw_in_world( love.graphics.draw , O.data.img , O.X , O.Y , O.Z , 0 , 1,1,200,200)
	--draw_in_world(  , O.dino , O.X , O.Y , O.Z , 0 , O.sens , 1 )
	--draw_in_world( love.graphics.print , O.data.nom , O.X , O.Y , O.Z )
end

