#!/bin/bash

# OpenCPI get/set instructions
# get [<instance> [<property]] # get info from bitstream
# set <instance> <property> <value>

# 7.5.1 Recommended Initial Power-Up Sequence
#  1. Apply power to device.
#  2. Program RESET = 1 to reset registers.
#  3. Program RESET = 0 to remove reset.
#  4. Program registers as shown in the register map in REVERSE order from highest to lowest.
#  5. Wait 10 ms.
#  6. Program register R0 one additional time with FCAL_EN = 1 to ensure that the VCO calibration runs from a stable state.

# PLL 314.5728 MHz VCO 100.00 MHz

WORKER_INDEX=3

# Unreset Worker
ocpihdl wunreset $WORKER_INDEX

# Set the control register timeout
ocpihdl wwctl $WORKER_INDEX 0x80000012

# Start Worker
ocpihdl wop $WORKER_INDEX start

# Register 0 (Power-Up Sequence 1-3)
ocpihdl set $WORKER_INDEX register_0 0x2412
ocpihdl set $WORKER_INDEX register_0 0x2410

# Register 106
ocpihdl set $WORKER_INDEX register_106 0x0000
ocpihdl -x get $WORKER_INDEX register_106

# Register 105
ocpihdl set $WORKER_INDEX register_105 0x0021
ocpihdl -x get $WORKER_INDEX register_105

# Register 104
ocpihdl set $WORKER_INDEX register_104 0x0000
ocpihdl -x get $WORKER_INDEX register_104

# Register 103
ocpihdl set $WORKER_INDEX register_103 0x0000
ocpihdl -x get $WORKER_INDEX register_103

# Register 102
ocpihdl set $WORKER_INDEX register_102 0x3F80
ocpihdl -x get $WORKER_INDEX register_102

# Register 101
ocpihdl set $WORKER_INDEX register_101 0x0011
ocpihdl -x get $WORKER_INDEX register_101

# Register 100
ocpihdl set $WORKER_INDEX register_100 0x0000
ocpihdl -x get $WORKER_INDEX register_100

# Register 99
ocpihdl set $WORKER_INDEX register_99 0x0000
ocpihdl -x get $WORKER_INDEX register_99

# Register 98
ocpihdl set $WORKER_INDEX register_98 0x0200
ocpihdl -x get $WORKER_INDEX register_98

# Register 97
ocpihdl set $WORKER_INDEX register_97 0x0888
ocpihdl -x get $WORKER_INDEX register_97

# Register 96
ocpihdl set $WORKER_INDEX register_96 0x0000
ocpihdl -x get $WORKER_INDEX register_96

# Register 95
ocpihdl set $WORKER_INDEX register_95 0x0000
ocpihdl -x get $WORKER_INDEX register_95

# Register 94
ocpihdl set $WORKER_INDEX register_94 0x0000
ocpihdl -x get $WORKER_INDEX register_94

# Register 9$WORKER_INDEX
ocpihdl set $WORKER_INDEX register_93 0x0000
ocpihdl -x get $WORKER_INDEX register_93

# Register 92
ocpihdl set $WORKER_INDEX register_92 0x0000
ocpihdl -x get $WORKER_INDEX register_92

# Register 91
ocpihdl set $WORKER_INDEX register_91 0x0000
ocpihdl -x get $WORKER_INDEX register_91

# Register 90
ocpihdl set $WORKER_INDEX register_90 0x0000
ocpihdl -x get $WORKER_INDEX register_90

# Register 89
ocpihdl set $WORKER_INDEX register_89 0x0000
ocpihdl -x get $WORKER_INDEX register_89

# Register 88
ocpihdl set $WORKER_INDEX register_88 0x0000
ocpihdl -x get $WORKER_INDEX register_88

# Register 87
ocpihdl set $WORKER_INDEX register_87 0x0000
ocpihdl -x get $WORKER_INDEX register_87

# Register 86
ocpihdl set $WORKER_INDEX register_86 0x0000
ocpihdl -x get $WORKER_INDEX register_86

# Register 85
ocpihdl set $WORKER_INDEX register_85 0xD300
ocpihdl -x get $WORKER_INDEX register_85

# Register 84
ocpihdl set $WORKER_INDEX register_84 0x0001
ocpihdl -x get $WORKER_INDEX register_84

# Register 8$WORKER_INDEX
ocpihdl set $WORKER_INDEX register_83 0x0000
ocpihdl -x get $WORKER_INDEX register_83

# Register 82
ocpihdl set $WORKER_INDEX register_82 0x1E00
ocpihdl -x get $WORKER_INDEX register_82

# Register 81
ocpihdl set $WORKER_INDEX register_81 0x0000
ocpihdl -x get $WORKER_INDEX register_81

# Register 80
ocpihdl set $WORKER_INDEX register_80 0x6666
ocpihdl -x get $WORKER_INDEX register_80

# Register 79
ocpihdl set $WORKER_INDEX register_79 0x0026
ocpihdl -x get $WORKER_INDEX register_79

# Register 78
ocpihdl set $WORKER_INDEX register_78 0x0003
ocpihdl -x get $WORKER_INDEX register_78

# Register 77
ocpihdl set $WORKER_INDEX register_77 0x0000
ocpihdl -x get $WORKER_INDEX register_77

# Register 76
ocpihdl set $WORKER_INDEX register_76 0x000C
ocpihdl -x get $WORKER_INDEX register_76

# Register 75
ocpihdl set $WORKER_INDEX register_75 0x09C0
ocpihdl -x get $WORKER_INDEX register_75

# Register 74
ocpihdl set $WORKER_INDEX register_74 0x0000
ocpihdl -x get $WORKER_INDEX register_74

# Register 73
ocpihdl set $WORKER_INDEX register_73 0x003F
ocpihdl -x get $WORKER_INDEX register_73

# Register 72
ocpihdl set $WORKER_INDEX register_72 0x0001
ocpihdl -x get $WORKER_INDEX register_72

# Register 71
ocpihdl set $WORKER_INDEX register_71 0x0081
ocpihdl -x get $WORKER_INDEX register_71

# Register 70
ocpihdl set $WORKER_INDEX register_70 0xC350
ocpihdl -x get $WORKER_INDEX register_70

# Register 69
ocpihdl set $WORKER_INDEX register_69 0x0000
ocpihdl -x get $WORKER_INDEX register_69

# Register 68
ocpihdl set $WORKER_INDEX register_68 0x03E8
ocpihdl -x get $WORKER_INDEX register_68

# Register 67
ocpihdl set $WORKER_INDEX register_67 0x0000
ocpihdl -x get $WORKER_INDEX register_67

# Register 66
ocpihdl set $WORKER_INDEX register_66 0x01F4
ocpihdl -x get $WORKER_INDEX register_66

## Register 65 -- SDO Goes High
ocpihdl set $WORKER_INDEX register_65 0x0000
ocpihdl -x get $WORKER_INDEX register_65

# Register 64
ocpihdl set $WORKER_INDEX register_64 0x1388
ocpihdl -x get $WORKER_INDEX register_64

# Register 63
ocpihdl set $WORKER_INDEX register_63 0x0000
ocpihdl -x get $WORKER_INDEX register_63

# Register 62
ocpihdl set $WORKER_INDEX register_62 0x0322
ocpihdl -x get $WORKER_INDEX register_62

# Register 61
ocpihdl set $WORKER_INDEX register_61 0x00A8
ocpihdl -x get $WORKER_INDEX register_61

# Register 60
ocpihdl set $WORKER_INDEX register_60 0x0000
ocpihdl -x get $WORKER_INDEX register_60

# Register 59
ocpihdl set $WORKER_INDEX register_59 0x0001
ocpihdl -x get $WORKER_INDEX register_59

# Register 58
ocpihdl set $WORKER_INDEX register_58 0x8001
ocpihdl -x get $WORKER_INDEX register_58

# Register 57
ocpihdl set $WORKER_INDEX register_57 0x0020
ocpihdl -x get $WORKER_INDEX register_57

# Register 56
ocpihdl set $WORKER_INDEX register_56 0x0000
ocpihdl -x get $WORKER_INDEX register_56

# Register 55
ocpihdl set $WORKER_INDEX register_55 0x0000
ocpihdl -x get $WORKER_INDEX register_55

# Register 54
ocpihdl set $WORKER_INDEX register_54 0x0000
ocpihdl -x get $WORKER_INDEX register_54

# Register 53
ocpihdl set $WORKER_INDEX register_53 0x0000
ocpihdl -x get $WORKER_INDEX register_53

# Register 52
ocpihdl set $WORKER_INDEX register_52 0x0820
ocpihdl -x get $WORKER_INDEX register_52

# Register 51
ocpihdl set $WORKER_INDEX register_51 0x0080
ocpihdl -x get $WORKER_INDEX register_51

# Register 50
ocpihdl set $WORKER_INDEX register_50 0x0000
ocpihdl -x get $WORKER_INDEX register_50

# Register 49
ocpihdl set $WORKER_INDEX register_49 0x4180
ocpihdl -x get $WORKER_INDEX register_49

# Register 48
ocpihdl set $WORKER_INDEX register_48 0x0300
ocpihdl -x get $WORKER_INDEX register_48

# Register 47
ocpihdl set $WORKER_INDEX register_47 0x0300
ocpihdl -x get $WORKER_INDEX register_47

# Register 46
ocpihdl set $WORKER_INDEX register_46 0x07FC
ocpihdl -x get $WORKER_INDEX register_46

# Register 45
ocpihdl set $WORKER_INDEX register_45 0xC0CC
ocpihdl -x get $WORKER_INDEX register_45

# Register 44
ocpihdl set $WORKER_INDEX register_44 0x0C23
ocpihdl -x get $WORKER_INDEX register_44

# Register 43
ocpihdl set $WORKER_INDEX register_43 0xC442
ocpihdl -x get $WORKER_INDEX register_43

# Register 42
ocpihdl set $WORKER_INDEX register_42 0xA9CD
ocpihdl -x get $WORKER_INDEX register_42

# Register 41
ocpihdl set $WORKER_INDEX register_41 0x0000
ocpihdl -x get $WORKER_INDEX register_41

# Register 40
ocpihdl set $WORKER_INDEX register_40 0x0000
ocpihdl -x get $WORKER_INDEX register_40

# Register 39
ocpihdl set $WORKER_INDEX register_39 0xFFFF
ocpihdl -x get $WORKER_INDEX register_39

# Register 38
ocpihdl set $WORKER_INDEX register_38 0xFFFF
ocpihdl -x get $WORKER_INDEX register_38

# Register 37
ocpihdl set $WORKER_INDEX register_37 0x0404
ocpihdl -x get $WORKER_INDEX register_37

# Register 36
ocpihdl set $WORKER_INDEX register_36 0x0064
ocpihdl -x get $WORKER_INDEX register_36

# Register 35
ocpihdl set $WORKER_INDEX register_35 0x0004
ocpihdl -x get $WORKER_INDEX register_35

# Register 34
ocpihdl set $WORKER_INDEX register_34 0x0000
ocpihdl -x get $WORKER_INDEX register_34

# Register 33
ocpihdl set $WORKER_INDEX register_33 0x1E21
ocpihdl -x get $WORKER_INDEX register_33

# Register 32
ocpihdl set $WORKER_INDEX register_32 0x0393
ocpihdl -x get $WORKER_INDEX register_32

# Register 31
ocpihdl set $WORKER_INDEX register_31 0x43EC
ocpihdl -x get $WORKER_INDEX register_31

# Register 30
ocpihdl set $WORKER_INDEX register_30 0x318C
ocpihdl -x get $WORKER_INDEX register_30

# Register 29
ocpihdl set $WORKER_INDEX register_29 0x318C
ocpihdl -x get $WORKER_INDEX register_29

# Register 28
ocpihdl set $WORKER_INDEX register_28 0x0488
ocpihdl -x get $WORKER_INDEX register_28

# Register 27
ocpihdl set $WORKER_INDEX register_27 0x0002
ocpihdl -x get $WORKER_INDEX register_27

# Register 26
ocpihdl set $WORKER_INDEX register_26 0x0DB0
ocpihdl -x get $WORKER_INDEX register_26

# Register 25
ocpihdl set $WORKER_INDEX register_25 0x0624
ocpihdl -x get $WORKER_INDEX register_25

# Register 24
ocpihdl set $WORKER_INDEX register_24 0x071A
ocpihdl -x get $WORKER_INDEX register_24

# Register 23
ocpihdl set $WORKER_INDEX register_23 0x007C
ocpihdl -x get $WORKER_INDEX register_23

# Register 22
ocpihdl set $WORKER_INDEX register_22 0x0001
ocpihdl -x get $WORKER_INDEX register_22

# Register 21
ocpihdl set $WORKER_INDEX register_21 0x0401
ocpihdl -x get $WORKER_INDEX register_21

# Register 20
ocpihdl set $WORKER_INDEX register_20 0xE048
ocpihdl -x get $WORKER_INDEX register_20

# Register 19
ocpihdl set $WORKER_INDEX register_19 0x27B7
ocpihdl -x get $WORKER_INDEX register_19

# Register 18
ocpihdl set $WORKER_INDEX register_18 0x0064
ocpihdl -x get $WORKER_INDEX register_18

# Register 17
ocpihdl set $WORKER_INDEX register_17 0x012C
ocpihdl -x get $WORKER_INDEX register_17

# Register 16
ocpihdl set $WORKER_INDEX register_16 0x0080
ocpihdl -x get $WORKER_INDEX register_16

# Register 15
ocpihdl set $WORKER_INDEX register_15 0x064F
ocpihdl -x get $WORKER_INDEX register_15

# Register 14
ocpihdl set $WORKER_INDEX register_14 0x1E70
ocpihdl -x get $WORKER_INDEX register_14

# Register 13
ocpihdl set $WORKER_INDEX register_13 0x4000
ocpihdl -x get $WORKER_INDEX register_13

# Register 12
ocpihdl set $WORKER_INDEX register_12 0x5001
ocpihdl -x get $WORKER_INDEX register_12

# Register 11
ocpihdl set $WORKER_INDEX register_11 0x0018
ocpihdl -x get $WORKER_INDEX register_11

# Register 10
ocpihdl set $WORKER_INDEX register_10 0x10D8
ocpihdl -x get $WORKER_INDEX register_10

# Register 9
ocpihdl set $WORKER_INDEX register_9 0x0604
ocpihdl -x get $WORKER_INDEX register_9

# Register 8
ocpihdl set $WORKER_INDEX register_8 0x2000
ocpihdl -x get $WORKER_INDEX register_8

# Register 7
ocpihdl set $WORKER_INDEX register_7 0x40B2
ocpihdl -x get $WORKER_INDEX register_7

# Register 6
ocpihdl set $WORKER_INDEX register_6 0xC802
ocpihdl -x get $WORKER_INDEX register_6

# Register 5
ocpihdl set $WORKER_INDEX register_5 0x00C8
ocpihdl -x get $WORKER_INDEX register_5

# Register 4
ocpihdl set $WORKER_INDEX register_4 0x0A43
ocpihdl -x get $WORKER_INDEX register_4

# Register 3
ocpihdl set $WORKER_INDEX register_3 0x0642
ocpihdl -x get $WORKER_INDEX register_3

# Register 2
ocpihdl set $WORKER_INDEX register_2 0x0500
ocpihdl -x get $WORKER_INDEX register_2

# Register 1
sleep 1
ocpihdl set $WORKER_INDEX register_1 0x0808
ocpihdl -x get $WORKER_INDEX register_1

# Reigster 0 (Power-Up Sequence 5-6)
sleep 1
ocpihdl set $WORKER_INDEX register_0 0x249C
ocpihdl -x get $WORKER_INDEX register_0
