function T.load(T)
	T.app = {{	app = model_humain_forum	}}
	T.selectable = true
	T.attacable = true
	T.santer = 500
	T.vrais_nom = "forum"
	T.present = true
	T.prix = 120
	T.hauteur = 20
	T.zone_sise = 100
end
function T.start(T)


end
function T.creation(T,Q)

	Q.X = math.floor(Q.X/30)*30+15
	Q.Y = math.floor(Q.Y/30)*30+15

	set_color_b(Q.X,Q.Y,200+Q.equipe)


	Q.chemin = {}
	Q.timer = crono+1

	if Q.mode == "normal" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 1
			h.app.nextanim = 1
		end
	elseif Q.mode == "build" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 2.3
			h.app.anim = 4
			h.app.nextanim = 4
		end
	end
end

function T.clic_gauche(T,Q)
	if Q.mode == "preparer le tire" then
		local dist = math.sqrt((Q.X-moux)^2+(Q.Y-mouy)^2)
		if dist < Q.max_range then
			local ang = math.atan2(mouy-Q.Y,moux-Q.X)

			local new = unit_create(Q.projectile,Q.equipe,Q.X,Q.Y,Q.Z+20,1)
			new.A = ang
			new.ciblex = moux
			new.cibley = mouy
			new.damage = 50

			new.mX = math.cos(ang)*Q.projectile.speed
			new.mY = math.sin(ang)*Q.projectile.speed
			new.mZ = -new.Z/dist*Q.projectile.speed+Q.projectile.poid*dist/Q.projectile.speed*30


			Q.timer = crono+2

			Q.ligne = false
			Q.mode = "normal"
		end
	end

end
function T.clic_droit(T,Q)
	if Q.mode == "preparer le tire" then
		Q.ligne = false
		Q.mode = "normal"
	end

end


function T.hit(T,Q)

	if Q.santer <= 0 then
		new = unit_create( unit_humain_grote , Q.equipe , Q.X , Q.Y , 0 , Q.sens , "build")
		if selection == Q then
			selectioner(new)
		end
	end

end
function T.mort(T,Q)
	add_chemin(Q , {})
	set_color_b(Q.X,Q.Y,0)

	Q.app[1].app.nextanim = 2
	Q.app[1].app.frame = 1
	Q.app[1].app.nextframe = 2
	Q.app[1].app.speed = 1


end
function T.ia(T,Q)


end
function T.update(T,Q,dot)

	if Q.etat == "vivant" then
		if Q.mode == "build" then
			if Q.app[1].app.anim == 4
			and Q.app[1].app.frame == 3 then
				Q.mode = "normal"
				Q.app[1].app.nextanim = 1
				Q.app[1].app.speed = 1
			end
		elseif Q.mode == "normal" then
			if Q.timer < crono then
				equipe[Q.equipe].gold = equipe[Q.equipe].gold+1

				Q.timer = crono+1
			end


			if Q.can_order == true then
				if Q.app[1].app.nextanim ~= 1 then
					Q.app[1].app.nextanim = 1
					Q.chemin = {}
				end

			else
				if Q.app[1].app.nextanim ~= 3 then
					Q.app[1].app.nextanim = 3
					Q.ligne = false
				end
			end

		elseif Q.mode == "preparer le tire" then

			if math.sqrt((Q.X-moux)^2+(Q.Y-mouy)^2) < Q.max_range then
				possi_point = true
			else
				possi_point = false
			end
		end



	elseif Q.etat == "mort" then
		if Q.app[1].app.anim == 2
		and Q.app[1].app.frame == 4 then
			Q.etat = "fini"
		end



	end
	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
		--h.app.sx = math.floor(math.sin(crono))*2+1
		--h.app.input[1] = math.floor(math.sin(crono))*math.pi
		--h.app.A = math.sin(crono)
	end


end
