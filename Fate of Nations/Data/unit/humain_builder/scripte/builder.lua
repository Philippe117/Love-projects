function T.load(T)
	T.app = {
			{app = model_humain_builder}
						}
	T.circle_sise = 10
	T.colision_circle = 8
	T.speed = 6
	T.santer = 80
	T.attacable = true
	T.build_time = 10
	T.present = true
	T.hauteur = 20
end
function T.start(T)
end
function T.creation(T,Q)
	Q.origine_X = Q.X
	Q.origine_Y = Q.Y
	for i,h in ipairs(Q.app) do
		h.app.nextanim = 2
		h.app.input[1] = 0
	end
	Q.direction = true
	--Q.chemin = {}
	--Q.chemin = {{X = 200 , Y = 300 , batiment = unit_humain_tour},{X = 300 , Y = 300 , batiment = unit_humain_tour},{X = 200 , Y = 400 , batiment = unit_humain_tour},{X = 300 , Y = 400 , batiment = unit_humain_tour}}
end
function T.hit(T,Q)
end

function T.stun(T,Q)
	Q.mode = "normal"
	Q.app[1].app.nextanim = 1
	Q.app[1].app.speed = 1

end
function T.destun(T,Q)
	
	Q.app[1].app.nextanim = 2
	Q.app[1].app.speed = 1

end

function T.mort(T,Q)
	add_chemin(Q.chef,{})
	Q.chef.can_order = true
	if Q.cible ~= nil then
		unit_kill(Q.cible)
	end
	Q.app[1].app.nextanim = 4
	Q.app[1].app.speed = 1
end



function T.ia(T,Q)
end
function T.update(T,Q,dot)
	if Q.etat == "vivant" then
		if Q.mode == "normal" then
			if Q.chemin[Q.nextpoint] ~= nil then
				if Q.direction == true then
					local dist = math.sqrt((Q.X-Q.chemin[Q.nextpoint].X)^2+(Q.Y-Q.chemin[Q.nextpoint].Y)^2)
					if dist > Q.speed*dot+10 then
						Q.mX = .8*Q.mX+Q.speed*(Q.chemin[Q.nextpoint].X-Q.X)/dist*dot
						Q.mY = .8*Q.mY+Q.speed*(Q.chemin[Q.nextpoint].Y-Q.Y)/dist*dot
					else
						if Q.chemin[Q.nextpoint].batiment ~= nil then
							local col = colibl(	Q.chemin[Q.nextpoint].X ,
										Q.chemin[Q.nextpoint].Y )
							if col ~= 201
							and col ~= 200 then
								Q.mode = "build"
								Q.cible = unit_create(Q.chemin[Q.nextpoint].batiment,Q.equipe,Q.chemin[Q.nextpoint].X,Q.chemin[Q.nextpoint].Y,0,1,"build")
								Q.cible.app[1].app.speed = 2
								Q.app[1].app.nextanim = 3
								Q.app[1].app.speed = 1.5
							else
								Q.chef.chemin[Q.nextpoint].app.etat = "fini"	
							end

						end

						Q.nextpoint = Q.nextpoint+1
					end
				else
					local dist = math.sqrt((Q.X-Q.chemin[Q.nextpoint].X)^2+(Q.Y-Q.chemin[Q.nextpoint].Y)^2)
					if dist > Q.speed*dot+10 then
						Q.mX = .8*Q.mX+Q.speed*(Q.chemin[Q.nextpoint].X-Q.X)/dist*dot
						Q.mY = .8*Q.mY+Q.speed*(Q.chemin[Q.nextpoint].Y-Q.Y)/dist*dot
					else
						Q.nextpoint = Q.nextpoint-1
					end
				end
			else
				if Q.direction == true then
					--Q.etat = "fini"
					Q.direction = false
					Q.nextpoint = Q.nextpoint-2
				else
					local dist = math.sqrt((Q.X-Q.origine_X)^2+(Q.Y-Q.origine_Y)^2)
					if dist > Q.speed*dot+10 then
						Q.mX = .8*Q.mX+Q.speed*(Q.origine_X-Q.X)/dist*dot
						Q.mY = .8*Q.mY+Q.speed*(Q.origine_Y-Q.Y)/dist*dot
					else
						Q.etat = "fini"
						Q.chef.can_order = true
						add_chemin(Q.chef,{})

						
					end
				end
			end
			local vitesse = math.sqrt(Q.mX^2+Q.mY^2)
			Q.app[1].app.speed = vitesse*3
			if Q.mX < 0 then
				Q.sens = -1
			elseif Q.mX > 0 then
				Q.sens = 1
			end
		elseif Q.mode == "build" then
			if Q.cible.mode == "build"
			and Q.cible.etat ~= "mort"
			and Q.cible.etat ~= "fini" then
				Q.app[1].app.speed = 2
				Q.mX = .9*Q.mX
				Q.mY = .9*Q.mY
				if Q.X < Q.cible.X then
					Q.sens = 1
				elseif Q.X > Q.cible.X then
					Q.sens = -1
				end
				local dist = math.sqrt((Q.X-Q.cible.X)^2+(Q.Y-Q.cible.Y)^2+(Q.Z-Q.cible.Z)^2)
				local ang = math.atan2(Q.cible.Y-Q.Y,Q.cible.X-Q.X)
				Q.X = Q.X+.01*((Q.cible.X-math.cos(ang)*20)-Q.X)
				Q.Y = Q.Y+.01*((Q.cible.Y-math.sin(ang)*20)-Q.Y)
				Q.app[1].app.input[1] = ang
				Q.mem , out = frame_pulse(Q.app[1],3,3,Q.mem)
				if out == true then
					Q.cible.app[1].app.speed = 2
					local rand = math.random(100)
					if rand < 25 then
						play_son(_G["son_"..T.nom.."_toc_1"],2,Q.X,Q.Y)
					elseif rand < 50 then
						play_son(_G["son_"..T.nom.."_toc_2"],2,Q.X,Q.Y)
					elseif rand < 75 then
						play_son(_G["son_"..T.nom.."_toc_3"],2,Q.X,Q.Y)
					else
						play_son(_G["son_"..T.nom.."_toc_4"],2,Q.X,Q.Y)
					end

				end
			else
				Q.mode = "normal"
				Q.app[1].app.nextanim = 2
				Q.cible = nil
				Q.chef.chemin[Q.nextpoint-1].app.etat = "fini"
			end
		end
		if Q.Z > 0 then
			Q.mZ = Q.mZ-T.poid*dot
		else
			Q.Z = 0
			Q.mZ = math.max(Q.mZ,0)
		end
		Q.A = Q.A+.1*angle(Q.A,0)
		Q.sc = Q.sc+.1*(1-Q.sc)
	elseif Q.etat == "stuned" then
		Q.mX = .9*Q.mX
		Q.mY = .9*Q.mY
		Q.app[1].app.input[1] = Q.app[1].app.input[1]+.1*angle(Q.app[1].app.input[1],Q.A)
	elseif Q.etat == "mort" then
		Q.mX = .9*Q.mX
		Q.mY = .9*Q.mY
		if Q.app[1].app.anim == 4
		and Q.app[1].app.frame == 10 then
			Q.etat = "fini"
		end
		if Q.Z > 0 then
			Q.mZ = Q.mZ-T.poid*dot
		else
			Q.Z = 0
			Q.mZ = math.max(Q.mZ,0)
		end
		Q.A = Q.A+.1*angle(Q.A,0)
		Q.sc = Q.sc+.1*(1-Q.sc)
	end
	Q.X = Q.X+Q.mX
	Q.Y = Q.Y+Q.mY
	Q.Z = Q.Z+Q.mZ
	for i,h in ipairs(Q.app) do
		--h.app.speed = math.sin(crono)
		h.app.X = Q.X
		h.app.Y = Q.Y
		h.app.sx = Q.sens
		
		--h.app.A = Q.A
		--h.app.sc = Q.sc
		--h.app.sx = math.floor(math.sin(crono))*2+1
		--h.app.input[1] = math.floor(math.sin(crono))*math.pi
		--h.app.A = Q.A
	end
end
