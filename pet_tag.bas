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
    dim _old0x = a
    b = 0
    dim _old0y = b

    c = 0
    dim _old1x = c
    d = 0
    dim _old1y = d

    dim _flags = e
    _flags = 0

    
    _flags{0} = 0   
    _flags{1} = 0 

    rem -- Flags for remembering what direction the player was facing last.
    _flags{2} = 0   
    _flags{3} = 0   

    rem -- Flag to check who is doing chase
    _flags{4} = 0

    dim _swapCooldown = f
    _swapCooldown = 0

    g = 0
    dim _p0animCounter = g
    h = 0
    dim _p1animCounter = h

; ======== PLAYER DATA INITIALIZERS ========

    player0x = 120
    player0y = 39

    player1x = 30
    player1y = 60


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
    drawscreen

    gosub __handleCollision
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
    if joy0up then player0y = player0y - 1  : _flags{0} = 1 : _flags : _p0animCounter = _p0animCounter + 1
    if joy0down then player0y = player0y + 1 : _flags{0} = 1 : _p0animCounter = _p0animCounter + 1

    rem -- Reset animation counter after 1 second/60 frames
    if _p0animCounter = 120 then _p0animCounter = 0

    if joy1right then player1x = player1x + 1 : _flags{1} = 1 : _flags{3} = 0
    if joy1left then player1x = player1x - 1 : _flags{1} = 1 : _flags{3} = 1
    if joy1up then player1y = player1y - 1 :  _flags{1} = 1
    if joy1down then player1y = player1y + 1 : _flags{1} = 1

    if !_flags{2} then REFP0 = 8
    if _flags{3} then REFP1 = 8

    return

__updateAnimations
    if _p0animCounter = 30 then gosub __p0frame0
    if _p0animCounter = 59 then gosub __p0frame1
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


__handleCollision
    if collision(player0, playfield) then player0x = _old0x : player0y = _old0y
    if collision(player1, playfield) then player1x = _old1x : player1y = _old1y
    rem -- Swap characters and set reset swapping cooldown so it doesn't flash
    if collision(player0, player1) && _swapCooldown = 0 then _flags{4} = !_flags{4} : _swapCooldown = 30

    rem -- Lower countdown 1 per frame
    if _swapCooldown > 0 then _swapCooldown = _swapCooldown - 1
    return

