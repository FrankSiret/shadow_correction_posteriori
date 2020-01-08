function varargout = ShadowCorreccion(varargin)
% SHADOWCORRECCION MATLAB code for ShadowCorreccion.fig
%      SHADOWCORRECCION, by itself, creates a new SHADOWCORRECCION or raises the existing
%      singleton*.
%
%      H = SHADOWCORRECCION returns the handle to a new SHADOWCORRECCION or the handle to
%      the existing singleton*.
%
%      SHADOWCORRECCION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHADOWCORRECCION.M with the given input arguments.
%
%      SHADOWCORRECCION('Property','Value',...) creates a new SHADOWCORRECCION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShadowCorreccion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShadowCorreccion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ShadowCorreccion

% Last Modified by GUIDE v2.5 12-Jul-2016 00:18:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ShadowCorreccion_OpeningFcn, ...
                   'gui_OutputFcn',  @ShadowCorreccion_OutputFcn, ...
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


% --- Executes just before ShadowCorreccion is made visible.
function ShadowCorreccion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShadowCorreccion (see VARARGIN)

% Choose default command line output for ShadowCorreccion
handles.output = hObject;
handles.indice_actual=1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ShadowCorreccion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ShadowCorreccion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.indice_actual < handles.cantidad_imagenes
    handles.indice_actual=handles.indice_actual+1;
else 
    handles.indice_actual=1;
end
mostrar_imagen(handles);
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.indice_actual > 1
    handles.indice_actual=handles.indice_actual-1;
else 
    handles.indice_actual=handles.cantidad_imagenes;
end
mostrar_imagen(handles);
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.radiobutton1,'value')==1
    LF([get(handles.text3, 'String') '/' handles.files(handles.indice_actual).name]);
elseif get(handles.radiobutton2,'value')==1
    HMF([get(handles.text3, 'String') '/' handles.files(handles.indice_actual).name]);
elseif get(handles.radiobutton3,'value')==1
    MFA([get(handles.text3, 'String') '/' handles.files(handles.indice_actual).name]);
elseif get(handles.radiobutton4,'value')==1
    MFM([get(handles.text3, 'String') '/' handles.files(handles.indice_actual).name]);
elseif get(handles.radiobutton5,'value')==1
    FA([get(handles.text3, 'String') '/' handles.files(handles.indice_actual).name]);
else 
    FM([get(handles.text3, 'String') '/' handles.files(handles.indice_actual).name]);
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Acerca_de;

% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup1,'Visible','off');
set(handles.text2,'Visible','off');
dir_db = uigetdir;

% Obtener las imagenes
filter = [dir_db];
set(handles.text3,'String',dir_db);
handles.files = dir(filter);
h=waitbar(0,'Cargando Imágenes');
i=1;   
while i <= length(handles.files)     
    try
        % Cargar imagen i desde pathName
        fileName = handles.files(i).name;
        img = im2double(imread([dir_db '/' fileName]));
        
    catch error
        handles.files(i)=[];
        continue;
    end        
    
    n=size(img,1);
    m=size(img,2);
    s = 450/max(n,m); 
    img = imresize(img,s);
    handles.imagenes{i}=img;
    i=i+1;
    waitbar(i/length(handles.files),h);
end    

set(h,'Visible','off');
handles.cantidad_imagenes = length(handles.files);
handles.indice_actual=1;
handles.factor_zoom=1;
handles.hFig = ShadowCorreccion();
handles.hIm = imshow(handles.imagenes{handles.indice_actual});
handles.hSP = imscrollpanel(handles.hFig,handles.hIm);
set(handles.hSP,'Units','pixels','Position',[17 75 450 450])
guidata(hObject, handles);
mostrar_imagen(handles);


% --------------------------------------------------------------------
function mostrar_imagen(handles)
I=handles.imagenes{handles.indice_actual};
set(handles.text4,'String',handles.files(handles.indice_actual).name);
api = iptgetapi(handles.hSP);
api.replaceImage(I);
api.setMagnificationAndCenter(handles.factor_zoom,225,225);


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup1,'Visible','off');
set(handles.text2,'Visible','off');
dir_db = uigetdir;

% Obtener las imagenes
filter = [dir_db];
set(handles.text3,'String',dir_db);
handles.files = dir(filter);
h=waitbar(0,'Cargando Imágenes');
i=1;
while i <= length(handles.files)     
    try
        % Cargar imagen i desde pathName
        fileName = handles.files(i).name;
        img = im2double(imread([dir_db '/' fileName]));
        
    catch error
        handles.files(i)=[];
        continue;
    end        
    
    n=size(img,1);
    m=size(img,2);
    s = 450/max(n,m); 
    img = imresize(img,s);
    handles.imagenes{i}=img;
    i=i+1;
    waitbar(i/length(handles.files),h);
end    

set(h,'Visible','off');
handles.cantidad_imagenes = length(handles.files);
handles.indice_actual=1;
handles.factor_zoom=1;
handles.hFig = ShadowCorreccion();
handles.hIm = imshow(handles.imagenes{handles.indice_actual});
handles.hSP = imscrollpanel(handles.hFig,handles.hIm);
set(handles.hSP,'Units','pixels','Position',[17 75 450 450])
guidata(hObject, handles);
mostrar_imagen(handles);
