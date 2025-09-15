; PET TAG for the Atari 2600

    ; Set assembler to use NTSC Northamerican format.
    set tv ntsc
    
    ; Remove spaces between playfield blocks
    set kernel_options no_blank_lines

    ; Sets the playfield to use p0 color on the right and p1 color on the left.
    CTRLPF = $23

; ======== PLAYFIELD ====
    playfield:
    ..XXXXXXXXXXXXXXXXXXXXXXXXXXXX..
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

; ======== PLAYER SPRITES ========

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

; ================================================
;                  GAME LOGIC
; ================================================
__main

    COLUP0 = PURPLE
    COLUP1 = GREEN
    COLUPF = YELLOW

    drawscreen
    goto __main