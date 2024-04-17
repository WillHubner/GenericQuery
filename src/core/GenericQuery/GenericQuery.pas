unit GenericQuery;

interface

uses
  System.JSON,
  Data.DB,
  DataSetToJSON,
  Model.GenericQuery.Intf,
  DataSetConverter4D.Util,
  FireDAC.Comp.Client,
  GenericQuery.Model.Connection,
  System.Classes,
  FireDAC.Stan.Param;

type
  TGenericQuery = class(TInterfacedObject, iGenericQuery)
  private
    FIndexConnection : Integer;
    FQuery : TFDQuery;
    FSQL: TStringList;
    FCurrentParam : Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New : iGenericQuery;

    function SQL(vSQL : String) : iGenericQuery;
    function Params(aValue : Variant) : iGenericQuery; overload;
    function Params(aParamName : String; aValue : Variant) : iGenericQuery; overload;
    function Execute : Boolean;
    function OpenArray : TJSONArray;
    function OpenObject : TJSONObject;
    function RecordCount : Integer;
  end;

implementation

uses
  System.SysUtils;

{ TGenericQuery }

constructor TGenericQuery.Create;
begin
  FQuery := TFDQuery.Create(nil);
  FIndexConnection := GenericQuery.Model.Connection.Connected;
  FQuery.Connection := GenericQuery.Model.Connection.FConnList.Items[FIndexConnection];
  FSQL := TStringList.Create;
  FCurrentParam := 0;
end;

destructor TGenericQuery.Destroy;
begin
  FQuery.Close;
  FQuery.Free;
  FSQL.Free;
  GenericQuery.Model.Connection.Disconnected(FIndexConnection);

  inherited;
end;

function TGenericQuery.Execute: Boolean;
begin
  if FSQL.Text = '' then
    raise Exception.Create('SQL não informado!');

  try
    FQuery.ExecSQL;

    Result := True;
  except
    Result := False;
  end;
end;

class function TGenericQuery.New: iGenericQuery;
begin
  Result := Self.Create;
end;

function TGenericQuery.OpenArray: TJSONArray;
begin
  Result := TJSONArray.Create;

  if FSQL.Text = '' then
    raise Exception.Create('SQL não informado!');

  FQuery.Open;

  if FQuery.RecordCount > 0 then
    Result := TDataSetToJSON.New.DataSetToJSONArray(FQuery);
end;

function TGenericQuery.OpenObject: TJSONObject;
begin
  Result := TJSONObject.Create;

  if FSQL.Text = '' then
    raise Exception.Create('SQL não informado!');

  FQuery.Open;

  if FQuery.RecordCount > 0 then
    Result := TDataSetToJSON.New.DataSetToJSONObject(FQuery);
end;

function TGenericQuery.Params(aParamName: String;
  aValue: Variant): iGenericQuery;
begin
  Result := Self;
  FQuery.ParamByName(aParamName).Value := aValue;
end;

function TGenericQuery.Params(aValue: Variant): iGenericQuery;
begin
  Result := Self;
  FQuery.Params[FCurrentParam].Value := aValue;
  Inc(FCurrentParam);
end;

function TGenericQuery.RecordCount: Integer;
begin
  if FSQL.Text = '' then
    raise Exception.Create('SQL não informado!');

  if not FQuery.Active then
    FQuery.Open;

  result := FQuery.RecordCount;
end;

function TGenericQuery.SQL(vSQL : String) : iGenericQuery;
begin
  Result := Self;

  FSQL.Add(vSQL);

  FQuery.SQL.Text := FSQL.Text;
end;

end.



