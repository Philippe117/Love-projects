function tex(v)
	if math.floor(v/10)*10 == 0 then
		local nom = "terre"

		if _G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""] ~= nil then
			return(_G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""])
		else
			return(_G["texture_"..nom.."_1"])
		end
	elseif math.floor(v/10)*10 == 50 then
		local nom = "eau"

		if _G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""] ~= nil then
			return(_G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""])
		else
			return(_G["texture_"..nom.."_1"])
		end

	elseif math.floor(v/10)*10 == 100 then
		local nom = "gazon"

		if _G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""] ~= nil then
			return(_G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""])
		else
			return(_G["texture_"..nom.."_1"])
		end

	elseif math.floor(v/10)*10 == 150 then
		local nom = "haut_fond"

		if _G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""] ~= nil then
			return(_G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""])
		else
			return(_G["texture_"..nom.."_1"])
		end




	elseif math.floor(v/10)*10 == 200 then
		local nom = "beton"

		if _G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""] ~= nil then
			return(_G["texture_"..nom.."_"..(v-math.floor(v/10)*10)..""])
		else
			return(_G["texture_"..nom.."_1"])
		end


	else
		return(texture_terre_1)
	end
end

