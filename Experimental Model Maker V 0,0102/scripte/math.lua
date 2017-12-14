function angle(A1,A2)
	return((A2-A1)-math.floor((A2-A1)/math.pi/2+.5)*2*math.pi)
end


function filter(PV,SP,dot,F,L)
	F = F or 1
	L = L or math.huge
	return math.max(PV-L,math.min(PV+L,PV+(SP-PV)/F*dot))
end
smooter = filter





