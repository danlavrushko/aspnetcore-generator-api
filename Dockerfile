FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

WORKDIR /app
COPY api/bin/Debug/netcoreapp3.1/publish .

ENTRYPOINT [ "dotnet", "api.dll" ]
