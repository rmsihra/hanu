
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools -verbose

   
    Import-module webadministration

    $SiteFolderPath = "C:\WebSite"              # Website Folder
    $SiteAppPool = "MyAppPool"                  # Application Pool Name
    $SiteName = "MySite"                        # IIS Site Name
    $SiteHostName = "www.MySite.com"            # Host Header

    New-Item $SiteFolderPath -type Directory
    Set-Content $SiteFolderPath\Default.htm "<h1>Hello IIS</h1>"
    New-Item IIS:\AppPools\$SiteAppPool
    New-Item IIS:\Sites\$SiteName -physicalPath $SiteFolderPath -bindings @{protocol="http";bindingInformation=":80:"+$SiteHostName}
    Set-ItemProperty IIS:\Sites\$SiteName -name applicationPool -value $SiteAppPool 