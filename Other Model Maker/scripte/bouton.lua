
local new = new_function(fonction,"load",-2)
function new.F()
	pointer = 0
	bouton = {}
	bouton_actif = add_list_to_collect_routine(add_list_to_sort_routine({},"Z",-1,false),"actif",false)
end
function search_for_bouton(lieux)
	local newlist = {}
	for i,h in ipairs(love.filesystem.enumerate(lieux)) do
		local new = add_bouton(lieux,h)

		table.insert( newlist , new )
	end
	return newlist
end



function add_bouton(lieux,nom)
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
	new.amIselectable = bouton_amIselectable
	if love.filesystem.exists(""..lieux.."/"..nom.."/scripte.lua") then
		B = new
		love.filesystem.load(""..lieux.."/"..nom.."/scripte.lua")()
		execute( new.load , new )
		new.sW = new.Width/new.normal.data.Width
		new.sH = new.Height/new.normal.data.Height
		add_data_to_a_list(bouton_actif,new)
		add_data_to_a_list(mouse.selectable,new)
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
local new = new_function(fonction,"MP",0)
function new.F()
	if mouse.canselect then
		execute_en_silence(mouse.canselect.MP,mouse.canselect)
	end
end
local new = new_function(fonction,"MR",0)
function new.F()
	if mouse.canselect then
		execute_en_silence(mouse.canselect.MR,mouse.canselect)
	end
end
local new = new_function(fonction,"update",0)
function new.F(dot)
	for e,g in ipairs(bouton_actif) do
		if g.eta.actif then
			if g.pointed then
				if love.mouse.isDown( "r" ) or love.mouse.isDown( "l" ) then
					g.app = g.cliquer
				else
					g.app = g.pointer
				end
			else
				g.app = g.normal
			end
			execute_en_silence(g.update,g,dot)
		end
	end
end
function bouton_amIselectable(bouton)
	return (love.mouse.getX() > bouton.pos.X and love.mouse.getX() < bouton.pos.X+bouton.Width and love.mouse.getY() > bouton.pos.Y and  love.mouse.getY() < bouton.pos.Y+bouton.Height)
end
local new = new_function(fonction,"draw",-20)
function new.F()
	love.graphics.setColor(255,255,255)
	for i,h in ipairs(bouton_actif) do
		if h.eta.actif then
			love.graphics.setFont( h.font )
			draw_sprite(h.app,h.pos.X,h.pos.Y,0,h.sW,h.sH)
			execute_en_silence(h.draw,h)
			if h.text then love.graphics.print( h.text , h.pos.X+4+h.textdecal, h.pos.Y+4 , 0 , h.textsise ) end
			if h.popup then
				love.graphics.setColor(255,255,255)
				love.graphics.setFont( f )
				draw_sprite(h.popup.app,h.popup.X,h.popup.Y,0,h.sW,h.sH)
				love.graphics.printf( h.popup.text , h.popup.X+4, h.popup.Y+2 , h.popup.Width-4 , "left" )
			end

		end
	end
end

