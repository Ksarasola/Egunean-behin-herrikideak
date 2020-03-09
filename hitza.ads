with Ada.Text_IO;

package Hitza is

  type Hitz is private;

  function Berdinak (H1, H2: Hitz) return Boolean;
   -- postbaldintza: sarrerako bi hitzak berdinak ote diren adierazten du

  procedure Idatzi_Hitza (H: in Hitz);
   -- postbaldintza: sarrerako H egituraren karaktereak pantailan idazten du
   --    eta bukaeran lerro jauzia

  procedure Hitza_Sortu_Fitxategitik (F: Ada.Text_IO.File_Type; H: out Hitz);
   -- Aurrebaldintza: Fitxategian hitzak komaz (,) bereiztuta daude.
   --    Kontuan hartu beharreko hitza edo kontzeptua, egiazki hainbat atalez
   --    osatuta badago, orduan sekuentzia osoa "" bereiztuta agertzen da
   --    Adibidez, jarduera bat politikari (" gabe) izan daiteke, edo "bide, ubide eta
   --    portuetako ingenieria"
   --    Fitxategiaren irakurketarako kurtsorea edozein posiziotan egon daiteke
   -- Postbaldintza: Fitxategiaren uneko posiziotik hurrengo komara (,) bitarteko karaktereek
   --    H egitura osatzen dute

  function Emakumezkoa_Hitza_Sortu return Hitz;
   -- Postbaldintza: "emakumezko" karaktere segidak osatzen duen egitura itzultzen da

  function Gizonezkoa_Hitza_Sortu return Hitz;
   -- Postbaldintza: "gizonezko" karaktere segidak osatzen duen egitura itzultzen da

  function Fusionatu_Hitzak(H1, H2: in Hitz) return Hitz;
   -- Postbaldintza: H1 eta H2 karaktere egiturak bata bestearen segidan kateatuz
   --    osatzen den egitura itzultzen da. Adibidez, H1 eta H2, "bat" eta "bi" balira
   --    "batbi" karaktere segidak osatutako egitura itzuliko litzateke


  private

   Kar_Max: Integer := 60;

   -- Zenbat-ek hitzaren luzera adierazten du
   type Hitz is record
      Letrak: string (1..Kar_Max);
      Zenbat: Integer;
   end record;

end Hitza;



