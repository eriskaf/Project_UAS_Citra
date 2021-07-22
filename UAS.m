function varargout = UAS(varargin)
% UAS MATLAB code for UAS.fig
%      UAS, by itself, creates a new UAS or raises the existing
%      singleton*.
%
%      H = UAS returns the handle to a new UAS or the handle to
%      the existing singleton*.
%
%      UAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UAS.M with the given input arguments.
%
%      UAS('Property','Value',...) creates a new UAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UAS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UAS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UAS

% Last Modified by GUIDE v2.5 22-Jul-2021 01:26:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UAS_OpeningFcn, ...
                   'gui_OutputFcn',  @UAS_OutputFcn, ...
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


% --- Executes just before UAS is made visible.
function UAS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UAS (see VARARGIN)

% Choose default command line output for UAS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UAS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UAS_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile({'*.jpg','*.png'});
Img = imread([pathname, filename]);
gray = rgb2gray(Img);

%menampilkan di axes_citra_asli
axes(handles.axes1);
imshow(gray);

axes(handles.axes5);
imhist(gray);


kernel1=[-1 -1 -1; -1 8 -1; -1 -1 -1];
kernel2=[ 0 -1 0; -1 5 -1; 0 -1 0];
kernel3=[ 1 -2 1; -2 5 -2; 1 -2 1];
kernel4=[ 0 -1/4 0; -1/4 2 -1/4; 0 -1/4 0];

J1=uint8(conv2(double(gray),kernel1,'same'));
J2=uint8(conv2(double(gray),kernel2,'same'));
J3=uint8(conv2(double(gray),kernel3,'same'));
J4=uint8(conv2(double(gray),kernel4,'same'));

axes(handles.axes2);
imshow(J1);

axes(handles.axes3);
imshow(J2);

axes(handles.axes4);
imshow(J3);

axes(handles.axes9);
imshow(J4);

[baris,kolom] = size(gray);
%pengukuran MSE dan PNSR J1
MSE1 = sum(sum((gray-J1).^2))/(baris*kolom);
PNSR1 = 10*log10((256*256)/(MSE1));

set(handles.edit9,'String',num2str(MSE1))
set(handles.edit10,'String',num2str(PNSR1))

%%pengukuran MSE dan PNSR J2
MSE2 = sum(sum((gray-J2).^2))/(baris*kolom);
PNSR2 = 10*log10((256*256)/(MSE2));

set(handles.edit11,'String',num2str(MSE2))
set(handles.edit12,'String',num2str(PNSR2))


%%pengukuran MSE dan PNSR J3
MSE3 = sum(sum((gray-J3).^2))/(baris*kolom);
PNSR3 = 10*log10((256*256)/(MSE3));

set(handles.edit13,'String',num2str(MSE3))
set(handles.edit14,'String',num2str(PNSR3))


%%pengukuran MSE dan PNSR J4
MSE4 = sum(sum((gray-J4).^2))/(baris*kolom);
PNSR4 = 10*log10((256*256)/(MSE4));

set(handles.edit15,'String',num2str(MSE4))
set(handles.edit16,'String',num2str(PNSR4))

axes(handles.axes6);
imhist(J1);

axes(handles.axes7);
imhist(J2);

axes(handles.axes8);
imhist(J3);

axes(handles.axes10);
imhist(J4);

