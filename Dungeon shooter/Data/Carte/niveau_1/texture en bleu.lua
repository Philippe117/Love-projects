function tex(bl)
	if bl == 0 then
		return(texture_beton)
	elseif bl == 100 then
		return(texture_block)
	elseif bl == 255 then
		return(texture_caisse)
	end
end
