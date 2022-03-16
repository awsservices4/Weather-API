FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY weather-api.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet build "weather-api.csproj" -c Release -o /app/build
RUN dotnet publish "weather-api.csproj" -c Release -o /app/publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "weather-api.dll"]
