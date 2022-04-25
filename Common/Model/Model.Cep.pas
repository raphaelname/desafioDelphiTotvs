unit Model.Cep;

interface

type
  /// <summary>
  ///   Classe que representa o JSON utilizado pela api Horse para comunicacao entre client/server
  /// </summary>
  TCep = class
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
    fOrigem: string;
    fUrl: string;
  private
    procedure SetBairro(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetDdd(const Value: Integer);
    procedure SetGia(const Value: string);
    procedure SetIbge(const Value: Integer);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetOrigem(const Value: string);
    procedure SetSiafi(const Value: Integer);
    procedure SetUrl(const Value: string);
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
    property origem: string read fOrigem write SetOrigem;
    property url: string read fUrl write SetUrl;

    /// <summary>
    ///   Converte instancia da classe TCep para JSON no formato de texto
    /// </summary>
    /// <returns>
    ///   Retorna objeto JSON no formato de texto.
    /// </returns>
    function ToJSONString(): string;
    /// <summary>
    ///  Instancia objeto da classe TCep com dados de JSON no formato de texto.
    /// </summary>
    /// <param name="JSONString">
    ///   JSON contendo dados da classe TCep no formato de texto.
    /// </param>
    /// <returns>
    ///   Retorna instancia da classe TCep.
    /// </returns>
    class function FromJSONString(const JSONString: string): TCep;

  end;

implementation

uses RESt.Json;

{ TCep }

class function TCep.FromJSONString(const JSONString: string): TCep;
begin
   Result := TJson.JsonToObject<TCep>(JSONString);
end;

procedure TCep.SetBairro(const Value: string);
begin
  fBairro := Value;
end;

procedure TCep.SetCep(const Value: string);
begin
  fCep := Value;
end;


procedure TCep.SetComplemento(const Value: string);
begin
  fComplemento := Value;
end;

procedure TCep.SetDdd(const Value: Integer);
begin
  fDdd := Value;
end;

procedure TCep.SetGia(const Value: string);
begin
  fGia := Value;
end;

procedure TCep.SetIbge(const Value: Integer);
begin
  fIbge := Value;
end;

procedure TCep.SetLocalidade(const Value: string);
begin
  fLocalidade := Value;
end;

procedure TCep.SetLogradouro(const Value: string);
begin
  fLogradouro := Value;
end;

procedure TCep.SetOrigem(const Value: string);
begin
  fOrigem := Value;
end;

procedure TCep.SetSiafi(const Value: Integer);
begin
  fSiafi := Value;
end;

procedure TCep.SetUf(const Value: string);
begin
  fUf := Value;
end;

procedure TCep.SetUrl(const Value: string);
begin
  fUrl := Value;
end;

function TCep.ToJSONString(): string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.
