with Ada.Command_line, Ada.text_io, Ada.Integer_text_io;
use Ada.Command_line, Ada.text_io, Ada.Integer_text_io;
with dbinarytree;

procedure arbre_binary is
  package newlist is new dbinarytree(Item => Character, "<" => "<","=" => "=",">" => ">", image => Character'Image);
  use newlist;

  F_Entrada, F_Salida  :File_Type;
  a :Character;
  inlist, prelist :list;
  final_tree: tree;

begin
   if Argument_Count /= 1 then
      Put_Line("Only needs one file!");
   else

      emptylist(inlist);
      emptylist(prelist);

      Open(F_Entrada, Mode => In_File, Name => Argument(1));
      Open(F_Salida, Mode=> Out_File, Name => "resultats.txt");

      --create inorder list
      get(F_Entrada,a);
      while not End_Of_Line(F_Entrada) loop
         insert(inlist, a);
         get(F_Entrada, a);
         get(F_Entrada, a);
      end loop;
      insert(inlist, a);

      --create preorder list
      get(F_Entrada,a);
      while not End_Of_Line(F_Entrada) loop
        insert(prelist,a);
        get(F_Entrada,a);
        get(F_Entrada, a);
      end loop;
      insert(prelist,a);

      --print lists
      Put("Inorder list: ");
      print(inlist);
      Put_Line("");
      Put("Preorder list: ");
      print(prelist);
      Put_Line("");

      -- create tree from inorder & preorder lists
      empty(final_tree);
      first_tree(inlist,prelist,final_tree);

      -- check if the final tree is correct
      if arbre_correcte(final_tree, inlist) then
         Put_Line("correcto: 1");
         put(F_Salida, '1');
      else
         Put_Line("correcto: 0");
         put(F_Salida, '0');
      end if;

      --check if the final tree is Binary Search Tree
      if es_ACB(final_tree) then
         Put_Line("acb: 1");
         put(F_Salida, '1');
      else
         Put_Line("acb: 0");
         put(F_Salida, '0');
      end if;

      --close files
      close(F_Entrada);
      close(F_Salida);

    end if;
  end arbre_binary;
