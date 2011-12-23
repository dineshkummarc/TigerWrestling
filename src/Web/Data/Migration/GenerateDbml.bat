@echo off
cls 
echo hello
 
set PATH="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin";"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE";%PATH%



goto :end
pause

osql -E -S .\sqlexpress -d TigerWrestling -i ..\Migration\Migration.sql

:end
  



SqlMetal.exe /server:.\sqlexpress  /namespace:Web.Data.DataContext /database:TigerWrestling /dbml:../DataContext/DataClasses.dbml /Context:AppDataContext  /language:cs /provider:SQL2008 /pluralize /sprocs /views

SqlMetal.exe /server:.\sqlexpress  /namespace:Web.Data.DataContext /database:TigerWrestling /code:../DataContext/DataClasses.designer.cs /Context:AppDataContext  /language:cs /provider:SQL2008 /pluralize /sprocs /views

 



pause