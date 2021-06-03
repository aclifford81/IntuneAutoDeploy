$locations = "C:\Users\adam.clifford\dev\Source2\CNF\","C:\Users\adam.clifford\dev\Source2\APP\","C:\Users\adam.clifford\dev\Source2\CMP\"

foreach ($location in $locations) 
{

    $files = Get-childitem $location

        foreach ($file in $files) {


        $a = Get-Content $file.FullName -raw | ConvertFrom-Json

        if ($a.'@odata.type' -like "*android*") {$prefix = "Android - "}
        if ($a.'@odata.type' -like "*iOS*") {$prefix = "iOS - "}

        
   
        if ($a.displayName -notlike "*iOS*" -and $a.displayName -notlike "*Android*") 
        {
            Write-host "Updating File $($file.name)"
            $a.displayName = $prefix + $a.displayName
            $a | ConvertTo-Json -depth 100 | Out-File $file.FullName



        }
    }
}
