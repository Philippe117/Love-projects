
TLX = 200
TLY = love.graphics.getHeight()-20
TLIX = 0
TLIY = love.graphics.getHeight()-120


TLZ = 40
TLO = 0
PLX = 0
PLY = 230
TTX = 0
TTY = 140

LINX = love.graphics.getWidth()-185
LINY = TLIY-100



function M.load(M)

	bones.list.X = PLX
	bones.list.Y = PLY

	const = load_image("constante.png")
	anim = load_image("anim.png")
	outil = load_image("outils.png")
	M.plaque = load_image(""..M.lieux.."/plaque")

	barre = load_image(""..M.lieux.."/barre")
	S1_1 = load_image(""..M.lieux.."/s1-1")
	S1_2 = load_image(""..M.lieux.."/s1-2")
	S1_10 = load_image(""..M.lieux.."/s1-10")
	S1_20 = load_image(""..M.lieux.."/s1-20")

	pointe = load_image(""..M.lieux.."/pointe")
	colone = load_image(""..M.lieux.."/colone")
	pointsel = load_image(""..M.lieux.."/point")
	nombre = load_image(""..M.lieux.."/nombre")
	cadre = load_image(""..M.lieux.."/cadre")



	mouse.Sdep = 1
	mouse.Sari = 1



	Pcansel = nil
	PSel = add_list_to_collect_routine({},"selected",true)
	set_mode(bouton_curseur)

end
function M.deload(M)
end
function M.update(M,dot)
	--txt = dot+1




	update_model(model_edit,dot)
	--txt = txt+1
end
function M.KP(M,k)
	if k == " " then
		model_edit.animation = 1
		model_set_anim(model_edit,model_edit.animation,0,1,1)
	elseif k == "s" then
		save_model(model_edit.data,"models/model_de_test")
	elseif k == "w" then
		model_set_anim(model_edit,NC,NC,speed+.2)
	elseif k == "q" then
		model_set_anim(model_edit,NC,NC,speed-.2)
	end
end
function M.KR(M,k)
end
function M.update(M,dot)
	update_model(model_edit,dot)
end

function M.MP(M,mx,my,bu)

end
function Timeline_to_screen(X)
	return TLX+(X-TLO)*TLZ
end
function screen_to_Timeline(X)
	return (X-TLX)/TLZ+TLO
end



function M.draw(M)
	love.graphics.setColor(255,255,255)
	draw_in_world( 	love.graphics.draw , grille , 0.5 , 0.5 , 0 , 0 , 1 , 1 , 200 , 200 )
	love.graphics.draw(M.plaque,PLX,PLY,0,80/M.plaque:getWidth(),220/M.plaque:getHeight())

	draw_camera()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(tool_tag,25,tool_tag_Y)





	love.graphics.setColor(255,255,255)
	local bex = TLX-50
	love.graphics.draw(barre,TLX,love.graphics.getHeight()-barre:getHeight(),0,(love.graphics.getWidth()-TLX)/barre:getWidth(),1)
	



	for i = math.floor(TLO) , screen_to_Timeline(love.graphics.getWidth()) do 
		local gex = 0
		if TLZ > 30 then
			if TLZ > 140 then
				if TLZ > 300 then
					for e = 1 , 19 do
						gex = Timeline_to_screen(i+e*.05)
						if gex >= TLX then
							love.graphics.draw(S1_20,gex,love.graphics.getHeight(),0,1,1,S1_20:getWidth()*.5,S1_20:getHeight())
						end
					end
				end
				love.graphics.draw(nombre,Timeline_to_screen(i+.5),TLY-51,0,1.6,1,nombre:getWidth()*.5,0)
				love.graphics.printf( i+.5 , Timeline_to_screen(i+.5)-25, TLY-50, 50, "center" )
				for e = 1 , 9 do
					cadregex = Timeline_to_screen(i+e*.1)
					if gex >= TLX then
						love.graphics.draw(S1_10,gex,love.graphics.getHeight(),0,1,1,S1_10:getWidth()*.5,S1_10:getHeight())
					end
				end
			end
			gex = Timeline_to_screen(i+.5)
			if gex >= TLX then
				love.graphics.draw(S1_2,gex,love.graphics.getHeight(),0,1,1,S1_2:getWidth()*.5,S1_2:getHeight())
			end
		end
		gex = Timeline_to_screen(i)
		if gex >= TLX then
			love.graphics.draw(S1_1,gex,love.graphics.getHeight(),0,1,1,S1_1:getWidth()*.5,S1_1:getHeight())
			if bex < gex then
				--love.graphics.print(""..i.."",gex,)
				love.graphics.draw(nombre,gex,TLY-55,0,1.1,1,nombre:getWidth()*.5,0)
				love.graphics.printf( i , gex-25, TLY-54, 50, "center" )


				bex = gex+35
			end
		end
	end



	if model_edit.animation and model_edit.animation ~= 0 then
		love.graphics.draw(colone,Timeline_to_screen(mouse.time),love.graphics.getHeight(),0,1,1,colone:getWidth()*.5,colone:getHeight())
		love.graphics.draw(colone,Timeline_to_screen(model_edit.bone[1].temps),love.graphics.getHeight(),0,.5,.5,colone:getWidth()*.5,colone:getHeight())
	end


	if model_edit.animation and model_edit.animation ~= 0 then
		for e,g in ipairs(bones.selection) do
			if model_edit.data.anim[model_edit.animation].bone[g.id][0] then
				for i = 0 , table.maxn(model_edit.data.anim[model_edit.animation].bone[g.id]) do
					local h = model_edit.data.anim[model_edit.animation].bone[g.id][i]
					love.graphics.draw(pointsel,Timeline_to_screen(h.temps),TLY-55,0,1,1,pointsel:getWidth()*.5,0)
					--love.graphics.print(""..i..","..h.temps.."",Timeline_to_screen(h.temps),TLY-150-5*i)
				end
			end
		end
		for i,h in ipairs(model_edit.anim_points[model_edit.animation]) do
			if h.temps >= TLO then
				if h == Pcansel then
					if h == Psel then
						love.graphics.setColor(150,255,120)
					else
						love.graphics.setColor(255,255,0)
					end
				elseif h == Psel then
					love.graphics.setColor(0,255,0)
				else
					love.graphics.setColor(255,255,255)
				end
				love.graphics.draw(pointe,Timeline_to_screen(h.temps),TLY,0,1,1,pointe:getWidth()*.5,pointe:getHeight())
			end
		end
		--draw_list(model_edit.anim_points[model_edit.animation],"temps",300,100)
	end
	if Psel  and table.maxn(bones.selection) ~= 0 then
		love.graphics.setColor(155,155,155)
		love.graphics.draw(cadre,LINX-3,LINY-3)
		love.graphics.setColor(255,255,255)
		for i,h in ipairs(bones.selection) do
			if h.data.tete.tipe ~= 2
			and h.anim[h.anim_index].temps == Psel.temps
			and  h.anim and h.anim[0] then

				local X = 0
				local Y = 0
				for i = 1 , 50 do
					local x = i/50*100
					local y = interpolation( 0 , 100 , i/50 , h.anim[h.anim_index].Sdep , h.anim[h.anim_index].Sari )
					love.graphics.setLine(1, "smooth")
					love.graphics.line(LINX+X, LINY+100-Y, LINX+x, LINY+100-y)
					X = x
					Y = y
				end
			end
		end

	end








	if mouse.canselect then
	--	draw_list(mouse.canselect.anim,400,100,"temps")
	--	love.graphics.print("("..mouse.canselect.anim_index..")",550,200)
	--	love.graphics.print("("..mouse.canselect.test..")",550,250)

	end
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( ff )
	love.graphics.print("("..love.mouse.getX()..","..love.mouse.getY()..")",200,0)
	
end
