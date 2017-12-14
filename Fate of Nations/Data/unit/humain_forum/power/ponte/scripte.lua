function P.load(T,P)
	P.X = 2
	P.Y = 2
	P.unit = unit_dino_she_rex
	P.build = unit_dino_nid_de_t_rex

	P.description = "pondre un oeuf de dino\ncoute "..P.build.prix.." pieces d'or"
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
