param(
    [String] $filePath,
    [String] $section,
    [String] $key
)

$ini = Add-Type -memberDefinition @"
[DllImport("Kernel32")] public static extern long WritePrivateProfileString (string section,string key,string val,string filePath);
[DllImport("Kernel32")] public static extern int  GetPrivateProfileString   (string section,string key,string def,StringBuilder retVal,int size,string filePath); 
"@ -passthru -name MyPrivateProfileString -UsingNamespace System.Text
  
$retVal=New-Object System.Text.StringBuilder(255)
$null=$ini::GetPrivateProfileString($section,$key,"",$retVal,255,$filePath)
Write-Host $retVal.tostring()
