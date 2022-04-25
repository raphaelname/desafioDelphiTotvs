unit Model.AwesomeCep;

interface

type
  /// <summary>
  ///   Classe que representa o JSON retornado pela api do AwesomeApi
  /// </summary>
  TAwesomeCep = class
    fCep: string;
    fAddress_Type: string;
    fAddress_Name: string;
    fAddress: string;
    fDistrinct: string;
    fCity: string;
    fState: string;
    fCity_Ibge: Integer;
    fDdd: Integer;
    fLat: string;
    fLng: string;

  private
    procedure SetAddress(const Value: string);
    procedure SetAddress_Name(const Value: string);
    procedure SetAddress_Type(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetCity_Ibge(const Value: Integer);
    procedure SetDdd(const Value: Integer);
    procedure SetDistrict(const Value: string);
    procedure SetLat(const Value: string);
    procedure SetLng(const Value: string);
    procedure SetState(const Value: string);

  public
    property cep: string read fCep write SetCep;
    property address_type: string read fAddress_type write SetAddress_Type;
    property address_name: string read fAddress_Name write SetAddress_Name;
    property address: string read fAddress write SetAddress;
    property district: string read fDistrinct write SetDistrict;
    property city: string read fCity write SetCity;
    property state: string read fState write SetState;
    property city_ibge: Integer read fCity_Ibge write SetCity_Ibge;
    property ddd: Integer read fDdd write SetDdd;
    property lat: string read fLat write SetLat;
    property lng: string read fLng write SetLng;

    /// <summary>
    ///   Converte instancia da classe TAwesomeCep para JSON no formato de texto
    /// </summary>
    /// <returns>
    ///   Retorna objeto JSON no formato de texto.
    /// </returns>
    function ToJSONString(): string;
    /// <summary>
    ///  Instancia objeto da classe TAwesomeCep com dados de JSON no formato de texto.
    /// </summary>
    /// <param name="JSONString">
    ///   JSON contendo dados da classe TAwesomeCep no formato de texto.
    /// </param>
    /// <returns>
    ///   Retorna instancia da classe TAwesomeCep.
    /// </returns>
    class function FromJSONString(const JSONString: string): TAwesomeCep;

  end;

implementation

uses REST.Json;

{ TAwesomeCep }

class function TAwesomeCep.FromJSONString(const JSONString: string): TAwesomeCep;
begin
   Result := TJson.JsonToObject<TAwesomeCep>(JSONString);
end;

procedure TAwesomeCep.SetAddress(const Value: string);
begin
  fAddress := Value;
end;

procedure TAwesomeCep.SetAddress_Name(const Value: string);
begin
  fAddress_Name := Value;
end;

procedure TAwesomeCep.SetAddress_Type(const Value: string);
begin
  fAddress_type := Value;
end;

procedure TAwesomeCep.SetCep(const Value: string);
begin
  fCep := Value;
end;

procedure TAwesomeCep.SetCity(const Value: string);
begin
  fCity := Value;
end;

procedure TAwesomeCep.SetCity_Ibge(const Value: Integer);
begin
  fCity_Ibge := Value;
end;

procedure TAwesomeCep.SetDdd(const Value: Integer);
begin
  fDdd := Value;
end;

procedure TAwesomeCep.SetDistrict(const Value: string);
begin
  fDistrinct := Value;
end;

procedure TAwesomeCep.SetLat(const Value: string);
begin
  fLat := Value;
end;

procedure TAwesomeCep.SetLng(const Value: string);
begin
  fLng := Value;
end;

procedure TAwesomeCep.SetState(const Value: string);
begin
  fState := Value;
end;

function TAwesomeCep.ToJSONString(): string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.
