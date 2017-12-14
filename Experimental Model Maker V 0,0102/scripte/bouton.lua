
local new = new_function(fonction,"load",0)
function new.F()
	pointer = 0
	bouton = {}
	bouton_actif = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",-1,false),"actif",false)
	popup_timer = 0
	popup_app = load_image("popup")
end
function search_for_bouton(lieux)
	local newlist = {}
	for i,h in ipairs(love.filesystem.enumerate(lieux)) do
		local new = load_bouton(lieux,h)
		table.insert( newlist , new )
	end
	return newlist
end
function bouton_condition()
	return true
end
function load_bouton(lieux,nom)
	local new =  { 	nom = nom ,
			lieux = ""..lieux.."/"..nom.."" ,
			normal = create_sprite(load_sprite(""..lieux.."/"..nom.."/normal")) ,
			pointer = create_sprite(load_sprite(""..lieux.."/"..nom.."/pointer")) ,
			cliquer = create_sprite(load_sprite(""..lieux.."/"..nom.."/cliquer") )
			--new.popup = load_sprite(""..lieux.."/"..nom.."/popup")
			  }
	new.clic = new_son(""..lieux.."/"..nom.."/clic")
	new.pointe = new_son(""..lieux.."/"..nom.."/pointe")
	new.app = new.normal
	new.textsise = 1
	new.textdecal = 1
	new.pos = {X=0,Y=80}
	new.Width = 200
	new.Height = 100
	new.Z = -100000
	new.font = ff
	condition = bouton_condition
	new.amIselectable = bouton_amIselectable
	if love.filesystem.exists(""..lieux.."/"..nom.."/scripte.lua") then
		B = new
		love.filesystem.load(""..lieux.."/"..nom.."/scripte.lua")()
		execute( new.load , new )
		new.sW = new.Width/new.normal.data.Width
		new.sH = new.Height/new.normal.data.Height
		add_data_to_a_list(bouton_actif,new)
		return (new)
	else
		rapporter_erreur("le scripte du bouton: "..lieux.."/"..nom.."  est introuvable")
	end
end
function bouton_set_text(bouton,txt)
	bouton.text = txt or bouton.text
	local tW = bouton.font:getWidth( bouton.text )

	bouton.textsise = math.min((bouton.Width -8)/tW , (bouton.Height-8)/bouton.font:getHeight( ) )

	bouton.textdecal = (bouton.Width-8-tW*bouton.textsise)/2

end
local new = new_function(fonction,"MP",10)
function new.F(mx,my,bu)
	if mouse.canbeclicked then
		mouse.canbeclicked.app = mouse.canbeclicked.cliquer
		execute_en_silence(mouse.canbeclicked.MP,mouse.canbeclicked,mx,my,bu)
	end
end
local new = new_function(fonction,"MR",10)
function new.F(mx,my,bu)
	if mouse.canbeclicked then
		mouse.canbeclicked.app = mouse.canbeclicked.pointer
		execute_en_silence(mouse.canbeclicked.MR,mouse.canbeclicked,mx,my,bu)
	end
end
local new = new_function(fonction,"update",10)
function new.F(dot)
	
	if mouse.canbeclicked then
		if bouton_amIselectable(mouse.canbeclicked) then
			execute_en_silence(mouse.canbeclicked.update,mouse.canbeclicked,dot)
		else
			execute_en_silence(mouse.canbeclicked.remove_mouse,mouse.canbeclicked)
			mouse.canbeclicked.app = mouse.canbeclicked.normal
			mouse.canbeclicked = nil
			mouse.eta = 1
		end
	elseif mouse.eta == 1 then
		for i,h in ipairs(bouton_actif) do
			if bouton_amIselectable(h) then
				mouse.canbeclicked = h
			end
		end
		if mouse.canbeclicked then
			if love.mouse.isDown( "r" ) or love.mouse.isDown( "l" ) then
				mouse.canbeclicked.app = mouse.canbeclicked.cliquer
			else
				mouse.canbeclicked.app = mouse.canbeclicked.pointer
			end
			execute_en_silence(mouse.canbeclicked.put_mouse,dot,mouse.canbeclicked)
			popup_timer = chrono+0.5
			mouse.eta = "bouton"
		end
	end
	



end
function bouton_amIselectable(bouton)
	return (bouton.condition() and love.mouse.getX() > bouton.pos.X and love.mouse.getX() < bouton.pos.X+bouton.Width and love.mouse.getY() > bouton.pos.Y and  love.mouse.getY() < bouton.pos.Y+bouton.Height)
end





local new = new_function(fonction,"draw",-20)
function new.F()
	for i,h in ipairs(bouton_actif) do
		if h.eta.actif and h.condition() then
			love.graphics.setColor(255,255,255)
			love.graphics.setFont( h.font )
			draw_sprite(h.app,h.pos.X,h.pos.Y,0,h.sW,h.sH)
			execute_en_silence(h.draw,h)
			if h.text then
				love.graphics.setColor(155,155,155)
				love.graphics.print( h.text , h.pos.X+2+h.textdecal, h.pos.Y+2 , 0 , h.textsise )
				love.graphics.setColor(0,0,0,100)
				love.graphics.print( h.text , h.pos.X+6+h.textdecal, h.pos.Y+6 , 0 , h.textsise )
				love.graphics.print( h.text , h.pos.X+3+h.textdecal, h.pos.Y+3 , 0 , h.textsise )
				love.graphics.setColor(245,245,245)
				love.graphics.print( h.text , h.pos.X+4+h.textdecal, h.pos.Y+4 , 0 , h.textsise )
			end
		end
	end
	love.graphics.setColor(255,255,255)
	if mouse.canbeclicked and mouse.canbeclicked.eta.actif and mouse.canbeclicked.popup_text and popup_timer < chrono then

		love.graphics.setFont( f )
		local ex = love.mouse.getX()
		local ey = love.mouse.getY()
		if love.graphics.getWidth()-ex < popup_app:getWidth() then ex = ex-popup_app:getWidth() end
		if love.graphics.getHeight()-ey < popup_app:getHeight() then ey = ey-popup_app:getHeight() end
		love.graphics.draw(popup_app,ex,ey)
		love.graphics.printf( mouse.canbeclicked.popup_text , ex+4, ey+2 , popup_app:getWidth()-4 , "left" )
	end



end

