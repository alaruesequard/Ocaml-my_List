type 'a my_list =
  | Item of ('a * 'a my_list)
  | Empty

(* tail-rec *)
let rec length = function
  | Empty	-> 0
  | Item(a, b)	-> (length b) + 1

(* not-tail *)
let hd = function
  | Empty	-> raise(Failure "hd")
  | Item(a, b)	-> a

(* not-tail *)
let tl = function
  | Empty	-> raise(Failure "tl")
  | Item(a, b)	-> b

(* tail-rec *)
let rec nth list nb =
  if (nb < 0)
  then raise(Invalid_argument "List.nth")
  else match list with
    | Empty		-> raise(Failure "nth")
    | Item(a, b)	-> if nb = 0 then a else nth b (nb - 1)

(* tail-rec *)
let rec rev_append a b = match a with
  | Empty		-> b
  | Item(hd, tl)	-> rev_append tl (Item(hd, b))

(* tail-rec *)
let rec rev a =
  rev_append a Empty

(* tail-rec *)
let append a b =
  rev_append (rev a) b

(* not-tail-rec *)
let rec flatten = function
  | Empty		-> Empty
  | Item(hd, tl)	-> append hd (flatten tl)

(* not-tail-rec *)
let concat list =
  flatten list

(* tail-rec *)
let rec iter func = function
  | Empty		-> ()
  | Item(hd, tl)	-> begin
    func hd;
    iter func tl;
  end

(* tail-rec *)
let rec iteri i func = function
  | Empty		-> ()
  | Item(hd, tl)	-> begin
    func i hd;
    iteri (i + 1) func tl;
  end

(* not-tail-rec *)
let iteri func list =
  iteri 0 func list

(* tail-rec *)
let rec iter2 func a b = match (a, b) with
  | (Empty, Empty)			-> ()
  | (Item(hda, tla), Item(hdb, tlb))	-> begin
    func hda hdb;
    iter2 func tla tlb;
  end
  | (_, _)				-> raise(Invalid_argument "List.iter2")

(* not-tail-rec *)
let rec map func = function
  | Empty		-> Empty
  | Item(hd, tl)	-> let b = func hd in Item(b, map func tl)

(* not-tail-rec *)
let rec mapi i func = function
  | Empty		-> Empty
  | Item(hd, tl)	-> let b = func i hd in Item(b, mapi (i + 1) func tl)

(* not-tail-rec *)
let mapi func list =
  mapi 0 func list

(* not-tail-rec *)
let rec map2 func a b = match(a, b) with
  | (Empty, Empty)			-> Empty
  | (Item(hda, tla), Item(hdb, tlb))	-> let c = func hda hdb in Item(c, map2 func tla tlb)
  | (_, _)				-> raise(Invalid_argument "List.map2")


(* tail-rec *)
let rev_map func list =
  let rec __rev_map a = function
    | Empty		-> a
    | Item(hd, tl)	-> __rev_map (Item(func hd, a)) tl
  in __rev_map Empty list

(* tail-rec *)
let rev_map2 func la lb =
  let rec __rev_map2 ret a b = match (a, b) with
    | (Empty, Empty)			-> ret
    | (Item(hda, tla), Item(hdb, tlb))	-> __rev_map2 (Item(func hda hdb, ret)) tla tlb
    | (_, _)				-> raise(Invalid_argument "List.map2")
  in __rev_map2 Empty la lb
