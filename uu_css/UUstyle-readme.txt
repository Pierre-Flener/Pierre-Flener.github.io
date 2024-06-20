
Webbmallar: css-baserad layout
::::::::::::::::::::::::::::::

Kopiera filerna till din webbserver. behåll katalogstrukturen. 
Ändra generella textpartier som smulrad och sidfot. 
Glöm inte sidtitel och meta-taggarna för description 
och keywords! Spara sedan som mall för dina webbsidor.

Om det ser konstigt ut när du jobbar med filerna i ex. 
DreamWeaver MX (före ver. 2004) kan du kommentera ut 
referensen till print.css medan du jobbar med filerna enligt:

<!--link rel="stylesheet" type="text/css" media="print" href="uu_css/print.css" /-->

Glöm inte ta bort !-- -- då du är klar.



::::::::::::::::::::::::::::::::::::::

I paketet finns diverse html-filer, tre är mallfiler 
med röd, vit resp. grå marginal. Dessa heter red.html, 
white.html samt grey.html (go figure..). Dessa tre 
mallar har högerkolumn färdig. Utöver dessa finns också 
en fil - stilexempel.html - som visar exempel på de 
olika stilarna i stilmallarna. Sist men inte minst finns 
en basmall - basic.html - utan högerkolumn och därför 
med något bredare huvudyta. 



I katalogen uu_css finns tre stilmallar: 

- maincss.css som är den huvudsakliga stilmallen. 
Denna skall alltid importeras enl. följande:

<style type="text/css" media="screen">
@import url(uu_css/maincss.css);
</style>

- print.css styr utskriftsformatering. 
Denna skall alltid länkas in enligt:

<link rel="stylesheet" type="text/css" media="print" href="uu_css/print.css" />

- rightcol.css som sköter högerkolumnen om sådan önskas. 
Om denna inte länkas in enligt nedan fås, som är fallet i basmallen, 
fås en bredare huvudyta och ingen högerkolumn. 

<link rel="stylesheet" type="text/css" media="screen" href="uu_css/rightcol.css" />

I maincss.css är högerkolumnen (#rightcolumn) dold och 
huvudytan (#maincontent) 500 pixlar bred. Önskas högerkolumn 
länkar man in rightcol.css som minskar huvudytans bredd till 
380 px och formaterar högerkolumnen i det nyvunna utrymmet.
(Glöm inte att lägga till högerkolumn i mallen heller...)

Basmallen länkar inte in den tredje stilmallen - rightcol.css - 
varvid högerkolumn saknas och en något bredare huvudyta erhålles.



I katalogen uu_img finns tillhörande bildfiler.

Revisioner

2004-06-30: 
Raden "background-color: transparent;" har tagits bort för 
html, body i maincss.css då marginalen inte löpte hela vägen ned i Mac/IE 5.x 

2005-01-10:
Plockat bort xml-deklarationen ur mallarna. Observera att dokument 
utan denna deklaration måste använda utf-8 eller utf-16 för att validera.
(se http://www.w3.org/TR/xhtml1/#C_1 för mer information)




Åke Johansson :: 2005-01-25
Informationsavdelningen :: Uppsala universitet

Frågor, tips och förbättringsförslag tas emot på ake.johansson[a]uadm.uu.se
  