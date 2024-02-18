if ((Test-Path .\ID_list.txt))
{
	Clear-Content ID_list.txt;
}
$directory=Get-Location
Write-Host "Current directory:" -NoNewline $directory.Path
Get-ChildItem -Path image_unit_icon\ ut* |
	Where BaseName -match 'ut\d{5}'|
	ForEach{$ID = $_.Name.Replace("ut","");
			$ID = $ID.Replace(".png","");
			Write-Host "Recording ID $ID";
			Write-Output "$ID" >> .\ID_list.txt;
		}
		
pause