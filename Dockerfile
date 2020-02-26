FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build-env
WORKDIR /api
COPY api/api.csproj .
RUN dotnet restore
COPY api .
RUN dotnet publish -o /publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /publish
COPY --from=build-env /publish /publish
ENTRYPOINT [ "dotnet", "api.dll" ]
