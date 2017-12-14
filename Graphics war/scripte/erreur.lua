
erreur = {}
erreur.lieux = "rapport d'erreur.lua"
erreur.time = math.floor( love.timer.getTime( ) )
erreur.rapport = love.filesystem.newFile( erreur.lieux )
erreur.rapport:open( "w" )
function rapporter_erreur(message)
	if math.floor( love.timer.getTime( ) ) ~= erreur.time then
		erreur.time = math.floor( love.timer.getTime( ) )
		erreur.rapport:write( "\n-----------------------------< "..erreur.time.."s >----------------------------" )
	end
	erreur.rapport:write( "\n--	"..message.."" )
end
rapporter_erreur("begining loading phase")
