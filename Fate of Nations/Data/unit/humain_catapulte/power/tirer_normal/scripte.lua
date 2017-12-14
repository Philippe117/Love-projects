function P.load(T,P)
	P.X = 2
	P.Y = 1
	P.proj = unit_humain_boulet

	P.description = "tire un boulet\ncoute "..P.proj.prix.." pieces d'or"
end
function P.condition(T,Q,P)
	if equipe[Q.equipe].gold >= P.proj.prix
	and Q.mode ~= "build"
	and Q.etat ~= "mort"
	and Q.etat ~= "fini"
	and Q.timer < crono then
		return(Q.can_order)
	end
end
function P.fonction_gauche(T,Q,P)
	Q.projectile = P.proj
	Q.ligne = "autre"
	Q.mode = "preparer le tire"
	Q.max_range = 300
end
function P.fonction_droit(T,Q,P)
	Q.ligne = false
	Q.mode = "normal"


end
