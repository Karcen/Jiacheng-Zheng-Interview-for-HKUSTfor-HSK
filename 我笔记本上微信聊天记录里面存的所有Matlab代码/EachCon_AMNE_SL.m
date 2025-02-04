
function [output2]=EachCon_AMNE_SL(V1)


C.ARGD = V1(:,1);
C.ARGF = V1(:,2);
C.AUSD = V1(:,3);
C.AUSF = V1(:,4);
C.AUTD = V1(:,5);
C.AUTF = V1(:,6);
C.BELD = V1(:,7);
C.BELF = V1(:,8);
C.BGDD = V1(:,9);
C.BGDF = V1(:,10);
C.BGRD = V1(:,11);
C.BGRF = V1(:,12);
C.BLRD = V1(:,13);
C.BLRF = V1(:,14);
C.BRAD = V1(:,15);
C.BRAF = V1(:,16);
C.BRND = V1(:,17);
C.BRNF = V1(:,18);
C.CAND = V1(:,19);
C.CANF = V1(:,20);
C.CHED = V1(:,21);
C.CHEF = V1(:,22);
C.CHLD = V1(:,23);
C.CHLF = V1(:,24);
C.CHND = V1(:,25);
C.CHNF = V1(:,26);
C.CIVD = V1(:,27);
C.CIVF = V1(:,28);
C.CMRD = V1(:,29);
C.CMRF = V1(:,30);
C.COLD = V1(:,31);
C.COLF = V1(:,32);
C.CRID = V1(:,33);
C.CRIF = V1(:,34);
C.CYPD = V1(:,35);
C.CYPF = V1(:,36);
C.CZED = V1(:,37);
C.CZEF = V1(:,38);
C.DEUD = V1(:,39);
C.DEUF = V1(:,40);
C.DNKD = V1(:,41);
C.DNKF = V1(:,42);
C.EGYD = V1(:,43);
C.EGYF = V1(:,44);
C.ESPD = V1(:,45);
C.ESPF = V1(:,46);
C.ESTD = V1(:,47);
C.ESTF = V1(:,48);
C.FIND = V1(:,49);
C.FINF = V1(:,50);
C.FRAD = V1(:,51);
C.FRAF = V1(:,52);
C.GBRD = V1(:,53);
C.GBRF = V1(:,54);
C.GRCD = V1(:,55);
C.GRCF = V1(:,56);
C.HKGD = V1(:,57);
C.HKGF = V1(:,58);
C.HRVD = V1(:,59);
C.HRVF = V1(:,60);
C.HUND = V1(:,61);
C.HUNF = V1(:,62);
C.IDND = V1(:,63);
C.IDNF = V1(:,64);
C.INDD = V1(:,65);
C.INDF = V1(:,66);
C.IRLD = V1(:,67);
C.IRLF = V1(:,68);
C.ISLD = V1(:,69);
C.ISLF = V1(:,70);
C.ISRD = V1(:,71);
C.ISRF = V1(:,72);
C.ITAD = V1(:,73);
C.ITAF = V1(:,74);
C.JORD = V1(:,75);
C.JORF = V1(:,76);
C.JPND = V1(:,77);
C.JPNF = V1(:,78);
C.KAZD = V1(:,79);
C.KAZF = V1(:,80);
C.KHMD = V1(:,81);
C.KHMF = V1(:,82);
C.KORD = V1(:,83);
C.KORF = V1(:,84);
C.LAOD = V1(:,85);
C.LAOF = V1(:,86);
C.LTUD = V1(:,87);
C.LTUF = V1(:,88);
C.LUXD = V1(:,89);
C.LUXF = V1(:,90);
C.LVAD = V1(:,91);
C.LVAF = V1(:,92);
C.MARD = V1(:,93);
C.MARF = V1(:,94);
C.MEXD = V1(:,95);
C.MEXF = V1(:,96);
C.MLTD = V1(:,97);
C.MLTF = V1(:,98);
C.MMRD = V1(:,99);
C.MMRF = V1(:,100);
C.MYSD = V1(:,101);
C.MYSF = V1(:,102);
C.NGAD = V1(:,103);
C.NGAF = V1(:,104);
C.NLDD = V1(:,105);
C.NLDF = V1(:,106);
C.NORD = V1(:,107);
C.NORF = V1(:,108);
C.NZLD = V1(:,109);
C.NZLF = V1(:,110);
C.PAKD = V1(:,111);
C.PAKF = V1(:,112);
C.PERD = V1(:,113);
C.PERF = V1(:,114);
C.PHLD = V1(:,115);
C.PHLF = V1(:,116);
C.POLD = V1(:,117);
C.POLF = V1(:,118);
C.PRTD = V1(:,119);
C.PRTF = V1(:,120);
C.ROUD = V1(:,121);
C.ROUF = V1(:,122);
C.RUSD = V1(:,123);
C.RUSF = V1(:,124);
C.SAUD = V1(:,125);
C.SAUF = V1(:,126);
C.SEND = V1(:,127);
C.SENF = V1(:,128);
C.SGPD = V1(:,129);
C.SGPF = V1(:,130);
C.SVKD = V1(:,131);
C.SVKF = V1(:,132);
C.SVND = V1(:,133);
C.SVNF = V1(:,134);
C.SWED = V1(:,135);
C.SWEF = V1(:,136);
C.THAD = V1(:,137);
C.THAF = V1(:,138);
C.TUND = V1(:,139);
C.TUNF = V1(:,140);
C.TURD = V1(:,141);
C.TURF = V1(:,142);
C.TWND = V1(:,143);
C.TWNF = V1(:,144);
C.UKRD = V1(:,145);
C.UKRF = V1(:,146);
C.USAD = V1(:,147);
C.USAF = V1(:,148);
C.VNMD = V1(:,149);
C.VNMF = V1(:,150);
C.ZAFD = V1(:,151);
C.ZAFF = V1(:,152);
C.ROWD = V1(:,153);
C.ROWF = V1(:,154);

GR2.G1.EU = [C.AUTD C.AUTF C.BELD C.BELF C.BGRD C.BGRF C.HRVD C.HRVF C.CYPD C.CYPF C.CZED C.CZEF C.DNKD C.DNKF C.ESTD C.ESTF C.FIND C.FINF C.FRAD C.FRAF C.DEUD C.DEUF C.GRCD C.GRCF C.HUND C.HUNF C.IRLD C.IRLF C.ITAD C.ITAF C.LVAD C.LVAF C.LTUD C.LTUF C.LUXD C.LUXF C.MLTD C.MLTF C.NLDD C.NLDF C.POLD C.POLF C.PRTD C.PRTF C.ROUD C.ROUF C.SVKD C.SVKF C.SVND C.SVNF C.ESPD C.ESPF C.SWED C.SWEF]; % 27 countries
GR2.G1.NEU_OECD = [C.AUSD C.AUSF C.CAND C.CANF C.CHLD C.CHLF C.COLD C.COLF C.CRID C.CRIF C.ISLD C.ISLF C.ISRD C.ISRF C.JPND C.JPNF C.KORD C.KORF C.MEXD C.MEXF C.NZLD C.NZLF C.NORD C.NORF C.TURD C.TURF C.GBRD C.GBRF]; % 14
GR2.G1.US = [C.USAD C.USAF]; % USA
GR2.G1.NEUC = [C.CHED C.CHEF C.UKRD C.UKRF]; % Non-EU countries

%%
%ONO-OECD 32 COUNTRIES
GR2.G1.China=[C.CHND+C.HKGD+C.TWND C.CHNF+C.HKGF+C.TWNF];%3
GR2.G1.Russia = [C.RUSD C.RUSF]; % 1
GR2.G1.ASEAN = [C.BRND C.BRNF C.KHMD C.KHMF C.IDND C.IDNF C.MYSD C.MYSF C.MMRD C.MMRF C.PHLD C.PHLF C.SGPD C.SGPF C.THAD C.THAF C.VNMD C.VNMF C.LAOD C.LAOF]; % 10
GR2.G1.India = [C.INDD C.INDF]; % 1
GR2.G1.Africa = [C.CMRD C.CMRF C.CIVD C.CIVF C.EGYD C.EGYF C.MARD C.MARF C.NGAD C.NGAF C.SEND C.SENF C.ZAFD C.ZAFF C.TUND C.TUNF C.JORD C.JORF C.SAUD C.SAUF]; % 10 Africa and Middle East
GR2.G1.NAMR = [C.ARGD C.ARGF C.BRAD C.BRAF C.PERD C.PERF]; % 3 North America
GR2.G1.ONOECD = [C.BGDD C.BGDF C.PAKD C.PAKF C.KAZD C.KAZF]; % 3 Other Non-OECD
GR2.G1.ROW = [C.ROWD C.ROWF]; % 1


%%
V12= [GR2.G1.EU GR2.G1.US GR2.G1.NEU_OECD GR2.G1.NEUC GR2.G1.China GR2.G1.Russia GR2.G1.ASEAN GR2.G1.India GR2.G1.Africa GR2.G1.NAMR GR2.G1.ONOECD GR2.G1.ROW];



%%
% z MATRIX

%R.ARG = V12(0*N+1:1*N,:);
num=1;%ITS 1
R.ARGD = V12(0*num+1:1*num,:); 
R.ARGF = V12(1*num+1:2*num,:); 
R.AUSD = V12(2*num+1:3*num,:); 
R.AUSF = V12(3*num+1:4*num,:); 
R.AUTD = V12(4*num+1:5*num,:); 
R.AUTF = V12(5*num+1:6*num,:); 
R.BELD = V12(6*num+1:7*num,:); 
R.BELF = V12(7*num+1:8*num,:); 
R.BGDD = V12(8*num+1:9*num,:); 
R.BGDF = V12(9*num+1:10*num,:); 
R.BGRD = V12(10*num+1:11*num,:); 
R.BGRF = V12(11*num+1:12*num,:); 
R.BLRD = V12(12*num+1:13*num,:); 
R.BLRF = V12(13*num+1:14*num,:); 
R.BRAD = V12(14*num+1:15*num,:); 
R.BRAF = V12(15*num+1:16*num,:); 
R.BRND = V12(16*num+1:17*num,:); 
R.BRNF = V12(17*num+1:18*num,:); 
R.CAND = V12(18*num+1:19*num,:); 
R.CANF = V12(19*num+1:20*num,:); 
R.CHED = V12(20*num+1:21*num,:); 
R.CHEF = V12(21*num+1:22*num,:); 
R.CHLD = V12(22*num+1:23*num,:); 
R.CHLF = V12(23*num+1:24*num,:); 
R.CHND = V12(24*num+1:25*num,:); 
R.CHNF = V12(25*num+1:26*num,:); 
R.CIVD = V12(26*num+1:27*num,:); 
R.CIVF = V12(27*num+1:28*num,:); 
R.CMRD = V12(28*num+1:29*num,:); 
R.CMRF = V12(29*num+1:30*num,:); 
R.COLD = V12(30*num+1:31*num,:); 
R.COLF = V12(31*num+1:32*num,:); 
R.CRID = V12(32*num+1:33*num,:); 
R.CRIF = V12(33*num+1:34*num,:); 
R.CYPD = V12(34*num+1:35*num,:); 
R.CYPF = V12(35*num+1:36*num,:); 
R.CZED = V12(36*num+1:37*num,:); 
R.CZEF = V12(37*num+1:38*num,:); 
R.DEUD = V12(38*num+1:39*num,:); 
R.DEUF = V12(39*num+1:40*num,:); 
R.DNKD = V12(40*num+1:41*num,:); 
R.DNKF = V12(41*num+1:42*num,:); 
R.EGYD = V12(42*num+1:43*num,:); 
R.EGYF = V12(43*num+1:44*num,:); 
R.ESPD = V12(44*num+1:45*num,:); 
R.ESPF = V12(45*num+1:46*num,:); 
R.ESTD = V12(46*num+1:47*num,:); 
R.ESTF = V12(47*num+1:48*num,:); 
R.FIND = V12(48*num+1:49*num,:); 
R.FINF = V12(49*num+1:50*num,:); 
R.FRAD = V12(50*num+1:51*num,:); 
R.FRAF = V12(51*num+1:52*num,:); 
R.GBRD = V12(52*num+1:53*num,:); 
R.GBRF = V12(53*num+1:54*num,:); 
R.GRCD = V12(54*num+1:55*num,:); 
R.GRCF = V12(55*num+1:56*num,:); 
R.HKGD = V12(56*num+1:57*num,:); 
R.HKGF = V12(57*num+1:58*num,:); 
R.HRVD = V12(58*num+1:59*num,:); 
R.HRVF = V12(59*num+1:60*num,:); 
R.HUND = V12(60*num+1:61*num,:); 
R.HUNF = V12(61*num+1:62*num,:); 
R.IDND = V12(62*num+1:63*num,:); 
R.IDNF = V12(63*num+1:64*num,:); 
R.INDD = V12(64*num+1:65*num,:); 
R.INDF = V12(65*num+1:66*num,:); 
R.IRLD = V12(66*num+1:67*num,:); 
R.IRLF = V12(67*num+1:68*num,:); 
R.ISLD = V12(68*num+1:69*num,:); 
R.ISLF = V12(69*num+1:70*num,:); 
R.ISRD = V12(70*num+1:71*num,:); 
R.ISRF = V12(71*num+1:72*num,:); 
R.ITAD = V12(72*num+1:73*num,:); 
R.ITAF = V12(73*num+1:74*num,:); 
R.JORD = V12(74*num+1:75*num,:); 
R.JORF = V12(75*num+1:76*num,:); 
R.JPND = V12(76*num+1:77*num,:); 
R.JPNF = V12(77*num+1:78*num,:); 
R.KAZD = V12(78*num+1:79*num,:); 
R.KAZF = V12(79*num+1:80*num,:); 
R.KHMD = V12(80*num+1:81*num,:); 
R.KHMF = V12(81*num+1:82*num,:); 
R.KORD = V12(82*num+1:83*num,:); 
R.KORF = V12(83*num+1:84*num,:); 
R.LAOD = V12(84*num+1:85*num,:); 
R.LAOF = V12(85*num+1:86*num,:); 
R.LTUD = V12(86*num+1:87*num,:); 
R.LTUF = V12(87*num+1:88*num,:); 
R.LUXD = V12(88*num+1:89*num,:); 
R.LUXF = V12(89*num+1:90*num,:); 
R.LVAD = V12(90*num+1:91*num,:); 
R.LVAF = V12(91*num+1:92*num,:); 
R.MARD = V12(92*num+1:93*num,:); 
R.MARF = V12(93*num+1:94*num,:); 
R.MEXD = V12(94*num+1:95*num,:); 
R.MEXF = V12(95*num+1:96*num,:); 
R.MLTD = V12(96*num+1:97*num,:); 
R.MLTF = V12(97*num+1:98*num,:); 
R.MMRD = V12(98*num+1:99*num,:); 
R.MMRF = V12(99*num+1:100*num,:); 
R.MYSD = V12(100*num+1:101*num,:); 
R.MYSF = V12(101*num+1:102*num,:); 
R.NGAD = V12(102*num+1:103*num,:); 
R.NGAF = V12(103*num+1:104*num,:); 
R.NLDD = V12(104*num+1:105*num,:); 
R.NLDF = V12(105*num+1:106*num,:); 
R.NORD = V12(106*num+1:107*num,:); 
R.NORF = V12(107*num+1:108*num,:); 
R.NZLD = V12(108*num+1:109*num,:); 
R.NZLF = V12(109*num+1:110*num,:); 
R.PAKD = V12(110*num+1:111*num,:); 
R.PAKF = V12(111*num+1:112*num,:); 
R.PERD = V12(112*num+1:113*num,:); 
R.PERF = V12(113*num+1:114*num,:); 
R.PHLD = V12(114*num+1:115*num,:); 
R.PHLF = V12(115*num+1:116*num,:); 
R.POLD = V12(116*num+1:117*num,:); 
R.POLF = V12(117*num+1:118*num,:); 
R.PRTD = V12(118*num+1:119*num,:); 
R.PRTF = V12(119*num+1:120*num,:); 
R.ROUD = V12(120*num+1:121*num,:); 
R.ROUF = V12(121*num+1:122*num,:); 
R.RUSD = V12(122*num+1:123*num,:); 
R.RUSF = V12(123*num+1:124*num,:); 
R.SAUD = V12(124*num+1:125*num,:); 
R.SAUF = V12(125*num+1:126*num,:); 
R.SEND = V12(126*num+1:127*num,:); 
R.SENF = V12(127*num+1:128*num,:); 
R.SGPD = V12(128*num+1:129*num,:); 
R.SGPF = V12(129*num+1:130*num,:);  
R.SVKD = V12(130*num+1:131*num,:); 
R.SVKF = V12(131*num+1:132*num,:);  
R.SVND = V12(132*num+1:133*num,:); 
R.SVNF = V12(133*num+1:134*num,:); 
R.SWED = V12(134*num+1:135*num,:); 
R.SWEF = V12(135*num+1:136*num,:); 
R.THAD = V12(136*num+1:137*num,:); 
R.THAF = V12(137*num+1:138*num,:); 
R.TUND = V12(138*num+1:139*num,:); 
R.TUNF = V12(139*num+1:140*num,:); 
R.TURD = V12(140*num+1:141*num,:); 
R.TURF = V12(141*num+1:142*num,:); 
R.TWND = V12(142*num+1:143*num,:); 
R.TWNF = V12(143*num+1:144*num,:); 
R.UKRD = V12(144*num+1:145*num,:); 
R.UKRF = V12(145*num+1:146*num,:);
R.USAD = V12(146*num+1:147*num,:); 
R.USAF = V12(147*num+1:148*num,:);
R.VNMD = V12(148*num+1:149*num,:); 
R.VNMF = V12(149*num+1:150*num,:);
R.ZAFD = V12(150*num+1:151*num,:); 
R.ZAFF = V12(151*num+1:152*num,:);
R.ROWD = V12(152*num+1:153*num,:); 
R.ROWF = V12(153*num+1:154*num,:);

GR2.G2.EU = [R.AUTD 
    R.AUTF 
    R.BELD 
    R.BELF 
    R.BGRD 
    R.BGRF 
    R.HRVD 
    R.HRVF 
    R.CYPD 
    R.CYPF 
    R.CZED 
    R.CZEF 
    R.DNKD 
    R.DNKF 
    R.ESTD 
    R.ESTF 
    R.FIND 
    R.FINF 
    R.FRAD 
    R.FRAF 
    R.DEUD 
    R.DEUF 
    R.GRCD
    R.GRCF 
    R.HUND
    R.HUNF 
    R.IRLD 
    R.IRLF 
    R.ITAD
    R.ITAF
    R.LVAD
    R.LVAF 
    R.LTUD
    R.LTUF 
    R.LUXD 
    R.LUXF
    R.MLTD 
    R.MLTF
    R.NLDD 
    R.NLDF 
    R.POLD
    R.POLF
    R.PRTD 
    R.PRTF
    R.ROUD
    R.ROUF
    R.SVKD 
    R.SVKF
    R.SVND
    R.SVNF
    R.ESPD
    R.ESPF
    R.SWED 
    R.SWEF]; % 27 countries
GR2.G2.NEU_OECD = [R.AUSD
    R.AUSF
    R.CAND
    R.CANF
    R.CHLD
    R.CHLF
    R.COLD
    R.COLF
    R.CRID
    R.CRIF
    R.ISLD
    R.ISLF
    R.ISRD
    R.ISRF
    R.JPND
    R.JPNF
    R.KORD
    R.KORF 
    R.MEXD
    R.MEXF
    R.NZLD
    R.NZLF
    R.NORD
    R.NORF
    R.TURD
    R.TURF
    R.GBRD
    R.GBRF]; % 14
GR2.G2.US = [R.USAD 
    R.USAF]; % USA
GR2.G2.NEUC = [R.CHED 
    R.CHEF 
    R.UKRD
    R.UKRF]; % Non-EU countries


%%
%ONO-OECD 32 COUNTRIES
GR2.G2.China=[R.CHND+R.HKGD+R.TWND 
    R.CHNF+R.HKGF+R.TWNF];%3
GR2.G2.Russia = [R.RUSD 
    R.RUSF]; % 1
GR2.G2.ASEAN = [R.BRND
    R.BRNF
    R.KHMD 
    R.KHMF 
    R.IDND
    R.IDNF
    R.MYSD 
    R.MYSF
    R.MMRD 
    R.MMRF 
    R.PHLD
    R.PHLF
    R.SGPD
    R.SGPF 
    R.THAD
    R.THAF
    R.VNMD
    R.VNMF 
    R.LAOD 
    R.LAOF]; % 10
GR2.G2.India = [R.INDD
    R.INDF]; % 1
GR2.G2.Africa = [R.CMRD 
    R.CMRF
    R.CIVD 
    R.CIVF
    R.EGYD 
    R.EGYF 
    R.MARD 
    R.MARF 
    R.NGAD
    R.NGAF 
    R.SEND
    R.SENF
    R.ZAFD
    R.ZAFF
    R.TUND
    R.TUNF
    R.JORD
    R.JORF 
    R.SAUD 
    R.SAUF]; % 10 Africa and Middle East
GR2.G2.NAMR = [R.ARGD 
    R.ARGF 
    R.BRAD
    R.BRAF
    R.PERD
    R.PERF]; % 3 North America
GR2.G2.ONOECD = [R.BGDD
    R.BGDF 
    R.PAKD
    R.PAKF
    R.KAZD
    R.KAZF]; % 3 Other Non-OECD
GR2.G2.ROW = [R.ROWD
    R.ROWF]; % 1

V13= [GR2.G2.EU
    GR2.G2.US 
    GR2.G2.NEU_OECD
    GR2.G2.NEUC
    GR2.G2.China
    GR2.G2.Russia
    GR2.G2.ASEAN
    GR2.G2.India
    GR2.G2.Africa
    GR2.G2.NAMR
    GR2.G2.ONOECD 
    GR2.G2.ROW];



%output1=V12;
output2=V13;

return 
end