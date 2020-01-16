FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic AS build

WORKDIR /opt/ctlog
COPY ./* ./
RUN dotnet publish -r linux-x64 -c Release -p:PublishSingleFile=True --self-contained

FROM ubuntu:latest

COPY --from=build /opt/ctlog/bin/Release/netcoreapp3.0/linux-x64/publish /usr/local/bin
RUN apt-get update && apt-get --no-install-recommends -y install libicu60 &&\
	rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["ctlog"]