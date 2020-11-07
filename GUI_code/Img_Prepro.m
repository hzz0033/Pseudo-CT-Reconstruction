function varargout = Img_Prepro(varargin)
% IMG_PREPRO MATLAB code for Img_Prepro.fig
%      IMG_PREPRO, by itself, creates a new IMG_PREPRO or raises the existing
%      singleton*.
%
%      H = IMG_PREPRO returns the handle to a new IMG_PREPRO or the handle to
%      the existing singleton*.
%
%      IMG_PREPRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMG_PREPRO.M with the given input arguments.
%
%      IMG_PREPRO('Property','Value',...) creates a new IMG_PREPRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Img_Prepro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Img_Prepro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Img_Prepro

% Last Modified by GUIDE v2.5 05-Nov-2019 01:58:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Img_Prepro_OpeningFcn, ...
                   'gui_OutputFcn',  @Img_Prepro_OutputFcn, ...
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


% --- Executes just before Img_Prepro is made visible.
function Img_Prepro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Img_Prepro (see VARARGIN)

% Choose default command line output for Img_Prepro
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Img_Prepro wait for user response (see UIRESUME)
% uiwait(handles.figure1);

addpath('functions');
global Projection_Images;
global Background_Image;


set(handles.edge_threshold,'string',0.1);
set(handles.axis_xStart,'string',150);
set(handles.axis_xEnd,'string',900);
setappdata(0,'threshold',0.1);
setappdata(0,'head',150);
setappdata(0,'tail',900);


m = size(Projection_Images,3);
set(handles.slider1,'min',1,'max',m);
set(handles.slider1,'value',m);
set(handles.slider1, 'SliderStep', [1/(m-1) 1/(m-1)]);
setappdata(0,'ref',0);  % reference variable for slider

axes(handles.axes1);
meanVal = mean2(mean(Projection_Images));
imagesc(Projection_Images(:,:,m),[0,2*meanVal]); axis off; colormap(gray);

% --- Outputs from this function are returned to the command line.
function varargout = Img_Prepro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edge_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to edge_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edge_threshold as text
%        str2double(get(hObject,'String')) returns contents of edge_threshold as a double

threshold = str2num(get(handles.edge_threshold,'string'));
setappdata(0,'threshold',threshold);





% --- Executes during object creation, after setting all properties.
function edge_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edge_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ref = getappdata(0,'ref');
global Projection_Images;
global SinoPl;

sliderValue = get(handles.slider1,'value');
sliderValue = int16(sliderValue);
    
if ref == 0
    axes(handles.axes1);
    meanVal = mean2(mean(Projection_Images));
    imagesc(Projection_Images(:,:,sliderValue),[0,2*meanVal]); axis off; colormap(gray);
else if ref == 1
    axes(handles.axes1);
    imagesc(max(SinoPl(:,:,sliderValue),0)); axis off; colormap(gray);  
else
    warndlg('images are unavaliable, please check','warning','modal'); 
    end
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Projection_Images;
global Background_Image;
global SinoPl;

thread = getappdata(0,'threshold');   % edge thread for canny kernel
head = getappdata(0,'head');
tail = getappdata(0,'tail');
axis_x = head:tail;   % middle part of object to detect tube position info, can change

if isempty(Projection_Images) || isempty(Background_Image)
    h = errordlg('error: Input Images are invalid','error');
else  
    h = msgbox('Images are under processing','Processing','fontsize',13);
    [Sino_plot,center] = ImgPreprocessing( Projection_Images, Background_Image, thread, axis_x ); % rotation
    SinoPl = Shift(Sino_plot,center); % move Sino_plot to the center place
    close(h);
end

h = msgbox('saving processed data','saving','fontsize',13);
save SinoPl.mat SinoPl;
setappdata(0,'ref',1);
close(h);

msgbox('processing are finished, you can continue','congrats','fontsize',13);
axes(handles.axes1);
m = size(SinoPl,3);
imagesc(max(SinoPl(:,:,m),0)); axis off; colormap(gray);

% --- Executes on button press in finish.
function finish_Callback(hObject, eventdata, handles)
% hObject    handle to finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;
DCM_Image_Input;


function axis_xStart_Callback(hObject, eventdata, handles)
% hObject    handle to axis_xStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axis_xStart as text
%        str2double(get(hObject,'String')) returns contents of axis_xStart as a double

value = str2num(get(handles.axis_xStart,'string'));
setappdata(0,'head',value);



% --- Executes during object creation, after setting all properties.
function axis_xStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis_xStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axis_xEnd_Callback(hObject, eventdata, handles)
% hObject    handle to axis_xEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of axis_xEnd as text
%        str2double(get(hObject,'String')) returns contents of axis_xEnd as a double

value = str2num(get(handles.axis_xEnd,'string'));
setappdata(0,'tail',value);

% --- Executes during object creation, after setting all properties.
function axis_xEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis_xEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
