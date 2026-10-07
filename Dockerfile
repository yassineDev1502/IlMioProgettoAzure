FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["IlMioProgetto.Api/IlMioProgetto.Api.csproj", "IlMioProgetto.Api/"]
RUN dotnet restore "IlMioProgetto.Api/IlMioProgetto.Api.csproj"
COPY . .
WORKDIR "/src/IlMioProgetto.Api"
RUN dotnet publish "IlMioProgetto.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "IlMioProgetto.Api.dll"]
