unit Model.GenericQuery.Intf;

interface

uses
  System.JSON;

type
  iGenericQuery = interface
  ['{D7C2F73C-5199-4890-A261-B2F2F16D35B9}']
    function Execute : Boolean;
    function OpenArray : TJSONArray;
    function OpenObject : TJSONObject;
    function RecordCount : Integer;
    function SQL(vSQL : String) : iGenericQuery;
    function Params(aValue : Variant) : iGenericQuery; overload;
    function Params(aParamName : String; aValue : Variant) : iGenericQuery; overload;
  end;

implementation

end.
