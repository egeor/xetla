//.kernel _ZTS22int1_fp16_upcvt_kernelILi1ELi512ELi1ELi16ELi64ELi1ELi1ELb1EE
//.platform XE2
//.thread_config numGRF=128, numAcc=4, numSWSB=16
//.options_string "-enablePreemptionR0Only -enableHalfLSC -dumpcommonisa -output -binary -abiver 2 -samplerHeaderWA "
//.full_options "-samplerHeaderWA -enablePreemptionR0Only -abiver 2 -output -binary -dumpcommonisa -enableHalfLSC "
//.instCount 383
//.RA type	LOCAL_ROUND_ROBIN_BC_RA
//.git-hash cd6c33fbee6ccc897657c64b11eae6917cc8ff5e

//.declare BuiltInR0 (0)  rf=r size=64 type=ud align=32 words (r0.0) IsBuiltin
//.declare  (1)  rf=r size=64 type=ud align=32 words (r97.0) IsBuiltin
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
//.declare V57 (65)  rf=r size=8 type=uq align=4 words (r5.1)
//.declare V58 (66)  rf=r size=8 type=uq align=4 words (r5.3)
//.declare V60 (68)  rf=r size=8 type=d align=2 words (r1.2)
//.declare V61 (69)  rf=r size=12 type=d align=2 words (r2.3)
//.declare V62 (70)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V63 (71)  rf=r size=12 type=d align=2 words (r4.12)
//.declare V64 (72)  rf=r size=4 type=d align=2 words (r102.0)
//.declare V65 (73)  rf=r size=4 type=d align=2 words (r5.0)
//.declare V66 (74)  rf=r size=4 type=d align=2 words (r102.1)
//.declare V67 (75)  rf=r size=4 type=d align=2 words (r102.2)
//.declare V68 (76)  rf=r size=8 type=uq align=4 words (r4.4)
//.declare V69 (77)  rf=r size=4 type=d align=2 words (r6.0)
//.declare V70 (78)  rf=r size=4 type=d align=2 words (r7.0)
//.declare V71 (79)  rf=r size=4 type=d align=2 words (r8.0)
//.declare V72 (80)  rf=r size=4 type=d align=32 words (r10.0)
//.declare V73 (81)  rf=r size=4 type=d align=2 words (r102.3)
//.declare V74 (82)  rf=r size=4 type=d align=2 words (r102.4)
//.declare V75 (83)  rf=r size=4 type=d align=2 words (r9.0)
//.declare V76 (84)  rf=r size=64 type=d align=32 words (r103.0)
//.declare V77 (85)  rf=r size=64 type=d align=32 words (r12.0)
//.declare V78 (86)  rf=r size=8 type=uq align=4 words (r5.4)
//.declare V79 (87)  rf=r size=128 type=q align=32 words (r15.0)
//.declare V80 (88)  rf=r size=64 type=d align=32 words (r104.0)
//.declare P1 (89)  rf=f1  size=2 type=uw align=1 words (f2.0)
//.declare V81 (90)  rf=r size=64 type=w align=32 words (r3.0)
//.declare V82 (91)  rf=r size=32 type=w align=2 words (r8.0)
//.declare V83 (92)  rf=r size=32 type=w align=2 words (r11.0)
//.declare V84 (93)  rf=r size=32 type=w align=2 words (r14.0)
//.declare V85 (94)  rf=r size=32 type=w align=2 words (r17.0)
//.declare V86 (95)  rf=r size=64 type=d align=32 words (r21.0)
//.declare V87 (96)  rf=r size=64 type=d align=32 words (r24.0)
//.declare V88 (97)  rf=r size=32 type=w align=8 words (r25.0)
//.declare V89 (98)  rf=r size=64 type=w align=32 words (r18.0)
//.declare V90 (99)  rf=r size=32 type=w align=2 words (r28.0)
//.declare V91 (100)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V92 (101)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V93 (102)  rf=r size=64 type=w align=32 words (r19.0)
//.declare V94 (103)  rf=r size=32 type=w align=2 words (r33.0)
//.declare V95 (104)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V96 (105)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V97 (106)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V98 (107)  rf=r size=64 type=d align=32 words (r37.0)
//.declare V99 (108)  rf=r size=64 type=d align=32 words (r38.0)
//.declare V100 (109)  rf=r size=64 type=d align=32 words (r39.0)
//.declare P2 (110)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V102 (112)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V104 (114)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V105 (115)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V107 (117)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V109 (119)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V110 (120)  rf=r size=4 type=d align=32 words (r7.0)
//.declare V111 (121)  rf=r size=64 type=d align=32 words (r105.0)
//.declare V112 (122)  rf=r size=4 type=d align=32 words (r8.0)
//.declare V113 (123)  rf=r size=64 type=d align=32 words (r106.0)
//.declare P3 (124)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare V116 (127)  rf=r size=4 type=d align=2 words (r102.5)
//.declare V117 (128)  rf=r size=8 type=q align=4 words (r102.3)
//.declare V118 (129)  rf=r size=8 type=q align=4 words (r102.4)
//.declare V119 (130)  rf=r size=64 type=d align=32 words (r107.0)
//.declare V120 (131)  rf=r size=64 type=d align=32 words (r108.0)
//.declare V121 (132)  rf=r size=64 type=d align=32 words (r109.0)
//.declare V122 (133)  rf=r size=64 type=f align=32 words (r110.0)
//.declare V123 (134)  rf=r size=8 type=q align=32 words (r3.0)
//.declare V124 (135)  rf=r size=8 type=q align=32 words (r10.0)
//.declare V125 (136)  rf=r size=32 type=hf align=32 words (r11.0)
//.declare V126 (137)  rf=r size=4 type=d align=2 words (r102.10)
//.declare P4 (138)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare V127 (139)  rf=r size=4 type=d align=2 words (r12.0)
//.declare V128 (140)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V129 (141)  rf=r size=64 type=d align=32 words (r111.0)
//.declare V130 (142)  rf=r size=64 type=d align=32 words (r15.0)
//.declare V131 (143)  rf=r size=128 type=q align=32 words (r18.0)
//.declare V132 (144)  rf=r size=192 type=d align=32 words (r21.0)
//.declare V133 (145)  rf=r size=32 type=w align=2 words (r27.0)
//.declare V135 (147)  rf=r size=32 type=w align=2 words (r30.0)
//.declare V137 (149)  rf=r size=64 type=d align=32 words (r24.0)
//.declare P5 (150)  rf=f16  size=2 type=uw align=1 words (f3.1)
//.declare V138 (151)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V139 (152)  rf=r size=64 type=w align=32 words (r14.0)
//.declare V140 (153)  rf=r size=32 type=w align=2 words (r37.0)
//.declare V142 (155)  rf=r size=32 type=w align=2 words (r40.0)
//.declare V144 (157)  rf=r size=64 type=d align=32 words (r34.0)
//.declare P6 (158)  rf=f16  size=2 type=uw align=1 words (f3.0)
//.declare V145 (159)  rf=r size=64 type=hf align=32 words (r43.0)
//.declare V146 (160)  rf=r size=64 type=d align=32 words (r44.0)
//.declare V147 (161)  rf=r size=64 type=d align=32 words (r46.0)
//.declare V148 (162)  rf=r size=64 type=d align=32 words (r47.0)
//.declare V149 (163)  rf=r size=128 type=hf align=32 words (r48.0)
//.declare V150 (164)  rf=r size=64 type=d align=32 words (r45.0)
//.declare V151 (165)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V152 (166)  rf=r size=64 type=d align=32 words (r60.0)
//.declare V153 (167)  rf=r size=64 type=d align=32 words (r61.0)
//.declare V154 (168)  rf=r size=128 type=hf align=32 words (r62.0)
//.declare V155 (169)  rf=r size=64 type=d align=32 words (r59.0)
//.declare V156 (170)  rf=r size=64 type=d align=32 words (r66.0)
//.declare V157 (171)  rf=r size=64 type=d align=32 words (r67.0)
//.declare V158 (172)  rf=r size=128 type=hf align=32 words (r68.0)
//.declare V159 (173)  rf=r size=64 type=d align=32 words (r64.0)
//.declare V161 (175)  rf=r size=64 type=d align=32 words (r72.0)
//.declare V162 (176)  rf=r size=64 type=d align=32 words (r73.0)
//.declare V163 (177)  rf=r size=128 type=hf align=32 words (r74.0)
//.declare V164 (178)  rf=r size=512 type=d align=32 words (r50.0)
//.declare V165 (179)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V167 (181)  rf=r size=64 type=d align=32 words (r78.0)
//.declare V168 (182)  rf=r size=64 type=d align=32 words (r79.0)
//.declare V169 (183)  rf=r size=128 type=hf align=32 words (r80.0)
//.declare V170 (184)  rf=r size=64 type=d align=32 words (r76.0)
//.declare V172 (186)  rf=r size=64 type=d align=32 words (r92.0)
//.declare V173 (187)  rf=r size=64 type=d align=32 words (r93.0)
//.declare V174 (188)  rf=r size=128 type=hf align=32 words (r94.0)
//.declare V175 (189)  rf=r size=64 type=d align=32 words (r90.0)
//.declare V177 (191)  rf=r size=64 type=d align=32 words (r98.0)
//.declare V178 (192)  rf=r size=64 type=d align=32 words (r99.0)
//.declare V179 (193)  rf=r size=128 type=hf align=32 words (r100.0)
//.declare V180 (194)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V181 (195)  rf=r size=64 type=d align=32 words (r96.0)
//.declare V182 (196)  rf=r size=64 type=d align=32 words (r32.0)
//.declare V183 (197)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V184 (198)  rf=r size=128 type=hf align=32 words (r10.0)
//.declare V185 (199)  rf=r size=512 type=d align=32 words (r82.0)
//.declare V186 (200)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V187 (201)  rf=r size=64 type=d align=32 words (r16.0)
//.declare V188 (202)  rf=r size=64 type=d align=32 words (r17.0)
//.declare V189 (203)  rf=r size=128 type=hf align=32 words (r18.0)
//.declare V190 (204)  rf=r size=64 type=d align=32 words (r14.0)
//.declare V191 (205)  rf=r size=64 type=d align=32 words (r28.0)
//.declare V192 (206)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V193 (207)  rf=r size=128 type=hf align=32 words (r31.0)
//.declare V194 (208)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V195 (209)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V196 (210)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V197 (211)  rf=r size=128 type=hf align=32 words (r37.0)
//.declare V198 (212)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V199 (213)  rf=r size=64 type=d align=32 words (r40.0)
//.declare V200 (214)  rf=r size=64 type=d align=32 words (r41.0)
//.declare V201 (215)  rf=r size=128 type=hf align=32 words (r45.0)
//.declare V202 (216)  rf=r size=512 type=d align=32 words (r20.0)
//.declare V203 (217)  rf=r size=64 type=d align=32 words (r44.0)
//.declare V204 (218)  rf=r size=64 type=d align=32 words (r48.0)
//.declare V205 (219)  rf=r size=64 type=d align=32 words (r49.0)
//.declare V206 (220)  rf=r size=128 type=hf align=32 words (r59.0)
//.declare V207 (221)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V208 (222)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V209 (223)  rf=r size=64 type=d align=32 words (r71.0)
//.declare V210 (224)  rf=r size=128 type=hf align=32 words (r73.0)
//.declare V211 (225)  rf=r size=64 type=d align=32 words (r72.0)
//.declare V212 (226)  rf=r size=64 type=d align=32 words (r76.0)
//.declare V213 (227)  rf=r size=64 type=d align=32 words (r77.0)
//.declare V214 (228)  rf=r size=128 type=hf align=32 words (r79.0)
//.declare V215 (229)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V216 (230)  rf=r size=64 type=d align=32 words (r78.0)
//.declare V217 (231)  rf=r size=64 type=d align=32 words (r42.0)
//.declare V218 (232)  rf=r size=64 type=d align=32 words (r81.0)
//.declare V219 (233)  rf=r size=128 type=hf align=32 words (r90.0)
//.declare V220 (234)  rf=r size=512 type=d align=32 words (r61.0)
//.declare V221 (235)  rf=r size=128 type=d align=32 words (r6.0)
//.declare P7 (236)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare V222 (237)  rf=r size=32 type=w align=16 words (r1.16)
//.declare V224 (239)  rf=r size=64 type=d align=32 words (r112.0)
//.declare V225 (240)  rf=r size=4 type=d align=2 words (r102.11)
//.declare V226 (241)  rf=r size=4 type=d align=2 words (r102.12)
//.declare V227 (242)  rf=r size=4 type=d align=2 words (r1.2)
//.declare V228 (243)  rf=r size=8 type=d align=4 words (r102.14)
//.declare V229 (244)  rf=r size=4 type=d align=32 words (r6.0)
//.declare V231 (246)  rf=r size=64 type=d align=32 words (r113.0)
//.declare V232 (247)  rf=r size=8 type=uq align=4 words (r4.5)
//.declare V233 (248)  rf=r size=128 type=q align=32 words (r9.0)
//.declare P8 (249)  rf=f16  size=2 type=uw align=1 words (f0.1)
//.declare P9 (250)  rf=f16  size=2 type=uw align=1 words (f0.0)
//.declare P10 (251)  rf=f16  size=2 type=uw align=1 words (f2.1)
//.declare V234 (252)  rf=r size=6 type=uw alias=V33+0 align=1 words (r1.0)
//.declare V235 (253)  rf=r size=8 type=d alias=V60+0 align=2 words (r1.2)
//.declare V237 (255)  rf=r size=12 type=d alias=V34+0 align=2 words (r2.0)
//.declare V238 (256)  rf=r size=12 type=d alias=V61+0 align=2 words (r2.3)
//.declare V239 (257)  rf=r size=4 type=d alias=V62+0 align=2 words (r3.0)
//.declare V240 (258)  rf=r size=12 type=d alias=V63+0 align=2 words (r4.12)
//.declare V241 (259)  rf=r size=4 type=d alias=V64+0 align=2 words (r102.0)
//.declare V242 (260)  rf=r size=4 type=d alias=V65+0 align=2 words (r5.0)
//.declare V243 (261)  rf=r size=4 type=d alias=V225+0 align=2 words (r102.11)
//.declare V244 (262)  rf=r size=4 type=ud alias=V225+0 align=2 words (r102.11)
//.declare V245 (263)  rf=r size=4 type=ud alias=V38+0 align=2 words (r4.2)
//.declare V246 (264)  rf=r size=4 type=d alias=V66+0 align=2 words (r102.1)
//.declare V247 (265)  rf=r size=4 type=d alias=V37+0 align=2 words (r4.1)
//.declare V248 (266)  rf=r size=4 type=d alias=V67+0 align=2 words (r102.2)
//.declare V249 (267)  rf=r size=8 type=q alias=V68+0 align=4 words (r4.4)
//.declare V250 (268)  rf=r size=64 type=q alias=V119+0 align=32 words (r107.0)
//.declare V251 (269)  rf=r size=4 type=ud alias=V69+0 align=2 words (r6.0)
//.declare V252 (270)  rf=r size=64 type=ud alias=V119+0 align=32 words (r107.0)
//.declare V253 (271)  rf=r size=4 type=ud alias=V70+0 align=2 words (r7.0)
//.declare V254 (272)  rf=r size=4 type=ud alias=V37+0 align=2 words (r4.1)
//.declare V255 (273)  rf=r size=4 type=d alias=V71+0 align=2 words (r8.0)
//.declare V256 (274)  rf=r size=4 type=d alias=V40+0 align=2 words (r4.4)
//.declare V257 (275)  rf=r size=64 type=d alias=V119+0 align=32 words (r107.0)
//.declare V258 (276)  rf=r size=4 type=d alias=V75+0 align=2 words (r9.0)
//.declare V259 (277)  rf=r size=4 type=d alias=V72+0 align=2 words (r10.0)
//.declare V260 (278)  rf=r size=4 type=d alias=V39+0 align=2 words (r4.3)
//.declare V261 (279)  rf=r size=4 type=d alias=V226+0 align=2 words (r102.12)
//.declare V262 (280)  rf=r size=64 type=d alias=V120+0 align=32 words (r108.0)
//.declare V263 (281)  rf=r size=4 type=ud alias=V73+0 align=2 words (r102.3)
//.declare V264 (282)  rf=r size=4 type=ud alias=V66+0 align=2 words (r102.1)
//.declare V265 (283)  rf=r size=4 type=ud alias=V72+0 align=2 words (r10.0)
//.declare V266 (284)  rf=r size=4 type=d alias=V74+0 align=2 words (r102.4)
//.declare V267 (285)  rf=r size=4 type=d alias=V52+0 align=2 words (r5.4)
//.declare V268 (286)  rf=r size=8 type=q alias=V228+0 align=4 words (r102.7)
//.declare V269 (287)  rf=r size=4 type=ud alias=V75+0 align=2 words (r9.0)
//.declare V270 (288)  rf=r size=8 type=q alias=V228+0 align=4 words (r102.7)
//.declare V271 (289)  rf=r size=64 type=d alias=V231+0 align=32 words (r113.0)
//.declare V272 (290)  rf=r size=64 type=d alias=V76+0 align=32 words (r103.0)
//.declare V273 (291)  rf=r size=64 type=d alias=V77+0 align=32 words (r12.0)
//.declare V274 (292)  rf=r size=128 type=q alias=V79+0 align=32 words (r15.0)
//.declare V275 (293)  rf=r size=8 type=q alias=V78+0 align=4 words (r5.4)
//.declare V276 (294)  rf=r size=64 type=ud alias=V77+0 align=32 words (r12.0)
//.declare V277 (295)  rf=r size=128 type=uq alias=V79+0 align=32 words (r15.0)
//.declare V278 (296)  rf=r size=4 type=ud alias=V64+0 align=2 words (r102.0)
//.declare V279 (297)  rf=r size=64 type=d alias=V81+0 align=32 words (r3.0)
//.declare V280 (298)  rf=r size=32 type=uw alias=V82+0 align=1 words (r8.0)
//.declare V281 (299)  rf=r size=64 type=uw alias=V81+0 align=32 words (r3.0)
//.declare V282 (300)  rf=r size=32 type=uw alias=V83+0 align=1 words (r11.0)
//.declare V283 (301)  rf=r size=32 type=uw alias=V84+0 align=1 words (r14.0)
//.declare V284 (302)  rf=r size=32 type=uw alias=V85+0 align=1 words (r17.0)
//.declare V285 (303)  rf=r size=64 type=d alias=V89+0 align=32 words (r18.0)
//.declare V286 (304)  rf=r size=64 type=d alias=V93+0 align=32 words (r19.0)
//.declare V287 (305)  rf=r size=64 type=d alias=V87+0 align=32 words (r24.0)
//.declare V288 (306)  rf=r size=32 type=uw alias=V88+0 align=1 words (r25.0)
//.declare V289 (307)  rf=r size=64 type=d alias=V96+0 align=32 words (r35.0)
//.declare V290 (308)  rf=r size=64 type=ud alias=V89+0 align=32 words (r18.0)
//.declare V291 (309)  rf=r size=64 type=ud alias=V231+0 align=32 words (r113.0)
//.declare V292 (310)  rf=r size=32 type=w alias=V90+0 align=1 words (r28.0)
//.declare V293 (311)  rf=r size=64 type=w alias=V89+0 align=32 words (r18.0)
//.declare V294 (312)  rf=r size=32 type=uw alias=V90+0 align=1 words (r28.0)
//.declare V295 (313)  rf=r size=64 type=ud alias=V93+0 align=32 words (r19.0)
//.declare V296 (314)  rf=r size=32 type=w alias=V94+0 align=1 words (r33.0)
//.declare V297 (315)  rf=r size=64 type=w alias=V93+0 align=32 words (r19.0)
//.declare V298 (316)  rf=r size=64 type=d alias=V98+0 align=32 words (r37.0)
//.declare V299 (317)  rf=r size=32 type=uw alias=V94+0 align=1 words (r33.0)
//.declare V300 (318)  rf=r size=64 type=d alias=V95+0 align=32 words (r34.0)
//.declare V301 (319)  rf=r size=64 type=ud alias=V97+0 align=32 words (r36.0)
//.declare V302 (320)  rf=r size=64 type=ud alias=V96+0 align=32 words (r35.0)
//.declare V303 (321)  rf=r size=64 type=ud alias=V86+0 align=32 words (r21.0)
//.declare V304 (322)  rf=r size=64 type=ud alias=V87+0 align=32 words (r24.0)
//.declare V305 (323)  rf=r size=64 type=ud alias=V99+0 align=32 words (r38.0)
//.declare V306 (324)  rf=r size=64 type=ud alias=V98+0 align=32 words (r37.0)
//.declare V307 (325)  rf=r size=64 type=ud alias=V91+0 align=32 words (r29.0)
//.declare V308 (326)  rf=r size=64 type=ud alias=V92+0 align=32 words (r30.0)
//.declare V309 (327)  rf=r size=64 type=ud alias=V95+0 align=32 words (r34.0)
//.declare V310 (328)  rf=r size=64 type=ud alias=V100+0 align=32 words (r39.0)
//.declare V312 (330)  rf=r size=64 type=ud alias=V102+0 align=32 words (r3.0)
//.declare V313 (331)  rf=r size=64 type=ud alias=V105+0 align=32 words (r7.0)
//.declare  (332)  rf=r size=64 type=ud align=32 words (r3.0)
//.declare V314 (333)  rf=r size=4 type=ud alias=V110+0 align=2 words (r7.0)
//.declare V315 (334)  rf=r size=4 type=ud alias=V112+0 align=2 words (r8.0)
//.declare V316 (335)  rf=r size=8 type=uq alias=V123+0 align=4 words (r3.0)
//.declare V317 (336)  rf=r size=8 type=uq alias=V117+0 align=4 words (r102.3)
//.declare V318 (337)  rf=r size=8 type=uq alias=V56+0 align=4 words (r4.3)
//.declare V319 (338)  rf=r size=128 type=q alias=V221+0 align=32 words (r6.0)
//.declare V320 (339)  rf=r size=8 type=uq alias=V124+0 align=4 words (r10.0)
//.declare V321 (340)  rf=r size=8 type=uq alias=V118+0 align=4 words (r102.4)
//.declare V322 (341)  rf=r size=8 type=uq alias=V57+0 align=4 words (r5.1)
//.declare V323 (342)  rf=r size=32 type=q alias=V125+0 align=4 words (r11.0)
//.declare V324 (343)  rf=r size=4 type=d alias=V126+0 align=2 words (r102.10)
//.declare V325 (344)  rf=r size=4 type=d alias=V116+0 align=2 words (r102.5)
//.declare V326 (345)  rf=r size=64 type=ud alias=V128+0 align=32 words (r13.0)
//.declare V327 (346)  rf=r size=64 type=ud alias=V180+0 align=32 words (r8.0)
//.declare V328 (347)  rf=r size=64 type=ud alias=V139+0 align=32 words (r14.0)
//.declare V329 (348)  rf=r size=64 type=ud alias=V121+0 align=32 words (r109.0)
//.declare V330 (349)  rf=r size=64 type=ud alias=V129+0 align=32 words (r111.0)
//.declare V331 (350)  rf=r size=64 type=ud alias=V215+0 align=32 words (r9.0)
//.declare V332 (351)  rf=r size=64 type=ud alias=V144+0 align=32 words (r34.0)
//.declare V333 (352)  rf=r size=64 type=ud alias=V130+0 align=32 words (r15.0)
//.declare V334 (353)  rf=r size=64 type=ud alias=V80+0 align=32 words (r104.0)
//.declare V335 (354)  rf=r size=128 type=q alias=V131+0 align=32 words (r18.0)
//.declare V336 (355)  rf=r size=8 type=q alias=V58+0 align=4 words (r5.3)
//.declare V337 (356)  rf=r size=128 type=uq alias=V131+0 align=32 words (r18.0)
//.declare V338 (357)  rf=r size=64 type=ud alias=V182+0 align=32 words (r32.0)
//.declare V339 (358)  rf=r size=192 type=ud alias=V132+0 align=32 words (r21.0)
//.declare V340 (359)  rf=r size=64 type=ud alias=V137+0 align=32 words (r24.0)
//.declare V341 (360)  rf=r size=32 type=w alias=V133+0 align=1 words (r27.0)
//.declare V342 (361)  rf=r size=64 type=w alias=V121+0 align=32 words (r109.0)
//.declare V343 (362)  rf=r size=32 type=uw alias=V133+0 align=1 words (r27.0)
//.declare V344 (363)  rf=r size=32 type=w alias=V135+0 align=1 words (r30.0)
//.declare V345 (364)  rf=r size=32 type=uw alias=V135+0 align=1 words (r30.0)
//.declare V348 (367)  rf=r size=64 type=ud alias=V138+0 align=32 words (r33.0)
//.declare V349 (368)  rf=r size=64 type=ud alias=V217+0 align=32 words (r42.0)
//.declare V350 (369)  rf=r size=32 type=w alias=V140+0 align=1 words (r37.0)
//.declare V351 (370)  rf=r size=64 type=w alias=V139+0 align=32 words (r14.0)
//.declare V352 (371)  rf=r size=32 type=uw alias=V140+0 align=1 words (r37.0)
//.declare V353 (372)  rf=r size=32 type=w alias=V142+0 align=1 words (r40.0)
//.declare V354 (373)  rf=r size=32 type=uw alias=V142+0 align=1 words (r40.0)
//.declare V357 (376)  rf=r size=64 type=ud alias=V146+0 align=32 words (r44.0)
//.declare V358 (377)  rf=r size=64 type=ud alias=V150+0 align=32 words (r45.0)
//.declare V359 (378)  rf=r size=64 type=ud alias=V111+0 align=32 words (r105.0)
//.declare V360 (379)  rf=r size=64 type=ud alias=V147+0 align=32 words (r46.0)
//.declare V361 (380)  rf=r size=64 type=ud alias=V113+0 align=32 words (r106.0)
//.declare V362 (381)  rf=r size=64 type=ud alias=V148+0 align=32 words (r47.0)
//.declare V363 (382)  rf=r size=128 type=d alias=V149+0 align=32 words (r48.0)
//.declare V364 (383)  rf=r size=512 type=hf alias=V164+0 align=32 words (r50.0)
//.declare V365 (384)  rf=r size=64 type=hf alias=V145+0 align=32 words (r43.0)
//.declare V366 (385)  rf=r size=128 type=hf alias=V149+0 align=32 words (r48.0)
//.declare V367 (386)  rf=r size=64 type=ud alias=V151+0 align=32 words (r58.0)
//.declare V368 (387)  rf=r size=64 type=ud alias=V155+0 align=32 words (r59.0)
//.declare V369 (388)  rf=r size=64 type=ud alias=V152+0 align=32 words (r60.0)
//.declare V370 (389)  rf=r size=64 type=ud alias=V153+0 align=32 words (r61.0)
//.declare V371 (390)  rf=r size=128 type=d alias=V154+0 align=32 words (r62.0)
//.declare V372 (391)  rf=r size=128 type=hf alias=V154+0 align=32 words (r62.0)
//.declare V373 (392)  rf=r size=64 type=ud alias=V159+0 align=32 words (r64.0)
//.declare V374 (393)  rf=r size=64 type=ud alias=V156+0 align=32 words (r66.0)
//.declare V375 (394)  rf=r size=64 type=ud alias=V157+0 align=32 words (r67.0)
//.declare V376 (395)  rf=r size=128 type=d alias=V158+0 align=32 words (r68.0)
//.declare V377 (396)  rf=r size=128 type=hf alias=V158+0 align=32 words (r68.0)
//.declare V379 (398)  rf=r size=64 type=ud alias=V165+0 align=32 words (r70.0)
//.declare V380 (399)  rf=r size=64 type=ud alias=V161+0 align=32 words (r72.0)
//.declare V381 (400)  rf=r size=64 type=ud alias=V162+0 align=32 words (r73.0)
//.declare V382 (401)  rf=r size=128 type=d alias=V163+0 align=32 words (r74.0)
//.declare V383 (402)  rf=r size=128 type=hf alias=V163+0 align=32 words (r74.0)
//.declare V385 (404)  rf=r size=64 type=ud alias=V170+0 align=32 words (r76.0)
//.declare V386 (405)  rf=r size=64 type=ud alias=V167+0 align=32 words (r78.0)
//.declare V387 (406)  rf=r size=64 type=ud alias=V168+0 align=32 words (r79.0)
//.declare V388 (407)  rf=r size=128 type=d alias=V169+0 align=32 words (r80.0)
//.declare V389 (408)  rf=r size=512 type=hf alias=V185+0 align=32 words (r82.0)
//.declare V390 (409)  rf=r size=128 type=hf alias=V169+0 align=32 words (r80.0)
//.declare V392 (411)  rf=r size=64 type=ud alias=V175+0 align=32 words (r90.0)
//.declare V393 (412)  rf=r size=64 type=ud alias=V172+0 align=32 words (r92.0)
//.declare V394 (413)  rf=r size=64 type=ud alias=V173+0 align=32 words (r93.0)
//.declare V395 (414)  rf=r size=128 type=d alias=V174+0 align=32 words (r94.0)
//.declare V396 (415)  rf=r size=128 type=hf alias=V174+0 align=32 words (r94.0)
//.declare V398 (417)  rf=r size=64 type=ud alias=V181+0 align=32 words (r96.0)
//.declare V399 (418)  rf=r size=64 type=ud alias=V177+0 align=32 words (r98.0)
//.declare V400 (419)  rf=r size=64 type=ud alias=V178+0 align=32 words (r99.0)
//.declare V401 (420)  rf=r size=128 type=d alias=V179+0 align=32 words (r100.0)
//.declare V402 (421)  rf=r size=128 type=hf alias=V179+0 align=32 words (r100.0)
//.declare V403 (422)  rf=r size=64 type=ud alias=V183+0 align=32 words (r3.0)
//.declare V404 (423)  rf=r size=128 type=d alias=V184+0 align=32 words (r10.0)
//.declare V405 (424)  rf=r size=128 type=hf alias=V184+0 align=32 words (r10.0)
//.declare V406 (425)  rf=r size=64 type=ud alias=V186+0 align=32 words (r13.0)
//.declare V407 (426)  rf=r size=64 type=ud alias=V190+0 align=32 words (r14.0)
//.declare V408 (427)  rf=r size=64 type=ud alias=V187+0 align=32 words (r16.0)
//.declare V409 (428)  rf=r size=64 type=ud alias=V188+0 align=32 words (r17.0)
//.declare V410 (429)  rf=r size=128 type=d alias=V189+0 align=32 words (r18.0)
//.declare V411 (430)  rf=r size=512 type=hf alias=V202+0 align=32 words (r20.0)
//.declare V412 (431)  rf=r size=128 type=hf alias=V189+0 align=32 words (r18.0)
//.declare V413 (432)  rf=r size=64 type=ud alias=V191+0 align=32 words (r28.0)
//.declare V414 (433)  rf=r size=64 type=ud alias=V194+0 align=32 words (r29.0)
//.declare V415 (434)  rf=r size=64 type=ud alias=V192+0 align=32 words (r30.0)
//.declare V416 (435)  rf=r size=128 type=d alias=V193+0 align=32 words (r31.0)
//.declare V417 (436)  rf=r size=128 type=hf alias=V193+0 align=32 words (r31.0)
//.declare V418 (437)  rf=r size=64 type=ud alias=V195+0 align=32 words (r34.0)
//.declare V419 (438)  rf=r size=64 type=ud alias=V198+0 align=32 words (r36.0)
//.declare V420 (439)  rf=r size=64 type=ud alias=V196+0 align=32 words (r35.0)
//.declare V421 (440)  rf=r size=128 type=d alias=V197+0 align=32 words (r37.0)
//.declare V422 (441)  rf=r size=128 type=hf alias=V197+0 align=32 words (r37.0)
//.declare V423 (442)  rf=r size=64 type=ud alias=V199+0 align=32 words (r40.0)
//.declare V424 (443)  rf=r size=64 type=ud alias=V203+0 align=32 words (r44.0)
//.declare V425 (444)  rf=r size=64 type=ud alias=V200+0 align=32 words (r41.0)
//.declare V426 (445)  rf=r size=128 type=d alias=V201+0 align=32 words (r45.0)
//.declare V427 (446)  rf=r size=128 type=hf alias=V201+0 align=32 words (r45.0)
//.declare V428 (447)  rf=r size=64 type=ud alias=V204+0 align=32 words (r48.0)
//.declare V429 (448)  rf=r size=64 type=ud alias=V207+0 align=32 words (r58.0)
//.declare V430 (449)  rf=r size=64 type=ud alias=V205+0 align=32 words (r49.0)
//.declare V431 (450)  rf=r size=128 type=d alias=V206+0 align=32 words (r59.0)
//.declare V432 (451)  rf=r size=512 type=hf alias=V220+0 align=32 words (r61.0)
//.declare V433 (452)  rf=r size=128 type=hf alias=V206+0 align=32 words (r59.0)
//.declare V434 (453)  rf=r size=64 type=ud alias=V208+0 align=32 words (r70.0)
//.declare V435 (454)  rf=r size=64 type=ud alias=V211+0 align=32 words (r72.0)
//.declare V436 (455)  rf=r size=64 type=ud alias=V209+0 align=32 words (r71.0)
//.declare V437 (456)  rf=r size=128 type=d alias=V210+0 align=32 words (r73.0)
//.declare V438 (457)  rf=r size=128 type=hf alias=V210+0 align=32 words (r73.0)
//.declare V439 (458)  rf=r size=64 type=ud alias=V212+0 align=32 words (r76.0)
//.declare V440 (459)  rf=r size=64 type=ud alias=V216+0 align=32 words (r78.0)
//.declare V441 (460)  rf=r size=64 type=ud alias=V213+0 align=32 words (r77.0)
//.declare V442 (461)  rf=r size=128 type=d alias=V214+0 align=32 words (r79.0)
//.declare V443 (462)  rf=r size=128 type=hf alias=V214+0 align=32 words (r79.0)
//.declare V444 (463)  rf=r size=64 type=ud alias=V218+0 align=32 words (r81.0)
//.declare V445 (464)  rf=r size=128 type=d alias=V219+0 align=32 words (r90.0)
//.declare V446 (465)  rf=r size=128 type=hf alias=V219+0 align=32 words (r90.0)
//.declare V447 (466)  rf=r size=64 type=f alias=V122+0 align=32 words (r110.0)
//.declare V448 (467)  rf=r size=8 type=q alias=V118+0 align=4 words (r102.4)
//.declare V449 (468)  rf=r size=4 type=ud alias=V127+0 align=2 words (r12.0)
//.declare V450 (469)  rf=r size=64 type=w alias=V122+0 align=32 words (r110.0)
//.declare V451 (470)  rf=r size=4 type=d alias=V73+0 align=2 words (r102.3)
//.declare V452 (471)  rf=r size=32 type=hf alias=V222+0 align=1 words (r1.16)
//.declare V453 (472)  rf=r size=32 type=uw alias=V222+0 align=1 words (r1.16)
//.declare V454 (473)  rf=r size=4 type=d alias=V227+0 align=2 words (r1.2)
//.declare V455 (474)  rf=r size=4 type=ud alias=V227+0 align=2 words (r1.2)
//.declare V456 (475)  rf=r size=4 type=ud alias=V36+0 align=2 words (r4.0)
//.declare V457 (476)  rf=r size=4 type=d alias=V229+0 align=2 words (r6.0)
//.declare V458 (477)  rf=r size=4 type=d alias=V41+0 align=2 words (r4.5)
//.declare V459 (478)  rf=r size=4 type=ud alias=V229+0 align=2 words (r6.0)
//.declare V461 (480)  rf=r size=128 type=q alias=V233+0 align=32 words (r9.0)
//.declare V462 (481)  rf=r size=8 type=q alias=V232+0 align=4 words (r4.5)
//.declare V463 (482)  rf=r size=4 type=ud alias=V226+0 align=2 words (r102.12)
//.declare V464 (483)  rf=r size=64 type=ud alias=V76+0 align=32 words (r103.0)
//.declare V465 (484)  rf=r size=128 type=uq alias=V233+0 align=32 words (r9.0)
//.declare  (485)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (486)  rf=r size=16 type=w align=16 words (r11.0)
//.declare  (487)  rf=r size=128 type=ud align=32 words (r13.0)
//.declare  (488)  rf=r size=16 type=w align=16 words (r22.0)
//.declare  (490)  rf=r size=64 type=uw align=32 words (r6.0)
//.declare  (491)  rf=r size=32 type=uw align=32 words (r7.0)
//.declare  (492)  rf=r size=64 type=uw align=32 words (r9.0)
//.declare  (493)  rf=r size=32 type=uw align=32 words (r10.0)
//.declare  (494)  rf=r size=64 type=uw align=32 words (r12.0)
//.declare  (495)  rf=r size=32 type=uw align=32 words (r13.0)
//.declare  (496)  rf=r size=64 type=uw align=32 words (r15.0)
//.declare  (497)  rf=r size=32 type=uw align=32 words (r16.0)
//.declare  (498)  rf=r size=64 type=w align=32 words (r26.0)
//.declare  (499)  rf=r size=32 type=w align=32 words (r27.0)
//.declare  (500)  rf=r size=64 type=w align=32 words (r31.0)
//.declare  (501)  rf=r size=32 type=w align=32 words (r32.0)
//.declare  (502)  rf=r size=128 type=ud align=32 words (r16.0)
//.declare  (503)  rf=r size=64 type=w align=32 words (r25.0)
//.declare  (504)  rf=r size=32 type=w align=32 words (r26.0)
//.declare  (505)  rf=r size=64 type=w align=32 words (r28.0)
//.declare  (506)  rf=r size=32 type=w align=32 words (r29.0)
//.declare  (507)  rf=r size=64 type=w align=32 words (r35.0)
//.declare  (508)  rf=r size=32 type=w align=32 words (r36.0)
//.declare  (509)  rf=r size=64 type=w align=32 words (r38.0)
//.declare  (510)  rf=r size=32 type=w align=32 words (r39.0)
//.declare  (511)  rf=r size=128 type=ud align=32 words (r7.0)
//.declare r0 (512)  rf=r size=64 type=ud align=32 words (r0.0)
//.declare rtmp (513)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (514)  rf=r size=64 type=ud align=32 words (r1.0)
//.declare  (515)  rf=r size=256 type=ud align=32 words (r2.0)

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
// | V68      | :uq      |    0x8 | r4+0x20  | cti+0xA0         |
// | V232     | :uq      |    0x8 | r4+0x28  | cti+0xA8         |
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
// | V57      | :uq      |    0x8 | r5+0x8   | cti+0xC8         |
// | V52      | :d       |    0x4 | r5+0x10  | cti+0xD0         |
// | V58      | :uq      |    0x8 | r5+0x18  | cti+0xD8         |
// | V78      | :uq      |    0x8 | r5+0x20  | cti+0xE0         |
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
// B002: Preds:{B001},  Succs:{B003, B005}
// _ZTS22int1_fp16_upcvt_kernelILi1ELi512ELi1ELi16ELi64ELi1ELi1ELb1EE_BB_0:
(W)     mov (16|M0)              r97.0<1>:ud   r0.0<1;1,0>:ud                                        //  ALU pipe: int; $1
        and (1|M0)               cr0.0<1>:ud   cr0.0<0;1,0>:ud   -1073743089:d               {A@1}   // $1
        or (1|M0)                cr0.0<1>:ud   cr0.0<0;1,0>:ud   1073743040:d               {A@1}    // $2
        sync.nop                             null                             {Compacted,A@1}        // $4
        sync.nop                             null                             {Compacted,$1.dst}     // $4
        mul (2|M0)               r1.2<1>:d     r2.0<1;1,0>:d     r1.2<0;1,0>:uw   {A@1,$0.dst}       //  ALU pipe: int; $4
        mov (8|M0)               r11.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $35
        add (2|M0)               r2.3<1>:d     r1.2<1;1,0>:d     r1.0<1;1,0>:uw   {I@2}              //  ALU pipe: int; $5
        shl (1|M0)               r5.0<1>:d     r0.1<0;1,0>:d     9:w               {Compacted}       //  ALU pipe: int; $11
(W)     mul (1|M0)               acc0.0<1>:d   r2.4<0;1,0>:d     r2.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $6
        macl (1|M0)              r3.0<1>:d     r2.4<0;1,0>:d     r2.0<0;1,0>:d    {Compacted}        //  ALU pipe: int; $7
        mov (8|M0)               r113.0<1>:d   r11.0<1;1,0>:w                                        //  ALU pipe: int; $35
        add (1|M0)               r4.12<1>:d    r3.0<0;1,0>:d     r1.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $7
        add (8|M0)               r113.8<1>:d   r113.0<1;1,0>:d   8:w               {I@2}             //  ALU pipe: int; $36
        and (1|M0)               r102.0<1>:d   r4.12<0;1,0>:d    31:w               {Compacted,I@2}  //  ALU pipe: int; $8
        add (1|M0)               r102.11<1>:d  r5.0<0;1,0>:d     512:w                               //  ALU pipe: int; $12
        shl (1|M0)               r102.2<1>:d   r102.0<0;1,0>:d   4:w               {Compacted,I@2}   //  ALU pipe: int; $15
        sel (1|M0)    (lt)f0.0   r102.11<1>:ud  r102.11<0;1,0>:ud  r4.2<0;1,0>:ud {I@2}              //  ALU pipe: int; $13
        or (1|M0)                r9.0<1>:d     r5.0<0;1,0>:d     r102.2<0;1,0>:d  {Compacted,I@2}    //  ALU pipe: int; $23
        mov (1|M0)               r102.12<1>:d  r0.6<0;1,0>:ud                                        //  ALU pipe: int; $10
        or (16|M0)               r103.0<1>:d   r9.0<0;1,0>:d     r113.0<1;1,0>:d  {Compacted,I@2}    //  ALU pipe: int; $37
        shl (16|M0)              r12.0<1>:d    r103.0<1;1,0>:d   2:w               {Compacted,I@1}   //  ALU pipe: int; $38
        mov (16|M0)              r13.0<2>:ud   r12.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $39
        add (16|M0)              r15.0<1>:q    r5.4<0;1,0>:q     r13.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $39
        load.ugm.d32.a64.ca.ca (16|M0)  r104:1  [r15:2]            {I@1,$2} // ex_desc:0x0; desc:0x4180580 // $40
        shr (1|M0)               r7.0<1>:ud    r4.1<0;1,0>:ud    0x5:uw              {Compacted}     //  ALU pipe: int; $19
        shl (1|M0)               r8.0<1>:d     r4.4<0;1,0>:d     2:w               {Compacted}       //  ALU pipe: int; $21
        shl (1|M0)               r10.0<1>:d    r4.3<0;1,0>:d     1:w               {Compacted}       //  ALU pipe: int; $26
        shl (1|M0)               r6.0<1>:ud    r102.11<0;1,0>:ud  0x2:uw             {Compacted}     //  ALU pipe: int; $17
        cmp (1|M0)    (lt)f2.0   null<1>:ud    r102.0<0;1,0>:ud  0x10:uw                             //  ALU pipe: int; $41
        mov (1|M0)               r107.0<1>:q   r4.4<0;1,0>:q                                         //  ALU pipe: int; $16
        mov (1|M0)               r107.6<1>:d   0:w                                                   //  ALU pipe: int; $25
        or (1|M0)                r107.5<1>:d   r5.0<0;1,0>:d     r102.2<0;1,0>:d                     //  ALU pipe: int; $24
        add (1|M0)               r107.3<1>:ud  r7.0<0;1,0>:ud    0xFFFFFFFF:ud              {I@7}    //  ALU pipe: int; $20
        add (1|M0)               r107.4<1>:d   r8.0<0;1,0>:d     -1:w               {I@7}            //  ALU pipe: int; $22
(W)     mul (1|M0)               acc0.0<1>:d   r10.0<0;1,0>:d    r102.24<0;1,0>:uw {I@7}             //  ALU pipe: int; $27
        add (1|M0)               r107.2<1>:ud  r6.0<0;1,0>:ud    0xFFFFFFFF:ud              {I@7}    //  ALU pipe: int; $18
        add (1|M0)               r102.1<1>:d   r4.1<0;1,0>:d     63:w                                //  ALU pipe: int; $14
        mov (1|M0)               r102.7<1>:q   r9.0<0;1,0>:ud                                        //  ALU pipe: int; $33
        macl (1|M0)              r10.0<1>:d    r10.0<0;1,0>:d    r102.12<0;1,0>:d                    //  ALU pipe: int; $28
        mov (16|M0)              r108.0<1>:f   r107.0<1;1,0>:f                  {I@4}                //  ALU pipe: float; $28
        shl (1|M0)               r102.4<1>:d   r5.4<0;1,0>:d     1:w                                 //  ALU pipe: int; $32
        shr (1|M0)               r102.3<1>:ud  r102.1<0;1,0>:ud  0x6:uw              {I@4}           //  ALU pipe: int; $30
        shl (1|M0)               r102.7<1>:q   r102.7<0;1,0>:q   1:w               {I@4}             //  ALU pipe: int; $34
        mov (1|M0)               r102.3<1>:q   r10.0<0;1,0>:ud                  {I@4}                //  ALU pipe: int; $31
        add (1|M0)               r108.6<1>:d   r107.6<0;1,0>:d   1:w               {F@1}             //  ALU pipe: int; $29
(W&~f2.0) jmpi                               BB_1                                                    //  ALU pipe: int; $42
// B003: Preds:{B002},  Succs:{B004, B005}
_L_k27_0_:
        or (16|M0)               r3.0<1>:d     r102.2<0;1,0>:d   r113.0<1;1,0>:d                     //  ALU pipe: int; $43
        shr (16|M0)              r6.0<2>:uw    r3.0<2;1,0>:uw    0x4:uw              {I@1}           //  ALU pipe: int; $44
        shr (16|M0)              r9.0<2>:uw    r3.0<2;1,0>:uw    0x5:uw                              //  ALU pipe: int; $46
        shr (16|M0)              r12.0<2>:uw   r3.0<2;1,0>:uw    0x6:uw                              //  ALU pipe: int; $48
        mov (16|M0)              r7.0<1>:uw    r6.0<2;1,0>:uw                   {I@3}                //  ALU pipe: int; $44
        mov (16|M0)              r10.0<1>:uw   r9.0<2;1,0>:uw                   {I@3}                //  ALU pipe: int; $46
        mov (16|M0)              r13.0<1>:uw   r12.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $48
        mov (16|M0)              r8.0<1>:hf    r7.0<1;1,0>:hf                   {I@3}                //  ALU pipe: float; $44
        mov (16|M0)              r11.0<1>:hf   r10.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $46
        mov (16|M0)              r14.0<1>:hf   r13.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $48
        and (16|M0)              r8.0<1>:uw    r8.0<1;1,0>:uw    0x1:uw              {F@3}           //  ALU pipe: int; $45
        and (16|M0)              r11.0<1>:uw   r11.0<1;1,0>:uw   0x1:uw              {F@2}           //  ALU pipe: int; $47
        and (16|M0)              r14.0<1>:uw   r14.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $49
        add (16|M0)              r18.0<1>:d    r8.0<1;1,0>:uw    r11.0<1;1,0>:uw  {I@2}              //  ALU pipe: int; $52
        add (16|M0)              r19.0<1>:d    r18.0<1;1,0>:d    r14.0<1;1,0>:uw  {I@1}              //  ALU pipe: int; $53
        mov (8|M0)               r25.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $59
        mov (8|M0)               r25.8<1>:w    0xFEDCBA98:uv                                         //  ALU pipe: int; $60
        shr (16|M0)              r15.0<2>:uw   r3.0<2;1,0>:uw    0x7:uw              {$2.src}        //  ALU pipe: int; $50
        shr (16|M0)              r19.0<1>:ud   r113.0<1;1,0>:ud  r19.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $71
        mov (8|M0)               r22.0<1>:w    0x10101010:v                                          //  ALU pipe: int; $55
        shr (16|M0)              r18.0<1>:ud   r113.0<1;1,0>:ud  r18.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $66
        shr (16|M0)              r25.0<1>:uw   r25.0<1;1,0>:uw   r8.0<1;1,0>:uw   {I@5}              //  ALU pipe: int; $61
        mov (16|M0)              r16.0<1>:uw   r15.0<2;1,0>:uw                  {I@5}                //  ALU pipe: int; $50
        shl (16|M0)              r31.0<2>:w    r19.0<2;1,0>:w    15:w               {I@5}            //  ALU pipe: int; $72
        mov (8|M0)               r24.0<1>:d    r22.0<1;1,0>:w                   {I@5}                //  ALU pipe: int; $55
        mov (8|M0)               r24.8<1>:d    r22.0<1;1,0>:w                                        //  ALU pipe: int; $56
        shl (16|M0)              r26.0<2>:w    r18.0<2;1,0>:w    15:w               {I@6}            //  ALU pipe: int; $67
        shl (16|M0)              r25.0<1>:uw   r25.0<1;1,0>:uw   0xF:uw              {I@6}           //  ALU pipe: int; $62
        mov (16|M0)              r17.0<1>:hf   r16.0<1;1,0>:hf                  {I@6}                //  ALU pipe: float; $50
        mov (16|M0)              r32.0<1>:w    r31.0<2;1,0>:w                   {I@5}                //  ALU pipe: int; $72
        mul (16|M0)              acc0.0<1>:d   r24.0<1;1,0>:d    0x8000:uw              {I@4}        //  ALU pipe: int; $57
        mov (16|M0)              r27.0<1>:w    r26.0<2;1,0>:w                   {I@4}                //  ALU pipe: int; $67
        or (16|M0)               r25.0<1>:uw   r25.0<1;1,0>:uw   0x3C00:uw              {I@4}        //  ALU pipe: int; $63
        and (16|M0)              r17.0<1>:uw   r17.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $51
        mov (16|M0)              r33.0<1>:hf   r32.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $72
        add (16|M0)              r24.0<1>:d    acc0.0<1;1,0>:d   15360:w                             //  ALU pipe: int; $58
        mov (16|M0)              acc0.0<1>:d   -r11.0<1;1,0>:uw                                      //  ALU pipe: int; $64
        mov (16|M0)              r28.0<1>:hf   r27.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $67
        or (16|M0)               r33.0<1>:w    r33.0<1;1,0>:w    15360:w               {F@2}         //  ALU pipe: int; $73
        and (16|M0)              acc0.0<1>:d   r25.0<1;1,0>:uw   acc0.0<1;1,0>:d  {I@5}              //  ALU pipe: int; $65
        mov (16|M0)              acc2.0<1>:d   -r17.0<1;1,0>:uw                 {I@5}                //  ALU pipe: int; $74
        or (16|M0)               r28.0<1>:w    r28.0<1;1,0>:w    15360:w               {F@1}         //  ALU pipe: int; $68
        and (16|M0)              acc2.0<1>:d   r33.0<1;1,0>:uw   acc2.0<1;1,0>:d  {I@4}              //  ALU pipe: int; $75
        shl (16|M0)              r34.0<1>:d    r3.0<1;1,0>:d     3:w                                 //  ALU pipe: int; $76
        mov (16|M0)              r21.0<1>:d    -r8.0<1;1,0>:uw                                       //  ALU pipe: int; $54
        mov (16|M0)              r30.0<1>:d    -r14.0<1;1,0>:uw                                      //  ALU pipe: int; $70
        mov (16|M0)              r29.0<1>:d    r28.0<1;1,0>:uw                  {I@5}                //  ALU pipe: int; $69
        shl (16|M0)              r35.0<1>:d    acc0.0<1;1,0>:d   16:w                                //  ALU pipe: int; $77
        shl (16|M0)              r37.0<1>:d    acc2.0<1;1,0>:d   16:w                                //  ALU pipe: int; $79
        cmp (1|M0)    (eq)f1.1   null<1>:d     r102.0<0;1,0>:d   0:w                                 //  ALU pipe: int; $84
        or (16|M0)               r39.0<1>:ud   r34.0<1;1,0>:ud   0x4:uw              {I@7}           //  ALU pipe: int; $82
        bfn.(s0|s1&s2) (16|M0)   r36.0<1>:ud   r35.0<1;0>:ud     r21.0<1;0>:ud     r24.0<1>:ud      {I@4} //  ALU pipe: int; $78
        bfn.(s0|s1&s2) (16|M0)   r38.0<1>:ud   r37.0<1;0>:ud     r29.0<1;0>:ud     r30.0<1>:ud      {I@4} //  ALU pipe: int; $80
        store.slm.d32.a32 (16|M0)  [r34:1]      r36:1              {I@2,$3} // ex_desc:0x0; desc:0x2000504 // $81
        store.slm.d32.a32 (16|M0)  [r39:1]      r38:1              {I@1,$4} // ex_desc:0x0; desc:0x2000504 // $83
(W&~f1.1) jmpi                               BB_1                                                    //  ALU pipe: int; $85
// B004: Preds:{B003},  Succs:{B005}
_L_k27_1_:
        mul (16|M0)              acc0.0<1>:ud  r113.0<1;1,0>:ud  0x4:uw                              //  ALU pipe: int; $86
        mov (16|M0)              r6.0<1>:d     1920:w                               {Compacted}      //  ALU pipe: int; $89
        mov (16|M0)              r8.0<1>:d     120:w                               {Compacted}       //  ALU pipe: int; $93
        add (16|M0)              r3.0<1>:ud    acc0.0<1;1,0>:ud  0x800:uw                            //  ALU pipe: int; $87
        add (16|M0)              r7.0<1>:ud    acc0.0<1;1,0>:ud  0x840:uw                            //  ALU pipe: int; $91
        store.slm.d32.a32 (16|M0)  [r3:1]       r6:1               {I@2,$5} // ex_desc:0x0; desc:0x2000504 // $90
        store.slm.d32.a32 (16|M0)  [r7:1]       r8:1               {I@1,$6} // ex_desc:0x0; desc:0x2000504 // $94
// B005: Preds:{B004, B003, B002},  Succs:{B006, B010}
BB_1:
        sync.nop                             null                             {$5.src}               // $96
(W)     send.slm (1|M0)          r3       r97  null:0  0x0            0x0210001F           {$7} // wr:1+0, rd:1; fence.slm.none.group // $96
        mov (16|M0)              r6.0<1>:f     0x20200000:f                               {Compacted} //  (0x20200000:f); ALU pipe: float; $98
(W)     mov (8|M0)               null<1>:ud    r3.0<1;1,0>:ud                   {Compacted,$7.dst}   //  memory fence commit; ALU pipe: int; $99
        send.gtwy (1|M0)         null     r6  null:0  0x0            0x02000004           {F@1,$8} // wr:1+0, rd:0; signal barrier // $99
(W)     sync.bar                             0:w                                                     // $100
        mov (1|M0)               r7.0<1>:d     2048:w                               {$6.src}         //  ALU pipe: int; $101
        mov (1|M0)               r8.0<1>:d     2112:w                                                //  ALU pipe: int; $103
        load.slm.d32x16t.a32 (1|M0)  r105:1     [r7:1]             {I@2,$9} // ex_desc:0x0; desc:0x210D500 // $102
        load.slm.d32x16t.a32 (1|M0)  r106:1     [r8:1]             {I@1,$10} // ex_desc:0x0; desc:0x210D500 // $104
        cmp (1|M0)    (lt)f1.0   null<1>:ud    r102.1<0;1,0>:ud  0x40:uw                             //  ALU pipe: int; $106
(W&f1.0) jmpi                                BB_2                                                    //  ALU pipe: int; $107
// B006: Preds:{B005},  Succs:{B007}
_L_k27_2_:
        mov (16|M0)              r109.0<1>:d   0:w                               {Compacted}         //  ALU pipe: int; $110
        mov (16|M0)              r110.0<1>:f   0.0:f                               {Compacted}       //  ALU pipe: float; $112
        sel (1|M0)    (ge)f0.0   r102.3<1>:ud  r102.3<0;1,0>:ud  0x1:uw                              //  ALU pipe: int; $108
        mov (1|M0)               r102.5<1>:d   0:w                                                   //  ALU pipe: int; $113
        mov (1|M0)               r102.4<1>:q   r102.7<0;1,0>:q                                       //  ALU pipe: int; $114
// B007: Preds:{B009, B006},  Succs:{B008, B009}
BB_3:
        shr (1|M0)               r3.0<1>:uq    r102.3<0;1,0>:uq  0x3:uw                              //  ALU pipe: int; $116
        mov (1|M0)               r107.7<1>:d   15:w                                                  //  ALU pipe: int; $121
        shl (1|M0)               r3.0<1>:uq    r3.0<0;1,0>:uq    0x3:uw              {I@2}           //  ALU pipe: int; $117
        mov (1|M0)               r108.7<1>:d   15:w                                                  //  ALU pipe: int; $124
        add (1|M0)               r3.0<1>:uq    r4.3<0;1,0>:uq    r3.0<0;1,0>:uq   {I@2}              //  ALU pipe: int; $118
        shr (1|M0)               r10.0<1>:uq   r102.4<0;1,0>:uq  0x3:uw                              //  ALU pipe: int; $127
        sync.allrd                           ($8,$9)                                                 // $120
        load.ugm.d64x16t.a64.ca.ca (1|M0)  r6:2 [r3:1]             {I@2,$11} // ex_desc:0x0; desc:0x228D780 // $120
        sync.nop                             null                             {$10.src}              // $123
        load_block2d.ugm.d32.a64.ca.ca (1|M0)  r8:1 [r107:1]       {$12} // ex_desc:0x0; desc:0x2180403 // $123
        shl (1|M0)               r10.0<1>:uq   r10.0<0;1,0>:uq   0x3:uw              {I@1}           //  ALU pipe: int; $128
        add (1|M0)               r10.0<1>:uq   r5.1<0;1,0>:uq    r10.0<0;1,0>:uq  {I@1}              //  ALU pipe: int; $129
        load_block2d.ugm.d32.a64.ca.ca (1|M0)  r9:1 [r108:1]       {$13} // ex_desc:0x0; desc:0x2180403 // $126
        load.ugm.d64x4t.a64.ca.ca (1|M0)  r11:1 [r10:1]            {I@1,$14} // ex_desc:0x0; desc:0x218B780 // $131
        add (1|M0)               r102.10<1>:d  r102.5<0;1,0>:d   1:w                                 //  ALU pipe: int; $136
        and (1|M0)    (eq)f0.1   r102.5<1>:d   r102.5<0;1,0>:d   1:w                                 //  ALU pipe: int; $137
        add (1|M0)               r107.6<1>:d   r107.6<0;1,0>:d   2:w               {$12.src}         //  ALU pipe: int; $134
        add (1|M0)               r108.6<1>:d   r108.6<0;1,0>:d   2:w               {$13.src}         //  ALU pipe: int; $135
(~f0.1) sel (1|M0)               r12.0<1>:d    r102.4<0;1,0>:d   0:w                                 //  ALU pipe: int; $139
        shr (16|M0)              acc2.0<1>:ud  r109.0<1;1,0>:ud  0x5:uw                              //  ALU pipe: int; $147
        add (16|M0)              acc0.0<1>:ud  acc2.0<1;1,0>:ud  r104.0<1;1,0>:ud {$2.dst}           //  ALU pipe: int; $148
        shl (16|M0)              r15.0<1>:ud   acc0.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $149
        mov (16|M0)              r16.0<2>:ud   r15.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $150
        add (16|M0)              r18.0<1>:q    r5.3<0;1,0>:q     r16.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $150
        load.ugm.d32x3.a64.ca.ca (16|M0)  r21:3 [r18:2]            {I@1,$15} // ex_desc:0x0; desc:0x4382580 // $152
        cbit (16|M0)             r14.0<1>:ud   r8.0<1;1,0>:ud                   {Compacted,$12.dst}  //  ALU pipe: int; $142
        and (16|M0)   (eq)f3.1   r25.0<2>:w    r109.0<2;1,0>:w   31:w                                //  ALU pipe: int; $155
        mov (16|M0)              r28.0<2>:w    -r109.0<2;1,0>:w                                      //  ALU pipe: int; $157
        add (16|M0)              r14.0<1>:ud   r14.0<1;1,0>:ud   r109.0<1;1,0>:ud {I@3}              //  ALU pipe: int; $143
        mov (16|M0)              r29.0<1>:w    r28.0<2;1,0>:w                   {I@2}                //  ALU pipe: int; $157
        mov (16|M0)              r26.0<1>:w    r25.0<2;1,0>:w                                        //  ALU pipe: int; $155
        and (16|M0)   (eq)f3.0   r35.0<2>:w    r14.0<2;1,0>:w    31:w               {I@3}            //  ALU pipe: int; $168
        mov (16|M0)              r38.0<2>:w    -r14.0<2;1,0>:w                  {$4.src}             //  ALU pipe: int; $170
        mov (16|M0)              r30.0<1>:hf   r29.0<1;1,0>:hf                  {I@4}                //  ALU pipe: float; $157
        shl (16|M0)              r44.0<1>:ud   r8.0<1;1,0>:ud    0x7:uw              {Compacted}     //  ALU pipe: int; $180
        shr (16|M0)              r33.0<1>:ud   r14.0<1;1,0>:ud   0x5:uw              {Compacted}     //  ALU pipe: int; $164
        bfn.(s0&~s2|s1&s2) (16|M0)   acc0.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud    0x0:uw              {$15.dst} //  ALU pipe: int; $153
        bfn.(s0&~s2|s1&s2) (16|M0)   r24.0<1>:ud  r22.0<1;0>:ud  r23.0<1;0>:ud     0x0:uw              //  ALU pipe: int; $154
        mov (16|M0)              r27.0<1>:hf   r26.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $155
        mov (16|M0)              r39.0<1>:w    r38.0<2;1,0>:w                   {I@5}                //  ALU pipe: int; $170
        and (16|M0)              r30.0<1>:w    r30.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $158
        shl (16|M0)              r58.0<1>:ud   r8.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $191
        shr (16|M0)              r13.0<1>:ud   r8.0<1;1,0>:ud    0x1:uw              {Compacted}     //  ALU pipe: int; $141
        mov (16|M0)              r36.0<1>:w    r35.0<2;1,0>:w                   {$3.src}             //  ALU pipe: int; $168
        and (16|M0)              r45.0<1>:ud   r44.0<1;1,0>:ud   r105.0<1;1,0>:ud {@7,$9.dst}        //  ALU pipe: int; $181
        add (16|M0)              r34.0<1>:ud   acc2.0<1;1,0>:ud  -r33.0<1;1,0>:ud {I@7}              //  ALU pipe: int; $165
        shr (16|M0)              r32.0<1>:ud   acc0.0<1;1,0>:ud  r27.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $160
        mov (16|M0)              r40.0<1>:hf   r39.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $170
        shl (16|M0)              r24.0<1>:ud   r24.0<1;1,0>:ud   r30.0<1;1,0>:uw  {I@7}              //  ALU pipe: int; $161
        and (16|M0)              r59.0<1>:ud   r58.0<1;1,0>:ud   r105.0<1;1,0>:ud {Compacted,I@7}    //  ALU pipe: int; $192
        and (16|M0)              r64.0<1>:ud   r13.0<1;1,0>:ud   r105.0<1;1,0>:ud {Compacted,I@7}    //  ALU pipe: int; $202
        mov (16|M0)              r37.0<1>:hf   r36.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $168
        cbit (16|M0)             r45.0<1>:ud   r45.0<1;1,0>:ud                  {I@6}                //  ALU pipe: int; $189
        bfn.(s0&~s2|s1&s2) (16|M0)   acc0.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud    r34.0<1>:ud      {I@6} //  ALU pipe: int; $166
        and (16|M0)              r40.0<1>:w    r40.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $171
(~f3.1) or (16|M0)               r32.0<1>:ud   r24.0<1;1,0>:ud   r32.0<1;1,0>:ud  {I@6}              //  ALU pipe: int; $163
        bfn.(s0&~s2|s1&s2) (16|M0)   acc2.0<1>:ud  r22.0<1;0>:ud  r23.0<1;0>:ud    r34.0<1>:ud       //  ALU pipe: int; $167
        cbit (16|M0)             r59.0<1>:ud   r59.0<1;1,0>:ud                  {Compacted,I@7}      //  ALU pipe: int; $200
        cbit (16|M0)             r64.0<1>:ud   r64.0<1;1,0>:ud                  {Compacted,I@7}      //  ALU pipe: int; $210
        shr (16|M0)              r42.0<1>:ud   acc0.0<1;1,0>:ud  r37.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $173
        shl (16|M0)              r34.0<1>:ud   acc2.0<1;1,0>:ud  r40.0<1;1,0>:uw  {I@6}              //  ALU pipe: int; $174
        shr (16|M0)              acc0.0<1>:ud  r32.0<1;1,0>:ud   r45.0<1;1,0>:ud  {I@6}              //  ALU pipe: int; $190
        shl (16|M0)              r60.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $193
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r59.0<1;1,0>:ud  {I@6}              //  ALU pipe: int; $201
        shl (16|M0)              r66.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $203
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r64.0<1;1,0>:ud  {I@7}              //  ALU pipe: int; $211
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $212
        and (16|M0)              r70.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $213
        shl (16|M0)              r72.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $214
        cbit (16|M0)             r70.0<1>:ud   r70.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $221
        and (16|M0)              r72.0<1>:ud   r72.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,@2,$10.dst} //  ALU pipe: int; $215
        bfn.(s0&s1|s2) (16|M0)   r73.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r72.0<1>:ud      {I@1} //  ALU pipe: int; $216
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r70.0<1;1,0>:ud                     //  ALU pipe: int; $222
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $223
        and (16|M0)              r76.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $224
        shl (16|M0)              r78.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $225
        cbit (16|M0)             r76.0<1>:ud   r76.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $232
        and (16|M0)              r78.0<1>:ud   r78.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $226
        bfn.(s0&s1|s2) (16|M0)   r79.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r78.0<1>:ud      {I@1} //  ALU pipe: int; $227
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r76.0<1;1,0>:ud                     //  ALU pipe: int; $233
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $234
        and (16|M0)              r90.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $235
        shl (16|M0)              r92.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $236
        and (16|M0)              r66.0<1>:ud   r66.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $204
        cbit (16|M0)             r90.0<1>:ud   r90.0<1;1,0>:ud                  {Compacted,I@3}      //  ALU pipe: int; $243
        and (16|M0)              r92.0<1>:ud   r92.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $237
        cbit (16|M0)             r111.0<1>:ud  r9.0<1;1,0>:ud                   {Compacted,$13.dst}  //  ALU pipe: int; $144
        bfn.(s0&s1|s2) (16|M0)   r67.0<1>:ud   r13.0<1;0>:ud     r105.0<1;0>:ud    r66.0<1>:ud      {I@4} //  ALU pipe: int; $205
        bfn.(s0&s1|s2) (16|M0)   r93.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r92.0<1>:ud      {I@3} //  ALU pipe: int; $238
        shl (16|M0)              r13.0<1>:ud   r9.0<1;1,0>:ud    0x7:uw                              //  ALU pipe: int; $264
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r90.0<1;1,0>:ud                     //  ALU pipe: int; $244
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $245
        and (16|M0)              r96.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $246
        shl (16|M0)              r98.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $247
        add (16|M0)              r111.0<1>:ud  r111.0<1;1,0>:ud  r14.0<1;1,0>:ud  {Compacted,I@7}    //  ALU pipe: int; $145
        and (16|M0)              r14.0<1>:ud   r13.0<1;1,0>:ud   r105.0<1;1,0>:ud {Compacted,I@6}    //  ALU pipe: int; $265
        cbit (16|M0)             r96.0<1>:ud   r96.0<1;1,0>:ud                  {Compacted,I@4}      //  ALU pipe: int; $255
        and (16|M0)              r98.0<1>:ud   r98.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@4}    //  ALU pipe: int; $248
(~f3.0) or (16|M0)               r42.0<1>:ud   r34.0<1;1,0>:ud   r42.0<1;1,0>:ud                     //  ALU pipe: int; $176
        cbit (16|M0)             r14.0<1>:ud   r14.0<1;1,0>:ud                  {I@4}                //  ALU pipe: int; $273
        bfn.(s0&s1|s2) (16|M0)   r99.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r98.0<1>:ud      {I@3} //  ALU pipe: int; $249
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r96.0<1;1,0>:ud                     //  ALU pipe: int; $256
        shl (16|M0)              r46.0<1>:ud   r32.0<1;1,0>:ud   0x3:uw                              //  ALU pipe: int; $182
        shl (16|M0)              r32.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $257
        shr (16|M0)              acc0.0<1>:ud  r42.0<1;1,0>:ud   r14.0<1;1,0>:ud  {I@5}              //  ALU pipe: int; $274
        shl (16|M0)              r28.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $275
        shl (16|M0)              r29.0<1>:ud   r9.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $277
        and (16|M0)              r28.0<1>:ud   r28.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $276
        bfn.(s0&s1|s2) (16|M0)   r30.0<1>:ud   r29.0<1;0>:ud     r105.0<1;0>:ud    r28.0<1>:ud      {I@1} //  ALU pipe: int; $278
        and (16|M0)              r29.0<1>:ud   r29.0<1;1,0>:ud   r105.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $279
        cbit (16|M0)             r29.0<1>:ud   r29.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $284
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r29.0<1;1,0>:ud  {I@1}              //  ALU pipe: int; $285
        shl (16|M0)              r34.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $286
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x1:uw                              //  ALU pipe: int; $288
        and (16|M0)              r46.0<1>:ud   r46.0<1;1,0>:ud   r106.0<1;1,0>:ud                    //  ALU pipe: int; $183
        and (16|M0)              r36.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $290
        and (16|M0)              r34.0<1>:ud   r34.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@4}    //  ALU pipe: int; $287
        bfn.(s0&s1|s2) (16|M0)   r47.0<1>:ud   r44.0<1;0>:ud     r105.0<1;0>:ud    r46.0<1>:ud      {I@3} //  ALU pipe: int; $184
        cbit (16|M0)             r36.0<1>:ud   r36.0<1;1,0>:ud                  {Compacted,I@3}      //  ALU pipe: int; $295
        load.slm.d32x2.a32 (16|M0)  r48:2       [r47:1]            {I@2,$0} // ex_desc:0x0; desc:0x2201500 // $186
        bfn.(s0&s1|s2) (16|M0)   r35.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r34.0<1>:ud       //  ALU pipe: int; $289
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r36.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $296
        shl (16|M0)              r40.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $297
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $299
        and (16|M0)              r44.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $301
        and (16|M0)              r40.0<1>:ud   r40.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $298
        cbit (16|M0)             r44.0<1>:ud   r44.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $306
        mov (16|M0)              r43.0<2>:uw   r11.0<1;1,0>:uw                  {$14.dst}            //  ALU pipe: int; $178
        mov (16|M0)              r43.1<2>:uw   r11.0<1;1,0>:uw                                       //  ALU pipe: int; $179
        and (16|M0)              r60.0<1>:ud   r60.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $194
        bfn.(s0&s1|s2) (16|M0)   r41.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r40.0<1>:ud      {I@5} //  ALU pipe: int; $300
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r44.0<1;1,0>:ud  {I@5}              //  ALU pipe: int; $307
        sync.nop                             null                             {Compacted,I@4}        // $187
        mul (32|M0)              r50.0<1>:hf   r43.0<1;1,0>:hf   r48.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $187
        shl (16|M0)              r48.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw              {F@1}           //  ALU pipe: int; $308
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $310
        bfn.(s0&s1|s2) (16|M0)   r61.0<1>:ud   r58.0<1;0>:ud     r105.0<1;0>:ud    r60.0<1>:ud      {I@5} //  ALU pipe: int; $195
        and (16|M0)              r58.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $312
        and (16|M0)              r48.0<1>:ud   r48.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@4}    //  ALU pipe: int; $309
        cbit (16|M0)             r58.0<1>:ud   r58.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $317
        mul (32|M0)              r51.0<1>:hf   r43.0<1;1,0>:hf   r49.0<1;1,0>:hf                     //  ALU pipe: float; $188
        bfn.(s0&s1|s2) (16|M0)   r49.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r48.0<1>:ud      {A@1} //  ALU pipe: int; $311
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r58.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $318
        shl (16|M0)              r70.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $319
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $321
        and (16|M0)              r72.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $323
        and (16|M0)              r70.0<1>:ud   r70.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $320
        cbit (16|M0)             r72.0<1>:ud   r72.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $328
        bfn.(s0&s1|s2) (16|M0)   r71.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r70.0<1>:ud      {I@2} //  ALU pipe: int; $322
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r72.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $329
        shl (16|M0)              r76.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $330
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $332
        and (16|M0)              r78.0<1>:ud   acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud                    //  ALU pipe: int; $334
        load.slm.d32x2.a32 (16|M0)  r80:2       [r79:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $229
        and (16|M0)              r76.0<1>:ud   r76.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $331
        cbit (16|M0)             r78.0<1>:ud   r78.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $340
        load.slm.d32x2.a32 (16|M0)  r74:2       [r73:1]            {$5} // ex_desc:0x0; desc:0x2201500 // $218
        bfn.(s0&s1|s2) (16|M0)   r77.0<1>:ud   acc2.0<1;0>:ud    r105.0<1;0>:ud    r76.0<1>:ud      {I@2} //  ALU pipe: int; $333
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r78.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $341
        shl (16|M0)              r16.0<1>:ud   r42.0<1;1,0>:ud   0x3:uw              {Compacted}     //  ALU pipe: int; $266
        shl (16|M0)              r42.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $342
        shr (16|M0)              r8.0<1>:ud    r8.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $254
        and (16|M0)              r32.0<1>:ud   r32.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $258
        shr (16|M0)              r9.0<1>:ud    r9.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $339
        and (16|M0)              r16.0<1>:ud   r16.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@5}    //  ALU pipe: int; $267
        and (16|M0)              r42.0<1>:ud   r42.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@5}    //  ALU pipe: int; $343
        mul (32|M0)              r83.0<1>:hf   r43.0<1;1,0>:hf   r81.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $231
        bfn.(s0&s1|s2) (16|M0)   r3.0<1>:ud    r8.0<1;0>:ud      r105.0<1;0>:ud    r32.0<1>:ud      {@4,$11.src} //  ALU pipe: int; $259
        bfn.(s0&s1|s2) (16|M0)   r17.0<1>:ud   r13.0<1;0>:ud     r105.0<1;0>:ud    r16.0<1>:ud      {I@3} //  ALU pipe: int; $268
        bfn.(s0&s1|s2) (16|M0)   r81.0<1>:ud   r9.0<1;0>:ud      r105.0<1;0>:ud    r42.0<1>:ud      {A@1} //  ALU pipe: int; $344
        load.slm.d32x2.a32 (16|M0)  r68:2       [r67:1]            {$6} // ex_desc:0x0; desc:0x2201500 // $207
        load.slm.d32x2.a32 (16|M0)  r94:2       [r93:1]            {$7} // ex_desc:0x0; desc:0x2201500 // $240
        load.slm.d32x2.a32 (16|M0)  r100:2      [r99:1]            {$12} // ex_desc:0x0; desc:0x2201500 // $251
        load.slm.d32x2.a32 (16|M0)  r37:2       [r35:1]            {$13} // ex_desc:0x0; desc:0x2201500 // $292
        load.slm.d32x2.a32 (16|M0)  r45:2       [r41:1]            {$14} // ex_desc:0x0; desc:0x2201500 // $303
        load.slm.d32x2.a32 (16|M0)  r62:2       [r61:1]            {$15} // ex_desc:0x0; desc:0x2201500 // $197
        load.slm.d32x2.a32 (16|M0)  r59:2       [r49:1]            {$0} // ex_desc:0x0; desc:0x2201500 // $314
        load.slm.d32x2.a32 (16|M0)  r10:2       [r3:1]             {I@3,$1} // ex_desc:0x0; desc:0x2201500 // $261
        load.slm.d32x2.a32 (16|M0)  r31:2       [r30:1]            {$2} // ex_desc:0x0; desc:0x2201500 // $281
        load.slm.d32x2.a32 (16|M0)  r18:2       [r17:1]            {I@2,$3} // ex_desc:0x0; desc:0x2201500 // $270
        load.slm.d32x2.a32 (16|M0)  r90:2       [r81:1]            {I@1,$4} // ex_desc:0x0; desc:0x2201500 // $346
        mul (32|M0)              r82.0<1>:hf   r43.0<1;1,0>:hf   r80.0<1;1,0>:hf                     //  ALU pipe: float; $230
        load.slm.d32x2.a32 (16|M0)  r79:2       [r77:1]            {F@1,$8} // ex_desc:0x0; desc:0x2201500 // $336
        mul (32|M0)              r56.0<1>:hf   r43.0<1;1,0>:hf   r74.0<1;1,0>:hf  {$5.dst}           //  ALU pipe: float; $219
        load.slm.d32x2.a32 (16|M0)  r73:2       [r71:1]            {F@1,$5} // ex_desc:0x0; desc:0x2201500 // $325
        add (1|M0)               r102.3<1>:uq  r102.3<0;1,0>:uq  0x80:uw                             //  ALU pipe: int; $146
        mul (32|M0)              r57.0<1>:hf   r43.0<1;1,0>:hf   r75.0<1;1,0>:hf                     //  ALU pipe: float; $220 R{} IR{}{O:5,O:5,},  {BC=1}
        mul (32|M0)              r54.0<1>:hf   r43.0<1;1,0>:hf   r68.0<1;1,0>:hf  {$6.dst}           //  ALU pipe: float; $208
        mul (32|M0)              r55.0<1>:hf   r43.0<1;1,0>:hf   r69.0<1;1,0>:hf                     //  ALU pipe: float; $209
        mul (32|M0)              r84.0<1>:hf   r43.0<1;1,0>:hf   r94.0<1;1,0>:hf  {$7.dst}           //  ALU pipe: float; $241
        mul (32|M0)              r85.0<1>:hf   r43.0<1;1,0>:hf   r95.0<1;1,0>:hf                     //  ALU pipe: float; $242
        mul (32|M0)              r86.0<1>:hf   r43.0<1;1,0>:hf   r100.0<1;1,0>:hf {$12.dst}          //  ALU pipe: float; $252
        mul (32|M0)              r87.0<1>:hf   r43.0<1;1,0>:hf   r101.0<1;1,0>:hf                    //  ALU pipe: float; $253
        mul (32|M0)              r24.0<1>:hf   r43.0<1;1,0>:hf   r37.0<1;1,0>:hf  {$13.dst}          //  ALU pipe: float; $293
        mul (32|M0)              r25.0<1>:hf   r43.0<1;1,0>:hf   r38.0<1;1,0>:hf                     //  ALU pipe: float; $294
        mul (32|M0)              r26.0<1>:hf   r43.0<1;1,0>:hf   r45.0<1;1,0>:hf  {$14.dst}          //  ALU pipe: float; $304
        mul (32|M0)              r27.0<1>:hf   r43.0<1;1,0>:hf   r46.0<1;1,0>:hf                     //  ALU pipe: float; $305
        mul (32|M0)              r52.0<1>:hf   r43.0<1;1,0>:hf   r62.0<1;1,0>:hf  {$15.dst}          //  ALU pipe: float; $198
        mul (32|M0)              r53.0<1>:hf   r43.0<1;1,0>:hf   r63.0<1;1,0>:hf                     //  ALU pipe: float; $199
        mul (32|M0)              r61.0<1>:hf   r43.0<1;1,0>:hf   r59.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $315
        mul (32|M0)              r88.0<1>:hf   r43.0<1;1,0>:hf   r10.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $262
        mul (32|M0)              r89.0<1>:hf   r43.0<1;1,0>:hf   r11.0<1;1,0>:hf                     //  ALU pipe: float; $263
        mul (32|M0)              r22.0<1>:hf   r43.0<1;1,0>:hf   r31.0<1;1,0>:hf  {$2.dst}           //  ALU pipe: float; $282
        mul (32|M0)              r23.0<1>:hf   r43.0<1;1,0>:hf   r32.0<1;1,0>:hf                     //  ALU pipe: float; $283
        mul (32|M0)              r20.0<1>:hf   r43.0<1;1,0>:hf   r18.0<1;1,0>:hf  {$3.dst}           //  ALU pipe: float; $271
        mul (32|M0)              r21.0<1>:hf   r43.0<1;1,0>:hf   r19.0<1;1,0>:hf                     //  ALU pipe: float; $272
        mul (32|M0)              r67.0<1>:hf   r43.0<1;1,0>:hf   r90.0<1;1,0>:hf  {$4.dst}           //  ALU pipe: float; $347
        mul (32|M0)              r65.0<1>:hf   r43.0<1;1,0>:hf   r79.0<1;1,0>:hf  {$8.dst}           //  ALU pipe: float; $337
        mul (32|M0)              r66.0<1>:hf   r43.0<1;1,0>:hf   r80.0<1;1,0>:hf                     //  ALU pipe: float; $338
        mul (32|M0)              r64.0<1>:hf   r43.0<1;1,0>:hf   r74.0<1;1,0>:hf  {$5.dst}           //  ALU pipe: float; $327
        mul (32|M0)              r68.0<1>:hf   r43.0<1;1,0>:hf   r91.0<1;1,0>:hf                     //  ALU pipe: float; $348
        mul (32|M0)              r62.0<1>:hf   r43.0<1;1,0>:hf   r60.0<1;1,0>:hf                     //  ALU pipe: float; $316
        mul (32|M0)              r63.0<1>:hf   r43.0<1;1,0>:hf   r73.0<1;1,0>:hf                     //  ALU pipe: float; $326
        sync.nop                             null                             {Compacted,$11.dst}    // $350
        dpas.8x1 (16|M0)         r110:f        r110:f            r50:hf            r6.0:hf          {Compacted,$6} // $350 R{} IR{}{E:7,E:1,E:3,},  R{r110,r6,} IR{} {BC=1}
        add (1|M0)               r102.4<1>:q   r102.4<0;1,0>:q   r12.0<0;1,0>:ud                     //  ALU pipe: int; $354
        dpas.8x1 (16|M0)         r110:f        r110:f            r82:hf            r6.16:hf         {Compacted,$6} // $351 R{} IR{}{E:7,E:1,E:3,},  R{r110,r6,} IR{} {BC=1}
        sync.nop                             null                             {Compacted,F@7}        // $352
        dpas.8x1 (16|M0)         r110:f        r110:f            r20:hf            r7.0:hf          {Compacted,$6} // $352
        sync.nop                             null                             {Compacted,F@1}        // $353
        dpas.8x1 (16|M0)         r110:f        r110:f            r61:hf            r7.16:hf         {$6} // $353
        mov (1|M0)               null<1>:ud    r110.0<0;1,0>:w                  {$6.dst}             //  ALU pipe: int; $355
        cmp (1|M0)    (eq)f0.0   null<1>:d     r102.10<0;1,0>:d  r102.3<0;1,0>:d                     //  ALU pipe: int; $357
(W&~f0.0) jmpi                               BB_4                                                    //  ALU pipe: int; $358
// B008: Preds:{B007},  Succs:{B011}
_L_k27_3_:
        mov (16|M0)              r1.16<1>:hf   r110.0<1;1,0>:f                                       //  ALU pipe: float; $359
        mov (16|M0)              r112.0<1>:d   r1.16<1;1,0>:uw                  {F@1}                //  ALU pipe: int; $360
(W)     jmpi                                 BB_5                                                    // $361
// B009: Preds:{B007},  Succs:{B007}
BB_4:
        mov (16|M0)              r109.0<1>:f   r111.0<1;1,0>:f                  {Compacted}          //  ALU pipe: float; $364
        mov (1|M0)               r102.5<1>:d   r102.10<0;1,0>:d                                      //  ALU pipe: int; $363
(W)     jmpi                                 BB_3                                                    // $365
// B010: Preds:{B005},  Succs:{B011}
BB_2:
        mov (16|M0)              r112.0<1>:d   0:w                               {Compacted}         //  ALU pipe: int; $368
// B011: Preds:{B010, B008},  Succs:{}
BB_5:
        add (1|M0)               r1.2<1>:d     r102.12<0;1,0>:d  1:w                                 //  ALU pipe: int; $370
        sel (1|M0)    (lt)f0.0   r1.2<1>:ud    r1.2<0;1,0>:ud    r4.0<0;1,0>:ud   {I@1}              //  ALU pipe: int; $371
        shl (1|M0)               r6.0<1>:d     r4.5<0;1,0>:d     1:w               {$8.src}          //  ALU pipe: int; $373
        mul (16|M0)              r113.0<1>:ud  r113.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $376
(W)     mul (1|M0)               acc0.0<1>:d   r6.0<0;1,0>:d     r102.24<0;1,0>:uw {I@2}             //  ALU pipe: int; $374 R{} IR{}{E:3,E:3,},  {BC=1}
        cmp (16|M0)   (lt)f2.1   null<1>:d     r102.12<0;1,0>:ud  r1.2<0;1,0>:ud                     //  ALU pipe: int; $379
        macl (1|M0)              r6.0<1>:d     r6.0<0;1,0>:d     r102.12<0;1,0>:d                    //  ALU pipe: int; $376 R{} IR{}{E:3,E:3,},  {BC=1}
(W)     mov (16|M0)              r127.0<1>:f   r97.0<1;1,0>:f                                        //  ALU pipe: float; $383
        add3 (16|M0)             r113.0<1>:ud  r6.0<0;0>:ud      r102.14<0;0>:ud   r113.0<1>:ud     {I@1} //  ALU pipe: int; $377 R{} IR{}{E:3,E:3,O:0,},  {BC=1}
(f2.1)  cmp (16|M0)   (lt)f2.1   null<1>:d     r103.0<1;1,0>:ud  r102.11<0;1,0>:ud                   //  ALU pipe: int; $380
        sync.nop                             null                             {Compacted,$10.src}    // $378
        mov (16|M0)              r7.0<2>:ud    r113.0<1;1,0>:ud                 {Compacted,@2,$9.src} //  ALU pipe: int; $378
        add (16|M0)              r9.0<1>:q     r4.5<0;1,0>:q     r7.0<2;1,0>:ud   {I@1}              //  ALU pipe: int; $378
(f2.1)  store.ugm.d16u32.a64.st.wb (16|M0)  [r9:2] r112:1          {I@1,$7} // ex_desc:0x0; desc:0x40C0B84 // $382
(W)     send.gtwy (1|M0)         null     r127  null:0  0x0            0x02000010           {EOT,F@1,$8} // wr:1+0, rd:0; end of thread // $383


//.BankConflicts: 6
//.ByteRMWs: 0
//


//.numALUInst: 337
//.accSubDef: 34
//.accSubUse: 57
//.accSubCandidateDef: 36
//.accSubCandidateUse: 60
//
//
//.singlePipeAtOneDistNum: 40
//.allAtOneDistNum: 8
//.syncInstCount: 9
//.tokenReuseCount: 4
//.AfterWriteTokenDepCount: 28
//.AfterReadTokenDepCount: 15
