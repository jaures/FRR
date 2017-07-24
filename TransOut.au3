#include <Date.au3>
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>

Local $hDLL = DllOpen("user32.dll")


Sleep(2000);

MsgBox(1, "Starting Transfer Out", "Transfer outs will begin in 3 seconds...");

; Loop Through All Transfer Docs
for $t = 1 to $CMDLINE[0]

   ; Open Up Transfer Out from Main Menu
   Sleep(5000);
   Send("^m");
   Sleep(500);
   Send("Transfers");
   Sleep(250);
   Send("{DOWN}");
   Sleep(500);
   Send("{ENTER}");
   Sleep(4000);

   ; Open The Transfer Doc and Read Transfer Information
   Local $transOut

   _FileReadToArray($CMDLINE[$t], $transOut);

   ; Transfer Out SSR File ARRAY Layout
   ;	[0] 	- > Count Of Number of Lines
   ;	[1] 	- > Reciving Branch
   ;	[2] 	- > Reference Number
   ;	[3] 	- > Ship In Date
   ;	[4] 	- > Shipping Method
   ;	[5]-[E] - >  { ECODES }

   ; Create A New Transfer Doc
   Send("^n");
   Sleep(2000);

   ; Enter In Reciving Branch
   Send($transOut[1]);
   Sleep(1000);
   Send("^{ENTER}");
   Sleep(1000);
   Send("^{ENTER}");
   Sleep(1000);

   ; Enter In Reference Number
   Send($transOut[2]);
   Sleep(1000);
   Send("{TAB}");
   Sleep(500);
   Send("{TAB}");
   Sleep(1000);

   ; Enter In Shipping Out Day (Current Date)
   Send(_NowDate());
   Sleep(1000);
   Send("{TAB}");
   Sleep(1000);

   ; Enter In Shipping In Day
   Send($transOut[3]);
   Sleep(1000);
   Send("^{TAB}");
   Sleep(500);

   ; Enter In Shipping Method
   Send($transOut[4]);
   Sleep(1000);
   Send("^{TAB}");
   Send("!a");
   Sleep(1000);

   ; Loop Through And Enter Ecodes
   for $ec = 5 to $transOut[0]

	  ; Check for ESC
	  If _IsPressed("1B", $hDLL) Then
		 DllClose($hDLL)
		 Exit
	  EndIf

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

DllClose($hDLL)