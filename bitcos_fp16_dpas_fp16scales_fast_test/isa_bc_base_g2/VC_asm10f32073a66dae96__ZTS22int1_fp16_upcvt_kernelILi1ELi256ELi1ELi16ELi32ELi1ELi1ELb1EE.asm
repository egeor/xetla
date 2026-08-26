//.kernel _ZTS22int1_fp16_upcvt_kernelILi1ELi256ELi1ELi16ELi32ELi1ELi1ELb1EE
//.platform XE2
//.thread_config numGRF=128, numAcc=4, numSWSB=16
//.options_string "-enablePreemptionR0Only -enableHalfLSC -dumpcommonisa -output -binary -abiver 2 -samplerHeaderWA "
//.full_options "-samplerHeaderWA -enablePreemptionR0Only -abiver 2 -output -binary -dumpcommonisa -enableHalfLSC "
//.instCount 274
//.RA type	LOCAL_ROUND_ROBIN_BC_RA
//.git-hash cd6c33fbee6ccc897657c64b11eae6917cc8ff5e

//.declare BuiltInR0 (0)  rf=r size=64 type=ud align=32 words (r0.0) IsBuiltin
//.declare  (1)  rf=r size=64 type=ud align=32 words (r57.0) IsBuiltin
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
//.declare V58 (66)  rf=r size=8 type=uq align=4 words (r5.1)
//.declare V59 (67)  rf=r size=8 type=uq align=4 words (r5.3)
//.declare V61 (69)  rf=r size=8 type=d align=2 words (r1.2)
//.declare V62 (70)  rf=r size=12 type=d align=2 words (r2.3)
//.declare V63 (71)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V64 (72)  rf=r size=12 type=d align=2 words (r4.12)
//.declare V65 (73)  rf=r size=4 type=d align=2 words (r5.0)
//.declare V66 (74)  rf=r size=4 type=d align=2 words (r63.0)
//.declare V67 (75)  rf=r size=4 type=d align=2 words (r63.1)
//.declare V68 (76)  rf=r size=4 type=d align=32 words (r7.0)
//.declare V69 (77)  rf=r size=4 type=d align=2 words (r63.2)
//.declare V70 (78)  rf=r size=4 type=d align=2 words (r63.3)
//.declare V71 (79)  rf=r size=64 type=d align=32 words (r69.0)
//.declare V72 (80)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V73 (81)  rf=r size=8 type=uq align=4 words (r5.4)
//.declare V74 (82)  rf=r size=128 type=q align=32 words (r12.0)
//.declare V75 (83)  rf=r size=64 type=d align=32 words (r83.0)
//.declare V76 (84)  rf=r size=4 type=d align=2 words (r6.0)
//.declare V77 (85)  rf=r size=64 type=w align=32 words (r14.0)
//.declare V78 (86)  rf=r size=32 type=w align=2 words (r17.0)
//.declare V79 (87)  rf=r size=32 type=w align=2 words (r20.0)
//.declare V80 (88)  rf=r size=32 type=w align=2 words (r23.0)
//.declare V81 (89)  rf=r size=32 type=w align=2 words (r26.0)
//.declare V82 (90)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V83 (91)  rf=r size=64 type=d align=32 words (r32.0)
//.declare V84 (92)  rf=r size=32 type=w align=8 words (r33.0)
//.declare V85 (93)  rf=r size=64 type=w align=32 words (r27.0)
//.declare V86 (94)  rf=r size=32 type=w align=2 words (r36.0)
//.declare V87 (95)  rf=r size=64 type=d align=32 words (r37.0)
//.declare V88 (96)  rf=r size=64 type=d align=32 words (r38.0)
//.declare V89 (97)  rf=r size=64 type=w align=32 words (r28.0)
//.declare V90 (98)  rf=r size=32 type=w align=2 words (r41.0)
//.declare V91 (99)  rf=r size=64 type=d align=32 words (r42.0)
//.declare V92 (100)  rf=r size=64 type=d align=32 words (r43.0)
//.declare V93 (101)  rf=r size=64 type=d align=32 words (r44.0)
//.declare V94 (102)  rf=r size=64 type=d align=32 words (r45.0)
//.declare V95 (103)  rf=r size=64 type=d align=32 words (r46.0)
//.declare V96 (104)  rf=r size=64 type=d align=32 words (r47.0)
//.declare P1 (105)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V98 (107)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V100 (109)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V101 (110)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V103 (112)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V105 (114)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V106 (115)  rf=r size=4 type=d align=32 words (r7.0)
//.declare V107 (116)  rf=r size=64 type=d align=32 words (r89.0)
//.declare V108 (117)  rf=r size=4 type=d align=32 words (r8.0)
//.declare V109 (118)  rf=r size=64 type=d align=32 words (r97.0)
//.declare P2 (119)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare V112 (122)  rf=r size=4 type=d align=2 words (r63.4)
//.declare V113 (123)  rf=r size=8 type=q align=4 words (r63.3)
//.declare V114 (124)  rf=r size=8 type=q align=4 words (r63.4)
//.declare V115 (125)  rf=r size=8 type=q align=4 words (r63.5)
//.declare V116 (126)  rf=r size=64 type=d align=32 words (r98.0)
//.declare V117 (127)  rf=r size=64 type=f align=32 words (r100.0)
//.declare V118 (128)  rf=r size=8 type=q align=32 words (r3.0)
//.declare V119 (129)  rf=r size=8 type=q align=32 words (r8.0)
//.declare V120 (130)  rf=r size=8 type=q align=32 words (r10.0)
//.declare V121 (131)  rf=r size=32 type=hf align=32 words (r11.0)
//.declare P3 (133)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare V123 (134)  rf=r size=4 type=d align=2 words (r12.0)
//.declare V125 (136)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V126 (137)  rf=r size=64 type=d align=32 words (r14.0)
//.declare V127 (138)  rf=r size=128 type=q align=32 words (r17.0)
//.declare V128 (139)  rf=r size=192 type=d align=32 words (r20.0)
//.declare V129 (140)  rf=r size=32 type=w align=2 words (r26.0)
//.declare V131 (142)  rf=r size=32 type=w align=2 words (r29.0)
//.declare V133 (144)  rf=r size=64 type=d align=32 words (r23.0)
//.declare P4 (145)  rf=f16  size=2 type=uw align=1 words (f2.1)
//.declare V134 (146)  rf=r size=64 type=hf align=32 words (r31.0)
//.declare V135 (147)  rf=r size=64 type=d align=32 words (r32.0)
//.declare V136 (148)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V137 (149)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V138 (150)  rf=r size=128 type=hf align=32 words (r36.0)
//.declare V139 (151)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V140 (152)  rf=r size=64 type=d align=32 words (r50.0)
//.declare V141 (153)  rf=r size=64 type=d align=32 words (r52.0)
//.declare V142 (154)  rf=r size=64 type=d align=32 words (r53.0)
//.declare V143 (155)  rf=r size=128 type=hf align=32 words (r54.0)
//.declare V144 (156)  rf=r size=64 type=d align=32 words (r51.0)
//.declare V145 (157)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V146 (158)  rf=r size=64 type=d align=32 words (r59.0)
//.declare V147 (159)  rf=r size=128 type=hf align=32 words (r60.0)
//.declare V148 (160)  rf=r size=64 type=d align=32 words (r56.0)
//.declare V150 (162)  rf=r size=64 type=d align=32 words (r64.0)
//.declare V151 (163)  rf=r size=64 type=d align=32 words (r65.0)
//.declare V152 (164)  rf=r size=128 type=hf align=32 words (r66.0)
//.declare V153 (165)  rf=r size=512 type=d align=32 words (r42.0)
//.declare V154 (166)  rf=r size=64 type=d align=32 words (r62.0)
//.declare V156 (168)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V157 (169)  rf=r size=64 type=d align=32 words (r71.0)
//.declare V158 (170)  rf=r size=128 type=hf align=32 words (r72.0)
//.declare V159 (171)  rf=r size=64 type=d align=32 words (r68.0)
//.declare V161 (173)  rf=r size=64 type=d align=32 words (r84.0)
//.declare V162 (174)  rf=r size=64 type=d align=32 words (r85.0)
//.declare V163 (175)  rf=r size=128 type=hf align=32 words (r86.0)
//.declare V164 (176)  rf=r size=64 type=d align=32 words (r82.0)
//.declare V166 (178)  rf=r size=64 type=d align=32 words (r90.0)
//.declare V167 (179)  rf=r size=64 type=d align=32 words (r91.0)
//.declare V168 (180)  rf=r size=128 type=hf align=32 words (r92.0)
//.declare V169 (181)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V170 (182)  rf=r size=64 type=d align=32 words (r88.0)
//.declare V171 (183)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V172 (184)  rf=r size=64 type=d align=32 words (r94.0)
//.declare V173 (185)  rf=r size=128 type=hf align=32 words (r95.0)
//.declare V174 (186)  rf=r size=512 type=d align=32 words (r74.0)
//.declare V175 (187)  rf=r size=64 type=d align=32 words (r7.0)
//.declare P5 (188)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare V176 (189)  rf=r size=32 type=w align=16 words (r1.16)
//.declare V178 (191)  rf=r size=64 type=d align=32 words (r99.0)
//.declare V179 (192)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V180 (193)  rf=r size=4 type=d align=2 words (r63.5)
//.declare V181 (194)  rf=r size=4 type=d align=2 words (r63.12)
//.declare V182 (195)  rf=r size=4 type=d align=2 words (r1.2)
//.declare V183 (196)  rf=r size=4 type=d align=2 words (r63.13)
//.declare V184 (197)  rf=r size=64 type=d align=32 words (r101.0)
//.declare V185 (198)  rf=r size=8 type=uq align=4 words (r4.5)
//.declare V186 (199)  rf=r size=128 type=q align=32 words (r8.0)
//.declare P6 (200)  rf=f16  size=2 type=uw align=1 words (f3.1)
//.declare P7 (201)  rf=f16  size=2 type=uw align=1 words (f3.0)
//.declare P8 (202)  rf=f16  size=2 type=uw align=1 words (f2.0)
//.declare V187 (203)  rf=r size=6 type=uw alias=V33+0 align=1 words (r1.0)
//.declare V188 (204)  rf=r size=8 type=d alias=V61+0 align=2 words (r1.2)
//.declare V190 (206)  rf=r size=12 type=d alias=V34+0 align=2 words (r2.0)
//.declare V191 (207)  rf=r size=12 type=d alias=V62+0 align=2 words (r2.3)
//.declare V192 (208)  rf=r size=4 type=d alias=V63+0 align=2 words (r3.0)
//.declare V193 (209)  rf=r size=12 type=d alias=V64+0 align=2 words (r4.12)
//.declare V194 (210)  rf=r size=4 type=d alias=V65+0 align=2 words (r5.0)
//.declare V195 (211)  rf=r size=4 type=d alias=V180+0 align=2 words (r63.5)
//.declare V196 (212)  rf=r size=4 type=d alias=V66+0 align=2 words (r63.0)
//.declare V197 (213)  rf=r size=4 type=d alias=V37+0 align=2 words (r4.1)
//.declare V198 (214)  rf=r size=4 type=ud alias=V67+0 align=2 words (r63.1)
//.declare V199 (215)  rf=r size=4 type=ud alias=V66+0 align=2 words (r63.0)
//.declare V200 (216)  rf=r size=4 type=d alias=V76+0 align=2 words (r6.0)
//.declare V201 (217)  rf=r size=4 type=d alias=V183+0 align=2 words (r63.13)
//.declare V202 (218)  rf=r size=4 type=d alias=V68+0 align=2 words (r7.0)
//.declare V203 (219)  rf=r size=4 type=d alias=V39+0 align=2 words (r4.3)
//.declare V204 (220)  rf=r size=4 type=d alias=V181+0 align=2 words (r63.12)
//.declare V205 (221)  rf=r size=4 type=ud alias=V68+0 align=2 words (r7.0)
//.declare V206 (222)  rf=r size=4 type=d alias=V69+0 align=2 words (r63.2)
//.declare V207 (223)  rf=r size=4 type=d alias=V40+0 align=2 words (r4.4)
//.declare V208 (224)  rf=r size=4 type=ud alias=V183+0 align=2 words (r63.13)
//.declare V209 (225)  rf=r size=8 type=q alias=V114+0 align=4 words (r63.4)
//.declare V210 (226)  rf=r size=8 type=q alias=V115+0 align=4 words (r63.5)
//.declare V211 (227)  rf=r size=4 type=d alias=V70+0 align=2 words (r63.3)
//.declare V212 (228)  rf=r size=4 type=d alias=V52+0 align=2 words (r5.4)
//.declare V213 (229)  rf=r size=64 type=d alias=V184+0 align=32 words (r101.0)
//.declare V214 (230)  rf=r size=64 type=d alias=V71+0 align=32 words (r69.0)
//.declare V215 (231)  rf=r size=64 type=d alias=V72+0 align=32 words (r9.0)
//.declare V216 (232)  rf=r size=128 type=q alias=V74+0 align=32 words (r12.0)
//.declare V217 (233)  rf=r size=8 type=q alias=V73+0 align=4 words (r5.4)
//.declare V218 (234)  rf=r size=64 type=ud alias=V72+0 align=32 words (r9.0)
//.declare V219 (235)  rf=r size=128 type=uq alias=V74+0 align=32 words (r12.0)
//.declare V220 (236)  rf=r size=64 type=d alias=V77+0 align=32 words (r14.0)
//.declare V221 (237)  rf=r size=32 type=uw alias=V78+0 align=1 words (r17.0)
//.declare V222 (238)  rf=r size=64 type=uw alias=V77+0 align=32 words (r14.0)
//.declare V223 (239)  rf=r size=32 type=uw alias=V79+0 align=1 words (r20.0)
//.declare V224 (240)  rf=r size=32 type=uw alias=V80+0 align=1 words (r23.0)
//.declare V225 (241)  rf=r size=32 type=uw alias=V81+0 align=1 words (r26.0)
//.declare V226 (242)  rf=r size=64 type=d alias=V85+0 align=32 words (r27.0)
//.declare V227 (243)  rf=r size=64 type=d alias=V89+0 align=32 words (r28.0)
//.declare V228 (244)  rf=r size=64 type=d alias=V83+0 align=32 words (r32.0)
//.declare V229 (245)  rf=r size=32 type=uw alias=V84+0 align=1 words (r33.0)
//.declare V230 (246)  rf=r size=64 type=d alias=V92+0 align=32 words (r43.0)
//.declare V231 (247)  rf=r size=64 type=ud alias=V85+0 align=32 words (r27.0)
//.declare V232 (248)  rf=r size=64 type=ud alias=V184+0 align=32 words (r101.0)
//.declare V233 (249)  rf=r size=32 type=w alias=V86+0 align=1 words (r36.0)
//.declare V234 (250)  rf=r size=64 type=w alias=V85+0 align=32 words (r27.0)
//.declare V235 (251)  rf=r size=32 type=uw alias=V86+0 align=1 words (r36.0)
//.declare V236 (252)  rf=r size=64 type=ud alias=V89+0 align=32 words (r28.0)
//.declare V237 (253)  rf=r size=32 type=w alias=V90+0 align=1 words (r41.0)
//.declare V238 (254)  rf=r size=64 type=w alias=V89+0 align=32 words (r28.0)
//.declare V239 (255)  rf=r size=64 type=d alias=V94+0 align=32 words (r45.0)
//.declare V240 (256)  rf=r size=32 type=uw alias=V90+0 align=1 words (r41.0)
//.declare V241 (257)  rf=r size=64 type=d alias=V91+0 align=32 words (r42.0)
//.declare V242 (258)  rf=r size=64 type=ud alias=V93+0 align=32 words (r44.0)
//.declare V243 (259)  rf=r size=64 type=ud alias=V92+0 align=32 words (r43.0)
//.declare V244 (260)  rf=r size=64 type=ud alias=V82+0 align=32 words (r29.0)
//.declare V245 (261)  rf=r size=64 type=ud alias=V83+0 align=32 words (r32.0)
//.declare V246 (262)  rf=r size=64 type=ud alias=V95+0 align=32 words (r46.0)
//.declare V247 (263)  rf=r size=64 type=ud alias=V94+0 align=32 words (r45.0)
//.declare V248 (264)  rf=r size=64 type=ud alias=V87+0 align=32 words (r37.0)
//.declare V249 (265)  rf=r size=64 type=ud alias=V88+0 align=32 words (r38.0)
//.declare V250 (266)  rf=r size=64 type=ud alias=V91+0 align=32 words (r42.0)
//.declare V251 (267)  rf=r size=64 type=ud alias=V96+0 align=32 words (r47.0)
//.declare V253 (269)  rf=r size=64 type=ud alias=V98+0 align=32 words (r3.0)
//.declare V254 (270)  rf=r size=64 type=ud alias=V101+0 align=32 words (r7.0)
//.declare  (271)  rf=r size=64 type=ud align=32 words (r3.0)
//.declare V255 (272)  rf=r size=4 type=ud alias=V106+0 align=2 words (r7.0)
//.declare V256 (273)  rf=r size=4 type=ud alias=V108+0 align=2 words (r8.0)
//.declare V257 (274)  rf=r size=8 type=uq alias=V118+0 align=4 words (r3.0)
//.declare V258 (275)  rf=r size=8 type=uq alias=V113+0 align=4 words (r63.3)
//.declare V259 (276)  rf=r size=8 type=uq alias=V56+0 align=4 words (r4.3)
//.declare V260 (277)  rf=r size=64 type=q alias=V175+0 align=32 words (r7.0)
//.declare V261 (278)  rf=r size=8 type=uq alias=V119+0 align=4 words (r8.0)
//.declare V262 (279)  rf=r size=8 type=uq alias=V114+0 align=4 words (r63.4)
//.declare V263 (280)  rf=r size=8 type=uq alias=V57+0 align=4 words (r4.4)
//.declare V264 (281)  rf=r size=64 type=q alias=V169+0 align=32 words (r9.0)
//.declare V265 (282)  rf=r size=8 type=uq alias=V120+0 align=4 words (r10.0)
//.declare V266 (283)  rf=r size=8 type=uq alias=V115+0 align=4 words (r63.5)
//.declare V267 (284)  rf=r size=8 type=uq alias=V58+0 align=4 words (r5.1)
//.declare V268 (285)  rf=r size=32 type=q alias=V121+0 align=4 words (r11.0)
//.declare V269 (286)  rf=r size=4 type=d alias=V112+0 align=2 words (r63.4)
//.declare V272 (289)  rf=r size=64 type=ud alias=V169+0 align=32 words (r9.0)
//.declare V273 (290)  rf=r size=64 type=ud alias=V125+0 align=32 words (r13.0)
//.declare V274 (291)  rf=r size=64 type=ud alias=V126+0 align=32 words (r14.0)
//.declare V275 (292)  rf=r size=64 type=ud alias=V116+0 align=32 words (r98.0)
//.declare V276 (293)  rf=r size=64 type=ud alias=V75+0 align=32 words (r83.0)
//.declare V277 (294)  rf=r size=128 type=q alias=V127+0 align=32 words (r17.0)
//.declare V278 (295)  rf=r size=8 type=q alias=V59+0 align=4 words (r5.3)
//.declare V279 (296)  rf=r size=128 type=uq alias=V127+0 align=32 words (r17.0)
//.declare V280 (297)  rf=r size=64 type=ud alias=V171+0 align=32 words (r30.0)
//.declare V281 (298)  rf=r size=192 type=ud alias=V128+0 align=32 words (r20.0)
//.declare V282 (299)  rf=r size=64 type=ud alias=V133+0 align=32 words (r23.0)
//.declare V283 (300)  rf=r size=32 type=w alias=V129+0 align=1 words (r26.0)
//.declare V284 (301)  rf=r size=64 type=w alias=V116+0 align=32 words (r98.0)
//.declare V285 (302)  rf=r size=32 type=uw alias=V129+0 align=1 words (r26.0)
//.declare V286 (303)  rf=r size=32 type=w alias=V131+0 align=1 words (r29.0)
//.declare V287 (304)  rf=r size=32 type=uw alias=V131+0 align=1 words (r29.0)
//.declare V290 (307)  rf=r size=64 type=ud alias=V135+0 align=32 words (r32.0)
//.declare V291 (308)  rf=r size=64 type=ud alias=V139+0 align=32 words (r33.0)
//.declare V292 (309)  rf=r size=64 type=ud alias=V107+0 align=32 words (r89.0)
//.declare V293 (310)  rf=r size=64 type=ud alias=V136+0 align=32 words (r34.0)
//.declare V294 (311)  rf=r size=64 type=ud alias=V109+0 align=32 words (r97.0)
//.declare V295 (312)  rf=r size=64 type=ud alias=V137+0 align=32 words (r35.0)
//.declare V296 (313)  rf=r size=128 type=d alias=V138+0 align=32 words (r36.0)
//.declare V297 (314)  rf=r size=512 type=hf alias=V153+0 align=32 words (r42.0)
//.declare V298 (315)  rf=r size=64 type=hf alias=V134+0 align=32 words (r31.0)
//.declare V299 (316)  rf=r size=128 type=hf alias=V138+0 align=32 words (r36.0)
//.declare V300 (317)  rf=r size=64 type=ud alias=V140+0 align=32 words (r50.0)
//.declare V301 (318)  rf=r size=64 type=ud alias=V144+0 align=32 words (r51.0)
//.declare V302 (319)  rf=r size=64 type=ud alias=V141+0 align=32 words (r52.0)
//.declare V303 (320)  rf=r size=64 type=ud alias=V142+0 align=32 words (r53.0)
//.declare V304 (321)  rf=r size=128 type=d alias=V143+0 align=32 words (r54.0)
//.declare V305 (322)  rf=r size=128 type=hf alias=V143+0 align=32 words (r54.0)
//.declare V306 (323)  rf=r size=64 type=ud alias=V148+0 align=32 words (r56.0)
//.declare V307 (324)  rf=r size=64 type=ud alias=V145+0 align=32 words (r58.0)
//.declare V308 (325)  rf=r size=64 type=ud alias=V146+0 align=32 words (r59.0)
//.declare V309 (326)  rf=r size=128 type=d alias=V147+0 align=32 words (r60.0)
//.declare V310 (327)  rf=r size=128 type=hf alias=V147+0 align=32 words (r60.0)
//.declare V312 (329)  rf=r size=64 type=ud alias=V154+0 align=32 words (r62.0)
//.declare V313 (330)  rf=r size=64 type=ud alias=V150+0 align=32 words (r64.0)
//.declare V314 (331)  rf=r size=64 type=ud alias=V151+0 align=32 words (r65.0)
//.declare V315 (332)  rf=r size=128 type=d alias=V152+0 align=32 words (r66.0)
//.declare V316 (333)  rf=r size=128 type=hf alias=V152+0 align=32 words (r66.0)
//.declare V318 (335)  rf=r size=64 type=ud alias=V159+0 align=32 words (r68.0)
//.declare V319 (336)  rf=r size=64 type=ud alias=V156+0 align=32 words (r70.0)
//.declare V320 (337)  rf=r size=64 type=ud alias=V157+0 align=32 words (r71.0)
//.declare V321 (338)  rf=r size=128 type=d alias=V158+0 align=32 words (r72.0)
//.declare V322 (339)  rf=r size=512 type=hf alias=V174+0 align=32 words (r74.0)
//.declare V323 (340)  rf=r size=128 type=hf alias=V158+0 align=32 words (r72.0)
//.declare V325 (342)  rf=r size=64 type=ud alias=V164+0 align=32 words (r82.0)
//.declare V326 (343)  rf=r size=64 type=ud alias=V161+0 align=32 words (r84.0)
//.declare V327 (344)  rf=r size=64 type=ud alias=V162+0 align=32 words (r85.0)
//.declare V328 (345)  rf=r size=128 type=d alias=V163+0 align=32 words (r86.0)
//.declare V329 (346)  rf=r size=128 type=hf alias=V163+0 align=32 words (r86.0)
//.declare V331 (348)  rf=r size=64 type=ud alias=V170+0 align=32 words (r88.0)
//.declare V332 (349)  rf=r size=64 type=ud alias=V166+0 align=32 words (r90.0)
//.declare V333 (350)  rf=r size=64 type=ud alias=V167+0 align=32 words (r91.0)
//.declare V334 (351)  rf=r size=128 type=d alias=V168+0 align=32 words (r92.0)
//.declare V335 (352)  rf=r size=128 type=hf alias=V168+0 align=32 words (r92.0)
//.declare V336 (353)  rf=r size=64 type=ud alias=V172+0 align=32 words (r94.0)
//.declare V337 (354)  rf=r size=128 type=d alias=V173+0 align=32 words (r95.0)
//.declare V338 (355)  rf=r size=128 type=hf alias=V173+0 align=32 words (r95.0)
//.declare V339 (356)  rf=r size=4 type=ud alias=V69+0 align=2 words (r63.2)
//.declare V340 (357)  rf=r size=4 type=ud alias=V123+0 align=2 words (r12.0)
//.declare V341 (358)  rf=r size=64 type=f alias=V117+0 align=32 words (r100.0)
//.declare V342 (359)  rf=r size=64 type=w alias=V117+0 align=32 words (r100.0)
//.declare V343 (360)  rf=r size=4 type=d alias=V67+0 align=2 words (r63.1)
//.declare V344 (361)  rf=r size=32 type=hf alias=V176+0 align=1 words (r1.16)
//.declare V345 (362)  rf=r size=32 type=uw alias=V176+0 align=1 words (r1.16)
//.declare V346 (363)  rf=r size=4 type=d alias=V182+0 align=2 words (r1.2)
//.declare V347 (364)  rf=r size=4 type=ud alias=V182+0 align=2 words (r1.2)
//.declare V348 (365)  rf=r size=4 type=ud alias=V36+0 align=2 words (r4.0)
//.declare V349 (366)  rf=r size=4 type=ud alias=V180+0 align=2 words (r63.5)
//.declare V350 (367)  rf=r size=4 type=ud alias=V38+0 align=2 words (r4.2)
//.declare V351 (368)  rf=r size=4 type=d alias=V179+0 align=2 words (r3.0)
//.declare V352 (369)  rf=r size=4 type=d alias=V41+0 align=2 words (r4.5)
//.declare V353 (370)  rf=r size=128 type=q alias=V186+0 align=32 words (r8.0)
//.declare V354 (371)  rf=r size=8 type=q alias=V185+0 align=4 words (r4.5)
//.declare V355 (372)  rf=r size=4 type=ud alias=V181+0 align=2 words (r63.12)
//.declare V356 (373)  rf=r size=64 type=ud alias=V71+0 align=32 words (r69.0)
//.declare V357 (374)  rf=r size=128 type=uq alias=V186+0 align=32 words (r8.0)
//.declare  (375)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (376)  rf=r size=16 type=w align=16 words (r8.0)
//.declare  (377)  rf=r size=16 type=w align=16 words (r30.0)
//.declare  (379)  rf=r size=128 type=ud align=32 words (r10.0)
//.declare  (380)  rf=r size=64 type=uw align=32 words (r15.0)
//.declare  (381)  rf=r size=32 type=uw align=32 words (r16.0)
//.declare  (382)  rf=r size=64 type=uw align=32 words (r18.0)
//.declare  (383)  rf=r size=32 type=uw align=32 words (r19.0)
//.declare  (384)  rf=r size=64 type=uw align=32 words (r21.0)
//.declare  (385)  rf=r size=32 type=uw align=32 words (r22.0)
//.declare  (386)  rf=r size=64 type=uw align=32 words (r24.0)
//.declare  (387)  rf=r size=32 type=uw align=32 words (r25.0)
//.declare  (388)  rf=r size=64 type=w align=32 words (r34.0)
//.declare  (389)  rf=r size=32 type=w align=32 words (r35.0)
//.declare  (390)  rf=r size=64 type=w align=32 words (r39.0)
//.declare  (391)  rf=r size=32 type=w align=32 words (r40.0)
//.declare  (392)  rf=r size=128 type=ud align=32 words (r15.0)
//.declare  (393)  rf=r size=64 type=w align=32 words (r24.0)
//.declare  (394)  rf=r size=32 type=w align=32 words (r25.0)
//.declare  (395)  rf=r size=64 type=w align=32 words (r27.0)
//.declare  (396)  rf=r size=32 type=w align=32 words (r28.0)
//.declare  (397)  rf=r size=128 type=ud align=32 words (r6.0)
//.declare r0 (398)  rf=r size=64 type=ud align=32 words (r0.0)
//.declare rtmp (399)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (400)  rf=r size=64 type=ud align=32 words (r1.0)
//.declare  (401)  rf=r size=256 type=ud align=32 words (r2.0)

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
// | V185     | :uq      |    0x8 | r4+0x28  | cti+0xA8         |
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
// | V58      | :uq      |    0x8 | r5+0x8   | cti+0xC8         |
// | V52      | :d       |    0x4 | r5+0x10  | cti+0xD0         |
// | V59      | :uq      |    0x8 | r5+0x18  | cti+0xD8         |
// | V73      | :uq      |    0x8 | r5+0x20  | cti+0xE0         |
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
// _ZTS22int1_fp16_upcvt_kernelILi1ELi256ELi1ELi16ELi32ELi1ELi1ELb1EE_BB_0:
(W)     mov (16|M0)              r57.0<1>:ud   r0.0<1;1,0>:ud                                        //  ALU pipe: int; $1
        and (1|M0)               cr0.0<1>:ud   cr0.0<0;1,0>:ud   -1073743089:d               {A@1}   // $1
        or (1|M0)                cr0.0<1>:ud   cr0.0<0;1,0>:ud   1073743040:d               {A@1}    // $2
        sync.nop                             null                             {Compacted,A@1}        // $4
        sync.nop                             null                             {Compacted,$1.dst}     // $4
        mul (2|M0)               r1.2<1>:d     r2.0<1;1,0>:d     r1.2<0;1,0>:uw   {A@1,$0.dst}       //  ALU pipe: int; $4
        mov (8|M0)               r8.0<1>:w     0x76543210:v                                          //  ALU pipe: int; $24
        add (2|M0)               r2.3<1>:d     r1.2<1;1,0>:d     r1.0<1;1,0>:uw   {I@2}              //  ALU pipe: int; $5
        mov (8|M0)               r101.0<1>:d   r8.0<1;1,0>:w                    {I@2}                //  ALU pipe: int; $24
(W)     mul (1|M0)               acc0.0<1>:d   r2.4<0;1,0>:d     r2.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $6
        macl (1|M0)              r3.0<1>:d     r2.4<0;1,0>:d     r2.0<0;1,0>:d                       //  ALU pipe: int; $7
        add (8|M0)               r101.8<1>:d   r101.0<1;1,0>:d   8:w               {I@3}             //  ALU pipe: int; $25
        add (1|M0)               r4.12<1>:d    r3.0<0;1,0>:d     r1.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $7
        mov (1|M0)               r63.5<1>:d    r0.1<0;1,0>:ud                                        //  ALU pipe: int; $9
        and (1|M0)               r5.0<1>:d     r4.12<0;1,0>:d    15:w               {I@2}            //  ALU pipe: int; $8
        shl (1|M0)               r63.5<1>:d    r63.5<0;1,0>:d    8:w               {I@2}             //  ALU pipe: int; $11
        shl (1|M0)               r6.0<1>:d     r5.0<0;1,0>:d     4:w               {Compacted,I@2}   //  ALU pipe: int; $14
        mov (8|M0)               r33.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $46
        or (16|M0)               r14.0<1>:d    r6.0<0;1,0>:d     r101.0<1;1,0>:d  {Compacted,I@2}    //  ALU pipe: int; $30
        shr (16|M0)              r15.0<2>:uw   r14.0<2;1,0>:uw   0x4:uw              {I@1}           //  ALU pipe: int; $31
        shr (16|M0)              r18.0<2>:uw   r14.0<2;1,0>:uw   0x5:uw                              //  ALU pipe: int; $33
        shr (16|M0)              r21.0<2>:uw   r14.0<2;1,0>:uw   0x6:uw                              //  ALU pipe: int; $35
        mov (16|M0)              r16.0<1>:uw   r15.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $31
        mov (16|M0)              r19.0<1>:uw   r18.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $33
        mov (16|M0)              r22.0<1>:uw   r21.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $35
        mov (16|M0)              r17.0<1>:hf   r16.0<1;1,0>:hf                  {I@3}                //  ALU pipe: float; $31
        mov (16|M0)              r20.0<1>:hf   r19.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $33
        mov (16|M0)              r23.0<1>:hf   r22.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $35
        and (16|M0)              r17.0<1>:uw   r17.0<1;1,0>:uw   0x1:uw              {F@3}           //  ALU pipe: int; $32
        and (16|M0)              r20.0<1>:uw   r20.0<1;1,0>:uw   0x1:uw              {F@2}           //  ALU pipe: int; $34
        or (1|M0)                r63.13<1>:d   r63.5<0;1,0>:d    r6.0<0;1,0>:d                       //  ALU pipe: int; $15
        and (16|M0)              r23.0<1>:uw   r23.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $36
        add (16|M0)              r27.0<1>:d    r17.0<1;1,0>:uw   r20.0<1;1,0>:uw  {I@3}              //  ALU pipe: int; $39
        or (16|M0)               r69.0<1>:d    r63.13<0;1,0>:d   r101.0<1;1,0>:d  {I@3}              //  ALU pipe: int; $26
        add (16|M0)              r28.0<1>:d    r27.0<1;1,0>:d    r23.0<1;1,0>:uw  {I@2}              //  ALU pipe: int; $40
        mov (8|M0)               r33.8<1>:w    0xFEDCBA98:uv                                         //  ALU pipe: int; $47
        shr (16|M0)              r24.0<2>:uw   r14.0<2;1,0>:uw   0x7:uw                              //  ALU pipe: int; $37
        shl (16|M0)              r9.0<1>:d     r69.0<1;1,0>:d    2:w               {Compacted,I@4}   //  ALU pipe: int; $27
        shr (16|M0)              r28.0<1>:ud   r101.0<1;1,0>:ud  r28.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $58
        mov (8|M0)               r30.0<1>:w    0x10101010:v                                          //  ALU pipe: int; $42
        mov (1|M0)               r63.12<1>:d   r0.6<0;1,0>:ud                                        //  ALU pipe: int; $10
        shl (1|M0)               r7.0<1>:d     r4.3<0;1,0>:d     1:w               {Compacted}       //  ALU pipe: int; $16
        shr (16|M0)              r27.0<1>:ud   r101.0<1;1,0>:ud  r27.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $53
        shr (16|M0)              r33.0<1>:uw   r33.0<1;1,0>:uw   r17.0<1;1,0>:uw  {I@7}              //  ALU pipe: int; $48 R{} IR{}{O:0,O:0,},  {BC=1}
        mov (16|M0)              r25.0<1>:uw   r24.0<2;1,0>:uw                  {I@7}                //  ALU pipe: int; $37
        mov (16|M0)              r10.0<2>:ud   r9.0<1;1,0>:ud                   {I@7}                //  ALU pipe: int; $28
        shl (16|M0)              r39.0<2>:w    r28.0<2;1,0>:w    15:w               {I@7}            //  ALU pipe: int; $59
        mov (8|M0)               r32.0<1>:d    r30.0<1;1,0>:w                   {I@7}                //  ALU pipe: int; $42
        mov (8|M0)               r32.8<1>:d    r30.0<1;1,0>:w                                        //  ALU pipe: int; $43
(W)     mul (1|M0)               acc0.0<1>:d   r7.0<0;1,0>:d     r63.24<0;1,0>:uw {I@7}              //  ALU pipe: int; $17
        shl (16|M0)              r34.0<2>:w    r27.0<2;1,0>:w    15:w               {I@7}            //  ALU pipe: int; $54
        shl (16|M0)              r33.0<1>:uw   r33.0<1;1,0>:uw   0xF:uw              {I@7}           //  ALU pipe: int; $49
        mov (16|M0)              r26.0<1>:hf   r25.0<1;1,0>:hf                  {I@7}                //  ALU pipe: float; $37
        add (16|M0)              r12.0<1>:q    r5.4<0;1,0>:q     r10.0<2;1,0>:ud  {I@7}              //  ALU pipe: int; $28
        mov (16|M0)              r40.0<1>:w    r39.0<2;1,0>:w                   {I@7}                //  ALU pipe: int; $59
        macl (1|M0)              r7.0<1>:d     r7.0<0;1,0>:d     r63.12<0;1,0>:d                     //  ALU pipe: int; $18
        mul (16|M0)              acc0.0<1>:d   r32.0<1;1,0>:d    0x8000:uw              {I@7}        //  ALU pipe: int; $44
        load.ugm.d32.a64.ca.ca (16|M0)  r83:1   [r12:2]            {I@4,$2} // ex_desc:0x0; desc:0x4180580 // $29
        mov (16|M0)              r35.0<1>:w    r34.0<2;1,0>:w                                        //  ALU pipe: int; $54
        or (16|M0)               r33.0<1>:uw   r33.0<1;1,0>:uw   0x3C00:uw                           //  ALU pipe: int; $50
        and (16|M0)              r26.0<1>:uw   r26.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $38
        mov (16|M0)              r41.0<1>:hf   r40.0<1;1,0>:hf                  {I@6}                //  ALU pipe: float; $59
        add (16|M0)              r32.0<1>:d    acc0.0<1;1,0>:d   15360:w                             //  ALU pipe: int; $45
        mov (16|M0)              acc0.0<1>:d   -r20.0<1;1,0>:uw                                      //  ALU pipe: int; $51
        mov (16|M0)              r36.0<1>:hf   r35.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $54
        or (16|M0)               r41.0<1>:w    r41.0<1;1,0>:w    15360:w               {F@2}         //  ALU pipe: int; $60
        and (16|M0)              acc0.0<1>:d   r33.0<1;1,0>:uw   acc0.0<1;1,0>:d  {I@5}              //  ALU pipe: int; $52
        mov (16|M0)              acc2.0<1>:d   -r26.0<1;1,0>:uw                 {I@5}                //  ALU pipe: int; $61
        or (16|M0)               r36.0<1>:w    r36.0<1;1,0>:w    15360:w               {F@1}         //  ALU pipe: int; $55
        and (16|M0)              acc2.0<1>:d   r41.0<1;1,0>:uw   acc2.0<1;1,0>:d  {I@4}              //  ALU pipe: int; $62
        shl (16|M0)              r42.0<1>:d    r14.0<1;1,0>:d    3:w                                 //  ALU pipe: int; $63
        mov (16|M0)              r29.0<1>:d    -r17.0<1;1,0>:uw                                      //  ALU pipe: int; $41
        mov (16|M0)              r38.0<1>:d    -r23.0<1;1,0>:uw                                      //  ALU pipe: int; $57
        mov (16|M0)              r37.0<1>:d    r36.0<1;1,0>:uw                  {I@5}                //  ALU pipe: int; $56
        shl (16|M0)              r43.0<1>:d    acc0.0<1;1,0>:d   16:w                                //  ALU pipe: int; $64
        shl (16|M0)              r45.0<1>:d    acc2.0<1;1,0>:d   16:w                                //  ALU pipe: int; $66
        cmp (1|M0)    (eq)f1.1   null<1>:d     r5.0<0;1,0>:d     0:w                                 //  ALU pipe: int; $71
        or (16|M0)               r47.0<1>:ud   r42.0<1;1,0>:ud   0x4:uw              {I@7}           //  ALU pipe: int; $69
        bfn.(s0|s1&s2) (16|M0)   r44.0<1>:ud   r43.0<1;0>:ud     r29.0<1;0>:ud     r32.0<1>:ud      {I@4} //  ALU pipe: int; $65
        bfn.(s0|s1&s2) (16|M0)   r46.0<1>:ud   r45.0<1;0>:ud     r37.0<1;0>:ud     r38.0<1>:ud      {I@4} //  ALU pipe: int; $67
        add (1|M0)               r63.0<1>:d    r4.1<0;1,0>:d     31:w                                //  ALU pipe: int; $12
        mov (1|M0)               r63.5<1>:q    r63.13<0;1,0>:ud                                      //  ALU pipe: int; $20
        store.slm.d32.a32 (16|M0)  [r42:1]      r44:1              {I@4,$3} // ex_desc:0x0; desc:0x2000504 // $68
        store.slm.d32.a32 (16|M0)  [r47:1]      r46:1              {I@3,$4} // ex_desc:0x0; desc:0x2000504 // $70
        shl (1|M0)               r63.2<1>:d    r4.4<0;1,0>:d     2:w                                 //  ALU pipe: int; $19
        shl (1|M0)               r63.3<1>:d    r5.4<0;1,0>:d     1:w                                 //  ALU pipe: int; $22
        mov (1|M0)               r63.3<1>:q    r7.0<0;1,0>:ud                                        //  ALU pipe: int; $18
        shr (1|M0)               r63.1<1>:ud   r63.0<0;1,0>:ud   0x5:uw              {I@5}           //  ALU pipe: int; $13
        shl (1|M0)               r63.4<1>:q    r63.5<0;1,0>:q    2:w               {I@5}             //  ALU pipe: int; $21
        shl (1|M0)               r63.5<1>:q    r63.5<0;1,0>:q    1:w                                 //  ALU pipe: int; $23
(W&~f1.1) jmpi                               BB_1                                                    //  ALU pipe: int; $72
// B003: Preds:{B002},  Succs:{B004}
_L_k19_0_:
        mul (16|M0)              acc0.0<1>:ud  r101.0<1;1,0>:ud  0x4:uw                              //  ALU pipe: int; $73
        mov (16|M0)              r6.0<1>:d     1920:w                               {Compacted}      //  ALU pipe: int; $76
        mov (16|M0)              r8.0<1>:d     120:w                               {Compacted}       //  ALU pipe: int; $80
        add (16|M0)              r3.0<1>:ud    acc0.0<1;1,0>:ud  0x800:uw                            //  ALU pipe: int; $74
        add (16|M0)              r7.0<1>:ud    acc0.0<1;1,0>:ud  0x840:uw                            //  ALU pipe: int; $78
        store.slm.d32.a32 (16|M0)  [r3:1]       r6:1               {I@2,$5} // ex_desc:0x0; desc:0x2000504 // $77
        store.slm.d32.a32 (16|M0)  [r7:1]       r8:1               {I@1,$6} // ex_desc:0x0; desc:0x2000504 // $81
// B004: Preds:{B003, B002},  Succs:{B005, B008}
BB_1:
        sync.nop                             null                             {$5.src}               // $83
(W)     send.slm (1|M0)          r3       r57  null:0  0x0            0x0210001F           {$7} // wr:1+0, rd:1; fence.slm.none.group // $83
        mov (16|M0)              r6.0<1>:f     0x10100000:f                               {Compacted} //  (0x10100000:f); ALU pipe: float; $85
(W)     mov (8|M0)               null<1>:ud    r3.0<1;1,0>:ud                   {Compacted,$7.dst}   //  memory fence commit; ALU pipe: int; $86
        send.gtwy (1|M0)         null     r6  null:0  0x0            0x02000004           {F@1,$8} // wr:1+0, rd:0; signal barrier // $86
(W)     sync.bar                             0:w                                                     // $87
        mov (1|M0)               r7.0<1>:d     2048:w                               {$6.src}         //  ALU pipe: int; $88
        mov (1|M0)               r8.0<1>:d     2112:w                                                //  ALU pipe: int; $90
        load.slm.d32x16t.a32 (1|M0)  r89:1      [r7:1]             {I@2,$9} // ex_desc:0x0; desc:0x210D500 // $89
        load.slm.d32x16t.a32 (1|M0)  r97:1      [r8:1]             {I@1,$10} // ex_desc:0x0; desc:0x210D500 // $91
        cmp (1|M0)    (lt)f1.0   null<1>:ud    r63.0<0;1,0>:ud   0x20:uw                             //  ALU pipe: int; $93
(W&f1.0) jmpi                                BB_2                                                    //  ALU pipe: int; $94
// B005: Preds:{B004},  Succs:{B006}
_L_k19_1_:
        mov (16|M0)              r98.0<1>:d    0:w                               {Compacted}         //  ALU pipe: int; $97
        mov (16|M0)              r100.0<1>:f   0.0:f                               {Compacted}       //  ALU pipe: float; $99
        sel (1|M0)    (ge)f0.0   r63.1<1>:ud   r63.1<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $95
        mov (1|M0)               r63.4<1>:d    0:w                                                   //  ALU pipe: int; $100
// B006: Preds:{B006, B005},  Succs:{B007, B006}
BB_3:
        shr (1|M0)               r3.0<1>:uq    r63.3<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $102
        shr (1|M0)               r8.0<1>:uq    r63.4<0;1,0>:uq   0x3:uw              {$10.src}       //  ALU pipe: int; $107
        shr (1|M0)               r10.0<1>:uq   r63.5<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $112
        shl (1|M0)               r3.0<1>:uq    r3.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $103
        shl (1|M0)               r8.0<1>:uq    r8.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $108
        shl (1|M0)               r10.0<1>:uq   r10.0<0;1,0>:uq   0x3:uw              {I@3}           //  ALU pipe: int; $113
        add (1|M0)               r3.0<1>:uq    r4.3<0;1,0>:uq    r3.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $104
        add (1|M0)               r8.0<1>:uq    r4.4<0;1,0>:uq    r8.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $109
        add (1|M0)               r10.0<1>:uq   r5.1<0;1,0>:uq    r10.0<0;1,0>:uq  {I@3}              //  ALU pipe: int; $114
        sync.nop                             null                             {$9.src}               // $106
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r7:1  [r3:1]             {I@3,$11} // ex_desc:0x0; desc:0x218C780 // $106
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r9:1  [r8:1]             {I@2,$12} // ex_desc:0x0; desc:0x218C780 // $111
        load.ugm.d64x4t.a64.ca.ca (1|M0)  r11:1 [r10:1]            {I@1,$13} // ex_desc:0x0; desc:0x218B780 // $116
        add (1|M0)               r63.4<1>:d    r63.4<0;1,0>:d    1:w                                 //  ALU pipe: int; $117
        and (1|M0)    (eq)f0.1   null<1>:d     r63.4<0;1,0>:d    3:w               {I@1}             //  ALU pipe: int; $121
        add (1|M0)               r63.3<1>:uq   r63.3<0;1,0>:uq   0x40:uw                             //  ALU pipe: int; $120
(f0.1)  sel (1|M0)               r12.0<1>:d    r63.3<0;1,0>:d    0:w               {$2.src}          //  ALU pipe: int; $123
        shr (16|M0)              acc0.0<1>:ud  r9.0<1;1,0>:ud    0x1:uw              {$12.dst}       //  ALU pipe: int; $125
        shr (16|M0)              acc2.0<1>:ud  r98.0<1;1,0>:ud   0x5:uw                              //  ALU pipe: int; $127
        add (16|M0)              acc2.0<1>:ud  acc2.0<1;1,0>:ud  r83.0<1;1,0>:ud  {$2.dst}           //  ALU pipe: int; $128
        shl (16|M0)              r14.0<1>:ud   acc2.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $129
        mov (16|M0)              r15.0<2>:ud   r14.0<1;1,0>:ud                  {I@1}                //  ALU pipe: int; $130
        add (16|M0)              r17.0<1>:q    r5.3<0;1,0>:q     r15.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $130
        load.ugm.d32x3.a64.ca.ca (16|M0)  r20:3 [r17:2]            {I@1,$14} // ex_desc:0x0; desc:0x4382580 // $132
        and (16|M0)   (eq)f2.1   r24.0<2>:w    r98.0<2;1,0>:w    31:w                                //  ALU pipe: int; $135
        mov (16|M0)              r27.0<2>:w    -r98.0<2;1,0>:w                                       //  ALU pipe: int; $137
        mov (16|M0)              r28.0<1>:w    r27.0<2;1,0>:w                   {I@1}                //  ALU pipe: int; $137
        mov (16|M0)              r25.0<1>:w    r24.0<2;1,0>:w                                        //  ALU pipe: int; $135
        mov (16|M0)              r29.0<1>:hf   r28.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $137
        shl (16|M0)              r32.0<1>:ud   r9.0<1;1,0>:ud    0x7:uw                              //  ALU pipe: int; $147
        mov (16|M0)              r26.0<1>:hf   r25.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $135
        bfn.(s0&~s2|s1&s2) (16|M0)   acc2.0<1>:ud  r20.0<1;0>:ud  r21.0<1;0>:ud    0x0:uw              {$14.dst} //  ALU pipe: int; $133
        bfn.(s0&~s2|s1&s2) (16|M0)   r23.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud     0x0:uw              //  ALU pipe: int; $134
        and (16|M0)              r29.0<1>:w    r29.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $138
        shl (16|M0)              r50.0<1>:ud   r9.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $158
        and (16|M0)              r33.0<1>:ud   r32.0<1;1,0>:ud   r89.0<1;1,0>:ud  {Compacted,@5,$9.dst} //  ALU pipe: int; $148
        shr (16|M0)              r30.0<1>:ud   acc2.0<1;1,0>:ud  r26.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $140
        shl (16|M0)              r23.0<1>:ud   r23.0<1;1,0>:ud   r29.0<1;1,0>:uw  {I@4}              //  ALU pipe: int; $141
        and (16|M0)              r51.0<1>:ud   r50.0<1;1,0>:ud   r89.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $159
        cbit (16|M0)             r33.0<1>:ud   r33.0<1;1,0>:ud                  {Compacted,I@4}      //  ALU pipe: int; $156
(~f2.1) or (16|M0)               r30.0<1>:ud   r23.0<1;1,0>:ud   r30.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $143
        cbit (16|M0)             r51.0<1>:ud   r51.0<1;1,0>:ud                  {I@3}                //  ALU pipe: int; $167
        shr (16|M0)              acc2.0<1>:ud  r30.0<1;1,0>:ud   r33.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $157
        shl (16|M0)              r52.0<1>:ud   acc2.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $160
        shr (16|M0)              acc2.0<1>:ud  acc2.0<1;1,0>:ud  r51.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $168
        and (16|M0)              r56.0<1>:ud   acc0.0<1;1,0>:ud  r89.0<1;1,0>:ud                     //  ALU pipe: int; $169
        shl (16|M0)              r58.0<1>:ud   acc2.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $170
        cbit (16|M0)             r56.0<1>:ud   r56.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $177
        and (16|M0)              r58.0<1>:ud   r58.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,@2,$10.dst} //  ALU pipe: int; $171
        bfn.(s0&s1|s2) (16|M0)   r59.0<1>:ud   acc0.0<1;0>:ud    r89.0<1;0>:ud     r58.0<1>:ud      {I@1} //  ALU pipe: int; $172
        shr (16|M0)              acc0.0<1>:ud  acc2.0<1;1,0>:ud  r56.0<1;1,0>:ud                     //  ALU pipe: int; $178
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $179
        and (16|M0)              r62.0<1>:ud   acc2.0<1;1,0>:ud  r89.0<1;1,0>:ud                     //  ALU pipe: int; $180
        shl (16|M0)              r64.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $181
        cbit (16|M0)             r62.0<1>:ud   r62.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $188
        and (16|M0)              r64.0<1>:ud   r64.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $182
        bfn.(s0&s1|s2) (16|M0)   r65.0<1>:ud   acc2.0<1;0>:ud    r89.0<1;0>:ud     r64.0<1>:ud      {I@1} //  ALU pipe: int; $183
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r62.0<1;1,0>:ud                     //  ALU pipe: int; $189
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $190
        and (16|M0)              r68.0<1>:ud   acc2.0<1;1,0>:ud  r89.0<1;1,0>:ud                     //  ALU pipe: int; $191
        shl (16|M0)              r70.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $192
        cbit (16|M0)             r68.0<1>:ud   r68.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $199
        and (16|M0)              r70.0<1>:ud   r70.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $193
        bfn.(s0&s1|s2) (16|M0)   r71.0<1>:ud   acc2.0<1;0>:ud    r89.0<1;0>:ud     r70.0<1>:ud      {I@1} //  ALU pipe: int; $194
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r68.0<1;1,0>:ud                     //  ALU pipe: int; $200
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $201
        and (16|M0)              r82.0<1>:ud   acc2.0<1;1,0>:ud  r89.0<1;1,0>:ud                     //  ALU pipe: int; $202
        shl (16|M0)              r84.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $203
        cbit (16|M0)             r82.0<1>:ud   r82.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $210
        and (16|M0)              r84.0<1>:ud   r84.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $204
        bfn.(s0&s1|s2) (16|M0)   r85.0<1>:ud   acc2.0<1;0>:ud    r89.0<1;0>:ud     r84.0<1>:ud      {I@1} //  ALU pipe: int; $205
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r82.0<1;1,0>:ud                     //  ALU pipe: int; $211
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $212
        and (16|M0)              r88.0<1>:ud   acc2.0<1;1,0>:ud  r89.0<1;1,0>:ud                     //  ALU pipe: int; $213
        shl (16|M0)              r90.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $214
        cbit (16|M0)             r88.0<1>:ud   r88.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $222
        and (16|M0)              r90.0<1>:ud   r90.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $215
        bfn.(s0&s1|s2) (16|M0)   r91.0<1>:ud   acc2.0<1;0>:ud    r89.0<1;0>:ud     r90.0<1>:ud      {I@1} //  ALU pipe: int; $216
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r88.0<1;1,0>:ud                     //  ALU pipe: int; $223
        shl (16|M0)              r34.0<1>:ud   r30.0<1;1,0>:ud   0x3:uw              {Compacted}     //  ALU pipe: int; $149
        shl (16|M0)              r30.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $224
        cbit (16|M0)             r13.0<1>:ud   r9.0<1;1,0>:ud                   {Compacted}          //  ALU pipe: int; $126
        and (16|M0)              r52.0<1>:ud   r52.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $161
        and (16|M0)              r34.0<1>:ud   r34.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $150
        and (16|M0)              r30.0<1>:ud   r30.0<1;1,0>:ud   r97.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $225
        shr (16|M0)              r9.0<1>:ud    r9.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $221
        bfn.(s0&s1|s2) (16|M0)   r53.0<1>:ud   r50.0<1;0>:ud     r89.0<1;0>:ud     r52.0<1>:ud      {I@4} //  ALU pipe: int; $162
        bfn.(s0&s1|s2) (16|M0)   r35.0<1>:ud   r32.0<1;0>:ud     r89.0<1;0>:ud     r34.0<1>:ud      {I@4} //  ALU pipe: int; $151
        bfn.(s0&s1|s2) (16|M0)   r94.0<1>:ud   r9.0<1;0>:ud      r89.0<1;0>:ud     r30.0<1>:ud      {I@3} //  ALU pipe: int; $226
        load.slm.d32x2.a32 (16|M0)  r60:2       [r59:1]            {$15} // ex_desc:0x0; desc:0x2201500 // $174
        load.slm.d32x2.a32 (16|M0)  r66:2       [r65:1]            {$0} // ex_desc:0x0; desc:0x2201500 // $185
        load.slm.d32x2.a32 (16|M0)  r72:2       [r71:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $196
        load.slm.d32x2.a32 (16|M0)  r86:2       [r85:1]            {$5} // ex_desc:0x0; desc:0x2201500 // $207
        load.slm.d32x2.a32 (16|M0)  r92:2       [r91:1]            {$6} // ex_desc:0x0; desc:0x2201500 // $218
        load.slm.d32x2.a32 (16|M0)  r54:2       [r53:1]            {I@3,$7} // ex_desc:0x0; desc:0x2201500 // $164
        load.slm.d32x2.a32 (16|M0)  r36:2       [r35:1]            {I@2,$12} // ex_desc:0x0; desc:0x2201500 // $153
        load.slm.d32x2.a32 (16|M0)  r95:2       [r94:1]            {I@1,$14} // ex_desc:0x0; desc:0x2201500 // $228
        mov (16|M0)              r31.0<2>:uw   r11.0<1;1,0>:uw                  {$13.dst}            //  ALU pipe: int; $145
        mov (16|M0)              r31.1<2>:uw   r11.0<1;1,0>:uw                                       //  ALU pipe: int; $146
        add (1|M0)               r63.4<1>:q    r63.4<0;1,0>:q    r63.2<0;1,0>:ud                     //  ALU pipe: int; $231
        add (1|M0)               r63.5<1>:q    r63.5<0;1,0>:q    r12.0<0;1,0>:ud                     //  ALU pipe: int; $232
        add (16|M0)              r98.0<1>:ud   r13.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $233
        sync.nop                             null                             {Compacted,I@4}        // $154
        sync.nop                             null                             {$3.src}               // $154
        mul (32|M0)              r42.0<1>:hf   r31.0<1;1,0>:hf   r36.0<1;1,0>:hf  {$12.dst}          //  ALU pipe: float; $154
        mul (32|M0)              r43.0<1>:hf   r31.0<1;1,0>:hf   r37.0<1;1,0>:hf                     //  ALU pipe: float; $155
        mul (32|M0)              r44.0<1>:hf   r31.0<1;1,0>:hf   r54.0<1;1,0>:hf  {$7.dst}           //  ALU pipe: float; $165
        mul (32|M0)              r45.0<1>:hf   r31.0<1;1,0>:hf   r55.0<1;1,0>:hf                     //  ALU pipe: float; $166
        sync.nop                             null                             {$4.src}               // $175
        mul (32|M0)              r46.0<1>:hf   r31.0<1;1,0>:hf   r60.0<1;1,0>:hf  {$15.dst}          //  ALU pipe: float; $175
        mul (32|M0)              r47.0<1>:hf   r31.0<1;1,0>:hf   r61.0<1;1,0>:hf                     //  ALU pipe: float; $176
        mul (32|M0)              r48.0<1>:hf   r31.0<1;1,0>:hf   r66.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $186
        mul (32|M0)              r49.0<1>:hf   r31.0<1;1,0>:hf   r67.0<1;1,0>:hf                     //  ALU pipe: float; $187
        mul (32|M0)              r74.0<1>:hf   r31.0<1;1,0>:hf   r72.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $197
        mul (32|M0)              r75.0<1>:hf   r31.0<1;1,0>:hf   r73.0<1;1,0>:hf                     //  ALU pipe: float; $198
        mul (32|M0)              r76.0<1>:hf   r31.0<1;1,0>:hf   r86.0<1;1,0>:hf  {$5.dst}           //  ALU pipe: float; $208
        mul (32|M0)              r77.0<1>:hf   r31.0<1;1,0>:hf   r87.0<1;1,0>:hf                     //  ALU pipe: float; $209
        mul (32|M0)              r78.0<1>:hf   r31.0<1;1,0>:hf   r92.0<1;1,0>:hf  {$6.dst}           //  ALU pipe: float; $219
        mul (32|M0)              r79.0<1>:hf   r31.0<1;1,0>:hf   r93.0<1;1,0>:hf                     //  ALU pipe: float; $220
        mul (32|M0)              r80.0<1>:hf   r31.0<1;1,0>:hf   r95.0<1;1,0>:hf  {$14.dst}          //  ALU pipe: float; $229
        mul (32|M0)              r81.0<1>:hf   r31.0<1;1,0>:hf   r96.0<1;1,0>:hf                     //  ALU pipe: float; $230
        sync.nop                             null                             {Compacted,F@7}        // $235
        dpas.8x1 (16|M0)         r100:f        r100:f            r42:hf            r7.0:hf          {Compacted,$11} // $235
        sync.nop                             null                             {Compacted,F@1}        // $236
        dpas.8x1 (16|M0)         r100:f        r100:f            r74:hf            r7.16:hf         {Compacted,$11} // $236
        mov (1|M0)               null<1>:ud    r100.0<0;1,0>:w                  {$11.dst}            //  ALU pipe: int; $237
        cmp (1|M0)    (eq)f0.0   null<1>:d     r63.4<0;1,0>:d    r63.1<0;1,0>:d                      //  ALU pipe: int; $239
(W&~f0.0) jmpi                               BB_3                                                    //  ALU pipe: int; $240
// B007: Preds:{B006},  Succs:{B009}
_L_k19_2_:
        mov (16|M0)              r1.16<1>:hf   r100.0<1;1,0>:f                                       //  ALU pipe: float; $241
        mov (16|M0)              r99.0<1>:d    r1.16<1;1,0>:uw                  {F@1}                //  ALU pipe: int; $242
(W)     jmpi                                 BB_4                                                    // $243
// B008: Preds:{B004},  Succs:{B009}
BB_2:
        mov (16|M0)              r99.0<1>:d    0:w                                                   //  ALU pipe: int; $246
// B009: Preds:{B008, B007},  Succs:{}
BB_4:
        add (1|M0)               r1.2<1>:d     r63.12<0;1,0>:d   1:w                                 //  ALU pipe: int; $248
        add (1|M0)               r63.5<1>:d    r63.5<0;1,0>:d    256:w                               //  ALU pipe: int; $250
        sel (1|M0)    (lt)f0.0   r1.2<1>:ud    r1.2<0;1,0>:ud    r4.0<0;1,0>:ud   {I@2}              //  ALU pipe: int; $249
        sel (1|M0)    (lt)f0.0   r63.5<1>:ud   r63.5<0;1,0>:ud   r4.2<0;1,0>:ud   {I@2}              //  ALU pipe: int; $251
(W)     mul (1|M0)               acc0.0<1>:d   r63.12<0;1,0>:d   r4.10<0;1,0>:uw                     //  ALU pipe: int; $253
        macl (1|M0)              r3.0<1>:d     r63.12<0;1,0>:d   r4.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $254
        mul (16|M0)              r101.0<1>:ud  r101.0<1;1,0>:ud  0x2:uw              {Compacted}     //  ALU pipe: int; $256
        add (1|M0)               r63.13<1>:d   r63.13<0;1,0>:d   r3.0<0;1,0>:d    {I@2}              //  ALU pipe: int; $254
        cmp (16|M0)   (lt)f2.0   null<1>:d     r63.12<0;1,0>:ud  r1.2<0;1,0>:ud                      //  ALU pipe: int; $259
        shl (1|M0)               r63.13<1>:d   r63.13<0;1,0>:d   1:w               {I@2}             //  ALU pipe: int; $255
(W)     mov (16|M0)              r127.0<1>:f   r57.0<1;1,0>:f                   {Compacted}          //  ALU pipe: float; $263
        add (16|M0)              r101.0<1>:ud  r63.13<0;1,0>:ud  r101.0<1;1,0>:ud {Compacted,I@1}    //  ALU pipe: int; $257
(f2.0)  cmp (16|M0)   (lt)f2.0   null<1>:d     r69.0<1;1,0>:ud   r63.5<0;1,0>:ud                     //  ALU pipe: int; $260
        sync.nop                             null                             {Compacted,$9.src}     // $258
        mov (16|M0)              r6.0<2>:ud    r101.0<1;1,0>:ud                 {Compacted,@2,$8.src} //  ALU pipe: int; $258
        add (16|M0)              r8.0<1>:q     r4.5<0;1,0>:q     r6.0<2;1,0>:ud   {@1,$10.src}       //  ALU pipe: int; $258
(f2.0)  store.ugm.d16u32.a64.st.wb (16|M0)  [r8:2] r99:1           {I@1,$13} // ex_desc:0x0; desc:0x40C0B84 // $262
(W)     send.gtwy (1|M0)         null     r127  null:0  0x0            0x02000010           {EOT,F@1,$14} // wr:1+0, rd:0; end of thread // $263


//.BankConflicts: 1
//.ByteRMWs: 0
//


//.numALUInst: 241
//.accSubDef: 21
//.accSubUse: 33
//.accSubCandidateDef: 22
//.accSubCandidateUse: 34
//
//
//.singlePipeAtOneDistNum: 28
//.allAtOneDistNum: 6
//.syncInstCount: 10
//.tokenReuseCount: 0
//.AfterWriteTokenDepCount: 18
//.AfterReadTokenDepCount: 11
