
Webbmallar: css-baserad layout
::::::::::::::::::::::::::::::

Kopiera filerna till din webbserver. beh�ll katalogstrukturen. 
�ndra generella textpartier som smulrad och sidfot. 
Gl�m inte sidtitel och meta-taggarna f�r description 
och keywords! Spara sedan som mall f�r dina webbsidor.

Om det ser konstigt ut n�r du jobbar med filerna i ex. 
DreamWeaver MX (f�re ver. 2004) kan du kommentera ut 
referensen till print.css medan du jobbar med filerna enligt:

<!--link rel="stylesheet" type="text/css" media="print" href="uu_css/print.css" /-->

Gl�m inte ta bort !-- -- d� du �r klar.



::::::::::::::::::::::::::::::::::::::

I paketet finns diverse html-filer, tre �r mallfiler 
med r�d, vit resp. gr� marginal. Dessa heter red.html, 
white.html samt grey.html (go figure..). Dessa tre 
mallar har h�gerkolumn f�rdig. Ut�ver dessa finns ocks� 
en fil - stilexempel.html - som visar exempel p� de 
olika stilarna i stilmallarna. Sist men inte minst finns 
en basmall - basic.html - utan h�gerkolumn och d�rf�r 
med n�got bredare huvudyta. 



I katalogen uu_css finns tre stilmallar: 

- maincss.css som �r den huvudsakliga stilmallen. 
Denna skall alltid importeras enl. f�ljande:

<style type="text/css" media="screen">
@import url(uu_css/maincss.css);
</style>

- print.css styr utskriftsformatering. 
Denna skall alltid l�nkas in enligt:

<link rel="stylesheet" type="text/css" media="print" href="uu_css/print.css" />

- rightcol.css som sk�ter h�gerkolumnen om s�dan �nskas. 
Om denna inte l�nkas in enligt nedan f�s, som �r fallet i basmallen, 
f�s en bredare huvudyta och ingen h�gerkolumn. 

<link rel="stylesheet" type="text/css" media="screen" href="uu_css/rightcol.css" />

I maincss.css �r h�gerkolumnen (#rightcolumn) dold och 
huvudytan (#maincontent) 500 pixlar bred. �nskas h�gerkolumn 
l�nkar man in rightcol.css som minskar huvudytans bredd till 
380 px och formaterar h�gerkolumnen i det nyvunna utrymmet.
(Gl�m inte att l�gga till h�gerkolumn i mallen heller...)

Basmallen l�nkar inte in den tredje stilmallen - rightcol.css - 
varvid h�gerkolumn saknas och en n�got bredare huvudyta erh�lles.



I katalogen uu_img finns tillh�rande bildfiler.

Revisioner

2004-06-30: 
Raden "background-color: transparent;" har tagits bort f�r 
html, body i maincss.css d� marginalen inte l�pte hela v�gen ned i Mac/IE 5.x 

2005-01-10:
Plockat bort xml-deklarationen ur mallarna. Observera att dokument 
utan denna deklaration m�ste anv�nda utf-8 eller utf-16 f�r att validera.
(se http://www.w3.org/TR/xhtml1/#C_1 f�r mer information)




�ke Johansson :: 2005-01-25
Informationsavdelningen :: Uppsala universitet

Fr�gor, tips och f�rb�ttringsf�rslag tas emot p� ake.johansson[a]uadm.uu.se
  