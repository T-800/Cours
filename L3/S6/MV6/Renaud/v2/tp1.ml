#use "/media/data/git/Cours/L3/S6/MV6/Renaud/v2/mv_myrte.ml";;


let a = assemble exemple1;;
let b = disassemble a;;

let p = String.make (15) 'z';;
p.[0] <- Char.chr 4;;
p.[1] <- Char.chr 0;;
p.[2] <- Char.chr 3;;
p.[3] <- Char.chr 0;;
p.[4] <- Char.chr 0;;
p.[5] <- Char.chr 0;;
p.[6] <- Char.chr 4;;
p.[7] <- Char.chr 1;;
p.[8] <- Char.chr 1;;
p.[9] <- Char.chr 1;;
p.[10] <- Char.chr 0;;
p.[11] <- Char.chr 0;;
p.[12] <- Char.chr 5;;
p.[13] <- Char.chr 0;;
p.[14] <- Char.chr 0;;

let c = print_instrs exemple1;;

disassemble p;; (* [|Consti 3; Push; Consti (-1); Addi; Pop|] *)


let d = get_acc (machine (init exemple1))
