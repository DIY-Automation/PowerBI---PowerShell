#Install-Module -Name MicrosoftPowerBIMgmt -Force
#Connect-PowerBIServiceAccount

### Specify the root path for which you want to save the files. 
$rootpath = ""

$PBIWorkspace = Get-PowerBIWorkspace 
ForEach($Workspace in $PBIWorkspace)
{
    ### Append a folder with the name of the rootspace to the root path. 
    $Folder = $rootpath + "\" + $Workspace.name

    ### Test to see if the folder already exists, if not, create it. 
    If(!(Test-Path $Folder))
	  {
		  New-Item –ItemType Directory –Force –Path $Folder
	  }

    ### Get a list of all the reports available in the workspace. 
    $PBIReports = Get-PowerBIReport –WorkspaceId $Workspace.Id 		

    ### Loop through the reports and download each one. 
    ForEach($Report in $PBIReports)
  	{
  		#Your PowerShell comandline will say Downloading Workspacename Reportname
  		Write-Host "Downloading "$Workspace.name":" $Report.name 
  			
  		#The final collection including folder structure + file name is created.
  		$OutputFile = $Folder + "\" + $Report.name + ".pbix"
  			
  		# If the file exists, delete it first; otherwise, the Export-PowerBIReport will fail.
  		if (Test-Path $OutputFile)
  		{
  			Remove-Item $OutputFile
  		}
  			
  		#The pbix is now really getting downloaded
  		Export-PowerBIReport –WorkspaceId $Workspace.ID –Id $Report.ID –OutFile $OutputFile
  	}

    ### Pull a list of all the data flows in the workspace. 
    $DataFlows = Get-PowerBIDataflow –WorkspaceId $Workspace.Id

    ### Loop through the dataflows and download each one. 
    ForEach($DataFlow in $DataFlows)
  	{
  		#Your PowerShell comandline will say Downloading Workspacename Dataflowname
  		Write-Host "Downloading "$Workspace.name":" $DataFlow.name 
  			
  		#The final collection including folder structure + file name is created.
  		$OutputFile = $Folder + "\" + $DataFlow.name + ".json"
  			
  		# If the file exists, delete it first; otherwise, the Export-PowerBIReport will fail.
  		if (Test-Path $OutputFile)
  		{
  			Remove-Item $OutputFile
  		}
  			
  		#The pbix is now really getting downloaded
  		Export-PowerBIDataflow –WorkspaceId $Workspace.ID –Id $DataFlow.ID –OutFile $OutputFile
  	}
}
