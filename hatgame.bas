;   Author: Zinadine M. L.

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X.............X.X..............X
    X.............XXX..............X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X.............XXX..............X
    X.............X.X..............X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

;   Constants
    const WHITE = $0E
    const YELLOW = $1E


;   Main loop
mainloop
    drawscreen
    COLUPF = YELLOW

    goto mainloop


