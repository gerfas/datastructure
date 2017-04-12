generic
   type item is private;
   with function "<"(i1, i2: in item) return boolean;
   with function ">"(i1, i2: in item) return boolean;
   with function "="(i1, i2: in item) return boolean;
   with function image(i: in item) return String;


package dbinarytree is

   type tree is limited private;
   type list is limited private;
   type pnode is limited private;
   type pcell is limited private;

   bad_use:        exception;
   space_overflow: exception;

   -- list procedures & functions
   procedure emptylist   (a: out list);
   procedure insert      (l: in out list; x: in item);
   procedure print_list  (l: in list);
   function compare_list (l1, l2: in list) return Boolean;

   -- tree procedures & functions
   procedure empty       (t: out tree);
   procedure first_tree  (inlist, prelist: in out list; btree: out  tree);
   procedure create_tree (btree: in out list; children: out pnode; parent: in out pcell);
   procedure inorden     (t: in pnode; inolist: out list);
   function arbre_correcte(a: in tree; r: in list) return boolean;
   function es_ACB       (a: in tree) return boolean;


private
   --tree
   type node;
   type pnode is access node;

   type node is
      record
         x:   item;
         l,r: pnode;
      end record;

   type tree is
      record
         root: pnode;
      end record;

   --list
   type cell;
   type pcell is access cell;

   type cell is
      record
         x:    item;
         next: pcell;
      end record;

   type list is
      record
         first: pcell;
         last : pcell;
      end record;

end dbinarytree;
