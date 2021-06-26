function varargout = Responsi2SAWGui(varargin)
% RESPONSI2SAWGUI MATLAB code for Responsi2SAWGui.fig
%      RESPONSI2SAWGUI, by itself, creates a new RESPONSI2SAWGUI or raises the existing
%      singleton*.
%
%      H = RESPONSI2SAWGUI returns the handle to a new RESPONSI2SAWGUI or the handle to
%      the existing singleton*.
%
%      RESPONSI2SAWGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI2SAWGUI.M with the given input arguments.
%
%      RESPONSI2SAWGUI('Property','Value',...) creates a new RESPONSI2SAWGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi2SAWGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi2SAWGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi2SAWGui

% Last Modified by GUIDE v2.5 25-Jun-2021 21:55:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi2SAWGui_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi2SAWGui_OutputFcn, ...
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


% --- Executes just before Responsi2SAWGui is made visible.
function Responsi2SAWGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi2SAWGui (see VARARGIN)

% Choose default command line output for Responsi2SAWGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi2SAWGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi2SAWGui_OutputFcn(hObject, eventdata, handles) 
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



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx'); %Mengambil File DATA RUMAH.xlsx
opts.SelectedVariableNames = ([1]); %Mengambil Kolom Pertama (No 1)
data1 = readtable('DATA RUMAH.xlsx', opts); Menyimpan %Kolom Pertama pada Data Rumah.xlsx sebagai Table dan disimpan pada Variabel Data 1
opts = detectImportOptions('DATA RUMAH.xlsx'); 
opts.SelectedVariableNames = ([3:8]);  
data2 = readtable('DATA RUMAH.xlsx', opts); %Kolom ke-3 sampai ke-8 pada Data Rumah.xlsx sebagai Table dan disimpan pada Variabel Data 2
data = [data1 data2]; %Menggabungkan data 1 dan data 2 menjadi 1 variabel dan disimpan pada variabel Data
data = table2cell(data); %Mengkonvert Table ke Cell Array
set (handles.uitable5,'data',data); %Menampilkan Variabel data pada elemen dengan tag uitable5 pada GUI

opts = detectImportOptions('DATA RUMAH.xlsx'); %Mengambil File DATA RUMAH.xlsx
opts.SelectedVariableNames = ([3:8]);  %Mengambil Kolom ke-3 sampai ke-8
data2 = readmatrix('DATA RUMAH.xlsx', opts); %Kolom ke-3 sampai ke-8 pada Data Rumah.xlsx sebagai Matrix dan disimpan pada Variabel Data 2

k=[0,1,1,1,1,1]; %Mendeklarasikan Keuntungan di setiap atribute
bobot=[0.3,0.2,0.23,0.1,0.07,0.1]; %Mendeklarasikan Bobot

% Tahapan Pertama yaitu normalisasi matriks
[m n]=size (data2); % Matriks m x n dengan ukuran sebanyak variabel data2
R=zeros (m,n); % Membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); % Membuat matriks Y, yang merupakan titik kosong

for j=1:n,
 if k(j)==1, % Statement untuk kriteria dengan atribut keuntungan
  R(:,j)=data2(:,j)./max(data2(:,j));
 else
  R(:,j)=min(data2(:,j))./data2(:,j);
 end;
end;

% Tahapan kedua yaitu proses perangkingan dengan bantuan perulangan
for i=1:m,
 alternatif(i)= sum(bobot.*R(i,:))
end;


alternatifTranspose = alternatif.'; % Tranpose matrix alternatif dari horizontal menjadi vertikal 
Ranks = num2cell(alternatifTranspose); %Convert array to cell array
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = ([2:3]);% Memilih kolom 2-3
rangking = readtable('DATA RUMAH.xlsx', opts);
rangking = table2cell(rangking);
rangking = [rangking Ranks];
rangking = sortrows(rangking,-3);% Melakukan sorting data berdasarkan kolom 3
rank = rangking(1:20,1:2);% Mengambil peringkat 1-20 dan disimpan pada variabel rank
set(handles.uitable4,'Data', rank); % Menampilkan variabel rank pada uitable4




% --- Executes when entered data in editable cell(s) in uitable5.
function uitable5_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable5 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
