#Question3 
#In which year (2000 or 2015) did storms have a higher monetary impact within the boundaries of the 13 original colonies?
Function AnswerQuestion3{
	## Get events for years 2000 and 2015
	$2000SEvents = Import-Csv ".\StormEvents_details-ftp_v1.0_d2000_c20160223.csv" | Select -First 100 
	$2015SEvents = Import-Csv ".\StormEvents_details-ftp_v1.0_d2015_c20160810.csv" | Select -First 100
	
	## Filter out locations not within Org. 13 colonies.
	#Create a collection of origianl states
	$OG13 = @("Connecticut",
"Delaware",
"Georgia",
"Maryland",
"Massachusetts",
"New Hampshire",
"New Jersey",
"New York",
"North Carolina",
"Pennsylvania",
"Rhode Island",
"South Carolina",
"Virginia"
)
	
	#Create Collection of year 2000 events which occured within the original 13 states
	$OG2000SEvents = @()
	
	#Create Collection of year 2000 events which occured within the original 13 states
	$OG2015SEvents = @()

	## Sum all storm's damage, in dollars for 2000
	#Create Integer to hold running total of year 2000 events which occured within the original 13 states
	[int]$Damage00 = 0
	Foreach($Event in $2000SEvents ){

		## Filter out A*" "B*" "C*"
		If(($Event.CZ_NAME -notlike "A*") -and ($Event.CZ_NAME -notlike "B*") -and ($Event.CZ_NAME -notlike "C*")){
			
			## Filter Out Non-OG13 States
			If ($OG13 -contains "$($Event.STATE)"){
			
				#Convert #.#K and #.#M into Ineger (Numbers)
				If ($Event.DAMAGE_CROPS.tostring() -like "*k"){
					$Event.DAMAGE_CROPS = $Event.DAMAGE_CROPS.tostring().split("k")[0].split("K")[0]
					$Event.DAMAGE_CROPS = [Int]$Event.DAMAGE_CROPS * 1000
					}
				ElseIf($Event.DAMAGE_CROPS.tostring() -like "*m"){
					$Event.DAMAGE_CROPS = $Event.DAMAGE_CROPS.tostring().split("m")[0].split("M")[0]
					$Event.DAMAGE_CROPS = [Int]$Event.DAMAGE_CROPS * 1000000
					}
				Else{
					$Event.DAMAGE_CROPS = [Int]$Event.DAMAGE_CROPS
					}
				
				If ($Event.DAMAGE_PROPERTY.tostring() -like "*k"){
					$Event.DAMAGE_PROPERTY = $Event.DAMAGE_PROPERTY.tostring().split("k")[0].split("K")[0]
					$Event.DAMAGE_PROPERTY = [Int]$Event.DAMAGE_PROPERTY * 1000
					}
				ElseIf($Event.DAMAGE_PROPERTY.tostring() -like "*m"){
					$Event.DAMAGE_PROPERTY = $Event.DAMAGE_PROPERTY.tostring().split("m")[0].split("M")[0]
					$Event.DAMAGE_PROPERTY = [Int]$Event.DAMAGE_PROPERTY * 1000000
					}		
				Else{
					$Event.DAMAGE_PROPERTY = [Int]$Event.DAMAGE_CROPS
					}
					
					
				If([int]$Event.DAMAGE_CROPS -gt 0){
					$Damage00 += [Int]$Event.DAMAGE_CROPS
					}
				If([int]$Event.DAMAGE_PROPERTY -gt 0){
					$Damage00 += [Int]$Event.DAMAGE_PROPERTY
					}
				}
			}
		}
		
	## Sum all storm's damage, in dollars  for 2015
	#Create Integer to hold running total of year 2015 events which occured within the original 13 states
	[int]$Damage15 = 0
	
	Foreach($Event in $2015SEvents){
		## Filter out A*" "B*" "C*"
		If(($Event.CZ_NAME -notlike "A*") -and ($Event.CZ_NAME -notlike "B*") -and ($Event.CZ_NAME -notlike "C*")){

			## Filter Out Non-OG13 States
			If ($OG13 -contains "$($Event.STATE)"){
				
				#Convert #.#K and #.#M into actual number
				If ($Event.DAMAGE_CROPS.tostring() -like "*k"){
					$Event.DAMAGE_CROPS = $Event.DAMAGE_CROPS.tostring().split("k")[0].split("K")[0]
					$Event.DAMAGE_CROPS = [Int]$Event.DAMAGE_CROPS * 1000
					}
				ElseIf($Event.DAMAGE_CROPS.tostring() -like "*m"){
					$Event.DAMAGE_CROPS = $Event.DAMAGE_CROPS.tostring().split("m")[0].split("M")[0]
					$Event.DAMAGE_CROPS = [Int]$Event.DAMAGE_CROPS * 1000000
					}
				Else{
					$Event.DAMAGE_CROPS = [Int]$Event.DAMAGE_CROPS
					}
				
				If ($Event.DAMAGE_PROPERTY.tostring() -like "*k"){
					$Event.DAMAGE_PROPERTY = $Event.DAMAGE_PROPERTY.tostring().split("k")[0].split("K")[0]
					$Event.DAMAGE_PROPERTY = [Int]$Event.DAMAGE_PROPERTY * 1000
					}
				ElseIf($Event.DAMAGE_PROPERTY.tostring() -like "*m"){
					$Event.DAMAGE_PROPERTY = $Event.DAMAGE_PROPERTY.tostring().split("m")[0].split("M")[0]
					$Event.DAMAGE_PROPERTY = [Int]$Event.DAMAGE_PROPERTY * 1000000
					}
				Else{
					$Event.DAMAGE_PROPERTY = [Int]$Event.DAMAGE_CROPS
					}

				#Count up the damage for 2015
				If([int]$Event.DAMAGE_CROPS -ge 0){
					$Damage15 += [Int]$Event.DAMAGE_CROPS
					}
				Else{
					Write-Host -ForegroundColor Red "DAMAGE_CROPS value is not a number for $($Event.EVENT_ID)"
					}
				If([int]$Event.DAMAGE_PROPERTY -ge 0){
					$Damage15 += [Int]$Event.DAMAGE_PROPERTY
					}
				Else{
					Write-Host -ForegroundColor Red "Damage_Property value is not a number for $($Event.EVENT_ID)"
					}	
				}
			}
		}
	
		
	## Compare which sum is higher and output answer
	If($Damage15 -gt $Damage00){
	
		#Report answer to question 
		CLS
		Write-Host "Your Question was:"
		Write-Host "`tIn which year (2000 or 2015) did storms have a higher monetary impact"
		Write-Host "`twithin the boundaries of the 13 original colonies?"
		Write-Host ""
		Read-Host -Prompt "Press `<Enter`> to view answer"
		CLS
		Write-Host "Your Question was:"
		Write-Host "`tIn which year (2000 or 2015) did storms have a higher monetary impact"
		Write-Host "`twithin the boundaries of the 13 original colonies?"
		Write-Host ""
		Write-Host "The answer is:"
		Write-Host -ForegroundColor Green "#Year 2015 storm events caused a higher monetary impact within the 13 original colonies"
		Write-Host -ForegroundColor Green "`$$Damage15 for 2015"
		Write-Host -ForegroundColor Red "`$$Damage00 for 2000"
		}
	ElseIf($Damage00 -gt $Damage15){
		CLS
		Write-Host "Your Question was:"
		Write-Host "`tIn which year (2000 or 2015) did storms have a higher monetary impact"
		Write-Host "`twithin the boundaries of the 13 original colonies?"
		Write-Host ""
		Read-Host -Prompt "Press `<Enter`> to view answer"
		CLS
		Write-Host "Your Question was:"
		Write-Host "`tIn which year (2000 or 2015) did storms have a higher monetary impact"
		Write-Host "`twithin the boundaries of the 13 original colonies?"
		Write-Host ""
		Write-Host "The answer is:"
		Write-Host -ForegroundColor Green "#Year 2000 storm events caused a higher monetary impact within the 13 original colonies"
		Write-Host -ForegroundColor Green "`$$Damage00 for 2000"
		Write-Host -ForegroundColor Red "`$$Damage15 for 2015"
		}
	Else{
		CLS
		Write-Host "Your Question was:"
		Write-Host "`tIn which year (2000 or 2015) did storms have a higher monetary impact"
		Write-Host "`twithin the boundaries of the 13 original colonies?"
		Write-Host ""
		Read-Host -Prompt "Press `<Enter`> to view answer"
		CLS
		Write-Host "Your Question was:"
		Write-Host "`tIn which year (2000 or 2015) did storms have a higher monetary impact"
		Write-Host "`twithin the boundaries of the 13 original colonies?"
		Write-Host ""
		Write-Host "The answer is:"
		Write-Host -ForegroundColor Green "Both 2015 and 2000 year's storm events were the same monetary impact within the 13 original colonies"
		Write-Host -ForegroundColor Green "`$$Damage00 for 2000"
		Write-Host -ForegroundColor Green "`$$Damage15 for 2015"
		}
	}