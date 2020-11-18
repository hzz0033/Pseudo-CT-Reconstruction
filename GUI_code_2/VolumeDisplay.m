function varargout = VolumeDisplay(varargin)
% VOLUMEDISPLAY MATLAB code for VolumeDisplay.fig
%      VOLUMEDISPLAY, by itself, creates a new VOLUMEDISPLAY or raises the existing
%      singleton*.
%
%      H = VOLUMEDISPLAY returns the handle to a new VOLUMEDISPLAY or the handle to
%      the existing singleton*.
%
%      VOLUMEDISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOLUMEDISPLAY.M with the given input arguments.
%
%      VOLUMEDISPLAY('Property','Value',...) creates a new VOLUMEDISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VolumeDisplay_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VolumeDisplay_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VolumeDisplay

% Last Modified by GUIDE v2.5 18-Apr-2018 21:50:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VolumeDisplay_OpeningFcn, ...
                   'gui_OutputFcn',  @VolumeDisplay_OutputFcn, ...
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


% --- Executes just before VolumeDisplay is made visible.
function VolumeDisplay_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VolumeDisplay (see VARARGIN)

% Choose default command line output for VolumeDisplay
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VolumeDisplay wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global VolumeData
m=size(VolumeData,3);

set(handles.slider1,'min',1,'max',m);
set(handles.slider1,'value',m);
set(handles.slider1, 'SliderStep', [1/(m-1) 1/(m-1)]);
set(handles.edit1,'string',num2str(1));

axes(handles.axes1);
imagesc(VolumeData(:,:,1)); axis off; colormap(gray);

% --- Outputs from this function are returned to the command line.
function varargout = VolumeDisplay_OutputFcn(hObject, eventdata, handles) 
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
sliderValue = get(handles.slider1,'value');
global VolumeData
m = size(VolumeData,3);
value = m - int16(sliderValue) + 1;

set(handles.edit1,'string',num2str(value));
axes(handles.axes1);
imagesc(VolumeData(:,:,value)); axis off; colormap(gray);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
editValue = get(handles.edit1,'string');
global VolumeData;
m = size(VolumeData,3);
value = m + 1 - num2double(editValue);
set(handles.slider1,'value',value);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile(['*.tif','TIF files(*.tif)'],'pick an image','Undefined.tif');
global VolumeData
if isequal(filename,0)||isequal(pathname,0)
    error('Error. /n file is not found');
    return;
else
    p = size(VolumeData,3);
    for i=1:p
    str = strcat (int2str(i) ,'.tif') ; 
    fpath = [pathname str];
    imwrite(VolumeData(:,:,i),fpath,'WriteMode', 'append',  'Compression','none','resolution',300);
    end 
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile(['*.mp4'],'Undefined.mp4');
if isequal(filename,0)||isequal(pathname,0)
    error('Error. /n file is not found');
    return;
else
    global VolumeData
    p = size(VolumeData,3);
    for i=1:p
        imagesc(VolumeData(:,:,i));
        colormap(gray);
        mov(i) = getframe;
    end
    fpath=[pathname filename];
    writerObj=VideoWriter(fpath,'MPEG-4');
    writerObj.FrameRate=12;
    writerObj.Quality=100;
    open(writerObj);
    writeVideo(writerObj,mov);
    close(writerObj);
end
