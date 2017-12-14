function P.load(T,P)
	P.X = 2
	P.Y = 3


	P.description = "annule toute les actions en cour"
end
function P.condition(T,Q,P)
	return(true)
end
function P.fonction_gauche(T,Q,P)

	add_chemin(Q , {})
	Q.liste = {}
	Q.progression = 0
	Q.pointe = {1,1}


end
function P.fonction_droit(T,Q,P)




	

end
