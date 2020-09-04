# GenericQuery

Class component a easily way to convert your SQL condition to a JSONArray or JSONString.

# How to use

Implement the uses Model.Connection, Model.GenericQuery two parameters Model.Connection.FServer, Model.Connection.FDataBase.

#Execute

Execute command returs a boolean value.
<details>
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .Execute
</details>

#OpenArray

Open a Array of Objects with fields data
<details>
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .Execute
</details>

#OpenObject

Open a Objects with only first register of sql
<details>
  TGenericQuery
    .New
    .SQL('')
    .SQL('')
    .Execute
</details>
