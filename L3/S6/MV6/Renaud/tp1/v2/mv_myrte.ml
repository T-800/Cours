
(** Machine virtuelle *)

type instr =
| Push
| Consti of int
| Addi
| Subs
| Eqi
| Andi
| Pop
| BranchIf of int
| Branch of int

type state = {
  mutable acc: int;
  code: instr array;
  mutable pc: int; (* indice de l’instruction courante dans code *)
  stack: int array;
  mutable sp: int; (* indice du sommet de la pile dans stack *)
}

let machine s =
  while s.pc < Array.length s.code do
    begin match s.code.(s.pc) with
    | Consti n ->
       s.acc <- n
    | Push ->
       s.sp <- s.sp + 1;
       s.stack.(s.sp) <- s.acc
    | Addi ->
       s.acc <- s.stack.(s.sp) + s.acc;
    | Subs ->
        s.acc <- s.stack.(s.sp) - s.acc;
    | Andi ->
       s.acc <- s.stack.(s.sp) * s.acc;
    | Eqi ->
       s.acc <- if s.stack.(s.sp) = s.acc then 1 else 0;
    | Pop ->
       s.sp <- s.sp-1
    | BranchIf n ->
       if s.acc = 0 then () else (s.pc <- s.pc + (n - 1));
    | Branch n -> (s.pc <- s.pc + (n - 1));
    end;
    s.pc <- s.pc + 1
  done; s

let init c =
  { code = c;
    stack = Array.make 1000 42; (* pourquoi 42 ? *)
    pc = 0;
    sp = -1;   (* pourquoi -1 ? *)
    acc = 52 } (* pourquoi 52 ? *)

let get_acc s = s.acc


let assemble (p : instr array) : string =
  let s = String.make ((Array.length p)*3) 'z' in
  for i = 0 to Array.length p - 1 do
    match p.(i) with
    | Push ->       s.[3*i] <-  Char.chr 0;
    | Addi ->       s.[3*i] <-  Char.chr 1;
    | Eqi ->        s.[3*i] <-  Char.chr 2;
    | Andi ->       s.[3*i] <-  Char.chr 3;
    | Pop ->        s.[3*i] <-  Char.chr 5;
    | Subs ->       s.[3*i] <-  Char.chr 6;
    | BranchIf n -> s.[3*i] <-  Char.chr 7; s.[3*i+1] <- Char.chr n;
    | Branch n ->   s.[3*i] <-  Char.chr 8; s.[3*i+1] <- Char.chr n;
    | Consti n ->   assert ((abs n) < 255); s.[3*i] <-  Char.chr 4; (if n < 0 then s.[3*i+1] <- Char.chr 1 else s.[3*i+1] <- Char.chr 0); s.[3*i+2] <-  Char.chr (abs n);


  done; s


let disassemble (s : string) : instr array =
  let p = Array.make ((String.length s)/3) Push in
  for i = 0 to (String.length s /3) - 1 do
    p.(i) <- match Char.code s.[3*i] with
        | 0 -> Push
        | 1 -> Addi
        | 2 -> Eqi
        | 3 -> Andi
        | 4 -> (if Char.code (s.[3*i+1]) = 1 then Consti (Char.code (s.[3*i+2]) * (-1)) else Consti(Char.code s.[3*i+2]))
        (*| n when (n mod 8 = 4) -> Consti (n lsr 3) *)
        | 5 -> Pop
        | 6 -> Subs
        | 7 -> BranchIf (Char.code (s.[3*i+1]))
        | 8 -> Branch (Char.code (s.[3*i+1]))
        | _ -> failwith "invalid byte-code"
  done; p

let string_of_instr instr = match instr with
    | Consti n      -> print_string("Consti "); print_string((string_of_int n));print_string("\n")
    | Push          -> print_endline("Push ")
    | Addi          -> print_endline("Addi ")
    | Subs          -> print_endline("Subs ")
    | Andi          -> print_endline("Andi ")
    | Eqi           -> print_endline("Eqi ")
    | Pop           -> print_endline("Pop ")
    | BranchIf n    -> print_string("BranchIf "); print_string((string_of_int n));print_string("\n")
    | Branch n      -> print_string("Branch "); print_string((string_of_int n));print_string("\n")
    | _             -> failwith "invalid byte-code"


let print_instrs inst_list =
    let rec aux l i = match l with
    | []    -> ()
    | a::b  -> print_string((string_of_int i)); print_string(" - "); string_of_instr a ; aux b (i+1)
in aux (Array.to_list inst_list) 0


let exemple1 = [| Consti 1; Push; Consti 2; Addi; Pop |]


(** Langage Myrte *)

type value =
  | Int of int
  | Bool of bool

type binop = Add | Eq | And

type expr =
  | Const of value
  | Binop of binop * expr * expr
  | If of expr * expr * expr


(** Interprétation *)

let rec interp : expr -> value = function
  | Const v           -> v
  | Binop (b, e1, e2) -> (
    match b, interp e1, interp e2 with
     | Add, Int i, Int j -> Int (i + j)
     | Eq, Int i, Int j -> Bool (i = j)
     | And, Bool i, Bool j -> Bool (i && j)
     | _ -> failwith "type error"
    )
  | If (c, e1, e2) -> (
    match interp c with
     | Bool true -> interp e1
     | Bool false -> interp e2
     | _ -> failwith "type error"
    )




(** Compilation *)


let repr = function
  | Int i      -> i
  | Bool true  -> 1
  | Bool false -> 0

let op = function
  | Add -> Addi
  | Eq  -> Eqi
  | And -> Andi

let rec compil = function
  | Const v -> [Consti (repr v)]
  | Binop (o,e1,e2) -> compil e1 @
                       [Push] @
                       compil e2 @
                       [op o; Pop]
  | If (c, e1, e2) -> let i1 = compil e1 in
                      let i2 = compil e2 in
                      compil c @
                      [BranchIf (2 + List.length i2)] @ i2 @
                      [Branch (1 + List.length i1)] @ i1
