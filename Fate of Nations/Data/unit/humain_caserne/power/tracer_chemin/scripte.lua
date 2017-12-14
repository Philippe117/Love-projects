function P.load(T,P)
	P.X = 3
	P.Y = 3


	P.description = "tracer le parcour des combatent"
end
function P.condition(T,Q,P)

	return(true)

end
function P.fonction_gauche(T,Q,P)

	Q.ligne = true




end
function P.fonction_droit(T,Q,P)

	Q.ligne = false
	controle_chemin = {}

	

end
