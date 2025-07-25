; TAG for the Atari 2600

    set tv ntsc
    set kernel_options no_blank_lines
    playfield:
    ................................
    ...........X...............X....
    ...XX..XX..X.......XX..XX..X....
    ...X.......X.......X.......X....
    .......X...............X........
    .......X...XXX.........X...XXX..
    ...X...X...........X...X........
    ...XX..............XX...........
    .......X...............X........
    .......X...............X........
    ................................
end
    player0:
    %00100010   ; <- p0 sprite0     (0)
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
    %00001000  ; <- p0 sprite1     (7)
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end

    player1:
    %00100010   ; <- p1 sprite0     (0)
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
    %00001000   ; <- p1 sprite1     (1)
    %00101010
    %00111110
    %01111111
    %10000111
    %10000101
    %10000000
end

          ;   Mirroring playfield to save memory
    


;   Color Constants
    const WHITE = $0F
    const PURPLE = $6A
    const GREEN = $BE

;   Animation Constants
    const frame0 = 0
    const frame1 = 1
    

    player0x = 50
    player0y = 50
    player1x = 70
    player1y = 70


    ;player0pointerlo = <player0
    ;player0pointerhi = >player0

    dim _animCounter = a

__main
;   Game logic
    
    ;================================================
    ;               PLAYER LOGIC
    ;================================================

    COLUP0 = PURPLE
    COLUP1 = GREEN
    player0height = 6
    player1height = 6

    if _animCounter > 100 then _animCounter = 0

    ; ---- Player 0 Movement -----------------------------------
    if joy0right then player0x = player0x + 1 : _animCounter + 1                                       ;   Right
    if joy0left then player0x = player0x - 1 : _animCounter + 1                                        ;   Left
    if joy0up then player0y = player0y - 1 : _animCounter + 1                                          ;   Up
    if joy0down then player0y = player0y + 1 : _animCounter + 1                                        ;   Down
    
    ; ---- Player 1 Movement -----------------------------------
    if joy1right then player1x = player1x + 1 : _animCounter + 1                                       ;   Right
    if joy1left then player1x = player1x - 1 : _animCounter + 1                                        ;   Left
    if joy1up then player1y = player1y - 1 : _animCounter + 1                                          ;   Up
    if joy1down then player1y = player1y + 1 : _animCounter + 1                                        ;   Down
    
    
    scorecolor = WHITE
    
    COLUPF = WHITE                              ;   PLAYFIELD =========================
    PF0 = %11110000                             ;       Turn on playfield border (left right)

    drawscreen 
    score = _animCounter
    goto __main

    

