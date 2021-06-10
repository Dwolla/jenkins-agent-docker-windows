# Jenkins Agent with Windows

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-windows.svg)](https://microbadger.com/images/dwolla/jenkins-agent-windows)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-windows.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-windows/blob/master/LICENSE)

Docker image making Windows available to Jenkins jobs.

## Building and Publishing

To build the image, execute the included `Build-Image.ps` script. To also
publish these images to DockerHub, add the `-Publish` option.

Note, Windows containers can have some
[compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility)
issues depending on what Windows version an image is built on and the Windows
version the image is run. To this end, the `Build-Image.ps1` script checks the
Windows version it is being run on before building the image. It uses this
information to tag the image as appropriate. This normally takes the form of
`<repo-version>-<windowsservercore|nanoserver>-<windows-version>`. For the
`latest` tag, `<windowsservercore|nanoserver>-<windows-version>` is used
instead.
