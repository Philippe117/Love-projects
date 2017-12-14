function I.load(I)
	sourmode = 1

	if love.filesystem.exists( "Menu/pause/Menu.gif") == true then
		Meno = love.graphics.newImage("Menu/pause/Menu.gif")
		Meno:setFilter( "nearest","nearest" )
	end

	love.graphics.setColor(255,255,255)

	love.graphics.setCanvas( arri )

		wx = -love.graphics.getWidth()/(50*zoom)/2
		while wx <= love.graphics.getWidth()/(50*zoom)/2+1 do
			wy = -love.graphics.getHeight()/(50*zoom)/2
			while wy < love.graphics.getHeight()/(50*zoom)/2+1 do
	 
				if carto[math.floor(wx+cam_x)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= 0 then
					if carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] < 100 then
						love.graphics.draw( sprite[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][1]][math.floor(checlist[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][2]][3])][1] , (math.floor(cam_x+wx)-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(math.floor(cam_y+wy)-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,-5*zoom,5*zoom,5,5)
					end
				end
				wy = wy+1
			end
			wx = wx+1
		end

	love.graphics.setCanvas(echel)
		wx = -love.graphics.getWidth()/(50*zoom)/2
		while wx <= love.graphics.getWidth()/(50*zoom)/2+1 do
			wy = -love.graphics.getHeight()/(50*zoom)/2
			while wy < love.graphics.getHeight()/(50*zoom)/2+1 do
	 
				if carto[math.floor(wx+cam_x)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= 0 then
					if carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] >= 100
					and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] < 150 then
						love.graphics.draw( sprite[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][1]][math.floor(checlist[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][2]][3])][1] , (math.floor(cam_x+wx)-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(math.floor(cam_y+wy)-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,-5*zoom,5*zoom,5,5)
					end
				end
				wy = wy+1
			end
			wx = wx+1
		end





	love.graphics.setCanvas(ava)
		love.graphics.setColor(M.rouge,M.vert,M.bleu)
		wx = -love.graphics.getWidth()/(50*zoom)/2
		while wx <= love.graphics.getWidth()/(50*zoom)/2+1 do
			wy = -love.graphics.getHeight()/(50*zoom)/2
			while wy < love.graphics.getHeight()/(50*zoom)/2+1 do
	 
				if carto[math.floor(wx+cam_x)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= 0 then
					if carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] >= 150 then
						love.graphics.draw( sprite[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][1]][math.floor(checlist[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][2]][3])][1] , (math.floor(cam_x+wx)-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(math.floor(cam_y+wy)-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,-5*zoom,5*zoom,5,5)
					end
				end
				wy = wy+1
			end
			wx = wx+1
		end
		love.graphics.setColor(255,255,255,255-255*math.max(2*(tempohit-crono),0))
		--if tempohit < crono
		if visi == true then
			if math.sin(crono*50)-math.min(2*(tempohit-crono),1) > 0 then
				love.graphics.draw( sprite[numspr][math.floor(frame)][1] , (x-cam_x)*zoom*50+love.graphics.getWidth()/2,(y-cam_y-.5)*zoom*50+love.graphics.getHeight()/2,ang,-5*zoom*sens,5*zoom,sprite[numspr][math.floor(frame)][1]:getWidth()/2,sprite[numspr][math.floor(frame)][1]:getHeight()/2)
			end
		end
		love.graphics.setColor(255,255,255)
		for i,h in ipairs(obj) do
			if math.abs(h[1][1]-cam_x) < 18 then
				love.graphics.draw( sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom*50+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom*50+love.graphics.getHeight()/2,h[2][3],5*zoom*h[2][4],5*zoom,10,10)
			end
			if objlist[h[3]][2] == "custom" then
				objlist[h[3]].draw(objlist[h[3]],h)
			end
		end


		for i,h in ipairs(missi) do
			if math.abs(h[1][1]-cam_x) < 18 then
				love.graphics.draw( sprite[missilist[h[4]][3]][math.floor(h[5])][1] , (h[1][1]-cam_x)*zoom*50+love.graphics.getWidth()/2,(h[1][2]-cam_y-.5)*zoom*50+love.graphics.getHeight()/2,h[2][3],5*zoom*h[2][1]/math.abs(h[2][1]),5*zoom,sprite[missilist[h[4]][3]][math.floor(h[5])][1]:getWidth()/2,sprite[missilist[h[4]][3]][math.floor(h[5])][1]:getHeight()/2)
			end
		end
		for i,h in ipairs(checpoint) do
			love.graphics.print( i ,(h[1]-cam_x)*zoom*50+love.graphics.getWidth()/2,(h[2]-cam_y-.5)*zoom*50+love.graphics.getHeight()/2)
		end
	love.graphics.setCanvas(arriere)
		love.graphics.setColor(255,255,255)
		love.graphics.draw( arri , 0 , 0 )
		love.graphics.setBlendMode( "multiplicative" )
		love.graphics.setColor(0,0,0,30)
		love.graphics.draw( ava , 0 , 0 )
		--love.graphics.setColor(255,255,255)
		love.graphics.draw( ava , 20+3 , 15+0 )
		love.graphics.draw( ava , 20+2 , 15+2 )
		love.graphics.draw( ava , 20+0 , 15+3 )
		love.graphics.draw( ava , 20-2 , 15+2 )
		love.graphics.draw( ava , 20-3 , 15+0 )
		love.graphics.draw( ava , 20-2 , 15-2 )
		love.graphics.draw( ava , 20+0 , 15-3 )
		love.graphics.draw( ava , 20+2 , 15-2 )

		love.graphics.draw( echel , 10+3 , 7+0 )
		love.graphics.draw( echel , 10+2 , 7+2 )
		love.graphics.draw( echel , 10+0 , 7+3 )
		love.graphics.draw( echel , 10-2 , 7+2 )
		love.graphics.draw( echel , 10-3 , 7+0 )
		love.graphics.draw( echel , 10-2 , 7-2 )
		love.graphics.draw( echel , 10+0 , 7-3 )
		love.graphics.draw( echel , 10+2 , 7-2 )
		love.graphics.setBlendMode( "alpha" )


	love.graphics.setCanvas(echelle)
		

		love.graphics.setColor(255,255,255)
		love.graphics.draw( echel , 0 , 0 )
		love.graphics.setBlendMode( "multiplicative" )
		love.graphics.setColor(0,0,0,30)
		love.graphics.draw( ava , 0 , 0 )
		--love.graphics.setColor(255,255,255)
		love.graphics.draw( ava , 10+3 , 7+0 )
		love.graphics.draw( ava , 10+2 , 7+2 )
		love.graphics.draw( ava , 10+0 , 7+3 )
		love.graphics.draw( ava , 10-2 , 7+2 )
		love.graphics.draw( ava , 10-3 , 7+0 )
		love.graphics.draw( ava , 10-2 , 7-2 )
		love.graphics.draw( ava , 10+0 , 7-3 )
		love.graphics.draw( ava , 10+2 , 7-2 )
		love.graphics.setBlendMode( "alpha" )



	love.graphics.setCanvas(avant)
		love.graphics.setColor(255,255,255)
		love.graphics.draw( ava , 0 , 0 )
	love.graphics.setCanvas(bloom)
		if fon ~= nil then
			love.graphics.draw( fon , 0,0,0,love.graphics.getWidth()/fon:getWidth(),love.graphics.getHeight()/fon:getHeight())
		end
		love.graphics.setColor(0,0,0,200)
		love.graphics.draw( arriere , 2 , 0 )
		love.graphics.draw( arriere , 1 , 1 )
		love.graphics.draw( arriere , 0 , 2 )
		love.graphics.draw( arriere , -1 , 1 )
		love.graphics.draw( arriere , -2 , 0 )
		love.graphics.draw( arriere , -1 , -1 )
		love.graphics.draw( arriere , 0 , -2 )
		love.graphics.draw( arriere , 1 , -1 )
		love.graphics.setColor(255,255,255)
		love.graphics.draw( arriere , 0 , 0 )




		love.graphics.setColor(0,0,0,200)
		love.graphics.draw( echelle , 2 , 0 )
		love.graphics.draw( echelle , 1 , 1 )
		love.graphics.draw( echelle , 0 , 2 )
		love.graphics.draw( echelle , -1 , 1 )
		love.graphics.draw( echelle , -2 , 0 )
		love.graphics.draw( echelle , -1 , -1 )
		love.graphics.draw( echelle , 0 , -2 )
		love.graphics.draw( echelle , 1 , -1 )
		love.graphics.setColor(255,255,255)
		love.graphics.draw( echelle , 0 , 0 )



		love.graphics.setColor(0,0,0,200)
		love.graphics.draw( avant , 2 , 0 )
		love.graphics.draw( avant , 1 , 1 )
		love.graphics.draw( avant , 0 , 2 )
		love.graphics.draw( avant , -1 , 1 )
		love.graphics.draw( avant , -2 , 0 )
		love.graphics.draw( avant , -1 , -1 )
		love.graphics.draw( avant , 0 , -2 )
		love.graphics.draw( avant , 1 , -1 )
		love.graphics.setColor(255,255,255)
		love.graphics.draw( avant , 0 , 0 )
		for i,h in ipairs(effet) do
			love.graphics.setColor(255,255,255,h.alpha)
			love.graphics.draw( sprite[h.tipe.image][math.floor(h.frame)][1] , (h.X-cam_x)*zoom*50+love.graphics.getWidth()/2,(h.Y-cam_y)*zoom*50+love.graphics.getHeight()/2,h.A,5*zoom*h.S,5*zoom*h.S,sprite[h.tipe.image][math.floor(h.frame)][1]:getWidth()/2,sprite[h.tipe.image][math.floor(h.frame)][1]:getHeight()/2)
		end


end
function I.deload(I)


end
function I.MP(I,mx,my,bu)

end
function I.MR(I,mx,my,bu)

end
function I.KP(I,k)
	if k == "escape" then
		sourmode = 0
		set_menu(menu_play)
		love.audio.resume(musi)
	end
end
function I.KR(I,k)

end

function I.update(I,dot)


end
function I.draw(I)

	love.graphics.setCanvas()

	love.graphics.setColor(255,255,255)
	love.graphics.draw( bloom , 0 , 0 )
	--love.graphics.setBlendMode( "additive" )
	love.graphics.setColor(255,255,255,80)
	love.graphics.draw( bloom , 2 , 0 )
	love.graphics.draw( bloom , 1 , 1 )
	love.graphics.draw( bloom , 0 , 2 )
	love.graphics.draw( bloom , -1 , 1 )
	love.graphics.draw( bloom , -2 , 0 )
	love.graphics.draw( bloom , -1 , -1 )
	love.graphics.draw( bloom , 0 , -2 )
	love.graphics.draw( bloom , 1 , -1 )


	--love.graphics.setBlendMode( "alpha" )
	love.graphics.setColor(255,255,255)

	M.draw()
	love.graphics.draw( grille , 0,0,0,love.graphics.getWidth()/grille:getWidth(),love.graphics.getHeight()/grille:getHeight())
	love.graphics.draw( grille , 0,0,0,love.graphics.getWidth()/grille:getWidth(),love.graphics.getHeight()/grille:getHeight())
	love.graphics.draw( grille , 0,0,0,love.graphics.getWidth()/grille:getWidth(),love.graphics.getHeight()/grille:getHeight())
	if Meno ~= nil then
		love.graphics.draw( Meno , love.graphics.getWidth()/2-127 , love.graphics.getHeight()/2-48 )
	end



end

