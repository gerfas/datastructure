with ada.text_io; use ada.text_io;

package body dbinarytree is

--creates an empty list
   procedure emptylist(a: out list) is
      begin
      a.first:=null;
      a.last:=null;
   end emptylist;

   --inserts an item inside list
   procedure insert(l: in out list; x: in item) is
      first:pcell renames l.first;
      p,pp,r: pcell;
   begin
      pp:=null; p:=first;
      while p/=null  loop
         pp:=p; p:=p.next;
      end loop;
      r:= new cell; r.all:=(x,null);
      r.next:=p;
      if pp=null then first:=r; else pp.next:=r; end if;
   end insert;

   --prints items of a list
   procedure print_list(l: in list) is
      p: pcell;
   begin
      p := l.first;
      while p/= null loop
         put(image(p.x));
         p := p.next;
      end loop;
   end print_list;

   --compare two lists, item by item
   function compare_list (l1, l2: in list) return Boolean is
      p1, p2: pcell;
   begin
      p1 := l1.first;
      p2 := l2.first;
      while p1 /= null and then p2 /= null loop
         if p1.x = p2.x then
            p1 := p1.next;
            p2 := p2.next;
         else
            return false;
         end if;
      end loop;
      return p1 =null and p2 = null;
   end compare_list;

   --creates an empty tree
   procedure empty(t: out tree) is
      p: pnode renames t.root;
   begin
      p:=null;
   end empty;

   --create tree from inorder & preorder lists
   --recursive procedure
   procedure create_tree(btree: in out list; children: out pnode; parent: in out pcell) is
      subtree: pcell:=btree.first;
      subleft, subright: list;
   begin
      if subtree=null then --if no more children nodes, stop the function
         children:=null;
      else
        --init the left and right subtrees
      emptylist(subleft);
      emptylist(subright);

      --creates left subtree
      while parent.x /= subtree.x loop
         insert(subleft, subtree.x);
         subtree:=subtree.next;
      end loop;

      --creates the right subtree
      subtree:=subtree.next;
      while subtree /= null loop
         insert(subright, subtree.x);
         subtree:= subtree.next;
      end loop;
      
      children:= new node;
      children.all:= (parent.x, null, null);
      parent:=parent.next;--advance in preorder list
      --recursive for both left and right subtrees
      create_tree(subleft,children.l,parent);
      create_tree(subright,children.r,parent);
      end if;
   end create_tree;

   --prepares to the recursive procedure create_tree
   procedure first_tree(inlist, prelist: in out list; btree: out  tree) is
      root: pnode renames btree.root;
   begin
      create_tree(inlist, root, prelist.first);
   end first_tree;

   --inorder traversal
   --recursive procedure
   procedure inorden (t: in pnode; inolist: out list) is
   begin
      if t /= null then
         inorden(t.l, inolist);
         insert(inolist, t.x);
         inorden(t.r, inolist);
      end if;
   end inorden;

   -- check if a tree is correct, from a list
   function arbre_correcte (a: in tree; r: in list) return boolean is
      root : pnode renames a.root;
      aux_list : list;
   begin
      emptylist(aux_list);
      inorden(root, aux_list);
      return compare_list(aux_list, r);
   end arbre_correcte;

   --check if a tree is a Binary Search Tree
   function es_ACB (a: in tree) return boolean is
      aux_list: list;
      p:pcell:= aux_list.first;
   begin
      emptylist(aux_list);
      inorden(a.root, aux_list);
            while p /= null loop
         if p.x > p.next.x then
            return false;
         else
            p := p.next;
         end if;
      end loop;
      return true;
   end es_ACB;

   end dbinarytree;
