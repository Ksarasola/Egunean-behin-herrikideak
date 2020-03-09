with Ada.Text_IO, Ada.Integer_Text_IO;

package body hitz_kontagailua is

   procedure Hasieratu (L : in out H_Kontagailu_Lista) is
   begin
      L.Zenbat := 0;
   end Hasieratu;

   function Lortu_luzera (L : in H_Kontagailu_Lista) return Integer is
   begin
      return L.zenbat;
   end Lortu_luzera ;

   function Lortu_hitza (L : in H_Kontagailu_Lista; ind : in Integer)
                        return Hitz is
   begin
      return L.Info(ind).H;
   end Lortu_hitza;

   procedure Idatzi_Kontagailu_Lista (L: H_Kontagailu_Lista) is
   begin
      for I in 1..L.Zenbat loop
  	    Idatzi_Hitza( L.Info(I).H);
	    Ada.Integer_Text_IO.Put(L.Info(I).Kont);
	    Ada.Text_IO.New_Line ;
      end loop;
   end Idatzi_Kontagailu_Lista;

   procedure Hasieratu_Kontagailua (L: in out H_Kontagailu_Lista; Hberria: in Hitz;
                                    ind: out Integer) is
   begin
      L.zenbat := L.zenbat+1;
      L.Info(L.zenbat).H := Hberria;
      L.Info(L.zenbat).Kont := 0;
      ind := L.zenbat;
   end Hasieratu_Kontagailua;

   procedure Gehitu_Kontagailua (L: in out H_Kontagailu_Lista; ind: in Integer) is
   begin
      L.Info(ind).Kont := L.Info(ind).Kont+1;
   end Gehitu_Kontagailua;

end hitz_kontagailua;
