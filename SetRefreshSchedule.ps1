#Connect-PowerBIServiceAccount

### This will list out all the different workspaces, and their id's
#$ws = Get-PowerBIWorkspace

#### specify the workspace id you want to update the schedules for. 
$wsid = ""
$datasets = Get-PowerBIDataset -WorkspaceId $wsid

ForEach($dataset in $datasets)
{
    $datasetid = $dataset.Id
    $dataset.Name
    $dataset.Id

    $path = '/datasets/' + $datasetid + '/refreshSchedule'
    Invoke-PowerBIRestMethod -Url $path -Method GET

    $value = "{ 'value': { 'times': [ '05:00', '07:00', '09:00', '11:00', '13:00', '15:00', '17:00', '19:00', '21:00' ]  }}"
    Invoke-PowerBIRestMethod -Url $path -Method PATCH -Body $value
}

