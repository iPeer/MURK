;on *:input:*:{ 
;  if ($me == Creeper && !$inpaste && !$ctrlenter && $left($1,1) != /) { 
;    haltdef 
;    say $replace($1-,s,$str(s,$r(5,15))) 
; } 
;}
