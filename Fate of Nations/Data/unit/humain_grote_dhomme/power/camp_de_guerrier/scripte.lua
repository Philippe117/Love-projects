function P.load(T,P)
	P.X = 1
	P.Y = 2
	P.batiment = unit_humain_camp_de_guerrier
	P.description = "convertir en camp de guerrier pour produire des masseux, des guenilloux et des lancier\ncoute "..P.batiment.prix.." pieces d'or"

end
function P.condition(T,Q,P)
	if Q.mode == "normal"
	and equipe[Q.equipe].gold >= P.batiment.prix then
		return(true)
	end
end
function P.fonction_gauche(T,Q,P)



	new = unit_create( P.batiment , Q.equipe , Q.X , Q.Y , 0 , Q.sens , "build")
	if selection == Q then
		selectioner(new)
	end
	equipe[Q.equipe].gold = equipe[Q.equipe].gold-P.batiment.prix
	unit_kill(Q)


end
function P.fonction_droit(T,Q,P)
	
end
