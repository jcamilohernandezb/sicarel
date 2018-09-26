function varargout = cargar_imagenes(varargin)
% CARGAR_IMAGENES MATLAB code for cargar_imagenes.fig
%      CARGAR_IMAGENES, by itself, creates a new CARGAR_IMAGENES or raises the existing
%      singleton*.
%
%      H = CARGAR_IMAGENES returns the handle to a new CARGAR_IMAGENES or the handle to
%      the existing singleton*.
%
%      CARGAR_IMAGENES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CARGAR_IMAGENES.M with the given input arguments.
%
%      CARGAR_IMAGENES('Property','Value',...) creates a new CARGAR_IMAGENES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cargar_imagenes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cargar_imagenes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cargar_imagenes

% Last Modified by GUIDE v2.5 08-Sep-2018 15:19:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cargar_imagenes_OpeningFcn, ...
                   'gui_OutputFcn',  @cargar_imagenes_OutputFcn, ...
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


% --- Executes just before cargar_imagenes is made visible.
function cargar_imagenes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cargar_imagenes (see VARARGIN)

% Choose default command line output for cargar_imagenes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cargar_imagenes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cargar_imagenes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Carga_img.
function Carga_img_Callback(hObject, eventdata, handles)
system('Pscp -pw raspberry pi@192.168.0.2:/home/pi/webcam/*.png C:\Users\juancamilo\Desktop\img_trampa\');
lee_archivos = dir('C:\Users\juancamilo\Desktop\img_trampa\*.png'); %el formato de imagen puede ser modificado.
for k = 1:length(lee_archivos) %recorre número de archivos guardados en el directorio
 c{k} = [lee_archivos(k).name,'--- ', lee_archivos(k).date];
 end
set(handles.Imagenes,'string',c);
% hObject    handle to Carga_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Imagenes.
function Imagenes_Callback(hObject, eventdata, handles)
% hObject    handle to Imagenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Imagenes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Imagenes


% --- Executes during object creation, after setting all properties.
function Imagenes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Imagenes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
