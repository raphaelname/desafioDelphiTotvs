unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  Model.Cep;

type
  TFormMain = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    gbxPesquisa: TGroupBox;
    GroupBox1: TGroupBox;
    ledtLogradouro: TLabeledEdit;
    ledtBairro: TLabeledEdit;
    ledtCidade: TLabeledEdit;
    ledtUF: TLabeledEdit;
    ledtIBGE: TLabeledEdit;
    ledtDDD: TLabeledEdit;
    ledtOrigem: TLabeledEdit;
    ledtURL: TLabeledEdit;
    medtCEP: TMaskEdit;
    Button1: TButton;
    procedure sbtnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetCEP();

    /// <summary>
    ///   Limpa os campos do formulário
    /// </summary>
    procedure LimparCampos();

    /// <summary>
    ///   Preenche os campos do formulário a apartir do objeto TCep passado como parâmetro
    /// </summary>
    /// <param name="cep">
    ///   Objeto que representa o JSON retornado pela api Horse de consulta de cep
    /// </param>
    procedure PreencherCampos(cep: TCep);

    /// <summary>
    ///   Chama rotina PreencherCampos caso o retorno da chamada da api seja 200. Caoso contrario, exibe mensagem de erro
    /// </summary>
    procedure ProcessarGetCep();

    /// <summary>
    ///   Exibe mensagem de erro caso ocorra algum erro não tratado na chamada da api Horse
    /// </summary>
    procedure ProcessarGetCepErro(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses DataModule.Main, System.UITypes;

procedure TFormMain.GetCEP();
begin
  LimparCampos();

  try
    dmmain.RESTRequest.Params.ParameterByName('CEP').value := medtCEP.Text;

    dmMain.RESTRequest.ExecuteAsync(ProcessarGetCep, true, true, ProcessarGetCepErro);
  except
    on e: Exception do
    begin
      MessageDlg('Erro ao acessar o servidor: ' + e.Message, TMsgDlgType.mtError, [mbOk], 0, mbOk);
    end;

  end;
end;

procedure TFormMain.LimparCampos();
begin
  ledtLogradouro.Clear();
  ledtBairro.Clear();
  ledtCidade.Clear();
  ledtUF.Clear();
  ledtIBGE.Clear();
  ledtDDD.Clear();
  ledtOrigem.Clear();
  ledtURL.Clear();
end;

procedure TFormMain.PreencherCampos(cep: TCep);
begin
  ledtLogradouro.Text := cep.logradouro;
  ledtBairro.Text     := cep.bairro;
  ledtCidade.Text     := cep.localidade;
  ledtUF.Text         := cep.uf;
  ledtIBGE.Text       := cep.ibge.ToString();
  ledtDDD.Text        := cep.ddd.ToString();
  ledtOrigem.Text     := cep.origem;
  ledtURL.Text        := cep.url;

  medtCEP.SetFocus();
end;

procedure TFormMain.ProcessarGetCep();
var
  cep: TCep;
begin
  if (dmMain.RESTRequest.Response.StatusCode = 200) then
  begin
    cep := tCep.FromJSONString(dmMain.RESTRequest.Response.Content);
    PreencherCampos(cep);
  end
  else
  begin
    MessageDlg(dmMain.RESTRequest.Response.Content, TMsgDlgType.mtError, [mbOk], 0, mbOk);
  end;
end;

procedure TFormMain.ProcessarGetCepErro(Sender: TObject);
begin
  if Assigned(Sender) and (Sender is Exception) then
  begin
    MessageDlg(Exception(Sender).Message, TMsgDlgType.mtError, [mbOk], 0, mbOk);
    medtCEP.SetFocus();
  end;
end;

procedure TFormMain.sbtnPesquisarClick(Sender: TObject);
begin
  if SameText(Trim(medtCEP.Text), EmptyStr) then
  begin
    MessageDlg('Por favor informe o CEP ', TMsgDlgType.mtError, [mbOk], 0, mbOk);
    medtCEP.SetFocus();
    Exit
  end;

  if Length(Trim(medtCEP.Text)) < 8 then
  begin
    if (MessageDlg('O CEP informado não está no formato correto. Deseja continuar?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrNo) then
    begin
      medtCEP.SetFocus();
      Exit
    end;
  end;

  GetCEP();
end;

end.
