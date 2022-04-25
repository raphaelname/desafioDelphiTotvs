unit Model.ApiCep;

interface

type
  /// <summary>
  ///   Classe que representa o JSON retornado pela api do ApiCep
  /// </summary>
  TApiCep = class
    fCode: string;
    fAddress: string;
    fDistrict: string;
    fCity: string;
    fState: string;
    fStatus: Integer;
    fOK: boolean;
    fStatusText: string;

  private
    procedure SetAddress(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetCode(const Value: string);
    procedure SetDistrict(const Value: string);
    procedure SetOK(const Value: boolean);
    procedure SetState(const Value: string);
    procedure SetStatus(const Value: Integer);
    procedure SetStatusText(const Value: string);

  public
    property code: string read fCode write SetCode;
    property address: string read fAddress write SetAddress;
    property district: string read fDistrict write SetDistrict;
    property city: string read fCity write SetCity;
    property state: string read fState write SetState;
    property status: Integer read fStatus write SetStatus;
    property ok: boolean read fOK write SetOK;
    property statusText: string read fStatusText write SetStatusText;

    /// <summary>
    ///   Converte instancia da classe TApiCep para JSON no formato de texto
    /// </summary>
    /// <returns>
    ///   Retorna objeto JSON no formato de texto.
    /// </returns>
    function ToJSONString(): string;
    /// <summary>
    ///  Instancia objeto da classe TApiCep com dados de JSON no formato de texto.
    /// </summary>
    /// <param name="JSONString">
    ///   JSON contendo dados da classe TApiCep no formato de texto.
    /// </param>
    /// <returns>
    ///   Retorna instancia da classe TApiCep.
    /// </returns>
    class function FromJSONString(const JSONString: string): TApiCep;
  end;

implementation

uses REST.Json;

{ TApiCep }

class function TApiCep.FromJSONString(const JSONString: string): TApiCep;
begin
   Result := TJson.JsonToObject<TApiCep>(JSONString);
end;

procedure TApiCep.SetAddress(const Value: string);
begin
  fAddress := Value;
end;

procedure TApiCep.SetCity(const Value: string);
begin
  fCity := Value;
end;

procedure TApiCep.SetCode(const Value: string);
begin
  fCode := Value;
end;

procedure TApiCep.SetDistrict(const Value: string);
begin
  fDistrict := Value;
end;

procedure TApiCep.SetOK(const Value: boolean);
begin
  fOK := Value;
end;

procedure TApiCep.SetState(const Value: string);
begin
  fState := Value;
end;

procedure TApiCep.SetStatus(const Value: Integer);
begin
  fStatus := Value;
end;

procedure TApiCep.SetStatusText(const Value: string);
begin
  fStatusText := Value;
end;

function TApiCep.ToJSONString(): string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.
