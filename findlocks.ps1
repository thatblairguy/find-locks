<#
    Find all locks in a repository path.

    Syntax: powershell .\findLocks.ps1 RepositoryURL
#>
param( $path )

function Main ( $repoPath ) {
    # Report on files in the repository.
    [xml]$repoInfo = (svn info -R --xml $repoPath)

    $lockset = $repoInfo.SelectNodes( "info/entry[lock and @kind='file']" )
    foreach ( $lock in $lockset ) {
        $filename = $lock.path
        $username = $lock.lock.owner
        Write-Host "Lock by $username on $filename."
    }
}


If( -not $path ) {
    Throw "You must specify a path in Subversion."
}

Main $path
