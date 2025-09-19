; PET TAG for the Atari 2600

    ; Set assembler to use NTSC Northamerican format.
    set tv ntsc
    
    ; Remove spaces between playfield blocks
    set kernel_options no_blank_lines

    ; Sets the playfield to use p0 color on the right and p1 color on the left.
    CTRLPF = $23

; ======== PLAYFIELD ====
    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X..............................X
    X..XXXXXXX...............XX....X
    X.................XX..X..XX....X
    X..X.....X.....................X
    X..XXXXXXX.....................X
    X........................XX....X
    X......XXXXXX.....XX..X..XX..X.X
    X.X....X..............X......X.X
    X..............................X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

; ======== PLAYER SPRITES ========

    player0:
    %00100010
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end

    player1:
    %00100010
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
end

; ======== CONSTANTS : COLORS ========
    const WHITE = $0F
    const PURPLE = $6A
    const GREEN = $BE
    const YELLOW = $1E

    const CHASER = PURPLE
    const PREY = GREEN

; ======== VARIABLE DECLARATIONS ========
    a = 0
    b = 0
    c = 0
    d = 0
    g = 0
    h = 0
    i = 0
    j = 0
    k = 0
    l = 0

    dim _old0x = a
    dim _old0y = b
    dim _old1x = c
    dim _old1y = d
    dim _flags = e

    rem -- Split into bits 76543210
    _flags = 0
    
    _flags{0} = 0   
    _flags{1} = 0 

    rem -- Flags for remembering what direction the player was facing last.
    _flags{2} = 0   
    _flags{3} = 0   

    rem -- Flag to check who is doing chase
    _flags{4} = 0

    dim _swapCooldown = f
    dim _p0animCounter = g
    dim _p1animCounter = h
    dim _timer = i
    dim _frameCounter = j
    dim _soundTimer = k
    dim _soundID = l
    

    _swapCooldown = 0
; ======== DATA INITIALIZERS ========

    player0x = 120
    player0y = 39

    player1x = 30
    player1y = 60

    scorecolor = WHITE
    _timer = 30
    _soundTimer = 10
    score = 1800


; ================================================
;                  MAIN LOOP
; ================================================
__main
    if _flags{4} then COLUP1 = CHASER : COLUP0 = PREY
    if !_flags{4} then COLUP1 = PREY : COLUP0 = CHASER
    COLUPF = YELLOW
    PF0 = %11110000
    gosub __updateAnimations
    gosub __handleInput

    rem -- Handle frame counter
    _frameCounter = _frameCounter + 1
    rem -- Reset after 60 frames (1 second)
    if _frameCounter = 61 then _frameCounter = 0

    drawscreen
    score = score - 1
    gosub __handleTimer
    gosub __handleCollision
    gosub __handleSFX

    if _timer = 0 then gosub __victoryTheme

    goto __main

; ================================================
;                  SUB-ROUTINES
; ================================================


__handleInput
    rem -- Storing old positions for later
    _old0x = player0x
    _old0y = player0y

    _old1x = player1x
    _old1y = player1y

    rem -- Flag to check if moving
    rem -- Also resets movement flag at beginning of frame
    _flags{0} = 0
    _flags{1} = 0

    rem -- player0 movement
    if joy0right then player0x = player0x + 1 : _flags{0} = 1 : _flags{2} = 0 : _p0animCounter = _p0animCounter + 1
    if joy0left then player0x = player0x - 1 : _flags{0} = 1 : _flags{2} = 1 : _p0animCounter = _p0animCounter + 1
    if joy0up then player0y = player0y - 1  : _flags{0} = 1 : _p0animCounter = _p0animCounter + 1
    if joy0down then player0y = player0y + 1 : _flags{0} = 1 : _p0animCounter = _p0animCounter + 1

    rem -- Reset animation counter after 10 frames
    if _p0animCounter = 10 then _p0animCounter = 0

    if joy1right then player1x = player1x + 1 : _flags{1} = 1 : _flags{3} = 0 : _p1animCounter = _p1animCounter + 1
    if joy1left then player1x = player1x - 1 : _flags{1} = 1 : _flags{3} = 1 : _p1animCounter = _p1animCounter + 1
    if joy1up then player1y = player1y - 1 :  _flags{1} = 1 : _p1animCounter = _p1animCounter + 1
    if joy1down then player1y = player1y + 1 : _flags{1} = 1 : _p1animCounter = _p1animCounter + 1

    rem -- Reset animation counter
    if _p1animCounter = 10 then _p1animCounter = 0

    if !_flags{2} then REFP0 = 8
    if _flags{3} then REFP1 = 8

    return

__updateAnimations
    if _p0animCounter < 5 then gosub __p0frame0
    if _p0animCounter > 5 then gosub __p0frame1

    if _p1animCounter > 5 then gosub __p1frame0
    if _p1animCounter < 5 then gosub __p1frame1

    return

__p0frame0
    player0:
    %00100010
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end
    return

__p0frame1
    player0:
    %00001000
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end
    return

__p1frame0
    player1:
    %00100010
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
end
    return

__p1frame1
    player1:
    %00001000
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
end
    return


__handleCollision
    if collision(player0, playfield) then player0x = _old0x : player0y = _old0y
    if collision(player1, playfield) then player1x = _old1x : player1y = _old1y
    rem -- Swap characters and set reset swapping cooldown so it doesn't flash
    if collision(player0, player1) && _swapCooldown = 0 then _flags{4} = !_flags{4} : _swapCooldown = 30 : _soundID = 1

    rem -- Lower countdown 1 per frame
    if _swapCooldown > 0 then _swapCooldown = _swapCooldown - 1
    return


__victoryTheme
    rem Start the sequence if timer is 0
    if _soundTimer = 0 then _soundTimer = 20   

    rem Change note based on remaining time
    if _soundTimer > 15 then AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 18
    if _soundTimer <= 15 && _soundTimer > 10 then AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 16  
    if _soundTimer <= 10 && _soundTimer > 5 then AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 16  
    if _soundTimer <= 5 && _soundTimer > 0 then AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 14    

    rem Count down the timer
    if _soundTimer > 0 then _soundTimer = _soundTimer - 1

    rem Silence when done
    if _soundTimer = 0 then AUDV0 = 0
return



__handleTimer
    if _frameCounter = 60 then _timer = _timer - 1
    if _timer = 0 && _flags{4} then gosub __gameOverCat
    if _timer = 0 && !_flags{4} then gosub __gameOverDog

    return

__handleSFX
    if _soundTimer > 0 then _soundTimer = _soundTimer - 1
    if _soundTimer = 0 then AUDV0 = 0
    
    if _soundID = 1 then AUDV0 = 10 : AUDC0 = 4 : AUDF0 = 60

    _soundID = 0

    return

__gameOverCat

    player0x = 100
    player0x = 200
    player1x = 200
    player1y = 100

    scorecolor = $00
    
   playfield:
   ................................
   ...XX...X..XXX.....X.X.....X....
   ..X..X.X.X..X......XXX....X.....
   ..X....XXX..X.........XXXX......
   ..X..X.X.X..X.........X...X.....
   ...XX..X.X..X...................
   .................X...X..........
   .................X...X.X......X.
   .................X...X...XXX.X..
   .................X.X.X.X.X.X..X.
   ..................X.X..X.X.X.X..
end

    return

__gameOverDog

    player0x = 100
    player0y = 200

    player1x = 200
    player1y = 100
    
    scorecolor = $00
    
   playfield:
   ................................
   ..XXX..............X.X....XX....
   ..X..X.XXX.XXX....XXXX.....X....
   ..X..X.X.X.X.X.......XXXXXXX....
   ..X..X.X.X.X.X.......X.....X....
   ..XXX..XXX.XXX..................
   .............X...X...X..........
   ...........XXX...X...X.X......X.
   .................X...X...XXX.X..
   .................X.X.X.X.X.X..X.
   ..................X.X..X.X.X.X..
end

    return
