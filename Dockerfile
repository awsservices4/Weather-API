WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY . .
WORKDIR "/src/."
RUN dotnet build "weather-api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "weather-api.csproj" -c Release -o /app/publish

WORKDIR /app
ENTRYPOINT ["dotnet", "weather-api.dll"]
