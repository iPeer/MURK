; ******************************************************************************
; *  MURK has been written & tested on mIRC versions 7.15, 7.16b, 7.17 & 7.19  *
; ******************************************************************************
menu * {
  MURK Hub: {
    if (!$dialog(MURK.Hub)) { dialog -md MURK.Hub MURK.Hub }
    else { dialog -ve MURK.Hub }
  }
}

on *:start:{
  if ($player.option(AutoUpdate)) { .timerMURKAutoUpdate 0 1800 murk.read.roll }
}

on *:load:{
  if (!$isdir(MURK\save)) mkdir MURK\save
  murk.read.roll
}

alias murk.version {
  return $murk.build
}

alias murk.build {
  var %murk.build 1.0.91
  if ($isid) { return %murk.build }
  elseif ($window(@MURK)) { echo -tg @MURK %murk.build }
}

alias murk.status { 
  var %murk.status Alpha
  if ($isid) { return %murk.status }
  elseif ($window(@MURK)) { echo -tg @MURK %murk.status }
}

alias -l murk.savedump {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %item 1
  if ($exists(MURK\Temp\SaveDump.txt)) { remove MURK\Temp\SaveDump.txt }
  if (!$isdir(MURK\Temp)) { mkdir MURK\Temp }
  write MURK\Temp\SaveDump.txt ---------------- DUMPING SAVEFILE ----------------
  murkc Dumping savefile, please wait...
  %start.time = $ctime
  while ($hget(MURK.Player,%item).item) {
    write MURK\Temp\SaveDump.txt - $hget(MURK.Player,%item).item -
    write MURK\Temp\SaveDump.txt $replace($hget(MURK.Player,$hget(MURK.Player,%item).item),$hget(MURK.Player,PassPhrase),$str(*,$len($hget(MURK.Player,PassPhrase))))
    inc %item
  }
  %finish.time = $ctime
  murkc Done dumping save file, see $mircdirMURK\Temp\SaveDump.txt for output. ( $+ $duration($calc(%murk.finish.time - %murk.start.time),3) $+ )
  unset %murk.*.time %item
  write MURK\Temp\SaveDump.txt ---------------- FINISHED DUMPING SAVEFILE ----------------
}
alias murk.about {
  murk.displaywind @murk.murkabout
}
alias murkc {
  if ($isid) { return $iif($window(@MURK),1,0) }
  elseif ($window(@MURK)) { echo -tg @MURK $1- }
  if ($lof(MURK\script\Console.log) >= 10485760) {
    var %f 1
    while ($exists($+(MURK\script\Console-10MB-,%f,.log))) { inc %f }
    .copy MURK\script\Console.log $+(MURK\script\Console-10MB-,%f,.log)
    .remove MURK\script\Console.log
  }
  if (!$isid && $1- != MURK is currently running with the latest version.) { write MURK\script\Console.log $1- }
}

alias -l murk.levelcap {
  ; This number should always be EQUAL to the level cap. Not CAP+1. Script uses < [cap]
  $iif($isid,return,murkc) 110
}

alias F6 {
  if ($murk.player) { 
    murk.save Q
  }
}

alias -l murk.player {
  var %murk.player $hget(MURK.Player,Name)
  if ($isid) return $iif(%murk.player,$v1,0)
  else murkc $iif(%murk.player,$v1,No player.)
}

alias -l player.challenge {
  var %murk.challenge $iif($hget(MURK.Player,$replace($1,$chr(32),-)),$v1,0)
  $iif($isid,return,murkc) %murk.challenge
}

alias -l player.levelat {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.exp 0, %mx 0, %level = $calc($1 - 1)
  while (%mx <= %level) {
    var %txp $calc($floor($calc(%mx + 300 * 2 ^ (%mx / 8))) / 5) 
    inc %murk.exp %txp
    inc %mx
  }
  if ($isid) return $int(%murk.exp)
  else murkc $int(%murk.exp)
}

alias -l player.weapon {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.weapon $iif($hget(MURK.Player,Weapon),$v1,Hands)
  if ($isid) return %murk.weapon
  else murkc %murk.weapon
}

alias -l player.weaponbase {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.weaponid $iif($iif($player.weapon != Hands,$readini(MURK\data\Item.ini,$murk.getitemidbyname($player.weapon),Base),Hands),$v1,$iif($hget(MURK.Player,weapon),$v1,None))
  var %murk.weapon $iif(%murk.weaponid isnum,$readini(MURK\data\Item.ini,%murk.weaponid,Name),%murk.weaponid)
  if ($isid) return %murk.weapon
  else murkc %murk.weapon
}

alias -l player.weaponhp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %weaphp $iif($hget(MURK.Player,$replace($player.weaponbase,$chr(32),-)) > 0,$v1,0)
  $iif($isid,return,murkc) %weaphp
}

alias -l player.weaponbasehp {
  var %basehp $iif($readini(MURK\data\Weapon.ini,$replace($player.weaponbase,$chr(32),-),HP),$v1,0)
  $iif($isid,return,murkc) %basehp
}

alias -l player.legshp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %legshp $iif($hget(MURK.Player,$replace($player.legsbase,$chr(32),-)) > 0,$v1,0)
  $iif($isid,return,murkc) %legshp
}

alias -l player.legsbasehp {
  var %basehp $iif($readini(MURK\data\Legs.ini,$replace($player.legsbase,$chr(32),-),HP),$v1,0)
  $iif($isid,return,murkc) %basehp
}

alias -l player.armourhp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %armourhp $iif($hget(MURK.Player,$replace($player.armourbase,$chr(32),-)) > 0,$v1,0)
  $iif($isid,return,murkc) %armourhp
}

alias -l player.armourbasehp {
  var %basehp $iif($readini(MURK\data\Armour.ini,$replace($player.armourbase,$chr(32),-),HP),$v1,0)
  $iif($isid,return,murkc) %basehp
}

alias -l player.shieldbasehp {
  var %basehp $iif($readini(MURK\data\Shield.ini,$replace($player.shieldbase,$chr(32),-),HP),$v1,0)
  $iif($isid,return,murkc) %basehp
}

alias -l player.shieldhp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %shieldhp $iif($hget(MURK.Player,$replace($player.shieldbase,$chr(32),-)) > 0,$v1,0)
  $iif($isid,return,murkc) %shieldhp
}

alias -l player.rares {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %rares $iif($hget(MURK.Player,RaresFound),$v1,0)
  $iif($isid,return,murkc) %rares
}

alias -l player.mods {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %mods $iif($hget(MURK.Player,ModsApplied),$v1,0)
  $iif($isid,return,murkc) %mods
}

alias -l player.armour {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.armour $iif($hget(MURK.Player,Armour),$v1,None)
  if ($isid) return %murk.armour
  else murkc %murk.armour
}

alias -l player.armourbase {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.armourid $iif($readini(MURK\data\Item.ini,$murk.getitemidbyname($player.armour),Base),$v1,$iif($hget(MURK.Player,armour),$v1,None))
  var %murk.armour $iif(%murk.armourid isnum,$readini(MURK\data\Item.ini,%murk.armourid,Name),%murk.armourid)
  if ($isid) return %murk.armour
  else murkc %murk.armour
}

alias -l player.failedsteals {
  var %steals $hget(MURK.Player,StealsFailed)
  $iif($isid,return,murkc) $iif(%steals,$v1,0)
}

alias -l player.stealsuccess {
  var %steals $hget(MURK.Player,StealsSuccess)
  $iif($isid,return,murkc) $iif(%steals,$v1,0)
}

alias -l player.degradeitems {
  var %type $1, %damage $floor($2), %weapon $player.weaponbase, %armour $player.armourbase, %shield $player.shieldbase, %legs $player.legsbase
  if (%type == weapon && $player.weaponbasehp) {
    var %weaponhp $player.weaponhp
    var %weaponnewhp $calc(%weaponhp - %damage)
    murkc WHP: %weaponhp \ %weaponnewhp
    if (!$hget(MURK.Player,10PWC) && %weaponnewhp <= $calc($player.weaponbasehp * .10)) { murk.displaywind @murk.repairitem | hadd -m MURK.Player 10PWC 1 }
    hadd -m MURK.Player $replace(%weapon,$chr(32),-) $floor(%weaponnewhp)
    murkc Weapon hp is now $player.weaponhp
  }
  elseif (%type == armour && $player.armourbasehp) {
    var %armourhp $player.armourhp
    var %armournewhp $calc(%armourhp - %damage)
    if (!$hget(MURK.Player,10PAC) && %armournewhp <= $calc($player.armourbasehp * .10)) { murk.displaywind @murk.repairitem | hadd -m MURK.Player 10PAC 1 }
    hadd -m MURK.Player $replace(%armour,$chr(32),-) %armournewhp
    murkc Armour hp is now $player.armourhp
    if ($player.shieldbasehp) {
      var %shieldhp $player.shieldhp
      var %shieldnewhp $calc(%shieldhp - %damage)
      if (!$hget(MURK.Player,10PSC) && %shieldnewhp <= $calc($player.shieldbasehp * .10)) { murk.displaywind @murk.repairitem | hadd -m MURK.Player 10PSC 1 }
      hadd -m MURK.Player $replace(%shield,$chr(32),-) %shieldnewhp
      murkc Shield hp is now $player.shieldhp
    }
    if ($player.legsbasehp) {
      var %legshp $player.legshp
      var %legsnewhp $calc(%legshp - %damage)
      if (!$hget(MURK.Player,10PLC) && %legsnewhp <= $calc($player.legsbasehp * .10)) { murk.displaywind @murk.repairitem | hadd -m MURK.Player 10PLC 1 }
      hadd -m MURK.Player $replace(%legs,$chr(32),-) %legsnewhp
      murkc Legs hp is now $player.legshp
    }
  }
}

alias -l player.repairitem {
  if ($1 == weapon) {
    var %cost $readini(MURK\data\Weapon.ini,$replace($player.weaponbase,$chr(32),-),COST) 
    player.removeitem 1 %cost
    hdel MURK.Player $replace($player.weaponbase,$chr(32),-)
    hdel MURK.Player 10PWC
    if ($player.weapon != Hands) { player.equipitem $murk.getitemidbyname($player.weapon) }
    else hadd MURK.Player Weapon Hands
  }
  elseif ($1 == armour) {
    var %cost $readini(MURK\data\Armour.ini,$replace($player.armourbase,$chr(32),-),COST) 
    player.removeitem 1 %cost
    hdel MURK.Player $replace($player.armourbase,$chr(32),-)
    hdel MURK.Player 10PAC
    if ($player.armour != Normal Clothes) { player.equipitem $murk.getitemidbyname($player.armour) }
    else hadd MURK.Player Armour Normal Clothes
  }
  elseif ($1 == shield) {
    var %cost $readini(MURK\data\Shield.ini,$replace($player.shieldbase,$chr(32),-),COST) 
    player.removeitem 1 %cost
    hdel MURK.Player $replace($player.shieldbase,$chr(32),-)
    hdel MURK.Player 10PSC
    if ($player.shield != None) { player.equipitem $murk.getitemidbyname($player.shield) }
    else hadd MURK.Player Shield None
  }
  elseif ($1 == legs) {
    var %cost $readini(MURK\data\Legs.ini,$replace($player.legsbase,$chr(32),-),COST) 
    player.removeitem 1 %cost
    hdel MURK.Player $replace($player.legsbase,$chr(32),-)
    hdel MURK.Player 10PLC
    if ($player.legs != Flares) { player.equipitem $murk.getitemidbyname($player.legs) }
    else hadd MURK.Player Legs Flares
  }
}

alias -l player.shield {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.shield $iif($hget(MURK.Player,Shield),$v1,None)
  if ($isid) return %murk.shield
  else murkc %murk.shield
}

alias -l player.shieldbase {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.shieldid $iif($iif($player.shield != None,$readini(MURK\data\Item.ini,$murk.getitemidbyname($player.shield),Base),None),$v1,$iif($hget(MURK.Player,shield),$v1,None))
  var %murk.shield $iif(%murk.shieldid isnum,$readini(MURK\data\Item.ini,%murk.shieldid,Name),%murk.shieldid)
  if ($isid) return %murk.shield
  else murkc %murk.shield
}

alias -l player.legs {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.Legs $iif($hget(MURK.Player,Legs),$v1,Flares)
  if ($isid) return %murk.legs
  else murkc %murk.legs
}

alias -l player.legsbase {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.legsid $iif($iif($player.legs != Flares,$readini(MURK\data\Item.ini,$murk.getitemidbyname($player.legs),Base),Flares),$v1,$iif($hget(MURK.Player,legs),$v1,Flares))
  var %murk.legs $iif(%murk.legsid isnum,$readini(MURK\data\Item.ini,%murk.legsid,Name),%murk.legsid)
  if ($isid) return %murk.legs
  else murkc %murk.legs
}

alias -l player.equipitem {
  murkc EI: $1-
  var %t = $readini(MURK\data\Item.ini,$1,Type)
  if (%t == W) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Weapon %name
    hadd MURK.Player MaxDam $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MaxDam)
    hadd MURK.Player MinDam $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MinDam)
    if ($1 == 47 && $player.shield != None) { 
      player.unequipitem $murk.getitemidbyname($player.shield)
      murk.displaywind @murk.forcedunequip shield
      if ($dialog(MURK.Armoury)) { dialog -x MURK.Armoury | dialog -md MURK.Armoury MURK.Armoury } 
    }
    if ($hget(MURK.Player,$replace($player.weaponbase,$chr(32),-)) == $null && $player.weaponbasehp) { murkc Adding Weapon's HP entry... | hadd MURK.Player $replace($player.weaponbase,$chr(32),-) $player.weaponbasehp }
  }
  elseif (%t == A) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Armour %name
    hadd -m MURK.Player AP $calc($player.ap + $readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),APBoost))
    hadd -m MURK.Player CHP $calc($player.chp + $iif($readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player HP $calc($player.hp + $iif($readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player CC $calc($player.cc + $iif($readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),CCBoost),$v1,0)))
    if (*Suit* iswm %name && $player.legs != Flares) { 
      player.unequipitem $murk.getitemidbyname($player.legs)
      murk.displaywind @murk.forcedunequip legs
      if ($dialog(MURK.Armoury)) { dialog -x MURK.Armoury | dialog -md MURK.Armoury MURK.Armoury } 
    }
    if ($hget(MURK.Player,$replace($player.armourbase,$chr(32),-)) == $null && $player.armourbasehp) { hadd MURK.Player $replace(%name,$chr(32),-) $player.armourbasehp }
  }
  elseif (%t == L) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Legs %name
    hadd -m MURK.Player AP $calc($player.ap + $readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),APBoost))
    hadd -m MURK.Player CHP $calc($player.chp + $iif($readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player HP $calc($player.hp + $iif($readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player CC $calc($player.cc + $iif($readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),CCBoost),$v1,0)))
    if (*Suit* iswm $player.armour) { 
      player.unequipitem $murk.getitemidbyname($player.armour)
      murk.displaywind @murk.forcedunequip armour
      if ($dialog(MURK.Armoury)) { dialog -x MURK.Armoury | dialog -md MURK.Armoury MURK.Armoury } 
    }
    if ($hget(MURK.Player,$replace($player.legsbase,$chr(32),-)) == $null && $player.legsbasehp) { hadd MURK.Player $replace(%name,$chr(32),-) $player.legsbasehp }
  }
  elseif (%t == S) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Shield %name
    if ($player.weapon == 50-50) { 
      player.unequipitem $murk.getitemidbyname($player.weapon)
      murk.displaywind @murk.forcedunequip weapon
      if ($dialog(MURK.Armoury)) { dialog -x MURK.Armoury | dialog -md MURK.Armoury MURK.Armoury } 
    }
    hadd -m MURK.Player AP $calc($player.ap + $readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),APBoost))
    hadd -m MURK.Player CHP $calc($player.chp + $iif($readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player HP $calc($player.hp + $iif($readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player CC $calc($player.cc + $iif($readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),CCBoost),$v1,0)))
    if ($hget(MURK.Player,$replace($player.shieldbase,$chr(32),-)) == $null && $player.shieldbasehp) { hadd MURK.Player $replace(%name,$chr(32),-) $player.shieldbasehp }
  }
  else {
    if (!$dialog(MURK.Armoury)) { murkc Invalid Weapon, Armour, Legs or Shield ID. }
  }
}

alias -l player.unequipitem {
  murkc UEI: $1-
  var %t = $readini(MURK\data\Item.ini,$1,Type)
  if (%t == W) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Weapon Hands
    hadd MURK.Player MaxDam $readini(MURK\data\Weapon.ini,Hands,MaxDam)
    hadd MURK.Player MinDam $readini(MURK\data\Weapon.ini,Hands,MinDam)
  }
  elseif (%t == A) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Armour Normal Clothes
    hadd -m MURK.Player AP $calc($player.ap - $readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),APBoost))
    hadd -m MURK.Player CHP $calc($player.chp - $iif($readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player HP $calc($player.hp - $iif($readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player CC $calc($player.cc - $iif($readini(MURK\data\Armour.ini,$replace(%name,$chr(32),-),CCBoost),$v1,0)))
  }
  elseif (%t == L) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Legs Flares
    hadd -m MURK.Player AP $calc($player.ap - $readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),APBoost))
    hadd -m MURK.Player CHP $calc($player.chp - $iif($readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player HP $calc($player.hp - $iif($readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player CC $calc($player.cc - $iif($readini(MURK\data\Legs.ini,$replace(%name,$chr(32),-),CCBoost),$v1,0)))
  }
  elseif (%t == S) {
    var %name $readini(MURK\data\Item.ini,$1,Name)
    hadd -m MURK.Player Shield None
    hadd -m MURK.Player AP $calc($player.ap - $readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),APBoost))
    hadd -m MURK.Player CHP $calc($player.chp - $iif($readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player HP $calc($player.hp - $iif($readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),HPBoost),$v1,0))
    hadd -m MURK.Player CC $calc($player.cc - $iif($readini(MURK\data\Shield.ini,$replace(%name,$chr(32),-),CCBoost),$v1,0)))
  }
  else {
  if (!$dialog(MURK.Armoury)) { murkc Invalid Weapon, Armour, Legs or Shield ID. }  }
}

alias -l murk.start {
  if ($hget(MURK.Player).size) {
    murk.displaywind @murk.startconfirm
    haltd
  }
  var %murk.charname $input(Name Input,e,What's your name?)
  if (!%murk.charname) { murkc We can't start a game without a character name... | murk.displaywind @murk.noname | halt }
  close -@ @murk.*
  murkc Starting new game with player name $qt($replace(%murk.charname,$chr(32),-))
  murkc Creating Player data...
  hadd -m MURK.Player Name $replace(%murk.charname,$chr(32),-)
  hadd -m MURK.Player HP $readini(MURK\data\Player.ini,Player,HP)
  hadd -m MURK.Player XP $readini(MURK\data\Player.ini,Player,XP)
  hadd -m MURK.Player AP $readini(MURK\data\Player.ini,Player,AP)
  hadd -m MURK.Player LVL $readini(MURK\data\Player.ini,Player,LVL)
  hadd -m MURK.Player Coords 1,1
  .timerMURKMovePlayer 0 300 murk.moveplayer
  murk.moveplayer
  murkc Processing Player Creation commands...
  ;$readini(MURK\data\Player.ini,Player,COM)
  murkc Passed commands.
  ;if ($dialog(MURK.Hub)) { murk.populatehub }
  murk.genmap normal
  murk.displayvendor
  murk.hubupdatevendor
  if (%c) unset %c
  var %c 1
  while ($gettok($readini(MURK\data\Player.ini,Player,COM),%c,44)) {
    $gettok($readini(MURK\data\Player.ini,Player,COM),%c,44)
    inc %c
  }
}

alias -l murk.moveplayer {
  if (!$exists($+(MURK\Players\,$hget(MURK.Player,SaveName),\map.bmp))) {
    if ($exists(MURK\Players\map.bmp)) {
      if (!$isdir(MURK\Players)) { mkdir MURK\Players }
      if (!$isdir(MURK\Players\ $+ $hget(MURK.Player,SaveName))) { mkdir MURK\Players\ $+ $hget(MURK.Player,SaveName) }
      .copy MURK\Players\map.bmp $+(MURK\Players\,$hget(MURK.Player,SaveName),\map.bmp)
      .remove MURK\Players\map.bmp
    }
    else {
      murk.displaywind @murk.nomap
      halt
    }
  }
  var %player.x $gettok($hget(MURK.Player,Coords),1,44), %player.y $gettok($hget(MURK.Player,Coords),2,44)
  var %new.playerx $calc(%player.x $iif($r(1,2) == 1,+,-) $r(0,5)), %new.playery $calc(%player.y $iif($r(3,4) == 3,+,-) $r(0,5))
  murkc New player coords: $+(%new.playerx,$chr(44),%new.playery)
  if (%new.playerx < 1) %new.playerx = $remove(%new.playerx,-)
  if (%new.playery < 1) %new.playery = $remove(%new.playery,-)
  if (%new.playerx == 0) inc %new.playerx $r(1,5)
  if (%new.playery == 0) inc %new.playery $r(1,5)
  murkc Player moved to $+(%new.playerx,$chr(44),%new.playery)
  hadd -m MURK.Player Coords $+(%new.playerx,$chr(44),%new.playery)
  var %attackchance 30
  if ($player.checkquant(9,1)) { inc %attackchance 15 }
  if ($player.armour == Stealth Suit mk. II) { dec %attackchance $readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),MCBoost) }
  if ($player.armour == Stealth Suit) { dec %attackchance $readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),MCBoost) }
  if ($player.armour == High Visibility Armour) { inc %attackchance $readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),MCBoost) }
  var %challengeplayer $iif($r(1,100) <= %attackchance,1,0)
  if (%challengeplayer) {
    murkc Player will be challenged.
    if ($murk.checkformonster(%new.playerx,%new.playery)) { 
      if ($r(1,1000) == 1) { murk.displaywind @murk.monsterbosschallenge }
      else { murk.displaywind @murk.monsterchallenge  }
    }
  }
  var %playerfinditemchance 20
  if ($player.checkquant(54,1)) { inc %playerfinditemchance 25 }
  var %itemchance $r(1,100)
  murkc Chance to find item: %playerfinditemchance \ %itemchance
  var %playerfinditem $iif(%itemchance <= %playerfinditemchance,1,0)
  if (%playerfinditem && !%challengeplayer) {
    murkc Player will find an item.
    murk.giveplayeritem
  }

}

alias -l murk.giveplayeritem {
  var %l 0, %t $ini(MURK\data\Item.ini,0)
  while (%l < %t) {
    inc %l
    if (!$readini(MURK\data\Item.ini,%l,IsRare)) {
      %murk.possibleitems = %murk.possibleitems %l
    }
  }
  murkc Possible items: %murk.possibleitems
  var %murk.awarditemid $r(1,$numtok(%murk.possibleitems,32))
  var %murk.awarditem $gettok(%murk.possibleitems,%murk.awarditemid,32)
  murkc Awarded item: %murk.awarditem
  player.additem %murk.awarditem 1
  hadd MURK.Player ItemsFound $calc($player.itemsfound + 1)
  murk.displaywind @murk.founditem $readini(MURK\data\Item.ini,%murk.awarditem,Name)
  unset %murk.awarditem %l %t %murk.possibleitems
  murk.save A
}

alias -l player.itemsfound {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %finds $iif($hget(MURK.Player,ItemsFound),$v1,0)
  $iif($isid,return,murkc) %finds
}

alias -l player.weight {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %w $iif($hget(MURK.Player,Weight),$v1,0)
  $iif($isid,return,murkc) %w
}

alias -l player.maxweight {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %w $iif(!$player.hasperk(Mass Haulage),250,300)
  $iif($isid,return,murkc) %w
}

alias -l player.hasperk { 
  return 0 
}

alias -l player.level {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.lvl $hget(MURK.Player,LVL)
  if ($isid) return %murk.lvl
  else murkc %murk.lvl
}

alias -l player.hp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.HP $hget(MURK.Player,HP)
  if ($isid) return %murk.HP
  else murkc %murk.HP
}

alias -l player.chp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.HP $iif($hget(MURK.Player,CHP),$v1,0)
  if ($isid) return %murk.HP
  else murkc %murk.HP
}

alias -l player.mhp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.HP $iif($hget(MURK.Player,Monster.HP),$v1,0)
  if ($isid) return %murk.HP
  else murkc %murk.HP
}

alias -l player.useaid {
  if ($qt($1-) isin $hget(MURK.Items,Aid) && $player.checkquant($murk.getitemidbyname($1-),1)) {
    var %itemname $replace($1-,$chr(32),-)
    murkc Using Aid %itemname
    if ($player.chp == $player.hp) { murk.displaywind itemnotify You're already at full health! :) | halt }
    var %hp $iif($readini(MURK\data\Aid.ini,%itemname,HP),$v1,0),%cc $iif($readini(MURK\data\Aid.ini,%itemname,CC),$v1,0), %ap $iif($readini(MURK\data\Aid.ini,%itemname,AP),$v1,0)
    %playernewhp = $calc($player.chp + %hp)
    if (%playernewhp > $player.hp) %playernewhp = $player.hp
    %playernewcc = $calc($player.cc + %cc)
    %playernewap = $calc($player.ap + %ap)
    murkc New Values: %playernewhp \ %playernewap \ %playernewcc
    hadd -m MURK.Player CHP %playernewhp
    hadd -m MURK.Player AP %playernewap
    hadd -m MURK.Player CC %playernewcc
    if ($dialog(MURK.Hub)) { did -ra MURK.Hub 12 Current HP: $+($player.chp,/,$player.hp) }
    if ($dialog(MURK.Fight)) { did -ra MURK.Fight 2 HP: $player.chp ( $+ $player.hp $+ ) }
    player.removeitem $murk.getitemidbyname($1-) 1  
  }
  else {
    murkc Invalid Aid item.
  }
}

alias -l player.wins {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.w $hget(MURK.Player,Wins)
  if ($isid) return %murk.w
  else murkc %murk.w
}

alias -l player.loses {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.l $hget(MURK.Player,Loses)
  if ($isid) return %murk.l
  else murkc %murk.l
}

alias -l player.exp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.exp $hget(MURK.Player,XP)
  if ($isid) return %murk.exp
  murkc %murk.exp
}

alias -l player.ap {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.ap $hget(MURK.Player,AP)
  if ($isid) return %murk.ap
  murkc %murk.ap
}

alias -l player.cc {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.cc $iif($hget(MURK.Player,CC),$v1,1)
  if ($isid) return %murk.cc
  murkc %murk.cc
}

alias -l player.checkquant {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if ($2 !isnum && $2 != return) { murkc Error: You must specifiy an ItemID and how many the player must have to pass player.checkquant ItemID Quant | halt }    ; - If the player isn't using the most recent inventory format... update it...
  if (@ !isin $hget(MURK.Player,Inventory)) { murkc Player isn't using most recent inventory format, updating it... | hadd MURK.Player Inventory $replace($hget(MURK.Player,Inventory),$chr(124),@) }

  if ($1 == 1) {
    if ($hget(MURK.Player,Coins) == $null) {
      noop $regex(%inv,/Coins@(\d+)/)
      hadd MURK.Player Coins $regml(1)
      var %inv $hget(MURK.Player,Inventory), %re /(Coins@\d+\,?)/g
      hadd MURK.Player Inventory $regsubex(%inv,%re,)
      murkc Coins moved.
    }
    else {
      var %coins $hget(MURK.Player,Coins), %murk.itemquant $gettok($2,1,44)
      if ($2 == return) $iif($isid,return,murkc) %coins
      if (%coins >= %murk.itemquant) { $iif($isid,return $true,murkc Player has enough of that item to continue) }
      else { $iif($isid,return $false,murkc Player doesn't have enough of that item to continue) }
    }
  }
  else {
    if ($readini(MURK\data\Item.ini,$1,Name)) {
      var %murk.itemname $v1, %murk.itemquant $gettok($2,1,44), %murk.currentinventory $hget(MURK.Player,Inventory)
      ;murkc ItemID $1 = %murk.itemname
      noop $regex($hget(MURK.Player,Inventory),$($+(/,$iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),$replace(%murk.itemname,$chr(40),$+(\,$chr(40)),$chr(41),$+(\,$chr(41))),@,([0-9\.]+)/)))      
      var %murk.currentitem $regml(1)
      if ($2 == return) $iif($isid,return,murkc) %murk.currentitem
      if (%murk.currentitem >= %murk.itemquant) { $iif($isid,return $true,murkc Player has enough of that item to continue) }
      else { $iif($isid,return $false,murkc Player doesn't have enough of that item to continue) }
    }
    else {
      murkc Invalid ItemID.
    }
  }
}

alias -l player.addexp {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  var %murk.currentexp $iif($hget(MURK.Player,XP),$v1,0), %murk.addexp $1
  if (%murk.currentexp >= $player.levelat($murk.levelcap)) { murkc Player already has max exp. Halting. | halt }
  var %murk.newexp $calc(%murk.currentexp + %murk.addexp)
  murkc CurrentExp: %murk.currentexp ExpToAdd: %murk.addexp FinalExp: %murk.newexp LevelAt: $player.levelat($calc($player.level + 1))
  hadd -m MURK.Player XP %murk.newexp
  player.levelup
}

alias -l player.levelup {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if ($player.level >= $murk.levelcap) { murkc Player is already the max level. | halt }
  if ($calc($player.levelat($calc($player.level + 1)) - $player.exp) < 1) {
    var %murk.playerlevel $player.level, %murk.playerhp $player.hp, %murk.playerap $player.ap, %murk.critchance $player.cc, %murk.critupchance $iif($player.checkquant(5,1),501,251)
    murkc Chance of Crit Up: %murk.critupchance $+($chr(40),$calc((%murk.critupchance - 1) / 1000 *100),%,$chr(41))
    while ($calc($player.levelat($calc($player.level + 1)) - $player.exp) < 1) {
      if ($player.level < $murk.levelcap) {
        inc %murk.playerlevel 1
        inc %murk.playerhp 19
        inc %murk.playerap 1
        if ($r(0,1000) < %murk.critupchance) inc %murk.critchance
        hadd -m MURK.Player LVL %murk.playerlevel
        hadd -m MURK.Player HP %murk.playerhp
        hadd -m MURK.Player AP %murk.playerap
        hadd -m MURK.Player CC %murk.critchance
      }
      else {
        ; XP Correction
        hadd -m MURK.Player XP $player.levelat($murk.levelcap) 
        goto skiplevelup 
      }
    }
    :skiplevelup
    ;murkc OldLvl: $player.level NewLvl: %murk.playerlevel
    murkc New player.hp = %murk.playerhp
    murkc New player.ap = %murk.playerap
    murkc New player.cc = %murk.critchance
    murkc Player has leveled up to %murk.playerlevel $+ !
    murk.displaywind @murk.playerlevelup %murk.playerlevel
    murk.save A
  }
}
alias -l player.completequest {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if ($1 || $readini(MURK\data\Quest.ini,$1)) {
    var %murk.QuestId $1, %murk.QuestName $readini(MURK\data\Quest.ini,$1,Name), %murk.completequests $hget(MURK.Player,Quests), %HashName $readini(MURK\data\Quest.ini,$1,HashName)
    if (%murk.QuestName !isin %murk.completequests) {
      hadd -m MURK.Player Quests $+(%murk.completequests,$iif($len(%murk.completequests) > 1,$chr(44)),%murk.QuestName)
      murk.displaywind @murk.itemnotify Challenge Complete $qt(%murk.QuestName) $+ : $readini(MURK\data\Quest.ini,%murk.QuestId,Req)
      if (%HashName) { hadd MURK.Player %HashName 1 }
      if (%c) unset %c
      var %c 1
      while ($gettok($readini(MURK\data\Quest.ini,%murk.QuestId,COM),%c,44)) {
        $gettok($readini(MURK\data\Quest.ini,%murk.QuestId,COM),%c,44)
        inc %c
      }
      if ($dialog(MURK.Hub)) { murk.populatehub }
    }
    else {
      murkc Player has already completed QuestId %murk.QuestId $+ . Preventing exploit.
    }
  }
  else {
    murkc Invalid QuestID.
  }
}

alias -l player.additem {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if ($2 !isnum) { murkc Error: You must specifiy an ItemID and how many you want to add. player.additem ItemID Quant | halt }
  ; - If the player isn't using the most recent inventory format... update it...
  if (@ !isin $hget(MURK.Player,Inventory)) { murkc Player isn't using most recent inventory format, updating it... | hadd MURK.Player Inventory $replace($hget(MURK.Player,Inventory),$chr(124),@) }
  if (!$hget(MURK.Player,Weight)) { 
    murkc Player has no weight, applying item weights. 
    var %tok 1, %inventory $hget(MURK.Player,Inventory)
    while ($gettok(%inventory,%tok,44)) { 
      %token = $v1
      murkc %token
      hadd MURK.Player Weight $calc($player.weight + ( $gettok(%token,2,64) * $iif($readini(MURK\data\Item.ini,$murk.getitemidbyname($gettok(%token,1,64)),Weight),$v1,0)))
      inc %tok
    }
    murkc Weight updated.
  }
  if ($1 == 1) {
    if ($hget(MURK.Player,Coins) == $null && Coins@ isin $hget(MURK.Player,Inventory)) {
      noop $regex(%inv,/Coins@(\d+)/)
      hadd MURK.Player Coins $regml(1)
      var %inv $hget(MURK.Player,Inventory), %re /(Coins@\d+\,?)/g
      hadd MURK.Player Inventory $regsubex(%inv,%re,)
      murkc Coins moved.
    }
    else {
      hadd MURK.Player Coins $calc($hget(MURK.Player,Coins) + $2)
    }
  }
  else {
    if ($readini(MURK\data\Item.ini,$1,Name)) {
      var %murk.itemname $v1, %murk.itemquant $gettok($2,1,44), %murk.currentinventory $hget(MURK.Player,Inventory), %weight $iif($readini(MURK\data\Item.ini,$1,Weight),$v1,0)
      murkc ItemID $1 = %murk.itemname
      murkc Attempting to add %murk.itemname to player inventory...
      murkc $iif(%murk.currentinventory,Current player inventory = $v1,Player has no items.)
      if ($+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@) isin %murk.currentinventory) {
        noop $regex($hget(MURK.Player,Inventory),$($+(/,$replace(%murk.itemname,$chr(40),$+(\,$chr(40)),$chr(41),$+(\,$chr(41))),@,([0-9\.]+)/)))      
        var %murk.currentitem $regml(1)
        murkc %murk.itemname \ %murk.currentitem
        murkc Player already has $remove(%murk.itemname,@) $+ . Adding to their current collection
        hadd -m MURK.Player Inventory $replacecs($remove(%murk.currentinventory,$+(Reinforced,$chr(32),$chr(44))),$+(%murk.itemname,@,%murk.currentitem),$+(%murk.itemname,@,$gettok($calc(%murk.currentitem + %murk.itemquant),1,46)))
        murkc New inventory = $replacecs(%murk.currentinventory,$+(%murk.itemname,@,%murk.currentitem),$+(%murk.itemname,@,$gettok($calc(%murk.currentitem + %murk.itemquant),1,46)))
        player.updateweight + %murk.itemquant %weight
      }
      else {
        murkc Player doesn't have any of that ItemID. Attempting to add some...
        murkc ItemID: $1 ItemName: %murk.itemname ItemQuant: %murk.itemquant
        hadd MURK.Player Weight $calc($player.weight + ( %murk.itemquant * $iif($readini(MURK\data\Item.ini,$1,Weight),$v1,0)))
        %murk.currentinventory = $+(%murk.currentinventory,$iif($len(%murk.currentinventory) > 1,$chr(44)),%murk.itemname,@,%murk.itemquant)
        hadd -m MURK.Player Inventory %murk.currentinventory 
      }
      murkc %murk.itemquant %murk.itemname added.
      murkc Player weight is now $player.weight
      ;if ($dialog(MURK.Hub)) { murk.populatehub }
      ;murk.displaywind @murk.itemnotify $iif(%murk.itemquant > 1,$v1) %murk.itemname added
    }
    else {
      murkc Invalid ItemID.
    }
  }
}

alias -l player.removeitem {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if ($2 !isnum) { murkc Error: You must specifiy an ItemID and how many you want to add. player.removeitem ItemID Quant | halt }
  ; - If the player isn't using the most recent inventory format... update it...
  if (@ !isin $hget(MURK.Player,Inventory)) { murkc Player isn't using most recent inventory format, updating it... | hadd MURK.Player Inventory $replace($hget(MURK.Player,Inventory),$chr(124),@) }
  if ($1 == 1) {
    if ($hget(MURK.Player,Coins) == $null) {
      noop $regex(%inv,/Coins@(\d+)/)
      hadd MURK.Player Coins $regml(1)
      var %inv $hget(MURK.Player,Inventory), %re /(Coins@\d+\,?)/g
      hadd MURK.Player Inventory $regsubex(%inv,%re,)
      murkc Coins moved.
    }
    else {
      hadd MURK.Player Coins $calc($hget(MURK.Player,Coins) - $2)
    }
  }
  else {
    if ($readini(MURK\data\Item.ini,$1,Name)) {
      var %murk.itemname $v1, %murk.itemquant $gettok($2,1,44), %murk.currentinventory $hget(MURK.Player,Inventory), %weight $iif($readini(MURK\data\Item.ini,$1,Weight),$v1,0)
      murkc ItemID $1 = %murk.itemname
      if ($+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@) isin %murk.currentinventory) {
        murkc Player has item, continuing...
        noop $regex($hget(MURK.Player,Inventory),$($+(/,$iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),$replace(%murk.itemname,$chr(40),$+(\,$chr(40)),$chr(41),$+(\,$chr(41))),@,([0-9\.]+)/)))      
        var %murk.currentitem $regml(1)
        var %murk.newquant $calc(%murk.currentitem - %murk.itemquant)
        murkc Item: %murk.currentitem
        murkc New Item Quantity: %murk.newquant
        if (%murk.newquant < 1) {
          murkc Item quant is less than the player has. Removing from inventory list.
          murkc I: $+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem)
          %murk.currentinventory = $replace($remove(%murk.currentinventory,$+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem)),$+($chr(44),$chr(44)),$chr(44))
          murkc New Inventory = %murk.currentinventory
          hadd -m MURK.Player Inventory $iif($left(%murk.currentinventory,1) == $chr(44),$right(%murk.currentinventory,-1),$iif($right(%murk.currentinventory,1) == $chr(44),$left(%murk.currentinventory,-1),%murk.currentinventory))
          player.updateweight - %murk.itemquant %weight
        }
        else {
          murkc I: $+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem)
          %murk.currentinventory = $replace(%murk.currentinventory,$+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem),$+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.newquant))
          murkc New Inventory = %murk.currentinventory
          hadd -m MURK.Player Inventory $iif($left(%murk.currentinventory,1) == $chr(44),$right(%murk.currentinventory,-1),$iif($right(%murk.currentinventory,1) == $chr(44),$left(%murk.currentinventory,-1),%murk.currentinventory))
          hadd MURK.Player Weight $calc($player.weight - ( %murk.itemquant * $iif($readini(MURK\data\Item.ini,$1,Weight),$v1,0)))

        }
        murkc Player weight is now $player.weight
        ;murk.displaywind @murk.itemnotify $iif(%murk.itemquant > 1,$v1) %murk.itemname removed
        ;if ($dialog(MURK.Hub)) { murk.populatehub }
      }
      else {
        murkc Player doesn't have any of that item.
      }
    }
  }
}


alias -l player.updateweight { 
  hadd MURK.Player Weight $calc($player.weight $1 ( $2 * $3 ))
  if ($dialog(MURK.Hub)) { did -ra MURK.Hub 11 Weight: $player.weight $+ / $+ $player.maxweight }
  if ($player.weight > $player.maxweight) { murk.displaywind @murkoverweight }
  murkc Weight Updated.
}

alias -l player.chest {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if ($3 !isnum) { murkc Error: You must specifiy an ItemID and how many you want to add. player.chest mode ItemID Quant | halt }
  ; - If the player isn't using the most recent inventory format... update it...
  if (@ !isin $hget(MURK.Player,Inventory)) { murkc Player isn't using most recent inventory format, updating it... | hadd MURK.Player Inventory $replace($hget(MURK.Player,Inventory),$chr(124),@) }
  if (!$hget(MURK.Player,Weight)) { 
    murkc Player has no weight, applying item weights. 
    var %tok 1, %inventory $hget(MURK.Player,Inventory)
    while ($gettok(%inventory,%tok,44)) { 
      %token = $v1
      murkc %token
      hadd MURK.Player Weight $calc($player.weight + ( $gettok(%token,2,64) * $iif($readini(MURK\data\Item.ini,$murk.getitemidbyname($gettok(%token,1,64)),Weight),$v1,0)))
      inc %tok
    }
    murkc Weight updated.
  }
  if (!$hget(MURK.Chest).size) { hmake MURK.Chest 100 }
  if ($readini(MURK\data\Item.ini,$2,Name)) {
    var %murk.itemid $2, %murk.itemname $v1, %murk.itemquant $gettok($3,1,44), %murk.currentinventory $hget(MURK.Player,Inventory), %weight $iif($readini(MURK\data\Item.ini,$2,Weight),$v1,0), %player.chest $hget(MURK.Chest,Items)
    if ($1 == a) {
      murkc ItemID $2 = %murk.itemname
      murkc Adding %murk.itemid to the player's chest.
      ;murkc $iif(%murk.currentinventory,Current player inventory = $v1,Player has no items.)
      if ($player.checkquant(%murk.itemid,%murk.itemquant)) {
        if ($+($iif($numtok(%player.chest,44) > 1 && $gettok($gettok(%player.chest,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@) isin %player.chest) {
          noop $regex($hget(MURK.Player,Chest),$($+(/,$replace(%murk.itemname,$chr(40),$+(\,$chr(40)),$chr(41),$+(\,$chr(41))),@,([0-9\.]+)/)))      
          var %murk.currentitem $regml(1)
          murkc %murk.itemname \ %murk.currentitem
          murkc Player has $remove(%murk.itemname,@) $+ . Stored, updating item count.
          hadd -m MURK.Chest Items $replacecs($remove(%player.chest,$+(Reinforced,$chr(32),$chr(44))),$+(%murk.itemname,@,%murk.currentitem),$+(%murk.itemname,@,$gettok($calc(%murk.currentitem + %murk.itemquant),1,46)))
          murkc New inventory = $replacecs(%player.chest,$+(%murk.itemname,@,%murk.currentitem),$+(%murk.itemname,@,$gettok($calc(%murk.currentitem + %murk.itemquant),1,46)))
          hadd MURK.Player Weight $calc($player.weight - ( %murk.itemquant * %weight))
        }
        else {
          murkc Player doesn't have that stored in the chest.
          murkc ItemID: $1 ItemName: %murk.itemname ItemQuant: %murk.itemquant
          ; hadd MURK.Player Weight $calc($player.weight + ( %murk.itemquant * $iif($readini(MURK\data\Item.ini,$1,Weight),$v1,0)))
          %player.chest = $+(%player.chest,$iif($len(%player.chest) > 1,$chr(44)),%murk.itemname,@,%murk.itemquant)
          hadd -m MURK.Chest Items %player.chest
        }
        player.removeitem %murk.itemid %murk.itemquant
      }
      else {
        murkc Player has none of that item. 
      }
    }
    elseif ($1 == r) {
      if ($+($iif($numtok(%player.chest,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@) isin %player.chest) {
        murkc Player has item stored.
        noop $regex(%player.chest,$($+(/,$iif($numtok(%player.chest,44) > 1 && $gettok($gettok(%player.chest,1,64),1,44) != %murk.itemname,$chr(44)),$replace(%murk.itemname,$chr(40),$+(\,$chr(40)),$chr(41),$+(\,$chr(41))),@,([0-9\.]+)/)))      
        var %murk.currentitem $regml(1)
        var %murk.newquant $calc(%murk.currentitem - %murk.itemquant)
        murkc Item: %murk.currentitem
        murkc New Item Quantity: %murk.newquant
        if (%murk.newquant < 1) {
          murkc Item quant is less than the player has. Removing from inventory list.
          murkc I: $+($iif($numtok(%murk.currentinventory,44) > 1 && $gettok($gettok(%murk.currentinventory,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem)
          %player.chest = $replace($remove(%player.chest,$+($iif($numtok(%player.chest,44) > 1 && $gettok($gettok(%player.chest,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem)),$+($chr(44),$chr(44)),$chr(44))
          murkc New Inventory = %murk.currentinventory
          hadd -m MURK.Chest Items $iif($left(%player.chest,1) == $chr(44),$right(%player.chest,-1),$iif($right(%player.chest,1) == $chr(44),$left(%player.chest,-1),%player.chest))
          hadd MURK.Player Weight $calc($player.weight - ( %murk.itemquant * %weight))

        }
        else {
          %player.chest = $replace(%player.chest,$+($iif($numtok(%player.chest,44) > 1 && $gettok($gettok(%player.chest,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.currentitem),$+($iif($numtok(%player.chest,44) > 1 && $gettok($gettok(%player.chest,1,64),1,44) != %murk.itemname,$chr(44)),%murk.itemname,@,%murk.newquant))
          hadd -m MURK.Chest Items $iif($left(%player.chest,1) == $chr(44),$right(%player.chest,-1),$iif($right(%player.chest,1) == $chr(44),$left(%player.chest,-1),%player.chest))
          ;hadd MURK.Player Weight $calc($player.weight - ( %murk.itemquant * %weight))
        }
        player.additem %murk.itemid %murk.itemquant
        ;murk.displaywind @murk.itemnotify $iif(%murk.itemquant > 1,$v1) %murk.itemname removed
        ;if ($dialog(MURK.Hub)) { murk.populatehub }
      }
      else {
        murkc Player doesn't have any of that item.
      }
    }
    if ($dialog(MURK.Hub)) { murk.populatehub }
    ;murk.displaywind @murk.itemnotify $iif(%murk.itemquant > 1,$v1) %murk.itemname added
  }
  else {
    murkc Invalid ItemID.
  }
}

alias -l murk.savechest {
  var %chest.name $iif($hget(MURK.Chest,Name),$v1,$?="Name your chest")
  if (!$isdir(MURK\save\ $+ $murk.player)) {
    murkc Creating player's save directory...
    mkdir MURK\save\ $+ $murk.player
  }
  if (!$hget(MURK.Chest,Name)) { hadd MURK.Chest Name %chest.name }
  hsave MURK.Chest $+(MURK\save\,$murk.player,\,$replace(%chest.name,$chr(32),_),.mchest)
  hfree MURK.Chest
}

alias -l murk.loadchest {
  if ($hget(MURK.Chest)) { murk.savechest }
  hmake MURK.Chest 100
  hload MURK.Chest $+(MURK\save\,$murk.player,\,$replace($1-,$chr(32),_),.mchest)
}

alias -l murk.save {
  if (!$murk.player) { murkc No player loaded. Please load one and try again. | halt }
  if (!$istok(Q A,$1,32)) {
    var %murk.savename $hget(MURK.Player,SaveName)
    if (!%murk.savename) { var %murk.savename $mkfn($replace($input(Enter Save Name,e,Please supply a name for your savefile.),$chr(32),_)) }
    if (!%murk.savename) { murkc User didn't enter a name for the save file, using character name instead. | murk.displaywind @murk.nosavename | var %murk.savename $hget(MURK.Player,Name) }
    hadd -m MURK.Player SaveName %murk.savename
  }
  if ($1 != O && $exists($+(MURK\save\,%murk.savename,.murks))) { murkc $exists($+(MURK\save\,%murk.savename,.murks)) \ $+(MURK\save\,%murk.savename,.murks) | murk.displaywind @murk.fileexists | halt }
  hadd MURK.Player VendorTime $calc($hget(MURK.Player,NextVendor) - $ctime))
  hadd MURK.Player BossTime $calc($hget(MURK.Player,NextBoss) - $ctime))
  hsave MURK.Player $+(MURK\save\,$iif($1 === A,autosave,$iif($1 === Q,quicksave,$iif($hget(MURK.Player,SaveName),$v1,$hget(MURK.Player,Name)))),.murks)
  if (!$istok(Q A,$1,32)) murk.updatestats
  murkc Saved Successfully. $+($chr(40),MURK\save\,$iif($1 === A,autosave,$iif($1 === Q,quicksave,$iif($hget(MURK.Player,SaveName),$v1,$hget(MURK.Player,Name)))),.murks,$chr(41))
  murk.displaywind @murk.saving $iif($1 === A,auto,$iif($1 === Q,quick))
}

alias murkconsole {
  window -deBf +l @MURK 0 0 800 400
  titlebar $active - MURK Console
}

on *:INPUT:@MURK:{
  $$1-
}
alias murk.displaywind {
  murkc Window Data: $1-
  var %murk.windname $iif($left($remove($1,-q:),6) != @murk.,@murk. $+ $remove($1,-q:),$remove($1,-q:)),$&
    %murk.winheight $iif($readini(MURK\data\Windows.ini,%murk.windname,height),$v1,150),$&
    %murk.winstyle $iif($readini(MURK\data\Windows.ini,%murk.windname,style),$v1,YesNo),$&
    %murk.wintext $iif($readini(MURK\data\Windows.ini,%murk.windname,text),$iif($v1 !== NONE,$v1),%murk.windname), $&
    %murk.winwidth $iif($readini(MURK\data\Windows.ini,%murk.windname,width),$v1,$iif(%murk.winstyle == none,$calc($width(%murk.wintext,Tahoma,15) + 40),600)),$&
    %murk.buttontext $readini(MURK\data\Windows.ini,%murk.windname,ButtonText), $&
    %murk.winpos $iif($readini(MURK\data\Windows.ini,%murk.windname,WinPos),$replace($v1,Cw,$floor($calc(($window(-1).w - %murk.winwidth) /2)),Ch,$floor($calc(($window(-1).h + %murk.winheight) /2))),-1 -1), $&
    %murk.wintimeout $readini(MURK\data\Windows.ini,%murk.windname,WinTimeout), $&
    %murk.buttonwidth $width($iif($istok(OK debug YesNo,%murk.winstyle,32),$iif(%murk.buttontext,$v1,OK),No),Tahoma,19), $&
    %murk.buttontextareawidth %murk.buttonwidth, $&
    %murk.YesText $readini(MURK\data\Windows.ini,%murk.windname,YesText), $&
    %murk.yesbuttonwidth $width($iif(%murk.YesText,$v1,Yes),Tahoma,19)
  ;murkc D: %murk.windname \ %murk.winpos \ %murk.winwidth
  ;if (!%murk.winwidth) { var %murk.winwidth $iif(%murk.winstyle == none,$calc($width(%murk.wintext,Tahoma,15) + 40),600) }
  ;if ($window(%murk.windname) && $left($1,3) == -q:) { murk.fadewind $1- }
  if ($istok(@murk.ipeerftwconnecting @murk.loaded @murk.statsupdated @murk.statsupdating @murk.saving @murk.itemnotify,%murk.windname,32) && $left($1,3) != -q: && %murk.wintimeout) { 
    var %t 1, %s 0
    while (%t <= $timer(0)) { 
      if (murkwindowqueue.* iswm $timer(%t)) { 
        if (%t > 1) { inc %s %murk.wintimeout }
        ;murkc T: %t \ $timer(%t) \ $timer(%t).secs \ %murk.wintimeout
        inc %s 
        ;%murk.wintimeout
        ;$timer(%t).secs
        murkc S: %s \ T: %t \ $timer(%t) \ $timer(%t).secs \ %murk.wintimeout
        if (%t > 2) dec %s
      }
      inc %t 
    }
    inc -eu10 %murk.windowqueue 
    .timermurkwindowqueue. [ $+ [ %murk.windname ] ] $+ . [ $+ [ %murk.windowqueue ] ]  -io 1 $iif(%s,$v1,0) murk.displaywind $+(-q:,$1-)
    if (%murk.wintimeout) .timerclose. [ $+ [ %murk.windname ] ] 1 $calc(%s + %murk.wintimeout) murk.fadewind %murk.windname
    unset %s %t 
  }
  else {
    if (!$window(%murk.windname)) { window $+(-,$iif(%murk.winpos == -1 -1,C),$iif($istok(debug none,%murk.winstyle,32) || !$appactive || $istok(@murk.itemnotify @murk.saving @murk.monsterbosschallenge @murk.monsterchallenge @murk.founditem @murk.trader @murk.tradertimeout,%murk.windname,32) || $left($1-,3) == -q:,h),Badfipw0k0) +dL %murk.windname %murk.winpos %murk.winwidth %murk.winheight }
    else { clear %murk.windname }
    if ($readini(MURK\data\user.ini,Options,WinTransparency) < 255) setlayer $v1 %murk.windname
    drawrect -fn %murk.windname $iif($readini(MURK\data\user.ini,Options,WinBGColour) != $null,$v1,01) 1 0 0 %murk.winwidth %murk.winheight
    drawrect -n %murk.windname $iif($readini(MURK\data\user.ini,Options,WinTextColour) != $null,$v1,04) 2 1 1 $calc(%murk.winwidth -2) $calc(%murk.winheight -2)

    ;Yes button
    if (!$istok(ok none debug,$readini(MURK\data\Windows.ini,%murk.windname,style),32)) $&
      drawtext -nc %murk.windname $&
      $iif($readini(MURK\data\user.ini,Options,WinTextColour),$v1,13) $&
      Tahoma 19 $&
      $floor($calc(($window(%murk.windname).w - $iif(%murk.yesbuttonwidth,$v1,15)) / 2)) $&
      $floor($calc($window(%murk.windname).h -70)) $&
      $iif($readini(MURK\data\Windows.ini,%murk.windname,ButtonWidth),$calc($v1 - 6),$iif(%murk.yesbuttonwidth,$v1,35)) $&
      $iif($readini(MURK\data\Windows.ini,%murk.windname,ButtonHeight),$calc($v1 - 6),%murk.yesbuttonwidth) $&
      $iif(%murk.YesText,$v1,Yes)

    ; No/Ok/Custom button
    if (!$istok(none,$readini(MURK\data\Windows.ini,%murk.windname,style),32)) $&
      drawtext -nc %murk.windname $&
      $iif($readini(MURK\data\user.ini,Options,WinTextColour) != $null,$v1,04) $&
      Tahoma 19 $&
      $floor($calc(($window(%murk.windname).w - $iif(%murk.buttontextareawidth,$v1,12)) / 2)) $&
      $floor($calc($window(%murk.windname).h -40)) $&
      $iif($readini(MURK\data\Windows.ini,%murk.windname,ButtonWidth),$calc($v1 - 6),$iif(%murk.buttonwidth,$v1,35)) $&
      $iif($readini(MURK\data\Windows.ini,%murk.windname,ButtonHeight),$calc($v1 - 6),%murk.buttonwidth) $&
      $iif($istok(ok debug YesNo,%murk.winstyle,32),$iif(%murk.buttontext,$v1,$iif(%murk.winstyle == YesNo,No,OK)),No)

    ; Window text
    var %murk.lines = $wrap(%murk.wintext,Tahoma,15,$calc(%murk.winwidth -3),1,0), %murk.tpos 10, %m.l 1
    while (%m.l <= %murk.lines) {
      var %width1 $calc(%murk.winwidth -3), %width2 $width($wrap(%murk.wintext,Tahoma,15,%width1,1,%m.l),Tahoma,15)
      var %width3 $calc((%width1 - %width2) / 2)
      drawtext -np %murk.windname $&
        $iif($readini(MURK\data\user.ini,Options,WinTextColour) != $null,$v1,04) $&
        Tahoma 15 $&
        %width3 $&
        %murk.tpos $wrap(%murk.wintext,Tahoma,15,%width1,1,%m.l)
      inc %murk.tpos 19
      inc %m.l
    }
  }
  if ($window($remove(%murk.windname,-q:))) { 
    drawrect $remove(%murk.windname,-q:)
    window -o %murk.windname
  }
  if (%murk.wintimeout && !$timer(close. [ $+ [ %murk.windname ] ])) { murkc %murk.windname \ %murk.wintimeout | .timerclose. [ $+ [ %murk.windname ] ] 1 %murk.wintimeout murk.fadewind %murk.windname }
  if ($murk.status != Stable && !$window(@murk.closeall) && $player.option(ShowCloseAll) && %murk.windname != @murk.optionspreview) { .timer 1 0.1 murk.displaywind @murk.closeall }
}
menu @murk.* {
  mouse {
    var %nowidth $calc($width($iif($istok(OK debug YesNo,$readini(MURK\data\Windows.ini,$active,style),32),$iif($readini(MURK\data\Windows.ini,$active,ButtonText),$v1,OK),No),Tahoma,19) + 10), $&
      %yeswidth $calc($width($iif($readini(MURK\data\Windows.ini,$active,YesText),$v1,Yes),Tahoma,19) + 10)
    if (!$istok(ok none debug,$readini(MURK\data\Windows.ini,$active,style),32)) {
      ;if ($inrect($mouse.x,$mouse.y,$floor($calc($window($active).w / 2 -20)),$floor($calc($window($active).h -70)),$iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,41),$iif($readini(MURK\data\Windows.ini,$active,ButtonHeight),$v1,25))) {
      if ($inrect($mouse.x,$mouse.y,$floor($calc($window($active).w / 2 - $iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1 / 2,$iif(%yeswidth,$v1 / 2,35)))),$floor($calc($window($active).h -70)),$iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1,$iif(%yeswidth,$v1,41)),25)) {
        drawrect $active $&
          $iif($readini(MURK\data\user.ini,Options,WinTextColour) != $null,$v1,04) $&
          2 $&
          $floor($calc($window($active).w / 2 - $iif($iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1,$iif(%yeswidth,$v1,41)),$floor($calc($v1 /2)),20)))) $&        
          $floor($calc($window($active).h -70)) $&
          $iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1,$iif(%yeswidth,$v1,20)) $&
          25
      }
      else {
        drawrect $active $&
          $iif($readini(MURK\data\user.ini,Options,WinBGColour) != $null,$v1,01) $&
          2 $&
          $floor($calc($window($active).w / 2 - $iif($iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1,$iif(%yeswidth,$v1,41)),$floor($calc($v1 /2)),20)))) $&        
          $floor($calc($window($active).h -70)) $&
          $iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1,$iif(%yeswidth,$v1,20)) $&
          25      
      }
    }
    if (!$istok(none,$readini(MURK\data\Windows.ini,$active,style),32)) {
      if ($inrect($mouse.x,$mouse.y,$floor($calc($window($active).w / 2 - $iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1 / 2,$iif(%nowidth,$v1 / 2,20)))),$floor($calc($window($active).h -40)),$iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,$iif(%nowidth,$v1,41)),25)) {
        drawrect $active $&
          $iif($readini(MURK\data\user.ini,Options,WinTextColour) != $null,$v1,04) $&
          2 $&
          $floor($calc($window($active).w / 2 - $iif($iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,$iif(%nowidth,$v1,41)),$floor($calc($v1 /2)),20)))) $&        
          $floor($calc($window($active).h -40)) $&
          $iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,$iif(%nowidth,$v1,41)) $&
          25
      }
      else {
        drawrect $active $iif($readini(MURK\data\user.ini,Options,WinBGColour) != $null,$v1,01) 2 $floor($calc($window($active).w / 2 - $iif($iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,$iif(%nowidth,$v1,41)),$floor($calc($v1 /2)),20)))) $floor($calc($window($active).h -40)) $iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,$iif(%nowidth,$v1,41)) 25
      }
    }
  }
  sclick { 
    var %nowidth $calc($width($iif($istok(OK debug YesNo,$readini(MURK\data\Windows.ini,$active,style),32),$iif($readini(MURK\data\Windows.ini,$active,buttontext),$v1,OK),No),Tahoma,19) + 10), $&
      %yeswidth $calc($width($iif($readini(MURK\data\Windows.ini,$active,YesText),$v1,Yes),Tahoma,19) + 10), $&
      %style = $readini(MURK\data\Windows.ini,$active,style)
    if (!$istok(ok none debug,%style,32) && $inrect($mouse.x,$mouse.y,$floor($calc($window($active).w / 2 - $iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1 / 2,$iif(%yeswidth,$v1 / 2,35)))),$floor($calc($window($active).h -70)),$iif($readini(MURK\data\Windows.ini,$active,YesButtonWidth),$v1,$iif(%yeswidth,$v1,41)),25)) {
      var %c 1, %murk.winname $active, %murk.onyescommands $readini(MURK\data\Windows.ini,%murk.winname,OnYes)
      while ($gettok(%murk.onyescommands,%c,124)) {
        $gettok($readini(MURK\data\Windows.ini,%murk.winname,OnYes),%c,124)
        inc %c
      }
      close -@ %murk.winname
    }
    elseif ($inrect($mouse.x,$mouse.y,$floor($calc($window($active).w / 2 - $iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1 / 2,$iif(%nowidth,$v1 / 2,20)))),$floor($calc($window($active).h -40)),$iif($readini(MURK\data\Windows.ini,$active,ButtonWidth),$v1,$iif(%nowidth,$v1,41)),25)) {
      var %c 1, %murk.winname $active, %murk.onnocommands $readini(MURK\data\Windows.ini,%murk.winname,OnNo)
      if (%murk.onnocommands) {
        while ($gettok(%murk.onnocommands,%c,124)) {
          $gettok(%murk.onnocommands,%c,124)
          inc %c
        }
      }
      close -@ %murk.winname
    }
  }
}
alias murk.fadewind {
  var %setlayer 255, %murk.fadewindname $1
  if ($window(%murk.fadewindname)) {
    while (%setlayer) {
      dec %setlayer 17
      ;murkc SETLAYER -> %setlayer %murk.fadewindname 
      setlayer %setlayer %murk.fadewindname 
    }
    close -@ %murk.fadewindname 
  }
  else {
    murkc %murk.fadewindname is not open.
  }
}
alias murk.checkforupdate {
  if ($sock(MURK.GET.VersionCheck)) .sockclose MURK.GET.VersionCheck
  %murk.GET = /version
  %murk.host = murk.ipeerftw.co.cc
  sockopen MURK.GET.VersionCheck murk.ipeerftw.co.cc 80
  murk.displaywind @murk.ipeerftwconnecting
}
; Script Socket

on *:SOCKOPEN:MURK.GET.*: {
  sockwrite -nt $sockname GET %murk.get HTTP/1.1
  sockwrite -nt $sockname Host: %murk.host
  sockwrite -nt $sockname User-Agent: MURK/ $+ $murk.version
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:MURK.GET.*: {
  if ($sockerr) {
    if ($window(@murk.ipeerftwconnecting)) { murk.fadewind @murk.ipeerftwconnecting }
    murk.displaywind @murk.ipeerftwcantconnect $sockerr
    halt
  }
  else {
    var %sockreader
    sockread %sockreader
    if ($sockname = MURK.VersionCheck) {
      if (*You are* iswm %sockreader) {
        if ($window(@murk.ipeerftwconnecting)) { murk.fadewind @murk.ipeerftwconnecting }
        murk.displaywind @murk.ipeerftwconnectsuccess
        sockread %sockreader
        var %murk.ver %sockreader
        murkc Latest Stable: %murk.ver
        if (%murk.ver == $murk.version) {
          murkc murk.ipeerftw.co.cc reports that the current running version is up-to-date.
        }
        else {
          murkc murk.ipeerftw.co.cc reports there is an update available.
          murk.displaywind @murk.asktoupdate
        }
        sockclose $sockname
      }
    }
  }
}

alias -l urlencode return $replace($regsubex($$1,/([^\w\s])/Sg,$+(%,$base($asc(\t),10,16,2))),$chr(32),+) 

alias -l murk.updatestats {
  if (!$hget(MURK.Player,PassPhrase)) { hadd -m MURK.Player PassPhrase $input(Enter PassPhrase,e,Please enter your PassPhrase.) }
  if ($sock(MURK.POST.UpdateStats)) .sockclose MURK.POST.UpdateStats
  %murk.POST = /MURK/database.php
  %murk.host = murk.ipeerftw.co.cc
  %murk.socketdata = $+(Name=,$hget(MURK.Player,Name),&AP=,$player.ap,&LVL=,$player.level,&XP=,$player.exp,&INV=,$hget(MURK.Player,Inventory),&QUEST=,$urlencode($replace($hget(MURK.Player,Quests),$+($chr(44),$chr(44)),$chr(44))),&HP=,$player.hp,&CC=,$player.cc,&PASSPHRASE=,$hget(MURK.Player,PassPhrase),&Weapon=,$iif($hget(MURK.Player,Weapon),$v1,Hands),&Armour=,$iif($hget(MURK.Player,Armour),$v1,Normal Clothes),&Wins=,$player.wins,&Loses=,$player.loses,&Rares=,$player.rares,&Finds=,$player.itemsfound,&Shield=,$player.shield,&Mods=,$player.mods,&StealCaught=,$player.failedsteals,&StealSuccess=,$player.stealsuccess,&Coins=,$hget(MURK.Player,Coins),&Legs=,$player.legs)
  murkc SOCKET DATA: %murk.socketdata
  sockopen MURK.POST.UpdateStats murk.ipeerftw.co.cc 80
  murk.displaywind @murk.ipeerftwconnecting

}
; Script Socket

on *:SOCKOPEN:MURK.POST*: {
  sockwrite -nt $sockname POST %murk.POST HTTP/1.1
  sockwrite -nt $sockname Host: %murk.host
  sockwrite -nt $sockname Content-Type: application/x-www-form-urlencoded 
  sockwrite -nt $sockname Content-Length: $len(%murk.socketdata)
  sockwrite -nt $sockname $crlf
  sockwrite -nt $sockname %murk.socketdata
}
on *:SOCKREAD:MURK.POST.*: {
  var %sockreader
  sockread %sockreader
  ;$iif(%sockreader,murkc $v1)
  if ($sockerr) {
    if ($window(@murk.ipeerftwconnecting)) { murk.fadewind @murk.ipeerftwconnecting }
    murk.displaywind @murk.ipeerftwcantconnect $sockerr
    halt
  }
  else {
    if ($window(@murk.ipeerftwconnecting)) { murk.fadewind @murk.ipeerftwconnecting }
    if (!$window(@murk.updatingstats)) murk.displaywind @murk.updatingstats
    if (*Database Updated* iswm %sockreader || *Added to* iswm %sockreader) {
      if ($window(@murk.updatingstats)) { murk.fadewind @murk.updatingstats }
      murkc Status Updated.
      if ($murk.player) murk.displaywind @murk.statsupdated
      sockclose $sockname
    }
    elseif (*Player is banned.* iswm %sockreader) {
      murk.displaywind @murk.userbanned
      murkc User is banned.
      sockclose $sockname
      if ($window(@murk.updatingstats)) { murk.fadewind @murk.updatingstats }
    }
    elseif (*PassPhrase* iswm %sockreader) {
      murkc PassPhrase Error
      sockclose $sockname
      if ($window(@murk.updatingstats)) { murk.fadewind @murk.updatingstats }
      murk.displaywind @murk.pferror
    }
  }
}
on *:SOCKCLOSE:MURK.POST.*: {
  murkc Socket $sockname force closed
}
/*
- Mapping -

Very Large: 600x600
Large: 500x500
Normal: 400x400
Small: 300x300
Very Small: 200x200

*/
alias murk.genmap {
  if (!$dialog(murk.mapgeneration)) {
    if (!$isdir(MURK\temp)) { mkdir MURK\temp }
    if ($exists(MURK\temp\monsters.murk.dat)) { .remove MURK\temp\monsters.murk.dat } 
    var %murk.mapsize $iif($1,$v1,normal)
    var %murk.mappixels $iif(%murk.mapsize == vsmall,200 200,$iif(%murk.mapsize == small,300 300,$iif(%murk.mapsize == normal,400 400,$iif(%murk.mapsize == large,500 500,$iif(%murk.mapsize == vlarge,600 600)))))
    var %murk.totalspawns $calc($gettok(%murk.mappixels,1,32) * $gettok(%murk.mappixels,2,32) /50)
    window -pfdhw0k0 +dL @murkmapgen -1 -1 %murk.mappixels
    dialog -md murk.mapgeneration murk.mapgeneration
    var %murk.placingspawn 1, %murk.mapheight $window(@murkmapgen).h, %murk.mapwidth $window(@murkmapgen).w, %segid 1
    ;did -ra murk.mapgeneration 2 Placing monster encounters... $+($chr(40),$calc(%murk.placingspawn / %murk.totalspawns *100),%,$chr(41))
    hdel -w MURK.Player Monsters*
    while (%murk.placingspawn <= %murk.totalspawns) {
      var %murk.x $r(1,%murk.mapheight), %murk.y $r(1,%murk.mapheight)
      did -ra murk.mapgeneration 2 Placing monster encounters... $+($chr(40),$round($calc(%murk.placingspawn / %murk.totalspawns *100),0),%,$chr(41))
      hadd -m MURK.Player $+(Monsters,%segid) $hget(MURK.Player,$+(Monsters,%segid)) $+ %murk.x %murk.y $+ $chr(44)
      if ($numtok($hget(MURK.Player,$+(Monsters,%segid)),44) >= 500) { inc %segid }
      drawdot -n @murkmapgen 4 1 %murk.x %murk.y   
      inc %murk.placingspawn    
    }
    drawdot @murkmapgen
    if (!$isdir(MURK\Players)) { mkdir MURK\Players }
    if (!$isdir(MURK\Players\ $+ $hget(MURK.Player,SaveName))) { mkdir MURK\Players\ $+ $hget(MURK.Player,SaveName) }
    if ($exists($+(MURK\Players\,$hget(MURK.Player,SaveName),\,map.bmp))) { .remove $+(MURK\Players\,$hget(MURK.Player,SaveName),\,map.bmp) }
    drawsave @murkmapgen $+(MURK\Players\,$hget(MURK.Player,SaveName),\,map.bmp)
    dialog -x murk.mapgeneration
    close -@ @murkmapgen
  } 
  else {
    murk.displaywind @murk.mapalreadygenerating
  }
}

alias -l murk.checkformonster {
  var %g 1, %coords $1 $2
  murkc Checking for monsters at %coords
  if (($gettok(%coords,1,32) == 0) || ($gettok(%coords,2,32) == 0)) { $iif($isid,return,murkc) 0 | unset %murk.foundspawn %g %coords }
  else {
    while ($hget(MURK.Player,Monsters $+ %g) && !%murk.foundspawn) {
      %data = $hget(MURK.Player,Monsters $+ %g)
      if (%coords isin %data) {
        %murk.foundspawn = 1
      }
      inc %g
    }
    $iif($isid,return,murkc) $iif(%murk.foundspawn,Monsters $+ $calc(%g - 1),0)
    unset %murk.foundspawn %g %coords
  }
}

dialog murk.mapgeneration {
  title "MURK Map Generation"
  size -1 -1 205 40
  option dbu
  text "MURK is now generating your map this make take a few minutes and mIRC may lock up during this process. This is completely normal.", 1, 4 2 196 16
  text "Placing monster encounters: 0/1337 (1337%)", 2, 34 23 137 8, center
}
alias -l murk.load {
  if (!%murk.filetoload) set -eu60 %murk.filetoload $1-
  murkc %murk.filetoload \ $1-
  if (!%murk.filetoload) { murk.displaywind @murk.nosaveselected | halt }
  if ($murk.player) { murk.displaywind @murk.loadconfirm | halt }
  if (!$exists($+(MURK\save\,%murk.filetoload,.murks))) { murkc Loading error: File does not exist! | murk.displaywind @murk.savedoesnotexist | halt }
  if ($hget(MURK.Player).size) { hfree MURK.Player }
  hmake MURK.Player 100
  hload MURK.Player $+(MURK\save\,%murk.filetoload,.murks)
  hadd MURK.Player NextVendor $calc($hget(MURK.Player,VendorTime) + $ctime)
  hadd MURK.Player NextBoss $calc($hget(MURK.Player,BossTime) + $ctime)
  if (!$timer(MURKMovePlayer)) { .timerMURKMovePlayer 0 300 murk.moveplayer }
  murk.displaywind @murk.loaded
  if ($dialog(MURK.Hub)) { murk.populatehub }
  unset %murk.filetoload
  murk.hubupdatevendor
  murk.hubupdateboss
  if ($dialog(MURK.Hub)) { 
    did -ra MURK.Hub 11 Weight: $player.weight $+ / $+ $player.maxweight 
    did -ra MURK.Hub 12 Current HP: $+($player.chp,/,$player.hp)
  }
  if ($dialog(MURK.Load)) { dialog -x MURK.Load }
}

dialog MURK.Update {
  title "MURK - Auto Updater"
  size -1 -1 408 239
  option pixels
  text "MURK Is currently being updated to the lastest version. Updated and new files will automatically be downloaded and added to your copy. If you wish to abort the update, just hit the 'Abort Update' button.", 1, 27 2 356 43
  text "Total Files:", 2, 26 56 356 16
  text "Files Remaining:", 3, 26 74 356 16
  text "Files Completed:", 4, 26 92 356 16
  button "Abort Update", 5, 90 202 226 24
  list 6, 25 115 358 76, size vsbar
}

on *:dialog:MURK.Update:sclick:5:{
  if ($did(5) == Abort Update) { sockclose MURK.Update.* | sockclose murk.read.roll | unset %murk.update.files %murk.update.files.total %murk.update.files.done }
  dialog -x $dname
}

alias mudlf {
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
  while ($sock(MURKDownload. [ $+ [ %sckid ] ])) {
    inc %sckid
  }
  %murk.host. [ $+ [ %sckid ] ] = $gettok($2,1,47) 
  %murk.file. [ $+ [ %sckid ] ] = $gettok($2,2-,47)
  murkc %murk.host. [ $+ [ %sckid ] ] \ %murk.file. [ $+ [ %sckid ] ]
  %murk.savein. [ $+ [ %sckid ] ] = $1
  if (*MURK.mrc* iswm $2-) { 
    if (!$isdir(MURK\script\Backups)) { mkdir MURK\script\Backups }
    if (!$isdir($+(MURK\script\Backups\,$murk.build))) { mkdir $+(MURK\script\Backups\,$murk.build) }
    if ($exists($+(MURK\script\Backups\,$murk.build,\MURK.mrc))) { .remove $+(MURK\script\Backups\,$murk.build,\MURK.mrc) }
    .copy MURK\Script\MURK.mrc $+(MURK\script\Backups\,$murk.build,\MURK.mrc)
    murkc Backup created as $+(MURK\script\Backups\,$murk.build,\MURK.mrc)
  }
  if ($exists(MURK\ $+ %murk.savein. [ $+ [ %sckid ] ] $+ $gettok(%murk.file. [ $+ [ %sckid ] ],-1,$asc(/)))) { .remove $+(MURK\,%murk.savein. [ $+ [ %sckid ] ],$gettok(%murk.file. [ $+ [ %sckid ] ],-1,$asc(/))) }
  sockopen MURKDownload. [ $+ [ %sckid ] ] %murk.host. [ $+ [ %sckid ] ] 80
}

on *:SOCKOPEN:MURKDownload.*: {
  did -a MURK.Update 6 Downloading: %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] - 0%
  sockwrite -nt $sockname GET $+(/,%murk.file. [ $+ [ $gettok($sockname,2,46) ] ]) HTTP/1.1
  sockwrite -nt $sockname Host: %murk.host. [ $+ [ $gettok($sockname,2,46) ] ]
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:MURKDownload.*: {
  if ($sockerr) {
    murkc Socket Error: $sockname $+ . Error code: $sockerr Please inform iPeer of this error message.
    murk.displaywind @murk.updateerror $sockname \ $sockerr
    halt
  }
  else {
    var %sockreader
    if (!%murk.header. [ $+ [ $gettok($sockname,2,46) ] ]) sockread %sockreader
    if (HTTP* iswmcs %sockreader && *200* !iswm %sockreader) {
      did -o MURK.Update 6 $gettok($sockname,2,46) %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] $+($gettok(%sockreader,2,32),'d)
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
    bwrite $qt(MURK\  $+ %murk.savein. [ $+ [ $gettok($sockname,2,46) ] ] $+ %file. [ $+ [ $gettok($sockname,2,46) ] ]) -1 -1 &murk.file. [ $+ [ $gettok($sockname,2,46) ] ]
    ;murkc %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] \ %file. [ $+ [ $gettok($sockname,2,46) ] ] \ $gettok($sockname,2,46) \ $sock($sockname).mark \ $lof($qt(MURK\ $+ %murk.savein. [ $+ [ $gettok($sockname,2,46) ] ] $+ $gettok(%murk.file. [ $+ [ $gettok($sockname,2,46) ] ],-1,$asc(/))))
    did -o MURK.Update 6 $gettok($sockname,2,46) Downloading: %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] - $round($calc($lof($qt($+(MURK\,%murk.savein. [ $+ [ $gettok($sockname,2,46) ] ],%file. [ $+ [ $gettok($sockname,2,46) ] ]))) / $sock($sockname).mark * 100),0)) $+ %
    if ($lof($qt($+(MURK\,%murk.savein. [ $+ [ $gettok($sockname,2,46) ] ],%file. [ $+ [ $gettok($sockname,2,46) ] ]))) >= $sock($sockname).mark) {
      inc %murk.update.files.done
      did -ra MURK.Update 3 Files Remaining: $calc(%murk.update.files.total - %murk.update.files.done)
      did -ra MURK.Update 4 Files Complete: %murk.update.files.done
      did -o MURK.Update 6 $gettok($sockname,2,46) Download Complete: %murk.file. [ $+ [ $gettok($sockname,2,46) ] ]
      did -c MURK.Update 6 $did(MURK.Update,6).lines
      did -u MURK.Update 6 $did(MURK.Update,6).lines
      unset %murk.*. [ $+ [ $gettok($sockname,2,46) ] ]
      sockclose $sockname
      if ($sock(MURKDownload.*,0) < 1) {
        unset %murk.update.files.* 
        did -a MURK.Update 6 Update Complete! :)
        murk.displaywind @murk.updated
        did -c MURK.Update 6 $did(MURK.Update,6).lines
        did -u MURK.Update 6 $did(MURK.Update,6).lines
        did -ra MURK.Update 5 Update Complete. Click to close.
        .reload -rs $qt($script)
        murk.loaditems
      }
    }
  }
}
on *:sockclose:MURKDownload.*:{
  murk.displaywind @murk.updateerror $iif($1-,$v1,$!null) \ $sockname \ %murk.file. [ $+ [ $gettok($sockname,2,46) ] ] \ $sockerr \ $sockbr
}

; - Update Roll Reading -
alias murk.read.roll {
  if ($dialog(MURK.Update)) { murkc Updater appears to already be running, won't check or update while it is. | halt }
  if ($1 == F) { set %murk.playersaidyestoupdate 1 | %murk.userforcedupdate = 1 }
  if (!$isdir(MURK\temp)) { mkdir MURK\temp }
  sockopen MURK.Update.ReadRoll murk.ipeerftw.co.cc 80
}
; Script Socket

on *:SOCKOPEN:MURK.Update.ReadRoll: {
  sockwrite -nt $sockname GET /script/roll/ $+ $iif(%murk.userforcedupdate,1.0.3,$murk.build) HTTP/1.1
  sockwrite -nt $sockname Host: murk.ipeerftw.co.cc
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:MURK.Update.ReadRoll: {
  if ($sockerr) {
    murk.displaywind @murk.ipeerftwcantconnect $sockerr
    halt
  }
  else {
    var %sockreader
    sockread %sockreader
    while (%sockreader != $null && !%murk.rollheader) {
      sockread %sockreader
    }
    set %murk.rollheader 1
    sockread %sockreader
    if (%sockreader == No Updates Needed.) { 
      murkc MURK is currently running with the latest version.
      sockclose $sockname
      unset %murk.rollheader
      halt
    }
    else {
      if (%murk.playersaidyestoupdate && %murk.rollheader) {
        ;unset %murk.playersaidyestoupdate
        while (%sockreader) {
          murkc Update Roll: %sockreader
          if (!$readini(MURK\temp\update.ini,Commands,$replace(%sockreader,$chr(32),-))) { 
            %sockreader
            writeini MURK\temp\update.ini Commands $replace(%sockreader,$chr(32),-) 1
          }
          sockread %sockreader
        }
        unset %murk.rollheader %murk.playersaidyestoupdate %murk.userforcedupdate
        sockclose $sockname
        if ($exists(MURK\temp\update.ini)) { .remove MURK\temp\update.ini }
      }
      else {
        murk.displaywind @murk.updateavailable 
        unset %murk.rollheader
        sockclose $sockname
      }
    }
  } 
}

; - Save Loading -

dialog MURK.Load {
  title "MURK - Load A Player"
  size -1 -1 226 266
  option pixels
  text "Please pick a savefile from the list below and press the 'Load' button to load it.", 1, 16 7 193 26
  list 2, 16 42 191 118, size vsbar
  box "Save Information", 3, 4 164 218 61
  button "Load", 4, 30 232 75 25
  button "Cancel", 5, 118 232 75 25, cancel
  text "Player Name:", 6, 13 181 67 16
  text "", 7, 84 181 131 16
  text "Player Level:", 8, 13 200 67 16
  text "", 9, 84 200 131 16
}
on *:dialog:MURK.Load:*:*:{
  if ($devent == init) {
    noop $findfile(MURK\save,*.murks,0,0,did -a $dname 2 $remove($1-,$scriptdir,$mircdir,MURK\,/MURK/,MURK/,\MURK\,save\,save/))
  }
  if ($devent == sclick) {
    if ($did == 2) {
      hmake MURK.Temp 100
      hload MURK.Temp MURK\save\ $+ $did(2).seltext
      did -ra $dname 7 $hget(MURK.Temp,Name)
      did -ra $dname 9 $hget(MURK.Temp,LVL)
      hfree MURK.Temp
    }
    if ($did == 4 && $did(2).seltext) {
      murk.load $remove($did(2).seltext,.murks)
      ;dialog -x $dname
    }
  }
}

; - Armoury - New and improved!

dialog MURK.Armoury {
  title "MURK - Armoury"
  size -1 -1 139 185
  option dbu
  combo 1, 9 19 60 50, size drop
  combo 2, 40 52 60 50, size drop
  combo 3, 70 19 60 50, size drop
  text "Weapon", 4, 26 9 25 8, center
  text "Shield", 5, 89 9 25 8, center
  text "Armour", 6, 58 43 25 8, center
  button "Leave Armoury", 7, 47 170 44 12, cancel
  box "Player Status", 8, 9 99 121 70
  text "Min/Max damage", 9, 14 107 110 8
  text "999/999", 10, 14 116 72 8
  text "Stats", 11, 14 129 109 8
  text "HP: 9999 (+9999, +9999)", 12, 14 139 113 8
  text "AP: 9999 (+9999, +9999)", 13, 14 148 113 8
  text "CC: 9999 (+9999, +9999)", 14, 14 157 113 8
  button "Repair Weapon", 15, 9 30 59 8, hide disable
  button "Repair Armour", 16, 40 63 59 8, hide disable
  button "Repair Shield", 17, 70 30 59 8, hide disable
  combo 18, 40 73 60 50, size drop
  button "Repair Legs", 19, 40 84 59 8, hide disable
}

on *:dialog:MURK.Armoury:*:*:{
  if ($devent == init) {
    if (!$hget(MURK.Items,Loaded)) { murk.loaditems }
    var %inventory $hget(MURK.Player,Inventory), %t 1, %w 1,%a 1,%s 1, %l 1
    did -a $dname 1 Hands
    did -a $dname 2 Normal Clothes
    did -a $dname 3 None
    did -a $dname 18 Flares
    while ($gettok(%inventory,%t,44)) {
      var %itemname = $gettok($gettok(%inventory,%t,44),1,64)
      ;murkc Armoury: %t \ %itemname
      if ($qt(%itemname) isin $hget(MURK.Items,Weapon)) {
        did -a $dname 1 %itemname
        inc %w
        if (%itemname == $player.weapon) { %murk.weapon = %w }
      }
      if ($qt(%itemname) isin $hget(MURK.Items,Armour)) {
        did -a $dname 2 %itemname
        inc %a
        if (%itemname == $player.armour) { %murk.armour = %a }
      }
      if ($qt(%itemname) isin $hget(MURK.Items,Shield)) {
        did -a $dname 3 %itemname
        inc %s
        if (%itemname == $iif($player.shield,$v1,None)) { %murk.shield = %s }
      }
      if ($qt(%itemname) isin $hget(MURK.Items,Legs)) {
        did -a $dname 18 %itemname
        inc %l
        if (%itemname == $iif($player.legs,$v1,Flares)) { %murk.legs = %l }
      }
      inc %t
    }
    murkc %murk.weapon \ %murk.armour \ $iif(%murk.shield,$v1,1) \ $iif(%murk.legs,$v1,1)
    did -c $dname 1 $iif(%murk.weapon,$v1,1)
    did -c $dname 2 $iif(%murk.armour,$v1,1)
    did -c $dname 3 $iif(%murk.shield,$v1,1)
    did -c $dname 18 $iif(%murk.legs,$v1,1)
    did -ra $dname 10 $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MinDam) $+ / $+ $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MaxDam)
    if ($player.weaponhp < $player.weaponbasehp && $player.checkquant(1,$readini(MURK\data\Weapon.ini,$replace($player.weaponbase,$chr(32),-),COST))) { did -ve $dname 15 }
    if ($player.armourhp < $player.armourbasehp && $player.checkquant(1,$readini(MURK\data\Armour.ini,$replace($player.armourbase,$chr(32),-),COST))) { did -ve $dname 16 }
    if ($player.shieldhp < $player.shieldbasehp && $player.checkquant(1,$readini(MURK\data\Shield.ini,$replace($player.shieldbase,$chr(32),-),COST))) { did -ve $dname 17 }
    if ($player.legshp < $player.legsbasehp && $player.checkquant(1,$readini(MURK\data\Legs.ini,$replace($player.legsbase,$chr(32),-),COST))) { did -ve $dname 19 }

    unset %murk.shield %murk.weapon %murk.armour %s %a %w %inventory %t
    var %ahp $iif($readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),HPBoost),$v1,0), $&
      %acc $iif($readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),CCBoost),$v1,0), $&
      %aap $iif($readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),APBoost),$v1,0), $&
      %shp $iif($readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),HPBoost),$v1,0), $&
      %sap $iif($readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),APBoost),$v1,0), $&
      %scc $iif($readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),CCBoost),$v1,0), $&
      %lhp $iif($readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),HPBoost),$v1,0), $&
      %lap $iif($readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),APBoost),$v1,0), $&
      %lcc $iif($readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),CCBoost),$v1,0)
    did -ra $dname 12 HP: $player.hp ( $+ $+(A: $iif($left(%ahp,1) != -,$+(+,%ahp),%ahp),$chr(44),$chr(32),S: ,$iif($left(%shp,1) != -,$+(+,%shp),%shp),$chr(44),$chr(32),L: ,$iif($left(%lhp,1) != -,$+(+,%lhp),%lhp)) $+ )
    did -ra $dname 13 AP: $player.ap ( $+ $+(A: $iif($left(%aap,1) != -,$+(+,%aap),%aap),$chr(44),$chr(32),S: ,$iif($left(%sap,1) != -,$+(+,%sap),%sap),$chr(44),$chr(32),L: ,$iif($left(%lap,1) != -,$+(+,%lap),%lap)) $+ )
    did -ra $dname 14 CC: $player.cc ( $+ $+(A: $iif($left(%acc,1) != -,$+(+,%acc),%acc),$chr(44),$chr(32),S: ,$iif($left(%scc,1) != -,$+(+,%scc),%scc),$chr(44),$chr(32),L: ,$iif($left(%lcc,1) != -,$+(+,%lcc),%lcc)) $+ )
  }
  if ($devent == sclick) {
    if ($did == 1) {
      if ($did(1).seltext != Hands) { player.equipitem $murk.getitemidbyname($did(1).seltext) }
      else { hadd MURK.Player Weapon Hands }
      did -ra $dname 10 $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MinDam) $+ / $+ $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MaxDam)

      if ($player.weaponhp < $player.weaponbasehp && $player.checkquant(1,$readini(MURK\data\Weapon.ini,$replace($player.weaponbase,$chr(32),-),COST))) { did -ve $dname 15 }
      else { did -bh $dname 15 }
    }
    if ($did isnum 2-3 || $did == 18) {
      if ($did == 2) {
        player.unequipitem $readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),ID)
        player.equipitem $readini(MURK\data\Armour.ini,$replace($did(2).seltext,$chr(32),-),ID)
        if ($player.armourhp < $player.armourbasehp && $player.checkquant(1,$readini(MURK\data\Armour.ini,$replace($player.armourbase,$chr(32),-),COST))) { did -ve $dname 16 }
        else { did -bh $dname 16 }
      }
      if ($did == 3) {
        player.unequipitem $readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),ID)
        player.equipitem $readini(MURK\data\Shield.ini,$replace($did(3).seltext,$chr(32),-),ID)
        if ($player.shieldhp < $player.shieldbasehp && $player.checkquant(1,$readini(MURK\data\Shield.ini,$replace($player.shieldbase,$chr(32),-),COST))) { did -ve $dname 17 }
        else { did -bh $dname 17 }
      }
      if ($did == 18) {
        player.unequipitem $readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),ID)
        player.equipitem $readini(MURK\data\Legs.ini,$replace($did(18).seltext,$chr(32),-),ID)
        if ($player.legshp < $player.legsbasehp && $player.checkquant(1,$readini(MURK\data\Legs.ini,$replace($player.legsbase,$chr(32),-),COST))) { did -ve $dname 19 }
        else { did -bh $dname 19 }
      }
      var %ahp $iif($readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),HPBoost),$v1,0), $&
        %acc $iif($readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),CCBoost),$v1,0), $&
        %aap $iif($readini(MURK\data\Armour.ini,$replace($player.armour,$chr(32),-),APBoost),$v1,0), $&
        %shp $iif($readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),HPBoost),$v1,0), $&
        %sap $iif($readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),APBoost),$v1,0), $&
        %scc $iif($readini(MURK\data\Shield.ini,$replace($player.shield,$chr(32),-),CCBoost),$v1,0), $&
        %lhp $iif($readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),HPBoost),$v1,0), $&
        %lap $iif($readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),APBoost),$v1,0), $&
        %lcc $iif($readini(MURK\data\Legs.ini,$replace($player.legs,$chr(32),-),CCBoost),$v1,0)
      did -ra $dname 12 HP: $player.hp ( $+ $+(A: $iif($left(%ahp,1) != -,$+(+,%ahp),%ahp),$chr(44),$chr(32),S: ,$iif($left(%shp,1) != -,$+(+,%shp),%shp),$chr(44),$chr(32),L: ,$iif($left(%lhp,1) != -,$+(+,%lhp),%lhp)) $+ )
      did -ra $dname 13 AP: $player.ap ( $+ $+(A: $iif($left(%aap,1) != -,$+(+,%aap),%aap),$chr(44),$chr(32),S: ,$iif($left(%sap,1) != -,$+(+,%sap),%sap),$chr(44),$chr(32),L: ,$iif($left(%lap,1) != -,$+(+,%lap),%lap)) $+ )
      did -ra $dname 14 CC: $player.cc ( $+ $+(A: $iif($left(%acc,1) != -,$+(+,%acc),%acc),$chr(44),$chr(32),S: ,$iif($left(%scc,1) != -,$+(+,%scc),%scc),$chr(44),$chr(32),L: ,$iif($left(%lcc,1) != -,$+(+,%lcc),%lcc)) $+ )
    }
    if ($did == 7) { murk.save A | if ($dialog(MURK.Hub)) { murk.populatehub } }
    if ($did == 15) { murk.displaywind @murk.weaponrepairconfirm $bytes($readini(MURK\data\Weapon.ini,$replace($player.weaponbase,$chr(32),-),COST),b) }
    if ($did == 16) { murk.displaywind @murk.armourrepairconfirm $bytes($readini(MURK\data\Armour.ini,$replace($player.armourbase,$chr(32),-),COST),b) }
    if ($did == 17) { murk.displaywind @murk.shieldrepairconfirm $bytes($readini(MURK\data\Shield.ini,$replace($player.shieldbase,$chr(32),-),COST),b) }
  }
}


dialog MURK.Fight {
  title "MURK - Monster Fight!"
  size -1 -1 204 136
  option dbu
  box "", 1, 101 12 1 50
  text "HP: 0 (9999)", 2, 4 26 94 8
  text "You", 3, 4 1 93 8, center
  text "SEECRIT MONSTAR", 4, 105 1 94 8, center
  text "LVL:", 5, 4 12 31 8
  text "AP:", 6, 36 12 31 8
  text "CC:", 7, 68 12 31 8
  text "CC:", 8, 168 12 31 14
  text "AP:", 9, 136 12 31 14
  text "LVL:", 10, 104 12 31 14
  text "HP: 0 (9999)", 11, 104 26 95 8
  text "AI thinking...", 12, 108 43 91 8, center
  button "Attack", 13, 12 38 37 12
  button "Inventory", 14, 52 38 37 12
  button "Run (1337 coins)", 15, 18 52 67 12, ok
  text "Information area", 16, 1 66 202 8, center
  list 17, 1 84 75 48, size vsbar
  text "Aid Items, Double click to use.", 18, 2 75 73 8
  box "Combat History", 19, 79 78 120 53
  list 20, 83 86 111 42, size vsbar
}
on *:dialog:MURK.Fight:close:0:{
  if ($player.mhp) {
    player.removeitem 1 $ceil($calc(($player.checkquant(1,return) * .10) + $player.mhp))
    .timerMurk.Combat.Monster.Attack off
  }
}
on *:dialog:MURK.Fight:init:0:{
  var %inventory $hget(MURK.Player,Inventory), %tok 1, %d $dname
  while ($gettok(%inventory,%tok,44)) {
    %token = $gettok(%inventory,%tok,44)
    if ($readini(MURK\data\Aid.ini,$replace($gettok(%token,1,64),$chr(32),-),ID)) { did -a %d 17 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41))) }
    inc %tok
  }
}
on *:dialog:MURK.Fight:dclick:17:{
  var %ID $readini(MURK\data\Aid.ini,$replace($left($gettok($did(17).seltext,1,40),-1),$chr(32),-),ID)
  if ($player.checkquant(%ID,1)) {
    player.useaid $left($gettok($did(17).seltext,1,40),-1)
    var %line $did(17).sel
    ;did -c $dname 17 %line
    did -o $dname 17 %line $regsubex($did(17).seltext,/\((\d+)\)/,( $+ $calc(\t -1) $+ ))
  }
}
on *:dialog:MURK.Fight:sclick:*:{
  if ($did == 13) { murk.combat.player }
  if ($did == 15) { 
    if ($did(15) != Close) { .timerMurk.Combat.Monster.Attack off | player.removeitem 1 $ceil($player.mhp) | hdel MURK.Player Monster.HP | if ($dialog(MURK.Hub)) { did -e MURK.Hub 35,43 } }
  }
  if ($did == 14) { 
    if (!$dialog(MURK.Hub)) { dialog -md MURK.Hub MURK.Hub }
    else dialog -ve MURK.Hub
    did -fu MURK.hub 5 
  }
}
alias -l murk.startcombat {
  hadd MURK.Player InCombat 1
  %monster = $iif($1 && $1 !== BOSS,$1,$ini($+(MURK\data\,$iif($1 === BOSS,Boss,Monster),.ini),$r(1,$ini($+(MURK\data\,$iif($1 === BOSS,Boss,Monster),.ini),0))))
  if ($hget(MURK.Monster,LPPL)) { hfree MURK.Monster }
  hmake MURK.Monster 100
  hload -i MURK.Monster $+(MURK\data\,$iif($1 && $1 === BOSS,Boss,Monster),.ini) %monster
  hadd MURK.Monster Name %monster
  var %d MURK.Fight, %monsterulvl $calc($player.level * $hget(MURK.Monster,LPPL)), %monsterlvl $floor($calc(%monsterulvl $iif($r(1,2) == 1,+,-) (%monsterulvl *.10)))
  var %monsterhp $calc(%monsterlvl * $hget(MURK.Monster,HPPL)), $&
    %monsterap $iif($calc(%monsterlvl * $hget(MURK.Monster,APPL)) > 900,900 ( $+ $v1 $+ ),$v1), %monstercc $iif($calc(%monsterlvl * $hget(MURK.Monster,CCPL)) > 900,900 ( $+ $v1 $+ ),$v1)
  if (!$hget(MURK.Player,MaxDam) || !$hget(MURK.Player,MinDam)) {
    hadd MURK.Player MaxDam $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MaxDam)
    hadd MURK.Player MinDam $readini(MURK\data\Weapon.ini,$replace($player.weapon,$chr(32),-),MinDam)
    murk.save A
  }
  if (%monsterulvl == 0 && $player.level > 0) { hfree MURK.Monster | hdel MURK.Player InCombat | murk.displaywind @murk.criticalerror Monster $qt(%monster) does not exist. | halt }
  if (!$dialog(%d)) { dialog -md %d %d }
  else { did -e %d 13,14 | dialog -ve %d }
  if ($dialog(MURK.Hub)) { did -b MURK.Hub 35,43 }
  if (!$player.chp) hadd -m MURK.Player CHP $player.hp
  did -ra %d 2 HP: $player.chp ( $+ $player.hp $+ )
  did -ra %d 5 LVL: $player.level
  did -ra %d 6 AP: $iif($player.ap > 900,900 ( $+ $v1 $+ ),$v1)
  did -ra %d 7 CC: $iif($player.cc > 900,900 ( $+ $v1 $+ ),$v1)
  did -ra %d 4 $replace(%monster,-,$chr(32))
  did -ra %d 10 LVL: %monsterlvl
  hadd -m MURK.Player Monster.HP %monsterhp
  did -ra %d 11 HP: $player.mhp ( $+ %monsterhp $+ )
  did -ra %d 8 CC: %monstercc
  did -ra %d 9 AP: %monsterap
  set %murk.combat.turn $iif($r(1,2) == 1,Player,Monster)
  did -ra %d 15 Run ( $+ %monsterhp Coins)
  murkc TURN: %murk.combat.turn
  if (%murk.combat.turn == Player) {
    did -ra %d 16 It's your turn!
    did -ra %d 12 AI waiting...
  }
  elseif (%murk.combat.turn == Monster) {
    did -ra %d 16 It's the monsters turn!
    did -b %d 13,14
    .timerMurk.Combat.Monster.Attack 0 $iif($player.option(MonsterDelay),$v1,3) murk.combat.monster
  }
}

alias -l murk.combat.player {
  var %monsterattacktime $iif($player.option(MonsterDelay),$v1,3), %d MURK.Fight, $&
    %monsterap $gettok($did(%d,9),2,32), %playercc $player.cc, %monsterhp $player.mhp, $&
    %playerweapon $player.weapon, %playermind $hget(MURK.Player,MinDam), $&
    %playermaxd $hget(MURK.Player,MaxDam), $&
    %monsterlvl $gettok($did(MURK.Fight,10),2,32), $&
    %monsterbasehp $calc(%monsterlvl * $hget(MURK.Monster,HPPL)), $&
    %monsterlootchance $hget(MURK.Monster,LootChance), $&
    %monsterloottotal $numtok($hget(MURK.Monster,Loot),44), $&
    %monsterloot $hget(MURK.Monster,Loot), $&
    %monsterrarechance $hget(MURK.Monster,RareChance), $&
    %monsterrareloottotal $numtok($hget(MURK.Monster,RareLoot),44) $&
    %monsterrareloot $hget(MURK.Monster,RareLoot), $&
    %monster $hget(MURK.Monster,Name)
  set %murk.iscritical $iif($r(1,1000) <= $iif(%playercc > 900,900,$v1),1,0)
  if ($player.weaponhp == 0 && $player.weaponbasehp || $player.weight > $player.maxweight) { var %playermaxd $calc(%playermaxd * .10), %playermind $calc(%playermind * .10) }
  %murk.playerhit = $r(%playermind,%playermaxd)
  if (%murk.iscritical) { 
    did -a MURK.Fight 20 Player's hit is critical! Damage x2
    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    %murk.playerhit = $calc(%murk.playerhit * 2)
  }
  ; Apply weapon special effects
  ; Ice/Water Damage on dragons.
  if (*Dragon* iswm %monster) {
    if (%playerweapon == Ice Sword) { %murk.playerhit = $calc(%murk.playerhit + (%murk.playerhit * .50)) }
    if (%playerweapon == Water Sword) { %murk.playerhit = $calc(%murk.playerhit + (%murk.playerhit * .25)) }
    if (%playerweapon == Wet Sword) { %murk.playerhit = $calc(%murk.playerhit + (%murk.playerhit * .10)) }
  }
  if (%monster == Verlyt && $player.weaponbase == Verlyt Sword) {
    %murk.playerhit = $calc(%murk.playerhit * 2)
  }

  ; Champion's Shield healing

  if ($istok(Champion's Shield.Upgraded Champion's Shield,$player.shield,46) && $r(1,8) == 8) { 
    if ($player.shield != Upgraded Champion's Shield) { 
      %murk.playerhit = $calc(%murk.playerhit - (%murk.playerhit * .10))
      did -a MURK.Fight 20 Your shield uses some of your power
      did -a MURK.Fight 20 to heal you a little!
    }
    else {
      did -a MURK.Fight 20 Your shield manages to heal you
      did -a MURK.Fight 20 a little!
    }

    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    %newplayerhp = $ceil($calc($player.chp + (%murk.playerhit * .10)))
    murkc Player HP: $player.chp -> %newplayerhp
    hadd -m MURK.Player CHP $iif(%newplayerhp > $player.hp,$v2,%newplayerhp)
    did -ra %d 2 HP: $player.chp ( $+ $player.hp $+ )
  }

  ; - If the user's weapon is poisonous, apply the extra damage
  if (Poisoned* iswm $player.weapon) { 
    if (%murk.monsterpoisoned) {
      inc %murk.playerhit $round($calc(%monsterhp * .10),0)
      did -a MURK.Fight 20 The monster is damaged by poison!
      did -c MURK.Fight 20 $did(MURK.Fight,20).lines
      did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    }
    else {
      if ($r(1,10) <= 2) {
        did -a MURK.Fight 20 The monster is now poisoned!
        did -c MURK.Fight 20 $did(MURK.Fight,20).lines
        did -u MURK.Fight 20 $did(MURK.Fight,20).lines
        set %murk.monsterpoisoned 1
      }
    }
  }
  murkc Player hits (BM): %murk.playerhit
  ; - Apply the monster's AP bonus, providing the user isnt using  the "Thrio Sword" -
  if ($player.weaponbase != Thrio Sword) %murk.playerhit = $round($calc(%murk.playerhit - (%murk.playerhit * ($iif(%monsterap > 900,900,$v1) / 1000))),0)
  ; - If the player is using a weapon that degrades, update it's hp now.
  if (%murk.playerhit > $player.mhp) { %murk.playerhit = $player.mhp }
  player.degradeitems weapon %murk.playerhit
  murkc Player hits (AM): %murk.playerhit
  did -a MURK.Fight 20 Player hit: %murk.playerhit
  did -c MURK.Fight 20 $did(MURK.Fight,20).lines
  did -u MURK.Fight 20 $did(MURK.Fight,20).lines

  ; - Update The monster's HP -
  %monsterhp = $calc(%monsterhp - $round(%murk.playerhit,0))
  hadd -m MURK.Player Monster.HP $iif(%monsterhp < 1,0,%monsterhp)
  ; - Continue as required
  if ($player.mhp <= 0) {
    hadd -m MURK.Player Wins $calc($iif($hget(MURK.Player,Wins),$v1,0) +1)
    did -ra %d 11 HP: $player.mhp ( $+ %monsterbasehp $+ )
    hdel MURK.Player Monster.HP
    if ($player.wins == 1) { player.completequest 2 }
    if ($player.wins == 25) { player.completequest 4 }
    if ($player.wins >= 50 && !$player.challenge(50Wins)) { player.completequest 6 }
    if ($player.wins >= 100 && !$player.challenge(100Wins)) { player.completequest 7 }
    if ($player.wins >= 250 && !$player.challenge(250Wins)) { player.completequest 8 }
    if ($player.wins >= 350 && !$player.challenge(350Wins)) { player.completequest 9 }
    if ($player.wins >= 450 && !$player.challenge(450Wins)) { player.completequest 11 }
    if ($player.wins >= 550 && !$player.challenge(550Wins)) { player.completequest 12 }
    if ($player.wins >= 650 && !$player.challenge(650Wins)) { player.completequest 13 }
    ;if ($player.wins >= 750 && !$player.challenge(750Wins)) { player.completequest 14 }
    ;if ($player.wins >= 850 && !$player.challenge(850Wins)) { player.completequest 15 }
    ;if ($player.wins >= 1000 && !$player.challenge(1000Wins)) { player.completequest 16 }
    if (%monster == Verlyt && !$player.challenge(DefeatVerlyt)) { player.completequest 17 }
    did -ra %d 16 You Win! :)
    did -ra %d 12 FNT
    did -ra %d 15 Close
    did -a MURK.Fight 20 Player WINS!
    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    .timerMurk.Combat.Monster.Attack off
    hdel MURK.Player InCombat
    if ($hget(MURK.Player,VendorWaiting)) { murk.hubupdatevendor | hdel MURK.Player VendorWaiting }
    did -ve %d 15
    if ($dialog(MURK.Hub)) { did -ra MURK.Hub 30,29,28,27 Coins $bytes($player.checkquant(1,return),b) | did -e MURK.Hub 35,43 }
    if ($hget(MURK.Monster,AlwaysDrops)) { player.additem $hget(MURK.Monster,AlwaysDrops) 1 }
    var %rarehit $iif($player.checkquant(17,1),95,100)
    if (%monsterlootchance) {
      if ($r(1,100) <= %monsterlootchance) {
        var %lootitemid $gettok(%monsterloot,$r(1,%monsterloottotal),44)
        player.additem %lootitemid 1
        if ($player.option(SumInDialog)) {
          did -a MURK.Fight 20 $readini(MURK\data\Item.ini,%lootitemid,Name) Acquired.
          did -c MURK.Fight 20 $did(MURK.Fight,20).lines
          did -u MURK.Fight 20 $did(MURK.Fight,20).lines
        } 
        else {
          murk.displaywind @Murk.itemnotify $readini(MURK\data\Item.ini,%lootitemid,Name) Acquired.
        }
      }
    }
    if (%monsterrarechance) { 
      var %droprare $r(1,%rarehit)
      murkc %droprare \ %monsterrarechance \ %monsterrareloottotal
      if (%droprare <= %monsterrarechance) {
        var %rareitemid $gettok($gettok(%monsterrareloottotal,2,32),$r(1,$gettok(%monsterrareloottotal,1,32)),44)
        player.additem %rareitemid 1
        if ($player.option(SumInDialog)) {
          did -a MURK.Fight 20 (Rare) $readini(MURK\data\Item.ini,%rareitemid,Name) Acquired.
          did -c MURK.Fight 20 $did(MURK.Fight,20).lines
          did -u MURK.Fight 20 $did(MURK.Fight,20).lines
        } 
        else {
          murk.displaywind @Murk.itemnotify (Rare) $readini(MURK\data\Item.ini,%rareitemid,Name) Acquired.
        }
        if (!$player.rares) { player.completequest 5 }
        hadd -m MURK.Player RaresFound $calc($iif($player.rares,$v1,0) + 1)
      }
    }
    if ($dialog(MURK.Hub)) { 
      murk.populatehub 
      did -ra MURK.Hub 12 Current HP: $+($player.chp,/,$player.hp)
    }
    did -b %d 13,14
    var %coins $floor($calc(%monsterbasehp * ( $player.level * .10))), %exp $iif($hget(MURK.Monster,Exp),$v1,%monsterbasehp)
    murkc Coins to add: %coins
    player.additem 1 %coins
    player.addexp %exp
    if ($player.option(SumInDialog)) {
      did -a MURK.Fight 20 $+(+,$bytes(%exp,b),exp)
      did -a MURK.Fight 20 $+(+,$bytes(%coins,b),$chr(32),Coins)
      did -c MURK.Fight 20 $did(MURK.Fight,20).lines
      did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    } 
    else {
      murk.displaywind @murk.combatsum %coins %exp
    }
    unset %murk.monsterpoisoned
  }
  else {
    did -ra %d 16 It's the monsters turn!
    did -ra %d 12 AI thinking...
    did -ra %d 11 HP: $player.mhp ( $+ %monsterbasehp $+ )
    did -b %d 13,14
    .timerMurk.Combat.Monster.Attack 0 $iif($player.option(MonsterDelay),$v1,3) murk.combat.monster
  }
}
alias -l murk.combat.monster {
  var %d MURK.Fight, %monsterulvl $calc($player.level * $hget(MURK.Monster,LPPL)), $&
    %monsterlvl $gettok($did(MURK.Fight,10),2,32), $&
    %monstercc $calc(%monsterlvl * $hget(MURK.Monster,CCPL)), %monstermax $calc(%monsterlvl * $hget(MURK.Monster,MDPL)), %monster $hget(MURK.Monster,Name)
  set %murk.iscritical $iif($r(1,1000) <= $iif(%monstercc > 900,900,$v1),1,0)
  %murk.monsterhit = $r(0,%monstermax)
  if (%murk.iscritical) {
    did -a MURK.Fight 20 Monster's hit is critical! Damage x2
    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    %murk.monsterhit = $calc(%murk.monsterhit *2)
  }
  ; - Apply Armour effects
  ; - Fire armour and dragons, dragonfire shield & dragons

  if (*dragon* iswm %monster && $player.armour == Fire Armour) { %murk.monsterhit = $calc(%murk.monsterhit - (%murk.monsterhit * .50)) }
  if (*dragon* iswm %monster && $player.shield == Dragonfire Shield) { %murk.monsterhit = $calc(%murk.monsterhit - (%murk.monsterhit * .30))  }
  if (%monster == Verlyt && $r(1,20) == 1) {
    ; Verlyt Special attack player's (current hp) -1.
    var %php $player.chp, %murk.monsterhit $calc(%php -1)
    set -u1 %is.verlyt.spec 1
    did -a MURK.Fight 20 The monster uses it's special attack
    did -a MURK.Fight 20 enabling it to remove all but one of your hitpoints!
    did -a MURK.Fight 20 hitpoints!
    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
  }
  else {
    murkc Monster hits (BM): %murk.monsterhit
    ; - Apply the Player's AP bonus -
    %murk.monsterhit = $round($calc(%murk.monsterhit - (%murk.monsterhit * ($iif($player.ap > 900,900,$v1) / 1000))),0)
    player.degradeitems armour %murk.monsterhit
    murkc Monster hits (AM): %murk.monsterhit
    did -a MURK.Fight 20 Monster hit: %murk.monsterhit
    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
  }
  ; - Update the player's HP -
  var %playernewhp $calc($player.chp - %murk.monsterhit)
  hadd -m MURK.Player CHP $iif(%playernewhp < 0,0,%playernewhp)
  if ($player.chp < $calc($player.hp * .05) && !%is.verlyt.spec && $player.checkquant(103,1)) {
    dialog -c MURK.Fight 13
    murk.displaywind @murk.itemnotify You Book of Life teleports you to a safe distance away from the monster.
    .timerMurk.Combat.Monster.Attack off
    ;did -ve %d 15
    unset %murk.monsterpoisoned
    if ($dialog(MURK.Hub)) { murk.populatehub | did -e MURK.Hub 35,43 }
    hdel MURK.Player InCombat
    if ($hget(MURK.Player,VendorWaiting)) { murk.hubupdatevendor | hdel MURK.Player VendorWaiting }
    player.removeitem 103 1
    halt
  }
  elseif ($player.chp <= 0) {
    hadd -m MURK.Player Loses $calc($iif($hget(MURK.Player,Loses),$v1,0) +1)
    did -ra %d 2 HP: $player.chp ( $+ $player.hp $+ )
    hadd -m MURK.Player CHP $player.hp
    did -ra %d 16 You LOSE! :(
    did -a MURK.Fight 20 player LOSES! :(
    did -c MURK.Fight 20 $did(MURK.Fight,20).lines
    did -u MURK.Fight 20 $did(MURK.Fight,20).lines
    player.removeitem 1 $int($player.mhp)
    if ($player.loses == 1) { player.completequest 3 }
    did -ra %d 12 *Dances*
    did -ra %d 15 Close
    .timerMurk.Combat.Monster.Attack off
    did -ve %d 15
    unset %murk.monsterpoisoned
    if ($dialog(MURK.Hub)) { 
      murk.populatehub
      did -e MURK.Hub 35,43 
      did -ra MURK.Hub 12 Current HP: $+($player.chp,/,$player.hp)
    }
    hdel MURK.Player InCombat
    if ($hget(MURK.Player,VendorWaiting)) { murk.hubupdatevendor | hdel MURK.Player VendorWaiting }
  }
  else {
    did -ra %d 16 It's your turn!
    did -ra %d 12 AI waiting...
    did -ra %d 2 HP: $player.chp ( $+ $player.hp $+ )
    did -e %d 13,14
  }
}
dialog MURK.Hub {
  title "MURK - Hub"
  size -1 -1 408 333
  option pixels
  tab "Home", 1, 2 2 403 275
  text "Welcome to the MURK Hub. In the tabs here you'll be able to check out what armour you've found a long with heal up and buy more aid supplies. Be aware however, only aid items you currently own will be buyable, for a price...", 22, 17 35 377 44, tab 1
  button "Quit Game", 23, 8 239 75 25, tab 1
  button "Save Game", 24, 8 175 75 25, tab 1
  button "Load Game", 25, 8 207 75 25, tab 1
  button "New Game", 26, 8 144 75 25, tab 1
  button "Fight Now!", 35, 87 144 75 25, tab 1
  button "Report Bug", 36, 283 192 113 25, tab 1
  button "Options", 39, 87 239 75 25, tab 1
  button "Troubleshooting FAQ", 37, 283 166 113 25, tab 1
  text "Next trader in: 00:00", 38, 12 103 384 16, tab 1
  button "Boss Fight", 43, 87 175 75 25, tab 1
  text "Boss available in: 00:00", 42, 12 82 384 16, tab 1
  text "Weight: 13/37", 11, 112 123 181 16, tab 1 center
  icon 46, 315 223 80 40, ./MURK/img/gls.png, 0, tab 1 noborder
  tab "Weapons", 3
  list 6, 12 40 184 220, tab 3 size vsbar
  button "Open Armoury", 8, 208 216 160 24, tab 3
  button "Sell Selected", 16, 208 189 160 25, disable tab 3
  text "Coins: 99999", 27, 208 168 160 16, tab 3 center
  button "Modify Items", 34, 208 126 160 25, tab 3
  text "Weapon HP: 0/0", 44, 201 45 199 16, tab 3 center
  tab "Armour", 4
  list 7, 12 40 184 220, tab 4 size vsbar
  button "Open Armoury", 9, 208 216 160 24, tab 4
  button "Sell Selected", 17, 208 189 160 25, disable tab 4
  text "Coins: 99999", 28, 208 168 160 16, tab 4 center
  text "Armour HP: 0/0 - Shield HP: 0/0 - Legs HP: 0/0", 45, 205 42 190 66, tab 4 center
  button "Modify Items", 33, 208 126 160 25, tab 4
  tab "Aid", 5
  list 14, 12 40 164 220, tab 5 size vsbar
  button "Sell Selected", 18, 208 189 160 25, disable tab 5
  text "Double click an Aid item to use it. Single click to highlight and make available for selling and buying.", 20, 194 40 186 54, tab 5
  button "Buy Selected", 21, 208 216 160 25, disable tab 5
  text "Coins: 99999", 29, 208 169 160 16, tab 5 center
  text "", 32, 194 113 186 56, tab 5 center
  text "Current HP: 0/0", 12, 194 95 186 16, tab 5 center
  tab "Misc. Items", 10
  list 15, 12 40 184 220, tab 10 size vsbar
  button "Sell Selected", 19, 210 198 160 25, disable tab 10
  text "Coins: 99999", 30, 210 177 160 16, tab 10 center
  text "", 31, 210 37 161 132, tab 10 center
  button "Modify Items", 40, 210 225 160 25, tab 10
  button "Close", 2, 2 308 404 24, cancel
  text "Build: 0", 13, 310 4 89 16, disable right
  text "Loading MOTD...", 41, 1 275 404 31, center
}
alias -l murk.hubupdateboss {
  var %time $calc($hget(MURK.Player,NextBoss) - $ctime)
  if ($dialog(MURK.Hub) && %time >= 0) {
    did -ra MURK.Hub 42 Boss available in: $right($duration(%time,3),-3)
    if (!$timer(UpdateBoss)) { .timerUpdateBoss 0 1 murk.hubupdateboss }
  }
  else { 
    .timerUpdateBoss off
  }
}

on *:dialog:MURK.Hub:init:0:{
  did -ra $dname 13 Build: $murk.build
  if (!$hget(MURK.Items,Loaded)) { murk.loaditems }
  did -ra MURK.Hub 11 Weight: $player.weight $+ / $+ $player.maxweight
  murk.populatehub
  murk.hubchangemotd
  murk.hubupdatevendor
  murk.hubupdateboss
}
alias -l murk.hubchangemotd { did -ra MURK.Hub 41 $read(MURK\data\MOTD.dat,$r(1,$lines(MURK\data\MOTD.dat))) }
on *:dialog:MURK.Hub:dclick:*:{
  if ($did == 14) {
    var %ID $readini(MURK\data\Aid.ini,$replace($left($gettok($did(14).seltext,1,40),-1),$chr(32),-),ID)
    if ($player.checkquant(%ID,1)) {
      player.useaid $left($gettok($did(14).seltext,1,40),-1)
      var %line $did(14).sel
      ;did -c $dname 14 %line
      did -o $dname 14 %line $regsubex($did(14).seltext,/\((\d+)\)/,( $+ $calc(\t -1) $+ ))
    }
  }
}
on *:dialog:MURK.Hub:sclick:*:{
  if ($did == 39) { dialog -md MURK.Options MURK.Options }
  if ($did == 38) { murk.read.roll }
  if ($did == 36) { murk.displaywind @murk.reportbug }
  if ($did == 37) { url -a http://services.ipeerftw.co.cc/f/viewtopic.php?t=145 }
  if ($did == 26) { murk.start }
  if ($did == 24) { murk.save }
  if ($did == 23) { murk.save O | .timerMURK* off | .timermurk* off | close -@ @murk* | dialog -x $dname | hfree MURK.Player }
  if ($did == 25) { dialog -md MURK.Load MURK.Load }
  if ($did == 35) { murk.startcombat }
  if ($did == 43) {
    if ($hget(MURK.Player,NextBoss) == $null || $ctime >= $hget(MURK.Player,NextBoss)) {
      murk.startcombat BOSS
      hadd MURK.Player NextBoss $calc($ctime + $r(300,900))
      murk.hubupdateboss
    }
    else {
      murk.displaywind @murk.bosseshiding
    }
  }
  if ($did isnum 8-9) { dialog -md MURK.Armoury MURK.Armoury }
  if ($did == 14 && $did(14).seltext) { 
    var %t $did(14).seltext, %ID $readini(MURK\data\Aid.ini,$replace($left($gettok($did(14).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1),$chr(32),-),ID), %val $readini(MURK\data\Item.ini,%ID,VAL), %Desc $readini(MURK\data\Item.ini,%ID,DES)
    if ($player.checkquant(1,%val) && $player.checkquant(93,1)) {  did -e $dname 18,21 }
    else { did -b $dname 21 | did -e $dname 18 }
    did -ra $dname 18 Sell Selected $+($chr(40),%val,$chr(41))
    did -ra $dname 21 Buy Selected $+($chr(40),%val,$chr(41))
    did -ra $dname 32 %Desc
    if (!$player.checkquant(%ID,1)) did -b $dname 18
  }
  if ($did == 21) {
    var %t $did(14).seltext, %ID $readini(MURK\data\Aid.ini,$replace($left($gettok($did(14).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1),$chr(32),-),ID), %val $readini(MURK\data\Item.ini,%ID,VAL)
    player.additem %ID 1
    player.removeitem 1 %val
    var %line $did(14).sel, %text $did(14).seltext
    did -o $dname 14 %line $regsubex(%text,/\((\d+)\)/,( $+ $calc(\t +1) $+ ))
    did -c $dname 14 %line
    did -ra $dname 30,29,28,27 Coins $bytes($player.checkquant(1,return),b)
    if ($player.checkquant(%ID,1)) did -e $dname 18
    if (!$player.checkquant(1,%val)) { did -b $dname 21 }
  }
  if ($did == 18) {
    var %t $did(14).seltext, %ID $readini(MURK\data\Aid.ini,$replace($left($gettok($did(14).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1),$chr(32),-),ID), %val $readini(MURK\data\Item.ini,%ID,VAL)
    player.removeitem %ID 1
    player.additem 1 %val
    var %line $did(14).sel
    did -o $dname 14 %line $regsubex($did(14).seltext,/\((\d+)\)/,( $+ $calc(\t -1) $+ ))
    did -c $dname 14 %line

    did -ra $dname 30,29,28,27 Coins $bytes($player.checkquant(1,return),b)
    if (!$player.checkquant(%ID,1)) { did -b $dname 18 | did -d $dname 14 %line }
    if ($player.checkquant(1,%val)) { did -e $dname 21 }
  }
  if ($did == 6 && $did(6).seltext) {
    var %t $did(6).seltext, %ID $murk.getitemidbyname($left($gettok($did(6).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1)), %val $readini(MURK\data\Item.ini,%ID,VAL)
    did -ra $dname 16 Sell Selected ( $+ %val $+ )
    if ($player.checkquant(%ID,1)) did -e $dname 16
    else did -b $dname 16
  }
  if ($did == 16) {
    var %t $did(6).seltext, %name $left($gettok($did(6).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1), %ID $murk.getitemidbyname(%name), %val $readini(MURK\data\Item.ini,%ID,VAL)
    player.additem 1 %val
    player.removeitem %ID 1
    var %line $did(6).sel
    did -o $dname 6 %line $regsubex($did(6).seltext,/\((\d+)\)/,( $+ $calc(\t -1) $+ ))
    did -c $dname 6 %line
    did -ra $dname 30,29,28,27 Coins $bytes($player.checkquant(1,return),b) 
    if (!$player.checkquant(%ID,1)) { 
      did -d $dname 6 %line
      did -b $dname 16
      if ($player.weapon == %name) { 
        player.unequipitem %ID 
      } 
    }
    else did -e $dname 16
  }
  if ($did == 7 && $did(7).seltext) {
    var %t $did(7).seltext, %ID $murk.getitemidbyname($left($gettok($did(7).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1)), %val $readini(MURK\data\Item.ini,%ID,VAL)
    did -ra $dname 17 Sell Selected ( $+ %val $+ )
    if ($player.checkquant(%ID,1)) did -e $dname 17
    else did -b $dname 17
  }
  if ($did == 17) {
    var %t $did(7).seltext, %name $left($gettok($did(7).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1), %ID $murk.getitemidbyname(%name), %val $readini(MURK\data\Item.ini,%ID,VAL)
    player.additem 1 %val
    player.removeitem %ID 1
    var %line $did(7).sel
    did -o $dname 7 %line $regsubex($did(7).seltext,/\((\d+)\)/,( $+ $calc(\t -1) $+ ))
    did -c $dname 7 %line
    did -ra $dname 30,29,28,27 Coins $bytes($player.checkquant(1,return),b) 
    if (!$player.checkquant(%ID,1)) { 
      did -b $dname 17
      did -d $dname 7 %line
      if ($player.armour == %name) { 
        player.unequipitem %ID 
      } 
      if ($player.shield == %name) { 
        player.unequipitem %ID 
      } 
    }

    else did -e $dname 17
  }
  if ($did == 15 && $did(15).seltext) {
    var %t $did(15).seltext, %ID $murk.getitemidbyname($left($gettok($did(15).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1)), %val $readini(MURK\data\Item.ini,%ID,VAL), %desc $iif($readini(MURK\data\Item.ini,%ID,DES),$v1,No description.)
    did -ra $dname 19 Sell Selected ( $+ %val $+ )
    if ($player.checkquant(%ID,1)) did -e $dname 19
    else did -b $dname 19
    did -ra $dname 31 %desc
  }
  if ($did == 19) {
    var %t $did(15).seltext, %ID $murk.getitemidbyname($left($gettok($did(15).seltext,$+(1-,$calc($numtok(%t,40) - 1)),40),-1)), %val $readini(MURK\data\Item.ini,%ID,VAL)
    murkc %t
    player.additem 1 %val
    player.removeitem %ID 1
    var %line $did(15).sel
    did -o $dname 15 %line $regsubex($did(15).seltext,/\((\d+)\)/,( $+ $calc(\t -1) $+ ))
    did -c $dname 15 %line
    did -ra $dname 30,29,28,27 Coins $bytes($player.checkquant(1,return),b) 
    if (!$player.checkquant(%ID,1)) { did -b $dname 19 | did -d $dname 15 %line }
    else did -e $dname 19
  }
  if ($istok(33 34 40,$did,32)) { dialog -md MURK.Mods MURK.Mods }
}

on *:dialog:MURK.Hub:close:0:{
  .timerMURK.UpdateVendor off
}

alias -l murk.getitemidbyname {
  var %id 1, %name $1-, %t $ini(MURK\data\Item.ini,0), %found %t
  while ($readini(MURK\data\Item.ini,%id,Name) != %name && %id <= %t) { 
    inc %id
    dec %found
  }
  if (%found <= 0) { murkc No item found! - %if \ %name \ %t \ %found }
  else $iif($isid,return,murkc) %id
}

alias murk.populatehub {
  var %d MURK.Hub
  if (!$murk.player) { did -ra %d 6,7,14,15 You must load or start | did -a %d 6,7,14,15 a game before items will | did -a %d 6,7,14,15 be listed here. }
  else {
    did -r %d 6,7,14,15
    did -ra %d 30,29,28,27 Coins $bytes($player.checkquant(1,return),b)
    did -ra %d 44 Weapon HP: $bytes($player.weaponhp,b) $+ / $+ $bytes($player.weaponbasehp,b)
    did -ra %d 45 Armour HP: $bytes($player.armourhp,b) $+ / $+ $bytes($player.armourbasehp,b) $+ $crlf $+ Shield HP: $bytes($player.shieldhp,b) $+ / $+ $bytes($player.shieldbasehp,b) $+ $crlf $+ Legs HP: $bytes($player.legshp,b) $+ / $+ $bytes($player.legsbasehp,b) 
    var %inventory $hget(MURK.Player,Inventory), %tok 1
    while ($gettok(%inventory,%tok,44)) {
      %token = $gettok(%inventory,%tok,44)
      if (Coins* !iswm %token) {
        if ($qt($gettok(%token,1,64)) isin $hget(MURK.Items,Weapon)) { did -a %d 6 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41))) }
        elseif ($qt($gettok(%token,1,64)) isin $hget(MURK.Items,Armour) || $qt($gettok(%token,1,64)) isin $hget(MURK.Items,Shield) || $qt($gettok(%token,1,64)) isin $hget(MURK.Items,Legs)) { did -a %d 7 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41))) }
        elseif ($qt($gettok(%token,1,64)) isin $hget(MURK.Items,Aid)) { did -a %d 14 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41))) }
        else did -a %d 15 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41)))
      }
      inc %tok
    }
  }
}
dialog MURK.Options {
  title "MURK - Options"
  size -1 -1 366 223
  option pixels
  button "Done", 1, 285 192 75 25
  text "Window Text Colour", 2, 10 14 104 16
  combo 3, 118 12 59 100, size limit 2 drop
  text "Window Background Colour", 4, 10 34 133 16
  combo 5, 146 32 59 100, size limit 2 drop
  check "Show 'Close All' Dialog when MURK opens a notification window", 6, 10 143 327 20
  check "Automatically check for updates periodically", 7, 10 56 235 20
  scroll "", 8, 10 109 191 17, range 1 5 horizontal bottom
  text "Monster attack speed", 9, 11 88 111 16
  text "Insane", 10, 11 127 37 16
  text "Normal", 11, 89 127 38 16
  text "Snail's Pace", 12, 153 127 58 16
  check "Display fight summary in the fight dialog rather than popups", 13, 10 164 346 20
}
on *:dialog:MURK.Options:init:0:{
  did -zc MURK.Options 8 $iif($player.option(MonsterDelay),$v1,3)
  if ($istok($null 1,$player.option(AutoUpdate),32)) { did -c $dname 7 }
  if ($istok($null 1,$player.option(ShowCloseAll),32)) { did -c $dname  6 }
  if ($player.option(SumInDialog) == 1) { did -c $dname 13 }
  var %c 0, %text $iif($player.option(WinTextColour),$v1,13), %bg $iif($player.option(WinBGColour),$v1,01)
  while (%c <= 15) { 
    did -a MURK.Options 3,5 %c 
    if ($calc(%c - 1) == %text) { did -c MURK.Options 3 %c }
    if ($calc(%c - 1) == %bg) { did -c MURK.Options 5 %c }
    inc %c 
  }
}
on *:dialog:MURK.Options:sclick:*:{
  if ($did == 1) {
    player.option ShowCloseAll $did(6).state
    player.option AutoUpdate $did(7).state
    player.option MonsterDelay $did(8).sel
    player.option WinTextColour $iif($did(3) < 10,$+(0,$v1),$v1)
    player.option WinBGColour $iif($did(5) < 10,$+(0,$v1),$v1)
    player.option SumInDialog $did(13).state
    dialog -x $dname
  }
}
alias player.options player.option $1-
alias player.option {
  if ($2 != $null) {
    writeini MURK\data\user.ini Options $1 $iif($2-,$v1,0)
    murkc $1 \ $2-
  }
  else {
    $iif($isid,return,murkc) $iif($readini(MURK\data\user.ini,Options,$1),$v1,0)
  }
}

dialog MURK.Mods {
  title "MURK - Item Modifications"
  size -1 -1 312 314
  option pixels
  list 1, 10 24 130 188, size vsbar
  list 2, 170 24 130 188, size vsbar
  edit "", 3, 19 234 270 21, read center
  button "Confirm Modification", 4, 96 260 117 25
}
on *:dialog:MURK.Mods:*:*:{

  if ($devent == init) {
    if (!$hget(MURK.Items,Loaded)) { murk.loaditems }
    if (!$player.challenge(DirtyModder)) { player.completequest 10 }
    murk.populatemods
  }

  if ($devent == sclick && $did isnum 1-2) {
    if ($did(1).seltext && $did(2).seltext) {
      did -ra $dname 3 $iif($murk.applymod().IsValid,$readini(MURK\data\Item.ini,$v1,Name),Invalid Combination.)
    }
  }
  elseif ($devent == sclick && $did == 4 && $did(3) != Invalid Combination. && $did(3)) {
    murk.applymod
    if ($dialog(MURK.Hub)) { murk.populatehub }
    dialog -x $dname
  }

}

alias -l murk.populatemods {
  var %inventory = $hget(MURK.Player,Inventory), %tok 1, %d MURK.Mods
  while ($gettok(%inventory,%tok,44)) {
    %token = $v1
    %token2 = $gettok(%token,1,64)
    if ($qt(%token2) isin $hget(MURK.Items,Weapon) $&
      || $qt(%token2) isin $hget(MURK.Items,Armour) $&
      || $qt(%token2) isin $hget(MURK.Items,Shield) $&
      || $qt(%token2) isin $hget(MURK.Items,Legs)) { 
      did -a %d 1 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41))) 
    }
    elseif (Coins* !iswm %token || $qt(%token2) !isin $hget(MURK.Items,Aid)) { did -a %d 2 $gettok(%token,1,64) $iif($gettok(%token,2,64) > 0,$+($chr(40),$gettok(%token,2,64),$chr(41))) }
    inc %tok
  }
  unset %token
}

alias -l murk.applymod {
  %item = $gettok($did(MURK.Mods,1).seltext,1,40)
  %ItemID = $murk.getitemidbyname(%item)
  %secondary = $gettok($did(MURK.Mods,2).seltext,1,40)
  %secondaryID = $murk.getitemidbyname(%secondary)
  %mods = $readini(MURK\data\Item.ini,%ItemID,Mods) 
  %replacements = $readini(MURK\data\Item.ini,%ItemID,Modded)
  if ($findtok(%mods,%secondaryid,44)) {
    var %newitem $gettok(%replacements,$findtok(%mods,%secondaryid,44),44)
    if ($prop == IsValid) {
      return %newitem
      unset %item %ItemID %secondary %secondaryid %mods %replacements
      halt
    }
    elseif (!$player.checkquant(56,1)) { murk.displaywind @murk.needhammer | halt }
    murkc %newitem \ $readini(MURK\data\Item.ini,%newitem,Name)
    player.removeitem %ItemID 1
    player.removeitem %secondaryid 1
    player.additem %newitem 1
    if ($findtok($+($player.weapon,.,$player.armour,.,$player.shield),%item,44)) {
      player.unequipitem %ItemID
      player.equipitem %newitem
    }
    murk.displaywind @murk.modapplied
    hadd MURK.Player ModsApplied $calc($player.mods + 1)
    murk.save A
    unset %item %ItemID %secondary %secondaryid %mods %replacements
  }
}

alias -l murk.displayvendor {
  if ($murk.player) {
    var %next $r(1800,3599), %next2 $calc($ctime + %next)
    murkc VENDOR: %next \ %next2
    hadd -m MURK.Player NextVendor %next2
    .timerMURK.VendorAppear -io 1 %next murk.hubupdatevendor
    if ($dialog(MURK.Hub)) { murk.hubupdatevendor }
  }
}

alias -l murk.hubupdatevendor {
  if ($murk.player) {
    var %time $calc($hget(MURK.Player,NextVendor) - $ctime)
    if (!$timer(MURK.VendorAppear)) { .timerMURK.VendorAppear -io 1 $calc($hget(MURK.Player,NextVendor) - $ctime) murk.hubupdatevendor }
    if (%time <= 0) { 
      if ($hget(MURK.Player,InCombat)) {
        murkc Player is in combat, making vendor wait.
        hadd MURK.Player VendorWaiting 1
        .timerMURK.UpdateVendor -p | .timerMURK.VendorAppear -p
        halt
      }
      else {
      .timerMURK.UpdateVendor -p | .timerMURK.VendorAppear -p | murk.displayvendor | murk.displaywind @murk.trader | .timerMURK.TraderTimeout 1 30 murk.tradertimeout }
    }
    if ($dialog(MURK.Hub)) { 
      did -ra MURK.Hub 38 Next vendor in: $right($duration($calc($hget(MURK.Player,NextVendor) - $ctime),3),-3)
      if (!$timer(MURK.UpdateVendor)) { .timerMURK.UpdateVendor 0 1 murk.hubupdatevendor }
    }
  }
}

alias -l murk.tradertimeout {
  murk.displaywind @murk.tradertimeout
  murk.displayvendor
}

dialog MURK.Trade {
  title "MURK - Vendors"
  size -1 -1 199 124
  option dbu
  list 1, 5 7 89 102, size vsbar
  button "Done Trading", 2, 7 110 184 12, ok
  button "Buy Selected", 3, 110 13 72 12, disable
  button "Steal Selected", 4, 110 35 72 12, disable
  text "", 5, 99 50 95 57, center
  scroll "", 6, 110 26 72 8, range 1 9999 horizontal bottom
}

on *:dialog:MURK.Trade:init:0:{
  var %t $ini(MURK\data\Item.ini,0), %i 2
  while (%i <= %t) {
    if ($r(1,2) == 1 && !$readini(MURK\data\Item.ini,%i,IsRare)) {
      var %num $iif(%i == 3 || %i == 56,$r(0,20),$iif(%i == 4,$r(0,15),$iif(%i == 30,$r(0,15),$r(0,3))))), %item $readini(MURK\data\Item.ini,%i,Name)
      if (%num > 0) { did -a MURK.Trade 1 %item $+($chr(40),%num,$chr(41)) }
    }
    inc %i
  }
  if (!$player.checkquant(106,1) && $r(1,2) == 1) { did -a $dname 1 Battlement Platelegs $+($chr(40),1,$chr(41)) }
  if ($player.challenge(450Wins) && !$player.checkquant(107,1) && !$player.checkquant(108,1) && !$player.checkquant(109,1)) { did -a $dname 1 Broken Thrio Platelegs $+($chr(40),1,$chr(41)) }
}

on *:dialog:MURK.Trade:scroll:6: {
  if ($did(1).seltext) {
    var %price $iif($player.armour == Vendor Suit 13,.13,$iif($player.armour == Vendor Suit 11,.11,$iif($player.armour == Vendor Suit 9,.09,$iif($player.armour == Vendor Suit 7,.07,$iif($player.armour == Vendor Suit 5,.05,.15))))), $&
      %val $readini(MURK\data\Item.ini,$murk.getitemidbyname($gettok($did(1).seltext,1,40)),VAL), %tprice $ceil($calc((%val + (%val * %price)) * $did($did).sel))
    if (%tprice > $player.checkquant(1,return)) { did -b $dname 6,3 }
    else { did -e $dname 6,3 }
    did -ra $dname 4 Steal Selected $+($chr(40),$calc(46 - $did(6).sel),$chr(37),$chr(41))
    did -ra $dname 3 Buy $did($did).sel $+($Chr(40),%tprice coins,$chr(41))
  }
}

on *:dialog:MURK.Trade:sclick:*:{
  if ($did == 2) { murk.save A | .timerMURK.UpdateVendor -r | .timerMURK.VendorAppear -r | if ($dialog(MURK.Hub)) { murk.populatehub } }
  if ($did == 3) { 
    noop $regex($did(3),/(\d+) coins/i)
    var %n $regml(1)
    player.additem $murk.getitemidbyname($gettok($did(1).seltext,1,40)) $did(6).sel
    player.removeitem 1 %n
    var %line $did(1).sel
    did -o $dname 1 %line $regsubex($did(1).seltext,/\((\d+)\)/,( $+ $calc(\t - $did(6).sel) $+ ))
    did -c $dname 1 %line
    if ($gettok($did(1).seltext,2,40) == $($+(0,$chr(41)))) { did -d $dname 1 %line | did -b $dname 3,4 }
  }
  if ($did == 4) { 
    var %chancemax $iif($player.armour == Stealth Suit,105,$iif($player.armour == Stealth Suit mk II,110,100))), %chance $r(1,%chancemax)
    murkc STEAL: %chancemax \ %chance
    if (%chance <= 65) {
      dialog -x $dname
      .timerMURK.UpdateVendor -r
      .timerMURK.VendorAppear -r
      murk.displaywind @murk.itemnotify You've been caught trying to steal!
      hadd MURK.Player StealsFailed $calc($iif($player.failedsteals,$v1,0) + 1)
      murk.startcombat Angry-Vendor
    }
    else {
      murk.displaywind @murk.itemnotify You have successfully stolen $did(6).sel $+($left($gettok($did(1).seltext,1,40),-1),$iif($did(6).sel > 1,s))
      player.additem $murk.getitemidbyname($gettok($did(1).seltext,1,40)) $did(6).sel
      var %line $did(1).sel
      did -o $dname 1 %line $regsubex($did(1).seltext,/\((\d+)\)/,( $+ $calc(\t - $did(6).sel) $+ ))
      did -c $dname 1 %line
      hadd MURK.Player StealsSuccess $calc($iif($player.stealsuccess,$v1,0) + 1)
      if ($gettok($did(1).seltext,2,40) == $($+(0,$chr(41)))) { did -d $dname 1 %line }
    }  
  }
  if ($did == 1) {
    var %price $iif($player.armour == Vendor Suit 13,.13,$iif($player.armour == Vendor Suit 11,.11,$iif($player.armour == Vendor Suit 9,.09,$iif($player.armour == Vendor Suit 7,.07,$iif($player.armour == Vendor Suit 5,.05,.15))))), $&
      %val $readini(MURK\data\Item.ini,$murk.getitemidbyname($gettok($did(1).seltext,1,40)),VAL), %des $readini(MURK\data\Item.ini,$murk.getitemidbyname($gettok($did(1).seltext,1,40)),DES), $&
      %tprice $ceil($calc(%val + (%val * %price)))
    noop $regex($did(1).seltext,/\((\d+)\)/)
    var %n $regml(1)
    did -c $dname 6
    did -z $dname 6 1 %n
    did -ra $dname 5 %des
    did -ra $dname 3 Buy 1 $+($chr(40),$ceil($calc(%val + (%val * %price))) coins,$chr(41))
    if (%tprice > $player.checkquant(1,return)) { did -b $dname 6,3 }
    else { did -e $dname 6,3 }
    did -e $dname 4
    did -ra $dname 4 Steal Selected $+($chr(40),$calc(46 - $did(6).sel),$chr(37),$chr(41))
  }
}

alias -l murk.convertinventory {
  var %inventory $hget(MURK.Player,Inventory), %tok 1 
  while ($gettok(%inventory,%tok,44)) { 
    %token = $gettok(%inventory,%tok,44)
    echo -tsg %token
    if (Coins* iswm %token) { 
      hadd MURK.Player Coins $gettok(%token,2,64) 
    }
    elseif ($readini(MURK\data\Weapon.ini,$replace($gettok(%token,1,64),$chr(32),-),ID)) { 
      hadd MURK.Player Weapons $+($hget(MURK.Player,Weapons),$iif(%w > 0,$chr(44)))) $+ %token
      inc %w
    } 
    inc %tok 
  }
  unset %tok* %w
  echo -tg Done.
}
alias -l murk.loaditems {
  if ($hget(MURK.Items,Loaded)) { hfree MURK.Items }
  hmake MURK.Items 100
  hadd MURK.Items Loaded 1
  var %i 1
  while ($readini(MURK\data\Item.ini,%i,Name)) {
    var %n $v1, %t $readini(MURK\data\Item.ini,%i,Type)
    ;murkc %i \ %n \ %t
    if (%t == A) { hadd MURK.Items Armour $hget(MURK.Items,Armour) $+ $qt(%n) }
    if (%t == S) { hadd MURK.Items Shield $hget(MURK.Items,Shield) $+ $qt(%n) }
    if (%t == W) { hadd MURK.Items Weapon $hget(MURK.Items,Weapon) $+ $qt(%n) }
    if (%t == L) { hadd MURK.Items Legs $hget(MURK.Items,Legs) $+ $qt(%n) }
    if (%t == Ad) { hadd MURK.Items Aid $hget(MURK.Items,Aid) $+ $qt(%n) }
    inc %i
  }
}

alias -l MURK.masswindowtest { murk.displaywind @murk.itemnotify Test 1 | murk.displaywind @murk.itemnotify Test 2 | murk.displaywind @murk.itemnotify Test 3 | murk.displaywind @murk.itemnotify Test 4 | murk.displaywind @murk.itemnotify Test 5 }
