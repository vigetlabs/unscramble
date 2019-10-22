open Base
open Stdio

let file = "/usr/share/dict/cracklib-small"

let sorted_letters w =
  let letters = String.to_list w in
  List.sort letters Poly.compare

let same_letters w1 w2 =
  let l1 = sorted_letters w1
  and l2 = sorted_letters w2 in
  List.equal Char.equal l1 l2

let filter_dict input dict =
  let l = String.length input
  and f = String.get input 0 in
  List.filter dict (fun (w) ->
    String.length w = l && String.contains w f)

let rec find_match input = function
  | w :: ws ->
      if same_letters input w then
        w
      else
        find_match input ws
  | [] -> failwith "No match found.";;

let dictionary = Stdio.In_channel.read_lines file in
let input = Array.get Sys.argv 1 in
let possible_matches = filter_dict input dictionary in
let result = find_match input possible_matches in
Stdio.print_endline result
