with Idatzi_Katea, Idatzi_Karakterea;
with  Ada.Text_IO,   Ada.Integer_Text_IO;

procedure Probatu_Sortu_galderak is
   --Aurre: query.csv fitxategia Wikidatako galdera honekin sortu da: https://w.wiki/Jej
   --       Herri batean (Ordizia) jaio edo bizi diren pertsonen 
   --         jaiotze-data, sexua eta jarduera (wikidatan daudenak) 
   --Post: irteera_herrikideak_ada.csv fitxategian hainbat galdera sortu dira 
   --      bakoitza lerro batean datu hauekin
   -- Mota, Galdera, Irudia, Zuzena, Oker1, Oker2, Jatorria, Esteka, Egilea
   -- "Nor da argazkiko pertsona?" erantzun zuena eta bi erantzun oker
   -- Erantzun okerrak zuzenaren antzekoak dira: sexu eta jarduera berekoak, adina+-Urt_Dif_Max

   
   Kar_Max: constant Integer := 80; -- Hitzen edo helbideen karaktere kopuru maximoa
   Urt_Dif_Max : constant Integer := 100;  -- pertsonen arteko onartzen den adin diferentzia maximoa

   type Hitz is record
      Letrak: string (1..Kar_Max);  
      Zenbat: Integer;
   end record;
   Hutsik : constant Hitz := ((1..Kar_Max =>' '),0);
   
   type Pertsona is record
      Kodea, 
      Izena,
      Jarduera,
      Jaiolekua,
      Argazkia: Hitz;
      Emakumea: Boolean; 
      Jaiourtea: Integer;
   end record; 
   
   Perts_Max: Integer := 2400;
   type Pertsona_Bektore is array (1..Perts_Max) of Pertsona;
   type Pertsona_Lista is record
      Info  : Pertsona_Bektore;
      Zenbat: Natural;
   end record;  
  
   
   
   function Berdinak (H1, H2: Hitz) return Boolean is
   begin
      return H1.Zenbat = H2.Zenbat 
	and then H1.Letrak(1..H1.Zenbat) = H2.Letrak(1..H1.Zenbat);
   end Berdinak;
   
   
   function Antzekoa (PL: Pertsona_Lista; I1,I2 : Integer) return Boolean is
      --Aurre: 1 <= I1 <= PL.Zenbat
      --       1 <= I2 <= PL.Zenbat
      --Post : Emaitza = True baldin eta soilik baldin 
      --                   PL.Info(I1) eta PL.Info(I2) pertsonak sexu eta lanbide berekoak badira, 
      --                   eta jaiourtean gehienez 100 (Urt_Dif_Max) urteko aldea badute
      P1, P2 : Pertsona; 
      Emaitza : Boolean;
   begin
      P1 := PL.Info(I1);
      P2 := PL.Info(I2);
      Emaitza := Berdinak (P1.Jarduera, P2.Jarduera)
	and P1.Emakumea = P2.Emakumea
	and  (abs(P1.Jaiourtea - P2.Jaiourtea) <= Urt_Dif_Max);
      return Emaitza;	 
   end Antzekoa;
   
   
   procedure  Bilatu_Antzekoak (PL : in Pertsona_Lista; 
				Eredua: in Integer;
				Oker1, Oker2: out Integer;
				Posible: out Boolean) is
      --Aurre: PB'First <= Eredua <= PB'Last
      --Post : Posible = Existitzen dira Oker1 eta Oker2:
      --                   1 <= Oker1 <= PL.Zenbat
      --                   1 <= Oker2 <= PL.Zenbat
      --                   Oker1 /= Oker2
      --                   PL.Info(Oker1) eta PL.Info(Eredu) antzekoak dira
      --                   PL.Info(Oker1).Izena /= PL1.Info(Eredu).Izena
      --                   PL.Info(Oker2) eta PL.Info(Eredu) antzekoak dira
      --                   PL.Info(Oker2).Izena /= PL.Info(Eredu).Izena
      --        Bi pertsona antzekoak dira sexu eta lanbide berekoak badira, 
      --        eta jaiourtean gehienez 20 urteko aldea badute
      Aurkituak2, Aurkitua1 : Boolean;
      I: Integer;
   begin
      Aurkitua1 := False;
      Aurkituak2 := False;
      Oker1 := 1; -- gero aldatuko da, balio hau ez da erabiliko
      I := 1;
      while I <= PL.Zenbat and not Aurkituak2 loop
	 if not Berdinak (PL.Info(I).Izena, PL.Info(Eredua).Izena) and Antzekoa (PL, Eredua, I) then
	    Ada.Integer_Text_IO.Put(Eredua);
	    Ada.Integer_Text_IO.Put(I);
	    Ada.Text_IO.New_Line;
	    if Aurkitua1 then
	       if not Berdinak(PL.Info(I).Izena, PL.Info(Oker1).Izena) then
		  Aurkituak2 := True; 
		  Oker2 := I;
	       end if;
	    else
	       Aurkitua1 := True;
	       Oker1 := I;
	    end if;	    
	 end if;
	 I := I+1;
      end loop;
      Posible := Aurkituak2;
   end Bilatu_Antzekoak;

   
   procedure Idatzi (PL : in Pertsona_Lista) is
      Izena: Hitz;
   begin
      Idatzi_Karakterea ('<');
      for I in 1..PL.Zenbat loop
	 Izena := PL.Info(I).Izena;
         for I in 1..Izena.Zenbat loop Ada.Text_Io.Put (Izena.Letrak(I)); end loop;
	 Ada.Text_Io.New_Line;
      end loop;
      Idatzi_Katea (">");
   end Idatzi;
   
   
   procedure Hitza_idatzi (F: Ada.Text_IO.File_Type; H: in Hitz) is	 
   begin
      for I in 1..H.Zenbat loop
	 Ada.Text_IO.Put(F, H.Letrak(I));
      end loop;
   end Hitza_Idatzi;

   procedure Hitza_idatzi (H: in Hitz) is	 
   begin
      for I in 1..H.Zenbat loop
	 Ada.Text_IO.Put(H.Letrak(I));
      end loop;
      Ada.Text_IO.New_Line;
   end Hitza_Idatzi;

   
   procedure Irakurri_Pertsona (F: Ada.Text_IO.File_Type; P: out Pertsona) is
      procedure Hitza_Sortu_Fitxategitik (F: Ada.Text_IO.File_Type; H: out Hitz) is
	 I: Integer;
	 Kar : Character;
	 Aurkitua : Boolean;
	 Komatxotan : Boolean := False;
      begin
	 H.Zenbat :=0;
	 I:=0;
	 Aurkitua := False;
	 while I< Kar_Max and not Aurkitua loop
	    Ada.Text_IO.Get(F, Kar);
	    if Kar = ',' and not Komatxotan then
	       Aurkitua :=True;
	    else
	       if Kar = '"' then
		  Komatxotan := not Komatxotan;
	       else
		  I := I + 1;
		  H.Letrak(I) := Kar;
	       end if;
	    end if;
	 end loop;
	 H.Zenbat := I;
	 if not Aurkitua then
	    while not Aurkitua loop
	       Ada.Text_IO.Get(F, Kar);
	       if Kar = ',' then
		  Aurkitua :=True;
	       end if;
	    end loop;
	 end if;
	 Ada.Integer_Text_IO.Put(H.Zenbat);	 
      end Hitza_Sortu_Fitxategitik;
      
      
      H: Hitz;
   begin
      Hitza_Sortu_Fitxategitik(F, P.Izena);
      Hitza_Idatzi (P.Izena);
      Hitza_Sortu_Fitxategitik(F, P.Jarduera);
      Hitza_Idatzi (P.Jarduera );
      
      Hitza_Sortu_Fitxategitik(F, H);
      P.Emakumea := H.Letrak(1..11) = "emakumezkoa";
      if P.Emakumea then 
	 Ada.Text_IO.Put_Line("Emak. ");
      else 
	 Ada.Text_IO.Put_Line("Ez emak. ");
      end if;
      
      Hitza_Sortu_Fitxategitik(F, P.Jaiolekua);		  
      Hitza_Idatzi (P.Jaiolekua);
      Hitza_Sortu_Fitxategitik(F, P.Argazkia);		  
      Hitza_Idatzi (P.Argazkia);
      
      if Ada.Text_IO.End_Of_Line(F) then
	 P.Jaiourtea := 0;
      else
	 Ada.Integer_Text_Io.Get(F, P.Jaiourtea);
      end if;
      Ada.Integer_Text_Io.Put (P.Jaiourtea);
      
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Skip_Line(F);		     		   
   end Irakurri_Pertsona;
   
   
   procedure Kargatu (PL         :    out Pertsona_Lista;
		      Fitx_Izena : in     String) is
      F : Ada.Text_IO.File_Type;
      P : Pertsona;
      I : Integer;
   begin
      I := 0;     
      Ada.Text_IO.Open (F, Ada.Text_IO.In_File, Fitx_Izena);
      Ada.Text_IO.Skip_Line(F); -- csv fitxategiaren lehen lerro saltatu (zutabe tituluak)
      while not Ada.Text_IO.End_Of_File (F) and I <= Perts_Max loop
	 Irakurri_Pertsona (F, P);
	 I := I + 1;
	 PL.Info(I) := P;
	 --  Ada.Integer_Text_Io.Put (L.Zenbat);
	 --  Ada.Text_IO.New_Line;
      end loop;
      Ada.Text_IO.Close (F);
      PL.Zenbat := I;
      
   end Kargatu;
   
   
   procedure Sortu_Galderak (F: Ada.Text_Io.File_Type; PL : in Pertsona_Lista) is
      
      procedure  Idatzi_Galdera (F: Ada.Text_Io.File_Type; 
				 PL  : in Pertsona_Lista;
				 I, I_Oker1, I_Oker2 : in Integer) is
	 --Aurre: 
	 --Post: F fitxategian idatzi da lerro bat PL listako I. pertsonaren izena galdetzeko
	 --      listako I_Oker1 eta I_Oker2-garren pertsonen izenak dira aukera okerrak.
	 
      begin
	 --"Mota;Galdera;Irudia;Zuzena;Oker1;Oker2;Jatorria;Esteka;Egilea"
	 
	 -- Idatzi Mota
	 Ada.Text_IO.Put (F, "Herrikideak;"); 
	 -- Idatzi Galdera
	 Ada.Text_IO.Put (F, "Nor da argazkiko pertsona?;"); 
	 -- Idatzi Irudia
	 Hitza_Idatzi (F, PL.Info(I).Argazkia);
	 Ada.Text_IO.Put (F, ";"); 
	 -- Idatzi Zuzena
	 Hitza_Idatzi(F, PL.Info(I).Izena);
	 Ada.Text_IO.Put (F, ";"); 
	 -- Idatzi Oker1
	 Hitza_Idatzi(F, PL.Info(I_Oker1).Izena);
	 Ada.Text_IO.Put (F, ";"); 
	 -- Idatzi Oker2
	 Hitza_Idatzi(F, PL.Info(I_Oker2).Izena);
	 Ada.Text_IO.Put (F, ";"); 
	 -- Idatzi Jatorria;Esteka;Egilea
	 Ada.Text_IO.Put (F, "https://eu.wikipedia.org/;"); 
	 Ada.Text_IO.New_line (F);   
      end Idatzi_Galdera;
      
      
      P1: Pertsona;
      I_Oker1, I_Oker2 : Integer;
      Posible : Boolean;
   begin
      for I in 1.. PL.Zenbat loop
	 P1 := PL.Info(I);
	 PosibLe := False;
	 if P1.Argazkia.Zenbat > 0 then -- Argazkirik badauka
	    Bilatu_Antzekoak (PL, I, I_Oker1, I_Oker2, Posible);
	    if Posible then
	       Idatzi_Galdera (F, PL, I, I_Oker1, I_Oker2);
	    end if;
	 end if;
      end loop;
   end Sortu_Galderak;
   
   
   
   
   PL1: Pertsona_Lista;
   F : Ada.Text_IO.File_Type;
begin
   --Aurkezpena;
   Kargatu(PL1,"query.csv");
   Idatzi(PL1);
   
   Ada.Text_IO.Create (F, Ada.Text_IO.out_File, "irteera_herrikideak_ada.csv");

   --csv fitxategian idatzi Goiburua
   Ada.Text_IO.Put_line (F, "Mota;Galdera;Irudia;Zuzena;Oker1;Oker2;Jatorria;Esteka;Egilea"); 
   Ada.Text_IO.Put_line ("#### galderak sortzen ####");
   
   Sortu_Galderak (F, PL1);

   Ada.Text_IO.Put_line ("Eginda!");
   Ada.Text_IO.Close (F);

end Probatu_Sortu_Galderak;

--  Ordiziakoekin, Antzeko adinaren murrizketa kenduta: 
--
--  <Andres Urdaneta -- Patxi Zubizarreta -- Nikolas Lekuona
--  Patxi Zubizarreta -- Andres Urdaneta -- Nikolas Lekuona
--  Mikel Arana -- Adur Ezenarro Agirre -- Manuel José de Zavala
--  Nikolas Lekuona -- Andres Urdaneta -- Patxi Zubizarreta
--  Sara Cozar -- Paula Etxeberria -- Aitana Etxeberria
--  Txema Auzmendi -- Salvador Martín -- Jesús María Toral
--  >

-- 100 urteko aldea onartuta:
--  Patxi Zubizarreta -- Nikolas Lekuona -- Ander Iturriotz
--  Mikel Arana -- Adur Ezenarro Agirre -- Joseba Rezola
--  Nikolas Lekuona -- Patxi Zubizarreta -- Ander Iturriotz
--  Sara Cozar -- Paula Etxeberria -- Aitana Etxeberria
--  >

-- 20 urteko aldearekin:
--
--  <Nikolas Lekuona -- Fermin Iturrioz -- Ramon Murua
--  Sara Cozar -- Paula Etxeberria -- Aitana Etxeberria
--  >


--EXEKUZIO ADIBIDEA:  Ordizia, 100 urteko aldea onaruta

--  Irudia	Zuzena	Oker1	Oker2
--  http://commons.wikimedia.org/wiki/Special:FilePath/Patxi%20Zubizarreta.JPG
--    Patxi Zubizarreta	Nikolas Lekuona	Ander Iturriotz
--  http://commons.wikimedia.org/wiki/Special:FilePath/Mikel%20Arana%20reunido%20con	
--    Mikel Arana	Adur Ezenarro Agirre	Joseba Rezola
--  http://commons.wikimedia.org/wiki/Special:FilePath/Nicolas%20de%20lekuona-st-mnc	
--    Nikolas Lekuona	Patxi Zubizarreta	Ander Iturriotz
--  http://commons.wikimedia.org/wiki/Special:FilePath/Sara%20Cozar%20antzezlea%2020	
--    Sara Cozar	Paula Etxeberria	Aitana Etxeberria
