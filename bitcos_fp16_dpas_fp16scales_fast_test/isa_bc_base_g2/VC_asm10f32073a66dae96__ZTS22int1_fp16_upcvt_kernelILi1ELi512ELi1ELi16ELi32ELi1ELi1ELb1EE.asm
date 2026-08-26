//.kernel _ZTS22int1_fp16_upcvt_kernelILi1ELi512ELi1ELi16ELi32ELi1ELi1ELb1EE
//.platform XE2
//.thread_config numGRF=128, numAcc=4, numSWSB=16
//.options_string "-enablePreemptionR0Only -enableHalfLSC -dumpcommonisa -output -binary -abiver 2 -samplerHeaderWA "
//.full_options "-samplerHeaderWA -enablePreemptionR0Only -abiver 2 -output -binary -dumpcommonisa -enableHalfLSC "
//.instCount 274
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
//.declare V58 (66)  rf=r size=8 type=uq align=4 words (r5.1)
//.declare V59 (67)  rf=r size=8 type=uq align=4 words (r5.3)
//.declare V61 (69)  rf=r size=8 type=d align=2 words (r1.2)
//.declare V62 (70)  rf=r size=12 type=d align=2 words (r2.3)
//.declare V63 (71)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V64 (72)  rf=r size=12 type=d align=2 words (r4.12)
//.declare V65 (73)  rf=r size=4 type=d align=2 words (r41.0)
//.declare V66 (74)  rf=r size=4 type=d align=2 words (r41.1)
//.declare V67 (75)  rf=r size=4 type=d align=2 words (r41.2)
//.declare V68 (76)  rf=r size=4 type=d align=2 words (r41.3)
//.declare V69 (77)  rf=r size=4 type=d align=32 words (r5.0)
//.declare V70 (78)  rf=r size=4 type=d align=2 words (r41.4)
//.declare V71 (79)  rf=r size=4 type=d align=2 words (r41.5)
//.declare V72 (80)  rf=r size=64 type=d align=32 words (r57.0)
//.declare V73 (81)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V74 (82)  rf=r size=8 type=uq align=4 words (r5.4)
//.declare V75 (83)  rf=r size=128 type=q align=32 words (r10.0)
//.declare V76 (84)  rf=r size=64 type=d align=32 words (r63.0)
//.declare P1 (85)  rf=f1  size=2 type=uw align=1 words (f2.0)
//.declare V77 (86)  rf=r size=64 type=w align=32 words (r3.0)
//.declare V78 (87)  rf=r size=32 type=w align=2 words (r8.0)
//.declare V79 (88)  rf=r size=32 type=w align=2 words (r11.0)
//.declare V80 (89)  rf=r size=32 type=w align=2 words (r14.0)
//.declare V81 (90)  rf=r size=32 type=w align=2 words (r17.0)
//.declare V82 (91)  rf=r size=64 type=d align=32 words (r21.0)
//.declare V83 (92)  rf=r size=64 type=d align=32 words (r24.0)
//.declare V84 (93)  rf=r size=32 type=w align=8 words (r25.0)
//.declare V85 (94)  rf=r size=64 type=w align=32 words (r18.0)
//.declare V86 (95)  rf=r size=32 type=w align=2 words (r28.0)
//.declare V87 (96)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V88 (97)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V89 (98)  rf=r size=64 type=w align=32 words (r19.0)
//.declare V90 (99)  rf=r size=32 type=w align=2 words (r33.0)
//.declare V91 (100)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V92 (101)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V93 (102)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V94 (103)  rf=r size=64 type=d align=32 words (r37.0)
//.declare V95 (104)  rf=r size=64 type=d align=32 words (r38.0)
//.declare V96 (105)  rf=r size=64 type=d align=32 words (r39.0)
//.declare P2 (106)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V98 (108)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V100 (110)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V101 (111)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V103 (113)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V105 (115)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V106 (116)  rf=r size=4 type=d align=32 words (r7.0)
//.declare V107 (117)  rf=r size=64 type=d align=32 words (r69.0)
//.declare V108 (118)  rf=r size=4 type=d align=32 words (r8.0)
//.declare V109 (119)  rf=r size=64 type=d align=32 words (r83.0)
//.declare P3 (120)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare V112 (123)  rf=r size=4 type=d align=2 words (r41.6)
//.declare V113 (124)  rf=r size=8 type=q align=4 words (r41.4)
//.declare V114 (125)  rf=r size=8 type=q align=4 words (r41.5)
//.declare V115 (126)  rf=r size=8 type=q align=4 words (r41.6)
//.declare V116 (127)  rf=r size=64 type=d align=32 words (r89.0)
//.declare V117 (128)  rf=r size=64 type=f align=32 words (r98.0)
//.declare V118 (129)  rf=r size=8 type=q align=32 words (r3.0)
//.declare V119 (130)  rf=r size=8 type=q align=32 words (r8.0)
//.declare V120 (131)  rf=r size=8 type=q align=32 words (r10.0)
//.declare V121 (132)  rf=r size=32 type=hf align=32 words (r11.0)
//.declare P4 (134)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare V123 (135)  rf=r size=4 type=d align=2 words (r12.0)
//.declare V125 (137)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V126 (138)  rf=r size=64 type=d align=32 words (r14.0)
//.declare V127 (139)  rf=r size=128 type=q align=32 words (r17.0)
//.declare V128 (140)  rf=r size=192 type=d align=32 words (r20.0)
//.declare V129 (141)  rf=r size=32 type=w align=2 words (r26.0)
//.declare V131 (143)  rf=r size=32 type=w align=2 words (r29.0)
//.declare V133 (145)  rf=r size=64 type=d align=32 words (r23.0)
//.declare P5 (146)  rf=f16  size=2 type=uw align=1 words (f3.0)
//.declare V134 (147)  rf=r size=64 type=hf align=32 words (r31.0)
//.declare V135 (148)  rf=r size=64 type=d align=32 words (r32.0)
//.declare V136 (149)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V137 (150)  rf=r size=64 type=d align=32 words (r35.0)
//.declare V138 (151)  rf=r size=128 type=hf align=32 words (r36.0)
//.declare V139 (152)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V140 (153)  rf=r size=64 type=d align=32 words (r50.0)
//.declare V141 (154)  rf=r size=64 type=d align=32 words (r52.0)
//.declare V142 (155)  rf=r size=64 type=d align=32 words (r53.0)
//.declare V143 (156)  rf=r size=128 type=hf align=32 words (r54.0)
//.declare V144 (157)  rf=r size=64 type=d align=32 words (r51.0)
//.declare V145 (158)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V146 (159)  rf=r size=64 type=d align=32 words (r59.0)
//.declare V147 (160)  rf=r size=128 type=hf align=32 words (r60.0)
//.declare V148 (161)  rf=r size=64 type=d align=32 words (r56.0)
//.declare V150 (163)  rf=r size=64 type=d align=32 words (r64.0)
//.declare V151 (164)  rf=r size=64 type=d align=32 words (r65.0)
//.declare V152 (165)  rf=r size=128 type=hf align=32 words (r66.0)
//.declare V153 (166)  rf=r size=512 type=d align=32 words (r42.0)
//.declare V154 (167)  rf=r size=64 type=d align=32 words (r62.0)
//.declare V156 (169)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V157 (170)  rf=r size=64 type=d align=32 words (r71.0)
//.declare V158 (171)  rf=r size=128 type=hf align=32 words (r72.0)
//.declare V159 (172)  rf=r size=64 type=d align=32 words (r68.0)
//.declare V161 (174)  rf=r size=64 type=d align=32 words (r84.0)
//.declare V162 (175)  rf=r size=64 type=d align=32 words (r85.0)
//.declare V163 (176)  rf=r size=128 type=hf align=32 words (r86.0)
//.declare V164 (177)  rf=r size=64 type=d align=32 words (r82.0)
//.declare V166 (179)  rf=r size=64 type=d align=32 words (r90.0)
//.declare V167 (180)  rf=r size=64 type=d align=32 words (r91.0)
//.declare V168 (181)  rf=r size=128 type=hf align=32 words (r92.0)
//.declare V169 (182)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V170 (183)  rf=r size=64 type=d align=32 words (r88.0)
//.declare V171 (184)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V172 (185)  rf=r size=64 type=d align=32 words (r94.0)
//.declare V173 (186)  rf=r size=128 type=hf align=32 words (r95.0)
//.declare V174 (187)  rf=r size=512 type=d align=32 words (r74.0)
//.declare V175 (188)  rf=r size=64 type=d align=32 words (r7.0)
//.declare P6 (189)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare V176 (190)  rf=r size=32 type=w align=16 words (r1.16)
//.declare V178 (192)  rf=r size=64 type=d align=32 words (r97.0)
//.declare V179 (193)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V180 (194)  rf=r size=4 type=d align=2 words (r41.7)
//.declare V181 (195)  rf=r size=4 type=d align=2 words (r41.14)
//.declare V182 (196)  rf=r size=4 type=d align=2 words (r1.2)
//.declare V183 (197)  rf=r size=4 type=d align=2 words (r41.15)
//.declare V184 (198)  rf=r size=64 type=d align=32 words (r99.0)
//.declare V185 (199)  rf=r size=8 type=uq align=4 words (r4.5)
//.declare V186 (200)  rf=r size=128 type=q align=32 words (r8.0)
//.declare P7 (201)  rf=f16  size=2 type=uw align=1 words (f0.0)
//.declare P8 (202)  rf=f16  size=2 type=uw align=1 words (f3.1)
//.declare P9 (203)  rf=f16  size=2 type=uw align=1 words (f2.1)
//.declare V187 (204)  rf=r size=6 type=uw alias=V33+0 align=1 words (r1.0)
//.declare V188 (205)  rf=r size=8 type=d alias=V61+0 align=2 words (r1.2)
//.declare V190 (207)  rf=r size=12 type=d alias=V34+0 align=2 words (r2.0)
//.declare V191 (208)  rf=r size=12 type=d alias=V62+0 align=2 words (r2.3)
//.declare V192 (209)  rf=r size=4 type=d alias=V63+0 align=2 words (r3.0)
//.declare V193 (210)  rf=r size=12 type=d alias=V64+0 align=2 words (r4.12)
//.declare V194 (211)  rf=r size=4 type=d alias=V65+0 align=2 words (r41.0)
//.declare V195 (212)  rf=r size=4 type=d alias=V180+0 align=2 words (r41.7)
//.declare V196 (213)  rf=r size=4 type=d alias=V66+0 align=2 words (r41.1)
//.declare V197 (214)  rf=r size=4 type=d alias=V37+0 align=2 words (r4.1)
//.declare V198 (215)  rf=r size=4 type=ud alias=V67+0 align=2 words (r41.2)
//.declare V199 (216)  rf=r size=4 type=ud alias=V66+0 align=2 words (r41.1)
//.declare V200 (217)  rf=r size=4 type=d alias=V68+0 align=2 words (r41.3)
//.declare V201 (218)  rf=r size=4 type=d alias=V183+0 align=2 words (r41.15)
//.declare V202 (219)  rf=r size=4 type=d alias=V69+0 align=2 words (r5.0)
//.declare V203 (220)  rf=r size=4 type=d alias=V39+0 align=2 words (r4.3)
//.declare V204 (221)  rf=r size=4 type=d alias=V181+0 align=2 words (r41.14)
//.declare V205 (222)  rf=r size=4 type=ud alias=V69+0 align=2 words (r5.0)
//.declare V206 (223)  rf=r size=4 type=d alias=V70+0 align=2 words (r41.4)
//.declare V207 (224)  rf=r size=4 type=d alias=V40+0 align=2 words (r4.4)
//.declare V208 (225)  rf=r size=4 type=ud alias=V183+0 align=2 words (r41.15)
//.declare V209 (226)  rf=r size=8 type=q alias=V114+0 align=4 words (r41.5)
//.declare V210 (227)  rf=r size=8 type=q alias=V115+0 align=4 words (r41.6)
//.declare V211 (228)  rf=r size=4 type=d alias=V71+0 align=2 words (r41.5)
//.declare V212 (229)  rf=r size=4 type=d alias=V52+0 align=2 words (r5.4)
//.declare V213 (230)  rf=r size=64 type=d alias=V184+0 align=32 words (r99.0)
//.declare V214 (231)  rf=r size=64 type=d alias=V72+0 align=32 words (r57.0)
//.declare V215 (232)  rf=r size=64 type=d alias=V73+0 align=32 words (r7.0)
//.declare V216 (233)  rf=r size=128 type=q alias=V75+0 align=32 words (r10.0)
//.declare V217 (234)  rf=r size=8 type=q alias=V74+0 align=4 words (r5.4)
//.declare V218 (235)  rf=r size=64 type=ud alias=V73+0 align=32 words (r7.0)
//.declare V219 (236)  rf=r size=128 type=uq alias=V75+0 align=32 words (r10.0)
//.declare V220 (237)  rf=r size=4 type=ud alias=V65+0 align=2 words (r41.0)
//.declare V221 (238)  rf=r size=64 type=d alias=V77+0 align=32 words (r3.0)
//.declare V222 (239)  rf=r size=32 type=uw alias=V78+0 align=1 words (r8.0)
//.declare V223 (240)  rf=r size=64 type=uw alias=V77+0 align=32 words (r3.0)
//.declare V224 (241)  rf=r size=32 type=uw alias=V79+0 align=1 words (r11.0)
//.declare V225 (242)  rf=r size=32 type=uw alias=V80+0 align=1 words (r14.0)
//.declare V226 (243)  rf=r size=32 type=uw alias=V81+0 align=1 words (r17.0)
//.declare V227 (244)  rf=r size=64 type=d alias=V85+0 align=32 words (r18.0)
//.declare V228 (245)  rf=r size=64 type=d alias=V89+0 align=32 words (r19.0)
//.declare V229 (246)  rf=r size=64 type=d alias=V83+0 align=32 words (r24.0)
//.declare V230 (247)  rf=r size=32 type=uw alias=V84+0 align=1 words (r25.0)
//.declare V231 (248)  rf=r size=64 type=d alias=V92+0 align=32 words (r35.0)
//.declare V232 (249)  rf=r size=64 type=ud alias=V85+0 align=32 words (r18.0)
//.declare V233 (250)  rf=r size=64 type=ud alias=V184+0 align=32 words (r99.0)
//.declare V234 (251)  rf=r size=32 type=w alias=V86+0 align=1 words (r28.0)
//.declare V235 (252)  rf=r size=64 type=w alias=V85+0 align=32 words (r18.0)
//.declare V236 (253)  rf=r size=32 type=uw alias=V86+0 align=1 words (r28.0)
//.declare V237 (254)  rf=r size=64 type=ud alias=V89+0 align=32 words (r19.0)
//.declare V238 (255)  rf=r size=32 type=w alias=V90+0 align=1 words (r33.0)
//.declare V239 (256)  rf=r size=64 type=w alias=V89+0 align=32 words (r19.0)
//.declare V240 (257)  rf=r size=64 type=d alias=V94+0 align=32 words (r37.0)
//.declare V241 (258)  rf=r size=32 type=uw alias=V90+0 align=1 words (r33.0)
//.declare V242 (259)  rf=r size=64 type=d alias=V91+0 align=32 words (r34.0)
//.declare V243 (260)  rf=r size=64 type=ud alias=V93+0 align=32 words (r36.0)
//.declare V244 (261)  rf=r size=64 type=ud alias=V92+0 align=32 words (r35.0)
//.declare V245 (262)  rf=r size=64 type=ud alias=V82+0 align=32 words (r21.0)
//.declare V246 (263)  rf=r size=64 type=ud alias=V83+0 align=32 words (r24.0)
//.declare V247 (264)  rf=r size=64 type=ud alias=V95+0 align=32 words (r38.0)
//.declare V248 (265)  rf=r size=64 type=ud alias=V94+0 align=32 words (r37.0)
//.declare V249 (266)  rf=r size=64 type=ud alias=V87+0 align=32 words (r29.0)
//.declare V250 (267)  rf=r size=64 type=ud alias=V88+0 align=32 words (r30.0)
//.declare V251 (268)  rf=r size=64 type=ud alias=V91+0 align=32 words (r34.0)
//.declare V252 (269)  rf=r size=64 type=ud alias=V96+0 align=32 words (r39.0)
//.declare V254 (271)  rf=r size=64 type=ud alias=V98+0 align=32 words (r3.0)
//.declare V255 (272)  rf=r size=64 type=ud alias=V101+0 align=32 words (r7.0)
//.declare  (273)  rf=r size=64 type=ud align=32 words (r3.0)
//.declare V256 (274)  rf=r size=4 type=ud alias=V106+0 align=2 words (r7.0)
//.declare V257 (275)  rf=r size=4 type=ud alias=V108+0 align=2 words (r8.0)
//.declare V258 (276)  rf=r size=8 type=uq alias=V118+0 align=4 words (r3.0)
//.declare V259 (277)  rf=r size=8 type=uq alias=V113+0 align=4 words (r41.4)
//.declare V260 (278)  rf=r size=8 type=uq alias=V56+0 align=4 words (r4.3)
//.declare V261 (279)  rf=r size=64 type=q alias=V175+0 align=32 words (r7.0)
//.declare V262 (280)  rf=r size=8 type=uq alias=V119+0 align=4 words (r8.0)
//.declare V263 (281)  rf=r size=8 type=uq alias=V114+0 align=4 words (r41.5)
//.declare V264 (282)  rf=r size=8 type=uq alias=V57+0 align=4 words (r4.4)
//.declare V265 (283)  rf=r size=64 type=q alias=V169+0 align=32 words (r9.0)
//.declare V266 (284)  rf=r size=8 type=uq alias=V120+0 align=4 words (r10.0)
//.declare V267 (285)  rf=r size=8 type=uq alias=V115+0 align=4 words (r41.6)
//.declare V268 (286)  rf=r size=8 type=uq alias=V58+0 align=4 words (r5.1)
//.declare V269 (287)  rf=r size=32 type=q alias=V121+0 align=4 words (r11.0)
//.declare V270 (288)  rf=r size=4 type=d alias=V112+0 align=2 words (r41.6)
//.declare V273 (291)  rf=r size=64 type=ud alias=V169+0 align=32 words (r9.0)
//.declare V274 (292)  rf=r size=64 type=ud alias=V125+0 align=32 words (r13.0)
//.declare V275 (293)  rf=r size=64 type=ud alias=V126+0 align=32 words (r14.0)
//.declare V276 (294)  rf=r size=64 type=ud alias=V116+0 align=32 words (r89.0)
//.declare V277 (295)  rf=r size=64 type=ud alias=V76+0 align=32 words (r63.0)
//.declare V278 (296)  rf=r size=128 type=q alias=V127+0 align=32 words (r17.0)
//.declare V279 (297)  rf=r size=8 type=q alias=V59+0 align=4 words (r5.3)
//.declare V280 (298)  rf=r size=128 type=uq alias=V127+0 align=32 words (r17.0)
//.declare V281 (299)  rf=r size=64 type=ud alias=V171+0 align=32 words (r30.0)
//.declare V282 (300)  rf=r size=192 type=ud alias=V128+0 align=32 words (r20.0)
//.declare V283 (301)  rf=r size=64 type=ud alias=V133+0 align=32 words (r23.0)
//.declare V284 (302)  rf=r size=32 type=w alias=V129+0 align=1 words (r26.0)
//.declare V285 (303)  rf=r size=64 type=w alias=V116+0 align=32 words (r89.0)
//.declare V286 (304)  rf=r size=32 type=uw alias=V129+0 align=1 words (r26.0)
//.declare V287 (305)  rf=r size=32 type=w alias=V131+0 align=1 words (r29.0)
//.declare V288 (306)  rf=r size=32 type=uw alias=V131+0 align=1 words (r29.0)
//.declare V291 (309)  rf=r size=64 type=ud alias=V135+0 align=32 words (r32.0)
//.declare V292 (310)  rf=r size=64 type=ud alias=V139+0 align=32 words (r33.0)
//.declare V293 (311)  rf=r size=64 type=ud alias=V107+0 align=32 words (r69.0)
//.declare V294 (312)  rf=r size=64 type=ud alias=V136+0 align=32 words (r34.0)
//.declare V295 (313)  rf=r size=64 type=ud alias=V109+0 align=32 words (r83.0)
//.declare V296 (314)  rf=r size=64 type=ud alias=V137+0 align=32 words (r35.0)
//.declare V297 (315)  rf=r size=128 type=d alias=V138+0 align=32 words (r36.0)
//.declare V298 (316)  rf=r size=512 type=hf alias=V153+0 align=32 words (r42.0)
//.declare V299 (317)  rf=r size=64 type=hf alias=V134+0 align=32 words (r31.0)
//.declare V300 (318)  rf=r size=128 type=hf alias=V138+0 align=32 words (r36.0)
//.declare V301 (319)  rf=r size=64 type=ud alias=V140+0 align=32 words (r50.0)
//.declare V302 (320)  rf=r size=64 type=ud alias=V144+0 align=32 words (r51.0)
//.declare V303 (321)  rf=r size=64 type=ud alias=V141+0 align=32 words (r52.0)
//.declare V304 (322)  rf=r size=64 type=ud alias=V142+0 align=32 words (r53.0)
//.declare V305 (323)  rf=r size=128 type=d alias=V143+0 align=32 words (r54.0)
//.declare V306 (324)  rf=r size=128 type=hf alias=V143+0 align=32 words (r54.0)
//.declare V307 (325)  rf=r size=64 type=ud alias=V148+0 align=32 words (r56.0)
//.declare V308 (326)  rf=r size=64 type=ud alias=V145+0 align=32 words (r58.0)
//.declare V309 (327)  rf=r size=64 type=ud alias=V146+0 align=32 words (r59.0)
//.declare V310 (328)  rf=r size=128 type=d alias=V147+0 align=32 words (r60.0)
//.declare V311 (329)  rf=r size=128 type=hf alias=V147+0 align=32 words (r60.0)
//.declare V313 (331)  rf=r size=64 type=ud alias=V154+0 align=32 words (r62.0)
//.declare V314 (332)  rf=r size=64 type=ud alias=V150+0 align=32 words (r64.0)
//.declare V315 (333)  rf=r size=64 type=ud alias=V151+0 align=32 words (r65.0)
//.declare V316 (334)  rf=r size=128 type=d alias=V152+0 align=32 words (r66.0)
//.declare V317 (335)  rf=r size=128 type=hf alias=V152+0 align=32 words (r66.0)
//.declare V319 (337)  rf=r size=64 type=ud alias=V159+0 align=32 words (r68.0)
//.declare V320 (338)  rf=r size=64 type=ud alias=V156+0 align=32 words (r70.0)
//.declare V321 (339)  rf=r size=64 type=ud alias=V157+0 align=32 words (r71.0)
//.declare V322 (340)  rf=r size=128 type=d alias=V158+0 align=32 words (r72.0)
//.declare V323 (341)  rf=r size=512 type=hf alias=V174+0 align=32 words (r74.0)
//.declare V324 (342)  rf=r size=128 type=hf alias=V158+0 align=32 words (r72.0)
//.declare V326 (344)  rf=r size=64 type=ud alias=V164+0 align=32 words (r82.0)
//.declare V327 (345)  rf=r size=64 type=ud alias=V161+0 align=32 words (r84.0)
//.declare V328 (346)  rf=r size=64 type=ud alias=V162+0 align=32 words (r85.0)
//.declare V329 (347)  rf=r size=128 type=d alias=V163+0 align=32 words (r86.0)
//.declare V330 (348)  rf=r size=128 type=hf alias=V163+0 align=32 words (r86.0)
//.declare V332 (350)  rf=r size=64 type=ud alias=V170+0 align=32 words (r88.0)
//.declare V333 (351)  rf=r size=64 type=ud alias=V166+0 align=32 words (r90.0)
//.declare V334 (352)  rf=r size=64 type=ud alias=V167+0 align=32 words (r91.0)
//.declare V335 (353)  rf=r size=128 type=d alias=V168+0 align=32 words (r92.0)
//.declare V336 (354)  rf=r size=128 type=hf alias=V168+0 align=32 words (r92.0)
//.declare V337 (355)  rf=r size=64 type=ud alias=V172+0 align=32 words (r94.0)
//.declare V338 (356)  rf=r size=128 type=d alias=V173+0 align=32 words (r95.0)
//.declare V339 (357)  rf=r size=128 type=hf alias=V173+0 align=32 words (r95.0)
//.declare V340 (358)  rf=r size=4 type=ud alias=V70+0 align=2 words (r41.4)
//.declare V341 (359)  rf=r size=4 type=ud alias=V123+0 align=2 words (r12.0)
//.declare V342 (360)  rf=r size=64 type=f alias=V117+0 align=32 words (r98.0)
//.declare V343 (361)  rf=r size=64 type=w alias=V117+0 align=32 words (r98.0)
//.declare V344 (362)  rf=r size=4 type=d alias=V67+0 align=2 words (r41.2)
//.declare V345 (363)  rf=r size=32 type=hf alias=V176+0 align=1 words (r1.16)
//.declare V346 (364)  rf=r size=32 type=uw alias=V176+0 align=1 words (r1.16)
//.declare V347 (365)  rf=r size=4 type=d alias=V182+0 align=2 words (r1.2)
//.declare V348 (366)  rf=r size=4 type=ud alias=V182+0 align=2 words (r1.2)
//.declare V349 (367)  rf=r size=4 type=ud alias=V36+0 align=2 words (r4.0)
//.declare V350 (368)  rf=r size=4 type=ud alias=V180+0 align=2 words (r41.7)
//.declare V351 (369)  rf=r size=4 type=ud alias=V38+0 align=2 words (r4.2)
//.declare V352 (370)  rf=r size=4 type=d alias=V179+0 align=2 words (r3.0)
//.declare V353 (371)  rf=r size=4 type=d alias=V41+0 align=2 words (r4.5)
//.declare V354 (372)  rf=r size=128 type=q alias=V186+0 align=32 words (r8.0)
//.declare V355 (373)  rf=r size=8 type=q alias=V185+0 align=4 words (r4.5)
//.declare V356 (374)  rf=r size=4 type=ud alias=V181+0 align=2 words (r41.14)
//.declare V357 (375)  rf=r size=64 type=ud alias=V72+0 align=32 words (r57.0)
//.declare V358 (376)  rf=r size=128 type=uq alias=V186+0 align=32 words (r8.0)
//.declare  (377)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (378)  rf=r size=16 type=w align=16 words (r6.0)
//.declare  (379)  rf=r size=128 type=ud align=32 words (r8.0)
//.declare  (380)  rf=r size=16 type=w align=16 words (r22.0)
//.declare  (382)  rf=r size=64 type=uw align=32 words (r6.0)
//.declare  (383)  rf=r size=32 type=uw align=32 words (r7.0)
//.declare  (384)  rf=r size=64 type=uw align=32 words (r9.0)
//.declare  (385)  rf=r size=32 type=uw align=32 words (r10.0)
//.declare  (386)  rf=r size=64 type=uw align=32 words (r12.0)
//.declare  (387)  rf=r size=32 type=uw align=32 words (r13.0)
//.declare  (388)  rf=r size=64 type=uw align=32 words (r15.0)
//.declare  (389)  rf=r size=32 type=uw align=32 words (r16.0)
//.declare  (390)  rf=r size=64 type=w align=32 words (r26.0)
//.declare  (391)  rf=r size=32 type=w align=32 words (r27.0)
//.declare  (392)  rf=r size=64 type=w align=32 words (r31.0)
//.declare  (393)  rf=r size=32 type=w align=32 words (r32.0)
//.declare  (394)  rf=r size=128 type=ud align=32 words (r15.0)
//.declare  (395)  rf=r size=64 type=w align=32 words (r24.0)
//.declare  (396)  rf=r size=32 type=w align=32 words (r25.0)
//.declare  (397)  rf=r size=64 type=w align=32 words (r27.0)
//.declare  (398)  rf=r size=32 type=w align=32 words (r28.0)
//.declare  (399)  rf=r size=128 type=ud align=32 words (r6.0)
//.declare r0 (400)  rf=r size=64 type=ud align=32 words (r0.0)
//.declare rtmp (401)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (402)  rf=r size=64 type=ud align=32 words (r1.0)
//.declare  (403)  rf=r size=256 type=ud align=32 words (r2.0)

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
// | V74      | :uq      |    0x8 | r5+0x20  | cti+0xE0         |
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
// _ZTS22int1_fp16_upcvt_kernelILi1ELi512ELi1ELi16ELi32ELi1ELi1ELb1EE_BB_0:
(W)     mov (16|M0)              r40.0<1>:ud   r0.0<1;1,0>:ud                                        //  ALU pipe: int; $1
        and (1|M0)               cr0.0<1>:ud   cr0.0<0;1,0>:ud   -1073743089:d               {A@1}   // $1
        or (1|M0)                cr0.0<1>:ud   cr0.0<0;1,0>:ud   1073743040:d               {A@1}    // $2
        sync.nop                             null                             {Compacted,A@1}        // $4
        sync.nop                             null                             {Compacted,$1.dst}     // $4
        mul (2|M0)               r1.2<1>:d     r2.0<1;1,0>:d     r1.2<0;1,0>:uw   {A@1,$0.dst}       //  ALU pipe: int; $4
        mov (1|M0)               r41.7<1>:d    r0.1<0;1,0>:ud                                        //  ALU pipe: int; $9
        add (2|M0)               r2.3<1>:d     r1.2<1;1,0>:d     r1.0<1;1,0>:uw   {I@2}              //  ALU pipe: int; $5
        mov (8|M0)               r6.0<1>:w     0x76543210:v                                          //  ALU pipe: int; $24
(W)     mul (1|M0)               acc0.0<1>:d   r2.4<0;1,0>:d     r2.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $6
        macl (1|M0)              r3.0<1>:d     r2.4<0;1,0>:d     r2.0<0;1,0>:d                       //  ALU pipe: int; $7
        shl (1|M0)               r41.7<1>:d    r41.7<0;1,0>:d    9:w                                 //  ALU pipe: int; $11
        add (1|M0)               r4.12<1>:d    r3.0<0;1,0>:d     r1.0<0;1,0>:uw   {I@2}              //  ALU pipe: int; $7
        mov (8|M0)               r99.0<1>:d    r6.0<1;1,0>:w                                         //  ALU pipe: int; $24
        and (1|M0)               r41.0<1>:d    r4.12<0;1,0>:d    31:w               {I@2}            //  ALU pipe: int; $8
        add (8|M0)               r99.8<1>:d    r99.0<1;1,0>:d    8:w               {I@2}             //  ALU pipe: int; $25
        shl (1|M0)               r41.3<1>:d    r41.0<0;1,0>:d    4:w               {I@2}             //  ALU pipe: int; $14
        mov (1|M0)               r41.14<1>:d   r0.6<0;1,0>:ud                                        //  ALU pipe: int; $10
        or (1|M0)                r41.15<1>:d   r41.7<0;1,0>:d    r41.3<0;1,0>:d   {I@2}              //  ALU pipe: int; $15
        shl (1|M0)               r5.0<1>:d     r4.3<0;1,0>:d     1:w               {Compacted}       //  ALU pipe: int; $16
        or (16|M0)               r57.0<1>:d    r41.15<0;1,0>:d   r99.0<1;1,0>:d   {I@2}              //  ALU pipe: int; $26
        shl (16|M0)              r7.0<1>:d     r57.0<1;1,0>:d    2:w               {Compacted,I@1}   //  ALU pipe: int; $27
        mov (16|M0)              r8.0<2>:ud    r7.0<1;1,0>:ud                   {I@1}                //  ALU pipe: int; $28
        add (16|M0)              r10.0<1>:q    r5.4<0;1,0>:q     r8.0<2;1,0>:ud   {I@1}              //  ALU pipe: int; $28
        load.ugm.d32.a64.ca.ca (16|M0)  r63:1   [r10:2]            {I@1,$2} // ex_desc:0x0; desc:0x4180580 // $29
        cmp (1|M0)    (lt)f2.0   null<1>:ud    r41.0<0;1,0>:ud   0x10:uw                             //  ALU pipe: int; $30
(W)     mul (1|M0)               acc0.0<1>:d   r5.0<0;1,0>:d     r41.28<0;1,0>:uw                    //  ALU pipe: int; $17
        add (1|M0)               r41.1<1>:d    r4.1<0;1,0>:d     31:w                                //  ALU pipe: int; $12
        mov (1|M0)               r41.6<1>:q    r41.15<0;1,0>:ud                                      //  ALU pipe: int; $20
        macl (1|M0)              r5.0<1>:d     r5.0<0;1,0>:d     r41.14<0;1,0>:d                     //  ALU pipe: int; $18
        shl (1|M0)               r41.4<1>:d    r4.4<0;1,0>:d     2:w                                 //  ALU pipe: int; $19
        shl (1|M0)               r41.5<1>:d    r5.4<0;1,0>:d     1:w                                 //  ALU pipe: int; $22
        shr (1|M0)               r41.2<1>:ud   r41.1<0;1,0>:ud   0x5:uw              {I@5}           //  ALU pipe: int; $13
        shl (1|M0)               r41.5<1>:q    r41.6<0;1,0>:q    2:w               {I@5}             //  ALU pipe: int; $21
        mov (1|M0)               r41.4<1>:q    r5.0<0;1,0>:ud                   {I@5}                //  ALU pipe: int; $18
        shl (1|M0)               r41.6<1>:q    r41.6<0;1,0>:q    1:w                                 //  ALU pipe: int; $23
(W&~f2.0) jmpi                               BB_1                                                    //  ALU pipe: int; $31
// B003: Preds:{B002},  Succs:{B004, B005}
_L_k25_0_:
        or (16|M0)               r3.0<1>:d     r41.3<0;1,0>:d    r99.0<1;1,0>:d                      //  ALU pipe: int; $32
        shr (16|M0)              r6.0<2>:uw    r3.0<2;1,0>:uw    0x4:uw              {I@1}           //  ALU pipe: int; $33
        shr (16|M0)              r9.0<2>:uw    r3.0<2;1,0>:uw    0x5:uw                              //  ALU pipe: int; $35
        shr (16|M0)              r12.0<2>:uw   r3.0<2;1,0>:uw    0x6:uw                              //  ALU pipe: int; $37
        mov (16|M0)              r7.0<1>:uw    r6.0<2;1,0>:uw                   {I@3}                //  ALU pipe: int; $33
        mov (16|M0)              r10.0<1>:uw   r9.0<2;1,0>:uw                   {@3,$2.src}          //  ALU pipe: int; $35
        mov (16|M0)              r13.0<1>:uw   r12.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $37
        mov (16|M0)              r8.0<1>:hf    r7.0<1;1,0>:hf                   {I@3}                //  ALU pipe: float; $33
        mov (16|M0)              r11.0<1>:hf   r10.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $35
        mov (16|M0)              r14.0<1>:hf   r13.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $37
        and (16|M0)              r8.0<1>:uw    r8.0<1;1,0>:uw    0x1:uw              {F@3}           //  ALU pipe: int; $34
        and (16|M0)              r11.0<1>:uw   r11.0<1;1,0>:uw   0x1:uw              {F@2}           //  ALU pipe: int; $36
        and (16|M0)              r14.0<1>:uw   r14.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $38
        add (16|M0)              r18.0<1>:d    r8.0<1;1,0>:uw    r11.0<1;1,0>:uw  {I@2}              //  ALU pipe: int; $41
        add (16|M0)              r19.0<1>:d    r18.0<1;1,0>:d    r14.0<1;1,0>:uw  {I@1}              //  ALU pipe: int; $42
        mov (8|M0)               r25.0<1>:w    0x76543210:v                                          //  ALU pipe: int; $48
        mov (8|M0)               r25.8<1>:w    0xFEDCBA98:uv                                         //  ALU pipe: int; $49
        shr (16|M0)              r15.0<2>:uw   r3.0<2;1,0>:uw    0x7:uw                              //  ALU pipe: int; $39
        shr (16|M0)              r19.0<1>:ud   r99.0<1;1,0>:ud   r19.0<1;1,0>:ud  {I@4}              //  ALU pipe: int; $60 R{} IR{}{O:1,O:1,},  {BC=1}
        mov (8|M0)               r22.0<1>:w    0x10101010:v                                          //  ALU pipe: int; $44
        shr (16|M0)              r18.0<1>:ud   r99.0<1;1,0>:ud   r18.0<1;1,0>:ud                     //  ALU pipe: int; $55
        shr (16|M0)              r25.0<1>:uw   r25.0<1;1,0>:uw   r8.0<1;1,0>:uw   {I@5}              //  ALU pipe: int; $50
        mov (16|M0)              r16.0<1>:uw   r15.0<2;1,0>:uw                  {I@5}                //  ALU pipe: int; $39
        shl (16|M0)              r31.0<2>:w    r19.0<2;1,0>:w    15:w               {I@5}            //  ALU pipe: int; $61
        mov (8|M0)               r24.0<1>:d    r22.0<1;1,0>:w                   {I@5}                //  ALU pipe: int; $44
        mov (8|M0)               r24.8<1>:d    r22.0<1;1,0>:w                                        //  ALU pipe: int; $45
        shl (16|M0)              r26.0<2>:w    r18.0<2;1,0>:w    15:w               {I@6}            //  ALU pipe: int; $56
        shl (16|M0)              r25.0<1>:uw   r25.0<1;1,0>:uw   0xF:uw              {I@6}           //  ALU pipe: int; $51
        mov (16|M0)              r17.0<1>:hf   r16.0<1;1,0>:hf                  {I@6}                //  ALU pipe: float; $39
        mov (16|M0)              r32.0<1>:w    r31.0<2;1,0>:w                   {I@5}                //  ALU pipe: int; $61
        mul (16|M0)              acc0.0<1>:d   r24.0<1;1,0>:d    0x8000:uw              {I@4}        //  ALU pipe: int; $46
        mov (16|M0)              r27.0<1>:w    r26.0<2;1,0>:w                   {I@4}                //  ALU pipe: int; $56
        or (16|M0)               r25.0<1>:uw   r25.0<1;1,0>:uw   0x3C00:uw              {I@4}        //  ALU pipe: int; $52
        and (16|M0)              r17.0<1>:uw   r17.0<1;1,0>:uw   0x1:uw              {F@1}           //  ALU pipe: int; $40
        mov (16|M0)              r33.0<1>:hf   r32.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $61
        add (16|M0)              r24.0<1>:d    acc0.0<1;1,0>:d   15360:w                             //  ALU pipe: int; $47
        mov (16|M0)              acc0.0<1>:d   -r11.0<1;1,0>:uw                                      //  ALU pipe: int; $53
        mov (16|M0)              r28.0<1>:hf   r27.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $56
        or (16|M0)               r33.0<1>:w    r33.0<1;1,0>:w    15360:w               {F@2}         //  ALU pipe: int; $62
        and (16|M0)              acc0.0<1>:d   r25.0<1;1,0>:uw   acc0.0<1;1,0>:d  {I@5}              //  ALU pipe: int; $54
        mov (16|M0)              acc2.0<1>:d   -r17.0<1;1,0>:uw                 {I@5}                //  ALU pipe: int; $63
        or (16|M0)               r28.0<1>:w    r28.0<1;1,0>:w    15360:w               {F@1}         //  ALU pipe: int; $57
        and (16|M0)              acc2.0<1>:d   r33.0<1;1,0>:uw   acc2.0<1;1,0>:d  {I@4}              //  ALU pipe: int; $64
        shl (16|M0)              r34.0<1>:d    r3.0<1;1,0>:d     3:w                                 //  ALU pipe: int; $65
        mov (16|M0)              r21.0<1>:d    -r8.0<1;1,0>:uw                                       //  ALU pipe: int; $43
        mov (16|M0)              r30.0<1>:d    -r14.0<1;1,0>:uw                                      //  ALU pipe: int; $59
        mov (16|M0)              r29.0<1>:d    r28.0<1;1,0>:uw                  {I@5}                //  ALU pipe: int; $58
        shl (16|M0)              r35.0<1>:d    acc0.0<1;1,0>:d   16:w                                //  ALU pipe: int; $66
        shl (16|M0)              r37.0<1>:d    acc2.0<1;1,0>:d   16:w                                //  ALU pipe: int; $68
        cmp (1|M0)    (eq)f1.1   null<1>:d     r41.0<0;1,0>:d    0:w                                 //  ALU pipe: int; $73
        or (16|M0)               r39.0<1>:ud   r34.0<1;1,0>:ud   0x4:uw              {I@7}           //  ALU pipe: int; $71
        bfn.(s0|s1&s2) (16|M0)   r36.0<1>:ud   r35.0<1;0>:ud     r21.0<1;0>:ud     r24.0<1>:ud      {I@4} //  ALU pipe: int; $67
        bfn.(s0|s1&s2) (16|M0)   r38.0<1>:ud   r37.0<1;0>:ud     r29.0<1;0>:ud     r30.0<1>:ud      {I@4} //  ALU pipe: int; $69
        store.slm.d32.a32 (16|M0)  [r34:1]      r36:1              {I@2,$3} // ex_desc:0x0; desc:0x2000504 // $70
        store.slm.d32.a32 (16|M0)  [r39:1]      r38:1              {I@1,$4} // ex_desc:0x0; desc:0x2000504 // $72
(W&~f1.1) jmpi                               BB_1                                                    //  ALU pipe: int; $74
// B004: Preds:{B003},  Succs:{B005}
_L_k25_1_:
        mul (16|M0)              acc0.0<1>:ud  r99.0<1;1,0>:ud   0x4:uw                              //  ALU pipe: int; $75
        mov (16|M0)              r6.0<1>:d     1920:w                               {Compacted}      //  ALU pipe: int; $78
        mov (16|M0)              r8.0<1>:d     120:w                               {Compacted}       //  ALU pipe: int; $82
        add (16|M0)              r3.0<1>:ud    acc0.0<1;1,0>:ud  0x800:uw                            //  ALU pipe: int; $76
        add (16|M0)              r7.0<1>:ud    acc0.0<1;1,0>:ud  0x840:uw                            //  ALU pipe: int; $80
        store.slm.d32.a32 (16|M0)  [r3:1]       r6:1               {I@2,$5} // ex_desc:0x0; desc:0x2000504 // $79
        store.slm.d32.a32 (16|M0)  [r7:1]       r8:1               {I@1,$6} // ex_desc:0x0; desc:0x2000504 // $83
// B005: Preds:{B004, B003, B002},  Succs:{B006, B009}
BB_1:
        sync.nop                             null                             {$5.src}               // $85
(W)     send.slm (1|M0)          r3       r40  null:0  0x0            0x0210001F           {$7} // wr:1+0, rd:1; fence.slm.none.group // $85
        mov (16|M0)              r6.0<1>:f     0x20200000:f                               {Compacted} //  (0x20200000:f); ALU pipe: float; $87
(W)     mov (8|M0)               null<1>:ud    r3.0<1;1,0>:ud                   {Compacted,$7.dst}   //  memory fence commit; ALU pipe: int; $88
        send.gtwy (1|M0)         null     r6  null:0  0x0            0x02000004           {F@1,$8} // wr:1+0, rd:0; signal barrier // $88
(W)     sync.bar                             0:w                                                     // $89
        mov (1|M0)               r7.0<1>:d     2048:w                               {$6.src}         //  ALU pipe: int; $90
        mov (1|M0)               r8.0<1>:d     2112:w                                                //  ALU pipe: int; $92
        load.slm.d32x16t.a32 (1|M0)  r69:1      [r7:1]             {I@2,$9} // ex_desc:0x0; desc:0x210D500 // $91
        load.slm.d32x16t.a32 (1|M0)  r83:1      [r8:1]             {I@1,$10} // ex_desc:0x0; desc:0x210D500 // $93
        cmp (1|M0)    (lt)f1.0   null<1>:ud    r41.1<0;1,0>:ud   0x20:uw                             //  ALU pipe: int; $95
(W&f1.0) jmpi                                BB_2                                                    //  ALU pipe: int; $96
// B006: Preds:{B005},  Succs:{B007}
_L_k25_2_:
        mov (16|M0)              r89.0<1>:d    0:w                               {Compacted}         //  ALU pipe: int; $99
        mov (16|M0)              r98.0<1>:f    0.0:f                               {Compacted}       //  ALU pipe: float; $101
        sel (1|M0)    (ge)f0.0   r41.2<1>:ud   r41.2<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $97
        mov (1|M0)               r41.6<1>:d    0:w                                                   //  ALU pipe: int; $102
// B007: Preds:{B007, B006},  Succs:{B008, B007}
BB_3:
        shr (1|M0)               r3.0<1>:uq    r41.4<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $104
        shr (1|M0)               r8.0<1>:uq    r41.5<0;1,0>:uq   0x3:uw              {$10.src}       //  ALU pipe: int; $109
        shr (1|M0)               r10.0<1>:uq   r41.6<0;1,0>:uq   0x3:uw              {$2.src}        //  ALU pipe: int; $114
        shl (1|M0)               r3.0<1>:uq    r3.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $105
        shl (1|M0)               r8.0<1>:uq    r8.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $110
        shl (1|M0)               r10.0<1>:uq   r10.0<0;1,0>:uq   0x3:uw              {I@3}           //  ALU pipe: int; $115
        add (1|M0)               r3.0<1>:uq    r4.3<0;1,0>:uq    r3.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $106
        add (1|M0)               r8.0<1>:uq    r4.4<0;1,0>:uq    r8.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $111
        add (1|M0)               r10.0<1>:uq   r5.1<0;1,0>:uq    r10.0<0;1,0>:uq  {I@3}              //  ALU pipe: int; $116
        sync.nop                             null                             {$9.src}               // $108
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r7:1  [r3:1]             {I@3,$11} // ex_desc:0x0; desc:0x218C780 // $108
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r9:1  [r8:1]             {I@2,$12} // ex_desc:0x0; desc:0x218C780 // $113
        load.ugm.d64x4t.a64.ca.ca (1|M0)  r11:1 [r10:1]            {I@1,$13} // ex_desc:0x0; desc:0x218B780 // $118
        add (1|M0)               r41.6<1>:d    r41.6<0;1,0>:d    1:w                                 //  ALU pipe: int; $119
        and (1|M0)    (eq)f0.1   null<1>:d     r41.6<0;1,0>:d    3:w               {I@1}             //  ALU pipe: int; $123
        add (1|M0)               r41.4<1>:uq   r41.4<0;1,0>:uq   0x40:uw                             //  ALU pipe: int; $122
(f0.1)  sel (1|M0)               r12.0<1>:d    r41.5<0;1,0>:d    0:w                                 //  ALU pipe: int; $125
        shr (16|M0)              acc0.0<1>:ud  r9.0<1;1,0>:ud    0x1:uw              {$12.dst}       //  ALU pipe: int; $127
        shr (16|M0)              acc2.0<1>:ud  r89.0<1;1,0>:ud   0x5:uw                              //  ALU pipe: int; $129
        add (16|M0)              acc2.0<1>:ud  acc2.0<1;1,0>:ud  r63.0<1;1,0>:ud  {$2.dst}           //  ALU pipe: int; $130
        shl (16|M0)              r14.0<1>:ud   acc2.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $131
        mov (16|M0)              r15.0<2>:ud   r14.0<1;1,0>:ud                  {I@1}                //  ALU pipe: int; $132
        add (16|M0)              r17.0<1>:q    r5.3<0;1,0>:q     r15.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $132
        load.ugm.d32x3.a64.ca.ca (16|M0)  r20:3 [r17:2]            {I@1,$14} // ex_desc:0x0; desc:0x4382580 // $134
        and (16|M0)   (eq)f3.0   r24.0<2>:w    r89.0<2;1,0>:w    31:w                                //  ALU pipe: int; $137
        mov (16|M0)              r27.0<2>:w    -r89.0<2;1,0>:w                                       //  ALU pipe: int; $139
        mov (16|M0)              r28.0<1>:w    r27.0<2;1,0>:w                   {I@1}                //  ALU pipe: int; $139
        mov (16|M0)              r25.0<1>:w    r24.0<2;1,0>:w                                        //  ALU pipe: int; $137
        mov (16|M0)              r29.0<1>:hf   r28.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $139
        shl (16|M0)              r32.0<1>:ud   r9.0<1;1,0>:ud    0x7:uw                              //  ALU pipe: int; $149
        mov (16|M0)              r26.0<1>:hf   r25.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $137
        bfn.(s0&~s2|s1&s2) (16|M0)   acc2.0<1>:ud  r20.0<1;0>:ud  r21.0<1;0>:ud    0x0:uw              {$14.dst} //  ALU pipe: int; $135
        bfn.(s0&~s2|s1&s2) (16|M0)   r23.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud     0x0:uw              //  ALU pipe: int; $136
        and (16|M0)              r29.0<1>:w    r29.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $140
        shl (16|M0)              r50.0<1>:ud   r9.0<1;1,0>:ud    0x3:uw              {Compacted}     //  ALU pipe: int; $160
        and (16|M0)              r33.0<1>:ud   r32.0<1;1,0>:ud   r69.0<1;1,0>:ud  {Compacted,@5,$9.dst} //  ALU pipe: int; $150
        shr (16|M0)              r30.0<1>:ud   acc2.0<1;1,0>:ud  r26.0<1;1,0>:uw  {F@1}              //  ALU pipe: int; $142
        shl (16|M0)              r23.0<1>:ud   r23.0<1;1,0>:ud   r29.0<1;1,0>:uw  {I@4}              //  ALU pipe: int; $143
        and (16|M0)              r51.0<1>:ud   r50.0<1;1,0>:ud   r69.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $161
        cbit (16|M0)             r33.0<1>:ud   r33.0<1;1,0>:ud                  {Compacted,I@4}      //  ALU pipe: int; $158
(~f3.0) or (16|M0)               r30.0<1>:ud   r23.0<1;1,0>:ud   r30.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $145
        cbit (16|M0)             r51.0<1>:ud   r51.0<1;1,0>:ud                  {I@3}                //  ALU pipe: int; $169
        shr (16|M0)              acc2.0<1>:ud  r30.0<1;1,0>:ud   r33.0<1;1,0>:ud  {I@2}              //  ALU pipe: int; $159
        shl (16|M0)              r52.0<1>:ud   acc2.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $162
        shr (16|M0)              acc2.0<1>:ud  acc2.0<1;1,0>:ud  r51.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $170
        and (16|M0)              r56.0<1>:ud   acc0.0<1;1,0>:ud  r69.0<1;1,0>:ud                     //  ALU pipe: int; $171
        shl (16|M0)              r58.0<1>:ud   acc2.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $172
        cbit (16|M0)             r56.0<1>:ud   r56.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $179
        and (16|M0)              r58.0<1>:ud   r58.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,@2,$10.dst} //  ALU pipe: int; $173
        bfn.(s0&s1|s2) (16|M0)   r59.0<1>:ud   acc0.0<1;0>:ud    r69.0<1;0>:ud     r58.0<1>:ud      {I@1} //  ALU pipe: int; $174
        shr (16|M0)              acc0.0<1>:ud  acc2.0<1;1,0>:ud  r56.0<1;1,0>:ud                     //  ALU pipe: int; $180
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $181
        and (16|M0)              r62.0<1>:ud   acc2.0<1;1,0>:ud  r69.0<1;1,0>:ud                     //  ALU pipe: int; $182
        shl (16|M0)              r64.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $183
        cbit (16|M0)             r62.0<1>:ud   r62.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $190
        and (16|M0)              r64.0<1>:ud   r64.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $184
        bfn.(s0&s1|s2) (16|M0)   r65.0<1>:ud   acc2.0<1;0>:ud    r69.0<1;0>:ud     r64.0<1>:ud      {I@1} //  ALU pipe: int; $185
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r62.0<1;1,0>:ud                     //  ALU pipe: int; $191
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $192
        and (16|M0)              r68.0<1>:ud   acc2.0<1;1,0>:ud  r69.0<1;1,0>:ud                     //  ALU pipe: int; $193
        shl (16|M0)              r70.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $194
        cbit (16|M0)             r68.0<1>:ud   r68.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $201
        and (16|M0)              r70.0<1>:ud   r70.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $195
        bfn.(s0&s1|s2) (16|M0)   r71.0<1>:ud   acc2.0<1;0>:ud    r69.0<1;0>:ud     r70.0<1>:ud      {I@1} //  ALU pipe: int; $196
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r68.0<1;1,0>:ud                     //  ALU pipe: int; $202
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $203
        and (16|M0)              r82.0<1>:ud   acc2.0<1;1,0>:ud  r69.0<1;1,0>:ud                     //  ALU pipe: int; $204
        shl (16|M0)              r84.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $205
        cbit (16|M0)             r82.0<1>:ud   r82.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $212
        and (16|M0)              r84.0<1>:ud   r84.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $206
        bfn.(s0&s1|s2) (16|M0)   r85.0<1>:ud   acc2.0<1;0>:ud    r69.0<1;0>:ud     r84.0<1>:ud      {I@1} //  ALU pipe: int; $207
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r82.0<1;1,0>:ud                     //  ALU pipe: int; $213
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $214
        and (16|M0)              r88.0<1>:ud   acc2.0<1;1,0>:ud  r69.0<1;1,0>:ud                     //  ALU pipe: int; $215
        shl (16|M0)              r90.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $216
        cbit (16|M0)             r88.0<1>:ud   r88.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $224
        and (16|M0)              r90.0<1>:ud   r90.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $217
        bfn.(s0&s1|s2) (16|M0)   r91.0<1>:ud   acc2.0<1;0>:ud    r69.0<1;0>:ud     r90.0<1>:ud      {I@1} //  ALU pipe: int; $218
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r88.0<1;1,0>:ud                     //  ALU pipe: int; $225
        shl (16|M0)              r34.0<1>:ud   r30.0<1;1,0>:ud   0x3:uw              {Compacted,$3.src} //  ALU pipe: int; $151
        shl (16|M0)              r30.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $226
        cbit (16|M0)             r13.0<1>:ud   r9.0<1;1,0>:ud                   {Compacted}          //  ALU pipe: int; $128
        and (16|M0)              r52.0<1>:ud   r52.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $163
        and (16|M0)              r34.0<1>:ud   r34.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $152
        and (16|M0)              r30.0<1>:ud   r30.0<1;1,0>:ud   r83.0<1;1,0>:ud  {Compacted,I@4}    //  ALU pipe: int; $227
        shr (16|M0)              r9.0<1>:ud    r9.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $223
        bfn.(s0&s1|s2) (16|M0)   r53.0<1>:ud   r50.0<1;0>:ud     r69.0<1;0>:ud     r52.0<1>:ud      {I@4} //  ALU pipe: int; $164
        bfn.(s0&s1|s2) (16|M0)   r35.0<1>:ud   r32.0<1;0>:ud     r69.0<1;0>:ud     r34.0<1>:ud      {I@4} //  ALU pipe: int; $153
        bfn.(s0&s1|s2) (16|M0)   r94.0<1>:ud   r9.0<1;0>:ud      r69.0<1;0>:ud     r30.0<1>:ud      {I@3} //  ALU pipe: int; $228
        load.slm.d32x2.a32 (16|M0)  r60:2       [r59:1]            {$15} // ex_desc:0x0; desc:0x2201500 // $176
        load.slm.d32x2.a32 (16|M0)  r66:2       [r65:1]            {$0} // ex_desc:0x0; desc:0x2201500 // $187
        load.slm.d32x2.a32 (16|M0)  r72:2       [r71:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $198
        load.slm.d32x2.a32 (16|M0)  r86:2       [r85:1]            {$5} // ex_desc:0x0; desc:0x2201500 // $209
        load.slm.d32x2.a32 (16|M0)  r92:2       [r91:1]            {$6} // ex_desc:0x0; desc:0x2201500 // $220
        load.slm.d32x2.a32 (16|M0)  r54:2       [r53:1]            {I@3,$7} // ex_desc:0x0; desc:0x2201500 // $166
        load.slm.d32x2.a32 (16|M0)  r36:2       [r35:1]            {I@2,$12} // ex_desc:0x0; desc:0x2201500 // $155
        load.slm.d32x2.a32 (16|M0)  r95:2       [r94:1]            {I@1,$14} // ex_desc:0x0; desc:0x2201500 // $230
        mov (16|M0)              r31.0<2>:uw   r11.0<1;1,0>:uw                  {$13.dst}            //  ALU pipe: int; $147
        mov (16|M0)              r31.1<2>:uw   r11.0<1;1,0>:uw                                       //  ALU pipe: int; $148
        add (1|M0)               r41.5<1>:q    r41.5<0;1,0>:q    r41.4<0;1,0>:ud                     //  ALU pipe: int; $233
        add (1|M0)               r41.6<1>:q    r41.6<0;1,0>:q    r12.0<0;1,0>:ud                     //  ALU pipe: int; $234
        add (16|M0)              r89.0<1>:ud   r13.0<1;1,0>:ud   r89.0<1;1,0>:ud  {Compacted}        //  ALU pipe: int; $235
        sync.nop                             null                             {Compacted,I@4}        // $156
        mul (32|M0)              r42.0<1>:hf   r31.0<1;1,0>:hf   r36.0<1;1,0>:hf  {$12.dst}          //  ALU pipe: float; $156
        mul (32|M0)              r43.0<1>:hf   r31.0<1;1,0>:hf   r37.0<1;1,0>:hf                     //  ALU pipe: float; $157
        mul (32|M0)              r44.0<1>:hf   r31.0<1;1,0>:hf   r54.0<1;1,0>:hf  {$7.dst}           //  ALU pipe: float; $167
        mul (32|M0)              r45.0<1>:hf   r31.0<1;1,0>:hf   r55.0<1;1,0>:hf                     //  ALU pipe: float; $168
        mul (32|M0)              r46.0<1>:hf   r31.0<1;1,0>:hf   r60.0<1;1,0>:hf  {$15.dst}          //  ALU pipe: float; $177
        mul (32|M0)              r47.0<1>:hf   r31.0<1;1,0>:hf   r61.0<1;1,0>:hf                     //  ALU pipe: float; $178
        mul (32|M0)              r48.0<1>:hf   r31.0<1;1,0>:hf   r66.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $188
        mul (32|M0)              r49.0<1>:hf   r31.0<1;1,0>:hf   r67.0<1;1,0>:hf                     //  ALU pipe: float; $189
        mul (32|M0)              r74.0<1>:hf   r31.0<1;1,0>:hf   r72.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $199
        mul (32|M0)              r75.0<1>:hf   r31.0<1;1,0>:hf   r73.0<1;1,0>:hf                     //  ALU pipe: float; $200
        mul (32|M0)              r76.0<1>:hf   r31.0<1;1,0>:hf   r86.0<1;1,0>:hf  {$5.dst}           //  ALU pipe: float; $210
        mul (32|M0)              r77.0<1>:hf   r31.0<1;1,0>:hf   r87.0<1;1,0>:hf                     //  ALU pipe: float; $211
        mul (32|M0)              r78.0<1>:hf   r31.0<1;1,0>:hf   r92.0<1;1,0>:hf  {$6.dst}           //  ALU pipe: float; $221
        mul (32|M0)              r79.0<1>:hf   r31.0<1;1,0>:hf   r93.0<1;1,0>:hf                     //  ALU pipe: float; $222
        mul (32|M0)              r80.0<1>:hf   r31.0<1;1,0>:hf   r95.0<1;1,0>:hf  {$14.dst}          //  ALU pipe: float; $231
        mul (32|M0)              r81.0<1>:hf   r31.0<1;1,0>:hf   r96.0<1;1,0>:hf                     //  ALU pipe: float; $232
        sync.nop                             null                             {Compacted,F@7}        // $237
        dpas.8x1 (16|M0)         r98:f         r98:f             r42:hf            r7.0:hf          {Compacted,$11} // $237
        sync.nop                             null                             {Compacted,F@1}        // $238
        dpas.8x1 (16|M0)         r98:f         r98:f             r74:hf            r7.16:hf         {Compacted,$11} // $238
        mov (1|M0)               null<1>:ud    r98.0<0;1,0>:w                   {$11.dst}            //  ALU pipe: int; $239
        cmp (1|M0)    (eq)f0.0   null<1>:d     r41.6<0;1,0>:d    r41.2<0;1,0>:d                      //  ALU pipe: int; $241
(W&~f0.0) jmpi                               BB_3                                                    //  ALU pipe: int; $242
// B008: Preds:{B007},  Succs:{B010}
_L_k25_3_:
        mov (16|M0)              r1.16<1>:hf   r98.0<1;1,0>:f                                        //  ALU pipe: float; $243
        mov (16|M0)              r97.0<1>:d    r1.16<1;1,0>:uw                  {F@1}                //  ALU pipe: int; $244
(W)     jmpi                                 BB_4                                                    // $245
// B009: Preds:{B005},  Succs:{B010}
BB_2:
        mov (16|M0)              r97.0<1>:d    0:w                                                   //  ALU pipe: int; $248
// B010: Preds:{B009, B008},  Succs:{}
BB_4:
        add (1|M0)               r1.2<1>:d     r41.14<0;1,0>:d   1:w                                 //  ALU pipe: int; $250
        add (1|M0)               r41.7<1>:d    r41.7<0;1,0>:d    512:w                               //  ALU pipe: int; $252
        sel (1|M0)    (lt)f0.0   r1.2<1>:ud    r1.2<0;1,0>:ud    r4.0<0;1,0>:ud   {I@2}              //  ALU pipe: int; $251
        sel (1|M0)    (lt)f0.0   r41.7<1>:ud   r41.7<0;1,0>:ud   r4.2<0;1,0>:ud   {I@2}              //  ALU pipe: int; $253
(W)     mul (1|M0)               acc0.0<1>:d   r41.14<0;1,0>:d   r4.10<0;1,0>:uw                     //  ALU pipe: int; $255
        macl (1|M0)              r3.0<1>:d     r41.14<0;1,0>:d   r4.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $256
        mul (16|M0)              r99.0<1>:ud   r99.0<1;1,0>:ud   0x2:uw              {Compacted}     //  ALU pipe: int; $258
        add (1|M0)               r41.15<1>:d   r41.15<0;1,0>:d   r3.0<0;1,0>:d    {I@2}              //  ALU pipe: int; $256
        cmp (16|M0)   (lt)f2.1   null<1>:d     r41.14<0;1,0>:ud  r1.2<0;1,0>:ud                      //  ALU pipe: int; $261
        shl (1|M0)               r41.15<1>:d   r41.15<0;1,0>:d   1:w               {I@2}             //  ALU pipe: int; $257
(W)     mov (16|M0)              r127.0<1>:f   r40.0<1;1,0>:f                                        //  ALU pipe: float; $265
        add (16|M0)              r99.0<1>:ud   r41.15<0;1,0>:ud  r99.0<1;1,0>:ud  {I@1}              //  ALU pipe: int; $259
(f2.1)  cmp (16|M0)   (lt)f2.1   null<1>:d     r57.0<1;1,0>:ud   r41.7<0;1,0>:ud                     //  ALU pipe: int; $262 R{} IR{}{O:4,O:4,},  {BC=1}
        sync.nop                             null                             {Compacted,$9.src}     // $260
        mov (16|M0)              r6.0<2>:ud    r99.0<1;1,0>:ud                  {Compacted,@2,$8.src} //  ALU pipe: int; $260
        add (16|M0)              r8.0<1>:q     r4.5<0;1,0>:q     r6.0<2;1,0>:ud   {@1,$10.src}       //  ALU pipe: int; $260
(f2.1)  store.ugm.d16u32.a64.st.wb (16|M0)  [r8:2] r97:1           {I@1,$13} // ex_desc:0x0; desc:0x40C0B84 // $264
(W)     send.gtwy (1|M0)         null     r127  null:0  0x0            0x02000010           {EOT,F@1,$14} // wr:1+0, rd:0; end of thread // $265


//.BankConflicts: 2
//.ByteRMWs: 0
//


//.numALUInst: 240
//.accSubDef: 21
//.accSubUse: 33
//.accSubCandidateDef: 22
//.accSubCandidateUse: 34
//
//
//.singlePipeAtOneDistNum: 34
//.allAtOneDistNum: 6
//.syncInstCount: 8
//.tokenReuseCount: 0
//.AfterWriteTokenDepCount: 18
//.AfterReadTokenDepCount: 11
