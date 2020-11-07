function varargout = DCM_Recon(varargin)
% DCM_RECON MATLAB code for DCM_Recon.fig
%      DCM_RECON, by itself, creates a new DCM_RECON or raises the existing
%      singleton*.
%
%      H = DCM_RECON returns the handle to a new DCM_RECON or the handle to
%      the existing singleton*.
%
%      DCM_RECON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCM_RECON.M with the given input arguments.
%
%      DCM_RECON('Property','Value',...) creates a new DCM_RECON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DCM_Recon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DCM_Recon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DCM_Recon

% Last Modified by GUIDE v2.5 05-Nov-2019 19:10:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCM_Recon_OpeningFcn, ...
                   'gui_OutputFcn',  @DCM_Recon_OutputFcn, ...
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


% --- Executes just before DCM_Recon is made visible.
function DCM_Recon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DCM_Recon (see VARARGIN)

% Choose default command line output for DCM_Recon
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DCM_Recon wait for user response (see UIRESUME)
% uiwait(handles.figure1);

addpath('function');

if ~exist('SinoPl.mat','file')
    error('Error. \n Processed datafiles are not found, please check SinoPl.mat');
else
    global SinoPl;
    axes(handles.axes1);
    m = size(SinoPl,3);
    imagesc(max(SinoPl(:,:,m),0)); axis off; colormap(gray);
   
    set(handles.slider1,'min',1,'max',m);
    set(handles.slider1,'value',m);
    set(handles.slider1,'SliderStep',[1/(m-1) 1/(m-1)]);
end

set(handles.edit_sharpening,'string',0.03);
set(handles.edit_smoothing,'string',0.002);
set(handles.edit_threshold,'string',0.001);
set(handles.slice_col,'string',512);

set(handles.Sharpen,'min',-3,'max',0);
set(handles.Sharpen,'value',-1.5);
set(handles.Sharpen,'SliderStep',[0.1 0.1]);

set(handles.Smooth,'min',0.001,'max',0.004);
set(handles.Smooth,'value',0.002);
set(handles.Smooth,'SliderStep',[0.33 0.33]);

set(handles.Threshold,'min',0.001,'max',0.1);
set(handles.Threshold,'value',0.001);
set(handles.Threshold,'SliderStep',[0.05 0.05]);

    
% --- Outputs from this function are returned to the command line.
function varargout = DCM_Recon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(handles.slider1,'value');
slice = int16(value);

global SinoPl;
axes(handles.axes1)
imagesc(max(SinoPl(:,:,slice),0)); axis off; colormap(gray);


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
function Sharpen_Callback(hObject, eventdata, handles)
% hObject    handle to Sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.Sharpen,'value');
editVal = roundn(10^(sliderValue),-3);
set(handles.edit_sharpening,'string',num2str(editVal));



% --- Executes during object creation, after setting all properties.
function Sharpen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.Smooth,'value');
editVal = roundn(sliderValue,-3);
set(handles.edit_smoothing,'string',num2str(editVal));

% --- Executes during object creation, after setting all properties.
function Smooth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.Threshold,'value');
editVal = roundn(sliderValue,-3);
set(handles.edit_threshold,'string',num2str(editVal));


% --- Executes during object creation, after setting all properties.
function Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
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
set(handles.Sharpen,'value',sliderValue);

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
editValue = get(handles.edit_smoothing,'string');
set(handles.Smooth,'value',str2num(editValue));

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
editValue = get(handles.edit_threshold,'string');
set(handles.threshold,'value',str2num(editValue));

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



function slice_col_Callback(hObject, eventdata, handles)
% hObject    handle to slice_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slice_col as text
%        str2double(get(hObject,'String')) returns contents of slice_col as a double


% --- Executes during object creation, after setting all properties.
function slice_col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slice_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ReconMethod.
function ReconMethod_Callback(hObject, eventdata, handles)
% hObject    handle to ReconMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ReconMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ReconMethod


% --- Executes during object creation, after setting all properties.
function ReconMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ReconMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SliceRecon.
function SliceRecon_Callback(hObject, eventdata, handles)
% hObject    handle to SliceRecon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SinoPl;
load('ParamSetting.mat');

if ~exist('ParamSetting.mat','file')
    error('Error. \n Parameter file is not found, please do the parameter setting first.');
end

hwait = waitbar(0,'processing');

slice = str2num(get(handles.slice_col,'string'));

num = size(SinoPl,3);
val = get(handles.ReconMethod,'value');

for i = 1:num
    Sino(:,i) = SinoPl(:,slice,i);      % required slice for reconstruction
end

switch val
    case 1                               % iradon
        [Precovered,Ploc,Pangles] = fan2para(Sino,param.DSO,...
                                      'FanSensorGeometry','line',...
                                      'ParallelSensorSpacing',1);
        I = max(iradon(Precovered,Pangles),0);
        
    case 2                              % fanbeam recon
        I = ifanbeam(Sino,param.DSO,... 
            'FanSensorGeometry','line',...
            'Filter','Shepp-Logan',... 
            'FanCoverage','cycle');
        I = max(I,0);
        
    case 3                              % fan + TV 
        a = str2double(get(handles.edit_sharpening,'string'));
        b = str2double(get(handles.edit_smoothing,'string'));
        T = str2double(get(handles.edit_threshold,'string'));
        x = TViteration(a,b,T,SinoPlot,param.DSO);
        I = max(x,0);        
        
    case 4                              % FDK
        error('Error. \n FDK algorithm is applied for 3D reconstruction, please use another one');
end

waitbar(1,hwait,['100','%','finished']);
pause(1);
delete(hwait);

axes(handles.axes2)
imagesc(I); axis off; colormap(gray);

axes(handles.axes1)    % add 1 corresponding red line to the sino images
num = int16(get(handles.slider1,'value'));
row = size(SinoPl,2);
imagesc(max(SinoPl(:,:,num),0)); axis off; colormap(gray);
hold on
plot([slice,slice],[1,row],'r');
        

% --- Executes on button press in Recon3D.
function Recon3D_Callback(hObject, eventdata, handles)
% hObject    handle to Recon3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SinoPl;
global VolumeData;
addpath('functions');
load('ParamSetting.mat');

if ~exist('ParamSetting.mat','file')
    error('Error. \n Parameter file is not found, please do the parameter setting first.');
end

hwait = waitbar(0,'processing');

[m,n,p] = size(SinoPl);
val = get(handles.ReconMethod,'value');

for i = 1:n
    for j = 1:p
        Sino(:,j,i) = SinoPl(:,i,j);      % rearrange projection data
    end
end

switch val
    case 1                    % 3d para
        for i = 1:n
            Radon = Sino(:,:,i);
            [Precovered,Ploc,Pangles] = fan2para(Radon,param.DSO,...
                                      'FanSensorGeometry','line',...
                                      'ParallelSensorSpacing',1);
            I = max(iradon(Precovered,Pangles),0);
            VolumeData(:,:,i) = imresize(I,[512,512]);
            waitbar(i/n,hwait,[num2str(fix(i*100/n)),'%']);
        end
        
    case 2                              % fanbeam recon 3D
        for i = 1:n
            Radon = Sino(:,:,i);
            I = ifanbeam(Radon,param.DSO,... 
                'FanSensorGeometry','line',...
                'Filter','Shepp-Logan',... 
                'FanCoverage','cycle');
            I = max(I,0);
            VolumeData(:,:,i) = imresize(I,[512,512]);
            waitbar(i/n,hwait,[num2str(fix(i*100/n)),'%']);
        end
        
    case 3                              % fan + TV 
        a = str2double(get(handles.edit_sharpening,'string'));
        b = str2double(get(handles.edit_smoothing,'string'));
        T = str2double(get(handles.edit_threshold,'string'));
        h = msgbox('this process will take several hours(6hr)','processing');
        VolumeData = TV_3Diteration(a,b,T,Sino);       
        close(h);
        
    case 4                              % FDK  
        proj = SinoPl;
        waitbar(0.25,hwait,['25%']);
        proj_filtered = filtering(proj,param);
        waitbar(0.5,hwait,['50%']);
        h = msgbox('this process will take several minutes(8min)','processing');
        VolumeData = CTbackprojection(proj_filtered, param);
        close(h);
end
waitbar(1,hwait,['completed']);
pause(0.2)
delete(hwait);
VolumeDisplay;



% --- Executes on button press in Parameter.
function Parameter_Callback(hObject, eventdata, handles)
% hObject    handle to Parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Param_Setting;

% --- Executes on button press in Return.
function Return_Callback(hObject, eventdata, handles)
% hObject    handle to Return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
DCM_Image_Input;
