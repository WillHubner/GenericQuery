# GenericQuery

Class component a easily way to convert your SQL condition to a JSONArray or JSONString.
Default database is running in firebird. To change only modify Mode.Connection uses.

# How to use

Implement this parameters:
```delphi
  Model.Connection.FServer := 'localhost';
  Model.Connection.FDataBase := '../../db/db';
  Model.Connection.FTypeConnection := SQLite;
```  
  
Compatible with Firebird and SQLite.

## Execute

Execute command returns a boolean value.
```delphi
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .Execute
```
## OpenArray

Open a Array of JSON Objects with fields data
```delphi
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .OpenArray
```

## OpenObject

Open a JSON Object with only first register of sql
```delphi
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .OpenObject
```
