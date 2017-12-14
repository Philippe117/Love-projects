function T.select(T,Q)
	Q.longeur_ligne_total = 0
	Q.longeur_ligne = 0
	Q.some = 0

end
function T.MP(T,Q,bu,mx,my)
	
	if Q.ligne == true then
		if bu == "l" then
			selo = false
			if Q.possi_build == true then
				if controle_shift == true then
					table.insert(controle_chemin,{X = Q.ligne_X,Y = Q.ligne_Y, batiment = Q.batiment })
					
					
					Q.longeur_ligne_total = Q.longeur_ligne_total+Q.longeur_ligne
				else
					add_chemin(Q,{{X = Q.ligne_X,Y = Q.ligne_Y,batiment = Q.batiment}})
					Q.ligne = false
				end
			end
		elseif bu == "r" then
			if controle_shift == true then
				table.insert(controle_chemin,{X = Q.ligne_X,Y = Q.ligne_Y})
				Q.longeur_ligne_total = Q.longeur_ligne_total+Q.longeur_ligne
			else
				Q.ligne = false
				controle_chemin = {}
			end
		end
	else
		if bu == "l" then
			selectioner(canselect)
		end
	end
end
function T.KR(T,Q,k)
	if k == "rshift"
	or k == "lshift" then
		if Q.ligne == true
		and controle_chemin[1] ~= nil then
			add_chemin(Q,controle_chemin)
			Q.ligne = false
			controle_chemin = {}
			largeur_ligne = 1
		end
	end
end
function T.update_select(T,Q,dot)
	if Q.etat ~= "mort" then

		if Q.ligne == true
		and selection.can_order == true then

			if controle_chemin[1] ~= nil then
				local h = controle_chemin[table.maxn(controle_chemin)]
				Q.possi_ligne,Q.ligne_X,Q.ligne_Y = colichemin(h.X,h.Y,moux,mouy,Q.equipe,Q.longeur_ligne_max-Q.longeur_ligne_total)
				Q.longeur_ligne = math.sqrt((h.X-Q.ligne_X)^2+(h.Y-Q.ligne_Y)^2)
			else
				local dist = math.sqrt((Q.X-moux)^2+(Q.Y-mouy)^2)

				Q.possi_ligne,Q.ligne_X,Q.ligne_Y = colichemin(Q.X-(Q.X-moux)/dist*40,Q.Y-(Q.Y-mouy)/dist*40,moux,mouy,Q.equipe,Q.longeur_ligne_max)
				Q.longeur_ligne = math.sqrt((Q.X-Q.ligne_X)^2+(Q.Y-Q.ligne_Y)^2)
			end

			Q.possi_build = true
			for i,h in ipairs(equipe[Q.equipe].unit) do
				if h.unit.tipe.zone_sise ~= 0 then
					local dist = math.sqrt((math.floor(Q.ligne_X/30)*30+15-h.unit.X)^2+(math.floor(Q.ligne_Y/30)*30+15-h.unit.Y)^2)
					if dist < h.unit.tipe.zone_sise then
						Q.possi_build = false
					end
				end
			end
			for i,h in ipairs(equipe[Q.equipe].projet) do
				if h.batiment.zone_sise ~= 0 then
					local dist = math.sqrt((math.floor(Q.ligne_X/30)*30+15-h.X)^2+(math.floor(Q.ligne_Y/30)*30+15-h.Y)^2)
					if dist < h.batiment.zone_sise then
						Q.possi_build = false
					end
				end
			end
			for i,h in ipairs(controle_chemin) do
				if h.batiment ~= nil
				and h.batiment.zone_sise ~= 0 then
					local dist = math.sqrt((math.floor(Q.ligne_X/30)*30+15-h.X)^2+(math.floor(Q.ligne_Y/30)*30+15-h.Y)^2)
					if dist < h.batiment.zone_sise then
						Q.possi_build = false
					end
				end

			end
		end
	end
end
function T.draw_select_sol(T,Q)
	love.graphics.setColor(255,255,255,150)
	if Q.ligne == true then
		for i,h in ipairs(equipe[Q.equipe].unit) do
			if h.unit.tipe.zone_sise ~= 0 then
				love.graphics.draw( 	zone ,
							(h.unit.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(h.unit.Y-cam_y  )*zoom+love.graphics.getHeight()/2,
							0,
							zoom/100*h.unit.tipe.zone_sise ,
							zoom/100*h.unit.tipe.zone_sise ,
							100 , 100 )

			end
		end
		for i,h in ipairs(equipe[Q.equipe].projet) do
			if h.batiment.zone_sise ~= 0 then

				love.graphics.draw( 	zone ,
							(math.floor(h.X/30)*30+15-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(math.floor(h.Y/30)*30+15-cam_y  )*zoom+love.graphics.getHeight()/2,
							0,
							zoom/100*h.batiment.zone_sise ,
							zoom/100*h.batiment.zone_sise ,
							100 , 100 )
			end
		end




		if controle_chemin[1] ~= nil then
			for i,h in ipairs(controle_chemin) do
				if i == 1 then
					draw_ligne(ora,	(Q.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(Q.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
							(h.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(h.Y-cam_y  )*zoom+love.graphics.getHeight()/2,
							zoom*math.max(.1,(Q.longeur_ligne_max-Q.longeur_ligne_total-Q.longeur_ligne)/Q.longeur_ligne_max+.1))
				else
					draw_ligne(ora,	(controle_chemin[i-1].X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(controle_chemin[i-1].Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
							(h.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(h.Y-cam_y  )*zoom+love.graphics.getHeight()/2,
							zoom*math.max(.1,(Q.longeur_ligne_max-Q.longeur_ligne_total-Q.longeur_ligne)/Q.longeur_ligne_max+.1))
				end
				if h.batiment ~= nil then
					if h.batiment.zone_sise ~= 0 then
						love.graphics.draw( 	zone ,
									(math.floor(h.X/30)*30+15-cam_x  )*zoom+love.graphics.getWidth()/2 ,
									(math.floor(h.Y/30)*30+15-cam_y  )*zoom+love.graphics.getHeight()/2,
									0,
									zoom/100*h.batiment.zone_sise ,
									zoom/100*h.batiment.zone_sise ,
									100 , 100 )
					end
					love.graphics.draw( 	h.batiment.icone ,
								(math.floor(h.X/30)*30-cam_x  )*zoom+love.graphics.getWidth()/2 ,
								(math.floor(h.Y/30)*30-cam_y  )*zoom+love.graphics.getHeight()/2 ,
								0 ,
								zoom*30/100,
								zoom*30/100 )
				end
			end
			draw_ligne(ora,	(controle_chemin[table.maxn(controle_chemin)].X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
					(controle_chemin[table.maxn(controle_chemin)].Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
					(Q.ligne_X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
					(Q.ligne_Y-cam_y  )*zoom+love.graphics.getHeight()/2,
					zoom*math.max(.1,(Q.longeur_ligne_max-Q.longeur_ligne_total-Q.longeur_ligne)/Q.longeur_ligne_max+.1))
		else
			draw_ligne(ora,	(Q.X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
					(Q.Y-cam_y  )*zoom+love.graphics.getHeight()/2 ,
					(Q.ligne_X-cam_x  )*zoom+love.graphics.getWidth()/2 ,
					(Q.ligne_Y-cam_y  )*zoom+love.graphics.getHeight()/2,
					zoom*math.max(.1,(Q.longeur_ligne_max-Q.longeur_ligne_total-Q.longeur_ligne)/Q.longeur_ligne_max+.1))

		end
		if Q.possi_build == true then
			love.graphics.setColor(255,255,255,150)
		else
			love.graphics.setColor(255,0,0,150)
		end
		love.graphics.draw( 	Q.batiment.icone ,
					(math.floor(Q.ligne_X/30)*30-cam_x  )*zoom+love.graphics.getWidth()/2 ,
					(math.floor(Q.ligne_Y/30)*30-cam_y  )*zoom+love.graphics.getHeight()/2 ,
					0 , 
					zoom*30/100,
					zoom*30/100 )
	end
end
function T.draw_select_par_dessu(T,Q)

	love.graphics.setColor(255,220,50,255)
	if Q.ligne == true then
		love.graphics.print( Q.some , 	(moux-cam_x  )*zoom+love.graphics.getWidth()/2 ,
						(mouy-cam_y  )*zoom+love.graphics.getHeight()/2 )
	end




end
function T.draw_select_interface(T,Q)




end
function T.deselect(T,Q)
	Q.ligne = false

end

