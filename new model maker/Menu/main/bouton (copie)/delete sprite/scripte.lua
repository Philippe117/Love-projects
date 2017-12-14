function B.init(B)				
	B.X = 100
	B.Y = 650
	B.text = "delete"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "suprimer l'os"
end
function B.clic_gauche(B)
	remove_bone(select)




end
function remove_bone(num)
	select = 0


	list = {}
	remove_bone2(num)
--	for i,h in ipairs(list) do
--		for e,g in ipairs(model.model_data.bone) do
--			if g.base.tipe == 1
--			and g.base.pos > h then
--				g.base.pos = g.base.pos-1
--			end
--			if g.tete.tipe == 2 then
--				if g.tete.pos > h then
--					g.tete.pos = g.tete.pos-1
--				end
--			end
--		end
--	end
	local qwe = table.maxn(model.model_data.bone)+1
	while qwe > 1 do
		qwe = qwe-1

		for i,h in ipairs(list) do
			--model.model_data.bone[h].fgh = true


			if h == qwe then
				table.remove(model.model_data.bone , h )
				table.remove(model.bone , h )
			end
		end

	end


	for i,h in ipairs(model.model_data.bone) do
		model.bone[i] = create_bone(model,h)


		local sp = model.speed
		model.speed = .00000001
		update_model(model,0)
		model.speed = sp


	end
end
function remove_bone2(num)
	local possi = true
	for i,h in ipairs(list) do
		if h == num then
			possi = false
		end
	end
	if possi == true then
		table.insert(list,num)


		for i,h in ipairs(model.model_data.sprite) do
			if h.chef == num then
				table.remove(model.model_data.sprite,i)
				table.remove(model.sprite,i)
			end
		end

		--for i,h in ipairs(model.model_data.bone) do


	local i = table.maxn(model.model_data.bone)+1
	while i > 1 do
		i = i-1
		local h = model.model_data.bone[i]
			if h.base.tipe == 1
			and h.base.pos == num then
				remove_bone2(i)
			end
			if h.tete.tipe == 2 then
				if h.tete.pos == num then
					remove_bone2(i)
				end
			end
		end
	end


end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()

		return( sprite_sel ~= 0 )

end
