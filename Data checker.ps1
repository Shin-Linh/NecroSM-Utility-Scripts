if ((Test-Path .\integrity_log.txt))
{
	Clear-Content integrity_log.txt;
}
PushD chara_data
$directory=Get-Location
$no_H = '00002','00007','00015','00021','00022','00033','00042','00073','00074','00077','00078','00079','00080','00081','00104','00128','00153','00182','00184','00221','00222','00226','00227','00228','00229','00253','00254','00255','00256','00263','00277','00317','00318','00319','00337','00356'
$NPC = '10007','10008','10011','10012','10021','10026'
$Ippa = '10002'
Write-Host "Current directory:" -NoNewline $directory.Path
Get-ChildItem|
	ForEach{$ID = $_.Name;
			$clear = $true;
			Write-Host "Checking ID $ID`...";
			if (!(Test-Path "$ID\up$ID.png"))
			{
				Write-Output "ID $ID is missing top icon" >> ..\integrity_log.txt;
				$clear = $false;
			};
			
			if (!(Test-Path "$ID\vs$ID.dmm") -and !$NPC.Contains($ID))
			{
				Write-Output "ID $ID is missing voice data" >> ..\integrity_log.txt;
				$clear = $false;
			};
			
			if ($NPC.Contains($ID) - $Ippa.Contains($ID))
			{
				
			}else
			{			
				if (!(Test-Path "$ID\scene"))
				{
					Write-Output "ID $ID is missing scene data" >> ..\integrity_log.txt;
					$clear = $false;
				} else
				{
					if (!(Test-Path "$ID\scene\har_$ID.dmm.ja") -and !(Test-Path "$ID\scene\har_$ID.dmm"))
					{
						Write-Output "ID $ID is missing scene script" >> ..\integrity_log.txt;
						$clear = $false;
					}
					if (!(Test-Path "$ID\scene\har_$ID`_voice.dmm"))
					{
						Write-Output "ID $ID is missing scene voice" >> ..\integrity_log.txt;
							$clear = $false;
					}
				}
			}
		
			if ($NPC.Contains($ID) -or $no_H.Contains($ID) -or $Ippa.Contains($ID))
			{
				
			}else
			{
				if (!(Test-Path "$ID\scene_R"))
				{
					Write-Output "ID $ID is missing H scene data" >> ..\integrity_log.txt;
					$clear = $false;
				} else
				{
					if (!(Test-Path "$ID\scene_R\har_$ID.dmm.ja") -and !(Test-Path "$ID\scene_R\har_$ID.dmm"))
					{
						Write-Output "ID $ID is missing H scene script" >> ..\integrity_log.txt;
						$clear = $false;
					}
					if (!(Test-Path "$ID\scene_R\har_$ID`_voice.dmm"))
					{
						Write-Output "ID $ID is missing H scene voice" >> ..\integrity_log.txt;
						$clear = $false;
					}
					if (!(Test-Path "$ID\scene_R\har_$ID`_image.dmm"))
					{
						Write-Output "ID $ID is missing H scene visuals" >> ..\integrity_log.txt;
						$clear = $false;
					}
				}
			}
			
			if ($NPC.Contains($ID))
			{
				
			} else
			{
				if (!(Test-Path "$ID\live2D\l2d$ID.dmm") -and !(Test-Path "$ID\live2D\l2d$ID.dmm.dmmpf"))
				{
						Write-Output "ID $ID is missing Live2D data" >> ..\integrity_log.txt;
						$clear = $false;
				}
				
				if (!(Test-Path "$ID\battle\p$ID.dmm") -and !(Test-Path "$ID\battle\p$ID.dmm.dmmpf"))
				{
						Write-Output "ID $ID is missing battle data" >> ..\integrity_log.txt;
						$clear = $false;
				}
			}
			
			if ($clear)
			{
				Write-Output "ID $ID clear" >> ..\integrity_log.txt;
			}
			Write-Output "----------------------------------------" >> ..\integrity_log.txt;
	}
	
Write-Host "Integrity check done. Please see the integrity_log.txt files for detail"
PushD ..
pause