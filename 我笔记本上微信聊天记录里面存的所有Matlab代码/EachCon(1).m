function [output2]= EachCon(V1)
num=45;

ARG = V1(0*num+1:1*num, :);
AUS = V1(1*num+1:2*num, :);
AUT = V1(2*num+1:3*num, :);
BEL = V1(3*num+1:4*num, :);
BGD = V1(4*num+1:5*num, :);
BGR = V1(5*num+1:6*num, :);
BLR = V1(6*num+1:7*num, :);
BRA = V1(7*num+1:8*num, :);
BRN = V1(8*num+1:9*num, :);
CAN = V1(9*num+1:10*num, :);
CHE = V1(10*num+1:11*num, :);
CHL = V1(11*num+1:12*num, :);
CHN = V1(12*num+1:13*num, :);
CIV = V1(13*num+1:14*num, :);
CMR = V1(14*num+1:15*num, :);
COL = V1(15*num+1:16*num, :);
CRI = V1(16*num+1:17*num, :);
CYP = V1(17*num+1:18*num, :);
CZE = V1(18*num+1:19*num, :);
DEU = V1(19*num+1:20*num, :);
DNK = V1(20*num+1:21*num, :);
EGY = V1(21*num+1:22*num, :);
ESP = V1(22*num+1:23*num, :);
EST = V1(23*num+1:24*num, :);
FIN = V1(24*num+1:25*num, :);
FRA = V1(25*num+1:26*num, :);
GBR = V1(26*num+1:27*num, :);
GRC = V1(27*num+1:28*num, :);
HKG = V1(28*num+1:29*num, :);
HRV = V1(29*num+1:30*num, :);
HUN = V1(30*num+1:31*num, :);
IDN = V1(31*num+1:32*num, :);
IND = V1(32*num+1:33*num, :);
IRL = V1(33*num+1:34*num, :);
ISL = V1(34*num+1:35*num, :);
ISR = V1(35*num+1:36*num, :);
ITA = V1(36*num+1:37*num, :);
JOR = V1(37*num+1:38*num, :);
JPN = V1(38*num+1:39*num, :);
KAZ = V1(39*num+1:40*num, :);
KHM = V1(40*num+1:41*num, :);
KOR = V1(41*num+1:42*num, :);
LAO = V1(42*num+1:43*num, :);
LTU = V1(43*num+1:44*num, :);
LUX = V1(44*num+1:45*num, :);
LVA = V1(45*num+1:46*num, :);
MAR = V1(46*num+1:47*num, :);
MEX = V1(47*num+1:48*num, :);
MLT = V1(48*num+1:49*num, :);
MMR = V1(49*num+1:50*num, :);
MYS = V1(50*num+1:51*num, :);
NGA = V1(51*num+1:52*num, :);
NLD = V1(52*num+1:53*num, :);
NOR = V1(53*num+1:54*num, :);
NZL = V1(54*num+1:55*num, :);
PAK = V1(55*num+1:56*num, :);
PER = V1(56*num+1:57*num, :);
PHL = V1(57*num+1:58*num, :);
POL = V1(58*num+1:59*num, :);
PRT = V1(59*num+1:60*num, :);
ROU = V1(60*num+1:61*num, :);
RUS = V1(61*num+1:62*num, :);
SAU = V1(62*num+1:63*num, :);
SEN = V1(63*num+1:64*num, :);
SGP = V1(64*num+1:65*num, :);
SVK = V1(65*num+1:66*num, :);
SVN = V1(66*num+1:67*num, :);
SWE = V1(67*num+1:68*num, :);
THA = V1(68*num+1:69*num, :);
TUN = V1(69*num+1:70*num, :);
TUR = V1(70*num+1:71*num, :);
TWN = V1(71*num+1:72*num, :);
UKR = V1(72*num+1:73*num, :);
USA = V1(73*num+1:74*num, :);
VNM = V1(74*num+1:75*num, :);
ZAF = V1(75*num+1:76*num, :);
ROW = V1(76*num+1:77*num, :);


V2 = [ARG AUS AUT BEL BGD BGR BLR BRA BRN CAN CHE CHL CHN CIV CMR COL CRI CYP CZE DEU DNK EGY ESP EST FIN FRA GBR GRC HKG HRV HUN IDN IND IRL ISL ISR ITA JOR JPN KAZ KHM KOR LAO LTU LUX LVA MAR MEX MLT MMR MYS NGA NLD NOR NZL PAK PER PHL POL PRT ROU RUS SAU SEN SGP SVK SVN SWE THA TUN TUR TWN UKR USA VNM ZAF ROW];

output2=V2;

return
end
