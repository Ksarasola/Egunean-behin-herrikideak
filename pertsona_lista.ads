with  Ada.Text_IO;
with hitza;
use hitza;

package pertsona_lista is

   type Pertsona is record
      Izena,
      Jarduera,
      Jaiolekua: Hitz;
      Emakumea: Boolean;
      Jaiourtea: Integer;
   end record;

   Perts_Max: Integer := 3000;

   type Pertsona_Bektore is array (1..Perts_Max) of Pertsona;

   type Lista is record
      Info : Pertsona_Bektore;
      Zenbat : Natural;
   end record;

   procedure Hasieratu (L : in out Lista);
     -- Postbaldintza: L=<> lista hutsa

   procedure Txertatu_Bukaeran (L : in out Lista; P : in Pertsona);
     -- Aurrebaldintza: L=<x_1, x_2, ..., x_j> non L.zenbat=j;
     --                 eta j<Perts_MAX, L ez dago beteta
     -- Postbaldintza: L=<x_1, x_2, ..., x_j, P> non L.zenbat=j+1

   procedure Idatzi_Lista (L : in   Lista);
    -- Postbaldintza: pantailan listako pertsonen izenak idazten dira

   procedure Irakurri_Pertsona (F: Ada.Text_IO.File_Type; P: out Pertsona);
   -- Aurrebaldintza: F testu-fitxategian hitzak lerrotan eta komaz (,) bereiztuta daude.
   --    Lerro bakoitzean lau edo bost atal bereizten dira, orden honetan:
   --    izena, jarduera, generoa, jaiolekua, [jaiourtea]; azken hori ez agertzea
   --    gerta daiteke.
   --    Kontuan hartu beharreko hitza edo kontzeptua, egiazki hainbat zatiz
   --    osatuta badago, orduan sekuentzia osoa "" bereiztuta agertzen da
   --    Adibidez, jarduera bat politikari (" gabe) izan daiteke, edo "bide, ubide eta
   --    portuetako ingenieria"
   --    Fitxategiaren irakurketarako kurtsorea edozein posiziotan egon daiteke, baina
   --    beti lerro baten hasieran
   -- Postbaldintza: F fitxategiaren uneko posiziotik lerro amaiera arteko hitzak
   --    P egituran biltegiratuta daude

   procedure Idatzi_Pertsona (P: in Pertsona);
    -- Postbaldintza: pantailan P egitura idazten da.
    --      Bere izena, jarduera, emakumea den edo ez, jaiolekua eta jaiotze-urtea
    --      Idazketa bakoitzaren ondoren lerro jauzia dago

   procedure Kargatu (
         L          : out Lista;
         Fitx_Izena : in String);

   -- Aurrebaldintza: F testu-fitxategi baten izena da. Fitxategian
   --    hitzak lerrotan eta komaz (,) bereiztuta daude.
   --    Lerro bakoitzean lau edo bost atal bereizten dira, orden honetan:
   --    izena, jarduera, generoa, jaiolekua, [jaiourtea]; azken hori ez agertzea
   --    gerta daiteke.
   --    Kontuan hartu beharreko hitza edo kontzeptua, egiazki hainbat zatiz
   --    osatuta badago, orduan sekuentzia osoa "" bereiztuta agertzen da
   --    Adibidez, jarduera bat politikari (" gabe) izan daiteke, edo "bide, ubide eta
   --    portuetako ingenieria"
   -- Postbaldintza: F fitxategiko hitzak L listan biltegiratuta daude


end pertsona_lista;
