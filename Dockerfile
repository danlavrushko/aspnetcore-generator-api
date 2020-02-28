FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine as build-env
WORKDIR /api
COPY api/api.csproj .
RUN dotnet restore -r linux-musl-x64
COPY api .
RUN dotnet publish -c release -o /publish -r linux-musl-x64 --self-contained true --no-restore /p:PublishTrimmed=true /p:PublishReadyToRun=true

FROM mcr.microsoft.com/dotnet/core/runtime-deps:3.1-alpine
WORKDIR /publish
COPY --from=build-env /publish /publish
ENTRYPOINT ["./api"]
