
Set-ExecutionPolicy RemoteSigned
Import-Module -name 'C:\Program Files (x86)\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Ide.psm1' -Force -Verbose
#Import-Module -name 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\140\RoleTailored Client\Microsoft.Dynamics.Nav.Ide.psm1' -Force -Verbose
Import-Module -name "C:\Program Files (x86)\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1"  -Force -Verbose
#Import-Module -name "C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\140\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1"  -Force -Verbose


#Автоматический импорт обьектов из базы(можно импортировать и в ручную)

#Export-NAVApplicationObject -DatabaseServer 'localhost' -DatabaseName 'Demo Database NAV (10-0)' -Filter 'Type=Table;Id=50000..50010' -Path 'c:\temp\Al-Conversion\Objects.txt' -Username 'Administrator' -Password 'Password123' -ExportToNewSyntax
Export-NAVApplicationObject -DatabaseServer 'ALFA' -DatabaseName 'ACS_NAV90' -Filter 'Type=Table;Id=1..100' -Path 'c:\temp\Al-Conversion\ACS.txt' 
Export-NAVApplicationObject -DatabaseServer 'SIRIUS' -DatabaseName 'Demo Database NAV (10-0)' -Filter 'Type=Table;Id=1..100' -Path 'c:\temp\Al-Conversion\Original.txt'  
 
#Сравнение оригинальных файлов с модифицированными.
Compare-NAVApplicationObject -OriginalPath 'C:\TEMP\Al-Conversion\OriginalNEW\Original.txt' -ModifiedPath C:\TEMP\Al-Conversion\Modified\Tables.txt -DeltaPath C:\TEMP\Al-Conversion\DELTA\


# Split the txt file into separate txt files pr object - Эта команда не понадобилась !
Split-NAVApplicationObjectFile -Source 'C:\temp\Al-Conversion\*.txt' -Destination 'c:\temp\Al-Conversion\cal'
Split-NAVApplicationObjectFile -Source 'C:\temp\Al-Conversion\*.txt' -Destination 'c:\temp\Al-Conversion\cal-Orig'


#Дальше через Command Promt нужно переделать файлы DELTA а AL.
# Create the .al files
$Command = "C:\Program Files (x86)\Microsoft Dynamics NAV\110\RoleTailored Client\txt2al.exe" #Указать папку с txt2al.exe
& $Command --source c:\temp\Al-Conversion\cal --target c:\temp\Al-Conversion\al
        

