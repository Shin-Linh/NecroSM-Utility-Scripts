$directory=Get-Location
Write-Host "Current directory:" -NoNewline $directory.Path
Get-ChildItem -Path image_unit_icon\ ut* |
	Where BaseName -match 'ut\d{5}'|
	ForEach{$ID = $_.Name.Replace("ut","");
			$ID = $ID.Replace(".png","");
			$path = "chara_data\$ID";
			
			## Check if the ID folder already exists
			if (!(Test-Path $path))
			{
				MD $path
			};
			Copy-Item image_unit_icon\$_ -Dest $path;
			
			## Move all party images into the ID folders
			Get-ChildItem -Path image_unit_top\ up*|
				Where BaseName -match "up$ID"|
					Copy -Dest $path;
					
			Get-ChildItem -Path chara_voice\ vs*|
				Where BaseName -match "vs$ID"|
					Copy -Dest $path -Recurse -Force;
			
			# Find all data folders of normal scenes of the same ID
			Get-ChildItem -Path advchara\ har_*|
			Where BaseName -match "har_$ID"|
			Group {$Matches}|
			ForEach{
			$path = "chara_data\$ID\scene"
			## Check if the scene folder already exists
			if (!(Test-Path $path))
			{
				MD $path
			};
			$_.Group|Copy -Dest $path -Recurse -Force}
			
			# Find all data folders of H-scenes of the same ID
			Get-ChildItem -Path advchara_r18\ har_*|
			Where BaseName -match "har_$ID"|
			Group {$Matches}|
			ForEach{
			$path = "chara_data\$ID\scene_R"
			## Check if the H-scene folder already exists
			if (!(Test-Path $path))
			{
				MD $path
			};
			$_.Group|Copy -Dest $path -Recurse -Force}
			
			# Find all Live2D data folders with the same ID
			Get-ChildItem -Path live2d\ l2d*|
			Where BaseName -match "l2d$ID"|
			Group {$Matches}|
			ForEach{
			$path = "chara_data\$ID\live2D"
			## Check if the Live2D folder already exists
			if (!(Test-Path $path))
			{
				MD $path
			};
			$_.Group|Copy -Dest $path -Recurse -Force}
			
			# Find all battle data folders with the same ID
			Get-ChildItem -Path unit\ p*|
			Where BaseName -match "p$ID"|
			Group {$Matches}|
			ForEach{
			$path = "chara_data\$ID\battle"
			## Check if the battle folder already exists
			if (!(Test-Path $path))
			{
				MD $path
			};
			$_.Group|Copy -Dest $path -Recurse -Force}
		}
	   
pause