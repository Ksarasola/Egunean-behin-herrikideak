package body Hitza is

  function Berdinak (H1, H2: Hitz) return Boolean is
   begin
      return H1.Zenbat = H2.Zenbat
	       and then H1.Letrak(1..H1.Zenbat) = H2.Letrak(1..H1.Zenbat);
   end Berdinak;

  procedure Idatzi_Hitza (H: in Hitz) is
   begin
      for I in 1..H.Zenbat loop
	    Ada.Text_IO.Put(H.Letrak(I));
      end loop;
      Ada.Text_IO.New_Line;
   end Idatzi_Hitza;

   procedure Hitza_Sortu_Fitxategitik (F: Ada.Text_IO.File_Type; H: out Hitz) is
	 I: Integer;
	 Kar : Character;
	 Aurkitua : Boolean;
	 Komatxotan : Boolean := False;
    begin
	 H.Zenbat := 0;
	 I:= 0;
	 Aurkitua := False;
	 while I < Kar_Max and not Aurkitua loop
	    Ada.Text_IO.Get(F, Kar);
	    if Kar = ',' and not Komatxotan then
	       Aurkitua := True;
	    elsif Kar = '"' then
		  Komatxotan := not Komatxotan;
	    else
		  I := I + 1;
		  H.Letrak(I) := Kar;
	    end if;
	 end loop;
      H.Zenbat := I;

      -- Hitza luzeegia zen eta luzera maximoa gainditu du,
      -- Fitxategian soberan dauden karaktereak irakurriko dira beren
      -- muga (hots, koma (,)) gainditu arte
	 if not Aurkitua then
	    while not Aurkitua loop
	       Ada.Text_IO.Get(F, Kar);
	       if Kar = ',' then
		       Aurkitua :=True;
	       end if;
	    end loop;
	 end if;
   end Hitza_Sortu_Fitxategitik;

   function Emakumezkoa_Hitza_Sortu return Hitz is
      berria: Hitz;
    begin
      berria.Letrak(1..11) := "emakumezkoa";
      berria.Zenbat := 11;
      return berria;
    end Emakumezkoa_Hitza_Sortu;

   function Gizonezkoa_Hitza_Sortu return Hitz is
      berria: Hitz;
    begin
      berria.Letrak(1..10) := "gizonezkoa";
      berria.Zenbat := 10;
      return berria;
    end Gizonezkoa_Hitza_Sortu;


    function Fusionatu_Hitzak(H1, H2: in Hitz) return Hitz is
       berria: Hitz;
     begin
        berria.Letrak := H1.Letrak;
        berria.Zenbat := H1.Zenbat;
        berria.Letrak(berria.Zenbat+1..berria.Zenbat+2) := ", ";
        berria.Letrak(berria.Zenbat+3..berria.Zenbat+2+H2.Zenbat) := H2.Letrak(1..H2.Zenbat);
        berria.Zenbat := berria.Zenbat+H2.Zenbat+2;
        return berria;
     end Fusionatu_Hitzak;

end Hitza ;



