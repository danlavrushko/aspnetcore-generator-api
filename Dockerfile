FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build-env
WORKDIR /api
COPY api/api.csproj .
RUN dotnet restore -r linux-musl-x64
COPY api .
RUN dotnet publish -c release -o /publish -r linux-musl-x64 --self-contained false --no-restore

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine
WORKDIR /publish
COPY --from=build-env /publish /publish
ENTRYPOINT ["./api"]
