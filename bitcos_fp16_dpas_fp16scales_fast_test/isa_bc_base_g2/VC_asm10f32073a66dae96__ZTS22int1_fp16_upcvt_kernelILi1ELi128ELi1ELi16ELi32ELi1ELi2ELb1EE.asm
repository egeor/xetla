//.kernel _ZTS22int1_fp16_upcvt_kernelILi1ELi128ELi1ELi16ELi32ELi1ELi2ELb1EE
//.platform XE2
//.thread_config numGRF=128, numAcc=4, numSWSB=16
//.options_string "-enablePreemptionR0Only -enableHalfLSC -dumpcommonisa -output -binary -abiver 2 -samplerHeaderWA "
//.full_options "-samplerHeaderWA -enablePreemptionR0Only -abiver 2 -output -binary -dumpcommonisa -enableHalfLSC "
//.instCount 362
//.RA type	LOCAL_ROUND_ROBIN_BC_RA
//.git-hash cd6c33fbee6ccc897657c64b11eae6917cc8ff5e

//.declare BuiltInR0 (0)  rf=r size=64 type=ud align=32 words (r0.0) IsBuiltin
//.declare  (1)  rf=r size=64 type=ud align=32 words (r35.0) IsBuiltin
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
//.declare V70 (78)  rf=r size=4 type=d align=2 words (r40.0)
//.declare V71 (79)  rf=r size=4 type=d align=2 words (r40.1)
//.declare V72 (80)  rf=r size=4 type=d align=2 words (r40.2)
//.declare V73 (81)  rf=r size=4 type=d align=2 words (r40.3)
//.declare V74 (82)  rf=r size=4 type=d align=32 words (r57.0)
//.declare V75 (83)  rf=r size=4 type=d align=2 words (r40.4)
//.declare P1 (84)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare P2 (85)  rf=f1  size=2 type=uw align=1 words (f0.1)
//.declare P3 (86)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V76 (87)  rf=r size=8 type=d align=2 words (r3.0)
//.declare V77 (88)  rf=r size=8 type=d align=4 words (r1.2)
//.declare V78 (89)  rf=r size=8 type=d align=4 words (r4.12)
//.declare V79 (90)  rf=r size=128 type=d align=32 words (r6.0)
//.declare V80 (91)  rf=r size=4 type=d align=32 words (r8.0)
//.declare V81 (92)  rf=r size=4 type=d align=32 words (r9.0)
//.declare V82 (93)  rf=r size=8 type=q align=4 words (r40.3)
//.declare V83 (94)  rf=r size=4 type=d align=2 words (r40.5)
//.declare V84 (95)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V85 (96)  rf=r size=4 type=d align=2 words (r40.8)
//.declare V86 (97)  rf=r size=4 type=d align=32 words (r63.0)
//.declare V87 (98)  rf=r size=4 type=d align=2 words (r40.9)
//.declare V88 (99)  rf=r size=4 type=d align=32 words (r69.0)
//.declare V89 (100)  rf=r size=4 type=d align=2 words (r5.0)
//.declare V90 (101)  rf=r size=64 type=d align=32 words (r83.0)
//.declare V91 (102)  rf=r size=64 type=d align=32 words (r89.0)
//.declare V92 (103)  rf=r size=64 type=d align=32 words (r92.0)
//.declare V93 (104)  rf=r size=64 type=d align=32 words (r93.0)
//.declare V94 (105)  rf=r size=8 type=uq align=4 words (r5.4)
//.declare V95 (106)  rf=r size=128 type=q align=32 words (r9.0)
//.declare V96 (107)  rf=r size=64 type=d align=32 words (r94.0)
//.declare P4 (108)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare P5 (109)  rf=f1  size=2 type=uw align=1 words (f3.1)
//.declare P6 (110)  rf=f1  size=2 type=uw align=1 words (f1.0)
//.declare V97 (111)  rf=r size=128 type=q align=32 words (r8.0)
//.declare V99 (113)  rf=r size=64 type=d align=32 words (r95.0)
//.declare V100 (114)  rf=r size=4 type=d align=2 words (r40.10)
//.declare V101 (115)  rf=r size=64 type=d align=32 words (r96.0)
//.declare V102 (116)  rf=r size=64 type=d align=32 words (r97.0)
//.declare V103 (117)  rf=r size=4 type=d align=2 words (r40.11)
//.declare V104 (118)  rf=r size=32 type=w align=2 words (r1.4)
//.declare V105 (119)  rf=r size=32 type=w align=2 words (r2.6)
//.declare V106 (120)  rf=r size=32 type=w align=2 words (r3.0)
//.declare V107 (121)  rf=r size=64 type=d align=32 words (r12.0)
//.declare V108 (122)  rf=r size=64 type=w align=32 words (r14.0)
//.declare V109 (123)  rf=r size=32 type=w align=2 words (r17.0)
//.declare V110 (124)  rf=r size=64 type=w align=32 words (r8.0)
//.declare V111 (125)  rf=r size=32 type=w align=2 words (r22.0)
//.declare V112 (126)  rf=r size=64 type=d align=32 words (r23.0)
//.declare V113 (127)  rf=r size=64 type=d align=32 words (r24.0)
//.declare V114 (128)  rf=r size=64 type=w align=32 words (r10.0)
//.declare V115 (129)  rf=r size=32 type=w align=2 words (r27.0)
//.declare V116 (130)  rf=r size=64 type=d align=32 words (r28.0)
//.declare V117 (131)  rf=r size=64 type=d align=32 words (r29.0)
//.declare V118 (132)  rf=r size=64 type=d align=32 words (r19.0)
//.declare V119 (133)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V120 (134)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V121 (135)  rf=r size=64 type=d align=32 words (r31.0)
//.declare V122 (136)  rf=r size=64 type=d align=32 words (r32.0)
//.declare V123 (137)  rf=r size=4 type=d align=2 words (r40.12)
//.declare P7 (138)  rf=f1  size=2 type=uw align=1 words (f0.0)
//.declare P8 (139)  rf=f1  size=2 type=uw align=1 words (f3.1)
//.declare V125 (141)  rf=r size=64 type=d align=32 words (r3.0)
//.declare V127 (143)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V129 (145)  rf=r size=64 type=d align=32 words (r7.0)
//.declare V131 (147)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V132 (148)  rf=r size=4 type=d align=32 words (r5.0)
//.declare V133 (149)  rf=r size=64 type=d align=32 words (r99.0)
//.declare V134 (150)  rf=r size=4 type=d align=32 words (r6.0)
//.declare V135 (151)  rf=r size=64 type=d align=32 words (r98.0)
//.declare P9 (153)  rf=f1  size=2 type=uw align=1 words (f3.0)
//.declare V137 (154)  rf=r size=4 type=d align=2 words (r40.13)
//.declare V138 (155)  rf=r size=8 type=q align=4 words (r40.7)
//.declare V139 (156)  rf=r size=8 type=q align=4 words (r41.1)
//.declare V140 (157)  rf=r size=8 type=q align=4 words (r41.2)
//.declare V141 (158)  rf=r size=8 type=q align=32 words (r3.0)
//.declare V142 (159)  rf=r size=8 type=q align=32 words (r8.0)
//.declare V143 (160)  rf=r size=8 type=q align=32 words (r10.0)
//.declare V144 (161)  rf=r size=32 type=hf align=32 words (r11.0)
//.declare P10 (163)  rf=f1  size=2 type=uw align=1 words (f2.1)
//.declare V146 (164)  rf=r size=4 type=d align=2 words (r12.0)
//.declare V147 (165)  rf=r size=64 type=d align=32 words (r14.0)
//.declare V148 (166)  rf=r size=64 type=d align=32 words (r15.0)
//.declare V149 (167)  rf=r size=128 type=q align=32 words (r18.0)
//.declare V150 (168)  rf=r size=192 type=d align=32 words (r20.0)
//.declare V151 (169)  rf=r size=32 type=w align=2 words (r25.0)
//.declare V153 (171)  rf=r size=32 type=w align=2 words (r28.0)
//.declare V155 (173)  rf=r size=64 type=d align=32 words (r31.0)
//.declare P11 (174)  rf=f16  size=2 type=uw align=1 words (f2.0)
//.declare V156 (175)  rf=r size=64 type=hf align=32 words (r32.0)
//.declare V157 (176)  rf=r size=64 type=d align=32 words (r36.0)
//.declare V158 (177)  rf=r size=64 type=d align=32 words (r33.0)
//.declare V159 (178)  rf=r size=64 type=d align=32 words (r37.0)
//.declare V160 (179)  rf=r size=128 type=hf align=32 words (r38.0)
//.declare V161 (180)  rf=r size=64 type=d align=32 words (r34.0)
//.declare V162 (181)  rf=r size=64 type=d align=32 words (r52.0)
//.declare V163 (182)  rf=r size=64 type=d align=32 words (r50.0)
//.declare V164 (183)  rf=r size=64 type=d align=32 words (r53.0)
//.declare V165 (184)  rf=r size=128 type=hf align=32 words (r54.0)
//.declare V166 (185)  rf=r size=64 type=d align=32 words (r51.0)
//.declare V167 (186)  rf=r size=64 type=d align=32 words (r58.0)
//.declare V168 (187)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V169 (188)  rf=r size=64 type=d align=32 words (r59.0)
//.declare V170 (189)  rf=r size=128 type=hf align=32 words (r60.0)
//.declare V171 (190)  rf=r size=64 type=d align=32 words (r56.0)
//.declare V172 (191)  rf=r size=64 type=d align=32 words (r64.0)
//.declare V174 (193)  rf=r size=64 type=d align=32 words (r65.0)
//.declare V175 (194)  rf=r size=128 type=hf align=32 words (r66.0)
//.declare V176 (195)  rf=r size=512 type=d align=32 words (r42.0)
//.declare V177 (196)  rf=r size=64 type=d align=32 words (r62.0)
//.declare V178 (197)  rf=r size=64 type=d align=32 words (r70.0)
//.declare V180 (199)  rf=r size=64 type=d align=32 words (r71.0)
//.declare V181 (200)  rf=r size=128 type=hf align=32 words (r72.0)
//.declare V182 (201)  rf=r size=64 type=d align=32 words (r68.0)
//.declare V183 (202)  rf=r size=64 type=d align=32 words (r84.0)
//.declare V185 (204)  rf=r size=64 type=d align=32 words (r85.0)
//.declare V186 (205)  rf=r size=128 type=hf align=32 words (r86.0)
//.declare V187 (206)  rf=r size=64 type=d align=32 words (r82.0)
//.declare V188 (207)  rf=r size=64 type=d align=32 words (r90.0)
//.declare V190 (209)  rf=r size=64 type=d align=32 words (r91.0)
//.declare V191 (210)  rf=r size=128 type=hf align=32 words (r10.0)
//.declare V192 (211)  rf=r size=64 type=d align=32 words (r88.0)
//.declare V193 (212)  rf=r size=64 type=d align=32 words (r30.0)
//.declare V194 (213)  rf=r size=64 type=d align=32 words (r9.0)
//.declare V195 (214)  rf=r size=64 type=d align=32 words (r13.0)
//.declare V196 (215)  rf=r size=128 type=hf align=32 words (r15.0)
//.declare V197 (216)  rf=r size=512 type=d align=32 words (r74.0)
//.declare V198 (217)  rf=r size=64 type=d align=32 words (r7.0)
//.declare P12 (218)  rf=f1  size=2 type=uw align=1 words (f2.0)
//.declare V199 (219)  rf=r size=64 type=q align=32 words (r100.0)
//.declare V201 (221)  rf=r size=4 type=d align=32 words (r101.0)
//.declare V202 (222)  rf=r size=4 type=d align=32 words (r3.0)
//.declare V203 (223)  rf=r size=4 type=d align=2 words (r4.12)
//.declare V204 (224)  rf=r size=64 type=d align=32 words (r6.0)
//.declare V205 (225)  rf=r size=4 type=b align=2 words (r41.24)
//.declare P13 (226)  rf=f1  size=2 type=uw align=1 words (f1.1)
//.declare V206 (227)  rf=r size=4 type=d align=2 words (r2.3)
//.declare V207 (228)  rf=r size=64 type=f align=32 words (r3.0)
//.declare V208 (229)  rf=r size=64 type=f align=32 words (r6.0)
//.declare V209 (230)  rf=r size=32 type=w align=16 words (r7.0)
//.declare V210 (231)  rf=r size=64 type=d align=32 words (r8.0)
//.declare V211 (232)  rf=r size=4 type=d align=2 words (r1.2)
//.declare V212 (233)  rf=r size=4 type=d align=32 words (r9.0)
//.declare V213 (234)  rf=r size=128 type=q align=32 words (r12.0)
//.declare P14 (235)  rf=f16  size=2 type=uw align=1 words (f3.0)
//.declare P15 (236)  rf=f16  size=2 type=uw align=1 words (f2.1)
//.declare P16 (237)  rf=f16  size=2 type=uw align=1 words (f0.1)
//.declare V214 (238)  rf=r size=6 type=uw alias=V33+0 align=1 words (r1.0)
//.declare V215 (239)  rf=r size=8 type=q alias=V64+0 align=4 words (r2.2)
//.declare V216 (240)  rf=r size=12 type=ud alias=V34+0 align=2 words (r2.0)
//.declare V217 (241)  rf=r size=128 type=ud alias=V62+0 align=32 words (r6.0)
//.declare V218 (242)  rf=r size=12 type=ud alias=V61+0 align=2 words (r1.2)
//.declare V219 (243)  rf=r size=8 type=q alias=V63+0 align=4 words (r8.0)
//.declare V220 (244)  rf=r size=128 type=ud alias=V65+0 align=32 words (r10.0)
//.declare V221 (245)  rf=r size=8 type=ud alias=V63+0 align=2 words (r8.0)
//.declare V222 (246)  rf=r size=8 type=ud alias=V64+0 align=2 words (r2.4)
//.declare V223 (247)  rf=r size=4 type=d alias=V66+0 align=2 words (r12.0)
//.declare V224 (248)  rf=r size=8 type=d alias=V63+0 align=2 words (r8.0)
//.declare V225 (249)  rf=r size=8 type=d alias=V64+0 align=2 words (r2.4)
//.declare V226 (250)  rf=r size=4 type=d alias=V67+0 align=2 words (r13.0)
//.declare V227 (251)  rf=r size=8 type=d alias=V68+0 align=2 words (r14.0)
//.declare V228 (252)  rf=r size=128 type=d alias=V65+0 align=32 words (r10.0)
//.declare V229 (253)  rf=r size=8 type=q alias=V68+0 align=4 words (r14.0)
//.declare V230 (254)  rf=r size=4 type=d alias=V205+0 align=2 words (r41.6)
//.declare V231 (255)  rf=r size=8 type=uq alias=V69+0 align=4 words (r41.0)
//.declare V232 (256)  rf=r size=8 type=uq alias=V68+0 align=4 words (r14.0)
//.declare V233 (257)  rf=r size=4 type=d alias=V83+0 align=2 words (r40.5)
//.declare V234 (258)  rf=r size=4 type=d alias=V71+0 align=2 words (r40.1)
//.declare V235 (259)  rf=r size=4 type=ud alias=V71+0 align=2 words (r40.1)
//.declare V236 (260)  rf=r size=4 type=ud alias=V38+0 align=2 words (r4.2)
//.declare V237 (261)  rf=r size=4 type=d alias=V72+0 align=2 words (r40.2)
//.declare V238 (262)  rf=r size=4 type=d alias=V70+0 align=2 words (r40.0)
//.declare V239 (263)  rf=r size=4 type=ud alias=V72+0 align=2 words (r40.2)
//.declare V240 (264)  rf=r size=4 type=ud alias=V36+0 align=2 words (r4.0)
//.declare V241 (265)  rf=r size=4 type=d alias=V73+0 align=2 words (r40.3)
//.declare V242 (266)  rf=r size=4 type=d alias=V37+0 align=2 words (r4.1)
//.declare V243 (267)  rf=r size=4 type=ud alias=V75+0 align=2 words (r40.4)
//.declare V244 (268)  rf=r size=4 type=ud alias=V73+0 align=2 words (r40.3)
//.declare V245 (269)  rf=r size=4 type=ud alias=V74+0 align=2 words (r57.0)
//.declare V246 (270)  rf=r size=8 type=ud alias=V69+0 align=2 words (r41.0)
//.declare V247 (271)  rf=r size=4 type=ud alias=V88+0 align=2 words (r69.0)
//.declare V248 (272)  rf=r size=4 type=d alias=V100+0 align=2 words (r40.10)
//.declare V249 (273)  rf=r size=8 type=d alias=V69+0 align=2 words (r41.0)
//.declare V250 (274)  rf=r size=4 type=ud alias=V86+0 align=2 words (r63.0)
//.declare V251 (275)  rf=r size=8 type=ud alias=V68+0 align=2 words (r14.0)
//.declare V252 (276)  rf=r size=8 type=uq alias=V77+0 align=4 words (r1.1)
//.declare V253 (277)  rf=r size=8 type=d alias=V76+0 align=2 words (r3.0)
//.declare V254 (278)  rf=r size=8 type=d alias=V77+0 align=2 words (r1.2)
//.declare V255 (279)  rf=r size=8 type=q alias=V78+0 align=4 words (r4.6)
//.declare V256 (280)  rf=r size=128 type=ud alias=V79+0 align=32 words (r6.0)
//.declare V257 (281)  rf=r size=8 type=ud alias=V77+0 align=2 words (r1.2)
//.declare V258 (282)  rf=r size=8 type=ud alias=V78+0 align=2 words (r4.12)
//.declare V259 (283)  rf=r size=4 type=d alias=V80+0 align=2 words (r8.0)
//.declare V260 (284)  rf=r size=8 type=d alias=V78+0 align=2 words (r4.12)
//.declare V261 (285)  rf=r size=4 type=d alias=V81+0 align=2 words (r9.0)
//.declare V262 (286)  rf=r size=8 type=d alias=V82+0 align=2 words (r40.6)
//.declare V263 (287)  rf=r size=8 type=d alias=V82+0 align=2 words (r40.6)
//.declare V264 (288)  rf=r size=128 type=d alias=V79+0 align=32 words (r6.0)
//.declare V265 (289)  rf=r size=8 type=q alias=V82+0 align=4 words (r40.3)
//.declare V266 (290)  rf=r size=8 type=q alias=V53+0 align=4 words (r5.5)
//.declare V267 (291)  rf=r size=4 type=d alias=V103+0 align=2 words (r40.11)
//.declare V268 (292)  rf=r size=4 type=d alias=V84+0 align=2 words (r3.0)
//.declare V269 (293)  rf=r size=4 type=d alias=V39+0 align=2 words (r4.3)
//.declare V270 (294)  rf=r size=8 type=q alias=V138+0 align=4 words (r40.7)
//.declare V271 (295)  rf=r size=4 type=ud alias=V84+0 align=2 words (r3.0)
//.declare V272 (296)  rf=r size=4 type=d alias=V85+0 align=2 words (r40.8)
//.declare V273 (297)  rf=r size=4 type=d alias=V40+0 align=2 words (r4.4)
//.declare V274 (298)  rf=r size=4 type=d alias=V86+0 align=2 words (r63.0)
//.declare V275 (299)  rf=r size=4 type=ud alias=V83+0 align=2 words (r40.5)
//.declare V276 (300)  rf=r size=8 type=q alias=V139+0 align=4 words (r41.1)
//.declare V277 (301)  rf=r size=8 type=q alias=V140+0 align=4 words (r41.2)
//.declare V278 (302)  rf=r size=4 type=d alias=V87+0 align=2 words (r40.9)
//.declare V279 (303)  rf=r size=4 type=d alias=V52+0 align=2 words (r5.4)
//.declare V280 (304)  rf=r size=4 type=d alias=V88+0 align=2 words (r69.0)
//.declare V281 (305)  rf=r size=4 type=ud alias=V89+0 align=2 words (r5.0)
//.declare V282 (306)  rf=r size=64 type=d alias=V91+0 align=32 words (r89.0)
//.declare V283 (307)  rf=r size=64 type=d alias=V102+0 align=32 words (r97.0)
//.declare V284 (308)  rf=r size=64 type=d alias=V92+0 align=32 words (r92.0)
//.declare V285 (309)  rf=r size=64 type=d alias=V93+0 align=32 words (r93.0)
//.declare V286 (310)  rf=r size=128 type=q alias=V95+0 align=32 words (r9.0)
//.declare V287 (311)  rf=r size=8 type=q alias=V94+0 align=4 words (r5.4)
//.declare V288 (312)  rf=r size=64 type=ud alias=V93+0 align=32 words (r93.0)
//.declare V289 (313)  rf=r size=128 type=uq alias=V95+0 align=32 words (r9.0)
//.declare V290 (314)  rf=r size=128 type=q alias=V97+0 align=32 words (r8.0)
//.declare V291 (315)  rf=r size=128 type=uq alias=V97+0 align=32 words (r8.0)
//.declare V292 (316)  rf=r size=64 type=d alias=V101+0 align=32 words (r96.0)
//.declare V293 (317)  rf=r size=32 type=uw alias=V104+0 align=1 words (r1.4)
//.declare V294 (318)  rf=r size=4 type=uw alias=V103+0 align=1 words (r40.22)
//.declare V295 (319)  rf=r size=64 type=d alias=V108+0 align=32 words (r14.0)
//.declare V296 (320)  rf=r size=32 type=uw alias=V105+0 align=1 words (r2.6)
//.declare V297 (321)  rf=r size=32 type=uw alias=V106+0 align=1 words (r3.0)
//.declare V298 (322)  rf=r size=64 type=ud alias=V120+0 align=32 words (r6.0)
//.declare V299 (323)  rf=r size=4 type=ud alias=V103+0 align=2 words (r40.11)
//.declare V300 (324)  rf=r size=64 type=d alias=V110+0 align=32 words (r8.0)
//.declare V301 (325)  rf=r size=64 type=d alias=V114+0 align=32 words (r10.0)
//.declare V302 (326)  rf=r size=64 type=ud alias=V108+0 align=32 words (r14.0)
//.declare V303 (327)  rf=r size=64 type=ud alias=V102+0 align=32 words (r97.0)
//.declare V304 (328)  rf=r size=32 type=uw alias=V109+0 align=1 words (r17.0)
//.declare V305 (329)  rf=r size=64 type=uw alias=V108+0 align=32 words (r14.0)
//.declare V306 (330)  rf=r size=64 type=d alias=V118+0 align=32 words (r19.0)
//.declare V307 (331)  rf=r size=64 type=ud alias=V110+0 align=32 words (r8.0)
//.declare V308 (332)  rf=r size=32 type=uw alias=V111+0 align=1 words (r22.0)
//.declare V309 (333)  rf=r size=64 type=uw alias=V110+0 align=32 words (r8.0)
//.declare V310 (334)  rf=r size=64 type=ud alias=V114+0 align=32 words (r10.0)
//.declare V311 (335)  rf=r size=32 type=uw alias=V115+0 align=1 words (r27.0)
//.declare V312 (336)  rf=r size=64 type=uw alias=V114+0 align=32 words (r10.0)
//.declare V313 (337)  rf=r size=64 type=d alias=V120+0 align=32 words (r6.0)
//.declare V314 (338)  rf=r size=64 type=d alias=V116+0 align=32 words (r28.0)
//.declare V315 (339)  rf=r size=64 type=d alias=V117+0 align=32 words (r29.0)
//.declare V316 (340)  rf=r size=64 type=ud alias=V119+0 align=32 words (r30.0)
//.declare V317 (341)  rf=r size=64 type=ud alias=V118+0 align=32 words (r19.0)
//.declare V318 (342)  rf=r size=64 type=ud alias=V107+0 align=32 words (r12.0)
//.declare V319 (343)  rf=r size=64 type=ud alias=V101+0 align=32 words (r96.0)
//.declare V320 (344)  rf=r size=64 type=ud alias=V121+0 align=32 words (r31.0)
//.declare V321 (345)  rf=r size=64 type=ud alias=V112+0 align=32 words (r23.0)
//.declare V322 (346)  rf=r size=64 type=ud alias=V113+0 align=32 words (r24.0)
//.declare V323 (347)  rf=r size=64 type=ud alias=V117+0 align=32 words (r29.0)
//.declare V324 (348)  rf=r size=64 type=ud alias=V122+0 align=32 words (r32.0)
//.declare V325 (349)  rf=r size=4 type=d alias=V123+0 align=2 words (r40.12)
//.declare V328 (352)  rf=r size=64 type=d alias=V125+0 align=32 words (r3.0)
//.declare V329 (353)  rf=r size=64 type=ud alias=V125+0 align=32 words (r3.0)
//.declare V330 (354)  rf=r size=64 type=d alias=V129+0 align=32 words (r7.0)
//.declare V331 (355)  rf=r size=64 type=ud alias=V129+0 align=32 words (r7.0)
//.declare  (356)  rf=r size=64 type=ud align=32 words (r3.0)
//.declare V332 (357)  rf=r size=8 type=b alias=V69+0 align=1 words (r41.0)
//.declare  (358)  rf=f16  size=2 type=uw align=2 words (f1.0)
//.declare V333 (359)  rf=r size=4 type=d alias=V132+0 align=2 words (r5.0)
//.declare V334 (360)  rf=r size=4 type=ud alias=V132+0 align=2 words (r5.0)
//.declare V335 (361)  rf=r size=4 type=d alias=V134+0 align=2 words (r6.0)
//.declare V336 (362)  rf=r size=4 type=ud alias=V134+0 align=2 words (r6.0)
//.declare V337 (363)  rf=r size=64 type=f alias=V199+0 align=32 words (r100.0)
//.declare V338 (364)  rf=r size=8 type=uq alias=V141+0 align=4 words (r3.0)
//.declare V339 (365)  rf=r size=8 type=uq alias=V138+0 align=4 words (r40.7)
//.declare V340 (366)  rf=r size=8 type=uq alias=V56+0 align=4 words (r4.3)
//.declare V341 (367)  rf=r size=64 type=q alias=V198+0 align=32 words (r7.0)
//.declare V342 (368)  rf=r size=8 type=uq alias=V142+0 align=4 words (r8.0)
//.declare V343 (369)  rf=r size=8 type=uq alias=V139+0 align=4 words (r41.1)
//.declare V344 (370)  rf=r size=8 type=uq alias=V57+0 align=4 words (r4.4)
//.declare V345 (371)  rf=r size=64 type=q alias=V194+0 align=32 words (r9.0)
//.declare V346 (372)  rf=r size=8 type=uq alias=V143+0 align=4 words (r10.0)
//.declare V347 (373)  rf=r size=8 type=uq alias=V140+0 align=4 words (r41.2)
//.declare V348 (374)  rf=r size=8 type=uq alias=V59+0 align=4 words (r5.1)
//.declare V349 (375)  rf=r size=32 type=q alias=V144+0 align=4 words (r11.0)
//.declare V350 (376)  rf=r size=4 type=d alias=V137+0 align=2 words (r40.13)
//.declare V352 (378)  rf=r size=64 type=ud alias=V168+0 align=32 words (r13.0)
//.declare V353 (379)  rf=r size=64 type=ud alias=V194+0 align=32 words (r9.0)
//.declare V354 (380)  rf=r size=64 type=ud alias=V147+0 align=32 words (r14.0)
//.declare V355 (381)  rf=r size=64 type=ud alias=V148+0 align=32 words (r15.0)
//.declare V356 (382)  rf=r size=64 type=ud alias=V99+0 align=32 words (r95.0)
//.declare V357 (383)  rf=r size=64 type=ud alias=V96+0 align=32 words (r94.0)
//.declare V358 (384)  rf=r size=128 type=q alias=V149+0 align=32 words (r18.0)
//.declare V359 (385)  rf=r size=8 type=q alias=V60+0 align=4 words (r5.3)
//.declare V360 (386)  rf=r size=128 type=uq alias=V149+0 align=32 words (r18.0)
//.declare V361 (387)  rf=r size=64 type=ud alias=V193+0 align=32 words (r30.0)
//.declare V362 (388)  rf=r size=192 type=ud alias=V150+0 align=32 words (r20.0)
//.declare V363 (389)  rf=r size=64 type=ud alias=V155+0 align=32 words (r31.0)
//.declare V364 (390)  rf=r size=32 type=w alias=V151+0 align=1 words (r25.0)
//.declare V365 (391)  rf=r size=64 type=w alias=V99+0 align=32 words (r95.0)
//.declare V366 (392)  rf=r size=32 type=uw alias=V151+0 align=1 words (r25.0)
//.declare V367 (393)  rf=r size=32 type=w alias=V153+0 align=1 words (r28.0)
//.declare V368 (394)  rf=r size=32 type=uw alias=V153+0 align=1 words (r28.0)
//.declare V371 (397)  rf=r size=64 type=ud alias=V158+0 align=32 words (r33.0)
//.declare V372 (398)  rf=r size=64 type=ud alias=V161+0 align=32 words (r34.0)
//.declare V373 (399)  rf=r size=64 type=ud alias=V133+0 align=32 words (r99.0)
//.declare V374 (400)  rf=r size=64 type=ud alias=V157+0 align=32 words (r36.0)
//.declare V375 (401)  rf=r size=64 type=ud alias=V135+0 align=32 words (r98.0)
//.declare V376 (402)  rf=r size=64 type=ud alias=V159+0 align=32 words (r37.0)
//.declare V377 (403)  rf=r size=4 type=ud alias=V100+0 align=2 words (r40.10)
//.declare V378 (404)  rf=r size=128 type=d alias=V160+0 align=32 words (r38.0)
//.declare V379 (405)  rf=r size=512 type=hf alias=V176+0 align=32 words (r42.0)
//.declare V380 (406)  rf=r size=64 type=hf alias=V156+0 align=32 words (r32.0)
//.declare V381 (407)  rf=r size=128 type=hf alias=V160+0 align=32 words (r38.0)
//.declare V382 (408)  rf=r size=64 type=ud alias=V163+0 align=32 words (r50.0)
//.declare V383 (409)  rf=r size=64 type=ud alias=V166+0 align=32 words (r51.0)
//.declare V384 (410)  rf=r size=64 type=ud alias=V162+0 align=32 words (r52.0)
//.declare V385 (411)  rf=r size=64 type=ud alias=V164+0 align=32 words (r53.0)
//.declare V386 (412)  rf=r size=128 type=d alias=V165+0 align=32 words (r54.0)
//.declare V387 (413)  rf=r size=128 type=hf alias=V165+0 align=32 words (r54.0)
//.declare V388 (414)  rf=r size=64 type=ud alias=V171+0 align=32 words (r56.0)
//.declare V389 (415)  rf=r size=64 type=ud alias=V167+0 align=32 words (r58.0)
//.declare V390 (416)  rf=r size=64 type=ud alias=V169+0 align=32 words (r59.0)
//.declare V391 (417)  rf=r size=128 type=d alias=V170+0 align=32 words (r60.0)
//.declare V392 (418)  rf=r size=128 type=hf alias=V170+0 align=32 words (r60.0)
//.declare V394 (420)  rf=r size=64 type=ud alias=V177+0 align=32 words (r62.0)
//.declare V395 (421)  rf=r size=64 type=ud alias=V172+0 align=32 words (r64.0)
//.declare V396 (422)  rf=r size=64 type=ud alias=V174+0 align=32 words (r65.0)
//.declare V397 (423)  rf=r size=128 type=d alias=V175+0 align=32 words (r66.0)
//.declare V398 (424)  rf=r size=128 type=hf alias=V175+0 align=32 words (r66.0)
//.declare V400 (426)  rf=r size=64 type=ud alias=V182+0 align=32 words (r68.0)
//.declare V401 (427)  rf=r size=64 type=ud alias=V178+0 align=32 words (r70.0)
//.declare V402 (428)  rf=r size=64 type=ud alias=V180+0 align=32 words (r71.0)
//.declare V403 (429)  rf=r size=128 type=d alias=V181+0 align=32 words (r72.0)
//.declare V404 (430)  rf=r size=512 type=hf alias=V197+0 align=32 words (r74.0)
//.declare V405 (431)  rf=r size=128 type=hf alias=V181+0 align=32 words (r72.0)
//.declare V407 (433)  rf=r size=64 type=ud alias=V187+0 align=32 words (r82.0)
//.declare V408 (434)  rf=r size=64 type=ud alias=V183+0 align=32 words (r84.0)
//.declare V409 (435)  rf=r size=64 type=ud alias=V185+0 align=32 words (r85.0)
//.declare V410 (436)  rf=r size=128 type=d alias=V186+0 align=32 words (r86.0)
//.declare V411 (437)  rf=r size=128 type=hf alias=V186+0 align=32 words (r86.0)
//.declare V413 (439)  rf=r size=64 type=ud alias=V192+0 align=32 words (r88.0)
//.declare V414 (440)  rf=r size=64 type=ud alias=V188+0 align=32 words (r90.0)
//.declare V415 (441)  rf=r size=64 type=ud alias=V190+0 align=32 words (r91.0)
//.declare V416 (442)  rf=r size=128 type=d alias=V191+0 align=32 words (r10.0)
//.declare V417 (443)  rf=r size=128 type=hf alias=V191+0 align=32 words (r10.0)
//.declare V418 (444)  rf=r size=64 type=ud alias=V195+0 align=32 words (r13.0)
//.declare V419 (445)  rf=r size=128 type=d alias=V196+0 align=32 words (r15.0)
//.declare V420 (446)  rf=r size=128 type=hf alias=V196+0 align=32 words (r15.0)
//.declare V421 (447)  rf=r size=4 type=ud alias=V85+0 align=2 words (r40.8)
//.declare V422 (448)  rf=r size=4 type=ud alias=V146+0 align=2 words (r12.0)
//.declare V423 (449)  rf=r size=64 type=f alias=V199+0 align=32 words (r100.0)
//.declare V424 (450)  rf=r size=64 type=w alias=V199+0 align=32 words (r100.0)
//.declare V425 (451)  rf=r size=4 type=d alias=V75+0 align=2 words (r40.4)
//.declare V427 (453)  rf=r size=4 type=d alias=V201+0 align=2 words (r101.0)
//.declare V428 (454)  rf=r size=4 type=d alias=V202+0 align=2 words (r3.0)
//.declare V429 (455)  rf=r size=4 type=ud alias=V202+0 align=2 words (r3.0)
//.declare V430 (456)  rf=r size=4 type=d alias=V203+0 align=2 words (r4.12)
//.declare  (457)  rf=r size=64 type=ud align=32 words (r7.0)
//.declare  (458)  rf=f16  size=2 type=uw align=2 words (f0.0)
//.declare V431 (459)  rf=r size=4 type=ud alias=V211+0 align=2 words (r1.2)
//.declare V432 (460)  rf=r size=4 type=ud alias=V206+0 align=2 words (r2.3)
//.declare V433 (461)  rf=r size=4 type=d alias=V206+0 align=2 words (r2.3)
//.declare V434 (462)  rf=r size=64 type=q alias=V207+0 align=32 words (r3.0)
//.declare V435 (463)  rf=r size=4 type=ud alias=V201+0 align=2 words (r101.0)
//.declare V436 (464)  rf=r size=64 type=q alias=V208+0 align=32 words (r6.0)
//.declare V437 (465)  rf=r size=64 type=f alias=V208+0 align=32 words (r6.0)
//.declare V438 (466)  rf=r size=64 type=f alias=V207+0 align=32 words (r3.0)
//.declare V439 (467)  rf=r size=32 type=hf alias=V209+0 align=1 words (r7.0)
//.declare V440 (468)  rf=r size=32 type=uw alias=V209+0 align=1 words (r7.0)
//.declare V441 (469)  rf=r size=4 type=d alias=V211+0 align=2 words (r1.2)
//.declare V442 (470)  rf=r size=4 type=d alias=V212+0 align=2 words (r9.0)
//.declare V443 (471)  rf=r size=4 type=d alias=V41+0 align=2 words (r4.5)
//.declare V444 (472)  rf=r size=128 type=q alias=V213+0 align=32 words (r12.0)
//.declare V445 (473)  rf=r size=8 type=q alias=V58+0 align=4 words (r4.5)
//.declare V446 (474)  rf=r size=64 type=ud alias=V91+0 align=32 words (r89.0)
//.declare V447 (475)  rf=r size=64 type=ud alias=V92+0 align=32 words (r92.0)
//.declare V448 (476)  rf=r size=128 type=uq alias=V213+0 align=32 words (r12.0)
//.declare  (477)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (478)  rf=r size=4 type=w align=16 words (r2.16)
//.declare  (479)  rf=r size=16 type=w align=16 words (r6.0)
//.declare  (480)  rf=r size=4 type=ud align=2 words (r4.12)
//.declare  (481)  rf=r size=128 type=ud align=32 words (r7.0)
//.declare  (482)  rf=r size=128 type=ud align=32 words (r6.0)
//.declare  (483)  rf=r size=16 type=w align=16 words (r1.16)
//.declare  (485)  rf=r size=16 type=uw align=16 words (r2.16)
//.declare  (486)  rf=r size=64 type=uw align=32 words (r15.0)
//.declare  (487)  rf=r size=32 type=uw align=32 words (r16.0)
//.declare  (488)  rf=r size=64 type=uw align=32 words (r20.0)
//.declare  (489)  rf=r size=32 type=uw align=32 words (r21.0)
//.declare  (490)  rf=r size=64 type=uw align=32 words (r25.0)
//.declare  (491)  rf=r size=32 type=uw align=32 words (r26.0)
//.declare  (492)  rf=r size=128 type=ud align=32 words (r16.0)
//.declare  (493)  rf=r size=64 type=w align=32 words (r23.0)
//.declare  (494)  rf=r size=32 type=w align=32 words (r24.0)
//.declare  (495)  rf=r size=64 type=w align=32 words (r26.0)
//.declare  (496)  rf=r size=32 type=w align=32 words (r27.0)
//.declare  (497)  rf=r size=128 type=ud align=32 words (r10.0)
//.declare r0 (498)  rf=r size=64 type=ud align=32 words (r0.0)
//.declare rtmp (499)  rf=r size=64 type=ud align=32 words (r127.0)
//.declare  (500)  rf=r size=64 type=ud align=32 words (r1.0)
//.declare  (501)  rf=r size=256 type=ud align=32 words (r2.0)

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
// _ZTS22int1_fp16_upcvt_kernelILi1ELi128ELi1ELi16ELi32ELi1ELi2ELb1EE_BB_0:
(W)     mov (16|M0)              r35.0<1>:ud   r0.0<1;1,0>:ud                                        //  ALU pipe: int; $1
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
        add (1|M0)               r40.3<1>:d    r4.1<0;1,0>:d     1:w                                 //  ALU pipe: int; $25
        add (1|M0)               r8.0<1>:q     r8.0<0;1,0>:q     r1.3<0;1,0>:ud   {A@1}              //  ALU pipe: int; $9
        mov (1|M0)               r40.5<1>:d    r0.1<0;1,0>:ud                                        //  ALU pipe: int; $18
        mul (1|M0)               acc0.0<1>:ud  r8.0<0;1,0>:ud    r2.8<0;1,0>:uw   {I@2}              //  ALU pipe: int; $10
        mach (1|M0)              r11.0<1>:ud   r8.0<0;1,0>:ud    r2.4<0;1,0>:ud                      //  ALU pipe: int; 
        shr (1|M0)               r40.4<1>:ud   r40.3<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $26
        mov (1|M0)               r10.0<1>:ud   acc0.0<0;1,0>:ud                 {Compacted}          //  ALU pipe: int; 
(W)     mul (1|M0)               acc0.0<1>:d   r8.0<0;1,0>:d     r2.10<0;1,0>:uw                     //  ALU pipe: int; $11
        macl (1|M0)              r12.0<1>:d    r8.0<0;1,0>:d     r2.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $12
(W)     mul (1|M0)               acc0.0<1>:d   r8.1<0;1,0>:d     r2.8<0;1,0>:uw                      //  ALU pipe: int; $12
        macl (1|M0)              r13.0<1>:d    r8.1<0;1,0>:d     r2.4<0;1,0>:d    {Compacted}        //  ALU pipe: int; $13
        mov (1|M0)               r14.0<1>:f    r10.0<0;1,0>:f                   {Compacted,I@5}      //  ALU pipe: float; $13
        add3 (1|M0)              r14.1<1>:d    r13.0<0;0>:d      r11.0<0;0>:d      r12.0<0>:d       {I@1} //  ALU pipe: int; $14
        mov (1|M0)               r40.0<1>:d    r0.6<0;1,0>:ud                                        //  ALU pipe: int; $19
        add (1|M0)               r14.0<1>:q    r14.0<0;1,0>:q    r1.2<0;1,0>:ud   {A@1}              //  ALU pipe: int; $15
        shl (1|M0)               r40.5<1>:d    r40.5<0;1,0>:d    7:w                                 //  ALU pipe: int; $20
        cmp (1|M0)    (lt)f1.1   null<1>:ud    r14.0<0;1,0>:ud   0x8:uw              {I@2}           //  ALU pipe: int; $33
        shr (1|M0)               r41.0<1>:uq   r14.0<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $17
        add (1|M0)               r40.2<1>:d    r40.0<0;1,0>:d    1:w                                 //  ALU pipe: int; $23
(W)     mul (1|M0)               acc0.0<1>:ud  r40.4<0;1,0>:ud   r41.0<0;1,0>:uw  {I@2}              //  ALU pipe: int; $27
(f1.1)  cmp (1|M0)    (eq)f1.1   null<1>:d     r14.1<0;1,0>:d    0:w                                 //  ALU pipe: int; $34
        add (1|M0)               r40.1<1>:d    r40.5<0;1,0>:d    128:w                               //  ALU pipe: int; $21
        macl (1|M0)              r57.0<1>:ud   r40.4<0;1,0>:ud   r41.0<0;1,0>:ud                     //  ALU pipe: int; $28
        add (1|M0)               r40.4<1>:ud   r40.4<0;1,0>:ud   0x1F:uw                             //  ALU pipe: int; $31
        and (1|M0)               r41.6<1>:d    r14.0<0;1,0>:d    7:w                                 //  ALU pipe: int; $16
        mul (1|M0)               r40.10<1>:d   r41.0<0;1,0>:d    2176:w                              //  ALU pipe: int; $29
        sel (1|M0)    (lt)f0.0   r40.2<1>:ud   r40.2<0;1,0>:ud   r4.0<0;1,0>:ud   {I@7}              //  ALU pipe: int; $24
        sel (1|M0)    (lt)f0.0   r40.1<1>:ud   r40.1<0;1,0>:ud   r4.2<0;1,0>:ud   {I@6}              //  ALU pipe: int; $22
        shr (1|M0)               r69.0<1>:ud   r57.0<0;1,0>:ud   0x7:uw              {Compacted,I@6} //  ALU pipe: int; $28
        shr (1|M0)               r63.0<1>:ud   r57.0<0;1,0>:ud   0x5:uw              {Compacted}     //  ALU pipe: int; $30
        shr (1|M0)               r40.4<1>:ud   r40.4<0;1,0>:ud   0x5:uw              {I@7}           //  ALU pipe: int; $32
(W&f1.1) jmpi                                BB_1                                                    //  ALU pipe: int; $36
// B003: Preds:{B002},  Succs:{B005}
_L_k7_0_:
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
        mov (1|M0)               r40.6<1>:d    r6.0<0;1,0>:d                    {I@5}                //  ALU pipe: int; $45
        add3 (1|M0)              r40.7<1>:d    r9.0<0;0>:d       r7.0<0;0>:d       r8.0<0>:d        {I@2} //  ALU pipe: int; $46
        shl (1|M0)               r40.3<1>:q    r40.3<0;1,0>:q    2:w               {I@1}             //  ALU pipe: int; $47
        add (1|M0)               r40.3<1>:q    r5.5<0;1,0>:q     r40.3<0;1,0>:q   {I@1}              //  ALU pipe: int; $48
(W)     jmpi                                 BB_2                                                    // $49
// B004: Preds:{B002},  Succs:{B005}
BB_1:
        mov (1|M0)               r40.3<1>:q    0:w                                                   //  ALU pipe: int; $51
// B005: Preds:{B004, B003},  Succs:{B006, B007}
BB_2:
        mov (8|M0)               r6.0<1>:w     0x76543210:v                                          //  ALU pipe: int; $71
        shl (1|M0)               r40.11<1>:d   r41.6<0;1,0>:d    4:w                                 //  ALU pipe: int; $53
        mov (8|M0)               r97.0<1>:d    r6.0<1;1,0>:w                    {I@2}                //  ALU pipe: int; $71
        or (1|M0)                r40.5<1>:d    r40.11<0;1,0>:d   r40.5<0;1,0>:d   {I@2}              //  ALU pipe: int; $54
        mov (16|M0)              r89.0<1>:f    r97.0<1;1,0>:f                   {I@2}                //  ALU pipe: float; $72
        add (8|M0)               r89.8<1>:d    r97.0<1;1,0>:d    8:w               {F@1}             //  ALU pipe: int; $73
        cmp (1|M0)    (eq)f1.0   null<1>:d     r40.7<0;1,0>:d    0:w                                 //  ALU pipe: int; $78
        or (16|M0)               r92.0<1>:d    r40.5<0;1,0>:d    r89.0<1;1,0>:d   {I@2}              //  ALU pipe: int; $74
        shl (16|M0)              r93.0<1>:d    r92.0<1;1,0>:d    2:w               {Compacted,I@1}   //  ALU pipe: int; $75
        mov (16|M0)              r7.0<2>:ud    r93.0<1;1,0>:ud                  {Compacted,I@1}      //  ALU pipe: int; $76
        add (16|M0)              r9.0<1>:q     r5.4<0;1,0>:q     r7.0<2;1,0>:ud   {I@1}              //  ALU pipe: int; $76
        load.ugm.d32.a64.ca.ca (16|M0)  r94:1   [r9:2]             {I@1,$2} // ex_desc:0x0; desc:0x4180580 // $77
        shl (1|M0)               r3.0<1>:d     r4.3<0;1,0>:d     1:w                                 //  ALU pipe: int; $55
        shl (1|M0)               r40.8<1>:d    r4.4<0;1,0>:d     2:w                                 //  ALU pipe: int; $60
        shl (1|M0)               r40.9<1>:d    r5.4<0;1,0>:d     1:w                                 //  ALU pipe: int; $65
(W)     mov (1|M0)               r4.12<1>:f    4.092601e-34:f                                        //  (0x08080000:f); ALU pipe: float; $69
(W)     mul (1|M0)               acc0.0<1>:d   r3.0<0;1,0>:d     r40.0<0;1,0>:uw  {I@3}              //  ALU pipe: int; $56
        mov (1|M0)               r40.7<1>:q    r57.0<0;1,0>:ud                                       //  ALU pipe: int; $57
        mov (1|M0)               r41.2<1>:q    r40.5<0;1,0>:ud                                       //  ALU pipe: int; $62
(f1.0)  cmp (1|M0)    (eq)f1.0   null<1>:d     r40.6<0;1,0>:d    0:w                                 //  ALU pipe: int; $79
        macl (1|M0)              r3.0<1>:d     r3.0<0;1,0>:d     r40.0<0;1,0>:d   {Compacted}        //  ALU pipe: int; $57
(W)     mul (1|M0)               acc0.0<1>:d   r63.0<0;1,0>:d    r40.16<0;1,0>:uw {I@7}              //  ALU pipe: int; $61
        bfn.(s0|s1&s2) (1|M0)    r5.0<1>:ud    r4.12<0;0>:ud     r41.0<0;0>:ud     0xFF:uw              {F@1} //  ALU pipe: int; $69
        macl (1|M0)              r63.0<1>:d    r63.0<0;1,0>:d    r40.8<0;1,0>:d   {Compacted}        //  ALU pipe: int; $62
(W)     mul (1|M0)               acc0.0<1>:d   r69.0<0;1,0>:d    r40.18<0;1,0>:uw {I@7}              //  ALU pipe: int; $66
        shl (1|M0)               r40.7<1>:q    r40.7<0;1,0>:q    1:w               {I@7}             //  ALU pipe: int; $58
        shl (1|M0)               r41.1<1>:q    r41.2<0;1,0>:q    2:w               {I@7}             //  ALU pipe: int; $63
        macl (1|M0)              r69.0<1>:d    r69.0<0;1,0>:d    r40.9<0;1,0>:d                      //  ALU pipe: int; $67
        shl (1|M0)               r41.2<1>:q    r41.2<0;1,0>:q    1:w                                 //  ALU pipe: int; $67
        mov (16|M0)              r83.0<1>:f    r5.0<0;1,0>:f                    {I@7}                //  ALU pipe: float; $70
        add (1|M0)               r40.7<1>:q    r40.7<0;1,0>:q    r3.0<0;1,0>:ud   {I@4}              //  ALU pipe: int; $59
        add (1|M0)               r41.1<1>:q    r41.1<0;1,0>:q    r63.0<0;1,0>:ud  {I@4}              //  ALU pipe: int; $64
        add (1|M0)               r41.2<1>:q    r41.2<0;1,0>:q    r69.0<0;1,0>:ud  {I@3}              //  ALU pipe: int; $68
(W&f1.0) jmpi                                BB_3                                                    //  ALU pipe: int; $81
// B006: Preds:{B005},  Succs:{B008}
_L_k7_1_:
        mov (16|M0)              r6.0<2>:ud    r93.0<1;1,0>:ud                                       //  ALU pipe: int; $82
        add (16|M0)              r8.0<1>:q     r40.3<0;1,0>:q    r6.0<2;1,0>:ud   {@1,$2.src}        //  ALU pipe: int; $82
        load.ugm.d32.a64.ca.ca (16|M0)  r95:1   [r8:2]             {I@1,$3} // ex_desc:0x0; desc:0x4180580 // $83
(W)     jmpi                                 BB_4                                                    // $84
// B007: Preds:{B005},  Succs:{B008}
BB_3:
        mov (16|M0)              r95.0<1>:d    0:w                                                   //  ALU pipe: int; $87
// B008: Preds:{B007, B006},  Succs:{B009}
BB_4:
        mov (8|M0)               r1.16<1>:w    0x10101010:v                                          //  ALU pipe: int; $89
        mov (8|M0)               r2.16<1>:uw   0xFEDCBA98:uv                                         //  ALU pipe: int; $93
        mov (8|M0)               r96.0<1>:d    r1.16<1;1,0>:w                   {I@2}                //  ALU pipe: int; $89
        mov (8|M0)               r96.8<1>:d    r1.16<1;1,0>:w                                        //  ALU pipe: int; $90
        mov (8|M0)               r97.8<1>:d    r2.16<1;1,0>:uw                  {I@3}                //  ALU pipe: int; $93
        mul (16|M0)              r96.0<1>:d    r96.0<1;1,0>:d    0x8000:uw              {I@2}        //  ALU pipe: int; $91
        mul (16|M0)              r97.0<1>:d    r97.0<1;1,0>:d    0x8000:uw              {I@2}        //  ALU pipe: int; $94
        add (16|M0)              r96.0<1>:d    r96.0<1;1,0>:d    15360:w               {I@2}         //  ALU pipe: int; $92
// B009: Preds:{B012, B008},  Succs:{B010, B012}
BB_5:
        shr (16|M0)              r1.4<1>:uw    r40.22<0;1,0>:uw  0x4:uw                              //  ALU pipe: int; $96
        shr (16|M0)              r2.6<1>:uw    r40.22<0;1,0>:uw  0x5:uw                              //  ALU pipe: int; $99
        shr (16|M0)              r3.0<1>:uw    r40.22<0;1,0>:uw  0x6:uw                              //  ALU pipe: int; $101
        and (16|M0)              r1.4<1>:uw    r1.4<1;1,0>:uw    0x1:uw              {I@3}           //  ALU pipe: int; $97
        and (16|M0)              r2.6<1>:uw    r2.6<1;1,0>:uw    0x1:uw              {I@3}           //  ALU pipe: int; $100
        and (16|M0)              r3.0<1>:uw    r3.0<1;1,0>:uw    0x1:uw              {I@3}           //  ALU pipe: int; $102
        add (16|M0)              r8.0<1>:d     r1.4<1;1,0>:uw    r2.6<1;1,0>:uw   {@2,$3.src}        //  ALU pipe: int; $104
        shr (16|M0)              r14.0<1>:ud   r97.0<1;1,0>:ud   r1.4<1;1,0>:uw                      //  ALU pipe: int; $107 R{} IR{}{O:0,O:0,},  {BC=1}
        add (16|M0)              r10.0<1>:d    r8.0<1;1,0>:d     r3.0<1;1,0>:uw   {@2,$2.src}        //  ALU pipe: int; $105
        bfn.(s0|s1&s2) (16|M0)   r15.0<2>:uw   0x3C00:uw               r14.0<4;2>:uw     0x8000:uw              {I@2} //  ALU pipe: int; $108
        shr (16|M0)              r10.0<1>:ud   r97.0<1;1,0>:ud   r10.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $115
        mov (16|M0)              r16.0<1>:uw   r15.0<2;1,0>:uw                  {I@2}                //  ALU pipe: int; $108
        bfn.(s0|s1&s2) (16|M0)   r25.0<2>:uw   0x3C00:uw               r10.0<4;2>:uw     0x8000:uw              {I@2} //  ALU pipe: int; $116
        shr (16|M0)              r6.0<1>:ud    r40.11<0;1,0>:ud  0x7:uw              {Compacted}     //  ALU pipe: int; $103
        mov (16|M0)              acc0.0<1>:d   -r2.6<1;1,0>:uw                                       //  ALU pipe: int; $109
        shr (16|M0)              r8.0<1>:ud    r97.0<1;1,0>:ud   r8.0<1;1,0>:ud                      //  ALU pipe: int; $111
        mov (16|M0)              r17.0<1>:hf   r16.0<1;1,0>:hf                  {I@5}                //  ALU pipe: float; $108
        mov (16|M0)              r26.0<1>:uw   r25.0<2;1,0>:uw                  {I@4}                //  ALU pipe: int; $116
        bfn.(s0|s1&s2) (16|M0)   r20.0<2>:uw   0x3C00:uw               r8.0<4;2>:uw      0x8000:uw              {I@2} //  ALU pipe: int; $112
        and (16|M0)              r19.0<1>:d    r17.0<1;1,0>:uw   acc0.0<1;1,0>:d  {F@1}              //  ALU pipe: int; $110
        mov (16|M0)              r27.0<1>:hf   r26.0<1;1,0>:hf                  {I@3}                //  ALU pipe: float; $116
        mov (16|M0)              acc2.0<1>:d   -r6.0<1;1,0>:d                                        //  ALU pipe: int; $117
        mov (16|M0)              r21.0<1>:uw   r20.0<2;1,0>:uw                  {I@3}                //  ALU pipe: int; $112
        and (16|M0)              acc2.0<1>:d   r27.0<1;1,0>:uw   acc2.0<1;1,0>:d  {F@1}              //  ALU pipe: int; $118
        or (16|M0)               acc0.0<1>:d   r40.11<0;1,0>:d   r89.0<1;1,0>:d                      //  ALU pipe: int; $119
        mov (16|M0)              r22.0<1>:hf   r21.0<1;1,0>:hf                  {I@3}                //  ALU pipe: float; $112
        shl (16|M0)              r28.0<1>:d    acc0.0<1;1,0>:d   3:w                                 //  ALU pipe: int; $120
        mov (16|M0)              r12.0<1>:d    -r1.4<1;1,0>:uw                                       //  ALU pipe: int; $106
        mov (16|M0)              r24.0<1>:d    -r3.0<1;1,0>:uw                                       //  ALU pipe: int; $114
        shl (16|M0)              r19.0<1>:d    r19.0<1;1,0>:d    16:w                                //  ALU pipe: int; $122
        shl (16|M0)              r6.0<1>:d     acc2.0<1;1,0>:d   16:w                                //  ALU pipe: int; $124
        mov (16|M0)              r23.0<1>:d    r22.0<1;1,0>:uw                  {F@1}                //  ALU pipe: int; $113
        add (16|M0)              r29.0<1>:d    r28.0<1;1,0>:d    r40.10<0;1,0>:d  {@6,$4.src}        //  ALU pipe: int; $121
        cmp (1|M0)    (lt)f0.0   null<1>:ud    r40.11<0;1,0>:ud  0x80:uw                             //  ALU pipe: int; $130
        bfn.(s0|s1&s2) (16|M0)   r30.0<1>:ud   r19.0<1;0>:ud     r12.0<1;0>:ud     r96.0<1>:ud      {I@5} //  ALU pipe: int; $123
        bfn.(s0|s1&s2) (16|M0)   r31.0<1>:ud   r6.0<1;0>:ud      r23.0<1;0>:ud     r24.0<1>:ud      {@4,$5.src} //  ALU pipe: int; $125
        or (16|M0)               r32.0<1>:ud   r29.0<1;1,0>:ud   0x4:uw              {I@4}           //  ALU pipe: int; $127
        store.slm.d32.a32 (16|M0)  [r29:1]      r30:1              {I@3,$4} // ex_desc:0x0; desc:0x2000504 // $126
        store.slm.d32.a32 (16|M0)  [r32:1]      r31:1              {I@1,$5} // ex_desc:0x0; desc:0x2000504 // $128
        add (1|M0)               r40.12<1>:d   r40.11<0;1,0>:d   128:w                               //  ALU pipe: int; $129
(W&f0.0) jmpi                                BB_6                                                    //  ALU pipe: int; $131
// B010: Preds:{B009},  Succs:{B011, B013}
_L_k7_2_:
        cmp (1|M0)    (eq)f3.1   null<1>:d     r41.6<0;1,0>:d    0:w                                 //  ALU pipe: int; $132
(W&f3.1) jmpi                                BB_7                                                    //  ALU pipe: int; $133
// B011: Preds:{B010},  Succs:{B014}
_L_k7_3_:
(W)     jmpi                                 BB_8                                                    // $134
// B012: Preds:{B009},  Succs:{B009}
BB_6:
        mov (1|M0)               r40.11<1>:d   r40.12<0;1,0>:d                  {I@5}                //  ALU pipe: int; $136
(W)     jmpi                                 BB_5                                                    // $137
// B013: Preds:{B010},  Succs:{B014}
BB_7:
        mul (16|M0)              acc0.0<1>:d   r89.0<1;1,0>:d    4:w               {Compacted}       //  ALU pipe: int; $139
        add (16|M0)              acc2.0<1>:d   acc0.0<1;1,0>:d   2048:w                              //  ALU pipe: int; $140
        add (16|M0)              r3.0<1>:d     r40.10<0;1,0>:d   acc2.0<1;1,0>:d                     //  ALU pipe: int; $141
        add (16|M0)              acc0.0<1>:d   acc0.0<1;1,0>:d   2112:w                              //  ALU pipe: int; $145
        mov (16|M0)              r6.0<1>:d     1920:w                               {Compacted}      //  ALU pipe: int; $143
        mov (16|M0)              r8.0<1>:d     120:w                               {Compacted}       //  ALU pipe: int; $148
        add (16|M0)              r7.0<1>:d     r40.10<0;1,0>:d   acc0.0<1;1,0>:d                     //  ALU pipe: int; $146
        store.slm.d32.a32 (16|M0)  [r3:1]       r6:1               {I@3,$6} // ex_desc:0x0; desc:0x2000504 // $144
        store.slm.d32.a32 (16|M0)  [r7:1]       r8:1               {I@1,$7} // ex_desc:0x0; desc:0x2000504 // $149
// B014: Preds:{B013, B011},  Succs:{B015, B017}
BB_8:
        sync.nop                             null                             {Compacted,$6.src}     // $151
(W)     send.slm (1|M0)          r3       r35  null:0  0x0            0x0210001F           {$8} // wr:1+0, rd:1; fence.slm.none.group // $151
(W)     mov (8|M0)               null<1>:ud    r3.0<1;1,0>:ud                   {$8.dst}             //  memory fence commit; ALU pipe: int; $152
        send.gtwy (1|M0)         null     r83  null:0  0x0            0x02000004           {$9} // wr:1+0, rd:0; signal barrier // $152
(W)     mov (1|M0)               f1.0<1>:uw    r41.0<0;1,0>:b                                        //  ALU pipe: int; $153
(W)     sync.bar                             f1.0:uw                                                 // $153
        add (1|M0)               r5.0<1>:d     r40.10<0;1,0>:d   2048:w                              //  ALU pipe: int; $154
        add (1|M0)               r6.0<1>:d     r40.10<0;1,0>:d   2112:w                              //  ALU pipe: int; $156
        load.slm.d32x16t.a32 (1|M0)  r99:1      [r5:1]             {I@2,$10} // ex_desc:0x0; desc:0x210D500 // $155
        load.slm.d32x16t.a32 (1|M0)  r98:1      [r6:1]             {I@1,$11} // ex_desc:0x0; desc:0x210D500 // $157
        cmp (1|M0)    (lt)f3.0   null<1>:ud    r40.3<0;1,0>:ud   0x2:uw                              //  ALU pipe: int; $161
        mov (16|M0)              r100.0<1>:f   0.0:f                                                 //  ALU pipe: float; $160
(W&f3.0) jmpi                                BB_9                                                    //  ALU pipe: int; $162
// B015: Preds:{B014},  Succs:{B016}
_L_k7_4_:
        sel (1|M0)    (ge)f0.0   r40.4<1>:ud   r40.4<0;1,0>:ud   0x1:uw                              //  ALU pipe: int; $163
        mov (1|M0)               r40.13<1>:d   0:w                                                   //  ALU pipe: int; $164
// B016: Preds:{B016, B015},  Succs:{B017, B016}
BB_10:
        shr (1|M0)               r3.0<1>:uq    r40.7<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $166
        shr (1|M0)               r8.0<1>:uq    r41.1<0;1,0>:uq   0x3:uw              {$7.src}        //  ALU pipe: int; $171
        shr (1|M0)               r10.0<1>:uq   r41.2<0;1,0>:uq   0x3:uw                              //  ALU pipe: int; $176
        shl (1|M0)               r3.0<1>:uq    r3.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $167
        shl (1|M0)               r8.0<1>:uq    r8.0<0;1,0>:uq    0x3:uw              {I@3}           //  ALU pipe: int; $172
        shl (1|M0)               r10.0<1>:uq   r10.0<0;1,0>:uq   0x3:uw              {I@3}           //  ALU pipe: int; $177
        add (1|M0)               r3.0<1>:uq    r4.3<0;1,0>:uq    r3.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $168
        add (1|M0)               r8.0<1>:uq    r4.4<0;1,0>:uq    r8.0<0;1,0>:uq   {I@3}              //  ALU pipe: int; $173
        add (1|M0)               r10.0<1>:uq   r5.1<0;1,0>:uq    r10.0<0;1,0>:uq  {I@3}              //  ALU pipe: int; $178
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r7:1  [r3:1]             {I@3,$12} // ex_desc:0x0; desc:0x218C780 // $170
        load.ugm.d64x8t.a64.ca.ca (1|M0)  r9:1  [r8:1]             {I@2,$13} // ex_desc:0x0; desc:0x218C780 // $175
        load.ugm.d64x4t.a64.ca.ca (1|M0)  r11:1 [r10:1]            {I@1,$14} // ex_desc:0x0; desc:0x218B780 // $180
        add (1|M0)               r40.13<1>:d   r40.13<0;1,0>:d   1:w                                 //  ALU pipe: int; $181
        and (1|M0)    (eq)f2.1   null<1>:d     r40.13<0;1,0>:d   3:w               {I@1}             //  ALU pipe: int; $185
        add (1|M0)               r40.7<1>:uq   r40.7<0;1,0>:uq   0x40:uw                             //  ALU pipe: int; $184
(f2.1)  sel (1|M0)               r12.0<1>:d    r40.9<0;1,0>:d    0:w                                 //  ALU pipe: int; $187
        shr (16|M0)              acc2.0<1>:ud  r95.0<1;1,0>:ud   0x5:uw              {$3.dst}        //  ALU pipe: int; $191
        add (16|M0)              acc2.0<1>:ud  acc2.0<1;1,0>:ud  r94.0<1;1,0>:ud  {$2.dst}           //  ALU pipe: int; $192
        shl (16|M0)              r15.0<1>:ud   acc2.0<1;1,0>:ud  0x2:uw                              //  ALU pipe: int; $193
        mov (16|M0)              r16.0<2>:ud   r15.0<1;1,0>:ud                  {I@1}                //  ALU pipe: int; $194
        add (16|M0)              r18.0<1>:q    r5.3<0;1,0>:q     r16.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $194
        load.ugm.d32x3.a64.ca.ca (16|M0)  r20:3 [r18:2]            {I@1,$15} // ex_desc:0x0; desc:0x4382580 // $196
        and (16|M0)   (eq)f2.0   r23.0<2>:w    r95.0<2;1,0>:w    31:w                                //  ALU pipe: int; $199
        mov (16|M0)              r26.0<2>:w    -r95.0<2;1,0>:w                                       //  ALU pipe: int; $201
        mov (16|M0)              r27.0<1>:w    r26.0<2;1,0>:w                   {I@1}                //  ALU pipe: int; $201
        mov (16|M0)              r24.0<1>:w    r23.0<2;1,0>:w                                        //  ALU pipe: int; $199
        mov (16|M0)              r28.0<1>:hf   r27.0<1;1,0>:hf                  {I@2}                //  ALU pipe: float; $201
        mov (16|M0)              r25.0<1>:hf   r24.0<1;1,0>:hf                  {I@1}                //  ALU pipe: float; $199
        bfn.(s0&~s2|s1&s2) (16|M0)   acc2.0<1>:ud  r20.0<1;0>:ud  r21.0<1;0>:ud    0x0:uw              {$15.dst} //  ALU pipe: int; $197
        and (16|M0)              r28.0<1>:w    r28.0<1;1,0>:w    31:w               {F@2}            //  ALU pipe: int; $202
        bfn.(s0&~s2|s1&s2) (16|M0)   acc0.0<1>:ud  r21.0<1;0>:ud  r22.0<1;0>:ud    0x0:uw              //  ALU pipe: int; $198
        sync.nop                             null                             {F@1}                  // $204
        shr (16|M0)              r30.0<1>:ud   acc2.0<1;1,0>:ud  r25.0<1;1,0>:uw  {$4.src}           //  ALU pipe: int; $204
        shl (16|M0)              r31.0<1>:ud   acc0.0<1;1,0>:ud  r28.0<1;1,0>:uw  {@3,$5.src}        //  ALU pipe: int; $205
(~f2.0) or (16|M0)               r30.0<1>:ud   r31.0<1;1,0>:ud   r30.0<1;1,0>:ud  {I@1}              //  ALU pipe: int; $207
        shl (16|M0)              r33.0<1>:ud   r9.0<1;1,0>:ud    0x7:uw              {Compacted,$13.dst} //  ALU pipe: int; $211
        shl (16|M0)              r36.0<1>:ud   r30.0<1;1,0>:ud   0x3:uw              {Compacted,I@2} //  ALU pipe: int; $213
        and (16|M0)              r34.0<1>:ud   r33.0<1;1,0>:ud   r99.0<1;1,0>:ud  {Compacted,@2,$10.dst} //  ALU pipe: int; $212
        and (16|M0)              r36.0<1>:ud   r36.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,@2,$11.dst} //  ALU pipe: int; $214
        cbit (16|M0)             r34.0<1>:ud   r34.0<1;1,0>:ud                  {I@2}                //  ALU pipe: int; $221
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  r33.0<1;0>:ud     r99.0<1;0>:ud     r36.0<1>:ud      {I@2} //  ALU pipe: int; $215
        add (16|M0)              r37.0<1>:ud   acc2.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $216
        shr (16|M0)              acc2.0<1>:ud  r30.0<1;1,0>:ud   r34.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $222
        shl (16|M0)              r50.0<1>:ud   r9.0<1;1,0>:ud    0x3:uw                              //  ALU pipe: int; $223
        shl (16|M0)              r52.0<1>:ud   acc2.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $225
        and (16|M0)              r51.0<1>:ud   r50.0<1;1,0>:ud   r99.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $224
        and (16|M0)              r52.0<1>:ud   r52.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $226
        cbit (16|M0)             r51.0<1>:ud   r51.0<1;1,0>:ud                  {I@2}                //  ALU pipe: int; $233
        bfn.(s0&s1|s2) (16|M0)   acc0.0<1>:ud  r50.0<1;0>:ud     r99.0<1;0>:ud     r52.0<1>:ud      {I@2} //  ALU pipe: int; $227
        add (16|M0)              r53.0<1>:ud   acc0.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $228
        shr (16|M0)              acc0.0<1>:ud  acc2.0<1;1,0>:ud  r51.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $234
        shr (16|M0)              r13.0<1>:ud   r9.0<1;1,0>:ud    0x1:uw              {Compacted}     //  ALU pipe: int; $189
        shl (16|M0)              r58.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $236
        and (16|M0)              r56.0<1>:ud   r13.0<1;1,0>:ud   r99.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $235
        and (16|M0)              r58.0<1>:ud   r58.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $237
        cbit (16|M0)             r56.0<1>:ud   r56.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $244
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  r13.0<1;0>:ud     r99.0<1;0>:ud     r58.0<1>:ud      {I@2} //  ALU pipe: int; $238
        add (16|M0)              r59.0<1>:ud   acc2.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $239
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r56.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $245
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x5:uw                              //  ALU pipe: int; $246
        shl (16|M0)              r64.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $248
        and (16|M0)              r62.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $247
        and (16|M0)              r64.0<1>:ud   r64.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $249
        cbit (16|M0)             r62.0<1>:ud   r62.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $256
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r64.0<1>:ud      {I@2} //  ALU pipe: int; $250
        add (16|M0)              r65.0<1>:ud   acc2.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $251
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r62.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $257
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x9:uw                              //  ALU pipe: int; $258
        shl (16|M0)              r70.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $260
        and (16|M0)              r68.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $259
        and (16|M0)              r70.0<1>:ud   r70.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $261
        cbit (16|M0)             r68.0<1>:ud   r68.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $268
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r70.0<1>:ud      {I@2} //  ALU pipe: int; $262
        add (16|M0)              r71.0<1>:ud   acc2.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $263
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r68.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $269
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0xD:uw                              //  ALU pipe: int; $270
        shl (16|M0)              r84.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $272
        and (16|M0)              r82.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $271
        and (16|M0)              r84.0<1>:ud   r84.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $273
        cbit (16|M0)             r82.0<1>:ud   r82.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $280
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r84.0<1>:ud      {I@2} //  ALU pipe: int; $274
        add (16|M0)              r85.0<1>:ud   acc2.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $275
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r82.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $281
        shr (16|M0)              acc2.0<1>:ud  r9.0<1;1,0>:ud    0x11:uw                             //  ALU pipe: int; $282
        shl (16|M0)              r90.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $284
        and (16|M0)              r88.0<1>:ud   acc2.0<1;1,0>:ud  r99.0<1;1,0>:ud                     //  ALU pipe: int; $283
        and (16|M0)              r90.0<1>:ud   r90.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $285
        cbit (16|M0)             r88.0<1>:ud   r88.0<1;1,0>:ud                  {Compacted,I@2}      //  ALU pipe: int; $293
        bfn.(s0&s1|s2) (16|M0)   acc2.0<1>:ud  acc2.0<1;0>:ud    r99.0<1;0>:ud     r90.0<1>:ud      {I@2} //  ALU pipe: int; $286
        add (16|M0)              r91.0<1>:ud   acc2.0<1;1,0>:ud  r40.10<0;1,0>:ud                    //  ALU pipe: int; $287
        shr (16|M0)              acc0.0<1>:ud  acc0.0<1;1,0>:ud  r88.0<1;1,0>:ud  {I@3}              //  ALU pipe: int; $294
        shl (16|M0)              r30.0<1>:ud   acc0.0<1;1,0>:ud  0x3:uw                              //  ALU pipe: int; $295
        cbit (16|M0)             r14.0<1>:ud   r9.0<1;1,0>:ud                   {Compacted}          //  ALU pipe: int; $190
        and (16|M0)              r30.0<1>:ud   r30.0<1;1,0>:ud   r98.0<1;1,0>:ud  {Compacted,I@2}    //  ALU pipe: int; $296
        shr (16|M0)              r9.0<1>:ud    r9.0<1;1,0>:ud    0x15:uw              {Compacted}    //  ALU pipe: int; $292
        bfn.(s0&s1|s2) (16|M0)   r9.0<1>:ud    r9.0<1;0>:ud      r99.0<1;0>:ud     r30.0<1>:ud      {I@1} //  ALU pipe: int; $297
        add (16|M0)              r13.0<1>:ud   r9.0<1;1,0>:ud    r40.10<0;1,0>:ud {Compacted,I@1}    //  ALU pipe: int; $298
        load.slm.d32x2.a32 (16|M0)  r38:2       [r37:1]            {$0} // ex_desc:0x0; desc:0x2201500 // $218
        load.slm.d32x2.a32 (16|M0)  r54:2       [r53:1]            {$1} // ex_desc:0x0; desc:0x2201500 // $230
        load.slm.d32x2.a32 (16|M0)  r60:2       [r59:1]            {$6} // ex_desc:0x0; desc:0x2201500 // $241
        load.slm.d32x2.a32 (16|M0)  r66:2       [r65:1]            {$8} // ex_desc:0x0; desc:0x2201500 // $253
        load.slm.d32x2.a32 (16|M0)  r72:2       [r71:1]            {$13} // ex_desc:0x0; desc:0x2201500 // $265
        load.slm.d32x2.a32 (16|M0)  r86:2       [r85:1]            {$15} // ex_desc:0x0; desc:0x2201500 // $277
        load.slm.d32x2.a32 (16|M0)  r15:2       [r13:1]            {I@1,$2} // ex_desc:0x0; desc:0x2201500 // $300
        mov (16|M0)              r32.0<2>:uw   r11.0<1;1,0>:uw                  {$14.dst}            //  ALU pipe: int; $209
        mov (16|M0)              r32.1<2>:uw   r11.0<1;1,0>:uw                                       //  ALU pipe: int; $210
        load.slm.d32x2.a32 (16|M0)  r10:2       [r91:1]            {I@1,$14} // ex_desc:0x0; desc:0x2201500 // $289
        add (1|M0)               r41.1<1>:q    r41.1<0;1,0>:q    r40.8<0;1,0>:ud                     //  ALU pipe: int; $303
        add (1|M0)               r41.2<1>:q    r41.2<0;1,0>:q    r12.0<0;1,0>:ud                     //  ALU pipe: int; $304
        add (16|M0)              r95.0<1>:ud   r14.0<1;1,0>:ud   r95.0<1;1,0>:ud                     //  ALU pipe: int; $305
        mul (32|M0)              r42.0<1>:hf   r32.0<1;1,0>:hf   r38.0<1;1,0>:hf  {$0.dst}           //  ALU pipe: float; $219
        mul (32|M0)              r43.0<1>:hf   r32.0<1;1,0>:hf   r39.0<1;1,0>:hf                     //  ALU pipe: float; $220
        mul (32|M0)              r44.0<1>:hf   r32.0<1;1,0>:hf   r54.0<1;1,0>:hf  {$1.dst}           //  ALU pipe: float; $231
        mul (32|M0)              r45.0<1>:hf   r32.0<1;1,0>:hf   r55.0<1;1,0>:hf                     //  ALU pipe: float; $232
        mul (32|M0)              r46.0<1>:hf   r32.0<1;1,0>:hf   r60.0<1;1,0>:hf  {$6.dst}           //  ALU pipe: float; $242
        mul (32|M0)              r47.0<1>:hf   r32.0<1;1,0>:hf   r61.0<1;1,0>:hf                     //  ALU pipe: float; $243
        mul (32|M0)              r48.0<1>:hf   r32.0<1;1,0>:hf   r66.0<1;1,0>:hf  {$8.dst}           //  ALU pipe: float; $254
        mul (32|M0)              r49.0<1>:hf   r32.0<1;1,0>:hf   r67.0<1;1,0>:hf                     //  ALU pipe: float; $255
        mul (32|M0)              r74.0<1>:hf   r32.0<1;1,0>:hf   r72.0<1;1,0>:hf  {$13.dst}          //  ALU pipe: float; $266
        mul (32|M0)              r75.0<1>:hf   r32.0<1;1,0>:hf   r73.0<1;1,0>:hf                     //  ALU pipe: float; $267
        mul (32|M0)              r76.0<1>:hf   r32.0<1;1,0>:hf   r86.0<1;1,0>:hf  {$15.dst}          //  ALU pipe: float; $278
        mul (32|M0)              r77.0<1>:hf   r32.0<1;1,0>:hf   r87.0<1;1,0>:hf                     //  ALU pipe: float; $279
        mul (32|M0)              r80.0<1>:hf   r32.0<1;1,0>:hf   r15.0<1;1,0>:hf  {$2.dst}           //  ALU pipe: float; $301
        mul (32|M0)              r81.0<1>:hf   r32.0<1;1,0>:hf   r16.0<1;1,0>:hf                     //  ALU pipe: float; $302
        mul (32|M0)              r78.0<1>:hf   r32.0<1;1,0>:hf   r10.0<1;1,0>:hf  {$14.dst}          //  ALU pipe: float; $290
        mul (32|M0)              r79.0<1>:hf   r32.0<1;1,0>:hf   r11.0<1;1,0>:hf                     //  ALU pipe: float; $291
        sync.nop                             null                             {Compacted,F@7}        // $307
        dpas.8x1 (16|M0)         r100:f        r100:f            r42:hf            r7.0:hf          {Compacted,$12} // $307
        sync.nop                             null                             {Compacted,F@1}        // $308
        dpas.8x1 (16|M0)         r100:f        r100:f            r74:hf            r7.16:hf         {Compacted,$12} // $308
        mov (1|M0)               null<1>:ud    r100.0<0;1,0>:w                  {$12.dst}            //  ALU pipe: int; $309
        cmp (1|M0)    (eq)f2.0   null<1>:d     r40.13<0;1,0>:d   r40.4<0;1,0>:d                      //  ALU pipe: int; $311
(W&~f2.0) jmpi                               BB_10                                                   //  ALU pipe: int; $312
// B017: Preds:{B016, B014},  Succs:{B018, B019}
BB_9:
        shl (1|M0)               r101.0<1>:d   r41.6<0;1,0>:d    6:w               {Compacted}       //  ALU pipe: int; $316
        shl (1|M0)               r3.0<1>:d     r41.0<0;1,0>:d    9:w               {Compacted}       //  ALU pipe: int; $317
        add (1|M0)               r101.0<1>:d   r101.0<0;1,0>:d   4352:w               {I@2}          //  ALU pipe: int; $318
        add (1|M0)               r41.6<1>:d    r41.6<0;1,0>:d    2:w                                 //  ALU pipe: int; $321
        add (1|M0)               r3.0<1>:d     r101.0<0;1,0>:d   r3.0<0;1,0>:d    {Compacted,I@2}    //  ALU pipe: int; $319
        or (1|M0)                r4.12<1>:d    r41.6<0;1,0>:d    33685504:d               {I@2}      //  ALU pipe: int; $322
        store.slm.d64x8t.a32 (1|M0)  [r3:1]     r100:1             {I@2,$0} // ex_desc:0x0; desc:0x200C704 // $320
        mov (16|M0)              r6.0<1>:d     r4.12<0;1,0>:d                   {Compacted,@1,$11.src} //  ALU pipe: int; $323
        sync.nop                             null                             {Compacted,$7.src}     // $324
(W)     send.slm (1|M0)          r7       r35  null:0  0x0            0x0210001F           {$1} // wr:1+0, rd:1; fence.slm.none.group // $324
(W)     mov (8|M0)               null<1>:ud    r7.0<1;1,0>:ud                   {Compacted,$1.dst}   //  memory fence commit; ALU pipe: int; $325
        send.gtwy (1|M0)         null     r6  null:0  0x0            0x02000004           {I@2,$6} // wr:1+0, rd:0; signal barrier // $325
(W)     mov (1|M0)               f0.0<1>:uw    r41.24<0;1,0>:b                                       //  ALU pipe: int; $326
(W)     sync.bar                             f0.0:uw                                                 // $326
        and (1|M0)    (eq)f1.1   null<1>:d     r41.0<0;1,0>:d    1:w                                 //  ALU pipe: int; $315
(W&~f1.1) jmpi                               BB_11                                                   //  ALU pipe: int; $328
// B018: Preds:{B017},  Succs:{B019}
_L_k7_5_:
        shr (1|M0)               r1.2<1>:ud    r41.0<0;1,0>:ud   0x1:uw              {Compacted}     //  ALU pipe: int; $329
        mul (16|M0)              r89.0<1>:d    r89.0<1;1,0>:d    2:w               {Compacted}       //  ALU pipe: int; $342
        shl (1|M0)               r2.3<1>:ud    r1.2<0;1,0>:ud    0x9:uw              {I@2}           //  ALU pipe: int; $330
        add (1|M0)               r1.2<1>:d     r1.2<0;1,0>:d     r40.0<0;1,0>:d                      //  ALU pipe: int; $338
        add (1|M0)               r101.0<1>:d   r101.0<0;1,0>:d   r2.3<0;1,0>:d    {I@2}              //  ALU pipe: int; $331
(W)     mul (1|M0)               acc0.0<1>:d   r1.2<0;1,0>:d     r4.10<0;1,0>:uw  {I@2}              //  ALU pipe: int; $339
        load.slm.d64x8t.a32 (1|M0)  r3:1        [r101:1]           {I@2,$7} // ex_desc:0x0; desc:0x210C700 // $332
        add (1|M0)               r101.0<1>:d   r101.0<0;1,0>:d   512:w               {Compacted,$7.src} //  ALU pipe: int; $333
        macl (1|M0)              r9.0<1>:d     r1.2<0;1,0>:d     r4.5<0;1,0>:d    {Compacted}        //  ALU pipe: int; $340
        sync.nop                             null                             {Compacted,$6.src}     // $334
        load.slm.d64x8t.a32 (1|M0)  r6:1        [r101:1]           {I@2,$8} // ex_desc:0x0; desc:0x210C700 // $334
        add (1|M0)               r9.0<1>:d     r9.0<0;1,0>:d     r40.5<0;1,0>:d   {Compacted,I@1}    //  ALU pipe: int; $340
        cmp (16|M0)   (lt)f0.1   null<1>:d     r1.2<0;1,0>:ud    r40.2<0;1,0>:ud                     //  ALU pipe: int; $345
        shl (1|M0)               r9.0<1>:d     r9.0<0;1,0>:d     1:w               {Compacted,I@2}   //  ALU pipe: int; $341
        add (16|M0)              r89.0<1>:d    r9.0<0;1,0>:d     r89.0<1;1,0>:d   {Compacted,I@1}    //  ALU pipe: int; $343
        sync.nop                             null                             {Compacted,$8.dst}     // $335
        add (16|M0)              r6.0<1>:f     r6.0<1;1,0>:f     r3.0<1;1,0>:f    {Compacted,$7.dst} //  ALU pipe: float; $335
(f0.1)  cmp (16|M0)   (lt)f0.1   null<1>:d     r92.0<1;1,0>:ud   r40.1<0;1,0>:ud                     //  ALU pipe: int; $346
        mov (16|M0)              r10.0<2>:ud   r89.0<1;1,0>:ud                  {I@2}                //  ALU pipe: int; $344
        mov (16|M0)              r7.0<1>:hf    r6.0<1;1,0>:f                    {F@1}                //  ALU pipe: float; $336
        add (16|M0)              r12.0<1>:q    r4.5<0;1,0>:q     r10.0<2;1,0>:ud  {I@1}              //  ALU pipe: int; $344
        mov (16|M0)              r8.0<1>:d     r7.0<1;1,0>:uw                   {F@1}                //  ALU pipe: int; $337
(f0.1)  store.ugm.d16u32.a64.st.wb (16|M0)  [r12:2] r8:1           {I@1,$12} // ex_desc:0x0; desc:0x40C0B84 // $348
// B019: Preds:{B018, B017},  Succs:{}
BB_11:
(W)     mov (16|M0)              r127.0<1>:f   r35.0<1;1,0>:f                   {Compacted}          //  ALU pipe: float; $350
(W)     send.gtwy (1|M0)         null     r127  null:0  0x0            0x02000010           {EOT,F@1,$13} // wr:1+0, rd:0; end of thread // $350


//.BankConflicts: 1
//.ByteRMWs: 0
//


//.numALUInst: 316
//.accSubDef: 29
//.accSubUse: 40
//.accSubCandidateDef: 31
//.accSubCandidateUse: 43
//
//
//.singlePipeAtOneDistNum: 41
//.allAtOneDistNum: 8
//.syncInstCount: 7
//.tokenReuseCount: 1
//.AfterWriteTokenDepCount: 22
//.AfterReadTokenDepCount: 14
