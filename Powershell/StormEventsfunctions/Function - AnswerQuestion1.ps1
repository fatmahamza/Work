Function AnswerQuestion1 {
#Question 1	
#Find the month in 2015 where the State of Washington had the largest number of storm events.
#How many days of storm-free weather occurred in that month?

	#Import storm events data
	If(-not (Test-Path .\StormEvents_details-ftp_v1.0_d2015_c20160810.csv)){
		Write-Host -ForegroundColor Red "Required data file is missing"
		Write-Host -ForegroundColor yellow "Please download csv from:"
		Write-Host "<LINK>"
		Exit
		}
	Else{
		$2015SEvents = Import-Csv ".\StormEvents_details-ftp_v1.0_d2015_c20160810.csv"
		}
		
	## Filter out A*" "B*" "C*"
	$2015SEvents = $2015SEvents | Where-Object{($_.CZ_NAME -notlike "A*") -and ($_.CZ_NAME -notlike "B*") -and ($_.CZ_NAME -notlike "C*")}

	#Exlude all except Washington State
	$2015SEventsWa = $2015SEvents | ?{$_.State -like "Washington"}

	#Took all year 2015 Events
	#Grouped by Month_Name
	#Sorted by count of value for Month_Name
	#Took the name largest count and assigned to $MostActiveMonth
	$MostActiveMonth = ($2015SEventsWa | Group-Object Month_Name | sort count)[-1].name

	#Create a days in month hash table
	$MonthsHash = @{}
	$MonthsHash["January"] = 31
	$MonthsHash["February"] = 28
	$MonthsHash["March"] = 31
	$MonthsHash["April"] = 30
	$MonthsHash["May"] = 31
	$MonthsHash["June"] = 30
	$MonthsHash["July"] = 31
	$MonthsHash["August"] = 31
	$MonthsHash["September"] = 30
	$MonthsHash["October"] = 31
	$MonthsHash["November"] = 30
	$MonthsHash["December"] = 31


	## Subtract count of days with storms from total days in month
	$CountStormyDays = ($2015SEvents | ?{$_.Month_Name -like $MostActiveMonth} | Group-Object BEGIN_DAY ).count
	$CountStormFreeDays = $MonthsHash["$MostActiveMonth"] - $CountStormyDays
	
	## Report the answer
	CLS
	Write-Host "Your Question was:"
	Write-Host "`tFind the month in 2015 where the State of Washington had the largest number of storm events,"
	Write-Host "`tHow many days of storm-free weather occurred in that month?"
	Write-Host ""
	$NotGonnaUse = Read-Host -Prompt "Press `<Enter`> to view answer"
	CLS
	Write-Host "Your Question was:"
	Write-Host "`tFind the month in 2015 where the State of Washington had the largest number of storm events,"
	Write-Host "`tHow many days of storm-free weather occurred in that month?"
	Write-Host ""
	Write-Host -ForegroundColor Yellow "In order to answer this I had to make assumtion about the definition of"
	Write-Host -ForegroundColor Yellow "`"storm-free weather`", the following answer assumes that storm free days"
	Write-Host -ForegroundColor Yellow "are days in which no storm event is reported in the data set"
	Write-Host ""
	Write-Host "The answer is:"
	Write-Host ""
	Write-Host -ForegroundColor Green "$($TimeWindowEvents.count)"
	
	Write-Host -ForegroundColor Green "Storm Free Days In $MostActiveMonth`:"
	Write-Host -ForegroundColor Green "$CountStormFreeDays"
	}

