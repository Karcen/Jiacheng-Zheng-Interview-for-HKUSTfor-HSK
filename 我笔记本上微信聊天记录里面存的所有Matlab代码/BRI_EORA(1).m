function output=BRI_EORA(V1)

C.AFG = V1(:, 1);
C.ALB = V1(:, 2);
C.DZA = V1(:, 3);
C.AND = V1(:, 4);
C.AGO = V1(:, 5);
C.ATG = V1(:, 6);
C.ARG = V1(:, 7);
C.ARM = V1(:, 8);
C.ABW = V1(:, 9);
C.AUS = V1(:, 10);
C.AUT = V1(:, 11);
C.AZE = V1(:, 12);
C.BHS = V1(:, 13);
C.BHR = V1(:, 14);
C.BGD = V1(:, 15);
C.BRB = V1(:, 16);
C.BLR = V1(:, 17);
C.BEL = V1(:, 18);
C.BLZ = V1(:, 19);
C.BEN = V1(:, 20);
C.BMU = V1(:, 21);
C.BTN = V1(:, 22);
C.BOL = V1(:, 23);
C.BIH = V1(:, 24);
C.BWA = V1(:, 25);
C.BRA = V1(:, 26);
C.VGB = V1(:, 27);
C.BRN = V1(:, 28);
C.BGR = V1(:, 29);
C.BFA = V1(:, 30);
C.BDI = V1(:, 31);
C.KHM = V1(:, 32);
C.CMR = V1(:, 33);
C.CAN = V1(:, 34);
C.CPV = V1(:, 35);
C.CYM = V1(:, 36);
C.CAF = V1(:, 37);
C.TCD = V1(:, 38);
C.CHL = V1(:, 39);
C.CHN = V1(:, 40);
C.COL = V1(:, 41);
C.COG = V1(:, 42);
C.CRI = V1(:, 43);
C.HRV = V1(:, 44);
C.CUB = V1(:, 45);
C.CYP = V1(:, 46);
C.CZE = V1(:, 47);
C.CIV = V1(:, 48);
C.PRK = V1(:, 49);
C.COD = V1(:, 50);
C.DNK = V1(:, 51);
C.DJI = V1(:, 52);
C.DOM = V1(:, 53);
C.ECU = V1(:, 54);
C.EGY = V1(:, 55);
C.SLV = V1(:, 56);
C.ERI = V1(:, 57);
C.EST = V1(:, 58);
C.ETH = V1(:, 59);
C.FJI = V1(:, 60);
C.FIN = V1(:, 61);
C.FRA = V1(:, 62);
C.PYF = V1(:, 63);
C.GAB = V1(:, 64);
C.GMB = V1(:, 65);
C.GEO = V1(:, 66);
C.DEU = V1(:, 67);
C.GHA = V1(:, 68);
C.GRC = V1(:, 69);
C.GRL = V1(:, 70);
C.GTM = V1(:, 71);
C.GIN = V1(:, 72);
C.GUY = V1(:, 73);
C.HTI = V1(:, 74);
C.HND = V1(:, 75);
C.HKG = V1(:, 76);
C.HUN = V1(:, 77);
C.ISL = V1(:, 78);
C.IND = V1(:, 79);
C.IDN = V1(:, 80);
C.IRN = V1(:, 81);
C.IRQ = V1(:, 82);
C.IRL = V1(:, 83);
C.ISR = V1(:, 84);
C.ITA = V1(:, 85);
C.JAM = V1(:, 86);
C.JPN = V1(:, 87);
C.JOR = V1(:, 88);
C.KAZ = V1(:, 89);
C.KEN = V1(:, 90);
C.KWT = V1(:, 91);
C.KGZ = V1(:, 92);
C.LAO = V1(:, 93);
C.LVA = V1(:, 94);
C.LBN = V1(:, 95);
C.LSO = V1(:, 96);
C.LBR = V1(:, 97);
C.LBY = V1(:, 98);
C.LIE = V1(:, 99);
C.LTU = V1(:, 100);
C.LUX = V1(:, 101);
C.MAC = V1(:, 102);
C.MDG = V1(:, 103);
C.MWI = V1(:, 104);
C.MYS = V1(:, 105);
C.MDV = V1(:, 106);
C.MLI = V1(:, 107);
C.MLT = V1(:, 108);
C.MRT = V1(:, 109);
C.MUS = V1(:, 110);
C.MEX = V1(:, 111);
C.MCO = V1(:, 112);
C.MNG = V1(:, 113);
C.MNE = V1(:, 114);
C.MAR = V1(:, 115);
C.MOZ = V1(:, 116);
C.MMR = V1(:, 117);
C.NAM = V1(:, 118);
C.NPL = V1(:, 119);
C.NLD = V1(:, 120);
C.ANT = V1(:, 121);
C.NCL = V1(:, 122);
C.NZL = V1(:, 123);
C.NIC = V1(:, 124);
C.NER = V1(:, 125);
C.NGA = V1(:, 126);
C.NOR = V1(:, 127);
C.PSE = V1(:, 128);
C.OMN = V1(:, 129);
C.PAK = V1(:, 130);
C.PAN = V1(:, 131);
C.PNG = V1(:, 132);
C.PRY = V1(:, 133);
C.PER = V1(:, 134);
C.PHL = V1(:, 135);
C.POL = V1(:, 136);
C.PRT = V1(:, 137);
C.QAT = V1(:, 138);
C.KOR = V1(:, 139);
C.MDA = V1(:, 140);
C.ROU = V1(:, 141);
C.RUS = V1(:, 142);
C.RWA = V1(:, 143);
C.WSM = V1(:, 144);
C.SMR = V1(:, 145);
C.STP = V1(:, 146);
C.SAU = V1(:, 147);
C.SEN = V1(:, 148);
C.SRB = V1(:, 149);
C.SYC = V1(:, 150);
C.SLE = V1(:, 151);
C.SGP = V1(:, 152);
C.SVK = V1(:, 153);
C.SVN = V1(:, 154);
C.SOM = V1(:, 155);
C.ZAF = V1(:, 156);
C.SDS = V1(:, 157);
C.ESP = V1(:, 158);
C.LKA = V1(:, 159);
C.SUD = V1(:, 160);
C.SUR = V1(:, 161);
C.SWZ = V1(:, 162);
C.SWE = V1(:, 163);
C.CHE = V1(:, 164);
C.SYR = V1(:, 165);
C.TWN = V1(:, 166);
C.TJK = V1(:, 167);
C.THA = V1(:, 168);
C.MKD = V1(:, 169);
C.TGO = V1(:, 170);
C.TTO = V1(:, 171);
C.TUN = V1(:, 172);
C.TUR = V1(:, 173);
C.TKM = V1(:, 174);
C.USR = V1(:, 175);
C.UGA = V1(:, 176);
C.UKR = V1(:, 177);
C.ARE = V1(:, 178);
C.GBR = V1(:, 179);
C.TZA = V1(:, 180);
C.USA = V1(:, 181);
C.URY = V1(:, 182);
C.UZB = V1(:, 183);
C.VUT = V1(:, 184);
C.VEN = V1(:, 185);
C.VNM = V1(:, 186);
C.YEM = V1(:, 187);
C.ZMB = V1(:, 188);
C.ZWE = V1(:, 189);

C1.CHN=C.CHN;
% South Asia
C1.SouthAsia=[C.AFG C.BGD C.MDV C.NPL C.PAK C.LKA];

C1.EastAsia=[C.BRN C.KHM  C.FJI  C.KOR C.LAO   C.MYS C.MNG   C.MMR C.NZL   C.PNG  C.PHL   C.WSM C.SGP   C.THA  C.VUT   C.VNM];

C1.SubSaharanAfrica=[C.AGO C.BEN C.BDI C.CMR C.TCD C.COG C.CIV C.ETH C.GAB C.GMB C.GHA C.GIN C.KEN C.LSO C.LBR C.MDG C.MLI C.MRT C.MOZ C.NAM C.NER C.NGA C.RWA C.SEN C.SYC C.SLE C.SOM C.ZAF C.SDS C.SUD C.TZA C.TGO C.UGA C.ZMB C.ZWE];

% Eastern Europe & Central Asia
C1.EECA=[C.BLR C.MDA C.RUS C.UKR C.KAZ C.KGZ C.TJK C.UZB C.ARM C.AZE C.GEO];

% Central & Southeastern Europe (including Balkans)
C1.CSE=[C.ALB C.BIH C.BGR C.HRV C.CZE C.HUN C.MNE C.MKD C.POL C.ROU C.SRB C.SVK C.SVN];

% Southern Europe
C1.SE=[C.CYP C.GRC  C.PRT C.TUR];

% Baltic & Western Europe
C1.BWE=[C.AUT C.EST C.LVA C.LTU C.LUX];

% Latin America & Caribbean
C1.LAC=[C.ATG C.BRB C.BOL C.CHL C.CRI C.CUB C.DOM C.ECU C.SLV C.GUY C.JAM C.PAN C.PER C.SUR C.TTO C.URY C.VEN];

% Middle East & North Africa
C1.MENA=[C.DZA C.BHR C.DJI C.EGY C.IRN C.IRQ C.KWT C.LBN C.LBY C.MLT C.MAR C.OMN C.QAT C.SAU C.TUN C.ARE C.YEM];

% Rest of the Countries
C1.REST=[C.AND, C.ARG, C.ABW, C.AUS, C.BHS, C.BEL, C.BLZ, C.BMU, C.BTN, C.IDN  C.BWA, C.BRA, C.VGB, C.BFA, C.CAN, C.CPV, C.CYM, C.CAF, C.COL, C.PRK, C.COD, C.DNK, C.ERI, C.FIN, C.FRA, C.PYF, C.DEU, C.GRL, C.GTM, C.HTI, C.HND, C.HKG, C.ISL, C.IND, C.IRL, C.ISR, C.JPN, C.JOR, C.LIE, C.MAC, C.MWI, C.MUS, C.MEX, C.MCO, C.NLD, C.ANT, C.NCL, C.NIC, C.NOR, C.PSE, C.PRY, C.SMR, C.STP, C.ESP, C.SWZ, C.SWE, C.CHE, C.SYR, C.TWN, C.TKM, C.USR, C.GBR, C.USA C.ITA];


V2=[C1.CHN C1.SouthAsia C1.EastAsia C1.SubSaharanAfrica  C1.EECA C1.CSE C1.SE C1.BWE C1.LAC C1.MENA C1.REST];


R.AFG=V2(1,:);
R.ALB=V2(2,:);
R.DZA=V2(3,:);
R.AND=V2(4,:);
R.AGO=V2(5,:);
R.ATG=V2(6,:);
R.ARG=V2(7,:);
R.ARM=V2(8,:);
R.ABW=V2(9,:);
R.AUS=V2(10,:);
R.AUT=V2(11,:);
R.AZE=V2(12,:);
R.BHS=V2(13,:);
R.BHR=V2(14,:);
R.BGD=V2(15,:);
R.BRB=V2(16,:);
R.BLR=V2(17,:);
R.BEL=V2(18,:);
R.BLZ=V2(19,:);
R.BEN=V2(20,:);
R.BMU=V2(21,:);
R.BTN=V2(22,:);
R.BOL=V2(23,:);
R.BIH=V2(24,:);
R.BWA=V2(25,:);
R.BRA=V2(26,:);
R.VGB=V2(27,:);
R.BRN=V2(28,:);
R.BGR=V2(29,:);
R.BFA=V2(30,:);
R.BDI=V2(31,:);
R.KHM=V2(32,:);
R.CMR=V2(33,:);
R.CAN=V2(34,:);
R.CPV=V2(35,:);
R.CYM=V2(36,:);
R.CAF=V2(37,:);
R.TCD=V2(38,:);
R.CHL=V2(39,:);
R.CHN=V2(40,:);
R.COL=V2(41,:);
R.COG=V2(42,:);
R.CRI=V2(43,:);
R.HRV=V2(44,:);
R.CUB=V2(45,:);
R.CYP=V2(46,:);
R.CZE=V2(47,:);
R.CIV=V2(48,:);
R.PRK=V2(49,:);
R.COD=V2(50,:);
R.DNK=V2(51,:);
R.DJI=V2(52,:);
R.DOM=V2(53,:);
R.ECU=V2(54,:);
R.EGY=V2(55,:);
R.SLV=V2(56,:);
R.ERI=V2(57,:);
R.EST=V2(58,:);
R.ETH=V2(59,:);
R.FJI=V2(60,:);
R.FIN=V2(61,:);
R.FRA=V2(62,:);
R.PYF=V2(63,:);
R.GAB=V2(64,:);
R.GMB=V2(65,:);
R.GEO=V2(66,:);
R.DEU=V2(67,:);
R.GHA=V2(68,:);
R.GRC=V2(69,:);
R.GRL=V2(70,:);
R.GTM=V2(71,:);
R.GIN=V2(72,:);
R.GUY=V2(73,:);
R.HTI=V2(74,:);
R.HND=V2(75,:);
R.HKG=V2(76,:);
R.HUN=V2(77,:);
R.ISL=V2(78,:);
R.IND=V2(79,:);
R.IDN=V2(80,:);
R.IRN=V2(81,:);
R.IRQ=V2(82,:);
R.IRL=V2(83,:);
R.ISR=V2(84,:);
R.ITA=V2(85,:);
R.JAM=V2(86,:);
R.JPN=V2(87,:);
R.JOR=V2(88,:);
R.KAZ=V2(89,:);
R.KEN=V2(90,:);
R.KWT=V2(91,:);
R.KGZ=V2(92,:);
R.LAO=V2(93,:);
R.LVA=V2(94,:);
R.LBN=V2(95,:);
R.LSO=V2(96,:);
R.LBR=V2(97,:);
R.LBY=V2(98,:);
R.LIE=V2(99,:);
R.LTU=V2(100,:);
R.LUX=V2(101,:);
R.MAC=V2(102,:);
R.MDG=V2(103,:);
R.MWI=V2(104,:);
R.MYS=V2(105,:);
R.MDV=V2(106,:);
R.MLI=V2(107,:);
R.MLT=V2(108,:);
R.MRT=V2(109,:);
R.MUS=V2(110,:);
R.MEX=V2(111,:);
R.MCO=V2(112,:);
R.MNG=V2(113,:);
R.MNE=V2(114,:);
R.MAR=V2(115,:);
R.MOZ=V2(116,:);
R.MMR=V2(117,:);
R.NAM=V2(118,:);
R.NPL=V2(119,:);
R.NLD=V2(120,:);
R.ANT=V2(121,:);
R.NCL=V2(122,:);
R.NZL=V2(123,:);
R.NIC=V2(124,:);
R.NER=V2(125,:);
R.NGA=V2(126,:);
R.NOR=V2(127,:);
R.PSE=V2(128,:);
R.OMN=V2(129,:);
R.PAK=V2(130,:);
R.PAN=V2(131,:);
R.PNG=V2(132,:);
R.PRY=V2(133,:);
R.PER=V2(134,:);
R.PHL=V2(135,:);
R.POL=V2(136,:);
R.PRT=V2(137,:);
R.QAT=V2(138,:);
R.KOR=V2(139,:);
R.MDA=V2(140,:);
R.ROU=V2(141,:);
R.RUS=V2(142,:);
R.RWA=V2(143,:);
R.WSM=V2(144,:);
R.SMR=V2(145,:);
R.STP=V2(146,:);
R.SAU=V2(147,:);
R.SEN=V2(148,:);
R.SRB=V2(149,:);
R.SYC=V2(150,:);
R.SLE=V2(151,:);
R.SGP=V2(152,:);
R.SVK=V2(153,:);
R.SVN=V2(154,:);
R.SOM=V2(155,:);
R.ZAF=V2(156,:);
R.SDS=V2(157,:);
R.ESP=V2(158,:);
R.LKA=V2(159,:);
R.SUD=V2(160,:);
R.SUR=V2(161,:);
R.SWZ=V2(162,:);
R.SWE=V2(163,:);
R.CHE=V2(164,:);
R.SYR=V2(165,:);
R.TWN=V2(166,:);
R.TJK=V2(167,:);
R.THA=V2(168,:);
R.MKD=V2(169,:);
R.TGO=V2(170,:);
R.TTO=V2(171,:);
R.TUN=V2(172,:);
R.TUR=V2(173,:);
R.TKM=V2(174,:);
R.USR=V2(175,:);
R.UGA=V2(176,:);
R.UKR=V2(177,:);
R.ARE=V2(178,:);
R.GBR=V2(179,:);
R.TZA=V2(180,:);
R.USA=V2(181,:);
R.URY=V2(182,:);
R.UZB=V2(183,:);
R.VUT=V2(184,:);
R.VEN=V2(185,:);
R.VNM=V2(186,:);
R.YEM=V2(187,:);
R.ZMB=V2(188,:);
R.ZWE=V2(189,:);


%%
R1.CHN=R.CHN;
% South Asia
R1.SouthAsia=[R.AFG 
    R.BGD 
    R.MDV 
    R.NPL 
    R.PAK 
    R.LKA];



R1.EastAsia=[R.BRN 
    R.KHM 
    R.FJI 
    R.KOR 
    R.LAO 
    R.MYS 
    R.MNG 
    R.MMR 
    R.NZL 
    R.PNG 
    R.PHL 
    R.WSM 
    R.SGP 
    R.THA 
    R.VUT 
    R.VNM];

R1.SubSaharanAfrica = [
    R.AGO
    R.BEN
    R.BDI
    R.CMR
    R.TCD
    R.COG
    R.CIV
    R.ETH
    R.GAB
    R.GMB
    R.GHA
    R.GIN
    R.KEN
    R.LSO
    R.LBR
    R.MDG
    R.MLI
    R.MRT
    R.MOZ
    R.NAM
    R.NER
    R.NGA
    R.RWA
    R.SEN
    R.SYC
    R.SLE
    R.SOM
    R.ZAF
    R.SDS
    R.SUD
    R.TZA
    R.TGO
    R.UGA
    R.ZMB
    R.ZWE
];

% Eastern Europe & Central Asia
R1.EECA = [
    R.BLR
    R.MDA
    R.RUS
    R.UKR
    R.KAZ
    R.KGZ
    R.TJK
    R.UZB
    R.ARM
    R.AZE
    R.GEO
];

% Central & Southeastern Europe (including Balkans)
R1.CSE = [
    R.ALB
    R.BIH
    R.BGR
    R.HRV
    R.CZE
    R.HUN
    R.MNE
    R.MKD
    R.POL
    R.ROU
    R.SRB
    R.SVK
    R.SVN
];

% Southern Europe
R1.SE = [
    R.CYP
    R.GRC
    R.PRT
    R.TUR
];

% Baltic & Western Europe
R1.BWE = [
    R.AUT
    R.EST
    R.LVA
    R.LTU
    R.LUX
];

% Latin America & Caribbean
R1.LAC = [
    R.ATG
    R.BRB
    R.BOL
    R.CHL
    R.CRI
    R.CUB
    R.DOM
    R.ECU
    R.SLV
    R.GUY
    R.JAM
    R.PAN
    R.PER
    R.SUR
    R.TTO
    R.URY
    R.VEN
];

% Middle East & North Africa
R1.MENA = [
    R.DZA
    R.BHR
    R.DJI
    R.EGY
    R.IRN
    R.IRQ
    R.KWT
    R.LBN
    R.LBY
    R.MLT
    R.MAR
    R.OMN
    R.QAT
    R.SAU
    R.TUN
    R.ARE
    R.YEM
];

% Rest of the Countries
R1.REST = [
    R.AND
    R.ARG
    R.ABW
    R.AUS
    R.BHS
    R.BEL
    R.BLZ
    R.BMU
    R.BTN
    R.IDN 
    R.BWA
    R.BRA
    R.VGB
    R.BFA
    R.CAN
    R.CPV
    R.CYM
    R.CAF
    R.COL
    R.PRK
    R.COD
    R.DNK
    R.ERI
    R.FIN
    R.FRA
    R.PYF
    R.DEU
    R.GRL
    R.GTM
    R.HTI
    R.HND
    R.HKG
    R.ISL
    R.IND
    R.IRL
    R.ISR
    R.JPN
    R.JOR
    R.LIE
    R.MAC
    R.MWI
    R.MUS
    R.MEX
    R.MCO
    R.NLD
    R.ANT
    R.NCL
    R.NIC
    R.NOR
    R.PSE
    R.PRY
    R.SMR
    R.STP
    R.ESP
    R.SWZ
    R.SWE
    R.CHE
    R.SYR
    R.TWN
    R.TKM
    R.USR
    R.GBR
    R.USA
    R.ITA
];

V3=[R1.CHN
    R1.SouthAsia
    R1.EastAsia
    R1.SubSaharanAfrica
    R1.EECA
    R1.CSE
    R1.SE
    R1.BWE
    R1.LAC
    R1.MENA
    R1.REST];

output=V3;

return
end