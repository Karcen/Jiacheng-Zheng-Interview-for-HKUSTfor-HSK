function output=BRI_EORA_VAD(V1)

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

C1.EastAsia=[C.BRN C.KHM  C.FJI C.IDN   C.KOR C.LAO   C.MYS C.MNG   C.MMR C.NZL   C.PNG  C.PHL   C.WSM C.SGP   C.THA  C.VUT   C.VNM];

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
C1.REST=[C.AND, C.ARG, C.ABW, C.AUS, C.BHS, C.BEL, C.BLZ, C.BMU, C.BTN, C.BWA, C.BRA, C.VGB, C.BFA, C.CAN, C.CPV, C.CYM, C.CAF, C.COL, C.PRK, C.COD, C.DNK, C.ERI, C.FIN, C.FRA, C.PYF, C.DEU, C.GRL, C.GTM, C.HTI, C.HND, C.HKG, C.ISL, C.IND, C.IRL, C.ISR, C.JPN, C.JOR, C.LIE, C.MAC, C.MWI, C.MUS, C.MEX, C.MCO, C.NLD, C.ANT, C.NCL, C.NIC, C.NOR, C.PSE, C.PRY, C.SMR, C.STP, C.ESP, C.SWZ, C.SWE, C.CHE, C.SYR, C.TWN, C.TKM, C.USR, C.GBR, C.USA C.ITA];


V2=[C1.CHN C1.SouthAsia C1.EastAsia C1.SubSaharanAfrica  C1.EECA C1.CSE C1.SE C1.BWE C1.LAC C1.MENA C1.REST];

output=V2;

return
end