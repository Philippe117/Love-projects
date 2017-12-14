function I.load(I)
	start_gold = 400
	son_start()
	unit_load()
	unit_start()

	team = 1

	equipe = {}
	equipe[1] = {	couleur = {0,100,255} ,
			unit = {},
			projet = {},
			gold = start_gold
							}
	equipe[2] = {	couleur = {255,0,0} ,
			unit = {},
			projet = {},
			gold = start_gold
							}
	for i,h in ipairs(equipe) do
		h.point = 0
	end
	zoom = 1
	cam_x = 0
	cam_y = 0
	map_start(map_mape,"skirmish")
	select = love.graphics.newImage("Menu/play/select.png")
	ora = love.graphics.newImage("Menu/play/ora.png")
	construction = love.graphics.newImage("Menu/play/construction.png")
	bloom = love.graphics.newImage("Menu/play/bloom.png")
	limite = love.graphics.newImage("Menu/play/limite.png")
	int_1 = love.graphics.newImage("Menu/play/interface1.1.png")
	int_2 = love.graphics.newImage("Menu/play/interface1.2.png")
	int_3 = love.graphics.newImage("Menu/play/interface1.3.png")
	cible = love.graphics.newImage("Menu/play/cible.png")
	zone = love.graphics.newImage("Menu/play/zone.png")

	controle_chemin = {}
	souris_mode = "normal"
	souris_model = nil
	controle_shift = false
	controle_lshift = false
	controle_rshift = false
	possi_ligne = true
	largeur_ligne = .5
	longeur_ligne_max = 1000
	longeur_ligne_total = 0
	longeur_ligne = 0
	crono = 0
	M.image = love.graphics.newImage(M.carter)
	M.image:setFilter( "nearest","nearest" )



	selo = true

	raly = new_son("Menu/play/RallyPoint.ogg",1)

end
function I.deload(I)
end
function I.MP(I,mx,my,bu)

	if pointer == 0
	and selection ~= nil then
		selection.tipe.MP(selection.tipe,selection,bu,mx,my)
	end
	if bu == "wd" then
		if zoom > 1.8 then
			zoom = .9*zoom
			cam_x = math.min(M.Width,math.max(0,cam_x+.1*(-mx+love.graphics.getWidth()/2)/zoom))
			cam_y = math.min(M.Height,math.max(0,cam_y+.1*(-my+love.graphics.getHeight()/2)/zoom))
		end
	elseif bu == "wu" then
		if zoom < 20 then
			zoom = 1.1*zoom
			cam_x = math.min(M.Width,math.max(0,cam_x-.1*(-mx+love.graphics.getWidth()/2)/zoom))
			cam_y = math.min(M.Height,math.max(0,cam_y-.1*(-my+love.graphics.getHeight()/2)/zoom))
		end
	elseif bu == "r" then





	elseif bu == "l" then


	end
end
function I.MR(I,mx,my,bu)

	if pointer == 0 then
		if selection ~= nil then
			selection.tipe.MR(selection.tipe,selection,bu,mx,my)
		end

		if bu == "l" then
			if selection == nil then
				selectioner(canselect)

			end
		end
	end

end
function I.KP(I,k)

	if selection ~= nil then
		selection.tipe.KP(selection.tipe,selection,k)
	end
	if k == "escape" then
		love.event.push('q')

	elseif k == "lshift" then
		controle_shift = true
	elseif k == "rshift" then
		controle_shift = true
	elseif k == " " then
		if team == 1 then
			team = 2
		else
			team = 1
		end
	end
end
function I.KR(I,k)
	if selection ~= nil then
		selection.tipe.KR(selection.tipe,selection,k)
	end
	if k == "lshift" then
		controle_lshift = false
		if controle_rshift == false then
			controle_shift = false
		end
	elseif k == "rshift" then
		controle_rshift = false
		if controle_lshift == false then
			controle_shift = false
		end
	end
end
function selectioner(qui)


	if qui ~= selection then
		if selection ~= nil then
			selection.tipe.deselect(selection.tipe,selection)
		end
		if qui ~= nil then
			qui.tipe.select(qui.tipe,qui)
		end

		selection = qui
		txt = txt+1
	end

end
function add_chemin(qui,chemin)
	for i,h in ipairs(qui.chemin) do
		if h.app ~= nil then
			h.app.etat = "fini"
		end
		if h.proj ~= nil then
			h.proj.etat = "fini"
		end
	end
	qui.chemin = {}
	for i,h in ipairs(chemin) do
		table.insert(qui.chemin,h)
		local newy = qui.chemin[table.maxn(qui.chemin)]
		if h.batiment ~= nil then
			model_create(model_obj_barriere,math.floor(h.X/30)*30+15,math.floor(h.Y/30)*30+30,0,0,1)
			h.proj = add_projet(h.batiment,h.X,h.Y,qui.equipe)

		else
			model_create(model_obj_jonction,h.X,h.Y,0,0,1)
		end
		newy.app = app[table.maxn(app)]
	end
end
function I.update(I,dot)

	moux = math.min(M.Width+15,math.max(-15,(love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x))
	mouy = math.min(M.Height,math.max(0,(love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y))
	if love.keyboard.isDown("up") then
		cam_y = math.max(0,cam_y-800*dot/zoom)
	end
	if love.keyboard.isDown("down") then
		cam_y = math.min(M.Height,cam_y+800*dot/zoom)
	end
	if love.keyboard.isDown("left") then
		cam_x = math.max(0,cam_x-800*dot/zoom)
	end
	if love.keyboard.isDown("right") then
		cam_x = math.min(M.Height,cam_x+800*dot/zoom)
	end

	if selection ~= nil then
		if selection.etat ~= "mort"
		and selection.etat ~= "fini"
		and selection.selectable == true then
			selection.tipe.update_select(selection.tipe,selection,dot)
		else
			selectioner(nil)
		end
	end







	local nearest = 0
	local near = 1000000
	for i,h in ipairs(equipe[team].unit) do
		if h.unit.selectable == true then
			local dist = math.sqrt((moux-h.unit.X)^2+(mouy-h.unit.Y)^2)
			if dist < h.unit.tipe.circle_sise then
				if dist < near then
					near = dist
					nearest = h.unit
				end
			end
		end
	end
	if nearest ~= 0 then
		canselect = nearest
	else
		canselect = nil
	end


	if crono == 0 then
		crono = crono+.05
	else
		crono = crono+dot
	end


	unit_update(dot)
	son_update(dot)
	model_update(dot)
	--txt = colibl(moux,mouy)
end
function I.draw(I)
	love.graphics.setFont( f )
	map_draw()
--	zoom = zoom+.001*math.sin(2.6*crono)/zoom
--	cam_x = cam_x+.1*math.sin(2.3*crono)/zoom
--	cam_y = cam_y+.1*math.sin(2*crono)/zoom
	for e,g in ipairs(equipe) do
		for i,h in ipairs(g.unit) do
			if h.unit.tipe.sol ~= nil then
				love.graphics.setColor(255,255,255,h.unit.a_sol)
				love.graphics.draw( 	h.unit.tipe.sol ,
								(h.unit.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
								(h.unit.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
								0 ,
								zoom,
								zoom,
								h.unit.tipe.sol:getWidth()/2,
								h.unit.tipe.sol:getHeight()/2 )



			end
			--	love.graphics.print( 	i ,
			--				(h.unit.X+15-cam_x  )*zoom+love.graphics.getWidth()/2+2*i ,
			--				(h.unit.Y+15-cam_y  )*zoom+love.graphics.getHeight()/2+10*i
			--					 )

		end
	end

	for i,h in ipairs(equipe[team].unit) do
		love.graphics.setColor(equipe[1].couleur[1],equipe[1].couleur[2],equipe[1].couleur[3])
		if h.unit.selectable == true then
			for e,g in ipairs(h.unit.chemin) do
				if e == 1 then
					draw_ligne(ora,	(h.unit.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(h.unit.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
							(g.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(g.Y-cam_y  )*zoom+love.graphics.getHeight()/2,
							zoom*.2)
				else
					draw_ligne(ora,	(g.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(g.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
							(h.unit.chemin[e-1].X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(h.unit.chemin[e-1].Y-cam_y  )*zoom+love.graphics.getHeight()/2,
							zoom*.2)
				end
			end
		end
	end

	if canselect ~= nil then
		love.graphics.setColor(equipe[canselect.equipe].couleur[1],equipe[canselect.equipe].couleur[2],equipe[canselect.equipe].couleur[3])
		love.graphics.draw( 	select ,
						(canselect.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
						(canselect.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
						0 ,
						zoom*1.2*canselect.tipe.circle_sise/25,
						zoom*1.2*canselect.tipe.circle_sise/25,
						25,
						25 )
	end
	if selection ~= nil then
		love.graphics.setColor(equipe[selection.equipe].couleur[1],equipe[selection.equipe].couleur[2],equipe[selection.equipe].couleur[3])
		love.graphics.draw( 	select ,
						(selection.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
						(selection.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
						0 ,
						zoom*selection.tipe.circle_sise/25,
						zoom*selection.tipe.circle_sise/25,
						25,
						25 )
	end
	love.graphics.setColor(255,255,255)
	draw_ligne( limite,	-cam_x*zoom+love.graphics.getWidth()/2 ,
				-cam_y*zoom+love.graphics.getHeight()/2 ,
				-cam_x*zoom+love.graphics.getWidth()/2 ,
				(M.Height-cam_y  )*zoom+love.graphics.getHeight()/2,
				zoom)
	draw_ligne( limite,	(M.Width-cam_x)*zoom+love.graphics.getWidth()/2 ,
				(M.Height-cam_y)*zoom+love.graphics.getHeight()/2 ,
				(M.Width-cam_x)*zoom+love.graphics.getWidth()/2 ,
				-cam_y*zoom+love.graphics.getHeight()/2,
				zoom)

	if selection ~= nil then
		selection.tipe.draw_select_sol(selection.tipe,selection)
	end
	model_draw()
	if selection ~= nil then
		selection.tipe.draw_select_par_dessu(selection.tipe,selection)
	end

	for e,g in ipairs(equipe) do
		for i,h in ipairs(g.unit) do
			local dist = math.sqrt((moux-h.unit.X)^2+(mouy-h.unit.Y)^2)*zoom/2
			love.graphics.setColor(0,0,0,math.max(0,math.min(255,(355/math.max(1,dist/30))-100)))
			love.graphics.rectangle( "fill", (h.unit.X-cam_x)*zoom+love.graphics.getWidth()/2-18, (h.unit.Y-cam_y)*zoom+love.graphics.getHeight()/2, 36 , 6 )
			love.graphics.setColor(math.min(255,510-510*(h.unit.santer/h.unit.tipe.santer)),math.min(255,510*(h.unit.santer/h.unit.tipe.santer)),0,math.max(0,math.min(255,(355/math.max(1,dist/30))-100)))
			love.graphics.rectangle( "fill", (h.unit.X-cam_x)*zoom+love.graphics.getWidth()/2-17, (h.unit.Y-cam_y)*zoom+love.graphics.getHeight()/2+1, 34*math.max(0,h.unit.santer/h.unit.tipe.santer) , 4 )

		end
	end
	love.graphics.setColor(255,255,255)
	love.graphics.draw( 	int_1 ,
				minimap_X-10 ,
				minimap_Y-10
				 )
	if selection ~= nil then


		love.graphics.draw( 	int_2 ,
					minimap_X-10+277 ,
					minimap_Y-2
					 )
		if selection.liste ~= nil then
			love.graphics.draw( 	int_3 ,
						minimap_X-10+684 ,
						minimap_Y+168
						 )
		end
	end
	if selection ~= nil then
		love.graphics.draw( 	selection.tipe.icone ,
						icon_X+3 ,
						icon_Y+1 ,
						0 ,
						143/100
						 )
		if selection.mode == "build" then
			love.graphics.draw( 	construction ,
							icon_X+3 ,
							icon_Y+1 ,
							0 ,
							143/100
							 )
		end
		for i,h in ipairs(selection.tipe.power) do
			love.graphics.draw( 	h.icone ,
							inter_power_X+h.X*75+4 ,
							inter_power_Y+h.Y*75+4 ,
							0 , 67/100
							 )
		end
		love.graphics.setColor(math.min(255,510-510*(selection.santer/selection.tipe.santer)),math.min(255,510*(selection.santer/selection.tipe.santer)),0,200)
		love.graphics.rectangle( "fill", 285, love.graphics.getHeight()-41, 149*math.max(0,selection.santer/selection.tipe.santer) , 18 )
		love.graphics.setColor(0,0,0)
		love.graphics.print( 	""..selection.santer.."/"..selection.tipe.santer.."" ,
					288 ,
					love.graphics.getHeight()-40
						 )
		love.graphics.print( 	""..selection.tipe.vrais_nom.."" ,
					288 ,
					love.graphics.getHeight()-75
						 )
		if selection.liste ~= nil then
			love.graphics.setColor(255,255,255)
			for i,h in ipairs(selection.liste) do
				love.graphics.draw( 	h.unit.icone ,
							inter_liste_X+i*50+2 ,
							inter_liste_Y-11 ,
							0 , 46/100
								 )
				love.graphics.print( 	h.nb ,
							inter_liste_X+i*50+37 ,
							inter_liste_Y +20
								 )
			end
			if selection.liste[selection.pointe[1]] ~= nil then
				love.graphics.print( 	selection.pointe[2] ,
							inter_liste_X+selection.pointe[1]*50+16 ,
							inter_liste_Y-47
								 )
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle( "fill", 	inter_liste_X+selection.pointe[1]*50,
								 	inter_liste_Y-25,
	 								50 , 10 )
				love.graphics.setColor(200,255,50)
				love.graphics.rectangle( "fill",	inter_liste_X+selection.pointe[1]*50+1,
								 	inter_liste_Y-24,
									48-48*math.max(0,(selection.progression/selection.liste[selection.pointe[1]].unit.build_time)) , 8 )
			end
		end
	end

	love.graphics.setColor(255,255,255,180)
	love.graphics.draw( 	M.mini ,
				minimap_X ,
				minimap_Y , 0 , M.minimap_ratio )
	love.graphics.setColor(255,255,255)
	local ex = math.max(0,(cam_x-love.graphics.getWidth()/2/zoom)*M.minimap_ratio/30)
	local ey = math.max(0,(cam_y-love.graphics.getHeight()/2/zoom)*M.minimap_ratio/30)

	love.graphics.rectangle( "line", 	minimap_X+ex ,
						minimap_Y+ey ,
						-ex+math.min(260,(cam_x+love.graphics.getWidth()/2/zoom)*M.minimap_ratio/30) ,
						-ey+math.min(260,(cam_y+love.graphics.getHeight()/2/zoom)*M.minimap_ratio/30)  )

	for e,g in ipairs(equipe) do
		love.graphics.setColor(g.couleur[1],g.couleur[2],g.couleur[3])
		for i,h in ipairs(g.unit) do
			if h.unit.X > 0
			and h.unit.X < M.Width then

				if h.unit.tipe.circle_sise ~= 0 then
					love.graphics.draw( 	point ,
								minimap_X+h.unit.X*M.minimap_ratio/30 ,
								minimap_Y+h.unit.Y*M.minimap_ratio/30 , 0 , 1,1,5,5 )
				else
					love.graphics.draw( 	point ,
								minimap_X+h.unit.X*M.minimap_ratio/30 ,
								minimap_Y+h.unit.Y*M.minimap_ratio/30 , 0 , .3,.3,5,5 )
				end
			end
		end
	end

	if selection ~= nil then
		selection.tipe.draw_select_interface(selection.tipe,selection)
	end



--	for e,g in ipairs(son_list) do
--		love.graphics.print( ""..g.pointe.."" , 200+100*e , 200 )
--		for i,h in ipairs(g.liste) do
--			if h.son ~= nil then
--				love.graphics.print( "oui" , 230+100*e , 200+20*i )
--			else
--				love.graphics.print( "non" , 230+100*e , 200+20*i )
--			end
--		end
--	end

	love.graphics.print( equipe[1].point , 10 , 200 )
	love.graphics.print( fps , 10 , 10 )

	love.graphics.print( colibl(moux,mouy) , 10 , 150 )
	love.graphics.print( "gold: "..equipe[team].gold.."" , 500 , 10 )
	love.graphics.print( "team: "..team.."" , 500 , 60 )
end
