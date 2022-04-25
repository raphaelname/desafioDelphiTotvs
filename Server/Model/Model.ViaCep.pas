unit Model.ViaCep;

interface

type
  /// <summary>
  ///   Classe que representa o JSON retornado pela api do ViaCep
  /// </summary>
  TViaCep = class
    fCep: string;
    fLogradouro: string;
    fComplemento: string;
    fBairro: string;
    fLocalidade: string;
    fUf: string;
    fIbge: Integer;
    fGia: string;
    fDdd: Integer;
    fSiafi: Integer;
  private
    procedure SetBairro(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetDdd(const Value: Integer);
    procedure SetGia(const Value: string);
    procedure SetIbge(const Value: Integer);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetSiafi(const Value: Integer);
    procedure SetUf(const Value: string);

  public
    property cep: string read fCep write SetCep;
    property logradouro: string read fLogradouro write SetLogradouro;
    property complemento: string read fComplemento write SetComplemento;
    property bairro: string read fBairro write SetBairro;
    property localidade: string read fLocalidade write SetLocalidade;
    property uf: string read fUf write SetUf;
    property ibge: Integer read fIbge write SetIbge;
    property gia: string read fGia write SetGia;
    property ddd: Integer read fDdd write SetDdd;
    property siafi: Integer read fSiafi write SetSiafi;

    /// <summary>
    ///   Converte instancia da classe TViaCep para JSON no formato de texto
    /// </summary>
    /// <returns>
    ///   Retorna objeto JSON no formato de texto.
    /// </returns>
    function ToJSONString(): string;
    /// <summary>
    ///  Instancia objeto da classe TViaCep com dados de JSON no formato de texto.
    /// </summary>
    /// <param name="JSONString">
    ///   JSON contendo dados da classe TViaCep no formato de texto.
    /// </param>
    /// <returns>
    ///   Retorna instancia da classe TViaCep.
    /// </returns>
    class function FromJSONString(const JSONString: string): TViaCep;

  end;

implementation

uses REST.Json;

{ TViaCep }

class function TViaCep.FromJSONString(const JSONString: string): TViaCep;
begin
   Result := TJson.JsonToObject<TViaCep>(JSONString);
end;

procedure TViaCep.SetBairro(const Value: string);
begin
  fBairro := Value;
end;

procedure TViaCep.SetCep(const Value: string);
begin
  fCep := Value;
end;

procedure TViaCep.SetComplemento(const Value: string);
begin
  fComplemento := Value;
end;

procedure TViaCep.SetDdd(const Value: Integer);
begin
  fDdd := Value;
end;

procedure TViaCep.SetGia(const Value: string);
begin
  fGia := Value;
end;

procedure TViaCep.SetIbge(const Value: Integer);
begin
  fIbge := Value;
end;

procedure TViaCep.SetLocalidade(const Value: string);
begin
  fLocalidade := Value;
end;

procedure TViaCep.SetLogradouro(const Value: string);
begin
  fLogradouro := Value;
end;

procedure TViaCep.SetSiafi(const Value: Integer);
begin
  fSiafi := Value;
end;

procedure TViaCep.SetUf(const Value: string);
begin
  fUf := Value;
end;

function TViaCep.ToJSONString(): string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.
