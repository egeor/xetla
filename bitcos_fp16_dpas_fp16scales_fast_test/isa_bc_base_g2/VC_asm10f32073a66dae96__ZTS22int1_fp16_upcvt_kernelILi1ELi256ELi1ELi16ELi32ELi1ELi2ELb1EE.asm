//.kernel _ZTS22int1_fp16_upcvt_kernelILi1ELi256ELi1ELi16ELi32ELi1ELi2ELb1EE
//.platform XE2
//.thread_config numGRF=128, numAcc=4, numSWSB=16
//.options_string "-enablePreemptionR0Only -enableHalfLSC -dumpcommonisa -output -binary -abiver 2 -samplerHeaderWA "
//.full_options "-samplerHeaderWA -enablePreemptionR0Only -abiver 2 -output -binary -dumpcommonisa -enableHalfLSC "
//.instCount 365
//.RA type	LOCAL_ROUND_ROBIN_BC_RA
//.git-hash cd6c33fbee6ccc897657c64b11eae6917cc8ff5e

//.declare BuiltInR0 (0)  rf=r size=64 type=ud align=32 words (r0.0) IsBuiltin
//.declare  (1)  rf=r size=64 type=ud align=32 words (r40.0) IsBuiltin
//.declare BuiltinA0 (2)  rf=a size=4 type=ud align=1 words (a0.0) IsBuiltin
//.declare BuiltinA0Dot2 (3)  rf=a size=4 type=ud align=1 words (a0.2) IsBuiltin
//.declare BuiltinSR0Dot1 (5)  rf=r size=4 type=ud align=2 words IsBuiltin
//.declare %null (10)  rf=r size=4 type=ud align=2 words
//.declare %local_id_x (13)  rf=r size=4 type=ud align=2 words (r2.0)
//.declare %local_id_y (14)  rf=r size=4 type=ud align=2 words (r2.1)
//.declare %local_size_x (15)  rf=r size=4 type=ud align=2 words (r1.12)
//.declare %local_size_y (16)  rf=r size=4 type=ud align=2 words (r1.13)
//.declare %group_id_x (17)  rf=r size=4 type=ud align=2 words (r0.1)
//.declare %group_id_y (18)  rf=r size=4 type=ud align=2 words (r0.6)
//.declare %group_id_z (19)  rf=r size=4 type=ud align=2 words (r0.7)
//.declare %group_count_x (20)  rf=r size=4 type=ud align=2 words (r1.14)
//.declare %group_count_y (21)  rf=r size=4 type=ud align=2 words (r1.15)
//.declare %tsc (22)  rf=r size=20 type=ud align=2 words
//.declare %arg (23)  rf=r size=0 type=ud align=32 words (r26.0)
//.declare %retval (24)  rf=r size=0 type=ud align=32 words (r26.0) Output
//.declare %sp (25)  rf=r size=8 type=uq align=4 words (r127.3)
//.declare %fp (26)  rf=r size=8 type=uq align=4 words (r127.2)
//.declare %sr0 (27)  rf=r size=16 type=ud align=2 words
//.declare %cr0 (28)  rf=r size=12 type=ud align=2 words
//.declare %ce0 (29)  rf=r size=4 type=ud align=2 words
//.declare %dbg0 (30)  rf=r size=8 type=ud align=2 words
//.declare implBufPtr (32)  rf=r size=8 type=uq align=4 words (r126.0)
//.declare localIdBufPtr (33)  rf=r size=8 type=uq align=4 words (r126.3)
//.declare %msg0 (34)  rf=r size=12 type=ud align=2 words
//.declare %scratchloc (35)  rf=r size=8 type=uq align=4 words (s0.7)
//.declare V33 (41)  rf=r size=6 type=w align=1 words (r1.0)
//.declare V34 (42)  rf=r size=12 type=d align=2 words (r2.0)
//.declare V35 (43)  rf=r size=8 type=q align=4 words (r2.2)
//.declare V36 (44)  rf=r size=4 type=d align=2 words (r4.0)
//.declare V37 (45)  rf=r size=4 type=d align=2 words (r4.1)
//.declare V38 (46)  rf=r size=4 type=d align=2 words (r4.2)
//.declare V39 (47)  rf=r size=4 type=d align=2 words (r4.3)
//.declare V40 (48)  rf=r size=4 type=d align=2 words (r4.4)
//.declare V41 (49)  rf=r size=4 type=d align=2 words (r4.5)
//.declare V42 (50)  rf=r size=8 type=uq align=4 words (r4.6)
//.declare V43 (51)  rf=r size=8 type=uq align=4 words (r4.7)
//.declare V44 (52)  rf=r size=1 type=b align=1 words (r5.0)
//.declare V45 (53)  rf=r size=1 type=b align=1 words (r5.1)
//.declare V46 (54)  rf=r size=1 type=b align=1 words (r5.2)
//.declare V47 (55)  rf=r size=1 type=b align=1 words (r5.3)
//.declare V48 (56)  rf=r size=1 type=b align=1 words (r5.4)
//.declare V49 (57)  rf=r size=1 type=b align=1 words (r5.5)
//.declare V50 (58)  rf=r size=1 type=b align=1 words (r5.6)
//.declare V51 (59)  rf=r size=1 type=b align=1 words (r5.7)
//.declare V52 (60)  rf=r size=4 type=d align=2 words (r5.4)
//.declare V53 (61)  rf=r size=8 type=uq align=4 words (r5.5)
//.declare V56 (64)  rf=r size=8 type=uq align=4 words (r4.3)
//.declare V57 (65)  rf=r size=8 type=uq align=4 words (r4.4)
//.declare V58 (66)  rf=r size=8 type=uq align=4 words (r4.5)
//.declare V59 (67)  rf=r size=8 type=uq align=4 words (r5.1)
//.declare V60 (68)  rf=r size=8 type=uq align=4 words (r5.3)
//.declare V61 (69)  rf=r size=12 type=d align=2 words (r1.2)
//.declare V62 (70)  rf=r size=128 type=d align=32 words (r6.0)
//.declare V63 (71)  rf=r size=8 type=d align=4 words (r8.0)
//.declare V64 (72)  rf=r size=8 type=d align=4 words (r2.4)
//.declare V65 (73)  rf=r size=128 type=d align=32 words (r10.0)
//.declare V66 (74)  rf=r size=4 type=d align=32 words (r12.0)
//.declare V67 (75)  rf=r size=4 type=d align=32 words (r13.0)
//.declare V68 (76)  rf=r size=8 type=d align=4 words (r14.0)
//.declare V69 (77)  rf=r size=8 type=d align=4 words (r41.0)
//.declare V70 (78)  rf=r size=4 type=d align=2 words (r41.2)
//.declare V71 (79)  rf=r size=4 type=d align=2 words (r41.3)
//.declare V72 (80)  rf=r size=4 type=d align=2 words (r41.4)
//.declare V73 (81)  rf=r size=4 type=d align=2 words (r41.5)
//.declare V74 (82)  rf=r size=4 type=d align=32 words (r57.0)
//.declare V75 (83)  rf=r size=4 type=d align=2 words (r41.6)
//.declare P1 (84)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare P2 (85)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare P3 (86)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare V76 (87)  rf=r size=8 type=d align=2 words (r3.0)
//.declare V77 (88)  rf=r size=8 type=d align=4 words (r1.2)
//.declare V78 (89)  rf=r size=8 type=d align=4 words (r4.12)
//.declare V79 (90)  rf=r size=128 type=d align=32 words (r6.0)
//.declare V80 (91)  rf=r size=4 type=d align=32 words (r8.0)
//.declare V81 (92)  rf=r size=4 type=d align=32 words (r9.0)
//.declare V82 (93)  rf=r size=8 type=q align=4 words (r41.4)
//.declare V83 (94)  rf=r size=4 type=d align=2 words (r41.7)
//.declare V84 (95)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V85 (96)  rf=r size=4 type=d align=2 words (r41.10)
//.declare V86 (97)  rf=r size=4 type=d align=32 words (r63.0)
//.declare V87 (98)  rf=r size=4 type=d align=2 words (r41.11)
//.declare V88 (99)  rf=r size=4 type=d align=32 words (r69.0)
//.declare V89 (100)  rf=r size=4 type=d align=2 words (r5.0)
//.declare V90 (101)  rf=r size=64 type=d align=32 words (r83.0)
//.declare V91 (102)  rf=r size=64 type=d align=32 words (r89.0)
//.declare V92 (103)  rf=r size=64 type=d align=32 words (r95.0)
//.declare V93 (104)  rf=r size=64 type=d align=32 words (r96.0)
//.declare V94 (105)  rf=r size=8 type=uq align=4 words (r5.4)
//.declare V95 (106)  rf=r size=128 type=q align=32 words (r9.0)
//.declare V96 (107)  rf=r size=64 type=d align=32 words (r97.0)
//.declare P4 (108)  rf=f1  size=2 type=uw align=1 words (f3.1)
//.declare P5 (109)  rf=f1  size=2 type=uw align=1 words (f3.0)
//.declare P6 (110)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare V97 (111)  rf=r size=128 type=q align=32 words (r8.0)
//.declare V99 (113)  rf=r size=64 type=d align=32 words (r98.0)
//.declare V100 (114)  rf=r size=4 type=d align=2 words (r41.12)
//.declare V101 (115)  rf=r size=4 type=d align=2 words (r41.13)
//.declare V102 (116)  rf=r size=32 type=w align=2 words (r8.0)
//.declare V103 (117)  rf=r size=32 type=w align=2 words (r11.0)
//.declare V104 (118)  rf=r size=32 type=w align=2 words (r14.0)
//.declare V105 (119)  rf=r size=32 type=w align=2 words (r17.0)
//.declare V106 (120)  rf=r size=64 type=d align=32 words (r21.0)
//.declare V107 (121)  rf=r size=64 type=d align=32 words (r24.0)
//.declare V108 (122)  rf=r size=32 type=w align=8 words (r25.0)
//.declare V109 (123)  rf=r size=64 type=w align=32 words (r18.0)
//.declare V110 (124)  rf=r size=32 type=w align=2 words (r28.0)
//.declare V111 (125)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V112 (126)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V113 (127)  rf=r size=64 type=w align=32 words (r19.0)
//.declare V114 (128)  rf=r size=32 type=w align=2 words (r33.0)
//.declare V115 (129)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V116 (130)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V117 (131)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V118 (132)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V119 (133)  rf=r size=64 type=d align=32 words (r37.0)
//.declare V120 (134)  rf=r size=64 type=d align=32 words (r38.0)
//.declare V121 (135)  rf=r size=64 type=d align=32 words (r39.0)
//.declare P7 (136)  rf=f1  size=2 type=uw align=1 words (f3.1)
//.declare V123 (138)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V125 (140)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V127 (142)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V129 (144)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V130 (145)  rf=r size=4 type=d align=32 words (r5.0)
//.declare V131 (146)  rf=r size=64 type=d align=32 words (r99.0)
//.declare V132 (147)  rf=r size=4 type=d align=32 words (r6.0)
//.declare V133 (148)  rf=r size=64 type=d align=32 words (r100.0)
//.declare P8 (150)  rf=f1  size=2 type=uw align=1 words (f3.0)
//.declare V135 (151)  rf=r size=4 type=d align=2 words (r41.14)
//.declare V136 (152)  rf=r size=8 type=q align=4 words (r57.1)
//.declare V137 (153)  rf=r size=8 type=q align=4 words (r57.2)
//.declare V138 (154)  rf=r size=8 type=q align=4 words (r57.3)
//.declare V139 (155)  rf=r size=8 type=q align=32 words (r3.0)
//.declare V140 (156)  rf=r size=8 type=q align=32 words (r8.0)
//.declare V141 (157)  rf=r size=8 type=q align=32 words (r10.0)
//.declare V142 (158)  rf=r size=32 type=hf align=32 words (r11.0)
//.declare P9 (160)  rf=f1  size=2 type=uw align=1 words (f2.1)
//.declare V144 (161)  rf=r size=4 type=d align=2 words (r12.0)
//.declare V145 (162)  rf=r size=64 type=d align=32 words (r14.0)
//.declare V146 (163)  rf=r size=64 type=d align=32 words (r15.0)
//.declare V147 (164)  rf=r size=128 type=q align=32 words (r18.0)
//.declare V148 (165)  rf=r size=192 type=d align=32 words (r20.0)
//.declare V149 (166)  rf=r size=32 type=w align=2 words (r25.0)
//.declare V151 (168)  rf=r size=32 type=w align=2 words (r28.0)
//.declare V153 (170)  rf=r size=64 type=d align=32 words (r31.0)
//.declare P10 (171)  rf=f16  size=2 type=uw align=1 words (f1.1)
//.declare V154 (172)  rf=r size=64 type=hf align=32 words (r32.0)
//.declare V155 (173)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V156 (174)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V157 (175)  rf=r size=64 type=d align=32 words (r37.0)
//.declare V158 (176)  rf=r size=128 type=hf align=32 words (r38.0)
//.declare V159 (177)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V160 (178)  rf=r size=64 type=d align=32 words (r52.0)
//.declare V161 (179)  rf=r size=64 type=d align=32 words (r50.0)
//.declare V162 (180)  rf=r size=64 type=d align=32 words (r53.0)
//.declare V163 (181)  rf=r size=128 type=hf align=32 words (r54.0)
//.declare V164 (182)  rf=r size=64 type=d align=32 words (r51.0)
//.declare V165 (183)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V166 (184)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V167 (185)  rf=r size=64 type=d align=32 words (r59.0)
//.declare V168 (186)  rf=r size=128 type=hf align=32 words (r60.0)
//.declare V169 (187)  rf=r size=64 type=d align=32 words (r56.0)
//.declare V170 (188)  rf=r size=64 type=d align=32 words (r64.0)
//.declare V172 (190)  rf=r size=64 type=d align=32 words (r65.0)
//.declare V173 (191)  rf=r size=128 type=hf align=32 words (r66.0)
//.declare V174 (192)  rf=r size=512 type=d align=32 words (r42.0)
//.declare V175 (193)  rf=r size=64 type=d align=32 words (r62.0)
//.declare V176 (194)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V178 (196)  rf=r size=64 type=d align=32 words (r71.0)
//.declare V179 (197)  rf=r size=128 type=hf align=32 words (r72.0)
//.declare V180 (198)  rf=r size=64 type=d align=32 words (r68.0)
//.declare V181 (199)  rf=r size=64 type=d align=32 words (r84.0)
//.declare V183 (201)  rf=r size=64 type=d align=32 words (r85.0)
//.declare V184 (202)  rf=r size=128 type=hf align=32 words (r86.0)
//.declare V185 (203)  rf=r size=64 type=d align=32 words (r82.0)
//.declare V186 (204)  rf=r size=64 type=d align=32 words (r90.0)
//.declare V188 (206)  rf=r size=64 type=d align=32 words (r91.0)
//.declare V189 (207)  rf=r size=128 type=hf align=32 words (r92.0)
//.declare V190 (208)  rf=r size=64 type=d align=32 words (r88.0)
//.declare V191 (209)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V192 (210)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V193 (211)  rf=r size=64 type=d align=32 words (r94.0)
//.declare V194 (212)  rf=r size=128 type=hf align=32 words (r8.0)
//.declare V195 (213)  rf=r size=512 type=d align=32 words (r74.0)
//.declare V196 (214)  rf=r size=64 type=d align=32 words (r7.0)
//.declare P11 (215)  rf=f1  size=2 type=uw align=1 words (f2.0)
//.declare V197 (216)  rf=r size=64 type=q align=32 words (r102.0)
//.declare V199 (218)  rf=r size=4 type=d align=32 words (r101.0)
//.declare V200 (219)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V201 (220)  rf=r size=4 type=d align=2 words (r4.12)
//.declare V202 (221)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V203 (222)  rf=r size=4 type=b align=2 words (r41.60)
//.declare P12 (223)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V204 (224)  rf=r size=4 type=d align=2 words (r2.3)
//.declare V205 (225)  rf=r size=64 type=f align=32 words (r3.0)
//.declare V206 (226)  rf=r size=64 type=f align=32 words (r6.0)
//.declare V207 (227)  rf=r size=32 type=w align=16 words (r7.0)
//.declare V208 (228)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V209 (229)  rf=r size=4 type=d align=2 words (r1.2)
//.declare V210 (230)  rf=r size=4 type=d align=32 words (r9.0)
//.declare V211 (231)  rf=r size=128 type=q align=32 words (r12.0)
//.declare P13 (232)  rf=f16  size=2 type=uw align=1 words (f2.1)
//.declare P14 (233)  rf=f16  size=2 type=uw align=1 words (f2.0)
//.declare P15 (234)  rf=f16  size=2 type=uw align=1 words (f0.0)
//.declare V212 (235)  rf=r size=6 type=uw alias=V33+0 align=1 words (r1.0)
//.declare V213 (236)  rf=r size=8 type=q alias=V64+0 align=4 words (r2.2)
//.declare V214 (237)  rf=r size=12 type=ud alias=V34+0 align=2 words (r2.0)
//.declare V215 (238)  rf=r size=128 type=ud alias=V62+0 align=32 words (r6.0)
//.declare V216 (239)  rf=r size=12 type=ud alias=V61+0 align=2 words (r1.2)
//.declare V217 (240)  rf=r size=8 type=q alias=V63+0 align=4 words (r8.0)
//.declare V218 (241)  rf=r size=128 type=ud alias=V65+0 align=32 words (r10.0)
//.declare V219 (242)  rf=r size=8 type=ud alias=V63+0 align=2 words (r8.0)
//.declare V220 (243)  rf=r size=8 type=ud alias=V64+0 align=2 words (r2.4)
//.declare V221 (244)  rf=r size=4 type=d alias=V66+0 align=2 words (r12.0)
//.declare V222 (245)  rf=r size=8 type=d alias=V63+0 align=2 words (r8.0)
//.declare V223 (246)  rf=r size=8 type=d alias=V64+0 align=2 words (r2.4)
//.declare V224 (247)  rf=r size=4 type=d alias=V67+0 align=2 words (r13.0)
//.declare V225 (248)  rf=r size=8 type=d alias=V68+0 align=2 words (r14.0)
//.declare V226 (249)  rf=r size=128 type=d alias=V65+0 align=32 words (r10.0)
//.declare V227 (250)  rf=r size=8 type=q alias=V68+0 align=4 words (r14.0)
//.declare V228 (251)  rf=r size=4 type=d alias=V203+0 align=2 words (r41.15)
//.declare V229 (252)  rf=r size=8 type=uq alias=V69+0 align=4 words (r41.0)
//.declare V230 (253)  rf=r size=8 type=uq alias=V68+0 align=4 words (r14.0)
//.declare V231 (254)  rf=r size=4 type=d alias=V83+0 align=2 words (r41.7)
//.declare V232 (255)  rf=r size=4 type=d alias=V71+0 align=2 words (r41.3)
//.declare V233 (256)  rf=r size=4 type=ud alias=V71+0 align=2 words (r41.3)
//.declare V234 (257)  rf=r size=4 type=ud alias=V38+0 align=2 words (r4.2)
//.declare V235 (258)  rf=r size=4 type=d alias=V72+0 align=2 words (r41.4)
//.declare V236 (259)  rf=r size=4 type=d alias=V70+0 align=2 words (r41.2)
//.declare V237 (260)  rf=r size=4 type=ud alias=V72+0 align=2 words (r41.4)
//.declare V238 (261)  rf=r size=4 type=ud alias=V36+0 align=2 words (r4.0)
//.declare V239 (262)  rf=r size=4 type=d alias=V73+0 align=2 words (r41.5)
//.declare V240 (263)  rf=r size=4 type=d alias=V37+0 align=2 words (r4.1)
//.declare V241 (264)  rf=r size=4 type=ud alias=V75+0 align=2 words (r41.6)
//.declare V242 (265)  rf=r size=4 type=ud alias=V73+0 align=2 words (r41.5)
//.declare V243 (266)  rf=r size=4 type=ud alias=V74+0 align=2 words (r57.0)
//.declare V244 (267)  rf=r size=8 type=ud alias=V69+0 align=2 words (r41.0)
//.declare V245 (268)  rf=r size=4 type=ud alias=V88+0 align=2 words (r69.0)
//.declare V246 (269)  rf=r size=4 type=d alias=V100+0 align=2 words (r41.12)
//.declare V247 (270)  rf=r size=8 type=d alias=V69+0 align=2 words (r41.0)
//.declare V248 (271)  rf=r size=4 type=ud alias=V86+0 align=2 words (r63.0)
//.declare V249 (272)  rf=r size=8 type=ud alias=V68+0 align=2 words (r14.0)
//.declare V250 (273)  rf=r size=8 type=uq alias=V77+0 align=4 words (r1.1)
//.declare V251 (274)  rf=r size=8 type=d alias=V76+0 align=2 words (r3.0)
//.declare V252 (275)  rf=r size=8 type=d alias=V77+0 align=2 words (r1.2)
//.declare V253 (276)  rf=r size=8 type=q alias=V78+0 align=4 words (r4.6)
//.declare V254 (277)  rf=r size=128 type=ud alias=V79+0 align=32 words (r6.0)
//.declare V255 (278)  rf=r size=8 type=ud alias=V77+0 align=2 words (r1.2)
//.declare V256 (279)  rf=r size=8 type=ud alias=V78+0 align=2 words (r4.12)
//.declare V257 (280)  rf=r size=4 type=d alias=V80+0 align=2 words (r8.0)
//.declare V258 (281)  rf=r size=8 type=d alias=V78+0 align=2 words (r4.12)
//.declare V259 (282)  rf=r size=4 type=d alias=V81+0 align=2 words (r9.0)
//.declare V260 (283)  rf=r size=8 type=d alias=V82+0 align=2 words (r41.8)
//.declare V261 (284)  rf=r size=8 type=d alias=V82+0 align=2 words (r41.8)
//.declare V262 (285)  rf=r size=128 type=d alias=V79+0 align=32 words (r6.0)
//.declare V263 (286)  rf=r size=8 type=q alias=V82+0 align=4 words (r41.4)
//.declare V264 (287)  rf=r size=8 type=q alias=V53+0 align=4 words (r5.5)
//.declare V265 (288)  rf=r size=4 type=d alias=V101+0 align=2 words (r41.13)
//.declare V266 (289)  rf=r size=4 type=d alias=V84+0 align=2 words (r3.0)
//.declare V267 (290)  rf=r size=4 type=d alias=V39+0 align=2 words (r4.3)
//.declare V268 (291)  rf=r size=8 type=q alias=V136+0 align=4 words (r57.1)
//.declare V269 (292)  rf=r size=4 type=ud alias=V84+0 align=2 words (r3.0)
//.declare V270 (293)  rf=r size=4 type=d alias=V85+0 align=2 words (r41.10)
//.declare V271 (294)  rf=r size=4 type=d alias=V40+0 align=2 words (r4.4)
//.declare V272 (295)  rf=r size=4 type=d alias=V86+0 align=2 words (r63.0)
//.declare V273 (296)  rf=r size=4 type=ud alias=V83+0 align=2 words (r41.7)
//.declare V274 (297)  rf=r size=8 type=q alias=V137+0 align=4 words (r57.2)
//.declare V275 (298)  rf=r size=8 type=q alias=V138+0 align=4 words (r57.3)
//.declare V276 (299)  rf=r size=4 type=d alias=V87+0 align=2 words (r41.11)
//.declare V277 (300)  rf=r size=4 type=d alias=V52+0 align=2 words (r5.4)
//.declare V278 (301)  rf=r size=4 type=d alias=V88+0 align=2 words (r69.0)
//.declare V279 (302)  rf=r size=4 type=ud alias=V89+0 align=2 words (r5.0)
//.declare V280 (303)  rf=r size=64 type=d alias=V91+0 align=32 words (r89.0)
//.declare V281 (304)  rf=r size=64 type=d alias=V92+0 align=32 words (r95.0)
//.declare V282 (305)  rf=r size=64 type=d alias=V93+0 align=32 words (r96.0)
//.declare V283 (306)  rf=r size=128 type=q alias=V95+0 align=32 words (r9.0)
//.declare V284 (307)  rf=r size=8 type=q alias=V94+0 align=4 words (r5.4)
//.declare V285 (308)  rf=r size=64 type=ud alias=V93+0 align=32 words (r96.0)
//.declare V286 (309)  rf=r size=128 type=uq alias=V95+0 align=32 words (r9.0)
//.declare V287 (310)  rf=r size=128 type=q alias=V97+0 align=32 words (r8.0)
//.declare V288 (311)  rf=r size=128 type=uq alias=V97+0 align=32 words (r8.0)
//.declare V289 (312)  rf=r size=64 type=d alias=V115+0 align=32 words (r3.0)
//.declare V290 (313)  rf=r size=32 type=uw alias=V102+0 align=1 words (r8.0)
//.declare V291 (314)  rf=r size=64 type=uw alias=V115+0 align=32 words (r3.0)
//.declare V292 (315)  rf=r size=32 type=uw alias=V103+0 align=1 words (r11.0)
//.declare V293 (316)  rf=r size=32 type=uw alias=V104+0 align=1 words (r14.0)
//.declare V294 (317)  rf=r size=32 type=uw alias=V105+0 align=1 words (r17.0)
//.declare V295 (318)  rf=r size=64 type=d alias=V109+0 align=32 words (r18.0)
//.declare V296 (319)  rf=r size=64 type=d alias=V113+0 align=32 words (r19.0)
//.declare V297 (320)  rf=r size=64 type=d alias=V107+0 align=32 words (r24.0)
//.declare V298 (321)  rf=r size=32 type=uw alias=V108+0 align=1 words (r25.0)
//.declare V299 (322)  rf=r size=64 type=d alias=V117+0 align=32 words (r35.0)
//.declare V300 (323)  rf=r size=64 type=ud alias=V109+0 align=32 words (r18.0)
//.declare V301 (324)  rf=r size=64 type=ud alias=V91+0 align=32 words (r89.0)
//.declare V302 (325)  rf=r size=32 type=w alias=V110+0 align=1 words (r28.0)
//.declare V303 (326)  rf=r size=64 type=w alias=V109+0 align=32 words (r18.0)
//.declare V304 (327)  rf=r size=32 type=uw alias=V110+0 align=1 words (r28.0)
//.declare V305 (328)  rf=r size=64 type=ud alias=V113+0 align=32 words (r19.0)
//.declare V306 (329)  rf=r size=32 type=w alias=V114+0 align=1 words (r33.0)
//.declare V307 (330)  rf=r size=64 type=w alias=V113+0 align=32 words (r19.0)
//.declare V308 (331)  rf=r size=64 type=d alias=V119+0 align=32 words (r37.0)
//.declare V309 (332)  rf=r size=32 type=uw alias=V114+0 align=1 words (r33.0)
//.declare V310 (333)  rf=r size=64 type=d alias=V116+0 align=32 words (r34.0)
//.declare V311 (334)  rf=r size=64 type=ud alias=V118+0 align=32 words (r36.0)
//.declare V312 (335)  rf=r size=64 type=ud alias=V117+0 align=32 words (r35.0)
//.declare V313 (336)  rf=r size=64 type=ud alias=V106+0 align=32 words (r21.0)
//.declare V314 (337)  rf=r size=64 type=ud alias=V107+0 align=32 words (r24.0)
//.declare V315 (338)  rf=r size=64 type=ud alias=V120+0 align=32 words (r38.0)
//.declare V316 (339)  rf=r size=64 type=ud alias=V119+0 align=32 words (r37.0)
//.declare V317 (340)  rf=r size=64 type=ud alias=V111+0 align=32 words (r29.0)
//.declare V318 (341)  rf=r size=64 type=ud alias=V112+0 align=32 words (r30.0)
//.declare V319 (342)  rf=r size=64 type=ud alias=V116+0 align=32 words (r34.0)
//.declare V320 (343)  rf=r size=64 type=ud alias=V121+0 align=32 words (r39.0)
//.declare V323 (346)  rf=r size=64 type=ud alias=V123+0 align=32 words (r3.0)
//.declare V324 (347)  rf=r size=4 type=ud alias=V100+0 align=2 words (r41.12)
//.declare V325 (348)  rf=r size=64 type=ud alias=V127+0 align=32 words (r7.0)
//.declare  (349)  rf=r size=64 type=ud align=32 words (r3.0)
//.declare V326 (350)  rf=r size=8 type=b alias=V69+0 align=1 words (r41.0)
//.declare  (351)  rf=f16  size=2 type=uw align=2 words (f1.0)
//.declare V327 (352)  rf=r size=4 type=d alias=V130+0 align=2 words (r5.0)
//.declare V328 (353)  rf=r size=4 type=ud alias=V130+0 align=2 words (r5.0)
//.declare V329 (354)  rf=r size=4 type=d alias=V132+0 align=2 words (r6.0)
//.declare V330 (355)  rf=r size=4 type=ud alias=V132+0 align=2 words (r6.0)
//.declare V331 (356)  rf=r size=64 type=f alias=V197+0 align=32 words (r102.0)
//.declare V332 (357)  rf=r size=8 type=uq alias=V139+0 align=4 words (r3.0)
//.declare V333 (358)  rf=r size=8 type=uq alias=V136+0 align=4 words (r57.1)
//.declare V334 (359)  rf=r size=8 type=uq alias=V56+0 align=4 words (r4.3)
//.declare V335 (360)  rf=r size=64 type=q alias=V196+0 align=32 words (r7.0)
//.declare V336 (361)  rf=r size=8 type=uq alias=V140+0 align=4 words (r8.0)
//.declare V337 (362)  rf=r size=8 type=uq alias=V137+0 align=4 words (r57.2)
//.declare V338 (363)  rf=r size=8 type=uq alias=V57+0 align=4 words (r4.4)
//.declare V339 (364)  rf=r size=64 type=q alias=V192+0 align=32 words (r9.0)
//.declare V340 (365)  rf=r size=8 type=uq alias=V141+0 align=4 words (r10.0)
//.declare V341 (366)  rf=r size=8 type=uq alias=V138+0 align=4 words (r57.3)
//.declare V342 (367)  rf=r size=8 type=uq alias=V59+0 align=4 words (r5.1)
//.declare V343 (368)  rf=r size=32 type=q alias=V142+0 align=4 words (r11.0)
//.declare V344 (369)  rf=r size=4 type=d alias=V135+0 align=2 words (r41.14)
//.declare V346 (371)  rf=r size=64 type=ud alias=V166+0 align=32 words (r13.0)
//.declare V347 (372)  rf=r size=64 type=ud alias=V192+0 align=32 words (r9.0)
//.declare V348 (373)  rf=r size=64 type=ud alias=V145+0 align=32 words (r14.0)
//.declare V349 (374)  rf=r size=64 type=ud alias=V146+0 align=32 words (r15.0)
//.declare V350 (375)  rf=r size=64 type=ud alias=V99+0 align=32 words (r98.0)
//.declare V351 (376)  rf=r size=64 type=ud alias=V96+0 align=32 words (r97.0)
//.declare V352 (377)  rf=r size=128 type=q alias=V147+0 align=32 words (r18.0)
//.declare V353 (378)  rf=r size=8 type=q alias=V60+0 align=4 words (r5.3)
//.declare V354 (379)  rf=r size=128 type=uq alias=V147+0 align=32 words (r18.0)
//.declare V355 (380)  rf=r size=64 type=ud alias=V191+0 align=32 words (r30.0)
//.declare V356 (381)  rf=r size=192 type=ud alias=V148+0 align=32 words (r20.0)
//.declare V357 (382)  rf=r size=64 type=ud alias=V153+0 align=32 words (r31.0)
//.declare V358 (383)  rf=r size=32 type=w alias=V149+0 align=1 words (r25.0)
//.declare V359 (384)  rf=r size=64 type=w alias=V99+0 align=32 words (r98.0)
//.declare V360 (385)  rf=r size=32 type=uw alias=V149+0 align=1 words (r25.0)
//.declare V361 (386)  rf=r size=32 type=w alias=V151+0 align=1 words (r28.0)
//.declare V362 (387)  rf=r size=32 type=uw alias=V151+0 align=1 words (r28.0)
//.declare V365 (390)  rf=r size=64 type=ud alias=V156+0 align=32 words (r33.0)
//.declare V366 (391)  rf=r size=64 type=ud alias=V159+0 align=32 words (r34.0)
//.declare V367 (392)  rf=r size=64 type=ud alias=V131+0 align=32 words (r99.0)
//.declare V368 (393)  rf=r size=64 type=ud alias=V155+0 align=32 words (r36.0)
//.declare V369 (394)  rf=r size=64 type=ud alias=V133+0 align=32 words (r100.0)
//.declare V370 (395)  rf=r size=64 type=ud alias=V157+0 align=32 words (r37.0)
//.declare V371 (396)  rf=r size=128 type=d alias=V158+0 align=32 words (r38.0)
//.declare V372 (397)  rf=r size=512 type=hf alias=V174+0 align=32 words (r42.0)
//.declare V373 (398)  rf=r size=64 type=hf alias=V154+0 align=32 words (r32.0)
//.declare V374 (399)  rf=r size=128 type=hf alias=V158+0 align=32 words (r38.0)
//.declare V375 (400)  rf=r size=64 type=ud alias=V161+0 align=32 words (r50.0)
//.declare V376 (401)  rf=r size=64 type=ud alias=V164+0 align=32 words (r51.0)
//.declare V377 (402)  rf=r size=64 type=ud alias=V160+0 align=32 words (r52.0)
//.declare V378 (403)  rf=r size=64 type=ud alias=V162+0 align=32 words (r53.0)
//.declare V379 (404)  rf=r size=128 type=d alias=V163+0 align=32 words (r54.0)
//.declare V380 (405)  rf=r size=128 type=hf alias=V163+0 align=32 words (r54.0)
//.declare V381 (406)  rf=r size=64 type=ud alias=V169+0 align=32 words (r56.0)
//.declare V382 (407)  rf=r size=64 type=ud alias=V165+0 align=32 words (r58.0)
//.declare V383 (408)  rf=r size=64 type=ud alias=V167+0 align=32 words (r59.0)
//.declare V384 (409)  rf=r size=128 type=d alias=V168+0 align=32 words (r60.0)
//.declare V385 (410)  rf=r size=128 type=hf alias=V168+0 align=32 words (r60.0)
//.declare V387 (412)  rf=r size=64 type=ud alias=V175+0 align=32 words (r62.0)
//.declare V388 (413)  rf=r size=64 type=ud alias=V170+0 align=32 words (r64.0)
//.declare V389 (414)  rf=r size=64 type=ud alias=V172+0 align=32 words (r65.0)
//.declare V390 (415)  rf=r size=128 type=d alias=V173+0 align=32 words (r66.0)
//.declare V391 (416)  rf=r size=128 type=hf alias=V173+0 align=32 words (r66.0)
//.declare V393 (418)  rf=r size=64 type=ud alias=V180+0 align=32 words (r68.0)
//.declare V394 (419)  rf=r size=64 type=ud alias=V176+0 align=32 words (r70.0)
//.declare V395 (420)  rf=r size=64 type=ud alias=V178+0 align=32 words (r71.0)
//.declare V396 (421)  rf=r size=128 type=d alias=V179+0 align=32 words (r72.0)
//.declare V397 (422)  rf=r size=512 type=hf alias=V195+0 align=32 words (r74.0)
//.declare V398 (423)  rf=r size=128 type=hf alias=V179+0 align=32 words (r72.0)
//.declare V400 (425)  rf=r size=64 type=ud alias=V185+0 align=32 words (r82.0)
//.declare V401 (426)  rf=r size=64 type=ud alias=V181+0 align=32 words (r84.0)
//.declare V402 (427)  rf=r size=64 type=ud alias=V183+0 align=32 words (r85.0)
//.declare V403 (428)  rf=r size=128 type=d alias=V184+0 align=32 words (r86.0)
//.declare V404 (429)  rf=r size=128 type=hf alias=V184+0 align=32 words (r86.0)
//.declare V406 (431)  rf=r size=64 type=ud alias=V190+0 align=32 words (r88.0)
//.declare V407 (432)  rf=r size=64 type=ud alias=V186+0 align=32 words (r90.0)
//.declare V408 (433)  rf=r size=64 type=ud alias=V188+0 align=32 words (r91.0)
//.declare V409 (434)  rf=r size=128 type=d alias=V189+0 align=32 words (r92.0)
//.declare V410 (435)  rf=r size=128 type=hf alias=V189+0 align=32 words (r92.0)
//.declare V411 (436)  rf=r size=64 type=ud alias=V193+0 align=32 words (r94.0)
//.declare V412 (437)  rf=r size=128 type=d alias=V194+0 align=32 words (r8.0)
//.declare V413 (438)  rf=r size=128 type=hf alias=V194+0 align=32 words (r8.0)
//.declare V414 (439)  rf=r size=4 type=ud alias=V85+0 align=2 words (r41.10)
//.declare V415 (440)  rf=r size=4 type=ud alias=V144+0 align=2 words (r12.0)
//.declare V416 (441)  rf=r size=64 type=f alias=V197+0 align=32 words (r102.0)
//.declare V417 (442)  rf=r size=64 type=w alias=V197+0 align=32 words (r102.0)
//.declare V418 (443)  rf=r size=4 type=d alias=V75+0 align=2 words (r41.6)
//.declare V420 (445)  rf=r size=4 type=d alias=V199+0 align=2 words (r101.0)
//.declare V421 (446)  rf=r size=4 type=d alias=V200+0 align=2 words (r3.0)
//.declare V422 (447)  rf=r size=4 type=ud alias=V200+0 align=2 words (r3.0)
//.declare V423 (448)  rf=r size=4 type=d alias=V201+0 align=2 words (r4.12)
//.declare  (449)  rf=r size=64 type=ud align=32 words (r7.0)
//.declare  (450)  rf=f16  size=2 type=uw align=2 words (f0.0)
//.declare V424 (451)  rf=r size=4 type=ud alias=V209+0 align=2 words (r1.2)
//.declare V425 (452)  rf=r size=4 type=ud alias=V204+0 align=2 words (r2.3)
//.declare V426 (453)  rf=r size=4 type=d alias=V204+0 align=2 words (r2.3)
//.declare V427 (454)  rf=r size=64 type=q alias=V205+0 align=32 words (r3.0)
//.declare V428 (455)  rf=r size=4 type=ud alias=V199+0 align=2 words (r101.0)
//.declare V429 (456)  rf=r size=64 type=q alias=V206+0 align=32 words (r6.0)
//.declare V430 (457)  rf=r size=64 type=f alias=V206+0 align=32 words (r6.0)
//.declare V431 (458)  rf=r size=64 type=f alias=V205+0 align=32 words (r3.0)
//.declare V432 (459)  rf=r size=32 type=hf alias=V207+0 align=1 words (r7.0)
//.declare V433 (460)  rf=r size=32 type=uw alias=V207+0 align=1 words (r7.0)
//.declare V434 (461)  rf=r size=4 type=d alias=V209+0 align=2 words (r1.2)
//.declare V435 (462)  rf=r size=4 type=d alias=V210+0 align=2 words (r9.0)
//.declare V436 (463)  rf=r size=4 type=d alias=V41+0 align=2 words (r4.5)
//.declare V437 (464)  rf=r size=4 type=ud alias=V210+0 align=2 words (r9.0)
//.declare V438 (465)  rf=r size=128 type=q alias=V211+0 align=32 words (r12.0)
//.declare V439 (466)  rf=r size=8 type=q alias=V58+0 align=4 words (r4.5)
//.declare V440 (467)  rf=r size=64 type=ud alias=V92+0 align=32 words (r95.0)
//.declare V441 (468)  rf=r size=128 type=uq alias=V211+0 align=32 words (r12.0)
//.declare  (469)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (470)  rf=r size=4 type=w align=16 words (r2.16)
//.declare  (471)  rf=r size=16 type=w align=16 words (r6.0)
//.declare  (472)  rf=r size=4 type=ud align=2 words (r4.12)
//.declare  (473)  rf=r size=128 type=ud align=32 words (r7.0)
//.declare  (474)  rf=r size=128 type=ud align=32 words (r6.0)
//.declare  (475)  rf=r size=16 type=w align=16 words (r22.0)
//.declare  (477)  rf=r size=64 type=uw align=32 words (r6.0)
//.declare  (478)  rf=r size=32 type=uw align=32 words (r7.0)
//.declare  (479)  rf=r size=64 type=uw align=32 words (r9.0)
//.declare  (480)  rf=r size=32 type=uw align=32 words (r10.0)
//.declare  (481)  rf=r size=64 type=uw align=32 words (r12.0)
//.declare  (482)  rf=r size=32 type=uw align=32 words (r13.0)
//.declare  (483)  rf=r size=64 type=uw align=32 words (r15.0)
//.declare  (484)  rf=r size=32 type=uw align=32 words (r16.0)
//.declare  (485)  rf=r size=64 type=w align=32 words (r26.0)
//.declare  (486)  rf=r size=32 type=w align=32 words (r27.0)
//.declare  (487)  rf=r size=64 type=w align=32 words (r31.0)
//.declare  (488)  rf=r size=32 type=w align=32 words (r32.0)
//.declare  (489)  rf=r size=128 type=ud align=32 words (r16.0)
//.declare  (490)  rf=r size=64 type=w align=32 words (r23.0)
//.declare  (491)  rf=r size=32 type=w align=32 words (r24.0)
//.declare  (492)  rf=r size=64 type=w align=32 words (r26.0)
//.declare  (493)  rf=r size=32 type=w align=32 words (r27.0)
//.declare  (494)  rf=r size=128 type=ud align=32 words (r10.0)
//.declare r0 (495)  rf=r size=64 type=ud align=32 words (r0.0)
//.declare rtmp (496)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (497)  rf=r size=64 type=ud align=32 words (r1.0)
//.declare  (498)  rf=r size=256 type=ud align=32 words (r2.0)

// .inputs
// +----------+----------+--------+----------+------------------+
// | id       | type     |  bytes | at       | from             |
// +----------+----------+--------+----------+------------------+
// | V33      | :w x 3   |    0x6 | r1       | pti[tid]+0x0     |
// | V34      | :d x 3   |    0xC | r2       | cti+0x0          |
// | V35      | :q       |    0x8 | r2+0x10  | cti+0x10         |
// | V36      | :d       |    0x4 | r4       | cti+0x80         |
// | V37      | :d       |    0x4 | r4+0x4   | cti+0x84         |
// | V38      | :d       |    0x4 | r4+0x8   | cti+0x88         |
// | V39      | :d       |    0x4 | r4+0xC   | cti+0x8C         |
// | V40      | :d       |    0x4 | r4+0x10  | cti+0x90         |
// | V41      | :d       |    0x4 | r4+0x14  | cti+0x94         |
// | V56      | :uq      |    0x8 | r4+0x18  | cti+0x98         |
// | V57      | :uq      |    0x8 | r4+0x20  | cti+0xA0         |
// | V58      | :uq      |    0x8 | r4+0x28  | cti+0xA8         |
// | V42      | :uq      |    0x8 | r4+0x30  | cti+0xB0         |
// | V43      | :uq      |    0x8 | r4+0x38  | cti+0xB8         |
// | V44      | :b       |    0x1 | r5       | cti+0xC0         |
// | V45      | :b       |    0x1 | r5+0x1   | cti+0xC1         |
// | V46      | :b       |    0x1 | r5+0x2   | cti+0xC2         |
// | V47      | :b       |    0x1 | r5+0x3   | cti+0xC3         |
// | V48      | :b       |    0x1 | r5+0x4   | cti+0xC4         |
// | V49      | :b       |    0x1 | r5+0x5   | cti+0xC5         |
// | V50      | :b       |    0x1 | r5+0x6   | cti+0xC6         |
// | V51      | :b       |    0x1 | r5+0x7   | cti+0xC7         |
// | V59      | :uq      |    0x8 | r5+0x8   | cti+0xC8         |
// | V52      | :d       |    0x4 | r5+0x10  | cti+0xD0         |
// | V60      | :uq      |    0x8 | r5+0x18  | cti+0xD8         |
// | V94      | :uq      |    0x8 | r5+0x20  | cti+0xE0         |
// | V53      | :uq      |    0x8 | r5+0x28  | cti+0xE8         |
// +----------+----------+--------+----------+------------------+


// B000: Preds:{},  Succs:{B001}
per_thread_prolog:
(W)     mov (16|M0)              r127.0<1>:ud  0x0:ud                              {A@1}             //  ALU pipe: int; 
(W)     and (1|M0)               r127.2<1>:ud  r0.0<0;1,0>:ud    0xFFFFFFC0:ud                       //  ALU pipe: int; 
(W)     and (1|M0)               r127.0<1>:uw  r0.4<0;1,0>:uw    0xFF:uw                             //  ALU pipe: int; 
(W)     add (1|M0)               r127.2<1>:ud  r127.2<0;1,0>:ud  0x100:ud              {I@2}         //  ALU pipe: int; 
(W)     mad (1|M0)               r127.0<1>:ud  r127.2<0;0>:ud    r127.0<0;0>:uw    0x40:uw              {I@1} //  ALU pipe: int; 
(W)     load.ugm.d32x16t.a32.ca.cc (1|M0)  r1:1 bti[255][r127:1]   {A@1,$0} // ex_desc:0xFF000000; desc:0x6219D500 // 
        nop                                                                                          // 
        nop                                                                                          // 
// B001: Preds:{B000},  Succs:{B002}
// cross_thread_prolog:
(W)     and (1|M0)               r127.0<1>:ud  r0.0<0;1,0>:ud    0xFFFFFFC0:ud              {$0.src} //  ALU pipe: int; 
(W)     load.ugm.d32x64t.a32.ca.cc (1|M0)  r2:4 bti[255][r127:1]   {A@1,$1} // ex_desc:0xFF000000; desc:0x6249F500 // 
// B002: Preds:{B001},  Succs:{B003, B004}
// _ZTS22int1_fp16_upcvt_kernelILi1ELi256ELi1ELi16ELi32ELi1ELi2ELb1EE_BB_0:
(W)     mov (16|M0)              r40.0<1>:ud   r0.0<1;1,0>:ud                                        //  ALU pipe: int; $1
        and (1|M0)               cr0.0<1>:ud   cr0.0<0;1,0>:ud   -1073743089:d               {A@1}   // $1
        or (1|M0)                cr0.0<1>:ud   cr0.0<0;1,0>:ud   1073743040:d               {A@1}    // $2
        mov (1|M0)               r1.4<1>:d     r1.2<0;1,0>:uw                   {A@1,$0.dst}         //  ALU pipe: int; $4
        mov (2|M0)               r1.2<1>:d     r1.0<1;1,0>:uw                                        //  ALU pipe: int; $3
        mul (1|M0)               acc0.0<1>:ud  r2.1<0;1,0>:ud    r1.8<0;1,0>:uw   {@2,$1.dst}        //  ALU pipe: int; $6
        mach (1|M0)              r7.0<1>:ud    r2.1<0;1,0>:ud    r1.4<0;1,0>:ud   {Compacted}        //  ALU pipe: int; 
        mov (1|M0)               r2.2<1>:q     r2.0<0;1,0>:ud                                        //  ALU pipe: int; $5
        mov (1|M0)               r6.0<1>:ud    acc0.0<0;1,0>:ud                 {Compacted}          //  ALU pipe: int; 
        mov (1|M0)               r8.1<1>:d     r7.0<0;1,0>:d                    {Compacted,I@3}      //  ALU pipe: int; $8
        mov (1|M0)               r8.0<1>:f     r6.0<0;1,0>:f                    {Compacted,I@2}      //  ALU pipe: float; $7
        add (1|M0)               r41.5<1>:d    r4.1<0;1,0>:d     1:w                                 //  ALU pipe: int; $25
        add (1|M0)               r8.0<1>:q     r8.0<0;1,0>:q     r1.3<0;1,0>:ud   {A@1}              //  ALU pipe: int; $9
        mov (1|M0)               r41.7<1>:d    r0.1<0;1,0>:ud                                        //  ALU pipe: int; $18
        mul (1|M0)               acc0.0<1>:ud  r8.0<0;1,0>:ud    r2.8<0;1,0>:uw   {I@2}              //  ALU pipe: int; $10
        mach (1|M0)              r11.0<1>:ud   r8.0<0;1,0>:ud    r2.4<0;1,0>:ud                      //  ALU pipe: int; 
        shr (1|M0)               r41.6<1>:ud   r41.5<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $26
        mov (1|M0)               r10.0<1>:ud   acc0.0<0;1,0>:ud                 {Compacted}          //  ALU pipe: int; 
(W)     mul (1|M0)               acc0.0<1>:d   r8.0<0;1,0>:d     r2.10<0;1,0>:uw                     //  ALU pipe: int; $11
        macl (1|M0)              r12.0<1>:d    r8.0<0;1,0>:d     r2.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $12
(W)     mul (1|M0)               acc0.0<1>:d   r8.1<0;1,0>:d     r2.8<0;1,0>:uw                      //  ALU pipe: int; $12
        macl (1|M0)              r13.0<1>:d    r8.1<0;1,0>:d     r2.4<0;1,0>:d    {Compacted}        //  ALU pipe: int; $13
        mov (1|M0)               r14.0<1>:f    r10.0<0;1,0>:f                   {Compacted,I@5}      //  ALU pipe: float; $13
        add3 (1|M0)              r14.1<1>:d    r13.0<0;0>:d      r11.0<0;0>:d      r12.0<0>:d       {I@1} //  ALU pipe: int; $14
        mov (1|M0)               r41.2<1>:d    r0.6<0;1,0>:ud                                        //  ALU pipe: int; $19
        add (1|M0)               r14.0<1>:q    r14.0<0;1,0>:q    r1.2<0;1,0>:ud   {A@1}              //  ALU pipe: int; $15
        shl (1|M0)               r41.7<1>:d    r41.7<0;1,0>:d    8:w                                 //  ALU pipe: int; $20
        cmp (1|M0)    (lt)f1.0   null<1>:ud    r14.0<0;1,0>:ud   0x10:uw              {I@2}          //  ALU pipe: int; $33
        shr (1|M0)               r41.0<1>:uq   r14.0<0;1,0>:uq   0x4:uw                              //  ALU pipe: int; $17
        add (1|M0)               r41.4<1>:d    r41.2<0;1,0>:d    1:w                                 //  ALU pipe: int; $23
(W)     mul (1|M0)               acc0.0<1>:ud  r41.6<0;1,0>:ud   r41.0<0;1,0>:uw  {I@2}              //  ALU pipe: int; $27
(f1.0)  cmp (1|M0)    (eq)f1.0   null<1>:d     r14.1<0;1,0>:d    0:w                                 //  ALU pipe: int; $34
        add (1|M0)               r41.3<1>:d    r41.7<0;1,0>:d    256:w                               //  ALU pipe: int; $21
        macl (1|M0)              r57.0<1>:ud   r41.6<0;1,0>:ud   r41.0<0;1,0>:ud                     //  ALU pipe: int; $28
        add (1|M0)               r41.6<1>:ud   r41.6<0;1,0>:ud   0x1F:uw                             //  ALU pipe: int; $31
        and (1|M0)               r41.15<1>:d   r14.0<0;1,0>:d    15:w                                //  ALU pipe: int; $16
        mul (1|M0)               r41.12<1>:d   r41.0<0;1,0>:d    2176:w                              //  ALU pipe: int; $29
        sel (1|M0)    (lt)f0.0   r41.4<1>:ud   r41.4<0;1,0>:ud   r4.0<0;1,0>:ud   {I@7}              //  ALU pipe: int; $24
        sel (1|M0)    (lt)f0.0   r41.3<1>:ud   r41.3<0;1,0>:ud   r4.2<0;1,0>:ud   {I@6}              //  ALU pipe: int; $22
        shr (1|M0)               r69.0<1>:ud   r57.0<0;1,0>:ud   0x7:uw              {Compacted,I@6} //  ALU pipe: int; $28
        shr (1|M0)               r63.0<1>:ud   r57.0<0;1,0>:ud   0x5:uw              {Compacted}     //  ALU pipe: int; $30
        shr (1|M0)               r41.6<1>:ud   r41.6<0;1,0>:ud   0x5:uw              {I@7}           //  ALU pipe: int; $32
(W&f1.0) jmpi                                BB_1                                                    //  ALU pipe: int; $36
// B003: Preds:{B002},  Succs:{B005}
_L_k13_0_:
        mov (2|M0)               r2.16<1>:w    0x87878787:uv                                         //  ALU pipe: int; $39
        add (1|M0)               r1.1<1>:uq    r41.0<0;1,0>:uq   0xFFFFFFFF:ud                       //  ALU pipe: int; $37
        add (2|M0)               r3.0<1>:d     r2.16<1;1,0>:w    -8:w               {I@2}            //  ALU pipe: int; $39
        mov (1|M0)               r4.6<1>:q     r4.2<0;1,0>:ud                                        //  ALU pipe: int; $41
        and (2|M0)               r1.2<1>:d     r1.2<1;1,0>:d     r3.0<1;1,0>:d    {I@2}              //  ALU pipe: int; $40
        mul (1|M0)               acc0.0<1>:ud  r1.2<0;1,0>:ud    r4.24<0;1,0>:uw  {I@1}              //  ALU pipe: int; $42
        mach (1|M0)              r7.0<1>:ud    r1.2<0;1,0>:ud    r4.12<0;1,0>:ud                     //  ALU pipe: int; 
        mov (1|M0)               r6.0<1>:ud    acc0.0<0;1,0>:ud                                      //  ALU pipe: int; 
(W)     mul (1|M0)               acc0.0<1>:d   r1.2<0;1,0>:d     r4.26<0;1,0>:uw                     //  ALU pipe: int; $43
        macl (1|M0)              r8.0<1>:d     r1.2<0;1,0>:d     r4.13<0;1,0>:d                      //  ALU pipe: int; $44
(W)     mul (1|M0)               acc0.0<1>:d   r1.3<0;1,0>:d     r4.24<0;1,0>:uw                     //  ALU pipe: int; $44
        macl (1|M0)              r9.0<1>:d     r1.3<0;1,0>:d     r4.12<0;1,0>:d                      //  ALU pipe: int; $45
        mov (1|M0)               r41.8<1>:d    r6.0<0;1,0>:d                    {I@5}                //  ALU pipe: int; $45
        add3 (1|M0)              r41.9<1>:d    r9.0<0;0>:d       r7.0<0;0>:d       r8.0<0>:d        {I@2} //  ALU pipe: int; $46
        shl (1|M0)               r41.4<1>:q    r41.4<0;1,0>:q    2:w               {I@1}             //  ALU pipe: int; $47
        add (1|M0)               r41.4<1>:q    r5.5<0;1,0>:q     r41.4<0;1,0>:q   {I@1}              //  ALU pipe: int; $48
(W)     jmpi                                 BB_2                                                    // $49
// B004: Preds:{B002},  Succs:{B005}
BB_1:
        mov (1|M0)               r41.4<1>:q    0:w                                                   //  ALU pipe: int; $51
// B005: Preds:{B004, B003},  Succs:{B006, B007}
BB_2:
        mov (8|M0)               r6.0<1>:w     0x76543210:v                                          //  ALU pipe: int; $71
        shl (1|M0)               r41.13<1>:d   r41.15<0;1,0>:d   4:w                                 //  ALU pipe: int; $53
        mov (8|M0)               r89.0<1>:d    r6.0<1;1,0>:w                    {I@2}                //  ALU pipe: int; $71
        or (1|M0)                r41.7<1>:d    r41.13<0;1,0>:d   r41.7<0;1,0>:d   {I@2}              //  ALU pipe: int; $54
        add (8|M0)               r89.8<1>:d    r89.0<1;1,0>:d    8:w               {I@2}             //  ALU pipe: int; $72
        cmp (1|M0)    (eq)f0.1   null<1>:d     r41.9<0;1,0>:d    0:w                                 //  ALU pipe: int; $77
        or (16|M0)               r95.0<1>:d    r41.7<0;1,0>:d    r89.0<1;1,0>:d   {I@2}              //  ALU pipe: int; $73
        shl (16|M0)              r96.0<1>:d    r95.0<1;1,0>:d    2:w               {Compacted,I@1}   //  ALU pipe: int; $74
        mov (16|M0)              r7.0<2>:ud    r96.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $75
        add (16|M0)              r9.0<1>:q     r5.4<0;1,0>:q     r7.0<2;1,0>:ud   {I@1}              //  ALU pipe: int; $75
        load.ugm.d32.a64.ca.ca (16|M0)  r97:1   [r9:2]             {I@1,$2} // ex_desc:0x0; desc:0x4180580 // $76
        shl (1|M0)               r3.0<1>:d     r4.3<0;1,0>:d     1:w                                 //  ALU pipe: int; $55
        shl (1|M0)               r41.10<1>:d   r4.4<0;1,0>:d     2:w                                 //  ALU pipe: int; $60
        shl (1|M0)               r41.11<1>:d   r5.4<0;1,0>:d     1:w                                 //  ALU pipe: int; $65
(W)     mov (1|M0)               r4.12<1>:f    0x10100000:f                                          //  (0x10100000:f); ALU pipe: float; $69
(W)     mul (1|M0)               acc0.0<1>:d   r3.0<0;1,0>:d     r41.4<0;1,0>:uw  {I@3}              //  ALU pipe: int; $56
        mov (1|M0)               r57.1<1>:q    r57.0<0;1,0>:ud                                       //  ALU pipe: int; $57
        mov (1|M0)               r57.3<1>:q    r41.7<0;1,0>:ud                                       //  ALU pipe: int; $62
(f0.1)  cmp (1|M0)    (eq)f0.1   null<1>:d     r41.8<0;1,0>:d    0:w                                 //  ALU pipe: int; $78
        macl (1|M0)              r3.0<1>:d     r3.0<0;1,0>:d     r41.2<0;1,0>:d   {Compacted}        //  ALU pipe: int; $57
(W)     mul (1|M0)               acc0.0<1>:d   r63.0<0;1,0>:d    r41.20<0;1,0>:uw {I@7}              //  ALU pipe: int; $61
        bfn.(s0|s1&s2) (1|M0)    r5.0<1>:ud    r4.12<0;0>:ud     r41.0<0;0>:ud     0xFF:uw              {F@1} //  ALU pipe: int; $69
        macl (1|M0)              r63.0<1>:d    r63.0<0;1,0>:d    r41.10<0;1,0>:d  {Compacted}        //  ALU pipe: int; $62
(W)     mul (1|M0)               acc0.0<1>:d   r69.0<0;1,0>:d    r41.22<0;1,0>:uw {I@7}              //  ALU pipe: int; $66
        shl (1|M0)               r57.1<1>:q    r57.1<0;1,0>:q    1:w               {I@7}             //  ALU pipe: int; $58
        shl (1|M0)               r57.2<1>:q    r57.3<0;1,0>:q    2:w               {I@7}             //  ALU pipe: int; $63
        macl (1|M0)              r69.0<1>:d    r69.0<0;1,0>:d    r41.11<0;1,0>:d  {Compacted}        //  ALU pipe: int; $67
        shl (1|M0)               r57.3<1>:q    r57.3<0;1,0>:q    1:w                                 //  ALU pipe: int; $67
        mov (16|M0)              r83.0<1>:f    r5.0<0;1,0>:f                    {Compacted,I@7}      //  ALU pipe: float; $70
        add (1|M0)               r57.1<1>:q    r57.1<0;1,0>:q    r3.0<0;1,0>:ud   {I@4}              //  ALU pipe: int; $59
        add (1|M0)               r57.2<1>:q    r57.2<0;1,0>:q    r63.0<0;1,0>:ud  {I@4}              //  ALU pipe: int; $64
        add (1|M0)               r57.3<1>:q    r57.3<0;1,0>:q    r69.0<0;1,0>:ud  {I@3}              //  ALU pipe: int; $68
(W&f0.1) jmpi                                BB_3                                                    //  ALU pipe: int; $80
// B006: Preds:{B005},  Succs:{B008}
_L_k13_1_:
        mov (16|M0)              r6.0<2>:ud    r96.0<1;1,0>:ud                  {Compacted}          //  ALU pipe: int; $81
        add (16|M0)              r8.0<1>:q     r41.4<0;1,0>:q    r6.0<2;1,0>:ud   {@1,$2.src}        //  ALU pipe: int; $81
        load.ugm.d32.a64.ca.ca (16|M0)  r98:1   [r8:2]             {I@1,$3} // ex_desc:0x0; desc:0x4180580 // $82
(W)     jmpi                                 BB_4                                                    // $83
// B007: Preds:{B005},  Succs:{B008}
BB_3:
        mov (16|M0)              r98.0<1>:d    0:w                               {Compacted}         //  ALU pipe: int; $86
// B008: Preds:{B007, B006},  Succs:{B009, B010}
BB_4:
        or (16|M0)               r3.0<1>:d     r41.13<0;1,0>:d   r89.0<1;1,0>:d   {Compacted}        //  ALU pipe: int; $88 R{} IR{}{O:4,O:4,},  {BC=1}
        shr (16|M0)              r6.0<2>:uw    r3.0<2;1,0>:uw    0x4:uw              {I@1}           //  ALU pipe: int; $89
        sync.nop                             null                             {Compacted,$3.src}     // $91
        shr (16|M0)              r9.0<2>:uw    r3.0<2;1,0>:uw    0x5:uw              {$2.src}        //  ALU pipe: int; $91
        shr (16|M0)              r12.0<2>:uw   r3.0<2;1,0>:uw    0x6:uw                              //  ALU pipe: int; $93
        mov (16|M0)              r7.0<1>:uw    r6.0<2;1,0>:uw                   {I@3}                //  ALU pipe: int; $89
        mov (16|M0)              r10.0<1>:uw   r9.0<2;1,0>:uw                   {I@3}                //  ALU pipe: int; $91
        mov (16|M0)              r13.0<1>:uw   r12.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $93
        mov (16|M0)              r8.0<1>:hf    r7.0<1;1,0>:hf                   {I@3}                //  ALU pipe: float; $89
        mov (16|M0)              r11.0<1>:hf   r10.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $91
        mov (16|M0)              r14.0<1>:hf   r13.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $93
        and (16|M0)              r8.0<1>:uw    r8.0<1;1,0>:uw    0x1:uw              {F@3}           //  ALU pipe: int; $90
        and (16|M0)              r11.0<1>:uw   r11.0<1;1,0>:uw   0x1:uw              {F@2}           //  ALU pipe: int; $92
        and (16|M0)              r14.0<1>:uw   r14.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $94
        add (16|M0)              r18.0<1>:d    r8.0<1;1,0>:uw    r11.0<1;1,0>:uw  {I@2}              //  ALU pipe: int; $97
        add (16|M0)              r19.0<1>:d    r18.0<1;1,0>:d    r14.0<1;1,0>:uw  {I@1}              //  ALU pipe: int; $98
        mov (8|M0)               r25.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $104
        mov (8|M0)               r25.8<1>:w    0xFEDCBA98:uv                                         //  ALU pipe: int; $105
        shr (16|M0)              r15.0<2>:uw   r3.0<2;1,0>:uw    0x7:uw                              //  ALU pipe: int; $95
        shr (16|M0)              r19.0<1>:ud   r89.0<1;1,0>:ud   r19.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $116
        mov (8|M0)               r22.0<1>:w    0x10101010:v                                          //  ALU pipe: int; $100
        shr (16|M0)              r18.0<1>:ud   r89.0<1;1,0>:ud   r18.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $111
        shr (16|M0)              r25.0<1>:uw   r25.0<1;1,0>:uw   r8.0<1;1,0>:uw   {I@5}              //  ALU pipe: int; $106
        mov (16|M0)              r16.0<1>:uw   r15.0<2;1,0>:uw                  {I@5}                //  ALU pipe: int; $95
        shl (16|M0)              r31.0<2>:w    r19.0<2;1,0>:w    15:w               {I@5}            //  ALU pipe: int; $117
        mov (8|M0)               r24.0<1>:d    r22.0<1;1,0>:w                   {I@5}                //  ALU pipe: int; $100
        mov (8|M0)               r24.8<1>:d    r22.0<1;1,0>:w                                        //  ALU pipe: int; $101
        shl (16|M0)              r26.0<2>:w    r18.0<2;1,0>:w    15:w               {I@6}            //  ALU pipe: int; $112
        shl (16|M0)              r25.0<1>:uw   r25.0<1;1,0>:uw   0xF:uw              {I@6}           //  ALU pipe: int; $107
        mov (16|M0)              r17.0<1>:hf   r16.0<1;1,0>:hf                  {I@6}                //  ALU pipe: float; $95
        mov (16|M0)              r32.0<1>:w    r31.0<2;1,0>:w                   {I@5}                //  ALU pipe: int; $117
        mul (16|M0)              acc0.0<1>:d   r24.0<1;1,0>:d    0x8000:uw              {I@4}        //  ALU pipe: int; $102
        mov (16|M0)              r27.0<1>:w    r26.0<2;1,0>:w                   {I@4}                //  ALU pipe: int; $112
        or (16|M0)               r25.0<1>:uw   r25.0<1;1,0>:uw   0x3C00:uw              {I@4}        //  ALU pipe: int; $108
        and (16|M0)              r17.0<1>:uw   r17.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $96
        mov (16|M0)              r33.0<1>:hf   r32.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $117
        add (16|M0)              r24.0<1>:d    acc0.0<1;1,0>:d   15360:w                             //  ALU pipe: int; $103
        mov (16|M0)              acc0.0<1>:d   -r11.0<1;1,0>:uw                                      //  ALU pipe: int; $109
        mov (16|M0)              r28.0<1>:hf   r27.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $112
        or (16|M0)               r33.0<1>:w    r33.0<1;1,0>:w    15360:w               {F@2}         //  ALU pipe: int; $118
        and (16|M0)              acc0.0<1>:d   r25.0<1;1,0>:uw   acc0.0<1;1,0>:d  {I@5}              //  ALU pipe: int; $110
        mov (16|M0)              acc2.0<1>:d   -r17.0<1;1,0>:uw                 {I@5}                //  ALU pipe: int; $119
        shl (16|M0)              r3.0<1>:d     r3.0<1;1,0>:d     3:w                                 //  ALU pipe: int; $121
        or (16|M0)               r28.0<1>:w    r28.0<1;1,0>:w    15360:w               {F@1}         //  ALU pipe: int; $113
        and (16|M0)              acc2.0<1>:d   r33.0<1;1,0>:uw   acc2.0<1;1,0>:d  {I@5}              //  ALU pipe: int; $120
        mov (16|M0)              r21.0<1>:d    -r8.0<1;1,0>:uw                                       //  ALU pipe: int; $99
        mov (16|M0)              r30.0<1>:d    -r14.0<1;1,0>:uw                                      //  ALU pipe: int; $115
        add (16|M0)              r34.0<1>:d    r3.0<1;1,0>:d     r41.12<0;1,0>:d  {I@5}              //  ALU pipe: int; $122
        mov (16|M0)              r29.0<1>:d    r28.0<1;1,0>:uw                  {I@5}                //  ALU pipe: int; $114
        shl (16|M0)              r35.0<1>:d    acc0.0<1;1,0>:d   16:w                                //  ALU pipe: int; $123
        shl (16|M0)              r37.0<1>:d    acc2.0<1;1,0>:d   16:w                                //  ALU pipe: int; $125
        cmp (1|M0)    (eq)f3.1   null<1>:d     r41.15<0;1,0>:d   0:w                                 //  ALU pipe: int; $130
        or (16|M0)               r39.0<1>:ud   r34.0<1;1,0>:ud   0x4:uw              {I@5}           //  ALU pipe: int; $128
        bfn.(s0|s1&s2) (16|M0)   r36.0<1>:ud   r35.0<1;0>:ud     r21.0<1;0>:ud     r24.0<1>:ud      {I@4} //  ALU pipe: int; $124
        bfn.(s0|s1&s2) (16|M0)   r38.0<1>:ud   r37.0<1;0>:ud     r29.0<1;0>:ud     r30.0<1>:ud      {I@4} //  ALU pipe: int; $126
        store.slm.d32.a32 (16|M0)  [r34:1]      r36:1              {I@2,$4} // ex_desc:0x0; desc:0x2000504 // $127
        store.slm.d32.a32 (16|M0)  [r39:1]      r38:1              {I@1,$5} // ex_desc:0x0; desc:0x2000504 // $129
(W&~f3.1) jmpi                               BB_5                                                    //  ALU pipe: int; $131
// B009: Preds:{B008},  Succs:{B010}
_L_k13_2_:
        mul (16|M0)              acc0.0<1>:ud  r89.0<1;1,0>:ud   0x4:uw                              //  ALU pipe: int; $132
        add (16|M0)              acc2.0<1>:ud  acc0.0<1;1,0>:ud  0x800:uw                            //  ALU pipe: int; $133
        add (16|M0)              r3.0<1>:ud    r41.12<0;1,0>:ud  acc2.0<1;1,0>:ud                    //  ALU pipe: int; $134
        add (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  0x840:uw                            //  ALU pipe: int; $138
        mov (16|M0)              r6.0<1>:d     1920:w                               {Compacted}      //  ALU pipe: int; $136
        mov (16|M0)              r8.0<1>:d     120:w                               {Compacted}       //  ALU pipe: int; $141
        add (16|M0)              r7.0<1>:ud    r41.12<0;1,0>:ud  acc0.0<1;1,0>:ud                    //  ALU pipe: int; $139
        store.slm.d32.a32 (16|M0)  [r3:1]       r6:1               {I@3,$6} // ex_desc:0x0; desc:0x2000504 // $137
        store.slm.d32.a32 (16|M0)  [r7:1]       r8:1               {I@1,$7} // ex_desc:0x0; desc:0x2000504 // $142
// B010: Preds:{B009, B008},  Succs:{B011, B013}
BB_5:
        sync.nop                             null                             {Compacted,$6.src}     // $144
(W)     send.slm (1|M0)          r3       r40  null:0  0x0            0x0210001F           {$8} // wr:1+0, rd:1; fence.slm.none.group // $144
(W)     mov (8|M0)               null<1>:ud    r3.0<1;1,0>:ud                   {Compacted,$8.dst}   //  memory fence commit; ALU pipe: int; $145
        send.gtwy (1|M0)         null     r83  null:0  0x0            0x02000004           {$9} // wr:1+0, rd:0; signal barrier // $145
(W)     mov (1|M0)               f1.0<1>:uw    r41.0<0;1,0>:b                                        //  ALU pipe: int; $146
(W)     sync.bar                             f1.0:uw                                                 // $146
        add (1|M0)               r5.0<1>:d     r41.12<0;1,0>:d   2048:w                              //  ALU pipe: int; $147
        add (1|M0)               r6.0<1>:d     r41.12<0;1,0>:d   2112:w                              //  ALU pipe: int; $149
        load.slm.d32x16t.a32 (1|M0)  r99:1      [r5:1]             {I@2,$10} // ex_desc:0x0; desc:0x210D500 // $148
        load.slm.d32x16t.a32 (1|M0)  r100:1     [r6:1]             {I@1,$11} // ex_desc:0x0; desc:0x210D500 // $150
        cmp (1|M0)    (lt)f3.0   null<1>:ud    r41.5<0;1,0>:ud   0x2:uw                              //  ALU pipe: int; $154
        mov (16|M0)              r102.0<1>:f   0.0:f                                                 //  ALU pipe: float; $153
(W&f3.0) jmpi                                BB_6                                                    //  ALU pipe: int; $155
// B011: Preds:{B010},  Succs:{B012}
_L_k13_3_:
        sel (1|M0)    (ge)f0.0   r41.6<1>:ud   r41.6<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $156
        mov (1|M0)               r41.14<1>:d   0:w                                                   //  ALU pipe: int; $157
// B012: Preds:{B012, B011},  Succs:{B013, B012}
BB_7:
        shr (1|M0)               r3.0<1>:uq    r57.1<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $159
        shr (1|M0)               r8.0<1>:uq    r57.2<0;1,0>:uq   0x3:uw              {$7.src}        //  ALU pipe: int; $164
        shr (1|M0)               r10.0<1>:uq   r57.3<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $169
        shl (1|M0)               r3.0<1>:uq    r3.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $160
        shl (1|M0)               r8.0<1>:uq    r8.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $165
        shl (1|M0)               r10.0<1>:uq   r10.0<0;1,0>:uq   0x3:uw              {I@3}           //  ALU pipe: int; $170
        add (1|M0)               r3.0<1>:uq    r4.3<0;1,0>:uq    r3.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $161
        add (1|M0)               r8.0<1>:uq    r4.4<0;1,0>:uq    r8.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $166
        add (1|M0)               r10.0<1>:uq   r5.1<0;1,0>:uq    r10.0<0;1,0>:uq  {I@3}              //  ALU pipe: int; $171
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r7:1  [r3:1]             {I@3,$12} // ex_desc:0x0; desc:0x218C780 // $163
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r9:1  [r8:1]             {I@2,$13} // ex_desc:0x0; desc:0x218C780 // $168
        load.ugm.d64x4t.a64.ca.ca (1|M0)  r11:1 [r10:1]            {I@1,$14} // ex_desc:0x0; desc:0x218B780 // $173
        add (1|M0)               r41.14<1>:d   r41.14<0;1,0>:d   1:w                                 //  ALU pipe: int; $174
        and (1|M0)    (eq)f2.1   null<1>:d     r41.14<0;1,0>:d   3:w               {I@1}             //  ALU pipe: int; $178
        add (1|M0)               r57.1<1>:uq   r57.1<0;1,0>:uq   0x40:uw                             //  ALU pipe: int; $177
(f2.1)  sel (1|M0)               r12.0<1>:d    r41.11<0;1,0>:d   0:w                                 //  ALU pipe: int; $180
        shr (16|M0)              acc2.0<1>:ud  r98.0<1;1,0>:ud   0x5:uw              {$3.dst}        //  ALU pipe: int; $184
        add (16|M0)              acc2.0<1>:ud  acc2.0<1;1,0>:ud  r97.0<1;1,0>:ud  {$2.dst}           //  ALU pipe: int; $185
        shl (16|M0)              r15.0<1>:ud   acc2.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $186
        mov (16|M0)              r16.0<2>:ud   r15.0<1;1,0>:ud                  {I@1}                //  ALU pipe: int; $187
        add (16|M0)              r18.0<1>:q    r5.3<0;1,0>:q     r16.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $187
        load.ugm.d32x3.a64.ca.ca (16|M0)  r20:3 [r18:2]            {I@1,$15} // ex_desc:0x0; desc:0x4382580 // $189
        and (16|M0)   (eq)f1.1   r23.0<2>:w    r98.0<2;1,0>:w    31:w                                //  ALU pipe: int; $192
        mov (16|M0)              r26.0<2>:w    -r98.0<2;1,0>:w                                       //  ALU pipe: int; $194
        mov (16|M0)              r27.0<1>:w    r26.0<2;1,0>:w                   {I@1}                //  ALU pipe: int; $194
        mov (16|M0)              r24.0<1>:w    r23.0<2;1,0>:w                                        //  ALU pipe: int; $192
        mov (16|M0)              r28.0<1>:hf   r27.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $194
        mov (16|M0)              r25.0<1>:hf   r24.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $192
        bfn.(s0&~s2|s1&s2) (16|M0)   acc2.0<1>:ud  r20.0<1;0>:ud  r21.0<1;0>:ud    0x0:uw              {$15.dst} //  ALU pipe: int; $190
        and (16|M0)              r28.0<1>:w    r28.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $195
        bfn.(s0&~s2|s1&s2) (16|M0)   acc0.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud    0x0:uw              //  ALU pipe: int; $191
        shr (16|M0)              r30.0<1>:ud   acc2.0<1;1,0>:ud  r25.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $197
        shl (16|M0)              r31.0<1>:ud   acc0.0<1;1,0>:ud  r28.0<1;1,0>:uw  {I@3}              //  ALU pipe: int; $198
(~f1.1) or (16|M0)               r30.0<1>:ud   r31.0<1;1,0>:ud   r30.0<1;1,0>:ud  {I@1}              //  ALU pipe: int; $200
        shl (16|M0)              r33.0<1>:ud   r9.0<1;1,0>:ud    0x7:uw              {Compacted,$13.dst} //  ALU pipe: int; $204
        shl (16|M0)              r36.0<1>:ud   r30.0<1;1,0>:ud   0x3:uw              {Compacted,@2,$4.src} //  ALU pipe: int; $206
        and (16|M0)              r34.0<1>:ud   r33.0<1;1,0>:ud   r99.0<1;1,0>:ud  {Compacted,@2,$10.dst} //  ALU pipe: int; $205
        and (16|M0)              r36.0<1>:ud   r36.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,@2,$11.dst} //  ALU pipe: int; $207 R{} IR{}{E:2,E:2,},  {BC=1}
        cbit (16|M0)             r34.0<1>:ud   r34.0<1;1,0>:ud                  {I@2}                //  ALU pipe: int; $214
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  r33.0<1;0>:ud     r99.0<1;0>:ud     r36.0<1>:ud      {I@2} //  ALU pipe: int; $208
        add (16|M0)              r37.0<1>:ud   acc2.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $209
        shr (16|M0)              acc2.0<1>:ud  r30.0<1;1,0>:ud   r34.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $215
        shl (16|M0)              r50.0<1>:ud   r9.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $216
        shl (16|M0)              r52.0<1>:ud   acc2.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $218
        and (16|M0)              r51.0<1>:ud   r50.0<1;1,0>:ud   r99.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $217
        and (16|M0)              r52.0<1>:ud   r52.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $219 R{} IR{}{E:2,E:2,},  {BC=1}
        cbit (16|M0)             r51.0<1>:ud   r51.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $226
        bfn.(s0&s1|s2) (16|M0)   acc0.0<1>:ud  r50.0<1;0>:ud     r99.0<1;0>:ud     r52.0<1>:ud      {I@2} //  ALU pipe: int; $220
        add (16|M0)              r53.0<1>:ud   acc0.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $221
        shr (16|M0)              acc0.0<1>:ud  acc2.0<1;1,0>:ud  r51.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $227
        shr (16|M0)              r13.0<1>:ud   r9.0<1;1,0>:ud    0x1:uw              {Compacted}     //  ALU pipe: int; $182
        shl (16|M0)              r58.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $229
        and (16|M0)              r56.0<1>:ud   r13.0<1;1,0>:ud   r99.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $228
        and (16|M0)              r58.0<1>:ud   r58.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $230
        cbit (16|M0)             r56.0<1>:ud   r56.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $237
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  r13.0<1;0>:ud     r99.0<1;0>:ud     r58.0<1>:ud      {I@2} //  ALU pipe: int; $231
        add (16|M0)              r59.0<1>:ud   acc2.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $232
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r56.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $238
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $239
        shl (16|M0)              r64.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $241
        and (16|M0)              r62.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $240
        and (16|M0)              r64.0<1>:ud   r64.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $242
        cbit (16|M0)             r62.0<1>:ud   r62.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $249
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r64.0<1>:ud      {I@2} //  ALU pipe: int; $243
        add (16|M0)              r65.0<1>:ud   acc2.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $244
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r62.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $250
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $251
        shl (16|M0)              r70.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $253
        and (16|M0)              r68.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $252
        and (16|M0)              r70.0<1>:ud   r70.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $254
        cbit (16|M0)             r68.0<1>:ud   r68.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $261
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r70.0<1>:ud      {I@2} //  ALU pipe: int; $255
        add (16|M0)              r71.0<1>:ud   acc2.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $256
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r68.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $262
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $263
        shl (16|M0)              r84.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $265
        and (16|M0)              r82.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $264
        and (16|M0)              r84.0<1>:ud   r84.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $266 R{} IR{}{E:2,E:2,},  {BC=1}
        cbit (16|M0)             r82.0<1>:ud   r82.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $273
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r84.0<1>:ud      {I@2} //  ALU pipe: int; $267
        add (16|M0)              r85.0<1>:ud   acc2.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $268
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r82.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $274
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $275
        shl (16|M0)              r90.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $277
        and (16|M0)              r88.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $276
        and (16|M0)              r90.0<1>:ud   r90.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $278
        cbit (16|M0)             r88.0<1>:ud   r88.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $286
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r90.0<1>:ud      {I@2} //  ALU pipe: int; $279
        add (16|M0)              r91.0<1>:ud   acc2.0<1;1,0>:ud  r41.12<0;1,0>:ud                    //  ALU pipe: int; $280
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r88.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $287
        shl (16|M0)              r30.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $288
        cbit (16|M0)             r14.0<1>:ud   r9.0<1;1,0>:ud                   {Compacted}          //  ALU pipe: int; $183
        and (16|M0)              r30.0<1>:ud   r30.0<1;1,0>:ud   r100.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $289
        shr (16|M0)              r9.0<1>:ud    r9.0<1;1,0>:ud    0x15:uw                             //  ALU pipe: int; $285
        bfn.(s0&s1|s2) (16|M0)   r9.0<1>:ud    r9.0<1;0>:ud      r99.0<1;0>:ud     r30.0<1>:ud      {I@1} //  ALU pipe: int; $290
        add (16|M0)              r94.0<1>:ud   r9.0<1;1,0>:ud    r41.12<0;1,0>:ud {I@1}              //  ALU pipe: int; $291
        load.slm.d32x2.a32 (16|M0)  r38:2       [r37:1]            {$0} // ex_desc:0x0; desc:0x2201500 // $211
        load.slm.d32x2.a32 (16|M0)  r54:2       [r53:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $223
        load.slm.d32x2.a32 (16|M0)  r60:2       [r59:1]            {$6} // ex_desc:0x0; desc:0x2201500 // $234
        load.slm.d32x2.a32 (16|M0)  r66:2       [r65:1]            {$8} // ex_desc:0x0; desc:0x2201500 // $246
        load.slm.d32x2.a32 (16|M0)  r72:2       [r71:1]            {$13} // ex_desc:0x0; desc:0x2201500 // $258
        load.slm.d32x2.a32 (16|M0)  r86:2       [r85:1]            {$15} // ex_desc:0x0; desc:0x2201500 // $270
        load.slm.d32x2.a32 (16|M0)  r92:2       [r91:1]            {$2} // ex_desc:0x0; desc:0x2201500 // $282
        load.slm.d32x2.a32 (16|M0)  r8:2        [r94:1]            {I@1,$3} // ex_desc:0x0; desc:0x2201500 // $293
        mov (16|M0)              r32.0<2>:uw   r11.0<1;1,0>:uw                  {$14.dst}            //  ALU pipe: int; $202
        mov (16|M0)              r32.1<2>:uw   r11.0<1;1,0>:uw                                       //  ALU pipe: int; $203
        add (1|M0)               r57.2<1>:q    r57.2<0;1,0>:q    r41.10<0;1,0>:ud                    //  ALU pipe: int; $296 R{} IR{}{O:4,O:4,},  {BC=1}
        add (1|M0)               r57.3<1>:q    r57.3<0;1,0>:q    r12.0<0;1,0>:ud                     //  ALU pipe: int; $297
        add (16|M0)              r98.0<1>:ud   r14.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $298
        sync.nop                             null                             {Compacted,I@4}        // $212
        mul (32|M0)              r42.0<1>:hf   r32.0<1;1,0>:hf   r38.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $212
        mul (32|M0)              r43.0<1>:hf   r32.0<1;1,0>:hf   r39.0<1;1,0>:hf                     //  ALU pipe: float; $213
        mul (32|M0)              r44.0<1>:hf   r32.0<1;1,0>:hf   r54.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $224
        mul (32|M0)              r45.0<1>:hf   r32.0<1;1,0>:hf   r55.0<1;1,0>:hf                     //  ALU pipe: float; $225
        mul (32|M0)              r46.0<1>:hf   r32.0<1;1,0>:hf   r60.0<1;1,0>:hf  {$6.dst}           //  ALU pipe: float; $235
        mul (32|M0)              r47.0<1>:hf   r32.0<1;1,0>:hf   r61.0<1;1,0>:hf                     //  ALU pipe: float; $236
        mul (32|M0)              r48.0<1>:hf   r32.0<1;1,0>:hf   r66.0<1;1,0>:hf  {$8.dst}           //  ALU pipe: float; $247
        mul (32|M0)              r49.0<1>:hf   r32.0<1;1,0>:hf   r67.0<1;1,0>:hf                     //  ALU pipe: float; $248
        mul (32|M0)              r74.0<1>:hf   r32.0<1;1,0>:hf   r72.0<1;1,0>:hf  {$13.dst}          //  ALU pipe: float; $259
        mul (32|M0)              r75.0<1>:hf   r32.0<1;1,0>:hf   r73.0<1;1,0>:hf                     //  ALU pipe: float; $260
        mul (32|M0)              r76.0<1>:hf   r32.0<1;1,0>:hf   r86.0<1;1,0>:hf  {$15.dst}          //  ALU pipe: float; $271
        mul (32|M0)              r77.0<1>:hf   r32.0<1;1,0>:hf   r87.0<1;1,0>:hf                     //  ALU pipe: float; $272
        mul (32|M0)              r78.0<1>:hf   r32.0<1;1,0>:hf   r92.0<1;1,0>:hf  {$2.dst}           //  ALU pipe: float; $283
        mul (32|M0)              r79.0<1>:hf   r32.0<1;1,0>:hf   r93.0<1;1,0>:hf                     //  ALU pipe: float; $284
        mul (32|M0)              r80.0<1>:hf   r32.0<1;1,0>:hf   r8.0<1;1,0>:hf   {$3.dst}           //  ALU pipe: float; $294
        mul (32|M0)              r81.0<1>:hf   r32.0<1;1,0>:hf   r9.0<1;1,0>:hf                      //  ALU pipe: float; $295
        sync.nop                             null                             {Compacted,F@7}        // $300
        dpas.8x1 (16|M0)         r102:f        r102:f            r42:hf            r7.0:hf          {Compacted,$12} // $300
        sync.nop                             null                             {Compacted,F@1}        // $301
        dpas.8x1 (16|M0)         r102:f        r102:f            r74:hf            r7.16:hf         {Compacted,$12} // $301
        mov (1|M0)               null<1>:ud    r102.0<0;1,0>:w                  {$12.dst}            //  ALU pipe: int; $302
        cmp (1|M0)    (eq)f2.0   null<1>:d     r41.14<0;1,0>:d   r41.6<0;1,0>:d                      //  ALU pipe: int; $304
(W&~f2.0) jmpi                               BB_7                                                    //  ALU pipe: int; $305
// B013: Preds:{B012, B010},  Succs:{B014, B015}
BB_6:
        shl (1|M0)               r101.0<1>:d   r41.15<0;1,0>:d   6:w                                 //  ALU pipe: int; $309
        shl (1|M0)               r3.0<1>:d     r41.0<0;1,0>:d    10:w                                //  ALU pipe: int; $310
        add (1|M0)               r101.0<1>:d   r101.0<0;1,0>:d   4352:w               {I@2}          //  ALU pipe: int; $311
        add (1|M0)               r41.15<1>:d   r41.15<0;1,0>:d   2:w                                 //  ALU pipe: int; $314
        add (1|M0)               r3.0<1>:d     r101.0<0;1,0>:d   r3.0<0;1,0>:d    {Compacted,I@2}    //  ALU pipe: int; $312
        or (1|M0)                r4.12<1>:d    r41.15<0;1,0>:d   33685504:d               {I@2}      //  ALU pipe: int; $315
        store.slm.d64x8t.a32 (1|M0)  [r3:1]     r102:1             {I@2,$14} // ex_desc:0x0; desc:0x200C704 // $313
        mov (16|M0)              r6.0<1>:d     r4.12<0;1,0>:d                   {Compacted,@1,$11.src} //  ALU pipe: int; $316
        sync.nop                             null                             {Compacted,$7.src}     // $317
(W)     send.slm (1|M0)          r7       r40  null:0  0x0            0x0210001F           {$15} // wr:1+0, rd:1; fence.slm.none.group // $317
(W)     mov (8|M0)               null<1>:ud    r7.0<1;1,0>:ud                   {Compacted,$15.dst}  //  memory fence commit; ALU pipe: int; $318
        send.gtwy (1|M0)         null     r6  null:0  0x0            0x02000004           {I@2,$0} // wr:1+0, rd:0; signal barrier // $318
(W)     mov (1|M0)               f0.0<1>:uw    r41.60<0;1,0>:b                                       //  ALU pipe: int; $319
(W)     sync.bar                             f0.0:uw                                                 // $319
        and (1|M0)    (eq)f1.1   null<1>:d     r41.0<0;1,0>:d    1:w                                 //  ALU pipe: int; $308
(W&~f1.1) jmpi                               BB_8                                                    //  ALU pipe: int; $321
// B014: Preds:{B013},  Succs:{B015}
_L_k13_4_:
        shr (1|M0)               r1.2<1>:ud    r41.0<0;1,0>:ud   0x1:uw              {Compacted}     //  ALU pipe: int; $322
        mul (16|M0)              r89.0<1>:ud   r89.0<1;1,0>:ud   0x2:uw              {Compacted}     //  ALU pipe: int; $335
        shl (1|M0)               r2.3<1>:ud    r1.2<0;1,0>:ud    0xA:uw              {I@2}           //  ALU pipe: int; $323
        add (1|M0)               r1.2<1>:d     r1.2<0;1,0>:d     r41.2<0;1,0>:d                      //  ALU pipe: int; $331
        add (1|M0)               r101.0<1>:d   r101.0<0;1,0>:d   r2.3<0;1,0>:d    {I@2}              //  ALU pipe: int; $324
(W)     mul (1|M0)               acc0.0<1>:d   r1.2<0;1,0>:d     r4.10<0;1,0>:uw  {I@2}              //  ALU pipe: int; $332
        load.slm.d64x8t.a32 (1|M0)  r3:1        [r101:1]           {I@2,$1} // ex_desc:0x0; desc:0x210C700 // $325
        add (1|M0)               r101.0<1>:d   r101.0<0;1,0>:d   1024:w               {Compacted,$1.src} //  ALU pipe: int; $326
        macl (1|M0)              r9.0<1>:d     r1.2<0;1,0>:d     r4.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $333
        sync.nop                             null                             {Compacted,$0.src}     // $327
        load.slm.d64x8t.a32 (1|M0)  r6:1        [r101:1]           {I@2,$6} // ex_desc:0x0; desc:0x210C700 // $327
        add (1|M0)               r9.0<1>:d     r9.0<0;1,0>:d     r41.7<0;1,0>:d   {Compacted,I@1}    //  ALU pipe: int; $333 R{} IR{}{O:4,O:4,},  {BC=1}
        cmp (16|M0)   (lt)f0.0   null<1>:d     r1.2<0;1,0>:ud    r41.4<0;1,0>:ud                     //  ALU pipe: int; $338
        shl (1|M0)               r9.0<1>:d     r9.0<0;1,0>:d     1:w               {Compacted,I@2}   //  ALU pipe: int; $334
        add (16|M0)              r89.0<1>:ud   r9.0<0;1,0>:ud    r89.0<1;1,0>:ud  {Compacted,I@1}    //  ALU pipe: int; $336
        sync.nop                             null                             {Compacted,$6.dst}     // $328
        add (16|M0)              r6.0<1>:f     r6.0<1;1,0>:f     r3.0<1;1,0>:f    {Compacted,$1.dst} //  ALU pipe: float; $328
(f0.0)  cmp (16|M0)   (lt)f0.0   null<1>:d     r95.0<1;1,0>:ud   r41.3<0;1,0>:ud                     //  ALU pipe: int; $339
        mov (16|M0)              r10.0<2>:ud   r89.0<1;1,0>:ud                  {I@2}                //  ALU pipe: int; $337
        mov (16|M0)              r7.0<1>:hf    r6.0<1;1,0>:f                    {F@1}                //  ALU pipe: float; $329
        add (16|M0)              r12.0<1>:q    r4.5<0;1,0>:q     r10.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $337
        mov (16|M0)              r8.0<1>:d     r7.0<1;1,0>:uw                   {F@1}                //  ALU pipe: int; $330
(f0.0)  store.ugm.d16u32.a64.st.wb (16|M0)  [r12:2] r8:1           {I@1,$7} // ex_desc:0x0; desc:0x40C0B84 // $341
// B015: Preds:{B014, B013},  Succs:{}
BB_8:
(W)     mov (16|M0)              r127.0<1>:f   r40.0<1;1,0>:f                   {Compacted}          //  ALU pipe: float; $343
(W)     send.gtwy (1|M0)         null     r127  null:0  0x0            0x02000010           {EOT,F@1,$8} // wr:1+0, rd:0; end of thread // $343


//.BankConflicts: 6
//.ByteRMWs: 0
//


//.numALUInst: 322
//.accSubDef: 30
//.accSubUse: 41
//.accSubCandidateDef: 31
//.accSubCandidateUse: 43
//
//
//.singlePipeAtOneDistNum: 42
//.allAtOneDistNum: 8
//.syncInstCount: 8
//.tokenReuseCount: 2
//.AfterWriteTokenDepCount: 22
//.AfterReadTokenDepCount: 11
