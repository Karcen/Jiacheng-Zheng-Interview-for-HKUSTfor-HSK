



function [output2]=EachCon_AMNE_SLG_FDI(V1)

COL.ARG = V1(:,1);
COL.AUS = V1(:,2);
COL.AUT = V1(:,3);
COL.BEL = V1(:,4);
COL.BGD = V1(:,5);
COL.BGR = V1(:,6);
COL.BLR = V1(:,7);
COL.BRA = V1(:,8);
COL.BRN = V1(:,9);
COL.CAN = V1(:,10);
COL.CHE = V1(:,11);
COL.CHL = V1(:,12);
COL.CHN = V1(:,13);
COL.CIV = V1(:,14);
COL.CMR = V1(:,15);
COL.COL = V1(:,16);
COL.CRI = V1(:,17);
COL.CYP = V1(:,18);
COL.CZE = V1(:,19);
COL.DEU = V1(:,20);
COL.DNK = V1(:,21);
COL.EGY = V1(:,22);
COL.ESP = V1(:,23);
COL.EST = V1(:,24);
COL.FIN = V1(:,25);
COL.FRA = V1(:,26);
COL.GBR = V1(:,27);
COL.GRC = V1(:,28);
COL.HKG = V1(:,29);
COL.HRV = V1(:,30);
COL.HUN = V1(:,31);
COL.IDN = V1(:,32);
COL.IND = V1(:,33);
COL.IRL = V1(:,34);
COL.ISL = V1(:,35);
COL.ISR = V1(:,36);
COL.ITA = V1(:,37);
COL.JOR = V1(:,38);
COL.JPN = V1(:,39);
COL.KAZ = V1(:,40);
COL.KHM = V1(:,41);
COL.KOR = V1(:,42);
COL.LAO = V1(:,43);
COL.LTU = V1(:,44);
COL.LUX = V1(:,45);
COL.LVA = V1(:,46);
COL.MAR = V1(:,47);
COL.MEX = V1(:,48);
COL.MLT = V1(:,49);
COL.MMR = V1(:,50);
COL.MYS = V1(:,51);
COL.NGA = V1(:,52);
COL.NLD = V1(:,53);
COL.NOR = V1(:,54);
COL.NZL = V1(:,55);
COL.PAK = V1(:,56);
COL.PER = V1(:,57);
COL.PHL = V1(:,58);
COL.POL = V1(:,59);
COL.PRT = V1(:,60);
COL.ROU = V1(:,61);
COL.RUS = V1(:,62);
COL.SAU = V1(:,63);
COL.SEN = V1(:,64);
COL.SGP = V1(:,65);
COL.SVK = V1(:,66);
COL.SVN = V1(:,67);
COL.SWE = V1(:,68);
COL.THA = V1(:,69);
COL.TUN = V1(:,70);
COL.TUR = V1(:,71);
COL.TWN = V1(:,72);
COL.UKR = V1(:,73);
COL.USA = V1(:,74);
COL.VNM = V1(:,75);
COL.ZAF = V1(:,76);
COL.ROW = V1(:,77);

GR.G1.EU = [COL.AUT COL.BEL COL.BGR COL.HRV COL.CYP COL.CZE COL.DNK COL.EST COL.FIN COL.FRA COL.DEU COL.GRC COL.HUN COL.IRL COL.ITA COL.LVA COL.LTU COL.LUX COL.MLT COL.NLD COL.POL COL.PRT COL.ROU COL.SVK COL.SVN COL.ESP COL.SWE];%27 countries
GR.G1.NEU_OECD = [COL.AUS + COL.CAN + COL.CHL + COL.COL + COL.CRI + COL.ISL + COL.ISR + COL.JPN + COL.KOR + COL.MEX + COL.NZL + COL.NOR + COL.TUR + COL.GBR];%14
GR.G1.US=COL.USA;
GR.G1.NEUC=[COL.CHE + COL.UKR];

%%
%ONO-OECD 32 COUNTRIES
GR.G1.China=COL.CHN+COL.HKG+COL.TWN;%3
GR.G1.Russia=COL.RUS;%1
GR.G1.ASEAN = [COL.BRN + COL.KHM + COL.IDN + COL.MYS + COL.MMR + COL.PHL + COL.SGP + COL.THA + COL.VNM + COL.LAO];%10
GR.G1.India=COL.IND;%1
GR.G1.Africa = [COL.CMR + COL.CIV + COL.EGY + COL.MAR + COL.NGA + COL.SEN + COL.ZAF + COL.TUN + COL.JOR + COL.SAU];%10 AFRICA AND MIDDLE EAST
GR.G1.NAMR= [COL.ARG + COL.BRA + COL.PER];%3 NORT AMERICN
GR.G1.ONOECD= [COL.BGD + COL.PAK + COL.KAZ];%OTHER NON_OECD 3
GR.G1.ROW=COL.ROW;%1

%%
V12= [GR.G1.EU GR.G1.US GR.G1.NEU_OECD GR.G1.NEUC GR.G1.China GR.G1.Russia GR.G1.ASEAN GR.G1.India GR.G1.Africa GR.G1.NAMR GR.G1.ONOECD GR.G1.ROW];

%%
% z MATRIX
% num=1;
%% 
 % R.ARG = V12(0*num+1:1*num,:);
% R.AUS = V12(1*num+1:2*num,:);
% R.AUT = V12(2*num+1:3*num,:);
% R.BEL = V12(3*num+1:4*num,:);
% R.BGD = V12(4*num+1:5*num,:);
% R.BGR = V12(5*num+1:6*num,:);
% R.BLR = V12(6*num+1:7*num,:);
% R.BRA = V12(7*num+1:8*num,:);
% R.BRN = V12(8*num+1:9*num,:);
% R.CAN = V12(9*num+1:10*num,:);
% R.CHE = V12(10*num+1:11*num,:);
% R.CHL = V12(11*num+1:12*num,:);
% R.CHN = V12(12*num+1:13*num,:);
% R.CIV = V12(13*num+1:14*num,:);
% R.CMR = V12(14*num+1:15*num,:);
% R.COL = V12(15*num+1:16*num,:);
% R.CRI = V12(16*num+1:17*num,:);
% R.CYP = V12(17*num+1:18*num,:);
% R.CZE = V12(18*num+1:19*num,:);
% R.DEU = V12(19*num+1:20*num,:);
% R.DNK = V12(20*num+1:21*num,:);
% R.EGY = V12(21*num+1:22*num,:);
% R.ESP = V12(22*num+1:23*num,:);
% R.EST = V12(23*num+1:24*num,:);
% R.FIN = V12(24*num+1:25*num,:);
% R.FRA = V12(25*num+1:26*num,:);
% R.GBR = V12(26*num+1:27*num,:);
% R.GRC = V12(27*num+1:28*num,:);
% R.HKG = V12(28*num+1:29*num,:);
% R.HRV = V12(29*num+1:30*num,:);
% R.HUN = V12(30*num+1:31*num,:);
% R.IDN = V12(31*num+1:32*num,:);
% R.IND = V12(32*num+1:33*num,:);
% R.IRL = V12(33*num+1:34*num,:);
% R.ISL = V12(34*num+1:35*num,:);
% R.ISR = V12(35*num+1:36*num,:);
% R.ITA = V12(36*num+1:37*num,:);
% R.JOR = V12(37*num+1:38*num,:);
% R.JPN = V12(38*num+1:39*num,:);
% R.KAZ = V12(39*num+1:40*num,:);
% R.KHM = V12(40*num+1:41*num,:);
% R.KOR = V12(41*num+1:42*num,:);
% R.LAO = V12(42*num+1:43*num,:);
% R.LTU = V12(43*num+1:44*num,:);
% R.LUX = V12(44*num+1:45*num,:);
% R.LVA = V12(45*num+1:46*num,:);
% R.MAR = V12(46*num+1:47*num,:);
% R.MEX = V12(47*num+1:48*num,:);
% R.MLT = V12(48*num+1:49*num,:);
% R.MMR = V12(49*num+1:50*num,:);
% R.MYS = V12(50*num+1:51*num,:);
% R.NGA = V12(51*num+1:52*num,:);
% R.NLD = V12(52*num+1:53*num,:);
% R.NOR = V12(53*num+1:54*num,:);
% R.NZL = V12(54*num+1:55*num,:);
% R.PAK = V12(55*num+1:56*num,:);
% R.PER = V12(56*num+1:57*num,:);
% R.PHL = V12(57*num+1:58*num,:);
% R.POL = V12(58*num+1:59*num,:);
% R.PRT = V12(59*num+1:60*num,:);
% R.ROU = V12(60*num+1:61*num,:);
% R.RUS = V12(61*num+1:62*num,:);
% R.SAU = V12(62*num+1:63*num,:);
% R.SEN = V12(63*num+1:64*num,:);
% R.SGP = V12(64*num+1:65*num,:);
% R.SVK = V12(65*num+1:66*num,:);
% R.SVN = V12(66*num+1:67*num,:);
% R.SWE = V12(67*num+1:68*num,:);
% R.THA = V12(68*num+1:69*num,:);
% R.TUN = V12(69*num+1:70*num,:);
% R.TUR = V12(70*num+1:71*num,:);
% R.TWN = V12(71*num+1:72*num,:);
% R.UKR = V12(72*num+1:73*num,:);
% R.USA = V12(73*num+1:74*num,:);
% R.VNM = V12(74*num+1:75*num,:);
% R.ZAF = V12(75*num+1:76*num,:);
% R.ROW = V12(76*num+1:77*num,:);
% 
% 
% GR2.G2.EU = [R.AUT 
%     R.BEL 
%     R.BGR 
%     R.HRV 
%     R.CYP 
%     R.CZE 
%     R.DNK
%     R.EST
%     R.FIN 
%     R.FRA
%     R.DEU
%     R.GRC
%     R.HUN 
%     R.IRL
%     R.ITA
%     R.LVA
%     R.LTU
%     R.LUX
%     R.MLT
%     R.NLD
%     R.POL
%     R.PRT
%     R.ROU
%     R.SVK
%     R.SVN
%     R.ESP
%     R.SWE];%27 countries
% 
% 
% GR2.G2.NEU_OECD = [R.AUS + R.CAN + R.CHL + R.COL + R.CRI + R.ISL + R.ISR + R.JPN + R.KOR + R.MEX + R.NZL + R.NOR + R.TUR + R.GBR];%14
% GR2.G2.US=R.USA;
% GR2.G2.NEUC=[R.CHE + R.UKR];
% 
% %%
% %ONO-OECD 32 COUNTRIES
% GR2.G2.China=R.CHN+R.HKG+R.TWN;%3
% GR2.G2.Russia=R.RUS;%1
% GR2.G2.ASEAN = [R.BRN + R.KHM + R.IDN + R.MYS + R.MMR + R.PHL + R.SGP + R.THA + R.VNM + R.LAO];%10
% GR2.G2.India=R.IND;%1
% GR2.G2.Africa = [R.CMR + R.CIV + R.EGY + R.MAR + R.NGA + R.SEN + R.ZAF + R.TUN + R.JOR + R.SAU];%10 AFRICA AND MIDDLE EAST
% GR2.G2.NAMR= [R.ARG + R.BRA + R.PER];%3 NORT AMERICN
% GR2.G2.ONOECD= [R.BGD + R.PAK + R.KAZ];%OTHER NON_OECD 3
% GR2.G2.ROW=R.ROW;%1
% 
% %%
% %ONO-OECD 32 COUNTRIES
% GR2.G2.China=[R.CHND+R.HKGD+R.TWND 
%     R.CHNF+R.HKGF+R.TWNF];%3
% GR2.G2.Russia = [R.RUSD 
%     R.RUSF]; % 1
% GR2.G2.ASEAN = [R.BRND+R.KHMD+R.IDND+R.MYSD+R.MMRD+R.PHLD+R.SGPD+R.THAD+R.VNMD+ R.LAOD 
%     R.BRNF+R.KHMF+ R.IDNF+R.MYSF+R.MMRF+R.PHLF+R.SGPF+R.THAF+R.VNMF+R.LAOF]; % 10
% 
% 
% V13= [GR2.G2.EU
%     GR2.G2.US 
%     GR2.G2.NEU_OECD
%     GR2.G2.NEUC
%     GR2.G2.China
%     GR2.G2.Russia
%     GR2.G2.ASEAN
%     GR2.G2.India
%     GR2.G2.Africa
%     GR2.G2.NAMR
%     GR2.G2.ONOECD 
%     GR2.G2.ROW];

output2=V12;

return


