unit Model.Connection;

interface

uses
  System.JSON,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  Firedac.Phys.FB,
  Firedac.Phys.SQLite,
  Firedac.Phys.SQLiteDef,
  Firedac.Phys.FBDef,
  Firedac.Phys.MySQLDef,
  Firedac.Phys.MySQL,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI;

var
  FDriver : TFDPhysFBDriverLink;
  FConnList : TObjectList<TFDConnection>;
  FServer : String;
  FDatabase : String;

function Connected : Integer;
procedure Disconnected(IndexConn : Integer);

implementation

function Connected : Integer;
var
  IndexConn : Integer;
begin
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  IndexConn := Pred(FConnList.Count);
  FConnList.Items[IndexConn].Params.DriverID := 'FB';
  FConnList.Items[IndexConn].Params.Database := FDatabase;
  FConnList.Items[IndexConn].Params.UserName := 'sysdba';
  FConnList.Items[IndexConn].Params.Password := 'masterkey';
  FConnList.Items[IndexConn].Params.Add('Server='+FServer);
  FConnList.Items[IndexConn].Params.Add('Protocol=TCPIP');
  FConnList.Items[IndexConn].Connected;

  Result := IndexConn;
end;

procedure Disconnected(IndexConn : Integer);
begin
  FConnList.Items[IndexConn].Connected := false;
  FConnList.Items[IndexConn].Free;
  FConnList.TrimExcess;
end;

end.
