function T.load(T)
	T.app = {{	app = model_humain_boulet	}}

	T.speed = 180
	T.range = 10
	T.poid = 10

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


	for i,h in ipairs(equipe[3-Q.equipe].unit) do
		if h.unit.etat ~= "mort"
		and h.unit.etat ~= "fini"
		and h.unit.attacable == true then
			local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2)
			if dist < T.range then
				unit_stun(h.unit,1)
				unit_hit(h.unit,Q.damage,"normal")

			end
		end
	end



	local rand = math.random(75)
	if rand < 25 then
		play_son(_G["son_"..T.nom.."_impact_1"],1,Q.X,Q.Y)
	elseif rand < 50 then
		play_son(_G["son_"..T.nom.."_impact_2"],1,Q.X,Q.Y)
	else
		play_son(_G["son_"..T.nom.."_impact_3"],1,Q.X,Q.Y)
	end







	Q.app[1].app.nextanim = 2


	Q.mX = 0
	Q.mY = 0
	Q.mZ = 0
	Q.Z = 0
end
function T.ia(T,Q)


end
function T.update(T,Q,dot)


	if Q.etat == "vivant" then
		Q.A = math.atan((Q.cibley-Q.Y)/math.abs(Q.ciblex-Q.X))


		Q.mX = Q.mX--+math.cos(Q.A)*5
		Q.mY = Q.mY--+math.sin(Q.A)*5
		Q.mZ = Q.mZ-T.poid

		if Q.Z < 0 then
			unit_kill(Q)
			hit_zone(Q.X,Q.Y,Q.damage,T.range,Q.equipe,false)

		end

	elseif Q.etat == "mort" then


		if Q.app[1].app.anim == 2
		and Q.app[1].app.frame == 4 then
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
	end

end
