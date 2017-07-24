#include <Date.au3>
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

Sleep(2000);

MsgBox(1, "Starting Transfer Out", "Transfer outs will begin in 3 seconds...");

; Loop Through All Transfer Docs
for $t = 1 to $CMDLINE[0]

   ; Open Up Transfer Out from Main Menu
   Sleep(5000);
   Send("^m");
   Sleep(500);
   Send("Transfers In");
   Sleep(500);
   Send("{ENTER}");
   Sleep(4000);

   ; Open The Transfer Doc and Read Transfer Information
   Local $transOut

   _FileReadToArray($CMDLINE[$t], $transOut);

   ; Transfer Out SSR File ARRAY Layout
   ;	[0] 	- > Count Of Number of Lines
   ;	[1] 	- > Reciving Branch
   ;	[2] 	- > Document Number
   ;	[3] 	- > Reference Number
   ;	[4] 	- > Ship In Date or Leave Blank for Today
   ;	[5]-[E] - >  { ECODES }

   ; Create A New Transfer In Doc
   Send("^n");
   Sleep(2000);


   ; Enter In Reciving Branch
   Send("{TAB}");
   Sleep(500);
   Send("{TAB}");
   Send($transOut[1]); Aux Function Needed to Use Arrows to Navi To Right One
   Sleep(1000);
   Send("{TAB}");
   Sleep(1000);

   ; Enter In Document Number
   Send($transOut[2]
   Send("{TAB}");
   Sleep(1000);

   ; Enter In Reference Number
   Send($transOut[3]);
   Sleep(1000);
   Send("{TAB}");
   Sleep(500);
   Send("{TAB}");
   Sleep(1000);

   ; Enter In Shipping Out Day (Current Date)
;~    Send(_NowDate());
;~    Sleep(1000);
;~    Send("{TAB}");
;~    Sleep(1000);

   ; Enter In Shipping Method
   Send($transOut[4]);
   Sleep(1000);
   Send("^{TAB}");
   Send("!a");
   Sleep(1000);

   ; Loop Through And Enter Ecodes
   for $ec = 5 to $transOut[0]
	  if StringLen($transOut[$ec]) == "" Then
		 ContinueLoop;
	  EndIf
	  Send($transOut[$ec]);
	  Sleep(100);
	  Send("{ENTER}");
	  Sleep(1500);
	  Send("{TAB}");
	  Sleep(750);
      Send("{TAB}");
	  Sleep(750);
	  Send("{TAB}");
	  Sleep(1000);
	  Send("{ENTER}");
	  Sleep(2500);

   Next

   Send("{ESC}");

Next

