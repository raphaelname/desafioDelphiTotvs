unit Controller.CEP;

interface

uses Horse, System.JSON, System.SysUtils, Model.Cep, REST.Json, REST.Types, REST.Client;

type
  TControllerCep = class
  private
    restClient  : TRestClient;
    restRequest : TRESTRequest;

    procedure PrepararRequest(index: Integer; request: THorseRequest);

    function IsValidResponse(index: Integer; content: string): boolean;

    function ParseResponseToCep(index: Integer; content: string): TCep;
  public
    constructor Create(); overload;
    destructor Destroy(); override;

    /// <summary>
    ///   Registra as rotas da api
    /// </summary>
    procedure Registry();

    procedure ConsultarCep(request: THorseRequest; response: THorseResponse; next: TProc);
  end;

var
  ControllerCep: TControllerCep;

implementation

uses Data.Bind.Components, Data.Bind.ObjectScope, System.MaskUtils, Model.ViaCep, Model.ApiCep, Model.AwesomeCep;

const
  webServices: array [1..3] of string = (
    'ViaCep',
    'ApiCep',
    'AwesomeApi'
  );

  baseUrlWebServices: array [1..3] of string = (
    'http://viacep.com.br',
    'https://ws.apicep.com',
    'https://cep.awesomeapi.com.br'
  );

  resourceWebService: array [1..3] of string = (
    '/ws/{cep}/json',
    '/cep/{cep}.json',
    '/json/{cep}'
  );

  formatarCepWebService: array [1..3] of boolean = (
    false,
    true,
    false
  );

constructor TControllerCep.Create();
begin
  restClient   := TRestClient.Create(nil);
  restRequest  := TRESTRequest.Create(nil);

  restRequest.Client   := restClient;
end;

destructor TControllerCep.Destroy;
begin
  if Assigned(restRequest) then
    FreeAndNil(restRequest);

  if Assigned(restClient) then
    FreeAndNil(restClient);

  inherited;
end;


function TControllerCep.IsValidResponse(index: Integer; content: string): boolean;
var
  cep: TJSONObject;
  isValid: boolean;
begin
  isValid := true;

  cep := TJSONObject.ParseJSONValue(content) AS TJSONObject;

  case index of
    1:
    begin
      isValid := (not cep.GetValue<boolean>('erro', false));
    end;

    2:
    begin
      isValid := (cep.GetValue<boolean>('ok', false));
    end;

    3:
    begin
      isValid := (not SameText(cep.GetValue<string>('code', EmptyStr), 'not_found'));
    end;

  end;

  Result := isValid;
end;

function TControllerCep.ParseResponseToCep(index: Integer; content: string): TCep;
var
  viaCep: TViaCep;
  apiCep: TApiCep;
  awesomeCep: TAwesomeCep;
begin
  Result := TCep.Create();

  Result.origem := webServices[index];
  Result.url    := baseUrlwebServices[index];

  case index of
    1:
    begin
      viaCep := TViaCep.FromJSONString(content);

      Result.cep         := viaCep.cep;
      Result.logradouro  := viaCep.logradouro;
      Result.complemento := viaCep.complemento;
      Result.bairro      := viaCep.bairro;
      Result.localidade  := viaCep.localidade;
      Result.uf          := viaCep.uf;
      Result.ibge        := viaCep.ibge;
      Result.gia         := viaCep.gia;
      Result.ddd         := viaCep.ddd;
      Result.siafi       := viaCep.siafi;
    end;

    2:
    begin
      apiCep := TApiCep.FromJSONString(content);

      Result.cep         := apiCep.code;
      Result.logradouro  := apiCep.address;
      Result.bairro      := apiCep.district;
      Result.localidade  := apiCep.city;
      Result.uf          := apiCep.state;
    end;

    3:
    begin
      awesomeCep := TAwesomeCep.FromJSONString(content);

      Result.cep         := awesomeCep.cep;
      Result.logradouro  := awesomeCep.address;
      Result.bairro      := awesomeCep.district;
      Result.localidade  := awesomeCep.city;
      Result.uf          := awesomeCep.state;
      Result.ibge        := awesomeCep.city_ibge;
      Result.ddd         := awesomeCep.ddd;
    end;

  end;
end;

procedure TControllerCep.PrepararRequest(index: Integer; request: THorseRequest);
var
  cepFormatado: string;
begin
  restClient.BaseUrl := baseUrlWebServices[index];
  restClient.RaiseExceptionOn500 := true;

  restRequest.Resource := resourceWebService[index];
  restRequest.Method   := TRESTRequestMethod.rmGET;

  restRequest.Params.Clear;
  restRequest.Params.AddItem('cep', 'self', TRESTRequestParameterKind.pkURLSEGMENT);

  if (formatarCepWebService[Index]) then
  begin
    cepFormatado := FormatMaskText('00000\-000;0;', request.Params['cep']);
    restRequest.params.ParameterByName('CEP').value := cepFormatado;
  end
  else
  begin
    restRequest.params.ParameterByName('CEP').value := request.Params['cep'];
  end;
end;

procedure TControllerCep.ConsultarCep(request: THorseRequest; response: THorseResponse; next: TProc);
var
  index: Integer;
  cep: TCep;
  cepJson: string;
  cepNaoEncontrado: Boolean;
  servicosIndisponiveis: Boolean;
begin
  cepJson := EmptyStr;
  cepNaoEncontrado := false;
  servicosIndisponiveis := false;

  try
    for index := 1 to Length(webServices) do
    begin
      PrepararRequest(index, request);

      try
        restRequest.Execute();

        servicosIndisponiveis := false;
      except
        on E:Exception do
        begin
          servicosIndisponiveis := true;

          Continue;
        end;
      end;

      if (restRequest.Response.StatusCode = 200) and (IsValidResponse(index, restRequest.Response.JSONValue.ToString())) then
      begin
        cep := ParseResponseToCep(index, restRequest.Response.content);

        cepJson :=  cep.ToJSONString();

        cepNaoEncontrado := false;

        Break;
      end
      else
      begin
        cepNaoEncontrado := true;
      end;
    end;
  finally
    if (cepNaoEncontrado) then
    begin
      response.Status(THTTPStatus.NotFound);
      response.Send('O CEP ' + FormatMaskText('00000\-000;0;', request.Params['cep']) + ' não foi encontrado');
    end
    else if (servicosIndisponiveis) then
    begin
      response.Status(THTTPStatus.ServiceUnavailable);
      response.Send('Não foi possível consultar o CEP informado. Tente novamente em alguns instantes');
    end
    else
    begin
      response.ContentType('application/json');
      response.Status(THTTPStatus.OK);
      response.Send(System.UTF8Encode(cepJson));
    end;
  end;
end;

procedure TControllerCep.Registry();
begin
  THorse.Get('/ConsultaCep/:cep', ConsultarCep);
end;

end.
