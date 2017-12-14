local new = new_function(fonction,"load",0)
function new.F()
	clavier = {	texte = "" ,
			X = 0 ,
			Y = 0 ,
			actif = false ,
			id = 0 ,
			crono = 0
				}
	case = load_image("case.png")
end
function set_clavier(text,X,Y,id)
	clavier.X = X
	clavier.Y = Y
	clavier.texte = text
	clavier.texte_mem = text
	clavier.actif = true
	clavier.id = id
	clavier.crono = 0
end

function ok_clavier()
	clavier.X = 0
	clavier.Y = 0
	clavier.actif = false
	--clavier.id = 0
	return( clavier.texte )
end

function clav_shift()
	return ( love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") or love.keyboard.isDown("capslock") )
end
function clav_KP(k)
	if clavier.actif then
		local letre = ""
		if k == "a" then
			if clav_shift() then
				letre = "A"
			else
				letre = "a"
			end
		elseif k == "b" then
			if clav_shift() then
				letre = "B"
			else
				letre = "b"
			end
		elseif k == "c" then
			if clav_shift() then
				letre = "C"
			else
				letre = "c"
			end
		elseif k == "d" then
			if clav_shift() then
				letre = "D"
			else
				letre = "d"
			end
		elseif k == "e" then
			if clav_shift() then
				letre = "E"
			else
				letre = "e"
			end
		elseif k == "f" then
			if clav_shift() then
				letre = "F"
			else
				letre = "f"
			end
		elseif k == "g" then
			if clav_shift() then
				letre = "G"
			else
				letre = "g"
			end
		elseif k == "h" then
			if clav_shift() then
				letre = "H"
			else
				letre = "h"
			end
		elseif k == "i" then
			if clav_shift() then
				letre = "I"
			else
				letre = "i"
			end
		elseif k == "j" then
			if clav_shift() then
				letre = "J"
			else
				letre = "j"
			end
		elseif k == "k" then
			if clav_shift() then
				letre = "K"
			else
				letre = "k"
			end
		elseif k == "l" then
			if clav_shift() then
				letre = "L"
			else
				letre = "l"
			end
		elseif k == "m" then
			if clav_shift() then
				letre = "M"
			else
				letre = "m"
			end
		elseif k == "n" then
			if clav_shift() then
				letre = "N"
			else
				letre = "n"
			end
		elseif k == "o" then
			if clav_shift() then
				letre = "O"
			else
				letre = "o"
			end
		elseif k == "p" then
			if clav_shift() then
				letre = "P"
			else
				letre = "p"
			end
		elseif k == "q" then
			if clav_shift() then
				letre = "Q"
			else
				letre = "q"
			end
		elseif k == "r" then
			if clav_shift() then
				letre = "R"
			else
				letre = "r"
			end
		elseif k == "s" then
			if clav_shift() then
				letre = "S"
			else
				letre = "s"
			end
		elseif k == "t" then
			if clav_shift() then
				letre = "T"
			else
				letre = "t"
			end
		elseif k == "u" then
			if clav_shift() then
				letre = "U"
			else
				letre = "u"
			end
		elseif k == "v" then
			if clav_shift() then
				letre = "V"
			else
				letre = "v"
			end
		elseif k == "w" then
			if clav_shift() then
				letre = "W"
			else
				letre = "w"
			end
		elseif k == "x" then
			if clav_shift() then
				letre = "X"
			else
				letre = "x"
			end
		elseif k == "y" then
			if clav_shift() then
				letre = "Y"
			else
				letre = "y"
			end
		elseif k == "z" then
			if clav_shift() then
				letre = "Z"
			else
				letre = "z"
			end
		elseif k == "1" then
			if clav_shift() then
				letre = "!"
			else
				letre = "1"
			end
		elseif k == "2" then
			if clav_shift() then
				letre = "@"
			else
				letre = "2"
			end
		elseif k == "3" then
			if clav_shift() then
				letre = "/"
			else
				letre = "3"
			end
		elseif k == "4" then
			if clav_shift() then
				letre = "$"
			else
				letre = "4"
			end
		elseif k == "5" then
			if clav_shift() then
				letre = "%"
			else
				letre = "5"
			end
		elseif k == "6" then
			if clav_shift() then
				letre = "?"
			else
				letre = "6"
			end
		elseif k == "7" then
			if clav_shift() then
				letre = "&"
			else
				letre = "7"
			end
		elseif k == "8" then
			if clav_shift() then
				letre = "*"
			else
				letre = "8"
			end
		elseif k == "9" then
			if clav_shift() then
				letre = "("
			else
				letre = "9"
			end
		elseif k == "0" then
			if clav_shift() then
				letre = ")"
			else
				letre = "0"
			end
		elseif k == "-" then
			if clav_shift() then
				letre = "_"
			else
				letre = "-"
			end
		elseif k == "=" then
			if clav_shift() then
				letre = "+"
			else
				letre = "="
			end
		elseif k == "«" then
			if clav_shift() then
				letre = "»"
			else
				letre = "«"
			end
		elseif k == "«" then
			if clav_shift() then
				letre = "»"
			else
				letre = "«"
			end
		elseif k == "<" then
			if clav_shift() then
				letre = ">"
			else
				letre = "<"
			end
		elseif k == "," then
			if clav_shift() then
				letre = "'"
			else
				letre = ","
			end
		elseif k == "." then
			if clav_shift() then
				letre = "."
			else
				letre = "."
			end
		elseif k == ";" then
			if clav_shift() then
				letre = ":"
			else
				letre = ";"
			end
		elseif k == " " then
			letre = "_"
		elseif k == "backspace" then
			clavier.texte = ""
		elseif k == "return" then
			ok_clavier()
		elseif k == "escape" then
			clavier.texte = clavier.texte_mem
			ok_clavier()
		end
		clavier.texte = ""..clavier.texte..""..letre..""
	end
end
function clav_draw()

	if clavier.actif then
		love.graphics.setFont( ff )
		love.graphics.draw( case , clavier.X , clavier.Y )
		if math.sin(clavier.crono*8) > 0 then
			local text = ""..clavier.texte.."|"
			love.graphics.print( text , clavier.X+2, clavier.Y , 0 , math.min((case:getWidth()-2)/love.graphics.getFont( ):getWidth( text ),(case:getHeight()-2)/love.graphics.getFont( ):getHeight( )))
		else
			love.graphics.print( clavier.texte , clavier.X+2, clavier.Y , 0 , math.min((case:getWidth()-2)/love.graphics.getFont( ):getWidth( clavier.texte ),(case:getHeight()-2)/love.graphics.getFont( ):getHeight( )))
		end
	end
end

