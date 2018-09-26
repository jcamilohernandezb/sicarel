function varargout = red_mariposas(varargin)
% RED_MARIPOSAS MATLAB code for red_mariposas.fig
%      RED_MARIPOSAS, by itself, creates a new RED_MARIPOSAS or raises the existing
%      singleton*.
%
%      H = RED_MARIPOSAS returns the handle to a new RED_MARIPOSAS or the handle to
%      the existing singleton*.
%
%      RED_MARIPOSAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RED_MARIPOSAS.M with the given input arguments.
%
%      RED_MARIPOSAS('Property','Value',...) creates a new RED_MARIPOSAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before red_mariposas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to red_mariposas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help red_mariposas

% Last Modified by GUIDE v2.5 21-Jun-2018 10:00:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @red_mariposas_OpeningFcn, ...
                   'gui_OutputFcn',  @red_mariposas_OutputFcn, ...
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


% --- Executes just before red_mariposas is made visible.
function red_mariposas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to red_mariposas (see VARARGIN)

% Choose default command line output for red_mariposas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes red_mariposas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = red_mariposas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in entrenar.
function entrenar_Callback(hObject, eventdata, handles)
tasaa = str2num(get(handles.tasaaprendizaje, 'String'));
errord = str2num(get(handles.errordeseado, 'String'));
momen = str2num(get(handles.momentum, 'String'));
Capcultas = str2num(get(handles.capaoculta, 'String'));
ejemplos = [];
ejemplos2 = [];
ejemplos3 = [];

global a;
for a=1:20
    file = 'mariposa_entrena';
    val = int2str(a);
    exten = '.png';
    ruta = strcat(file,val,exten);
    imagen = imread(ruta); 
    rojo = imagen(:,:,1);
    c = sum(rojo);
    f = sum(rojo');
    colum = floor(c/600);
    fila = floor(f/600);
    vector =[fila,colum];
    ejemplos = [ejemplos;vector];
end

for a=1:20
    file = 'mariposa_entrena';
    val = int2str(a);
    exten = '.png';
    ruta = strcat(file,val,exten);
    imagen = imread(ruta); 
    verde = imagen(:,:,2);
    c = sum(verde);
    f = sum(verde');
    colum = floor(c/600);
    fila = floor(f/600);
    vector =[fila,colum];
    ejemplos2 = [ejemplos2;vector];
end

for a=1:20
    file = 'mariposa_entrena';
    val = int2str(a);
    exten = '.png';
    ruta = strcat(file,val,exten);
    imagen = imread(ruta); 
    azul = imagen(:,:,3);
    c = sum(azul);
    f = sum(azul');
    colum = floor(c/600);
    fila = floor(f/600);
    vector =[fila,colum];
    ejemplos3 = [ejemplos3;vector];
end
global W1
global W2
global b1
global b2

entrenamientos =  horzcat(ejemplos,ejemplos2,ejemplos3);

dataset = entrenamientos';
T = [1 1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]; %valores esperados (donde a = -1 y e = 1)
Q=20; %variable auxiliar
 aux = 1;   % semilla para datos aleatorios
% Valores iniciales
W1 = aux*(2*rand(Capcultas,3600)-1); %creación de la matriz de pesos para entradas
b1 = aux*(2*rand(Capcultas,1)-1);  %creación del bias entradas 
W2 = aux*(2*rand(1,Capcultas)-1);  %creación de la matriz de pesos para capa oculta
b2 = aux*(2*rand-1);              %creación del bias capa oculta 

for k = 1:1000000000000
    su = 0;
    for q = 1:Q
        % Propagación de la entrada hacia la salida
        c1 = tansig(W1*dataset(:,q) + b1);%tansig 
        c2(q) = tansig(W2*c1 + b2);
        % Retropropagación del error
        e = T(q)-c2(q); %calculo del error
        e2 = -2*(1-c2(q)^2)*e; %calculo del error en capa 2
        e1 = diag(1-c1.^2)*W2'*e2; %calculo del error en capa 1
        % Actualización de pesos 
        W2 = W2 - tasaa*e2*c1'*momen;  % Actualización de los pesos de la segunda capa
        b2 = b2 - tasaa*e2; % Actualización de los pesos del bias de la segunda capa
        W1 = W1 - tasaa*e1*dataset(:,q)'*momen; % Actualización de los pesos de la primera capa
        b1 = b1 - tasaa*e1;  % Actualización del bias de la primera capa
        % Sumando el error cuadratico 
        su = e^2 + su;   
    end
    % Error cuadratico medio
    ErrorCuMedio(k) = su/Q;
    set(handles.erroroptenido,'string',ErrorCuMedio(k));
    L = length(ErrorCuMedio)
    set(handles.iteraciones,'string',L);
    pause(0.001);
    if ErrorCuMedio(k) <= errord
        break;
    end 
 end 

ErrorCuMedio(k)
L = length(ErrorCuMedio)
 
axes(handles.axes2)
plot(ErrorCuMedio)
xlswrite('matricesRGB1.xlsx',W1,'Hoja1','A1');
xlswrite('matricesRGB1.xlsx',W2,'Hoja2','A1');
xlswrite('matricesRGB1.xlsx',b1,'Hoja3','A1');
xlswrite('matricesRGB1.xlsx',b2,'Hoja4','A1');
%Confrontacion de la red entrenada vs dataset de prueba hacia adelante
   for q = 1:20
     a(q) = tansig(W2*tansig(W1*dataset(:,q) + b1)+ b2);
   end
   
%set(handles.NeuronasOcultas,'string',nOcultas);
set(handles.muestra1,'string',a(1));
set(handles.muestra2,'string',a(2));
set(handles.muestra3,'string',a(3));
set(handles.muestra4,'string',a(4));
set(handles.muestra5,'string',a(5));
set(handles.muestra6,'string',a(6));
set(handles.muestra7,'string',a(7));
set(handles.muestra8,'string',a(8));
set(handles.muestra9,'string',a(9));
set(handles.muestra10,'string',a(10));
set(handles.muestra11,'string',a(11));
set(handles.muestra12,'string',a(12));
set(handles.muestra13,'string',a(13));
set(handles.muestra14,'string',a(14));
set(handles.muestra15,'string',a(15));
set(handles.muestra16,'string',a(16));
set(handles.muestra17,'string',a(17));
set(handles.muestra18,'string',a(18));
set(handles.muestra19,'string',a(19));
set(handles.muestra20,'string',a(20));
set(handles.pesos2,'string',W2);
set(handles.pesos1,'string',num2str(W1));
% hObject    handle to entrenar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function tasaaprendizaje_Callback(hObject, eventdata, handles)
% hObject    handle to tasaaprendizaje (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tasaaprendizaje as text
%        str2double(get(hObject,'String')) returns contents of tasaaprendizaje as a double


% --- Executes during object creation, after setting all properties.
function tasaaprendizaje_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tasaaprendizaje (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function momentum_Callback(hObject, eventdata, handles)
% hObject    handle to momentum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of momentum as text
%        str2double(get(hObject,'String')) returns contents of momentum as a double


% --- Executes during object creation, after setting all properties.
function momentum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to momentum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function errordeseado_Callback(hObject, eventdata, handles)
% hObject    handle to errordeseado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of errordeseado as text
%        str2double(get(hObject,'String')) returns contents of errordeseado as a double


% --- Executes during object creation, after setting all properties.
function errordeseado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to errordeseado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function capaoculta_Callback(hObject, eventdata, handles)
% hObject    handle to capaoculta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of capaoculta as text
%        str2double(get(hObject,'String')) returns contents of capaoculta as a double


% --- Executes during object creation, after setting all properties.
function capaoculta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to capaoculta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pesos2.
function pesos2_Callback(hObject, eventdata, handles)
% hObject    handle to pesos2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pesos2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pesos2


% --- Executes during object creation, after setting all properties.
function pesos2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pesos2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pesos1.
function pesos1_Callback(hObject, eventdata, handles)
% hObject    handle to pesos1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pesos1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pesos1


% --- Executes during object creation, after setting all properties.
function pesos1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pesos1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
% hObject    handle to salida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
