function P.load(T,P)
	P.X = 1
	P.Y = 3


	P.description = "revendre le terrain pour "..T.prix.."$"
end
function P.condition(T,Q,P)
	if Q.mode == "normal"
	and Q.etat ~= "mort"
	and Q.etat ~= "fini" then
		return(true)
	end
end
function P.fonction_gauche(T,Q,P)

	unit_kill(Q)



	new = unit_create( unit_humain_grote , Q.equipe , Q.X , Q.Y , 0 , Q.sens , "build")
	if selection == Q then
		selectioner(new)
	end
	equipe[Q.equipe].gold = equipe[Q.equipe].gold+T.prix
end
function P.fonction_droit(T,Q,P)
	
end
