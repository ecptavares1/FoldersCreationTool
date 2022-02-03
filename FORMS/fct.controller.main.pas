unit fct.controller.main;

interface

Uses
  fct.Controller.Interfaces,System.sysUtils, Vcl.Dialogs,Registry, Vcl.Forms,  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg;

type
  TFolderClass = class(TInterfacedObject,iFolderInterface)
    private
      FRaiz : String;
      FProjectName : String;
    public
    constructor Create;
    destructor Destroy;override;
    class Function New : iFolderInterface;
    function LocalRaiz(Value : String) : iFolderInterface;
    function Exec : iFolderInterface;
    function EnsureShellFolderPopupItem(Value: String) : iFolderInterface;
    function ProjectName(Value : String) : iFolderInterface;
  end;

implementation

{ TFolderClass }

constructor TFolderClass.Create;
begin

end;

destructor TFolderClass.Destroy;
begin

  inherited;
end;

function TFolderClass.EnsureShellFolderPopupItem(
  Value: String): iFolderInterface;
begin
  Result := Self;
  With TRegistry.Create do
  Begin
    try
      RootKey := HKEY_CLASSES_ROOT;
      if openKey('Directory\Shell',true) then
        Begin
          if OpenKey(Value + '\command',true) then
            WriteString('','"' + Application.ExeName + '" "%1"');
        End;
    finally
      Free;
    end;
  End;
end;

function TFolderClass.Exec: iFolderInterface;
var
  Caminho : String;
begin
  if (FRaiz <> '') and (FProjectName <> '') then
  Begin
    Caminho := FRaiz + '\' + FProjectName;
    if (not DirectoryExists(Caminho + '\DCU')) and (not DirectoryExists(Caminho + '\CLASSEs')) and (not DirectoryExists(Caminho + '\EXE')) and (not DirectoryExists(Caminho + '\EXE\DADOS')) and (not DirectoryExists(Caminho + '\FORMs')) and (not DirectoryExists(Caminho + '\IMAGEs')) and (not DirectoryExists(Caminho + '\PROJETO')) then
     Begin
      ForceDirectories(Caminho + '\CLASSEs');
      ForceDirectories(Caminho + '\DCU');
      ForceDirectories(Caminho + '\EXE');
      ForceDirectories(Caminho + '\EXE\DADOS');
      ForceDirectories(Caminho + '\FORMs');
      ForceDirectories(Caminho + '\IMAGEs');
      ForceDirectories(Caminho + '\PROJETO');
      MessageDlg('Folders Created Successfully' + #13 + 'You need to setup your Delphi Project by going to Menu Project/Options under Delphi Compiler.Change the options OUTPUT DIRECTORY pointing it to EXE folder and UNIT OUTPUT DIRECTORY pointing it to DCU folder',mtWarning,[mbOk],0);
     End
     Else
     Begin
       MessageDlg('Folders have already been created.',mtWarning,[mbOk],0);
     End;
  End;
end;

function TFolderClass.LocalRaiz(Value: String): iFolderInterface;
begin
  Result := Self;
  FRaiz := Value;
end;

class function TFolderClass.New: iFolderInterface;
begin
    Result := Self.Create;
end;

function TFolderClass.ProjectName(Value: String): iFolderInterface;
begin
  Result := Self;
  FProjectName := Value;
end;

end.
