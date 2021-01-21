#  FXLogic Profile clean script 
#  C de Wet && M de Beer

#Set Chrome Items to clean
$Items = @('Archived History',
                    'Cache\*',
                   # 'Cookies',
                   # 'History',
                   # 'Login Data',
                   # 'Top Sites',
                   'Visited Links',
                   'Web Data',
                   'File System\*',
                   'Code Cache\js',
                   'Service Worker\CacheStorage')

 

        # set folder path
        $user_path = "$($env:USERPROFILE)"
        
        # set Chrome folder path
        $ChromeFolder = "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default"
        $ChromeFolder2 = "$($env:USERPROFILE)\chrome_data\Chrome\User Data\Default"

 

        # set min age of files
        $max_age = “-90”

 

        # get the current date
        $curr_date = Get-Date

 

        # determine how far back we go based on current date
        $del_date = $curr_date.AddDays($max_age)

 

        # delete only .ost files which are older than 90 days
        Get-ChildItem -include *.ost $user_path -Recurse | 
        Where-Object {$_.LastWriteTime -lt $del_date} |
            Where-Object { -not ($_.psiscontainer) } | 
            Foreach-Object {Remove-Item $_.FullName}

         # delete only .crdownload files which are older than 90 days
        Get-ChildItem -include *.crdownload $user_path -Recurse | 
        Where-Object {$_.LastWriteTime -lt $del_date} |
            Where-Object { -not ($_.psiscontainer) } | 
            Foreach-Object {Remove-Item $_.FullName}

        #Clean Chrome
        $Items | % {
            if (Test-Path "$ChromeFolder\$_") {
            Remove-Item "$ChromeFolder\$_" -Recurse
            }
             $Items | % {
            if (Test-Path "$ChromeFolder2\$_") {
            Remove-Item "$ChromeFolder2\$_" -Recurse
            }}
        }
