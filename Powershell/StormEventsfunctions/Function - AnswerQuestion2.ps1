########################################################################	
#Commenting out, leaving for notes
#	If($TreeImpactedEvent.BEGIN_TIME -le 800){
#		Write-Host -ForegroundColor YEllow "Trouble Shooting Note: Made it here 1"
#		If($TreeImpactedEvent.BEGIN_TIME -gt 2000){
#			Write-Host -ForegroundColor Green "Trouble Shooting Note: Made it here 2"
#			$TimeWindowEvents += $TreeImpactedEvent
#			}
#		}
########################################################################
Function AnswerQuestion2{
#Question 2
#How many storms impacting trees happened between 8PM EST and 8AM EST in 2000?

	#Get Year 2000 storm events
	$2000SEvents = Import-Csv ".\StormEvents_details-ftp_v1.0_d2000_c20160223.csv"
	
	## Filter out A*" "B*" "C*"
	$2000SEvents = $2000SEvents | Where-Object{($_.CZ_NAME -notlike "A*") -and ($_.CZ_NAME -notlike "B*") -and ($_.CZ_NAME -notlike "C*")}
		
	#Get just storms that impact trees, check Episode_Narrative and Event_Narrative for *Tree*
	#Make sure to not include duplicats that have tree in both fields, by using an -or operator.
	$2000TreeEvents = @($2000SEvents | Where-Object{($_.EVENT_NARRATIVE -like "*Tree*") -or ($_.EPISODE_NARRATIVE -like "*Tree*")})

	# Create Correction Hash with Time Zone conversion values
	$TZCorrectionHash = @{}
	$TZCorrectionHash["CST"] = +100
	$TZCorrectionHash["EST"] = 0
	$TZCorrectionHash["PST"] = +300
	$TZCorrectionHash["MST"] = +200
	$TZCorrectionHash["AST"] = 0
	$TZCorrectionHash["HST"] = +500
	$TZCorrectionHash["SST"] = +1100

	# Filter out storms between 8am EST and 8pm EST.
	$TimeWindowEvents = @()
	ForEach($TreeImpactedEvent in $2000TreeEvents){
		#Used $TreeImpactedEvent.BEGIN_TIME.gettype() to deturmin the type of object
		#Found BEGIN_TIME is a string
		#Change out the string value in BEGIN_TIME to an integer.
		#Cast the string to itself as an intger using the [Int]
		[Int]$TreeImpactedEvent.BEGIN_TIME =  $TreeImpactedEvent.BEGIN_TIME
		
		
		
		# Correct time to Eastern Standard Time (EST)
		# If Hash has entry for timezone
		#   Add the transfomation time
		#   If its above 2359 (Past Midnight)
		#       Subtract 2400 to get the time in the next day
		If($TZCorrectionHash["$($TreeImpactedEvent.CZ_TIMEZONE)"]){
			$TreeImpactedEvent.Begin_Time = [int]$TreeImpactedEvent.Begin_Time + [Int]$TZCorrectionHash["$($TreeImpactedEvent.CZ_TIMEZONE)"]
			If([Int]$TreeImpactedEvent.Begin_Time -gt 2359){
				[Int]$TreeImpactedEvent.Begin_Time = [Int]$TreeImpactedEvent.Begin_Time - 2400
				}
			}
		
		#Get just the ones in the window 8pm to 8am, and add those to the collection
		If (($TreeImpactedEvent.Begin_Time -le 800) -or ($TreeImpactedEvent.Begin_Time -gt 2000)){
			$TimeWindowEvents += $TreeImpactedEvent
			}
		}
	#Report answer to question 
	CLS
	Write-Host "Your Question was:"
	Write-Host "`tHow many storms impacting trees happened between 8PM EST and 8AM EST in 2000?"
	Write-Host ""
	$NotGonnaUse = Read-Host -Prompt "Press `<Enter`> to view answer"
	CLS
	Write-Host "Your Question was:"
	Write-Host "`tHow many storms impacting trees happened between 8PM EST and 8AM EST in 2000?"
	Write-Host ""
	Write-Host -ForegroundColor Yellow "In order to answer this I had to make assumtion that events impacting trees"
	Write-Host -ForegroundColor Yellow "would have the word `"Tree`" in EVENT_NARRATIVE or EPISODE_NARRATIVE fields"
	Write-Host "with that assumption the answer is:"
	Write-Host ""
	Write-Host -ForegroundColor Green "$($TimeWindowEvents.count) storms impacted trees between 8pm and 8am in 2000"
	}

