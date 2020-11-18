function x = TViteration(a,b,T,Sino,DSO)

hwait = waitbar(0.5,['50','%']);
[Precovered,Ploc,Pangles] = fan2para(Sino,DSO,...
                                      'FanSensorGeometry','line',...
                                      'ParallelSensorSpacing',1);
x=max(iradon(Precovered,Pangles),0);
[m,n]=size(Precovered);
for i=1:300
    px=radon(x,Pangles);
    [m2,n2]=size(px);
    d=abs(m2-m)./2;
    difference=Precovered-px(1+d:m2-d,1:n2);
    pd=iradon(difference,Pangles,'none');
    Dmx=conv2(x,[1 -1]','valid');
    Dnx=conv2(x,[1 -1],'valid');
    ODmx=sign(Dmx).*min(abs(Dmx)/T,1);
    ODnx=sign(Dnx).*min(abs(Dnx)/T,1);
    dOx=conv2(ODmx,[-1 1]')+conv2(ODnx,[-1 1]);
    x=max(x+b*(pd-a*dOx),0);
    waitbar(0.5+i/600,hwait,[num2str(50+fix((50*i)/300)),'%']);
end   
delete(hwait);
end