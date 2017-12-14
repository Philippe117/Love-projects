
function S.load(new)

	S.recto = love.graphics.newImage(""..S.lieux.."/recto.png")
	S.recto2 = render_card(S.recto)

end
function S.creation(O)
	txt = txt+1
	O.txt = 1
	O.mX = 0
	O.mY = 0
	O.mZ = 0
	O.A = 0
	O.AX = 1
	O.AY = 1
	O.PA = 0
end

local new = new_function( 0, "objet_update" , 12 )
new.obj = S
function new.F(D,dot)
	for i,O in ipairs(D.objet) do
		--O.AX = math.max(-1,math.min(1,1.5*math.cos(crono*0.8)))
		if O.eta.camera then
			if not inview( O.X , O.Y , O.Z , 200 ) then
				O.eta.camera = false
			end
		else
			if inview( O.X , O.Y , O.Z , 200 ) then
				add_to_camera(O)
			end
		end


	end
end
local new = new_function(fonction,"KP",12)
function new.F(k)
	local D = objet_data.carte_mana_bleu
	if k == " " then
		for i,O in ipairs(D.objet) do
			O.PA = O.PA+.2
		end
	elseif k == "m" then
		for i,O in ipairs(D.objet) do
			O.AX = O.AX+.05
		end
	elseif k == "n" then
		for i,O in ipairs(D.objet) do
			O.AX = O.AX-.05
		end
	elseif k == "v" then
		for i,O in ipairs(D.objet) do
			O.A = O.A-.05
		end
	elseif k == "b" then
		for i,O in ipairs(D.objet) do
			O.A = O.A+.05
		end
	elseif k == "d" then
		for i,O in ipairs(D.objet) do
			O.X = O.X+2/camera.zoom
		end
	elseif k == "a" then
		for i,O in ipairs(D.objet) do
			O.X = O.X-2/camera.zoom
		end
	elseif k == "w" then
		for i,O in ipairs(D.objet) do
			O.Y = O.Y-2/camera.zoom
		end
	elseif k == "s" then
		for i,O in ipairs(D.objet) do
			O.Y = O.Y+2/camera.zoom
		end
	elseif k == "return" then
		for i,O in ipairs(D.objet) do
			rapporter_erreur("CARTE = ( "..D.nom.." , "..i.." )")
			rapporter_erreur("pos = ( "..O.X.." , "..O.Y.." )")
			rapporter_erreur("A = "..O.A.."")
			rapporter_erreur("AX = "..O.AX.."")
			rapporter_erreur("PA = "..O.PA.."")
		end

	end
end
function S.draw_cam(O)
	if O.AY*O.AX > 0 then	
		draw_in_world( draw_card , O.data.recto2 , O.X , O.Y , O.Z , O.A , .5*O.AX,.5*O.AY,O.PA)
	else
		draw_in_world( draw_card , carte.verso2 , O.X , O.Y , O.Z , O.A , .5*O.AX,.5*O.AY,O.PA)
	end
end
