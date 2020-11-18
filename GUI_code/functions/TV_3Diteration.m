function reconstruction = TV_3Diteration(a,b,T,SinoPlot)

hwait = waitbar(0,'Total Variation begin');

[m,p,n] = size(SinoPlot);
theta = 0:360/p:360-360/p;

for i = 1:n
    R = SinoPlot(:,:,i);
    %I = imresize(iradon(R,theta),[512,512]);  
    I = iradon(R,theta);
    II(:,:,i) = max(I,0);
end

cap=zeros(1,1,2);
cap(1,1,1)=1;
cap(1,1,2)=-1;
cap2=-cap;
%Volume=[];
Volume=II;

for j=1:300
    for i=1:n
        projections(:,:,i)=radon(Volume(:,:,i),theta);
    end
    
    [m2,p2,n2]=size(projections);
    d=abs(m2-m)./2;   
    
    for i = 1:n
        difference(:,:,i) = SinoPlot(:,:,i)-projections(1+d:m2-d,1:p2,i);
    end
    
    for i = 1:n
        pd(:,:,i) = iradon(difference(:,:,i),theta,'none');
    end
    
    Dmx=convn(Volume,[1 -1]','valid');
    Dnx=convn(Volume,[1 -1],'valid');
    Doz=convn(Volume,cap,'valid');
    ODmx=sign(Dmx).*min(abs(Dmx)/T,1);
    ODnx=sign(Dnx).*min(abs(Dnx)/T,1);
    ODoz=sign(Doz).*min(abs(Doz)/T,1);
    dOx=convn(ODmx,[-1 1]')+convn(ODnx,[-1 1])+convn(ODoz,cap2);
    Volume=max(Volume+b*(pd-a*dOx),0);
    
    waitbar(j/300,hwait,[num2str(fix(j*100/300)),'%']);  
end

reconstruction = zeros(512,512,n);
for i = 1:n
    reconstruction(:,:,i) = imresize(Volume(:,:,i),[512,512]);
end

waitbar(1,hwait,'100%');
pause(1)
delete(hwait);
end