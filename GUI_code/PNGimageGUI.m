function varargout = PNGimageGUI(varargin)
% PNGIMAGEGUI MATLAB code for PNGimageGUI.fig
%      PNGIMAGEGUI, by itself, creates a new PNGIMAGEGUI or raises the existing
%      singleton*.
%
%      H = PNGIMAGEGUI returns the handle to a new PNGIMAGEGUI or the handle to
%      the existing singleton*.
%
%      PNGIMAGEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PNGIMAGEGUI.M with the given input arguments.
%
%      PNGIMAGEGUI('Property','Value',...) creates a new PNGIMAGEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PNGimageGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PNGimageGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PNGimageGUI

% Last Modified by GUIDE v2.5 19-Apr-2018 13:08:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PNGimageGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PNGimageGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PNGimageGUI is made visible.
function PNGimageGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PNGimageGUI (see VARARGIN)

% Choose default command line output for PNGimageGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PNGimageGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PNGimageGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global
[filename,pathname]=uigetfile(['*.png;*.PNG','image files(*.png;*.PNG)'],'pick an image');
if isequal(filename,0)||isequal(pathname,0)
    return;
else

global images
axes(handles.axes1);
hwait = waitbar(0,'reading images');    % create waitbar

filename = dir([pathname,'/*.PNG']);
m = size(filename,1);
for i = 1:m
    str = [pathname,filename(i).name];
    image_raw = double(rgb2gray(imread(str)));             
    images(:,:,i) = image_raw; 
    waitbar(i/m,hwait,[num2str(fix(i*100/m)),'%']);
end

delete(hwait);
set(handles.slider1,'min',1,'max',m);
set(handles.slider1,'value',m);
set(handles.slider1, 'SliderStep', [1/(m-1) 1/(m-1)]);
imagesc(images(:,:,m)); axis off;
colormap(gray)
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider1,'value');
axes(handles.axes1);
number = int16(sliderValue);

global images
imagesc(images(:,:,number)); axis off;
colormap(gray)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider2,'value');
axes(handles.axes2);
number = int16(sliderValue);
global CropImages
global ReferNum
x = str2num(get(handles.edit_column,'string'));
n = size(CropImages,2);

if ReferNum == 1
    imagesc(CropImages(:,:,number)); axis off;
    colormap(gray),hold on
    plot([x,x],[1,n],'r')
else
    imagesc(CropImages(:,:,number)); axis off;
    colormap(gray)
end

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global images
global CropImages

m = size(images,3);
A = images(80:640,105:670,:);


CropImages = preprocessing(A,m);

set(handles.slider2,'min',1,'max',m);
set(handles.slider2,'value',m);
set(handles.slider2, 'SliderStep', [1/(m-1) 1/(m-1)]);
axes(handles.axes2);
imagesc(CropImages(:,:,m)); axis off;
colormap(gray);

set(handles.edit_sharpening,'string',0.03);
set(handles.edit_smoothing,'string',0.002);
set(handles.edit_threshold,'string',0.001);
set(handles.edit_column,'string',250);

set(handles.slider_sharpening,'min',-3,'max',0);
set(handles.slider_sharpening,'value',-1.5);
set(handles.slider_sharpening,'SliderStep',[0.1 0.1]);
set(handles.slider_smoothing,'min',0.001,'max',0.004);
set(handles.slider_smoothing,'value',0.002);
set(handles.slider_smoothing,'sliderstep',[0.33 0.33]);
set(handles.slider_threshold,'min',0.001,'max',0.1);
set(handles.slider_threshold,'value',0.001);
set(handles.slider_threshold,'sliderstep',[0.05 0.05]);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
fileSelection


% --- Executes on slider movement.
function slider_sharpening_Callback(hObject, eventdata, handles)
% hObject    handle to slider_sharpening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider_sharpening,'value');
editValue = roundn(10^(sliderValue),-3);
set(handles.edit_sharpening,'String',num2str(editValue));

% --- Executes during object creation, after setting all properties.
function slider_sharpening_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_sharpening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_smoothing_Callback(hObject, eventdata, handles)
% hObject    handle to slider_smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider_smoothing,'value');
sliderValue = roundn(sliderValue,-3);
set(handles.edit_smoothing,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_smoothing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to slider_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider_threshold,'value');
sliderValue = roundn(sliderValue,-3);
set(handles.edit_threshold,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit_sharpening_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sharpening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sharpening as text
%        str2double(get(hObject,'String')) returns contents of edit_sharpening as a double
editValue = get(handles.edit_sharpening,'string');
sliderValue = log10(str2double(editValue));
set(handles.slider_sharpening,'value',sliderValue);
%guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_sharpening_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sharpening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_smoothing_Callback(hObject, eventdata, handles)
% hObject    handle to edit_smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_smoothing as text
%        str2double(get(hObject,'String')) returns contents of edit_smoothing as a double
Value = get(handles.edit_smoothing,'string');
set(handles.slider_smoothing,'value',str2num(Value));


% --- Executes during object creation, after setting all properties.
function edit_smoothing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to edit_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_threshold as text
%        str2double(get(hObject,'String')) returns contents of edit_threshold as a double
Value = get(handles.edit_threshold,'string');
set(handles.slider_threshold,'value',str2num(Value));

% --- Executes during object creation, after setting all properties.
function edit_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_column_Callback(hObject, eventdata, handles)
% hObject    handle to edit_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_column as text
%        str2double(get(hObject,'String')) returns contents of edit_column as a double


% --- Executes during object creation, after setting all properties.
function edit_column_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CropImages
global ReferNum
hwait = waitbar(0,'processing');

column = str2num(get(handles.edit_column,'string'));

p = size(CropImages,3);    % obtain radon images
for i=1:p
    K=double(max(max(CropImages(:,:,i))))+2;
    alpha=K-double(min(min(CropImages(:,:,i))));
    D(:,:,i)=log(alpha./(K-double(CropImages(:,:,i))));        
    waitbar(i/(4*p),hwait,[num2str(fix((25*i)/p)),'%']);
end

waitbar(0.25,hwait,['25','%']);

for i = 1:p
    SinoPlot(:,i) = D(:,column,i);
end

waitbar(0.5,hwait,['50','%']);

vall = get(handles.popupmenu1,'value');          % image reconstruction
theta = 0:360/p:360-360/p;
switch vall
    case 1                                       % iradon
        I = iradon(SinoPlot,theta);
        I = max(I,0);
    case 2
        I = ifanbeam(SinoPlot,900,... 
            'FanSensorGeometry','line',...
            'Filter','Shepp-Logan',... 
            'FanCoverage','cycle');
        
        I = max(I,0);
    case 3                                       % ART 
        a = str2double(get(handles.edit_sharpening,'string'));
        b = str2double(get(handles.edit_smoothing,'string'));
        [Precovered,Ploc,Pangles] = fan2para(SinoPlot,900,...
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
            Lx=conv2(x,[0 1 0;1 -4 1;0 1 0],'valid');
            LLx=conv2(Lx,[0 1 0;1 -4 1;0 1 0]);
            x=x+b*(pd-a*LLx);
            waitbar(0.5+i/600,hwait,[num2str(50+fix((50*i)/300)),'%']);
        end
        I = max(x,0);
    case 4                                      % TV
        a = str2double(get(handles.edit_sharpening,'string'));
        b = str2double(get(handles.edit_smoothing,'string'));
        T = str2double(get(handles.edit_threshold,'string'));
        x = TViteration(a,b,T,SinoPlot);
        I = max(x,0);
end

waitbar(1,hwait,['100','%','finished']);
pause(1);
delete(hwait);
ReferNum = 1;

axes(handles.axes3);
imagesc(I); axis off;
colormap(gray);
axes(handles.axes2);
number = int16(get(handles.slider2,'value'));
x=column;
n=size(CropImages,2);
imagesc(CropImages(:,:,number)),colormap(gray),axis off
hold on
plot([x,x],[1,n],'r');



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CropImages
global VolumeData

hwait = waitbar(0,'processing');
[m,n,p] = size(CropImages);    % obtain radon images
for i=1:p
    K=double(max(max(CropImages(:,:,i))))+2;
    alpha=K-double(min(min(CropImages(:,:,i))));
    D(:,:,i)=log(alpha./(K-double(CropImages(:,:,i))));        
    waitbar(i/(4*p),hwait,[num2str(fix((25*i)/p)),'%']);
end
waitbar(0.25,hwait,['25','%']);

for i = 1:n
    for j = 1:p
        SinoPlot(:,j,i) = D(:,i,j);
    end
end

waitbar(0.5,hwait,['50','%']);

vall = get(handles.popupmenu1,'value');          % image reconstruction
theta = 0:360/p:360-360/p;
switch vall
    case 1                                       % 3D iradon
        slice = size(SinoPlot,3);
        for i = 1:slice
            R = SinoPlot(:,:,i);
            I = iradon(R,theta);  
            VolumeData(:,:,i) = max(I,0);
            waitbar(0.5+i/(2*slice),hwait,[num2str(50+fix((50*i)/slice)),'%']);
        end;
    case 2                                       % 3D fan
        slice = size(SinoPlot,3);
        for i = 1:slice
            R = SinoPlot(:,:,i);
            I = ifanbeam(R,900,... 
                        'FanSensorGeometry','line',...
                        'Filter','Shepp-Logan',... 
                        'FanCoverage','cycle');   
            VolumeData(:,:,i) = max(I,0);
            waitbar(0.5+i/(2*slice),hwait,[num2str(50+fix((50*i)/slice)),'%']);
        end;
    case 3                                       % 3D ART 
        a = str2double(get(handles.edit_sharpening,'string'));
        b = str2double(get(handles.edit_smoothing,'string'));
        VolumeData = ART_3Diteration(a,b,SinoPlot);
        
    case 4                                        % 3D TV
        a = str2double(get(handles.edit_sharpening,'string'));
        b = str2double(get(handles.edit_smoothing,'string'));
        T = str2double(get(handles.edit_threshold,'string'));
        VolumeData = TV_3Diteration(a,b,T,SinoPlot);
        
end
waitbar(1,hwait,'completed')
pause(0.2)
delete(hwait);
VolumeDisplay
