    .text
    .org 0x0000

    // ===================================== Pruebas iniciales =====================================

    MOVZ X1, #0xFFFF, LSL #0
    STUR X1, [X0, #0xB0] // MEM 22:0xFFFF

    MOVZ X1, #0xAAAA, LSL #0
    STUR X1, [X0, #0xB8] // MEM 23:0xAAAA

    LDUR X2, [X0, #0xB0]

    ADD X3, X2, X2
    STUR X3, [X0, #0xC0] // MEM 24:0x1fffe

    // Reiniciar registros modificados

    MOVZ X1, #0x1, LSL #0
    MOVZ X2, #0x2, LSL #0
    MOVZ X3, #0x3, LSL #0

    // ===================================== Pruebas de MOVZ =====================================

    MOVZ X29, #0xFFFF, LSL #0
    STUR X29, [X0, #0xC8] // MEM 25: 0xFFFF

    MOVZ X29, #0xFFFF, LSL #16
    STUR X29, [X0, #0xD0] // MEM 26: 0xFFFF0000

    MOVZ X29, #0xFFFF, LSL #32
    STUR X29, [X0, #0xD8] // MEM 27: 0xFFFF00000000

    MOVZ X29, #0xFFFF, LSL #48
    STUR X29, [X0, #0xE0] // MEM 28: 0xFFFF000000000000

    // Reiniciar registros modificados

    MOVZ X29, #0x1D, LSL #0

    // ===================================== Programa base brindado =====================================

    STUR X1, [X0, #0] // MEM 0:0x1
    STUR X2, [X0, #8] // MEM 1:0x2
    STUR X3, [X16, #0] // MEM 2:0x3
    ADD X3, X4, X5
    STUR X3, [X0, #24] // MEM 3:0x9
    SUB X3, X4, X5
    STUR X3, [X0, #32] // MEM 4:0xFFFFFFFFFFFFFFFF
    SUB X4, XZR, X10
    STUR X4, [X0, #40] // MEM 5:0xFFFFFFFFFFFFFFF6
    ADD X4, X3, X4
    STUR X4, [X0, #48] // MEM 6:0xFFFFFFFFFFFFFFF5
    SUB X5, X1, X3
    STUR X5, [X0, #56] // MEM 7:0x2
    AND X5, X10, XZR
    STUR X5, [X0, #64] // MEM 8:0x0
    AND X5, X10, X3
    STUR X5, [X0, #72] // MEM 9:0xA
    AND X20, X20, X20
    STUR X20, [X0, #80] // MEM 10:0x14
    ORR X6, X11, XZR
    STUR X6, [X0, #88] // MEM 11:0xB
    ORR X6, X11, X3
    STUR X6, [X0, #96] // MEM 12:0xFFFFFFFFFFFFFFFF
    LDUR X12, [X0, #0]
    ADD X7, X12, XZR
    STUR X7, [X0, #104] // MEM 13:0x1
    STUR X12, [X0, #112] // MEM 14:0x1
    ADD XZR, X13, X14
    STUR XZR, [X0, #120] // MEM 15:0x0
    CBZ X0, L1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [X0, #128] // MEM 16:0x0(si falla CBZ =21)

L1:
    STUR X21, [X0, #136] // MEM 17:0x15
    ADD X2, XZR, X1

L2: 
    SUB X2, X2, X1
    ADD X24, XZR, X1
    STUR X24, [X0, #144] // MEM 18:0x1 y MEM 19=0x1
    ADD X0, X0, X8
    CBZ X2, L2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #144] // MEM 20:0x1E
    ADD X30, X30, X30
    SUB X21, XZR, X21
    ADD X30, X30, X20
    LDUR X25, [X30, #-8]
    ADD X30, X30, X30
    ADD X30, X30, X16
    STUR X25, [X30, #-8] // MEM 21:0xA (= MEM 9)

finloop:
    CBZ XZR, finloop
