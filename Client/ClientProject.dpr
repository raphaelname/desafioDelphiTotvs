program ClientProject;

uses
  Vcl.Forms,
  Form.Main in 'Form\Form.Main.pas' {FormMain},
  DataModule.Main in 'DataModule\DataModule.Main.pas' {dmMain: TDataModule},
  Model.Cep in '..\Common\Model\Model.Cep.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.
