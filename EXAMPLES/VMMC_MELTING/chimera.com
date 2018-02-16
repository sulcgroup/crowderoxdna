set bg_color white
~bond #0
bond #0:0.A:0.B
bond #0:0.B:0.C
bond #0:1.A:1.B
bond #0:1.B:1.C
bond #0:2.A:2.B
bond #0:2.B:2.C
bond #0:3.A:3.B
bond #0:3.B:3.C
bond #0:4.A:4.B
bond #0:4.B:4.C
bond #0:5.A:5.B
bond #0:5.B:5.C
bond #0:6.A:6.B
bond #0:6.B:6.C
bond #0:7.A:7.B
bond #0:7.B:7.C
bond #0:8.A:8.B
bond #0:8.B:8.C
bond #0:9.A:9.B
bond #0:9.B:9.C
bond #0:10.A:10.B
bond #0:10.B:10.C
bond #0:11.A:11.B
bond #0:11.B:11.C
bond #0:12.A:12.B
bond #0:12.B:12.C
bond #0:13.A:13.B
bond #0:13.B:13.C
bond #0:14.A:14.B
bond #0:14.B:14.C
bond #0:15.A:15.B
bond #0:15.B:15.C
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
