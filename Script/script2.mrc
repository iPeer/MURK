alias getmcostlinks {
  if ($sock(GetMCOSTLinks)) .sockclose GetMCOSTLinks
  set %chan $chan
  sockopen GetMCOSTLinks c418.bandcamp.com 80
}
on *:SOCKOPEN:GetMCOSTLinks: {
  sockwrite -nt $sockname GET /album/minecraft-volume-alpha HTTP/1.1
  sockwrite -nt $sockname Host: c418.bandcamp.com
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:GetMCOSTLinks: {
  if ($sockerr) {
    msg %chan Socket Error: $sockname $+ . Error code: $sockerr Please inform $me of this error message.
    halt
  }
  else {
    var %sockreader
    sockread %sockreader
    if (*<a href="/track/*">*</a>* iswm %sockreader) {
      noop $regex(%sockreader,/"(.*?)">(.*?)</Si)
      var %tempvar $regml(1)
      echo -tg %tempvar \ $regml(2)
      if (%tempvar && $regml(2)) { getmcpost %tempvar $regml(2) }
    }
    if (*<dt class="hiddenAccess">about</dt>* iswm %sockreader) { sockclose $sockname }
  }
}
alias getmcpost {
  echo -tg Init.
  ;var %link = $+(/,$gettok($1-,3-,47))
  %link = $1-
  ;%title = $2-
  var %id 1
  while ($sock(GetMinecraftOST. [ $+ [ %id ] ])) { inc %id }
  %link. [ $+ [ %id ] ] = $1-
  %title. [ $+ [ %id ] ] = $2-
  sockopen GetMinecraftOST. [ $+ [ %id ] ] c418.bandcamp.com 80
}
on *:SOCKOPEN:GetMinecraftOST.*: {
  echo -tg Connecting.
  sockwrite -nt $sockname GET %link. [ $+ [ $gettok($sockname,2,46) ] ] HTTP/1.1
  sockwrite -nt $sockname Host: c418.bandcamp.com
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:GetMinecraftOST.*: {
  if ($sockerr) {
    msg %chan Socket Error: $sockname $+ . Error code: $sockerr Please inform $me of this error message.
    halt
  }
  else {
    var %sockreader
    sockread %sockreader
    if (*stream : "*",* iswm %sockreader) {
      inc %t
      noop $regex(%sockreader,/"(.*?)"/Si)
      var %tempvar $regml(1)
      write test.txt $+(%t,.,_,C418_-_,$replace(%title. [ $+ [ $gettok($sockname,2,46) ] ],$chr(32),_),.mp3) $remove(%tempvar,http://)
      sockclose $sockname
    }
  }
}
alias mudlf2 {
  if (!$1) { echo -tg You must tell me what file to download! | halt }
  if (!$dialog(MURK.Update)) { dialog -md MURK.Update MURK.Update }
  inc %murk.update.files
  inc %murk.update.files.total
  %dn = MURK.Update
  did -ra %dn 2 Total Files: %murk.update.files.total
  did -ra %dn 3 Files Remaining: $calc(%murk.update.files.total - %murk.update.files.done)
  did -c MURK.Update 6 $did(MURK.Update,6).lines
  did -u MURK.Update 6 $did(MURK.Update,6).lines
  var %sckid 1
  while ($sock(MURKDownload2. [ $+ [ %sckid ] ])) {
    inc %sckid
  }
  %murk.host. [ $+ [ %sckid ] ] = $gettok($3,2,47) 
  %murk.file. [ $+ [ %sckid ] ] = $gettok($3,3-,47)
  %save.as. [ $+ [ %sckid ] ] = $+(C418 -,$chr(32),$replace($2,_,$chr(32)),.mp3)
  %murk.savein. [ $+ [ %sckid ] ] = $1
  if (*MURK.mrc* iswm $2-) { 
    if (!$isdir(MURK\script\Backups)) { mkdir MURK\script\Backups }
    if (!$isdir($+(MURK\script\Backups\,$murk.build))) { mkdir $+(MURK\script\Backups\,$murk.build) }
    if ($exists($+(MURK\script\Backups\,$murk.build,\MURK.mrc))) { .remove $+(MURK\script\Backups\,$murk.build,\MURK.mrc) }
    .copy MURK\Script\MURK.mrc $+(MURK\script\Backups\,$murk.build,\MURK.mrc)
    ;murkc Backup created as $+(MURK\script\Backups\,$murk.build,\MURK.mrc)
  }
  ;if ($exists(MURK\ $+ %murk.savein. [ $+ [ %sckid ] ] $+ $gettok(%murk.file. [ $+ [ %sckid ] ],-1,$asc(/)))) { .remove $+(MURK\,%murk.savein. [ $+ [ %sckid ] ],$gettok(%murk.file. [ $+ [ %sckid ] ],-1,$asc(/))) }
  sockopen MURKDownload2. [ $+ [ %sckid ] ] %murk.host. [ $+ [ %sckid ] ] 80
}

on *:SOCKOPEN:MURKDownload2.*: {
  did -a MURK.Update 6 Downloading: %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] - 0%
  sockwrite -nt $sockname GET $+(/,%murk.file. [ $+ [ $gettok($sockname,2,46) ] ]) HTTP/1.1
  sockwrite -nt $sockname Host: %murk.host. [ $+ [ $gettok($sockname,2,46) ] ]
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:MURKDownload2.*: {
  if ($sockerr) {
    echo -tg Socket Error: $sockname $+ . Error code: $sockerr Please inform iPeer of this error message.
    murk.displaywind @murk.updateerror $sockname \ $sockerr
    halt
  }
  else {
    var %sockreader
    if (!%murk.header. [ $+ [ $gettok($sockname,2,46) ] ]) sockread %sockreader
    if (HTTP* iswmcs %sockreader && *200* !iswm %sockreader) {
      echo -tg did -o MURK.Update 6 $gettok($sockname,2,46) %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] $+($gettok(%sockreader,2,32),'d)
      did -c MURK.Update 6 $did(MURK.Update,6).lines
      did -u MURK.Update 6 $did(MURK.Update,6).lines
      dec %murk.update.files.total
      did -ra %dn 2 Total Files: %murk.update.files.total
      unset %murk.*. [ $+ [ $gettok($sockname,2,46) ] ]
      sockclose $sockname
      halt
    }
    while (%sockreader != $null && !%murk.header. [ $+ [ $gettok($sockname,2,46) ] ]) {
      if (Content-Length:* iswm %sockreader) { %murk.filesize. [ $+ [ $gettok($sockname,2,46) ] ] = $gettok(%sockreader,2,32) }
      sockread %sockreader
    } 
    sockmark $sockname %murk.filesize. [ $+ [ $gettok($sockname,2,46) ] ]
    if (!%murk.header. [ $+ [ $gettok($sockname,2,46) ] ]) { murkc Downloading %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] - $bytes($sock($sockname).mark).suf }
    set %murk.header. [ $+ [ $gettok($sockname,2,46) ] ] 1
    if (!$isdir(MURK\ $+ %murk.savein. [ $+ [ $gettok($sockname,2,46) ] ])) { mkdir MURK\ $+ $+ %murk.savein. [ $+ [ $gettok($sockname,2,46) ] ] }
    sockread &murk.file. [ $+ [ $gettok($sockname,2,46) ] ]
    var %file. [ $+ [ $gettok($sockname,2,46) ] ] $gettok(%murk.file. [ $+ [ $gettok($sockname,2,46) ] ],-1,$asc(/))
    ;echo -tg %save.as. [ $+ [ $gettok($sockname,2,46) ] ]
    bwrite $qt(MURK\  $+ %murk.savein. [ $+ [ $gettok($sockname,2,46) ] ] $+ %save.as. [ $+ [ $gettok($sockname,2,46) ] ]) -1 -1 &murk.file. [ $+ [ $gettok($sockname,2,46) ] ]
    ;murkc %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] \ %file. [ $+ [ $gettok($sockname,2,46) ] ] \ $gettok($sockname,2,46) \ $sock($sockname).mark \ $lof($qt(MURK\ $+ %murk.savein. [ $+ [ $gettok($sockname,2,46) ] ] $+ $gettok(%murk.file. [ $+ [ $gettok($sockname,2,46) ] ],-1,$asc(/))))
    did -o MURK.Update 6 $gettok($sockname,2,46) Downloading: %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] - $round($calc($lof($qt($+(MURK\,%murk.savein. [ $+ [ $gettok($sockname,2,46) ] ],%file. [ $+ [ $gettok($sockname,2,46) ] ]))) / $sock($sockname).mark * 100),0)) $+ %
    if ($lof($qt($+(MURK\,%murk.savein. [ $+ [ $gettok($sockname,2,46) ] ],%save.as. [ $+ [ $gettok($sockname,2,46) ] ]))) >= $sock($sockname).mark) {
      inc %murk.update.files.done
      did -ra MURK.Update 3 Files Remaining: $calc(%murk.update.files.total - %murk.update.files.done)
      did -ra MURK.Update 4 Files Complete: %murk.update.files.done
      did -o MURK.Update 6 $gettok($sockname,2,46) Download Complete: %murk.file. [ $+ [ $gettok($sockname,2,46) ] ]
      did -c MURK.Update 6 $did(MURK.Update,6).lines
      did -u MURK.Update 6 $did(MURK.Update,6).lines
      unset %murk.*. [ $+ [ $gettok($sockname,2,46) ] ]
      sockclose $sockname
      if ($sock(MURKDownload2.*,0) < 1) {
        unset %murk.update.files.* 
        did -a MURK.Update 6 Update Complete! :)
        ;murk.displaywind @murk.updated
        did -c MURK.Update 6 $did(MURK.Update,6).lines
        did -u MURK.Update 6 $did(MURK.Update,6).lines
        did -ra MURK.Update 5 Update Complete. Click to close.
        ;.reload -rs $qt($script)
        ;murk.loaditems
      }
    }
  }
}
