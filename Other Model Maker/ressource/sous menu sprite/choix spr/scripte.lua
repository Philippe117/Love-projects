function B.init(B)
	B.X = love.graphics.getWidth()-200
	B.Y = 125
	B.text = ""

end
function B.clic_gauche(B)
--	local new = add_sprite(model_data,sprite.select,sprite.choix,bone.select,sprite.eritrot,sprite.eritscale)
--	sprite.select = new.id
end
function B.clic_droit(B)
end
function B.autre(B,bu)
	if bu == "wu" then
		sprite.choix = math.min(table.maxn(model.model_data.sprite_list),sprite.choix+1)
	elseif bu == "wd" then
		sprite.choix = math.max(1,sprite.choix-1)
	end
end
function B.update(B,dot)
end
function B.condition(B)
	return ( mode == "editer" and mode_edit == "edit sprite" )
end
