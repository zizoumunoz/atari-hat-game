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

; ======== VARIABLE DECLARATIONS ========
    a = 0
    dim _old0x = a
    b = 0
    dim _old0y = b

; ======== PLAYER DATA INITIALIZERS ========

    player0x = 120
    player0y = 39

    player1x = 30
    player1y = 60

; ================================================
;                  SUB-ROUTINES
; ================================================



; ================================================
;                  MAIN LOOP
; ================================================
__main

    COLUP0 = PURPLE
    COLUP1 = GREEN
    COLUPF = YELLOW
    PF0 = %11110000

    gosub __handleInput

    drawscreen
    goto __main

__handleInput
    rem -- Storing old positions for later
    _old0x = player0x
    _old0y = player0y

    rem -- player0 movement
    if joy0right then player0x = player0x + 1 : REFP0 = 8
    if joy0left then player0x = player0x - 1
    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 1

    rem -- player1 movement
    if joy1right then player1x = player1x + 1
    if joy1left then player1x = player1x - 1 : REFP1 = 8
    if joy1up then player1y = player1y - 1
    if joy1down then player1y = player1y + 1
    return
