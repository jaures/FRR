#include <Date.au3>
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>


MsgBox(1, "PO", "About to Start PO Ref Adding in 5 Sec");

Local $serials

_FileReadToArray($CMDLINE[1], $serials);

For $s = 1 to $serials[0]
   Send($serials[$s]);
   Sleep(500);
   Send("{TAB}");
   Sleep(200);
   Send("{TAB}");
   Sleep(200);
   Send("{ENTER}");
   Sleep(1500);
   Send("!r");
   Sleep(500)
Next