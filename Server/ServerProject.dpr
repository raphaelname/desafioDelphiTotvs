program ServerProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.JSON,
  Controller.CEP in 'Controller\Controller.CEP.pas',
  Model.Cep in '..\Common\Model\Model.Cep.pas',
  Model.ViaCep in 'Model\Model.ViaCep.pas',
  Model.ApiCep in 'Model\Model.ApiCep.pas',
  Model.AwesomeCep in 'Model\Model.AwesomeCep.pas';

type
  TAPIError = class
  private
    Ferror: string;
  public
    property error: string read Ferror write Ferror;
  end;

var
  controllerCep: TControllerCep;

procedure RegistrarController();
begin
  controllerCep := TControllerCEP.Create();

  controllerCep.Registry();
end;

begin
  RegistrarController();

  THorse.Listen(9000);
end.
