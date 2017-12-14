PLX = 0
PLY = 350
TTX = 0
TTY = 140


function M.load(M)

	bones.list.X = PLX
	bones.list.Y = PLY

	const = load_image("constante.png")
	anim = load_image("anim.png")
	outil = load_image("outils.png")
	M.plaque = load_image(""..M.lieux.."/plaque")

	set_mode(bouton_curseur)

	model_set_anim(model_edit,nil,0)
	model_edit.animation = nil



end
function M.deload(M)

end
function M.update(M,dot)
	--txt = dot+1
	update_model(model_edit,dot)
	--txt = txt+1
end
function M.KP(M,k)
	if k == "s" then
		save_model(model_edit.data,"models/model_de_test")
	elseif k == "delete" then
		for i,h in ipairs(bones.selection) do
			remove_bone(h)
		end
	end
end
function M.KR(M,k)
end
function M.update(M,dot)
	update_model(model_edit,dot)
end

function M.draw(M)
	love.graphics.setColor(255,255,255)
	draw_in_world( 	love.graphics.draw , grille , 0.5 , 0.5 , 0 , 0 , 1 , 1 , 200 , 200 )
	love.graphics.draw(M.plaque,PLX,PLY,0,80/M.plaque:getWidth(),220/M.plaque:getHeight())

	draw_camera()


	love.graphics.draw(tool_tag,25,tool_tag_Y)



--	draw_list(model_edit.data.anim[1].bone,"nom",200,100)
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( ff )
	love.graphics.print("("..love.mouse.getX()..","..love.mouse.getY()..")",200,0)
	
end
