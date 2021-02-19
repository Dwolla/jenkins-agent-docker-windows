# More recent image versions seem to result in a password expired error:
# https://github.com/jenkinsci/docker-inbound-agent/issues/183
FROM jenkins/inbound-agent:4.3-7-jdk8-nanoserver-1809

# By default, jobs on a Jenkins slave will be stored in [Remote FS
# root]\workspace, but the the Windows-based Jenkins agent's workspace
# directory is [Remote FS root]\Work. We create a symbolic link to address this
# incompatibility.
RUN cmd /c mklink /d C:\Users\jenkins\workspace C:\Users\jenkins\Work


COPY jenkins-agent-wrapper.ps1 C:/ProgramData/Jenkins
ENTRYPOINT ["pwsh.exe", "-f", "C:/ProgramData/Jenkins/jenkins-agent-wrapper.ps1"]