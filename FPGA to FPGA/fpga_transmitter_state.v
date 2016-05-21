module stateForFpgaTran(finishSent,finish,sendToOther,resetCounter,increment,load,shift,sent,acknowledge,count8,clk,reset);
output finishSent,finish,sendToOther,resetCounter,increment,load,shift;
input sent,acknowledge,count8,clk,reset;

reg[3:0] ps;
reg[3:0] ns;

always @(posedge clk)
begin
	if(reset)ps=0;
	else ps = ns;
end

always @(sent or acknowledge or count8 or ps)
begin
	if(ps == 0)ns = (sent)?1:0;
	if(ps == 1)ns = 2;
	if(ps == 2)ns = (acknowledge)?3:2;
	if(ps == 3)ns = (acknowledge)?4:3;
	if(ps == 4)ns = (count8)?5:3;
	if(ps == 5)ns = (acknowledge)?6:5;
	if(ps == 6)ns = 0;
end

always @(ps)
begin
	if(ps == 1)load = 1;
	else load = 0;
	if(ps == 1 || ps == 3)sendToOther = 1;
	else sendToOther = 0;
	if(ps == 1)resetCounter = 1;
	else resetCounter = 0;
	if(ps == 4)shift=1;
	else shift = 0;
	if(ps == 4)increment = 1;
	else increment = 0;
	if(ps == 5)finish = 1;
	else finish = 0;
	if(ps == 6)finishSent = 1;
	else finishSent = 0;
end