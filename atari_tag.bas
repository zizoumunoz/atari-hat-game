; TO-DO HIDING IN WALLS

; TAG for the Atari 2600
    set tv ntsc
    set kernel_options no_blank_lines
    CTRLPF = $23
    playfield:
    ..XXXXXXXXXXXXXXXXXXXXXXXXXXX..
    ..X.............................
    ..X............X.........XX..X..
    ..X..X..XX........XX..X..XX..X..
    ..X..X...X.....X.............X..
    ..X..X..XX.....XXXXXXXXXXXXXXX..
    ..X............X.........XX.....
    .......XXXXXX.....XX..X..XX..X..
    ..X....X.......X......X......X..
    ..XXXXXX.XXXXXXXXXXXXXXXXXXXXX..
    ................................
end

;   === PLAYER SPRITES ===

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

;   Color Constants
    const WHITE = $0F
    const PURPLE = $6A
    const GREEN = $BE
    const YELLOW = $1E
    
    player0x = 120
    player0y = 39
    player1x = 30
    player1y = 45

    ballx = 60
    bally = 192
    ballheight = 4
    
    
    a = 0
    dim _p0animCounter = a
    b = 0
    dim _p1animCounter = b

    c = 0
    dim _new0x = c
    d = 0
    dim _old0y = d
    e = 0
    dim _old1x = e
    f = 0
    dim _old1y = f

    
    scorecolor = WHITE
    
__main
    
    ;================================================
    ;               GAME LOGIC
    ;================================================

    COLUP0 = PURPLE
    COLUP1 = GREEN
    COLUPF = YELLOW
    
    PF0 = %11110000
    score = score + 1
    
    drawscreen
    goto __p0movement
    goto __p1movement
    goto __main

__p0movement
    
    ; Movement, then collision checking
    if joy0right then player0x = player0x + 1 : REFP0 = 8 : _p0animCounter = _p0animCounter + 1
    if collision(player0, playfield) then player0x = player0x - 1

    if joy0left then player0x = player0x - 1 : _p0animCounter = _p0animCounter + 1
    if collision(player0, playfield) then player0x = player0x + 1    

    if joy0up then player0y = player0y - 1 : _p0animCounter = _p0animCounter + 1

    if joy0down then player0y = player0y + 1 : _p0animCounter = _p0animCounter + 1

    if _p0animCounter = 1 then goto __p0walkframe0
    if _p0animCounter = 5 then goto __p0walkframe1
    if _p0animCounter > 10 then _p0animCounter = 0

__p1movement

    if joy1right then player1x = player1x + 1  : _p1animCounter = _p1animCounter + 1

    if joy1left then player1x = player1x - 1: REFP1 = 8 : _p1animCounter = _p1animCounter + 1

    if joy1up then player1y = player1y - 1 : _p1animCounter = _p1animCounter + 1

    if joy1down then player1y = player1y + 1 : _p1animCounter = _p1animCounter + 1

    if _p1animCounter = 1 then goto __p1walkframe0
    if _p1animCounter = 5 then goto __p1walkframe1
    if _p1animCounter > 10 then _p1animCounter = 0
    goto __main

__p0walkframe0
    player0:
    %00100010
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end
    goto __main

__p0walkframe1
    player0:
    %00001000
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end
    goto __main

__p1walkframe0
    player1:
    %00100010
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
end
    goto __main

__p1walkframe1
    player1:
    %00001000
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
end
    goto __main
