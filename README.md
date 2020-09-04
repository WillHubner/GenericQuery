# GenericQuery

Class component a easily way to convert your SQL condition to a JSONArray or JSONString.

# How to use

Implement the uses Model.Connection, Model.GenericQuery two parameters Model.Connection.FServer, Model.Connection.FDataBase.

#Execute

Execute command returs a boolean value.
```delphi
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .Execute
```
#OpenArray

Open a Array of Objects with fields data
```delphi
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .OpenArray
```

#OpenObject

Open a Objects with only first register of sql
```delphi
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .OpenObject
```
