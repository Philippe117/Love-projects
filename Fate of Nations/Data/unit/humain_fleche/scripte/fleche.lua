function T.load(T)
	T.app = {{	app = model_humain_fleche	}}


	T.speed = 220
	T.range = 0
	T.poid = 4


end
function T.start(T)


end
function T.creation(T,Q)

	Q.damage = 1

	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
		h.app.speed = 3
	end
end
function T.hit(T,Q)


end
function T.mort(T,Q)

	Q.app[1].app.nextanim = 2



	local rand = math.random(75)
	if rand < 25 then
		play_son(_G["son_"..T.nom.."_impact_1"],1,Q.X,Q.Y)
	elseif rand < 50 then
		play_son(_G["son_"..T.nom.."_impact_2"],1,Q.X,Q.Y)
	else
		play_son(_G["son_"..T.nom.."_impact_3"],1,Q.X,Q.Y)
	end

	Q.mX = 0
	Q.mY = 0
	Q.mZ = 0
end
function T.ia(T,Q)


end
function T.update(T,Q,dot)


	if Q.etat == "vivant" then


		Q.A = math.atan((Q.mY-Q.mZ)/Q.mX)
		Q.sens = Q.mX/math.abs(Q.mX)


		Q.mX = Q.mX
		Q.mY = Q.mY
		Q.mZ = Q.mZ-T.poid


		if Q.Z < 0 then
			unit_kill(Q)
			Q.cible = hit_zone(Q.X,Q.Y,Q.damage,T.range,Q.equipe,false)
			if Q.cible ~= nil then
				Q.decal_X = Q.cible.X-Q.X
				Q.decal_Y = Q.cible.Y-Q.Y
				Q.decal_Z = Q.cible.Z-Q.Z
			end
		end


		if Q.cible ~= nil then
			if Q.cible.etat ==  "mort"
			or Q.cible.etat ==  "fini" then
				Q.cible = nil
			elseif Q.Z < Q.cible.tipe.hauteur then
				local dist = math.sqrt((Q.X-Q.cible.X)^2+(Q.Y-Q.cible.Y)^2)-Q.cible.tipe.colision_circle-T.range
				if dist < T.range then
					unit_kill(Q)
					unit_hit(Q.cible,Q.damage,"normal")
					Q.decal_X = Q.cible.X-Q.X
					Q.decal_Y = Q.cible.Y-Q.Y
					Q.decal_Z = Q.cible.Z-Q.Z
				end
			end
		end





	elseif Q.etat == "mort" then



		if Q.cible ~= nil then
			if Q.cible.etat ==  "mort"
			or Q.cible.etat ==  "fini" then
				Q.cible = nil
			else
				Q.X = Q.cible.X-Q.decal_X
				Q.Y = Q.cible.Y-Q.decal_Y
				Q.Z = Q.cible.Z-Q.decal_Z
			end
		end
		if Q.app[1].app.anim == 2
		and Q.app[1].app.frame == 8 then
			Q.etat = "fini"
		end

	end

	Q.X = Q.X+Q.mX*dot
	Q.Y = Q.Y+Q.mY*dot
	Q.Z = Q.Z+Q.mZ*dot


	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
		h.app.Z = Q.Z
		h.app.A = Q.A
		h.app.sx = Q.sens
	end

end
