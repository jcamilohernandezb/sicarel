function varargout = aplicaion(varargin)
% APLICAION MATLAB code for aplicaion.fig
%      APLICAION, by itself, creates a new APLICAION or raises the existing
%      singleton*.
%
%      H = APLICAION returns the handle to a new APLICAION or the handle to
%      the existing singleton*.
%
%      APLICAION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLICAION.M with the given input arguments.
%
%      APLICAION('Property','Value',...) creates a new APLICAION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aplicaion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aplicaion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aplicaion

% Last Modified by GUIDE v2.5 24-Sep-2018 19:26:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aplicaion_OpeningFcn, ...
                   'gui_OutputFcn',  @aplicaion_OutputFcn, ...
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


% --- Executes just before aplicaion is made visible.
function aplicaion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aplicaion (see VARARGIN)

% Choose default command line output for aplicaion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aplicaion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aplicaion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in prueba.
function prueba_Callback(hObject, eventdata, handles)
prueba = []; 
prueba2 = [];
prueba3 = [];

[nombre dire] = uigetfile( '*.png','abrir')
if nombre == 0
    return
end

imagen = imread (fullfile(dire,nombre));
axes(handles.axes3) 
image(imagen)

red = imagen(:,:,1);
axes(handles.axes4)
image(red,'CDataMapping','scaled')

verde = imagen(:,:,2);
axes(handles.axes5)
image(verde,'CDataMapping','scaled')

azul = imagen(:,:,3);
axes(handles.axes6)
image(azul,'CDataMapping','scaled')

%leer imagen sacar matriz roja sumar y dividir columnas y filas 
red = imagen(:,:,1);
c = sum(red);
f = sum(red');
colum = floor(c/600);
fila = floor(f/600);
vector =[fila,colum];
prueba = [prueba;vector];

green = imagen(:,:,2);
c2 = sum(green);
f2 = sum(green');
colum2 = floor(c2/600);
fila2 = floor(f2/600);
vector2 =[fila2,colum2];
prueba2 = [prueba2;vector2];

blue = imagen(:,:,3);
c3 = sum(blue);
f3 = sum(blue');
colum3 = floor(c3/600);
fila3 = floor(f3/600);
vector3 =[fila3,colum3];
prueba3 = [prueba3;vector3];

global datasetPrueba

pruebas =  horzcat(prueba,prueba2,prueba3);
datasetPrueba = pruebas';

% hObject    handle to prueba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in salida.
function salida_Callback(hObject, eventdata, handles)
global W1
global W2
global b1
global b2
global datasetPrueba
global a


for q = 1:20
     a2(q) = tansig(W2*tansig(W1*datasetPrueba(:,q) + b1)+ b2);
if a ~= a2
   vacio=' ';
   set(handles.resultado,'string',(a2(1)));
   mjs = ['¡¡Mariposa no reconicida!!']; 
   set(handles.strreino,'string',mjs);
    set(handles.strdivicion,'string',vacio);
    set(handles.strclase,'string',vacio);
    set(handles.strsuperfamilia,'string',vacio);
    set(handles.strfamilia,'string',vacio);
    set(handles.strsubfamilia,'string',vacio);
    set(handles.strgenero,'string',vacio);
    set(handles.strespecie,'string',vacio);
else
    if a2>0
        set(handles.resultado,'string',(a2(1)));
    reino='Reino: Animalia';
    divicion='División: Arthropoda';
    clase='Clase: Insecta';
    superfamilia='Superfamilia: Papilionoidea';
    familia='Familia: Nymphalidae';
    subfamilia='Subfamilia: Danainae';
    genero='Género: Danaus';
    especie='Especie: D. plexippus';
    %info = [reino;divicion;clase;superfamilia;familia;subfamila;genero;especie];
    %mjs1 = [info]; 
    set(handles.strreino,'string',reino);
    set(handles.strdivicion,'string',divicion);
    set(handles.strclase,'string',clase);
    set(handles.strsuperfamilia,'string',superfamilia);
    set(handles.strfamilia,'string',familia);
    set(handles.strsubfamilia,'string',subfamilia);
    set(handles.strgenero,'string',genero);
    set(handles.strespecie,'string',especie);
    else
        reino='Reino Animalia';
    divicion='rama: Artrópodos';
    clase='Clase: Insecta';
    superfamilia='Orden: Lepidópteros';
    familia='Familia: nymphalidae';
    subfamilia='Subfamilia: Satyrinae';
    genero='Género: cepheuptychia';
    especie='Especie: Euptychia cephus';
    %info = [reino;divicion;clase;superfamilia;familia;subfamila;genero;especie];
    %mjs1 = [info]; 
    set(handles.strreino,'string',reino);
    set(handles.strdivicion,'string',divicion);
    set(handles.strclase,'string',clase);
    set(handles.strsuperfamilia,'string',superfamilia);
    set(handles.strfamilia,'string',familia);
    set(handles.strsubfamilia,'string',subfamilia);
    set(handles.strgenero,'string',genero);
    set(handles.strespecie,'string',especie);   
    end
end
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
prueba = []; 
prueba2 = [];
prueba3 = [];

[nombre dire] = uigetfile( '*.png','abrir')
if nombre == 0
    return
end

imagen = imread (fullfile(dire,nombre));
axes(handles.axes1) 
image(imagen)

red = imagen(:,:,1);
axes(handles.axes2)
image(red,'CDataMapping','scaled')

verde = imagen(:,:,2);
axes(handles.axes3)
image(verde,'CDataMapping','scaled')

azul = imagen(:,:,3);
axes(handles.axes4)
image(azul,'CDataMapping','scaled')

%leer imagen sacar matriz roja sumar y dividir columnas y filas 
red = imagen(:,:,1);
c = sum(red);
f = sum(red');
colum = floor(c/600);
fila = floor(f/600);
vector =[fila,colum];
prueba = [prueba;vector];

green = imagen(:,:,2);
c2 = sum(green);
f2 = sum(green');
colum2 = floor(c2/600);
fila2 = floor(f2/600);
vector2 =[fila2,colum2];
prueba2 = [prueba2;vector2];

blue = imagen(:,:,3);
c3 = sum(blue);
f3 = sum(blue');
colum3 = floor(c3/600);
fila3 = floor(f3/600);
vector3 =[fila3,colum3];
prueba3 = [prueba3;vector3];

global datasetPrueba

pruebas =  horzcat(prueba,prueba2,prueba3);
datasetPrueba = pruebas';
W1=xlsread('matricesRGB1.xlsx','Hoja3')
disp(W1)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global W1
global W2
global b1
global b2
global datasetPrueba
global a


for q = 1:20
     a2(q) = tansig(W2*tansig(W1*datasetPrueba(:,q) + b1)+ b2);
if a ~= a2
   vacio=' ';
   set(handles.resultado,'string',(a2(1)));
   mjs = ['¡¡Mariposa no reconicida!!']; 
   set(handles.strreino,'string',mjs);
    set(handles.strdivicion,'string',vacio);
    set(handles.strclase,'string',vacio);
    set(handles.strsuperfamilia,'string',vacio);
    set(handles.strfamilia,'string',vacio);
    set(handles.strsubfamilia,'string',vacio);
    set(handles.strgenero,'string',vacio);
    set(handles.strespecie,'string',vacio);
else
    if a2>0
        set(handles.resultado,'string',(a2(1)));
    reino='Reino: Animalia';
    divicion='División: Arthropoda';
    clase='Clase: Insecta';
    superfamilia='Superfamilia: Papilionoidea';
    familia='Familia: Nymphalidae';
    subfamilia='Subfamilia: Danainae';
    genero='Género: Danaus';
    especie='Especie: D. plexippus';
    %info = [reino;divicion;clase;superfamilia;familia;subfamila;genero;especie];
    %mjs1 = [info]; 
    set(handles.strreino,'string',reino);
    set(handles.strdivicion,'string',divicion);
    set(handles.strclase,'string',clase);
    set(handles.strsuperfamilia,'string',superfamilia);
    set(handles.strfamilia,'string',familia);
    set(handles.strsubfamilia,'string',subfamilia);
    set(handles.strgenero,'string',genero);
    set(handles.strespecie,'string',especie);
    else
        reino='Reino Animalia';
    divicion='rama: Artrópodos';
    clase='Clase: Insecta';
    superfamilia='Orden: Lepidópteros';
    familia='Familia: nymphalidae';
    subfamilia='Subfamilia: Satyrinae';
    genero='Género: cepheuptychia';
    especie='Especie: Euptychia cephus';
    %info = [reino;divicion;clase;superfamilia;familia;subfamila;genero;especie];
    %mjs1 = [info]; 
    set(handles.strreino,'string',reino);
    set(handles.strdivicion,'string',divicion);
    set(handles.strclase,'string',clase);
    set(handles.strsuperfamilia,'string',superfamilia);
    set(handles.strfamilia,'string',familia);
    set(handles.strsubfamilia,'string',subfamilia);
    set(handles.strgenero,'string',genero);
    set(handles.strespecie,'string',especie);   
    end
end

end
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
