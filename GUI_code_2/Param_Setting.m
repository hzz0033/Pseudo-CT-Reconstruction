function varargout = Param_Setting(varargin)
% PARAM_SETTING MATLAB code for Param_Setting.fig
%      PARAM_SETTING, by itself, creates a new PARAM_SETTING or raises the existing
%      singleton*.
%
%      H = PARAM_SETTING returns the handle to a new PARAM_SETTING or the handle to
%      the existing singleton*.
%
%      PARAM_SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAM_SETTING.M with the given input arguments.
%
%      PARAM_SETTING('Property','Value',...) creates a new PARAM_SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Param_Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Param_Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Param_Setting

% Last Modified by GUIDE v2.5 06-Nov-2019 09:14:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Param_Setting_OpeningFcn, ...
                   'gui_OutputFcn',  @Param_Setting_OutputFcn, ...
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


% --- Executes just before Param_Setting is made visible.
function Param_Setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Param_Setting (see VARARGIN)

% Choose default command line output for Param_Setting
handles.output = hObject;

% UIWAIT makes Param_Setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SinoPl;
set(handles.nx,'string',512);
handles.nxVal = 512;
set(handles.ny,'string',512);
handles.nyVal = 512;
set(handles.nz,'string',512);
handles.nzVal = 512;
set(handles.sx,'string',512);
handles.sxVal = 512;
set(handles.sy,'string',512);
handles.syVal = 512;
set(handles.sz,'string',512);
handles.szVal = 512;

row = size(SinoPl,1);
col = size(SinoPl,2);
set(handles.nu,'string',row);
handles.nuVal = row;
set(handles.nv,'string',col);
handles.nvVal = col;
set(handles.su,'string',row);
handles.suVal = row;
set(handles.sv,'string',col);
handles.svVal = col;

set(handles.DSO,'string',3085);
handles.DSOVal = 3085;
set(handles.DSD,'string',6826);
handles.DSDVal = 6826;

set(handles.direc,'string',-1);
handles.dirVal = -1;
slice = size(SinoPl,3);
set(handles.number,'string',slice);
handles.numVal = slice;
set(handles.parker,'string',0);
handles.parkerVal = 0;

set(handles.filter,'string','ram-lak');
handles.filterVal = 'ram-lak';
set(handles.InterType,'string','linear');
handles.interptypeVal = 'linear';

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Param_Setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




function nx_Callback(hObject, eventdata, handles)
% hObject    handle to nx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nx as text
%        str2double(get(hObject,'String')) returns contents of nx as a double

handles.nxVal = str2num(get(handles.nx,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ny_Callback(hObject, eventdata, handles)
% hObject    handle to ny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ny as text
%        str2double(get(hObject,'String')) returns contents of ny as a double
handles.nyVal = str2num(get(handles.ny,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ny_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nz_Callback(hObject, eventdata, handles)
% hObject    handle to nz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nz as text
%        str2double(get(hObject,'String')) returns contents of nz as a double
handles.nzVal = str2num(get(handles.nz,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sx_Callback(hObject, eventdata, handles)
% hObject    handle to sx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sx as text
%        str2double(get(hObject,'String')) returns contents of sx as a double
handles.sxVal = str2num(get(handles.sx,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sy_Callback(hObject, eventdata, handles)
% hObject    handle to sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sy as text
%        str2double(get(hObject,'String')) returns contents of sy as a double
handles.syVal = str2num(get(handles.sy,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sz_Callback(hObject, eventdata, handles)
% hObject    handle to sz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sz as text
%        str2double(get(hObject,'String')) returns contents of sz as a double
handles.szVal = str2num(get(handles.sz,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nu_Callback(hObject, eventdata, handles)
% hObject    handle to nu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nu as text
%        str2double(get(hObject,'String')) returns contents of nu as a double
handles.nuVal = str2num(get(handles.nu,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nv_Callback(hObject, eventdata, handles)
% hObject    handle to nv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nv as text
%        str2double(get(hObject,'String')) returns contents of nv as a double
handles.nvVal = str2num(get(handles.nv,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function su_Callback(hObject, eventdata, handles)
% hObject    handle to su (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of su as text
%        str2double(get(hObject,'String')) returns contents of su as a double
handles.suVal = str2num(get(handles.su,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function su_CreateFcn(hObject, eventdata, handles)
% hObject    handle to su (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sv_Callback(hObject, eventdata, handles)
% hObject    handle to sv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sv as text
%        str2double(get(hObject,'String')) returns contents of sv as a double
handles.svVal = str2num(get(handles.sv,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DSO_Callback(hObject, eventdata, handles)
% hObject    handle to DSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DSO as text
%        str2double(get(hObject,'String')) returns contents of DSO as a double
handles.DSOVal = str2num(get(handles.DSO,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function DSO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DSO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DSD_Callback(hObject, eventdata, handles)
% hObject    handle to DSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DSD as text
%        str2double(get(hObject,'String')) returns contents of DSD as a double
handles.DSDVal = str2num(get(handles.DSD,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function DSD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function direc_Callback(hObject, eventdata, handles)
% hObject    handle to direc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of direc as text
%        str2double(get(hObject,'String')) returns contents of direc as a double
handles.dirVal = str2num(get(handles.direc,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function direc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function number_Callback(hObject, eventdata, handles)
% hObject    handle to number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number as text
%        str2double(get(hObject,'String')) returns contents of number as a double
handles.numVal = str2num(get(handles.number,'string'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function parker_Callback(hObject, eventdata, handles)
% hObject    handle to parker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parker as text
%        str2double(get(hObject,'String')) returns contents of parker as a double
handles.parkerVal = str2num(get(handles.parker,'string'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function parker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filter as text
%        str2double(get(hObject,'String')) returns contents of filter as a double
handles.filterVal = get(handles.filter,'string');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InterType_Callback(hObject, eventdata, handles)
% hObject    handle to InterType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InterType as text
%        str2double(get(hObject,'String')) returns contents of InterType as a double
handles.interptypeVal = get(handles.InterType,'string');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function InterType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InterType (see GCBO)
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
param.nx = handles.nxVal;
param.ny = handles.nyVal;
param.nz = handles.nzVal;
param.sx = handles.sxVal;
param.sy = handles.syVal;
param.sz = handles.szVal;

param.nu = handles.nuVal;
param.nv = handles.nvVal;
param.su = handles.suVal;
param.sv = handles.svVal;

param.DSO = handles.DSOVal;
param.DSD = handles.DSDVal;

param.dir = handles.dirVal;
param.nProj = handles.numVal;
param.dang = 360/(param.nProj - 1);
param.deg = param.dir * (0:param.dang:360);
param.parker = handles.parkerVal;

param.filter = handles.filterVal;
param.interptype = handles.interptypeVal;

param.off_u = 0; param.off_v = 0; % detector rotation shift (real size)

% % % % % % Confirm your parameters % % % % % % %
% Only for Matlab version above 2013b with parallel computing toolbox: Speed dependent on your GPU
% You don't need to install CUDA, but install latest graphics driver.
% only Nvidia GPU cards can use this. otherwise please "param.gpu=0"
% This option is semi-GPU code using built-in Matlab GPU functions: several times faster than CPU
param.gpu = 0;

param.dx = param.sx/param.nx; % single voxel size
param.dy = param.sy/param.ny;
param.dz = param.sz/param.nz;
param.du = param.su/param.nu;
param.dv = param.sv/param.nv;

% % % Geometry calculation % % %
param.xs = [-(param.nx-1)/2:1:(param.nx-1)/2]*param.dx;
param.ys = [-(param.ny-1)/2:1:(param.ny-1)/2]*param.dy;
param.zs = [-(param.nz-1)/2:1:(param.nz-1)/2]*param.dz;

param.us = (-(param.nu-1)/2:1:(param.nu-1)/2)*param.du + param.off_u;
param.vs = (-(param.nv-1)/2:1:(param.nv-1)/2)*param.dv + param.off_v;

save ParamSetting.mat param;
close;
DCM_Recon;
