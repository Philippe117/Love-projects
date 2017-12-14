function P.load(T,P)
	P.X = 1
	P.Y = 1
	P.unit = unit_humain_builder
	P.build = unit_humain_tour

	P.description = "construire des tours\ncoute "..P.build.prix.." pieces d'or"
end
function P.condition(T,Q,P)
	if equipe[Q.equipe].gold >= P.build.prix
	and Q.etat ~= "mort"
	and Q.etat ~= "fini" then
		return(Q.can_order)
	end
end
function P.fonction_gauche(T,Q,P)
	Q.batiment = P.build
	Q.builder = P.unit
	Q.ligne = true

end
function P.fonction_droit(T,Q,P)

	Q.ligne = false
end
