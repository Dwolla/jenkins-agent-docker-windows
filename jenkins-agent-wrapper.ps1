# The Jenkins ECS plugin does not currently generate the correct command for
# Windows-based Jenkins agents:
# https://github.com/jenkinsci/amazon-ecs-plugin/issues/225. This wrapper script
# accepts a command in the form that would normally be taken by a Linux-based
# Jenkins agent and forwards it in the format expected by the Windows-based
# Jenkins agent.

[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Url,

    [Parameter(Mandatory, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]$Secret,

    [Parameter(Mandatory, Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]$AgentName
)

Start-Process pwsh.exe -Wait -NoNewWindow -ArgumentList "C:/ProgramData/Jenkins/jenkins-agent.ps1", "-Url", $Url, "-WorkDir", "C:/Jenkins/agent", "-Secret", $Secret, "-Name", $AgentName
