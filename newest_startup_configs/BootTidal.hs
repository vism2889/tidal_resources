:set -XOverloadedStrings
:set prompt ""
:module Sound.Tidal.Context

import Sound.Tidal.Context

(midicmd, midicmd_p) = pS "midicmd" (Nothing)
(midichan, midichan_p) = pF "midichan" (Nothing)
(progNum, progNum_p) = pF "progNum" (Nothing)
(val, val_p) = pF "val" (Nothing)
(uid, uid_p) = pF "uid" (Nothing)
(array, array_p) = pF "array" (Nothing)
(frames, frames_p) = pF "frames" (Nothing)
(seconds, seconds_p) = pF "seconds" (Nothing)
(minutes, minutes_p) = pF "minutes" (Nothing)
(hours, hours_p) = pF "hours" (Nothing)
(frameRate, frameRate_p) = pF "frameRate" (Nothing)
(songPtr, songPtr_p) = pF "songPtr" (Nothing)
(ctlNum, ctlNum_p) = pF "ctlNum" (Nothing)
(control, control_p) = pF "control" (Nothing)

(cps, nudger, getNow) <- cpsUtils'

(c1,ct1) <- dirtSetters getNow
(c2,ct2) <- dirtSetters getNow
(c3,ct3) <- dirtSetters getNow
(c4,ct4) <- dirtSetters getNow
(c5,ct5) <- dirtSetters getNow
(c6,ct6) <- dirtSetters getNow
(c7,ct7) <- dirtSetters getNow
(c8,ct8) <- dirtSetters getNow
(c9,ct9) <- dirtSetters getNow

(d1,t1) <- superDirtSetters getNow
(d2,t2) <- superDirtSetters getNow
(d3,t3) <- superDirtSetters getNow
(d4,t4) <- superDirtSetters getNow
(d5,t5) <- superDirtSetters getNow
(d6,t6) <- superDirtSetters getNow
(d7,t7) <- superDirtSetters getNow
(d8,t8) <- superDirtSetters getNow
(d9,t9) <- superDirtSetters getNow


let bps x = cps (x/2)
let hush = mapM_ ($ silence) [d1,d2,d3,d4,d5,d6,d7,d8,d9,c1,c2,c3,c4,c5,c6,c7,c8,c9]
let solo = (>>) hush






let gtfo p = (const $ sound "~") p

let startclock d p = do now <- getNow; d $ (pure (nextSam now)) ~> p

let oneshot d p = startclock d $ seqP [(0, 1, p)]




let faux p =  every 4 (slow 2) $ sometimes (|*| up (choose[3, 15, 2, 9, (-3), 11, 17, (-7), (-9), (-2)])) p
    faux' a p = every 1 (slow 1 . stut a 0.9 0.5) $ sometimes (|*| up ((scale (-4) 18 sine)*(slow 8 saw))) p



let twist a b c p = within (a, b) (slow 4 . rev . stut c 0.75 0.5) p
    perxrid =  whenmod 16 12 (const $ sound "[glitch:3*4 glitch:9*4 trp:17*4 ~]") $ whenmod 10 6 (const $ sound "[trp:8*4, trp:9]*2") $ sound "[trp:8*4, Morgo:9]" -- mainly an example of how you can use samples and very specific events inside a function
    fuk p =  every 4 (slow 2) $ sometimes (|*| up (choose[3, 15, 2, 9, (-3), 11, 17, (-7), (-9), (-2)])) p
    fuk' a p = every 1 (slow 1 . stut a 0.9 0.5) $ sometimes (|*| up ((scale (-4) 18 sine)*(slow 8 saw))) p
    pop3 a b p = stut' 3(a) (|*| speed b) p
    pop4 a b p = stut' 4(a) (|*| speed b) p
    unchained p = (0.25 ~>) $ every 8(pop4 0.125 1.2) $ every 6 (twist 0.25 1.0 (choose [16])) p
    dip p =  every 6 (density 4. slow 4) $ whenmod 16 10 ( ifp ((== 0).(flip mod 5))(stut 8 0.25  0.75)(# coarse "6 16 20 27"))  $ sometimes (|*| speed "[0.9 0.8 1.15, 1 0.7 1.0]") p

let filler p = every 3 (within (0.0, 0.50)(slow 2 . rev . stut 8 0.95 0.25)) $ every 7 (within (0.5, 0.75)(stut 4 0.95 0.25)) $ someCyclesBy 0.125 (within (0.75, 1.0)(striate 32)) p
    maven a b c p = stut' 4(a) (|*| coarse b ) $ stut' 4(1) (|*| speed c ) p --ex: $ maven 0.125 0.2 0.4
    realAF p = every 3 (slow 2) $ someCyclesBy 0.125 (stut 8 0.95 0.25) $ every 16 (within (0.5,0.75)(slow 4 . striate 16)) p
    verbPat  = room "0.0 0.0 0.8 0.0 0.0 0.0 0.2 0.0"

let unchained a p = (0.25 ~>) $ every 8(pop4 0.125 a) $ every 6 (twist 0.25 1.0 (choose [16])) p
    dip p =  every 6 (density 4. slow 4) $ whenmod 16 10 ( ifp ((== 0).(flip mod 5))(stut 8 0.25  0.75)(# coarse "6 16 20 27"))  $ sometimes (|*| speed "[0.9 0.8 1.15, 1 0.7 1.0]") p
    ladder a b p =  when ((elem a).show)(rev . striate b) p -- EX: $ ladder '2' 16
    frac a p =  when ((elem a).show)(within (0.25, 1.0) (slow 4 . stut 16 0.75 0.5)) p -- EX: $ frac '2'
    frac' p = ifp ((== 0).(flip mod 8))(within (0.25, 1.0) (slow 4 . rev . stut 8 0.75 0.25))(# speed "0.75") p

:set prompt "tidal> "
