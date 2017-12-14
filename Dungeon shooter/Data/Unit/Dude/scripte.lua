function T.init(T)
	T.speed = 1
	T.colision = .5
	T.hauteur = 1
	T.santer = 100
	T.vue = 10
	T.arc = 2
	T.reflex = .5


end
function T.creation(T,Q,I)
	Q.hauteur = T.hauteur
	Q.dep_m = .1
	Q.dep_n = -.05
	Q.dep_o = 0
	Q.santer = T.santer
	Q.app = {	{sprite = _G["unit_"..Q.tipe.nom.."_anim_run"] 	, x = Q.x , y = Q.y , z = Q.z+20 , A = Q.A , Az = Q.Az , frame = 1 , lastframe = 0},
			{sprite = _G["unit_"..Q.tipe.nom.."_anim_stand"] 	, x = Q.x , y = Q.y , z = Q.z+40 , A = Q.A , Az = Q.Az , frame = 1 , lastframe = 0}
																					}

	if Q ~= hero then
		Q.reflex = crono+1
		Q.rafale = 0
		Q.pause = 0
	


	end

end
function T.hit(T,Q,I,missi)
	if Q ~= hero then
		Q.A = Q.A+.8*angle(Q.A,missi.A+math.pi)
	end



end
function T.mort(T,Q,I,missi)

	Q.dep_m = 0
	Q.dep_n = 0
	Q.app[2].z = 0
	Q.app[1].sprite = _G["unit_"..Q.tipe.nom.."_anim_mort"]
	Q.app[1].frame = 1
	Q.app[1].lastframe = 0
	Q.cible = nil
	table.remove(Q.app,2)


end
function T.MP(T,Q,mx,my,bu)
	if Q.mode ~= "mort" then
		if bu == "l" then

			Q.app[2].sprite = _G["unit_"..Q.tipe.nom.."_anim_fire"]
			Q.app[2].frame = 1
			Q.app[2].lastframe = 0

		end
	end
end
function T.MR(T,Q,mx,my,bu)
	if Q.mode ~= "mort" then
		if bu == "l" then

			Q.app[2].sprite = _G["unit_"..Q.tipe.nom.."_anim_stand"]
			Q.app[2].frame = 1
			Q.app[2].lastframe = 0
		end
	end
end
function T.KP(T,Q,k)
	if Q.mode ~= "mort" then
		if k == " " then
			Q.dep_o = 10
		end
	end
end
function T.KR(T,Q,k)
	if Q.mode ~= "mort" then
		if k == " " then
			Q.dep_o = 0
		end
	end
end
function T.update_hero(T,Q,dot)

	if Q.mode ~= "mort" then
		if love.keyboard.isDown("w") then
			Q.dep_n = .8*Q.dep_n-.1
		end
		if love.keyboard.isDown("s") then
			Q.dep_n = .8*Q.dep_n+.1
		end
		if love.keyboard.isDown("a") then
			Q.dep_m = .8*Q.dep_m-.1
		end
		if love.keyboard.isDown("d") then
			Q.dep_m = .8*Q.dep_m+.1
		end
	end
	cam_x = cam_x+Q.m*dot*1.5
	cam_y = cam_y+Q.n*dot*1.5
	cam_x = cam_x+.06*((4*Q.x+3*moux)/7-cam_x)*zoom
	cam_y = cam_y+.06*((4*Q.y+3*mouy)/7-cam_y)*zoom
	--cam_z = cam_z+.06*(mouz+800-cam_z)
	zoom = zoom+.06*(10/Q.z+1.8-zoom)



	Q.A = Q.A+.20*math.min(.9,math.max(-.9,angle(Q.A,math.atan2((mouy-Q.y),(moux-Q.x)))))
	Q.Az = math.min(1,math.max(-1,Q.Az+.20*math.min(.9,math.max(-.9,angle(Q.Az,math.atan2((mouz-Q.z-10)/25,math.sqrt((moux-Q.x)^2+(mouy-Q.y)^2)))))))




end
function T.ia(T,Q,I)

	if Q.mode == "normal" then




		if Q.cible == nil then


			local diste = 10000
			local equi = 1
			if equi == Q.equipe then
				equi = equi+1
			end


			while carto[equi] ~= nil do
				local list = recherche(Q.x,Q.y,Q.A,T.arc,T.vue,equi)

				for e,g in ipairs(list) do
					for u,k in ipairs(g) do
						if k.mode ~= "mort" then

							local dist = math.sqrt((Q.x-k.x)^2+(Q.y-k.y)^2+(Q.z/25+Q.hauteur-k.z/25-k.hauteur)^2)
							if dist < T.vue
							and dist < diste
							and math.abs(angle(math.atan2(k.y-Q.y,k.x-Q.x),Q.A)) < T.arc then
								possi = true
								di = 1
								while di <= dist do
									if coliv(Q.x+(k.x-Q.x)/dist*di,Q.y+(k.y-Q.y)/dist*di) > Q.z+Q.hauteur*25+(k.z+k.hauteur*25-Q.z-Q.hauteur*25)/dist*di then
										possi = false
										di = 1000
									end
									di = di+.5
								end
								if possi == true then
									Q.cible = k
									diste = dist
									Q.reflex = crono+T.reflex
								end

							end


						end

					end

				end

				equi = equi+1
				if equi == Q.equipe then
					equi = equi+1
				end

			end
			if Q.reflex < crono then
				if Q.app[2].sprite ~= _G["unit_"..Q.tipe.nom.."_anim_stand"] then
					Q.app[2].sprite = _G["unit_"..Q.tipe.nom.."_anim_stand"]
	 				Q.app[2].frame = 1
	 				Q.app[2].lastframe = 0
				end
				Q.dep_m = (1*Q.dep_m+math.random(-5,20)/10)/2
				Q.dep_n = (1*Q.dep_n+math.random(-5,20)/10)/2
				Q.A = Q.A+Q.dep_n+math.random(-10,10)/100+.1*angle(Q.A,math.atan2(Q.dep_n,Q.dep_m))

			end
		else

			if Q.reflex < crono then
				if Q.rafale < crono then


					if Q.app[2].sprite ~= _G["unit_"..Q.tipe.nom.."_anim_stand"] then
						Q.app[2].sprite = _G["unit_"..Q.tipe.nom.."_anim_stand"]
		 				Q.app[2].frame = 1
		 				Q.app[2].lastframe = 0
						Q.pause = crono+.8
					end

					if Q.pause < crono then
						if Q.app[2].sprite ~= _G["unit_"..Q.tipe.nom.."_anim_fire"] then
							Q.app[2].sprite = _G["unit_"..Q.tipe.nom.."_anim_fire"]
			 				Q.app[2].frame = 1
			 				Q.app[2].lastframe = 0
							Q.rafale = crono+.2
						end
					end




				end
			end
			local dist = math.sqrt((Q.x-Q.cible.x)^2+(Q.y-Q.cible.y)^2+(Q.z/25+Q.hauteur-Q.cible.z/25-Q.cible.hauteur)^2)

			if Q.cible.mode ~= "mort"
			and dist < T.vue+1 then
	


				Q.A = Q.A+.9*math.min(.9,math.max(-.9,angle(Q.A,math.atan2((Q.cible.y-Q.y),(Q.cible.x-Q.x)))))
				Q.Az = math.min(1,math.max(-1,Q.Az+.20*math.min(.9,math.max(-.9,angle(Q.Az,math.atan2((Q.cible.z-Q.z-10)/25,math.sqrt((Q.cible.x-Q.x)^2+(Q.cible.y-Q.y)^2)))))))



				di = 1
				while di <= dist do
					if coliv(Q.x+(Q.cible.x-Q.x)/dist*di,Q.y+(Q.cible.y-Q.y)/dist*di) > Q.z+Q.hauteur*25+(Q.cible.z+Q.cible.hauteur*25-Q.z-Q.hauteur*25)/dist*di then
						Q.cible = nil
						di = 10000
						Q.reflex = crono+1
					end
					di = di+.5
				end

			else
				txt = txt+1
				Q.cible = nil
				Q.reflex = crono+1
			end
		end





	end


end
function T.update(T,Q,I,dot)





	if coliv(Q.x,Q.y-1) > Q.z+10 then
		if Q.y < math.floor(Q.y)+.3 then
			Q.y = math.floor(Q.y)+.30001
			Q.m = .95*Q.m
			Q.n = math.max(0,Q.n)
		end
	end
	if coliv(Q.x,Q.y+1) > Q.z+10 then
		if Q.y > math.floor(Q.y)+.7 then
			Q.y = math.floor(Q.y)+.6999
			Q.m = .95*Q.m
			Q.n = math.min(0,Q.n)
		end
	end
	if coliv(Q.x-1,Q.y) > Q.z+10 then
		if Q.x < math.floor(Q.x)+.3 then
			Q.x = math.floor(Q.x)+.30001
			Q.n = .95*Q.n
			Q.m = math.max(0,Q.m)
		end
	end
	if coliv(Q.x+1,Q.y) > Q.z+10 then
		if Q.x > math.floor(Q.x)+.7 then
			Q.x = math.floor(Q.x)+.6999
			Q.n = .95*Q.n
			Q.m = math.min(0,Q.m)
		end
	end


	if Q.z <= math.max(coliv(Q.x,Q.y),coliv(Q.x-.3,Q.y),coliv(Q.x+.3,Q.y),coliv(Q.x,Q.y-.3),coliv(Q.x,Q.y+.3))+1 then
		Q.z = math.max(coliv(Q.x,Q.y),coliv(Q.x-.3,Q.y),coliv(Q.x+.3,Q.y),coliv(Q.x,Q.y-.3),coliv(Q.x,Q.y+.3),Q.z)
		Q.o = math.max(Q.o,0)
		Q.o = Q.o-40*dot
		Q.m = Q.m+Q.dep_m
		Q.n = Q.n+Q.dep_n
		Q.o = Q.o+Q.dep_o
		Q.m = .95*Q.m
		Q.n = .95*Q.n
		Q.o = .95*Q.o
	else
		Q.o = Q.o-40*dot
		Q.m = Q.m+.2*Q.dep_m
		Q.n = Q.n+.2*Q.dep_n

	end

	if Q.mode == "normal" then



		local list = test_pos(Q.x,Q.y,0)
		for e,g in ipairs(list) do
			for u,k in ipairs(g) do
				if Q ~= k
				and Q.z+T.hauteur*25 > k.z
				and k.mode ~= "mort"
				and Q.z < k.z+k.tipe.hauteur*25 then
					local dist = math.sqrt((Q.x-k.x)^2+(Q.y-k.y)^2)
					if dist < T.colision+k.tipe.colision then


						Q.m = Q.m+1.6*(Q.x-k.x)/dist*(T.colision+k.tipe.colision-dist)
						Q.n = Q.n+1.6*(Q.y-k.y)/dist*(T.colision+k.tipe.colision-dist)

					end
				end
			end
		end












		Q.app[2].A = Q.app[2].A+.2*angle(Q.app[2].A,Q.A)
		Q.app[2].Az = math.min(.6,math.max(-.6,Q.app[2].Az+.4*angle(Q.app[2].Az,Q.Az)))
		Q.app[2].x = Q.app[2].x+.3*(Q.x-Q.app[2].x)
		Q.app[2].y = Q.app[2].y+.3*(Q.y-Q.app[2].y)
		Q.app[2].z = Q.app[2].z+.4*(Q.z-Q.app[2].z+20)


		Q.dep_m = .8*Q.dep_m
		Q.dep_n = .8*Q.dep_n

		Q.app[1].A = Q.app[1].A+.06*angle(Q.app[1].A,Q.A)
		if math.abs(angle(math.atan2(Q.n,Q.m),Q.app[2].A)) < math.pi/2.22 then
			Q.app[1].A = Q.app[1].A+.18*angle(Q.app[1].A,math.atan2(Q.n,Q.m))
			Q.app[1].frame = Q.app[1].frame+math.sqrt((Q.m+Q.dep_m)^2/2+(Q.n+Q.dep_n)^2/2)*dot*5
			if Q.app[1].frame >= table.maxn(Q.app[1].sprite)+1 then
				Q.app[1].frame = 1
				Q.app[1].lastframe = 0
			end
		else
			Q.app[1].A = Q.app[1].A+.18*angle(Q.app[1].A,math.atan2(Q.n,Q.m)-math.pi)
			Q.app[1].frame = Q.app[1].frame-math.sqrt((Q.m+Q.dep_m)^2/2+(Q.n+Q.dep_n)^2/2)*dot*5
			if Q.app[1].frame < 1 then
				Q.app[1].frame = table.maxn(Q.app[1].sprite)+.99999
				Q.app[1].lastframe = table.maxn(Q.app[1].sprite)+1
			end


		end
		Q.app[1].x = Q.app[1].x+.3*(Q.x-Q.app[1].x)
		Q.app[1].y = Q.app[1].y+.3*(Q.y-Q.app[1].y)
		Q.app[1].z = Q.app[1].z+.4*(Q.z-Q.app[1].z+10)





		if Q.app[2].sprite == _G["unit_"..Q.tipe.nom.."_anim_stand"] then
			Q.app[2].frame = Q.app[2].frame+.15
			if Q.app[2].frame >= table.maxn(Q.app[2].sprite)+1 then
				Q.app[2].frame = 1
				Q.app[2].lastframe = 0
			end


		elseif Q.app[2].sprite == _G["unit_"..Q.tipe.nom.."_anim_fire"] then

			Q.app[2].frame = Q.app[2].frame+.4
			if Q.app[2].frame >= table.maxn(Q.app[2].sprite)+1 then
				Q.app[2].frame = 1
				Q.app[2].lastframe = 0
			end
			if math.floor(Q.app[2].frame) ~= Q.app[2].lastframe
			and math.floor(Q.app[2].frame) == Q.app[2].sprite.frametire then
				Q.app[2].A = Q.app[2].A+math.random(-100,100)/1000
				Q.app[2].Az = Q.app[2].Az+math.random(-100,100)/1000
				ex , ey = point(Q.app[2],Q.app[2].sprite.tirex,Q.app[2].sprite.tirey)


				tire(ex,ey,Q.app[2].z,Q.app[2].A,Q.app[2].Az,Q.equipe,missi_balle)

			end


		elseif Q.app[2].sprite == _G["unit_"..Q.tipe.nom.."_anim_recharge"] then

			Q.app[2].frame = Q.app[2].frame+.15
			if Q.app[2].frame >= table.maxn(Q.app[2].sprite)+1 then
				Q.app[2].sprite = _G["unit_"..Q.tipe.nom.."_anim_stand"]
				Q.app[2].frame = 1
				Q.app[2].lastframe = 0
			end



		elseif Q.app[2].sprite == _G["unit_"..Q.tipe.nom.."_anim_penche"] then


			Q.app[2].frame = Q.app[2].frame+.15
			if Q.app[2].frame >= table.maxn(Q.app[2].sprite)+1 then
				Q.app[2].frame = 1
				Q.app[2].lastframe = 0
			end





		elseif Q.app[2].sprite == _G["unit_"..Q.tipe.nom.."_anim_pencher"] then







		end
	elseif Q.mode == "mort" then
		Q.app[1].z = Q.app[1].z+.4*(Q.z-Q.app[1].z)


		if Q.app[1].sprite == _G["unit_"..Q.tipe.nom.."_anim_mort"] then
			Q.app[1].frame = math.min(Q.app[1].frame+.15,table.maxn(Q.app[1].sprite))




		end
	end
end


