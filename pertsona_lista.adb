with idatzi_katea, idatzi_karakterea;
with Ada.Integer_Text_IO;

package body pertsona_lista is

   procedure Hasieratu (L : in out Lista) is
   begin
      L.Zenbat := 0;
   end Hasieratu;

   procedure Txertatu_Bukaeran (
         L : in out Lista;
         P : in     Pertsona) is
   begin
      L.Zenbat := L.Zenbat + 1;
      L.Info (L.Zenbat) := P;
   end Txertatu_Bukaeran ;

   procedure Idatzi_Lista (L : in   Lista) is
   begin
      Idatzi_Karakterea ('<');
      for I in 1 .. L.Zenbat loop
         Idatzi_Hitza(L.Info(I).Izena);
      end loop;
      Idatzi_Katea (">");
   end Idatzi_Lista;

   procedure Irakurri_Pertsona (F: Ada.Text_IO.File_Type; P: out Pertsona) is

       H: Hitz;
   begin
      Hitza_Sortu_Fitxategitik(F, P.Izena);
      Hitza_Sortu_Fitxategitik(F, P.Jarduera);
      Hitza_Sortu_Fitxategitik(F, H);
      P.Emakumea := Berdinak(H, Emakumezkoa_Hitza_Sortu);
      Hitza_Sortu_Fitxategitik(F, P.Jaiolekua);
      if Ada.Text_IO.End_Of_Line(F) then
  	     P.Jaiourtea := 0;
      else
	     Ada.Integer_Text_Io.Get(F, P.Jaiourtea);
      end if;
      Ada.Text_IO.Skip_Line(F);
   end Irakurri_Pertsona;

   procedure Idatzi_Pertsona (P: in Pertsona) is
   begin

      Idatzi_Hitza (P.Izena);
      Idatzi_Hitza (P.Jarduera );
      if P.Emakumea then
	    Ada.Text_IO.Put_Line("Emak. ");
      else
	    Ada.Text_IO.Put_Line("Ez emak. ");
      end if;
      Idatzi_Hitza (P.Jaiolekua);
      Ada.Integer_Text_Io.Put (P.Jaiourtea);
      Ada.Text_IO.New_Line;

   end Idatzi_Pertsona;


   procedure Kargatu (
         L          :    out Lista;
         Fitx_Izena : in     String) is
      F : Ada.Text_IO.File_Type;
      P : Pertsona;
   begin
      L.Zenbat := 0;
      Ada.Text_IO.Open (F, Ada.Text_IO.In_File, Fitx_Izena);
      Ada.Text_IO.Skip_Line(F); -- csv fitxategiaren lehen lerro saltatu (zutabe tituluak)
      while not Ada.Text_IO.End_Of_File (F) loop
	    Irakurri_Pertsona (F, P);
         Txertatu_Bukaeran (L, P);
      end loop;
      Ada.Text_IO.Close (F);
   end Kargatu;

end pertsona_lista;
