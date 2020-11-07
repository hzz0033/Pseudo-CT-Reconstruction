function varargout = DCM_Image_Input(varargin)
% DCM_IMAGE_INPUT MATLAB code for DCM_Image_Input.fig
%      DCM_IMAGE_INPUT, by itself, creates a new DCM_IMAGE_INPUT or raises the existing
%      singleton*.
%
%      H = DCM_IMAGE_INPUT returns the handle to a new DCM_IMAGE_INPUT or the handle to
%      the existing singleton*.
%
%      DCM_IMAGE_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCM_IMAGE_INPUT.M with the given input arguments.
%
%      DCM_IMAGE_INPUT('Property','Value',...) creates a new DCM_IMAGE_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DCM_Image_Input_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DCM_Image_Input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DCM_Image_Input

% Last Modified by GUIDE v2.5 05-Nov-2019 00:00:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCM_Image_Input_OpeningFcn, ...
                   'gui_OutputFcn',  @DCM_Image_Input_OutputFcn, ...
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


% --- Executes just before DCM_Image_Input is made visible.
function DCM_Image_Input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DCM_Image_Input (see VARARGIN)

% Choose default command line output for DCM_Image_Input
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DCM_Image_Input wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SinoPl;
if exist('SinoPl.mat','file')
    num = size(SinoPl,3);
    imagesc(max(SinoPl(:,:,num),0)); axis off; colormap(gray);
end


% --- Outputs from this function are returned to the command line.
function varargout = DCM_Image_Input_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in DCM_Input.
function DCM_Input_Callback(hObject, eventdata, handles)
% hObject    handle to DCM_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile(['*.dcm; *.DCM', 'image files(*.dcm; *.DCM)'], 'pick an image');
if isequal(filename, 0) || isequal(pathname, 0)
    warndlg('no dcm image input','warning','modal');
    return;
else 
    global Projection_Images;  
    axes(handles.axes1);
    hwait = waitbar(0,'reading images');    % create waitbar
    filename = dir([pathname,'/*.dcm']);
    [m,n] = size(filename);
    for i = 1:m
        str = [pathname,filename(i).name];
        image_raw = dicomread(str); % 4-D data package
        if length(size(image_raw)) == 4
            images(:,:,i) = image_raw(:,:,1,2);
        else
            images(:,:,i) = image_raw(:,:);     % extract x-ray mode image
        end
        waitbar(i/m,hwait,[num2str(fix(i*100/m)),'%']);
    end
    Projection_Images = images;
    delete(hwait);
end

% set defaul values for slider 
set(handles.slider1,'min',1,'max',m);
set(handles.slider1,'value',m);
set(handles.slider1, 'SliderStep', [1/(m-1) 1/(m-1)]);

%{
h = dialog('Name','congrats', 'Position', [300 300 250 150]);
txt = uicontrol('parent', h, ...
                'Style','text', ...
                'Position', [40 80 210 40], ...
                'String','DCM images are well deployed','fontsize', 12);
btn = uicontrol('parent', h, ...
                'Position', [85 20 70 25], ...
                'String', 'Close', ...
                'Callback', 'delete(gcf)');
%}
meanVal = mean2(mean(Projection_Images));
imagesc(Projection_Images(:,:,m),[0,2*meanVal]); axis off; colormap(gray);


% --- Executes on button press in Backg_Input.
function Backg_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Backg_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile(['*.dcm; *.DCM', 'image files(*.dcm; *.DCM)'], 'pick an image');
if isequal(filename, 0) || isequal(pathname, 0)
    warndlg('no background image input, please check','warning','modal');
    return;
else 
    global Background_Image;  
    hwait = waitbar(0,'reading images');    % create waitbar
    filename = dir([pathname,'/*.dcm']);
    [m,n] = size(filename);
    for i = 1:m
        str = [pathname,filename(i).name];
        image_raw = dicomread(str); % 4-D data package
        if length(size(image_raw)) == 4
            images(:,:,i) = image_raw(:,:,1,2);
        else
            images(:,:,i) = image_raw(:,:);     % extract x-ray mode image
        end
        waitbar(i/m,hwait,[num2str(fix(i*100/m)),'%']);
    end
    if m == 1
        Background_Image = images;
    else
        Background_Image = mean(images,3);
    end
    delete(hwait);    
end

msgbox('Background images are well deployed','congrats','fontsize',13);


% --- Executes on button press in Img_Pre.
function Img_Pre_Callback(hObject, eventdata, handles)
% hObject    handle to Img_Pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Img_Prepro;


% --- Executes on button press in go_back.
function go_back_Callback(hObject, eventdata, handles)
% hObject    handle to go_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
fileSelection;

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
DCM_Recon;

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider1, 'value');
slice = int16(sliderValue);

global Projection_Images;
global SinoPl;

axes(handles.axes1)
if exist('SinoPl.mat','file')
    imagesc(max(SinoPl(:,:,slice),0)); axis off; colormap(gray);
else
    meanVal = mean2(mean(Projection_Images));
    imagesc(Projection_Images(:,:,slice),[0,2*meanVal]); axis off; colormap(gray);
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
