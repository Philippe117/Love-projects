M.nom = "model_de_test"
--MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM bone MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM--
M.bone = {}
M.bone[1] = {	nom = "femur" ,
		base = { tipe = 0 , pos = { X = 0 , Y = 0 } } ,
		tete = { tipe = 0 , pos = { X = 40 , Y = 20 } }, }

M.bone[2] = {	nom = "cou" ,
		base = { tipe = 1 , pos = 1 } ,
		tete = { tipe = 1 , vec = { D = 0 , L = 20 } } , L = 45  }

M.bone[3] = {	nom = "plx" ,
		base = { tipe = 0 , pos = { X = 0 , Y = 40 } } ,
		tete = { tipe = 2 , pos = 2 } , L = 45 }

M.bone[4] = {	nom = "new bone #1" ,
		base = { tipe = 0 , pos = { X = 89 , Y = -35 } } ,
		tete = { tipe = 2 , pos = 1 } , L = 45 }

--WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW bone WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW--

--MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM animations MMMMMMMMMMMMMMMMMMMMMMMMMM--
--((-------------------( stand (----------------((--

M.anim[1] = { nom = "stand" , duration = 8 , bone = {} }
M.anim[1].bone[1] = {} 
M.anim[1].bone[1][0] = { pos = { X = 20 , Y = 20 } , temps = 2 , duration = 2 , Sdep = 1.6 , Sari = 1.6 } 
M.anim[1].bone[1][1] = { pos = { X = 20 , Y = -20 } , temps = 4 , duration = 2 , Sdep = 1.6 , Sari = 1.6 } 
M.anim[1].bone[1][2] = { pos = { X = -20 , Y = -20 } , temps = 6 , duration = 2 , Sdep = 1.6 , Sari = 1.6 } 
M.anim[1].bone[1][3] = { pos = { X = -20 , Y = 20 } , temps = 8 , duration = 2 , Sdep = 1.6 , Sari = 1.6 } 

M.anim[1].bone[2] = {} 
M.anim[1].bone[2][0] = { vec = { D = 0 , L = 20 , eritrot = 1 } , temps = 0 , duration = 2 , Sdep = 2 , Sari = 2 } 
M.anim[1].bone[2][1] = { vec = { D = 0 , L = 20 , eritrot = 0 } , temps = 2 , duration = 2 , Sdep = 2 , Sari = 2 } 
M.anim[1].bone[2][2] = { vec = { D = 0 , L = 20 , eritrot = 0 } , temps = 4 , duration = 2 , Sdep = 2 , Sari = 2 } 
M.anim[1].bone[2][3] = { vec = { D = 0 , L = 20 , eritrot = 1 } , temps = 6 , duration = 2 , Sdep = 2 , Sari = 2 } 

M.anim[1].bone[3] = {} 

M.anim[1].bone[4] = {} 

--))-------------------) stand )----------------))--
--((-------------------( run (----------------((--

M.anim[2] = { nom = "run" , duration = 9 , bone = {} }
M.anim[2].bone[1] = {} 
M.anim[2].bone[1][0] = { pos = { X = 0 , Y = 20 } , temps = 3 , duration = 3 , Sdep = 2 , Sari = 2 } 
M.anim[2].bone[1][1] = { pos = { X = 20 , Y = -14 } , temps = 6 , duration = 3 , Sdep = 2 , Sari = 2 } 
M.anim[2].bone[1][2] = { pos = { X = -20 , Y = -14 } , temps = 9 , duration = 3 , Sdep = 2 , Sari = 2 } 

M.anim[2].bone[2] = {} 
M.anim[2].bone[2][0] = { vec = { D = 0 , L = 20 , eritrot = 1 } , temps = 0 , duration = 2 , Sdep = 2 , Sari = 2 } 
M.anim[2].bone[2][1] = { vec = { D = 0 , L = 20 , eritrot = 0 } , temps = 2 , duration = 2 , Sdep = 2 , Sari = 2 } 
M.anim[2].bone[2][2] = { vec = { D = 0 , L = 20 , eritrot = 0 } , temps = 4 , duration = 2 , Sdep = 2 , Sari = 2 } 
M.anim[2].bone[2][3] = { vec = { D = 0 , L = 20 , eritrot = 1 } , temps = 6 , duration = 3 , Sdep = 2 , Sari = 2 } 

M.anim[2].bone[3] = {} 

M.anim[2].bone[4] = {} 

--))-------------------) run )----------------))--
--WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW animation WWWWWWWWWWWWWWWWWWWWWWWWWWW--
