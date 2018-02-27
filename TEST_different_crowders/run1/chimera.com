set bg_color white
~bond #0
bond #0:0
bond #0:1
bond #0:2
bond #0:3
bond #0:4
bond #0:5
bond #0:6
bond #0:7
bond #0:8
bond #0:9
bond #0:10
bond #0:11
bond #0:12
bond #0:13
bond #0:14
bond #0:15
bond #0:16
bond #0:17
bond #0:18
bond #0:19
bond #0:20
bond #0:21
bond #0:22
bond #0:23
bond #0:24
bond #0:25
bond #0:26
bond #0:27
bond #0:28
bond #0:29
bond #0:30
bond #0:31
bond #0:32
bond #0:33
bond #0:34
bond #0:35
bond #0:36
bond #0:37
bond #0:38
bond #0:39
bond #0:40
bond #0:41
bond #0:42
bond #0:43
bond #0:44
bond #0:45
bond #0:46
bond #0:47
bond #0:48
bond #0:49
bond #0:50
bond #0:51
bond #0:52
bond #0:53
bond #0:54
bond #0:55
bond #0:56
bond #0:57
bond #0:58
bond #0:59
bond #0:60
bond #0:61
bond #0:62
bond #0:63
bond #0:64
bond #0:65
bond #0:66
bond #0:67
bond #0:68
bond #0:69
bond #0:70
bond #0:71
bond #0:72
bond #0:73
bond #0:74
bond #0:75
bond #0:76
bond #0:77
bond #0:78
bond #0:79
bond #0:80
bond #0:81
bond #0:82
bond #0:83
bond #0:84
bond #0:85
bond #0:86
bond #0:87
bond #0:88
bond #0:89
bond #0:90
bond #0:91
bond #0:92
bond #0:93
bond #0:94
bond #0:95
bond #0:96
bond #0:97
bond #0:98
bond #0:99
bond #0:100
bond #0:101
bond #0:102
bond #0:103
bond #0:104
bond #0:105
bond #0:106
bond #0:107
bond #0:108
bond #0:109
bond #0:110
bond #0:111
bond #0:112
bond #0:113
bond #0:114
bond #0:115
bond #0:1.A,0.A
bond #0:2.A,1.A
bond #0:3.A,2.A
bond #0:4.A,3.A
bond #0:5.A,4.A
bond #0:6.A,5.A
bond #0:7.A,6.A
bond #0:9.A,8.A
bond #0:10.A,9.A
bond #0:11.A,10.A
bond #0:12.A,11.A
bond #0:13.A,12.A
bond #0:14.A,13.A
bond #0:15.A,14.A
preset apply int ribbons
set bg_color white
color sandy brown #0:ALA
col deep sky blue #0:ALA@N
col deep sky blue #0:ALA@O
col deep sky blue #0:ALA@S
col deep sky blue #0:ALA@K
bondcolor sandy brown #0:ALA
color blue #0:GLY
col deep sky blue #0:GLY@N
col deep sky blue #0:GLY@O
col deep sky blue #0:GLY@S
col deep sky blue #0:GLY@K
bondcolor blue #0:GLY
color red #0:CYS
col deep sky blue #0:CYS@N
col deep sky blue #0:CYS@O
col deep sky blue #0:CYS@S
col deep sky blue #0:CYS@K
bondcolor red #0:CYS
color green #0:TYR
col deep sky blue #0:TYR@N
col deep sky blue #0:TYR@O
col deep sky blue #0:TYR@S
col deep sky blue #0:TYR@K
bondcolor green #0:TYR
color purple #0:ARG
col deep sky blue #0:ARG@N
col deep sky blue #0:ARG@O
col deep sky blue #0:ARG@S
col deep sky blue #0:ARG@K
bondcolor purple #0:ARG
color dark gray #0:PHE
col deep sky blue #0:PHE@N
col deep sky blue #0:PHE@O
col deep sky blue #0:PHE@S
col deep sky blue #0:PHE@K
bondcolor dark gray #0:PHE
color yellow #0:LYS
col deep sky blue #0:LYS@N
col deep sky blue #0:LYS@O
col deep sky blue #0:LYS@S
col deep sky blue #0:LYS@K
bondcolor yellow #0:LYS
color orange #0:SER
col deep sky blue #0:SER@N
col deep sky blue #0:SER@O
col deep sky blue #0:SER@S
col deep sky blue #0:SER@K
bondcolor orange #0:SER
color deep pink #0:PRO
col deep sky blue #0:PRO@N
col deep sky blue #0:PRO@O
col deep sky blue #0:PRO@S
col deep sky blue #0:PRO@K
bondcolor deep pink #0:PRO
color magenta #0:VAL
col deep sky blue #0:VAL@N
col deep sky blue #0:VAL@O
col deep sky blue #0:VAL@S
col deep sky blue #0:VAL@K
bondcolor magenta #0:VAL
color sienna #0:ASN
col deep sky blue #0:ASN@N
col deep sky blue #0:ASN@O
col deep sky blue #0:ASN@S
col deep sky blue #0:ASN@K
bondcolor sienna #0:ASN
color goldenrod #0:ASP
col deep sky blue #0:ASP@N
col deep sky blue #0:ASP@O
col deep sky blue #0:ASP@S
col deep sky blue #0:ASP@K
bondcolor goldenrod #0:ASP
color gray #0:CYX
col deep sky blue #0:CYX@N
col deep sky blue #0:CYX@O
col deep sky blue #0:CYX@S
col deep sky blue #0:CYX@K
bondcolor gray #0:CYX
color plum #0:HSP
col deep sky blue #0:HSP@N
col deep sky blue #0:HSP@O
col deep sky blue #0:HSP@S
col deep sky blue #0:HSP@K
bondcolor plum #0:HSP
color olive drab #0:HSD
col deep sky blue #0:HSD@N
col deep sky blue #0:HSD@O
col deep sky blue #0:HSD@S
col deep sky blue #0:HSD@K
bondcolor olive drab #0:HSD
color dark red #0:MET
col deep sky blue #0:MET@N
col deep sky blue #0:MET@O
col deep sky blue #0:MET@S
col deep sky blue #0:MET@K
bondcolor dark red #0:MET
color steel blue #0:LEU
col deep sky blue #0:LEU@N
col deep sky blue #0:LEU@O
col deep sky blue #0:LEU@S
col deep sky blue #0:LEU@K
bondcolor steel blue #0:LEU
aniso scale 0.75 smoothing 4
setattr m stickScale 0.6 #0
