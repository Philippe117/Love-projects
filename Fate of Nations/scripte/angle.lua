function angle(A1,A2)
	return( (A2-A1)-math.floor((A2-A1)/(2*math.pi)+.5)*(2*math.pi) )
end
