function S.load(S)
	S.sol = {}
	local t = 1
	while love.filesystem.exists(""..S.lieux.."/ressource/sol "..t..".png") do
		S.sol[t] = love.graphics.newImage(""..S.lieux.."/ressource/sol "..t..".png")
		t = t+1
	end



	S.ciel_1 = love.graphics.newImage(""..S.lieux.."/ressource/ciel 1.png")
end
function S.creation(O)
	O.txt = 1
	O.ciel = { 	app = O.data.ciel_1 ,
			Z = -10000 ,
			draw_cam = O.data.draw_ciel }
	add_to_camera(O.ciel)
	O.sol = {}
	for i = 1,25 do

		O.sol[i] = { 	X = 2000 ,
				Y = 200+i*4+math.random()*30 ,
				Z = i*30-1000 ,
				A = 0 ,
				app = O.data.sol[math.random(1,table.maxn(O.data.sol))] ,
				draw_cam = O.data.draw_cam }
	end


	for i = 1,100 do
		local rand = (math.random()+math.random())*30*25/2
		objet_create(objet_data.prop_gazon,math.random()*4000,rand/30*4+88,rand-1000,0,1,1)
	end
end
local new = new_function( 0, "objet_update" , 0 )
new.obj = S
function new.F(P,dot)
	for e,g in ipairs(P.objet) do
		for i,h in ipairs(g.sol) do
			--h.Y = math.sin(i+crono)
			--txt = txt+1
			if h.eta == nil or not h.eta.camera then
				if inview(2000,h.Y,h.Z,100000 , 500) then
					add_to_camera(h)
				end
			else
				if not inview(2000,h.Y,h.Z,100000 , 500 ) then
					h.eta.camera = false
				end
			end
		end
	end
end
function S.draw_ciel(O)
	draw_in_world( love.graphics.draw , O.app , -10000 , -10000 , O.Z , 0 , 110 , 40 )
end
function S.draw_cam(O)
	draw_in_world( love.graphics.draw , O.app , O.X , O.Y , O.Z , O.A , 1/1000*(O.Z-1500) , 1 , O.app:getWidth()/2 , O.app:getHeight() )
end
