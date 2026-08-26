//.kernel _ZTS22int1_fp16_upcvt_kernelILi1ELi256ELi1ELi16ELi64ELi1ELi1ELb1EE
//.platform XE2
//.thread_config numGRF=128, numAcc=4, numSWSB=16
//.options_string "-enablePreemptionR0Only -enableHalfLSC -dumpcommonisa -output -binary -abiver 2 -samplerHeaderWA "
//.full_options "-samplerHeaderWA -enablePreemptionR0Only -abiver 2 -output -binary -dumpcommonisa -enableHalfLSC "
//.instCount 384
//.RA type	LOCAL_ROUND_ROBIN_BC_RA
//.git-hash cd6c33fbee6ccc897657c64b11eae6917cc8ff5e

//.declare BuiltInR0 (0)  rf=r size=64 type=ud align=32 words (r0.0) IsBuiltin
//.declare  (1)  rf=r size=64 type=ud align=32 words (r71.0) IsBuiltin
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
//.declare V64 (72)  rf=r size=4 type=d align=2 words (r5.0)
//.declare V65 (73)  rf=r size=4 type=d align=2 words (r6.0)
//.declare V66 (74)  rf=r size=4 type=d align=2 words (r91.0)
//.declare V67 (75)  rf=r size=8 type=uq align=4 words (r4.4)
//.declare V68 (76)  rf=r size=4 type=d align=2 words (r8.0)
//.declare V69 (77)  rf=r size=4 type=d align=2 words (r9.0)
//.declare V70 (78)  rf=r size=4 type=d align=2 words (r10.0)
//.declare V71 (79)  rf=r size=4 type=d align=32 words (r11.0)
//.declare V72 (80)  rf=r size=4 type=d align=2 words (r91.1)
//.declare V73 (81)  rf=r size=4 type=d align=2 words (r91.2)
//.declare V74 (82)  rf=r size=64 type=d align=32 words (r97.0)
//.declare V75 (83)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V76 (84)  rf=r size=8 type=uq align=4 words (r5.4)
//.declare V77 (85)  rf=r size=128 type=q align=32 words (r16.0)
//.declare V78 (86)  rf=r size=64 type=d align=32 words (r105.0)
//.declare V79 (87)  rf=r size=4 type=d align=2 words (r7.0)
//.declare V80 (88)  rf=r size=64 type=w align=32 words (r18.0)
//.declare V81 (89)  rf=r size=32 type=w align=2 words (r21.0)
//.declare V82 (90)  rf=r size=32 type=w align=2 words (r24.0)
//.declare V83 (91)  rf=r size=32 type=w align=2 words (r27.0)
//.declare V84 (92)  rf=r size=32 type=w align=2 words (r30.0)
//.declare V85 (93)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V86 (94)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V87 (95)  rf=r size=32 type=w align=8 words (r37.0)
//.declare V88 (96)  rf=r size=64 type=w align=32 words (r31.0)
//.declare V89 (97)  rf=r size=32 type=w align=2 words (r40.0)
//.declare V90 (98)  rf=r size=64 type=d align=32 words (r41.0)
//.declare V91 (99)  rf=r size=64 type=d align=32 words (r42.0)
//.declare V92 (100)  rf=r size=64 type=w align=32 words (r32.0)
//.declare V93 (101)  rf=r size=32 type=w align=2 words (r45.0)
//.declare V94 (102)  rf=r size=64 type=d align=32 words (r46.0)
//.declare V95 (103)  rf=r size=64 type=d align=32 words (r47.0)
//.declare V96 (104)  rf=r size=64 type=d align=32 words (r48.0)
//.declare V97 (105)  rf=r size=64 type=d align=32 words (r49.0)
//.declare V98 (106)  rf=r size=64 type=d align=32 words (r50.0)
//.declare V99 (107)  rf=r size=64 type=d align=32 words (r51.0)
//.declare P1 (108)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V101 (110)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V103 (112)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V104 (113)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V106 (115)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V108 (117)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V109 (118)  rf=r size=4 type=d align=32 words (r7.0)
//.declare V110 (119)  rf=r size=64 type=d align=32 words (r107.0)
//.declare V111 (120)  rf=r size=4 type=d align=32 words (r8.0)
//.declare V112 (121)  rf=r size=64 type=d align=32 words (r106.0)
//.declare P2 (122)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare V115 (125)  rf=r size=4 type=d align=2 words (r91.3)
//.declare V116 (126)  rf=r size=8 type=q align=4 words (r91.2)
//.declare V117 (127)  rf=r size=8 type=q align=4 words (r91.3)
//.declare V118 (128)  rf=r size=64 type=d align=32 words (r108.0)
//.declare V119 (129)  rf=r size=64 type=d align=32 words (r109.0)
//.declare V120 (130)  rf=r size=64 type=d align=32 words (r110.0)
//.declare V121 (131)  rf=r size=64 type=f align=32 words (r116.0)
//.declare V122 (132)  rf=r size=8 type=q align=32 words (r3.0)
//.declare V123 (133)  rf=r size=8 type=q align=32 words (r10.0)
//.declare V124 (134)  rf=r size=32 type=hf align=32 words (r11.0)
//.declare V125 (135)  rf=r size=4 type=d align=2 words (r91.8)
//.declare P3 (136)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare V126 (137)  rf=r size=4 type=d align=2 words (r12.0)
//.declare V127 (138)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V128 (139)  rf=r size=64 type=d align=32 words (r111.0)
//.declare V129 (140)  rf=r size=64 type=d align=32 words (r15.0)
//.declare V130 (141)  rf=r size=128 type=q align=32 words (r18.0)
//.declare V131 (142)  rf=r size=192 type=d align=32 words (r21.0)
//.declare V132 (143)  rf=r size=32 type=w align=2 words (r27.0)
//.declare V134 (145)  rf=r size=32 type=w align=2 words (r30.0)
//.declare V136 (147)  rf=r size=64 type=d align=32 words (r24.0)
//.declare P4 (148)  rf=f16  size=2 type=uw align=1 words (f3.0)
//.declare V137 (149)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V138 (150)  rf=r size=64 type=w align=32 words (r14.0)
//.declare V139 (151)  rf=r size=32 type=w align=2 words (r37.0)
//.declare V141 (153)  rf=r size=32 type=w align=2 words (r40.0)
//.declare V143 (155)  rf=r size=64 type=d align=32 words (r34.0)
//.declare P5 (156)  rf=f16  size=2 type=uw align=1 words (f2.1)
//.declare V144 (157)  rf=r size=64 type=hf align=32 words (r43.0)
//.declare V145 (158)  rf=r size=64 type=d align=32 words (r44.0)
//.declare V146 (159)  rf=r size=64 type=d align=32 words (r46.0)
//.declare V147 (160)  rf=r size=64 type=d align=32 words (r47.0)
//.declare V148 (161)  rf=r size=128 type=hf align=32 words (r48.0)
//.declare V149 (162)  rf=r size=64 type=d align=32 words (r45.0)
//.declare V150 (163)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V151 (164)  rf=r size=64 type=d align=32 words (r60.0)
//.declare V152 (165)  rf=r size=64 type=d align=32 words (r61.0)
//.declare V153 (166)  rf=r size=128 type=hf align=32 words (r62.0)
//.declare V154 (167)  rf=r size=64 type=d align=32 words (r59.0)
//.declare V155 (168)  rf=r size=64 type=d align=32 words (r66.0)
//.declare V156 (169)  rf=r size=64 type=d align=32 words (r67.0)
//.declare V157 (170)  rf=r size=128 type=hf align=32 words (r68.0)
//.declare V158 (171)  rf=r size=64 type=d align=32 words (r64.0)
//.declare V160 (173)  rf=r size=64 type=d align=32 words (r72.0)
//.declare V161 (174)  rf=r size=64 type=d align=32 words (r73.0)
//.declare V162 (175)  rf=r size=128 type=hf align=32 words (r74.0)
//.declare V163 (176)  rf=r size=512 type=d align=32 words (r50.0)
//.declare V164 (177)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V166 (179)  rf=r size=64 type=d align=32 words (r78.0)
//.declare V167 (180)  rf=r size=64 type=d align=32 words (r79.0)
//.declare V168 (181)  rf=r size=128 type=hf align=32 words (r80.0)
//.declare V169 (182)  rf=r size=64 type=d align=32 words (r76.0)
//.declare V171 (184)  rf=r size=64 type=d align=32 words (r92.0)
//.declare V172 (185)  rf=r size=64 type=d align=32 words (r93.0)
//.declare V173 (186)  rf=r size=128 type=hf align=32 words (r94.0)
//.declare V174 (187)  rf=r size=64 type=d align=32 words (r90.0)
//.declare V176 (189)  rf=r size=64 type=d align=32 words (r98.0)
//.declare V177 (190)  rf=r size=64 type=d align=32 words (r99.0)
//.declare V178 (191)  rf=r size=128 type=hf align=32 words (r100.0)
//.declare V179 (192)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V180 (193)  rf=r size=64 type=d align=32 words (r96.0)
//.declare V181 (194)  rf=r size=64 type=d align=32 words (r32.0)
//.declare V182 (195)  rf=r size=64 type=d align=32 words (r102.0)
//.declare V183 (196)  rf=r size=128 type=hf align=32 words (r103.0)
//.declare V184 (197)  rf=r size=512 type=d align=32 words (r82.0)
//.declare V185 (198)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V186 (199)  rf=r size=64 type=d align=32 words (r10.0)
//.declare V187 (200)  rf=r size=64 type=d align=32 words (r11.0)
//.declare V188 (201)  rf=r size=128 type=hf align=32 words (r13.0)
//.declare V189 (202)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V190 (203)  rf=r size=64 type=d align=32 words (r24.0)
//.declare V191 (204)  rf=r size=64 type=d align=32 words (r25.0)
//.declare V192 (205)  rf=r size=128 type=hf align=32 words (r26.0)
//.declare V193 (206)  rf=r size=64 type=d align=32 words (r23.0)
//.declare V194 (207)  rf=r size=64 type=d align=32 words (r28.0)
//.declare V195 (208)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V196 (209)  rf=r size=128 type=hf align=32 words (r31.0)
//.declare V197 (210)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V198 (211)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V199 (212)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V200 (213)  rf=r size=128 type=hf align=32 words (r37.0)
//.declare V201 (214)  rf=r size=512 type=d align=32 words (r15.0)
//.declare V202 (215)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V203 (216)  rf=r size=64 type=d align=32 words (r40.0)
//.declare V204 (217)  rf=r size=64 type=d align=32 words (r41.0)
//.declare V205 (218)  rf=r size=128 type=hf align=32 words (r45.0)
//.declare V206 (219)  rf=r size=64 type=d align=32 words (r44.0)
//.declare V207 (220)  rf=r size=64 type=d align=32 words (r66.0)
//.declare V208 (221)  rf=r size=64 type=d align=32 words (r67.0)
//.declare V209 (222)  rf=r size=128 type=hf align=32 words (r69.0)
//.declare V210 (223)  rf=r size=64 type=d align=32 words (r68.0)
//.declare V211 (224)  rf=r size=64 type=d align=32 words (r72.0)
//.declare V212 (225)  rf=r size=64 type=d align=32 words (r73.0)
//.declare V213 (226)  rf=r size=128 type=hf align=32 words (r75.0)
//.declare V214 (227)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V215 (228)  rf=r size=64 type=d align=32 words (r74.0)
//.declare V216 (229)  rf=r size=64 type=d align=32 words (r42.0)
//.declare V217 (230)  rf=r size=64 type=d align=32 words (r77.0)
//.declare V218 (231)  rf=r size=128 type=hf align=32 words (r78.0)
//.declare V219 (232)  rf=r size=512 type=d align=32 words (r58.0)
//.declare V220 (233)  rf=r size=128 type=d align=32 words (r6.0)
//.declare P6 (234)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare V221 (235)  rf=r size=32 type=w align=16 words (r1.16)
//.declare V223 (237)  rf=r size=64 type=d align=32 words (r112.0)
//.declare V224 (238)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V225 (239)  rf=r size=4 type=d align=2 words (r91.9)
//.declare V226 (240)  rf=r size=4 type=d align=2 words (r91.10)
//.declare V227 (241)  rf=r size=4 type=d align=2 words (r1.2)
//.declare V228 (242)  rf=r size=4 type=d align=2 words (r91.11)
//.declare V229 (243)  rf=r size=64 type=d align=32 words (r113.0)
//.declare V230 (244)  rf=r size=8 type=uq align=4 words (r4.5)
//.declare V231 (245)  rf=r size=128 type=q align=32 words (r8.0)
//.declare P7 (246)  rf=f16  size=2 type=uw align=1 words (f0.0)
//.declare P8 (247)  rf=f16  size=2 type=uw align=1 words (f3.1)
//.declare P9 (248)  rf=f16  size=2 type=uw align=1 words (f2.0)
//.declare V232 (249)  rf=r size=6 type=uw alias=V33+0 align=1 words (r1.0)
//.declare V233 (250)  rf=r size=8 type=d alias=V60+0 align=2 words (r1.2)
//.declare V235 (252)  rf=r size=12 type=d alias=V34+0 align=2 words (r2.0)
//.declare V236 (253)  rf=r size=12 type=d alias=V61+0 align=2 words (r2.3)
//.declare V237 (254)  rf=r size=4 type=d alias=V62+0 align=2 words (r3.0)
//.declare V238 (255)  rf=r size=12 type=d alias=V63+0 align=2 words (r4.12)
//.declare V239 (256)  rf=r size=4 type=d alias=V64+0 align=2 words (r5.0)
//.declare V240 (257)  rf=r size=4 type=d alias=V65+0 align=2 words (r6.0)
//.declare V241 (258)  rf=r size=4 type=d alias=V225+0 align=2 words (r91.9)
//.declare V242 (259)  rf=r size=4 type=ud alias=V225+0 align=2 words (r91.9)
//.declare V243 (260)  rf=r size=4 type=ud alias=V38+0 align=2 words (r4.2)
//.declare V244 (261)  rf=r size=4 type=d alias=V66+0 align=2 words (r91.0)
//.declare V245 (262)  rf=r size=4 type=d alias=V37+0 align=2 words (r4.1)
//.declare V246 (263)  rf=r size=4 type=d alias=V79+0 align=2 words (r7.0)
//.declare V247 (264)  rf=r size=4 type=d alias=V228+0 align=2 words (r91.11)
//.declare V248 (265)  rf=r size=8 type=q alias=V67+0 align=4 words (r4.4)
//.declare V249 (266)  rf=r size=64 type=q alias=V118+0 align=32 words (r108.0)
//.declare V250 (267)  rf=r size=4 type=ud alias=V68+0 align=2 words (r8.0)
//.declare V251 (268)  rf=r size=64 type=ud alias=V118+0 align=32 words (r108.0)
//.declare V252 (269)  rf=r size=4 type=ud alias=V69+0 align=2 words (r9.0)
//.declare V253 (270)  rf=r size=4 type=ud alias=V37+0 align=2 words (r4.1)
//.declare V254 (271)  rf=r size=4 type=d alias=V70+0 align=2 words (r10.0)
//.declare V255 (272)  rf=r size=4 type=d alias=V40+0 align=2 words (r4.4)
//.declare V256 (273)  rf=r size=64 type=d alias=V118+0 align=32 words (r108.0)
//.declare V257 (274)  rf=r size=4 type=d alias=V71+0 align=2 words (r11.0)
//.declare V258 (275)  rf=r size=4 type=d alias=V39+0 align=2 words (r4.3)
//.declare V259 (276)  rf=r size=4 type=d alias=V226+0 align=2 words (r91.10)
//.declare V260 (277)  rf=r size=64 type=d alias=V119+0 align=32 words (r109.0)
//.declare V261 (278)  rf=r size=4 type=ud alias=V72+0 align=2 words (r91.1)
//.declare V262 (279)  rf=r size=4 type=ud alias=V66+0 align=2 words (r91.0)
//.declare V263 (280)  rf=r size=4 type=ud alias=V71+0 align=2 words (r11.0)
//.declare V264 (281)  rf=r size=4 type=d alias=V73+0 align=2 words (r91.2)
//.declare V265 (282)  rf=r size=4 type=d alias=V52+0 align=2 words (r5.4)
//.declare V266 (283)  rf=r size=4 type=ud alias=V228+0 align=2 words (r91.11)
//.declare V267 (284)  rf=r size=8 type=q alias=V117+0 align=4 words (r91.3)
//.declare V268 (285)  rf=r size=64 type=d alias=V229+0 align=32 words (r113.0)
//.declare V269 (286)  rf=r size=64 type=d alias=V74+0 align=32 words (r97.0)
//.declare V270 (287)  rf=r size=64 type=d alias=V75+0 align=32 words (r13.0)
//.declare V271 (288)  rf=r size=128 type=q alias=V77+0 align=32 words (r16.0)
//.declare V272 (289)  rf=r size=8 type=q alias=V76+0 align=4 words (r5.4)
//.declare V273 (290)  rf=r size=64 type=ud alias=V75+0 align=32 words (r13.0)
//.declare V274 (291)  rf=r size=128 type=uq alias=V77+0 align=32 words (r16.0)
//.declare V275 (292)  rf=r size=64 type=d alias=V80+0 align=32 words (r18.0)
//.declare V276 (293)  rf=r size=32 type=uw alias=V81+0 align=1 words (r21.0)
//.declare V277 (294)  rf=r size=64 type=uw alias=V80+0 align=32 words (r18.0)
//.declare V278 (295)  rf=r size=32 type=uw alias=V82+0 align=1 words (r24.0)
//.declare V279 (296)  rf=r size=32 type=uw alias=V83+0 align=1 words (r27.0)
//.declare V280 (297)  rf=r size=32 type=uw alias=V84+0 align=1 words (r30.0)
//.declare V281 (298)  rf=r size=64 type=d alias=V88+0 align=32 words (r31.0)
//.declare V282 (299)  rf=r size=64 type=d alias=V92+0 align=32 words (r32.0)
//.declare V283 (300)  rf=r size=64 type=d alias=V86+0 align=32 words (r36.0)
//.declare V284 (301)  rf=r size=32 type=uw alias=V87+0 align=1 words (r37.0)
//.declare V285 (302)  rf=r size=64 type=d alias=V95+0 align=32 words (r47.0)
//.declare V286 (303)  rf=r size=64 type=ud alias=V88+0 align=32 words (r31.0)
//.declare V287 (304)  rf=r size=64 type=ud alias=V229+0 align=32 words (r113.0)
//.declare V288 (305)  rf=r size=32 type=w alias=V89+0 align=1 words (r40.0)
//.declare V289 (306)  rf=r size=64 type=w alias=V88+0 align=32 words (r31.0)
//.declare V290 (307)  rf=r size=32 type=uw alias=V89+0 align=1 words (r40.0)
//.declare V291 (308)  rf=r size=64 type=ud alias=V92+0 align=32 words (r32.0)
//.declare V292 (309)  rf=r size=32 type=w alias=V93+0 align=1 words (r45.0)
//.declare V293 (310)  rf=r size=64 type=w alias=V92+0 align=32 words (r32.0)
//.declare V294 (311)  rf=r size=64 type=d alias=V97+0 align=32 words (r49.0)
//.declare V295 (312)  rf=r size=32 type=uw alias=V93+0 align=1 words (r45.0)
//.declare V296 (313)  rf=r size=64 type=d alias=V94+0 align=32 words (r46.0)
//.declare V297 (314)  rf=r size=64 type=ud alias=V96+0 align=32 words (r48.0)
//.declare V298 (315)  rf=r size=64 type=ud alias=V95+0 align=32 words (r47.0)
//.declare V299 (316)  rf=r size=64 type=ud alias=V85+0 align=32 words (r33.0)
//.declare V300 (317)  rf=r size=64 type=ud alias=V86+0 align=32 words (r36.0)
//.declare V301 (318)  rf=r size=64 type=ud alias=V98+0 align=32 words (r50.0)
//.declare V302 (319)  rf=r size=64 type=ud alias=V97+0 align=32 words (r49.0)
//.declare V303 (320)  rf=r size=64 type=ud alias=V90+0 align=32 words (r41.0)
//.declare V304 (321)  rf=r size=64 type=ud alias=V91+0 align=32 words (r42.0)
//.declare V305 (322)  rf=r size=64 type=ud alias=V94+0 align=32 words (r46.0)
//.declare V306 (323)  rf=r size=64 type=ud alias=V99+0 align=32 words (r51.0)
//.declare V308 (325)  rf=r size=64 type=ud alias=V101+0 align=32 words (r3.0)
//.declare V309 (326)  rf=r size=64 type=ud alias=V104+0 align=32 words (r7.0)
//.declare  (327)  rf=r size=64 type=ud align=32 words (r3.0)
//.declare V310 (328)  rf=r size=4 type=ud alias=V109+0 align=2 words (r7.0)
//.declare V311 (329)  rf=r size=4 type=ud alias=V111+0 align=2 words (r8.0)
//.declare V312 (330)  rf=r size=8 type=uq alias=V122+0 align=4 words (r3.0)
//.declare V313 (331)  rf=r size=8 type=uq alias=V116+0 align=4 words (r91.2)
//.declare V314 (332)  rf=r size=8 type=uq alias=V56+0 align=4 words (r4.3)
//.declare V315 (333)  rf=r size=128 type=q alias=V220+0 align=32 words (r6.0)
//.declare V316 (334)  rf=r size=8 type=uq alias=V123+0 align=4 words (r10.0)
//.declare V317 (335)  rf=r size=8 type=uq alias=V117+0 align=4 words (r91.3)
//.declare V318 (336)  rf=r size=8 type=uq alias=V57+0 align=4 words (r5.1)
//.declare V319 (337)  rf=r size=32 type=q alias=V124+0 align=4 words (r11.0)
//.declare V320 (338)  rf=r size=4 type=d alias=V125+0 align=2 words (r91.8)
//.declare V321 (339)  rf=r size=4 type=d alias=V115+0 align=2 words (r91.3)
//.declare V322 (340)  rf=r size=64 type=ud alias=V127+0 align=32 words (r13.0)
//.declare V323 (341)  rf=r size=64 type=ud alias=V179+0 align=32 words (r8.0)
//.declare V324 (342)  rf=r size=64 type=ud alias=V138+0 align=32 words (r14.0)
//.declare V325 (343)  rf=r size=64 type=ud alias=V120+0 align=32 words (r110.0)
//.declare V326 (344)  rf=r size=64 type=ud alias=V128+0 align=32 words (r111.0)
//.declare V327 (345)  rf=r size=64 type=ud alias=V214+0 align=32 words (r9.0)
//.declare V328 (346)  rf=r size=64 type=ud alias=V143+0 align=32 words (r34.0)
//.declare V329 (347)  rf=r size=64 type=ud alias=V129+0 align=32 words (r15.0)
//.declare V330 (348)  rf=r size=64 type=ud alias=V78+0 align=32 words (r105.0)
//.declare V331 (349)  rf=r size=128 type=q alias=V130+0 align=32 words (r18.0)
//.declare V332 (350)  rf=r size=8 type=q alias=V58+0 align=4 words (r5.3)
//.declare V333 (351)  rf=r size=128 type=uq alias=V130+0 align=32 words (r18.0)
//.declare V334 (352)  rf=r size=64 type=ud alias=V181+0 align=32 words (r32.0)
//.declare V335 (353)  rf=r size=192 type=ud alias=V131+0 align=32 words (r21.0)
//.declare V336 (354)  rf=r size=64 type=ud alias=V136+0 align=32 words (r24.0)
//.declare V337 (355)  rf=r size=32 type=w alias=V132+0 align=1 words (r27.0)
//.declare V338 (356)  rf=r size=64 type=w alias=V120+0 align=32 words (r110.0)
//.declare V339 (357)  rf=r size=32 type=uw alias=V132+0 align=1 words (r27.0)
//.declare V340 (358)  rf=r size=32 type=w alias=V134+0 align=1 words (r30.0)
//.declare V341 (359)  rf=r size=32 type=uw alias=V134+0 align=1 words (r30.0)
//.declare V344 (362)  rf=r size=64 type=ud alias=V137+0 align=32 words (r33.0)
//.declare V345 (363)  rf=r size=64 type=ud alias=V216+0 align=32 words (r42.0)
//.declare V346 (364)  rf=r size=32 type=w alias=V139+0 align=1 words (r37.0)
//.declare V347 (365)  rf=r size=64 type=w alias=V138+0 align=32 words (r14.0)
//.declare V348 (366)  rf=r size=32 type=uw alias=V139+0 align=1 words (r37.0)
//.declare V349 (367)  rf=r size=32 type=w alias=V141+0 align=1 words (r40.0)
//.declare V350 (368)  rf=r size=32 type=uw alias=V141+0 align=1 words (r40.0)
//.declare V353 (371)  rf=r size=64 type=ud alias=V145+0 align=32 words (r44.0)
//.declare V354 (372)  rf=r size=64 type=ud alias=V149+0 align=32 words (r45.0)
//.declare V355 (373)  rf=r size=64 type=ud alias=V110+0 align=32 words (r107.0)
//.declare V356 (374)  rf=r size=64 type=ud alias=V146+0 align=32 words (r46.0)
//.declare V357 (375)  rf=r size=64 type=ud alias=V112+0 align=32 words (r106.0)
//.declare V358 (376)  rf=r size=64 type=ud alias=V147+0 align=32 words (r47.0)
//.declare V359 (377)  rf=r size=128 type=d alias=V148+0 align=32 words (r48.0)
//.declare V360 (378)  rf=r size=512 type=hf alias=V163+0 align=32 words (r50.0)
//.declare V361 (379)  rf=r size=64 type=hf alias=V144+0 align=32 words (r43.0)
//.declare V362 (380)  rf=r size=128 type=hf alias=V148+0 align=32 words (r48.0)
//.declare V363 (381)  rf=r size=64 type=ud alias=V150+0 align=32 words (r58.0)
//.declare V364 (382)  rf=r size=64 type=ud alias=V154+0 align=32 words (r59.0)
//.declare V365 (383)  rf=r size=64 type=ud alias=V151+0 align=32 words (r60.0)
//.declare V366 (384)  rf=r size=64 type=ud alias=V152+0 align=32 words (r61.0)
//.declare V367 (385)  rf=r size=128 type=d alias=V153+0 align=32 words (r62.0)
//.declare V368 (386)  rf=r size=128 type=hf alias=V153+0 align=32 words (r62.0)
//.declare V369 (387)  rf=r size=64 type=ud alias=V158+0 align=32 words (r64.0)
//.declare V370 (388)  rf=r size=64 type=ud alias=V155+0 align=32 words (r66.0)
//.declare V371 (389)  rf=r size=64 type=ud alias=V156+0 align=32 words (r67.0)
//.declare V372 (390)  rf=r size=128 type=d alias=V157+0 align=32 words (r68.0)
//.declare V373 (391)  rf=r size=128 type=hf alias=V157+0 align=32 words (r68.0)
//.declare V375 (393)  rf=r size=64 type=ud alias=V164+0 align=32 words (r70.0)
//.declare V376 (394)  rf=r size=64 type=ud alias=V160+0 align=32 words (r72.0)
//.declare V377 (395)  rf=r size=64 type=ud alias=V161+0 align=32 words (r73.0)
//.declare V378 (396)  rf=r size=128 type=d alias=V162+0 align=32 words (r74.0)
//.declare V379 (397)  rf=r size=128 type=hf alias=V162+0 align=32 words (r74.0)
//.declare V381 (399)  rf=r size=64 type=ud alias=V169+0 align=32 words (r76.0)
//.declare V382 (400)  rf=r size=64 type=ud alias=V166+0 align=32 words (r78.0)
//.declare V383 (401)  rf=r size=64 type=ud alias=V167+0 align=32 words (r79.0)
//.declare V384 (402)  rf=r size=128 type=d alias=V168+0 align=32 words (r80.0)
//.declare V385 (403)  rf=r size=512 type=hf alias=V184+0 align=32 words (r82.0)
//.declare V386 (404)  rf=r size=128 type=hf alias=V168+0 align=32 words (r80.0)
//.declare V388 (406)  rf=r size=64 type=ud alias=V174+0 align=32 words (r90.0)
//.declare V389 (407)  rf=r size=64 type=ud alias=V171+0 align=32 words (r92.0)
//.declare V390 (408)  rf=r size=64 type=ud alias=V172+0 align=32 words (r93.0)
//.declare V391 (409)  rf=r size=128 type=d alias=V173+0 align=32 words (r94.0)
//.declare V392 (410)  rf=r size=128 type=hf alias=V173+0 align=32 words (r94.0)
//.declare V394 (412)  rf=r size=64 type=ud alias=V180+0 align=32 words (r96.0)
//.declare V395 (413)  rf=r size=64 type=ud alias=V176+0 align=32 words (r98.0)
//.declare V396 (414)  rf=r size=64 type=ud alias=V177+0 align=32 words (r99.0)
//.declare V397 (415)  rf=r size=128 type=d alias=V178+0 align=32 words (r100.0)
//.declare V398 (416)  rf=r size=128 type=hf alias=V178+0 align=32 words (r100.0)
//.declare V399 (417)  rf=r size=64 type=ud alias=V182+0 align=32 words (r102.0)
//.declare V400 (418)  rf=r size=128 type=d alias=V183+0 align=32 words (r103.0)
//.declare V401 (419)  rf=r size=128 type=hf alias=V183+0 align=32 words (r103.0)
//.declare V402 (420)  rf=r size=64 type=ud alias=V185+0 align=32 words (r3.0)
//.declare V403 (421)  rf=r size=64 type=ud alias=V189+0 align=32 words (r8.0)
//.declare V404 (422)  rf=r size=64 type=ud alias=V186+0 align=32 words (r10.0)
//.declare V405 (423)  rf=r size=64 type=ud alias=V187+0 align=32 words (r11.0)
//.declare V406 (424)  rf=r size=128 type=d alias=V188+0 align=32 words (r13.0)
//.declare V407 (425)  rf=r size=512 type=hf alias=V201+0 align=32 words (r15.0)
//.declare V408 (426)  rf=r size=128 type=hf alias=V188+0 align=32 words (r13.0)
//.declare V409 (427)  rf=r size=64 type=ud alias=V193+0 align=32 words (r23.0)
//.declare V410 (428)  rf=r size=64 type=ud alias=V190+0 align=32 words (r24.0)
//.declare V411 (429)  rf=r size=64 type=ud alias=V191+0 align=32 words (r25.0)
//.declare V412 (430)  rf=r size=128 type=d alias=V192+0 align=32 words (r26.0)
//.declare V413 (431)  rf=r size=128 type=hf alias=V192+0 align=32 words (r26.0)
//.declare V414 (432)  rf=r size=64 type=ud alias=V197+0 align=32 words (r30.0)
//.declare V415 (433)  rf=r size=64 type=ud alias=V194+0 align=32 words (r28.0)
//.declare V416 (434)  rf=r size=64 type=ud alias=V195+0 align=32 words (r29.0)
//.declare V417 (435)  rf=r size=128 type=d alias=V196+0 align=32 words (r31.0)
//.declare V418 (436)  rf=r size=128 type=hf alias=V196+0 align=32 words (r31.0)
//.declare V419 (437)  rf=r size=64 type=ud alias=V202+0 align=32 words (r36.0)
//.declare V420 (438)  rf=r size=64 type=ud alias=V198+0 align=32 words (r34.0)
//.declare V421 (439)  rf=r size=64 type=ud alias=V199+0 align=32 words (r35.0)
//.declare V422 (440)  rf=r size=128 type=d alias=V200+0 align=32 words (r37.0)
//.declare V423 (441)  rf=r size=128 type=hf alias=V200+0 align=32 words (r37.0)
//.declare V424 (442)  rf=r size=64 type=ud alias=V206+0 align=32 words (r44.0)
//.declare V425 (443)  rf=r size=64 type=ud alias=V203+0 align=32 words (r40.0)
//.declare V426 (444)  rf=r size=64 type=ud alias=V204+0 align=32 words (r41.0)
//.declare V427 (445)  rf=r size=128 type=d alias=V205+0 align=32 words (r45.0)
//.declare V428 (446)  rf=r size=512 type=hf alias=V219+0 align=32 words (r58.0)
//.declare V429 (447)  rf=r size=128 type=hf alias=V205+0 align=32 words (r45.0)
//.declare V430 (448)  rf=r size=64 type=ud alias=V207+0 align=32 words (r66.0)
//.declare V431 (449)  rf=r size=64 type=ud alias=V210+0 align=32 words (r68.0)
//.declare V432 (450)  rf=r size=64 type=ud alias=V208+0 align=32 words (r67.0)
//.declare V433 (451)  rf=r size=128 type=d alias=V209+0 align=32 words (r69.0)
//.declare V434 (452)  rf=r size=128 type=hf alias=V209+0 align=32 words (r69.0)
//.declare V435 (453)  rf=r size=64 type=ud alias=V211+0 align=32 words (r72.0)
//.declare V436 (454)  rf=r size=64 type=ud alias=V215+0 align=32 words (r74.0)
//.declare V437 (455)  rf=r size=64 type=ud alias=V212+0 align=32 words (r73.0)
//.declare V438 (456)  rf=r size=128 type=d alias=V213+0 align=32 words (r75.0)
//.declare V439 (457)  rf=r size=128 type=hf alias=V213+0 align=32 words (r75.0)
//.declare V440 (458)  rf=r size=64 type=ud alias=V217+0 align=32 words (r77.0)
//.declare V441 (459)  rf=r size=128 type=d alias=V218+0 align=32 words (r78.0)
//.declare V442 (460)  rf=r size=128 type=hf alias=V218+0 align=32 words (r78.0)
//.declare V443 (461)  rf=r size=64 type=f alias=V121+0 align=32 words (r116.0)
//.declare V444 (462)  rf=r size=4 type=ud alias=V126+0 align=2 words (r12.0)
//.declare V445 (463)  rf=r size=64 type=w alias=V121+0 align=32 words (r116.0)
//.declare V446 (464)  rf=r size=4 type=d alias=V72+0 align=2 words (r91.1)
//.declare V447 (465)  rf=r size=32 type=hf alias=V221+0 align=1 words (r1.16)
//.declare V448 (466)  rf=r size=32 type=uw alias=V221+0 align=1 words (r1.16)
//.declare V449 (467)  rf=r size=4 type=d alias=V227+0 align=2 words (r1.2)
//.declare V450 (468)  rf=r size=4 type=ud alias=V227+0 align=2 words (r1.2)
//.declare V451 (469)  rf=r size=4 type=ud alias=V36+0 align=2 words (r4.0)
//.declare V452 (470)  rf=r size=4 type=d alias=V224+0 align=2 words (r3.0)
//.declare V453 (471)  rf=r size=4 type=d alias=V41+0 align=2 words (r4.5)
//.declare V454 (472)  rf=r size=128 type=q alias=V231+0 align=32 words (r8.0)
//.declare V455 (473)  rf=r size=8 type=q alias=V230+0 align=4 words (r4.5)
//.declare V456 (474)  rf=r size=4 type=ud alias=V226+0 align=2 words (r91.10)
//.declare V457 (475)  rf=r size=64 type=ud alias=V74+0 align=32 words (r97.0)
//.declare V458 (476)  rf=r size=128 type=uq alias=V231+0 align=32 words (r8.0)
//.declare  (477)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (478)  rf=r size=16 type=w align=16 words (r12.0)
//.declare  (479)  rf=r size=16 type=w align=16 words (r34.0)
//.declare  (481)  rf=r size=128 type=ud align=32 words (r14.0)
//.declare  (482)  rf=r size=64 type=uw align=32 words (r19.0)
//.declare  (483)  rf=r size=32 type=uw align=32 words (r20.0)
//.declare  (484)  rf=r size=64 type=uw align=32 words (r22.0)
//.declare  (485)  rf=r size=32 type=uw align=32 words (r23.0)
//.declare  (486)  rf=r size=64 type=uw align=32 words (r25.0)
//.declare  (487)  rf=r size=32 type=uw align=32 words (r26.0)
//.declare  (488)  rf=r size=64 type=uw align=32 words (r28.0)
//.declare  (489)  rf=r size=32 type=uw align=32 words (r29.0)
//.declare  (490)  rf=r size=64 type=w align=32 words (r38.0)
//.declare  (491)  rf=r size=32 type=w align=32 words (r39.0)
//.declare  (492)  rf=r size=64 type=w align=32 words (r43.0)
//.declare  (493)  rf=r size=32 type=w align=32 words (r44.0)
//.declare  (494)  rf=r size=128 type=ud align=32 words (r16.0)
//.declare  (495)  rf=r size=64 type=w align=32 words (r25.0)
//.declare  (496)  rf=r size=32 type=w align=32 words (r26.0)
//.declare  (497)  rf=r size=64 type=w align=32 words (r28.0)
//.declare  (498)  rf=r size=32 type=w align=32 words (r29.0)
//.declare  (499)  rf=r size=64 type=w align=32 words (r35.0)
//.declare  (500)  rf=r size=32 type=w align=32 words (r36.0)
//.declare  (501)  rf=r size=64 type=w align=32 words (r38.0)
//.declare  (502)  rf=r size=32 type=w align=32 words (r39.0)
//.declare  (503)  rf=r size=128 type=ud align=32 words (r6.0)
//.declare r0 (504)  rf=r size=64 type=ud align=32 words (r0.0)
//.declare rtmp (505)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (506)  rf=r size=64 type=ud align=32 words (r1.0)
//.declare  (507)  rf=r size=256 type=ud align=32 words (r2.0)

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
// | V67      | :uq      |    0x8 | r4+0x20  | cti+0xA0         |
// | V230     | :uq      |    0x8 | r4+0x28  | cti+0xA8         |
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
// | V76      | :uq      |    0x8 | r5+0x20  | cti+0xE0         |
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
// _ZTS22int1_fp16_upcvt_kernelILi1ELi256ELi1ELi16ELi64ELi1ELi1ELb1EE_BB_0:
(W)     mov (16|M0)              r71.0<1>:ud   r0.0<1;1,0>:ud                                        //  ALU pipe: int; $1
        and (1|M0)               cr0.0<1>:ud   cr0.0<0;1,0>:ud   -1073743089:d               {A@1}   // $1
        or (1|M0)                cr0.0<1>:ud   cr0.0<0;1,0>:ud   1073743040:d               {A@1}    // $2
        sync.nop                             null                             {Compacted,A@1}        // $4
        sync.nop                             null                             {Compacted,$1.dst}     // $4
        mul (2|M0)               r1.2<1>:d     r2.0<1;1,0>:d     r1.2<0;1,0>:uw   {A@1,$0.dst}       //  ALU pipe: int; $4
        mov (8|M0)               r12.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $35
        add (2|M0)               r2.3<1>:d     r1.2<1;1,0>:d     r1.0<1;1,0>:uw   {I@2}              //  ALU pipe: int; $5
        mov (8|M0)               r113.0<1>:d   r12.0<1;1,0>:w                   {I@2}                //  ALU pipe: int; $35
(W)     mul (1|M0)               acc0.0<1>:d   r2.4<0;1,0>:d     r2.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $6
        macl (1|M0)              r3.0<1>:d     r2.4<0;1,0>:d     r2.0<0;1,0>:d                       //  ALU pipe: int; $7
        add (8|M0)               r113.8<1>:d   r113.0<1;1,0>:d   8:w               {I@3}             //  ALU pipe: int; $36
        add (1|M0)               r4.12<1>:d    r3.0<0;1,0>:d     r1.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $7
        shl (1|M0)               r6.0<1>:d     r0.1<0;1,0>:d     8:w               {Compacted}       //  ALU pipe: int; $11
        and (1|M0)               r5.0<1>:d     r4.12<0;1,0>:d    15:w               {Compacted,I@2}  //  ALU pipe: int; $8
        mov (8|M0)               r37.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $57
        shl (1|M0)               r7.0<1>:d     r5.0<0;1,0>:d     4:w               {Compacted,I@2}   //  ALU pipe: int; $15
        mov (8|M0)               r37.8<1>:w    0xFEDCBA98:uv                                         //  ALU pipe: int; $58
        or (16|M0)               r18.0<1>:d    r7.0<0;1,0>:d     r113.0<1;1,0>:d  {Compacted,I@2}    //  ALU pipe: int; $41
        shr (16|M0)              r19.0<2>:uw   r18.0<2;1,0>:uw   0x4:uw              {I@1}           //  ALU pipe: int; $42
        shr (16|M0)              r22.0<2>:uw   r18.0<2;1,0>:uw   0x5:uw                              //  ALU pipe: int; $44
        shr (16|M0)              r25.0<2>:uw   r18.0<2;1,0>:uw   0x6:uw                              //  ALU pipe: int; $46
        mov (16|M0)              r20.0<1>:uw   r19.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $42
        mov (16|M0)              r23.0<1>:uw   r22.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $44
        mov (16|M0)              r26.0<1>:uw   r25.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $46
        mov (16|M0)              r21.0<1>:hf   r20.0<1;1,0>:hf                  {I@3}                //  ALU pipe: float; $42
        mov (16|M0)              r24.0<1>:hf   r23.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $44
        mov (16|M0)              r27.0<1>:hf   r26.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $46
        and (16|M0)              r21.0<1>:uw   r21.0<1;1,0>:uw   0x1:uw              {F@3}           //  ALU pipe: int; $43
        and (16|M0)              r24.0<1>:uw   r24.0<1;1,0>:uw   0x1:uw              {F@2}           //  ALU pipe: int; $45
        or (1|M0)                r91.11<1>:d   r6.0<0;1,0>:d     r7.0<0;1,0>:d                       //  ALU pipe: int; $16
        and (16|M0)              r27.0<1>:uw   r27.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $47
        add (16|M0)              r31.0<1>:d    r21.0<1;1,0>:uw   r24.0<1;1,0>:uw  {I@3}              //  ALU pipe: int; $50
        or (16|M0)               r97.0<1>:d    r91.11<0;1,0>:d   r113.0<1;1,0>:d  {Compacted,I@3}    //  ALU pipe: int; $37
        add (16|M0)              r32.0<1>:d    r31.0<1;1,0>:d    r27.0<1;1,0>:uw  {I@2}              //  ALU pipe: int; $51
        shr (16|M0)              r28.0<2>:uw   r18.0<2;1,0>:uw   0x7:uw                              //  ALU pipe: int; $48
        shl (16|M0)              r13.0<1>:d    r97.0<1;1,0>:d    2:w               {Compacted,I@3}   //  ALU pipe: int; $38
        shr (16|M0)              r32.0<1>:ud   r113.0<1;1,0>:ud  r32.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $69
        mov (8|M0)               r34.0<1>:w    0x10101010:v                                          //  ALU pipe: int; $53
        mov (1|M0)               r91.10<1>:d   r0.6<0;1,0>:ud                                        //  ALU pipe: int; $10
        shl (1|M0)               r11.0<1>:d    r4.3<0;1,0>:d     1:w               {Compacted}       //  ALU pipe: int; $26
        shr (16|M0)              r37.0<1>:uw   r37.0<1;1,0>:uw   r21.0<1;1,0>:uw                     //  ALU pipe: int; $59 R{} IR{}{O:2,O:2,},  {BC=1}
        shr (16|M0)              r31.0<1>:ud   r113.0<1;1,0>:ud  r31.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $64
        mov (16|M0)              r29.0<1>:uw   r28.0<2;1,0>:uw                  {I@7}                //  ALU pipe: int; $48
        mov (16|M0)              r14.0<2>:ud   r13.0<1;1,0>:ud                  {I@7}                //  ALU pipe: int; $39
        shl (16|M0)              r43.0<2>:w    r32.0<2;1,0>:w    15:w               {I@7}            //  ALU pipe: int; $70
        mov (8|M0)               r36.0<1>:d    r34.0<1;1,0>:w                   {I@7}                //  ALU pipe: int; $53
        mov (8|M0)               r36.8<1>:d    r34.0<1;1,0>:w                                        //  ALU pipe: int; $54
(W)     mul (1|M0)               acc0.0<1>:d   r11.0<0;1,0>:d    r91.20<0;1,0>:uw {I@7}              //  ALU pipe: int; $27 R{} IR{}{O:5,O:5,},  {BC=1}
        shl (16|M0)              r37.0<1>:uw   r37.0<1;1,0>:uw   0xF:uw              {I@7}           //  ALU pipe: int; $60
        shl (16|M0)              r38.0<2>:w    r31.0<2;1,0>:w    15:w               {I@7}            //  ALU pipe: int; $65
        mov (16|M0)              r30.0<1>:hf   r29.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $48
        add (16|M0)              r16.0<1>:q    r5.4<0;1,0>:q     r14.0<2;1,0>:ud  {I@7}              //  ALU pipe: int; $39
        mov (16|M0)              r44.0<1>:w    r43.0<2;1,0>:w                   {I@7}                //  ALU pipe: int; $70
        macl (1|M0)              r11.0<1>:d    r11.0<0;1,0>:d    r91.10<0;1,0>:d                     //  ALU pipe: int; $28 R{} IR{}{O:5,O:5,},  {BC=1}
        mul (16|M0)              acc0.0<1>:d   r36.0<1;1,0>:d    0x8000:uw              {I@7}        //  ALU pipe: int; $55
        load.ugm.d32.a64.ca.ca (16|M0)  r105:1  [r16:2]            {I@4,$2} // ex_desc:0x0; desc:0x4180580 // $40
        or (16|M0)               r37.0<1>:uw   r37.0<1;1,0>:uw   0x3C00:uw                           //  ALU pipe: int; $61
        mov (16|M0)              r39.0<1>:w    r38.0<2;1,0>:w                                        //  ALU pipe: int; $65
        and (16|M0)              r30.0<1>:uw   r30.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $49
        mov (16|M0)              r45.0<1>:hf   r44.0<1;1,0>:hf                  {I@6}                //  ALU pipe: float; $70
        add (16|M0)              r36.0<1>:d    acc0.0<1;1,0>:d   15360:w                             //  ALU pipe: int; $56
        mov (16|M0)              acc0.0<1>:d   -r24.0<1;1,0>:uw                                      //  ALU pipe: int; $62
        add (1|M0)               r91.9<1>:d    r6.0<0;1,0>:d     256:w                               //  ALU pipe: int; $12
        mov (16|M0)              r40.0<1>:hf   r39.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $65
        or (16|M0)               r45.0<1>:w    r45.0<1;1,0>:w    15360:w               {F@2}         //  ALU pipe: int; $71
        and (16|M0)              acc0.0<1>:d   r37.0<1;1,0>:uw   acc0.0<1;1,0>:d                     //  ALU pipe: int; $63
        mov (16|M0)              acc2.0<1>:d   -r30.0<1;1,0>:uw                 {I@6}                //  ALU pipe: int; $72
        sel (1|M0)    (lt)f0.0   r91.9<1>:ud   r91.9<0;1,0>:ud   r4.2<0;1,0>:ud   {I@4}              //  ALU pipe: int; $13
        or (16|M0)               r40.0<1>:w    r40.0<1;1,0>:w    15360:w               {F@1}         //  ALU pipe: int; $66
        and (16|M0)              acc2.0<1>:d   r45.0<1;1,0>:uw   acc2.0<1;1,0>:d  {I@5}              //  ALU pipe: int; $73
        shr (1|M0)               r9.0<1>:ud    r4.1<0;1,0>:ud    0x5:uw              {Compacted}     //  ALU pipe: int; $20
        shl (1|M0)               r10.0<1>:d    r4.4<0;1,0>:d     2:w               {Compacted}       //  ALU pipe: int; $22
        shl (16|M0)              r46.0<1>:d    r18.0<1;1,0>:d    3:w               {Compacted}       //  ALU pipe: int; $74
        mov (16|M0)              r33.0<1>:d    -r21.0<1;1,0>:uw                                      //  ALU pipe: int; $52
        mov (16|M0)              r42.0<1>:d    -r27.0<1;1,0>:uw                                      //  ALU pipe: int; $68
        shl (1|M0)               r8.0<1>:ud    r91.9<0;1,0>:ud   0x2:uw              {Compacted,I@7} //  ALU pipe: int; $18
        mov (16|M0)              r41.0<1>:d    r40.0<1;1,0>:uw                  {I@7}                //  ALU pipe: int; $67
        shl (16|M0)              r47.0<1>:d    acc0.0<1;1,0>:d   16:w                                //  ALU pipe: int; $75
        shl (16|M0)              r49.0<1>:d    acc2.0<1;1,0>:d   16:w                                //  ALU pipe: int; $77
        cmp (1|M0)    (eq)f1.1   null<1>:d     r5.0<0;1,0>:d     0:w                                 //  ALU pipe: int; $82
        mov (1|M0)               r108.0<1>:q   r4.4<0;1,0>:q                                         //  ALU pipe: int; $17
        mov (1|M0)               r108.6<1>:d   0:w                                                   //  ALU pipe: int; $25
        or (1|M0)                r108.5<1>:d   r6.0<0;1,0>:d     r7.0<0;1,0>:d                       //  ALU pipe: int; $24
        add (1|M0)               r108.3<1>:ud  r9.0<0;1,0>:ud    0xFFFFFFFF:ud                       //  ALU pipe: int; $21
        add (1|M0)               r108.4<1>:d   r10.0<0;1,0>:d    -1:w               {Compacted}      //  ALU pipe: int; $23
        or (16|M0)               r51.0<1>:ud   r46.0<1;1,0>:ud   0x4:uw              {Compacted}     //  ALU pipe: int; $80
        add (1|M0)               r108.2<1>:ud  r8.0<0;1,0>:ud    0xFFFFFFFF:ud              {I@7}    //  ALU pipe: int; $19
        bfn.(s0|s1&s2) (16|M0)   r48.0<1>:ud   r47.0<1;0>:ud     r33.0<1;0>:ud     r36.0<1>:ud      {I@7} //  ALU pipe: int; $76
        bfn.(s0|s1&s2) (16|M0)   r50.0<1>:ud   r49.0<1;0>:ud     r41.0<1;0>:ud     r42.0<1>:ud      {I@7} //  ALU pipe: int; $78
        add (1|M0)               r91.0<1>:d    r4.1<0;1,0>:d     63:w               {Compacted}      //  ALU pipe: int; $14
        mov (1|M0)               r91.3<1>:q    r91.11<0;1,0>:ud                                      //  ALU pipe: int; $33
        store.slm.d32.a32 (16|M0)  [r46:1]      r48:1              {I@4,$3} // ex_desc:0x0; desc:0x2000504 // $79
        store.slm.d32.a32 (16|M0)  [r51:1]      r50:1              {I@3,$4} // ex_desc:0x0; desc:0x2000504 // $81
        mov (16|M0)              r109.0<1>:f   r108.0<1;1,0>:f                  {Compacted}          //  ALU pipe: float; $28
        shl (1|M0)               r91.2<1>:d    r5.4<0;1,0>:d     1:w                                 //  ALU pipe: int; $32
        mov (1|M0)               r91.2<1>:q    r11.0<0;1,0>:ud                                       //  ALU pipe: int; $31
        shr (1|M0)               r91.1<1>:ud   r91.0<0;1,0>:ud   0x6:uw              {I@4}           //  ALU pipe: int; $30
        shl (1|M0)               r91.3<1>:q    r91.3<0;1,0>:q    1:w               {I@4}             //  ALU pipe: int; $34
        add (1|M0)               r109.6<1>:d   r108.6<0;1,0>:d   1:w               {F@1}             //  ALU pipe: int; $29
(W&~f1.1) jmpi                               BB_1                                                    //  ALU pipe: int; $83
// B003: Preds:{B002},  Succs:{B004}
_L_k21_0_:
        mul (16|M0)              acc0.0<1>:ud  r113.0<1;1,0>:ud  0x4:uw                              //  ALU pipe: int; $84
        mov (16|M0)              r6.0<1>:d     1920:w                               {Compacted}      //  ALU pipe: int; $87
        mov (16|M0)              r8.0<1>:d     120:w                               {Compacted}       //  ALU pipe: int; $91
        add (16|M0)              r3.0<1>:ud    acc0.0<1;1,0>:ud  0x800:uw                            //  ALU pipe: int; $85
        add (16|M0)              r7.0<1>:ud    acc0.0<1;1,0>:ud  0x840:uw                            //  ALU pipe: int; $89
        store.slm.d32.a32 (16|M0)  [r3:1]       r6:1               {I@2,$5} // ex_desc:0x0; desc:0x2000504 // $88
        store.slm.d32.a32 (16|M0)  [r7:1]       r8:1               {I@1,$6} // ex_desc:0x0; desc:0x2000504 // $92
// B004: Preds:{B003, B002},  Succs:{B005, B009}
BB_1:
        sync.nop                             null                             {Compacted,$5.src}     // $94
(W)     send.slm (1|M0)          r3       r71  null:0  0x0            0x0210001F           {$7} // wr:1+0, rd:1; fence.slm.none.group // $94
        mov (16|M0)              r6.0<1>:f     0x10100000:f                               {Compacted} //  (0x10100000:f); ALU pipe: float; $96
(W)     mov (8|M0)               null<1>:ud    r3.0<1;1,0>:ud                   {$7.dst}             //  memory fence commit; ALU pipe: int; $97
        send.gtwy (1|M0)         null     r6  null:0  0x0            0x02000004           {F@1,$8} // wr:1+0, rd:0; signal barrier // $97
(W)     sync.bar                             0:w                                                     // $98
        mov (1|M0)               r7.0<1>:d     2048:w                               {$6.src}         //  ALU pipe: int; $99
        mov (1|M0)               r8.0<1>:d     2112:w                                                //  ALU pipe: int; $101
        load.slm.d32x16t.a32 (1|M0)  r107:1     [r7:1]             {I@2,$9} // ex_desc:0x0; desc:0x210D500 // $100
        load.slm.d32x16t.a32 (1|M0)  r106:1     [r8:1]             {I@1,$10} // ex_desc:0x0; desc:0x210D500 // $102
        cmp (1|M0)    (lt)f1.0   null<1>:ud    r91.0<0;1,0>:ud   0x40:uw                             //  ALU pipe: int; $104
(W&f1.0) jmpi                                BB_2                                                    //  ALU pipe: int; $105
// B005: Preds:{B004},  Succs:{B006}
_L_k21_1_:
        mov (16|M0)              r110.0<1>:d   0:w                               {Compacted}         //  ALU pipe: int; $108
        mov (16|M0)              r116.0<1>:f   0.0:f                               {Compacted}       //  ALU pipe: float; $110
        sel (1|M0)    (ge)f0.0   r91.1<1>:ud   r91.1<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $106
        mov (1|M0)               r91.3<1>:d    0:w                                                   //  ALU pipe: int; $111
// B006: Preds:{B008, B005},  Succs:{B007, B008}
BB_3:
        shr (1|M0)               r3.0<1>:uq    r91.2<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $113
        mov (1|M0)               r108.7<1>:d   15:w                                                  //  ALU pipe: int; $118
        shl (1|M0)               r3.0<1>:uq    r3.0<0;1,0>:uq    0x3:uw              {I@2}           //  ALU pipe: int; $114
        mov (1|M0)               r109.7<1>:d   15:w                                                  //  ALU pipe: int; $121
        add (1|M0)               r3.0<1>:uq    r4.3<0;1,0>:uq    r3.0<0;1,0>:uq   {I@2}              //  ALU pipe: int; $115
        shr (1|M0)               r10.0<1>:uq   r91.3<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $124
        sync.allrd                           ($8,$9)                                                 // $117
        load.ugm.d64x16t.a64.ca.ca (1|M0)  r6:2 [r3:1]             {I@2,$11} // ex_desc:0x0; desc:0x228D780 // $117
        sync.nop                             null                             {$10.src}              // $120
        load_block2d.ugm.d32.a64.ca.ca (1|M0)  r8:1 [r108:1]       {$12} // ex_desc:0x0; desc:0x2180403 // $120
        shl (1|M0)               r10.0<1>:uq   r10.0<0;1,0>:uq   0x3:uw              {I@1}           //  ALU pipe: int; $125
        add (1|M0)               r10.0<1>:uq   r5.1<0;1,0>:uq    r10.0<0;1,0>:uq  {I@1}              //  ALU pipe: int; $126
        load_block2d.ugm.d32.a64.ca.ca (1|M0)  r9:1 [r109:1]       {$13} // ex_desc:0x0; desc:0x2180403 // $123
        load.ugm.d64x4t.a64.ca.ca (1|M0)  r11:1 [r10:1]            {I@1,$14} // ex_desc:0x0; desc:0x218B780 // $128
        add (1|M0)               r91.8<1>:d    r91.3<0;1,0>:d    1:w                                 //  ALU pipe: int; $133
        and (1|M0)    (eq)f0.1   r91.3<1>:d    r91.3<0;1,0>:d    1:w                                 //  ALU pipe: int; $134
        add (1|M0)               r108.6<1>:d   r108.6<0;1,0>:d   2:w               {$12.src}         //  ALU pipe: int; $131
        add (1|M0)               r109.6<1>:d   r109.6<0;1,0>:d   2:w               {$13.src}         //  ALU pipe: int; $132
(~f0.1) sel (1|M0)               r12.0<1>:d    r91.2<0;1,0>:d    0:w                                 //  ALU pipe: int; $136
        shr (16|M0)              acc2.0<1>:ud  r110.0<1;1,0>:ud  0x5:uw                              //  ALU pipe: int; $144
        add (16|M0)              acc0.0<1>:ud  acc2.0<1;1,0>:ud  r105.0<1;1,0>:ud {$2.dst}           //  ALU pipe: int; $145
        shl (16|M0)              r15.0<1>:ud   acc0.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $146
        mov (16|M0)              r16.0<2>:ud   r15.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $147
        add (16|M0)              r18.0<1>:q    r5.3<0;1,0>:q     r16.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $147
        load.ugm.d32x3.a64.ca.ca (16|M0)  r21:3 [r18:2]            {I@1,$15} // ex_desc:0x0; desc:0x4382580 // $149
        cbit (16|M0)             r14.0<1>:ud   r8.0<1;1,0>:ud                   {Compacted,$12.dst}  //  ALU pipe: int; $139
        and (16|M0)   (eq)f3.0   r25.0<2>:w    r110.0<2;1,0>:w   31:w                                //  ALU pipe: int; $152
        mov (16|M0)              r28.0<2>:w    -r110.0<2;1,0>:w                                      //  ALU pipe: int; $154
        add (16|M0)              r14.0<1>:ud   r14.0<1;1,0>:ud   r110.0<1;1,0>:ud {I@3}              //  ALU pipe: int; $140 R{} IR{}{E:7,E:7,},  {BC=1}
        mov (16|M0)              r29.0<1>:w    r28.0<2;1,0>:w                   {I@2}                //  ALU pipe: int; $154
        mov (16|M0)              r26.0<1>:w    r25.0<2;1,0>:w                                        //  ALU pipe: int; $152
        and (16|M0)   (eq)f2.1   r35.0<2>:w    r14.0<2;1,0>:w    31:w               {I@3}            //  ALU pipe: int; $165
        mov (16|M0)              r38.0<2>:w    -r14.0<2;1,0>:w                                       //  ALU pipe: int; $167
        mov (16|M0)              r30.0<1>:hf   r29.0<1;1,0>:hf                  {I@4}                //  ALU pipe: float; $154
        shl (16|M0)              r44.0<1>:ud   r8.0<1;1,0>:ud    0x7:uw              {Compacted}     //  ALU pipe: int; $177
        shr (16|M0)              r33.0<1>:ud   r14.0<1;1,0>:ud   0x5:uw              {Compacted}     //  ALU pipe: int; $161
        bfn.(s0&~s2|s1&s2) (16|M0)   acc0.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud    0x0:uw              {$15.dst} //  ALU pipe: int; $150
        bfn.(s0&~s2|s1&s2) (16|M0)   r24.0<1>:ud  r22.0<1;0>:ud  r23.0<1;0>:ud     0x0:uw              //  ALU pipe: int; $151
        mov (16|M0)              r27.0<1>:hf   r26.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $152
        mov (16|M0)              r39.0<1>:w    r38.0<2;1,0>:w                   {I@5}                //  ALU pipe: int; $167
        and (16|M0)              r30.0<1>:w    r30.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $155
        shl (16|M0)              r58.0<1>:ud   r8.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $188
        shr (16|M0)              r13.0<1>:ud   r8.0<1;1,0>:ud    0x1:uw              {Compacted}     //  ALU pipe: int; $138
        mov (16|M0)              r36.0<1>:w    r35.0<2;1,0>:w                                        //  ALU pipe: int; $165
        and (16|M0)              r45.0<1>:ud   r44.0<1;1,0>:ud   r107.0<1;1,0>:ud {@7,$9.dst}        //  ALU pipe: int; $178
        add (16|M0)              r34.0<1>:ud   acc2.0<1;1,0>:ud  -r33.0<1;1,0>:ud {I@7}              //  ALU pipe: int; $162
        shr (16|M0)              r32.0<1>:ud   acc0.0<1;1,0>:ud  r27.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $157
        mov (16|M0)              r40.0<1>:hf   r39.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $167
        shl (16|M0)              r24.0<1>:ud   r24.0<1;1,0>:ud   r30.0<1;1,0>:uw  {I@7}              //  ALU pipe: int; $158
        and (16|M0)              r59.0<1>:ud   r58.0<1;1,0>:ud   r107.0<1;1,0>:ud {Compacted,I@7}    //  ALU pipe: int; $189
        and (16|M0)              r64.0<1>:ud   r13.0<1;1,0>:ud   r107.0<1;1,0>:ud {Compacted,I@7}    //  ALU pipe: int; $199
        mov (16|M0)              r37.0<1>:hf   r36.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $165
        cbit (16|M0)             r45.0<1>:ud   r45.0<1;1,0>:ud                  {I@6}                //  ALU pipe: int; $186
        bfn.(s0&~s2|s1&s2) (16|M0)   acc0.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud    r34.0<1>:ud      {I@6} //  ALU pipe: int; $163
        and (16|M0)              r40.0<1>:w    r40.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $168
(~f3.0) or (16|M0)               r32.0<1>:ud   r24.0<1;1,0>:ud   r32.0<1;1,0>:ud  {I@6}              //  ALU pipe: int; $160
        bfn.(s0&~s2|s1&s2) (16|M0)   acc2.0<1>:ud  r22.0<1;0>:ud  r23.0<1;0>:ud    r34.0<1>:ud       //  ALU pipe: int; $164
        cbit (16|M0)             r59.0<1>:ud   r59.0<1;1,0>:ud                  {Compacted,I@7}      //  ALU pipe: int; $197
        cbit (16|M0)             r64.0<1>:ud   r64.0<1;1,0>:ud                  {Compacted,I@7}      //  ALU pipe: int; $207
        shr (16|M0)              r42.0<1>:ud   acc0.0<1;1,0>:ud  r37.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $170
        shl (16|M0)              r34.0<1>:ud   acc2.0<1;1,0>:ud  r40.0<1;1,0>:uw  {I@6}              //  ALU pipe: int; $171
        shr (16|M0)              acc0.0<1>:ud  r32.0<1;1,0>:ud   r45.0<1;1,0>:ud  {I@6}              //  ALU pipe: int; $187
        shl (16|M0)              r60.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $190
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r59.0<1;1,0>:ud  {I@6}              //  ALU pipe: int; $198
        shl (16|M0)              r66.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $200
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r64.0<1;1,0>:ud  {I@7}              //  ALU pipe: int; $208
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $209
        and (16|M0)              r70.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $210
        shl (16|M0)              r72.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $211
        cbit (16|M0)             r70.0<1>:ud   r70.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $218
        and (16|M0)              r72.0<1>:ud   r72.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,@2,$10.dst} //  ALU pipe: int; $212
        bfn.(s0&s1|s2) (16|M0)   r73.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r72.0<1>:ud      {I@1} //  ALU pipe: int; $213
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r70.0<1;1,0>:ud                     //  ALU pipe: int; $219
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $220
        and (16|M0)              r76.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $221
        shl (16|M0)              r78.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $222
        cbit (16|M0)             r76.0<1>:ud   r76.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $229
        and (16|M0)              r78.0<1>:ud   r78.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $223
        bfn.(s0&s1|s2) (16|M0)   r79.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r78.0<1>:ud      {I@1} //  ALU pipe: int; $224
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r76.0<1;1,0>:ud                     //  ALU pipe: int; $230
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $231
        and (16|M0)              r90.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $232
        shl (16|M0)              r92.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $233
        cbit (16|M0)             r90.0<1>:ud   r90.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $240
        and (16|M0)              r92.0<1>:ud   r92.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $234
        bfn.(s0&s1|s2) (16|M0)   r93.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r92.0<1>:ud      {I@1} //  ALU pipe: int; $235
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r90.0<1;1,0>:ud                     //  ALU pipe: int; $241
        shr (16|M0)              acc2.0<1>:ud  r8.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $242
        and (16|M0)              r96.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $243
        shl (16|M0)              r98.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $244
        cbit (16|M0)             r96.0<1>:ud   r96.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $252
        and (16|M0)              r98.0<1>:ud   r98.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $245
        bfn.(s0&s1|s2) (16|M0)   r99.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r98.0<1>:ud      {I@1} //  ALU pipe: int; $246
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r96.0<1;1,0>:ud                     //  ALU pipe: int; $253
        shl (16|M0)              r46.0<1>:ud   r32.0<1;1,0>:ud   0x3:uw              {$3.src}        //  ALU pipe: int; $179
        shl (16|M0)              r32.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $254
        sync.nop                             null                             {Compacted,$11.src}    // $261
        shl (16|M0)              r3.0<1>:ud    r9.0<1;1,0>:ud    0x7:uw              {Compacted,$13.dst} //  ALU pipe: int; $261
        shr (16|M0)              r8.0<1>:ud    r8.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $251
        and (16|M0)              r32.0<1>:ud   r32.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $255
        bfn.(s0&s1|s2) (16|M0)   r102.0<1>:ud  r8.0<1;0>:ud      r107.0<1;0>:ud    r32.0<1>:ud      {I@1} //  ALU pipe: int; $256
        and (16|M0)              r8.0<1>:ud    r3.0<1;1,0>:ud    r107.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $262
(~f2.1) or (16|M0)               r42.0<1>:ud   r34.0<1;1,0>:ud   r42.0<1;1,0>:ud                     //  ALU pipe: int; $173
        cbit (16|M0)             r8.0<1>:ud    r8.0<1;1,0>:ud                   {Compacted,I@2}      //  ALU pipe: int; $270
        shr (16|M0)              acc0.0<1>:ud  r42.0<1;1,0>:ud   r8.0<1;1,0>:ud   {I@1}              //  ALU pipe: int; $271
        shl (16|M0)              r24.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $273
        shl (16|M0)              r23.0<1>:ud   r9.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $272
        and (16|M0)              r24.0<1>:ud   r24.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $274
        bfn.(s0&s1|s2) (16|M0)   r25.0<1>:ud   r23.0<1;0>:ud     r107.0<1;0>:ud    r24.0<1>:ud      {I@1} //  ALU pipe: int; $275
        and (16|M0)              r23.0<1>:ud   r23.0<1;1,0>:ud   r107.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $276
        cbit (16|M0)             r23.0<1>:ud   r23.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $282
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x1:uw                              //  ALU pipe: int; $281
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r23.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $283
        shl (16|M0)              r28.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $284
        and (16|M0)              r30.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $287
        and (16|M0)              r28.0<1>:ud   r28.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $285
        cbit (16|M0)             r30.0<1>:ud   r30.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $292
        bfn.(s0&s1|s2) (16|M0)   r29.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r28.0<1>:ud      {I@2} //  ALU pipe: int; $286
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r30.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $293
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $294
        and (16|M0)              r66.0<1>:ud   r66.0<1;1,0>:ud   r106.0<1;1,0>:ud                    //  ALU pipe: int; $201
        shl (16|M0)              r34.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $295
        and (16|M0)              r36.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $298
        bfn.(s0&s1|s2) (16|M0)   r67.0<1>:ud   r13.0<1;0>:ud     r107.0<1;0>:ud    r66.0<1>:ud      {I@3} //  ALU pipe: int; $202
        and (16|M0)              r34.0<1>:ud   r34.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $296
        cbit (16|M0)             r36.0<1>:ud   r36.0<1;1,0>:ud                  {Compacted,I@3}      //  ALU pipe: int; $303
        and (16|M0)              r46.0<1>:ud   r46.0<1;1,0>:ud   r106.0<1;1,0>:ud                    //  ALU pipe: int; $180
        load.slm.d32x2.a32 (16|M0)  r68:2       [r67:1]            {I@4,$0} // ex_desc:0x0; desc:0x2201500 // $204
        bfn.(s0&s1|s2) (16|M0)   r35.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r34.0<1>:ud      {I@3} //  ALU pipe: int; $297
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r36.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $304
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $305
        bfn.(s0&s1|s2) (16|M0)   r47.0<1>:ud   r44.0<1;0>:ud     r107.0<1;0>:ud    r46.0<1>:ud      {I@4} //  ALU pipe: int; $181
        shl (16|M0)              r40.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $306
        and (16|M0)              r44.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud                    //  ALU pipe: int; $309
        and (16|M0)              r40.0<1>:ud   r40.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@2}    //  ALU pipe: int; $307
        cbit (16|M0)             r44.0<1>:ud   r44.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $314
        mov (16|M0)              r43.0<2>:uw   r11.0<1;1,0>:uw                  {$14.dst}            //  ALU pipe: int; $175
        bfn.(s0&s1|s2) (16|M0)   r41.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r40.0<1>:ud      {I@3} //  ALU pipe: int; $308
        mov (16|M0)              r43.1<2>:uw   r11.0<1;1,0>:uw                                       //  ALU pipe: int; $176
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r44.0<1;1,0>:ud  {I@4}              //  ALU pipe: int; $315
        load.slm.d32x2.a32 (16|M0)  r74:2       [r73:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $215
        shl (16|M0)              r66.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $316
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $318
        sync.nop                             null                             {Compacted,I@4}        // $205
        mul (32|M0)              r54.0<1>:hf   r43.0<1;1,0>:hf   r68.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $205
        and (16|M0)              r68.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud {F@1}              //  ALU pipe: int; $320
        and (16|M0)              r66.0<1>:ud   r66.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $317
        cbit (16|M0)             r68.0<1>:ud   r68.0<1;1,0>:ud                  {I@2}                //  ALU pipe: int; $325
        bfn.(s0&s1|s2) (16|M0)   r67.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r66.0<1>:ud      {I@2} //  ALU pipe: int; $319
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r68.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $326
        shl (16|M0)              r72.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $327
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $329
        mul (32|M0)              r56.0<1>:hf   r43.0<1;1,0>:hf   r74.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $216
        and (16|M0)              r74.0<1>:ud   acc2.0<1;1,0>:ud  r107.0<1;1,0>:ud {F@1}              //  ALU pipe: int; $331
        and (16|M0)              r72.0<1>:ud   r72.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@3}    //  ALU pipe: int; $328
        cbit (16|M0)             r74.0<1>:ud   r74.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $337
        bfn.(s0&s1|s2) (16|M0)   r73.0<1>:ud   acc2.0<1;0>:ud    r107.0<1;0>:ud    r72.0<1>:ud      {I@2} //  ALU pipe: int; $330
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r74.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $338
        shl (16|M0)              r10.0<1>:ud   r42.0<1;1,0>:ud   0x3:uw              {Compacted}     //  ALU pipe: int; $263
        shl (16|M0)              r42.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $339
        cbit (16|M0)             r111.0<1>:ud  r9.0<1;1,0>:ud                   {Compacted}          //  ALU pipe: int; $141
        and (16|M0)              r60.0<1>:ud   r60.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted}        //  ALU pipe: int; $191
        and (16|M0)              r10.0<1>:ud   r10.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@4}    //  ALU pipe: int; $264
        and (16|M0)              r42.0<1>:ud   r42.0<1;1,0>:ud   r106.0<1;1,0>:ud {Compacted,I@4}    //  ALU pipe: int; $340
        shr (16|M0)              r9.0<1>:ud    r9.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $336
        bfn.(s0&s1|s2) (16|M0)   r61.0<1>:ud   r58.0<1;0>:ud     r107.0<1;0>:ud    r60.0<1>:ud      {I@4} //  ALU pipe: int; $192
        bfn.(s0&s1|s2) (16|M0)   r11.0<1>:ud   r3.0<1;0>:ud      r107.0<1;0>:ud    r10.0<1>:ud      {I@4} //  ALU pipe: int; $265
        bfn.(s0&s1|s2) (16|M0)   r77.0<1>:ud   r9.0<1;0>:ud      r107.0<1;0>:ud    r42.0<1>:ud      {I@3} //  ALU pipe: int; $341
        load.slm.d32x2.a32 (16|M0)  r80:2       [r79:1]            {$5} // ex_desc:0x0; desc:0x2201500 // $226
        load.slm.d32x2.a32 (16|M0)  r94:2       [r93:1]            {$6} // ex_desc:0x0; desc:0x2201500 // $237
        load.slm.d32x2.a32 (16|M0)  r100:2      [r99:1]            {$7} // ex_desc:0x0; desc:0x2201500 // $248
        load.slm.d32x2.a32 (16|M0)  r103:2      [r102:1]           {$12} // ex_desc:0x0; desc:0x2201500 // $258
        load.slm.d32x2.a32 (16|M0)  r26:2       [r25:1]            {$13} // ex_desc:0x0; desc:0x2201500 // $278
        load.slm.d32x2.a32 (16|M0)  r31:2       [r29:1]            {$14} // ex_desc:0x0; desc:0x2201500 // $289
        load.slm.d32x2.a32 (16|M0)  r37:2       [r35:1]            {$15} // ex_desc:0x0; desc:0x2201500 // $300
        load.slm.d32x2.a32 (16|M0)  r48:2       [r47:1]            {$0} // ex_desc:0x0; desc:0x2201500 // $183
        load.slm.d32x2.a32 (16|M0)  r45:2       [r41:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $311
        load.slm.d32x2.a32 (16|M0)  r62:2       [r61:1]            {I@3,$2} // ex_desc:0x0; desc:0x2201500 // $194
        load.slm.d32x2.a32 (16|M0)  r78:2       [r77:1]            {I@1,$3} // ex_desc:0x0; desc:0x2201500 // $343
        mul (32|M0)              r55.0<1>:hf   r43.0<1;1,0>:hf   r69.0<1;1,0>:hf                     //  ALU pipe: float; $206
        load.slm.d32x2.a32 (16|M0)  r69:2       [r67:1]            {F@1,$4} // ex_desc:0x0; desc:0x2201500 // $322
        mul (32|M0)              r57.0<1>:hf   r43.0<1;1,0>:hf   r75.0<1;1,0>:hf                     //  ALU pipe: float; $217 R{} IR{}{O:5,O:5,},  {BC=1}
        load.slm.d32x2.a32 (16|M0)  r75:2       [r73:1]            {F@1,$8} // ex_desc:0x0; desc:0x2201500 // $333
        add (16|M0)              r111.0<1>:ud  r111.0<1;1,0>:ud  r14.0<1;1,0>:ud                     //  ALU pipe: int; $142
        load.slm.d32x2.a32 (16|M0)  r13:2       [r11:1]            {I@1,$9} // ex_desc:0x0; desc:0x2201500 // $267
        add (1|M0)               r91.2<1>:uq   r91.2<0;1,0>:uq   0x80:uw                             //  ALU pipe: int; $143
        mul (32|M0)              r82.0<1>:hf   r43.0<1;1,0>:hf   r80.0<1;1,0>:hf  {$5.dst}           //  ALU pipe: float; $227
        mul (32|M0)              r83.0<1>:hf   r43.0<1;1,0>:hf   r81.0<1;1,0>:hf                     //  ALU pipe: float; $228
        mul (32|M0)              r84.0<1>:hf   r43.0<1;1,0>:hf   r94.0<1;1,0>:hf  {$6.dst}           //  ALU pipe: float; $238
        mul (32|M0)              r85.0<1>:hf   r43.0<1;1,0>:hf   r95.0<1;1,0>:hf                     //  ALU pipe: float; $239
        mul (32|M0)              r86.0<1>:hf   r43.0<1;1,0>:hf   r100.0<1;1,0>:hf {$7.dst}           //  ALU pipe: float; $249
        mul (32|M0)              r87.0<1>:hf   r43.0<1;1,0>:hf   r101.0<1;1,0>:hf                    //  ALU pipe: float; $250
        mul (32|M0)              r88.0<1>:hf   r43.0<1;1,0>:hf   r103.0<1;1,0>:hf {$12.dst}          //  ALU pipe: float; $259
        mul (32|M0)              r89.0<1>:hf   r43.0<1;1,0>:hf   r104.0<1;1,0>:hf                    //  ALU pipe: float; $260
        mul (32|M0)              r17.0<1>:hf   r43.0<1;1,0>:hf   r26.0<1;1,0>:hf  {$13.dst}          //  ALU pipe: float; $279
        mul (32|M0)              r18.0<1>:hf   r43.0<1;1,0>:hf   r27.0<1;1,0>:hf                     //  ALU pipe: float; $280
        mul (32|M0)              r19.0<1>:hf   r43.0<1;1,0>:hf   r31.0<1;1,0>:hf  {$14.dst}          //  ALU pipe: float; $290
        mul (32|M0)              r20.0<1>:hf   r43.0<1;1,0>:hf   r32.0<1;1,0>:hf                     //  ALU pipe: float; $291
        mul (32|M0)              r21.0<1>:hf   r43.0<1;1,0>:hf   r37.0<1;1,0>:hf  {$15.dst}          //  ALU pipe: float; $301
        mul (32|M0)              r22.0<1>:hf   r43.0<1;1,0>:hf   r38.0<1;1,0>:hf                     //  ALU pipe: float; $302
        sync.nop                             null                             {$4.src}               // $184
        mul (32|M0)              r50.0<1>:hf   r43.0<1;1,0>:hf   r48.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $184
        mul (32|M0)              r51.0<1>:hf   r43.0<1;1,0>:hf   r49.0<1;1,0>:hf                     //  ALU pipe: float; $185
        mul (32|M0)              r58.0<1>:hf   r43.0<1;1,0>:hf   r45.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $312
        mul (32|M0)              r59.0<1>:hf   r43.0<1;1,0>:hf   r46.0<1;1,0>:hf                     //  ALU pipe: float; $313
        mul (32|M0)              r52.0<1>:hf   r43.0<1;1,0>:hf   r62.0<1;1,0>:hf  {$2.dst}           //  ALU pipe: float; $195
        mul (32|M0)              r53.0<1>:hf   r43.0<1;1,0>:hf   r63.0<1;1,0>:hf                     //  ALU pipe: float; $196
        mul (32|M0)              r64.0<1>:hf   r43.0<1;1,0>:hf   r78.0<1;1,0>:hf  {$3.dst}           //  ALU pipe: float; $344
        mul (32|M0)              r65.0<1>:hf   r43.0<1;1,0>:hf   r79.0<1;1,0>:hf                     //  ALU pipe: float; $345
        mul (32|M0)              r60.0<1>:hf   r43.0<1;1,0>:hf   r69.0<1;1,0>:hf  {$4.dst}           //  ALU pipe: float; $323
        mul (32|M0)              r61.0<1>:hf   r43.0<1;1,0>:hf   r70.0<1;1,0>:hf                     //  ALU pipe: float; $324
        mul (32|M0)              r15.0<1>:hf   r43.0<1;1,0>:hf   r13.0<1;1,0>:hf  {$9.dst}           //  ALU pipe: float; $268
        mul (32|M0)              r16.0<1>:hf   r43.0<1;1,0>:hf   r14.0<1;1,0>:hf                     //  ALU pipe: float; $269
        mul (32|M0)              r62.0<1>:hf   r43.0<1;1,0>:hf   r75.0<1;1,0>:hf  {$8.dst}           //  ALU pipe: float; $334
        mul (32|M0)              r63.0<1>:hf   r43.0<1;1,0>:hf   r76.0<1;1,0>:hf                     //  ALU pipe: float; $335
        sync.nop                             null                             {Compacted,F@7}        // $347
        sync.nop                             null                             {Compacted,$11.dst}    // $347
        dpas.8x1 (16|M0)         r116:f        r116:f            r50:hf            r6.0:hf          {Compacted,$5} // $347 R{} IR{}{E:2,E:1,E:3,},  R{r116,r6,} IR{} {BC=1}
        add (1|M0)               r91.3<1>:q    r91.3<0;1,0>:q    r12.0<0;1,0>:ud                     //  ALU pipe: int; $351
        dpas.8x1 (16|M0)         r116:f        r116:f            r82:hf            r6.16:hf         {Compacted,$5} // $348 R{} IR{}{E:2,E:1,E:3,},  R{r116,r6,} IR{} {BC=1}
        sync.nop                             null                             {Compacted,F@3}        // $349
        dpas.8x1 (16|M0)         r116:f        r116:f            r15:hf            r7.0:hf          {Compacted,$5} // $349
        sync.nop                             null                             {Compacted,F@1}        // $350
        dpas.8x1 (16|M0)         r116:f        r116:f            r58:hf            r7.16:hf         {Compacted,$5} // $350
        mov (1|M0)               null<1>:ud    r116.0<0;1,0>:w                  {$5.dst}             //  ALU pipe: int; $352
        cmp (1|M0)    (eq)f0.0   null<1>:d     r91.8<0;1,0>:d    r91.1<0;1,0>:d                      //  ALU pipe: int; $354
(W&~f0.0) jmpi                               BB_4                                                    //  ALU pipe: int; $355
// B007: Preds:{B006},  Succs:{B010}
_L_k21_2_:
        mov (16|M0)              r1.16<1>:hf   r116.0<1;1,0>:f                                       //  ALU pipe: float; $356
        mov (16|M0)              r112.0<1>:d   r1.16<1;1,0>:uw                  {F@1}                //  ALU pipe: int; $357
(W)     jmpi                                 BB_5                                                    // $358
// B008: Preds:{B006},  Succs:{B006}
BB_4:
        mov (16|M0)              r110.0<1>:f   r111.0<1;1,0>:f                                       //  ALU pipe: float; $361
        mov (1|M0)               r91.3<1>:d    r91.8<0;1,0>:d                                        //  ALU pipe: int; $360
(W)     jmpi                                 BB_3                                                    // $362
// B009: Preds:{B004},  Succs:{B010}
BB_2:
        mov (16|M0)              r112.0<1>:d   0:w                                                   //  ALU pipe: int; $365
// B010: Preds:{B009, B007},  Succs:{}
BB_5:
        add (1|M0)               r1.2<1>:d     r91.10<0;1,0>:d   1:w                                 //  ALU pipe: int; $367
        sel (1|M0)    (lt)f0.0   r1.2<1>:ud    r1.2<0;1,0>:ud    r4.0<0;1,0>:ud   {I@1}              //  ALU pipe: int; $368
(W)     mul (1|M0)               acc0.0<1>:d   r91.10<0;1,0>:d   r4.10<0;1,0>:uw                     //  ALU pipe: int; $370
        macl (1|M0)              r3.0<1>:d     r91.10<0;1,0>:d   r4.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $371
        mul (16|M0)              r113.0<1>:ud  r113.0<1;1,0>:ud  0x2:uw              {Compacted}     //  ALU pipe: int; $373
        add (1|M0)               r91.11<1>:d   r91.11<0;1,0>:d   r3.0<0;1,0>:d    {I@2}              //  ALU pipe: int; $371
        cmp (16|M0)   (lt)f2.0   null<1>:d     r91.10<0;1,0>:ud  r1.2<0;1,0>:ud                      //  ALU pipe: int; $376
        shl (1|M0)               r91.11<1>:d   r91.11<0;1,0>:d   1:w               {I@2}             //  ALU pipe: int; $372
(W)     mov (16|M0)              r127.0<1>:f   r71.0<1;1,0>:f                   {Compacted}          //  ALU pipe: float; $380
        add (16|M0)              r113.0<1>:ud  r91.11<0;1,0>:ud  r113.0<1;1,0>:ud {Compacted,I@1}    //  ALU pipe: int; $374
(f2.0)  cmp (16|M0)   (lt)f2.0   null<1>:d     r97.0<1;1,0>:ud   r91.9<0;1,0>:ud                     //  ALU pipe: int; $377
        sync.nop                             null                             {Compacted,$9.src}     // $375
        mov (16|M0)              r6.0<2>:ud    r113.0<1;1,0>:ud                 {Compacted,@2,$8.src} //  ALU pipe: int; $375
        add (16|M0)              r8.0<1>:q     r4.5<0;1,0>:q     r6.0<2;1,0>:ud   {@1,$10.src}       //  ALU pipe: int; $375
(f2.0)  store.ugm.d16u32.a64.st.wb (16|M0)  [r8:2] r112:1          {I@1,$6} // ex_desc:0x0; desc:0x40C0B84 // $379
(W)     send.gtwy (1|M0)         null     r127  null:0  0x0            0x02000010           {EOT,F@1,$7} // wr:1+0, rd:0; end of thread // $380


//.BankConflicts: 7
//.ByteRMWs: 0
//


//.numALUInst: 339
//.accSubDef: 34
//.accSubUse: 57
//.accSubCandidateDef: 36
//.accSubCandidateUse: 60
//
//
//.singlePipeAtOneDistNum: 39
//.allAtOneDistNum: 6
//.syncInstCount: 12
//.tokenReuseCount: 5
//.AfterWriteTokenDepCount: 28
//.AfterReadTokenDepCount: 14
