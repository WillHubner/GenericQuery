unit GenericQuery;

interface

uses
  System.JSON,
  Data.DB,
  Model.GenericQuery.Intf,
  DataSetConverter4D,
  DataSetConverter4D.Impl,
  DataSetConverter4D.Helper,
  DataSetConverter4D.Util, FireDAC.Comp.Client, Model.Connection,
  System.Classes;

type
  TGenericQuery = class(TInterfacedObject, iGenericQuery)
  private
    FIndexConnection : Integer;
    FQuery : TFDQuery;
    FSQL: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    class function New : iGenericQuery;

    function SQL(vSQL : String) : iGenericQuery;
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
  FIndexConnection := Model.Connection.Connected;
  FQuery.Connection := Model.Connection.FConnList.Items[FIndexConnection];
  FSQL := TStringList.Create;
end;

destructor TGenericQuery.Destroy;
begin
  FQuery.Close;
  FQuery.Free;
  FSQL.Free;
  Model.Connection.Disconnected(FIndexConnection);

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
    Result := FQuery.AsJSONArray;
end;

function TGenericQuery.OpenObject: TJSONObject;
begin
  Result := TJSONObject.Create;

  if FSQL.Text = '' then
    raise Exception.Create('SQL não informado!');

  FQuery.Open;

  if FQuery.RecordCount > 0 then
    Result := FQuery.AsJSONObject;
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



