#!/bin/bash

set -e 

export PATH=$HOME/.dotnetcli:$PATH

dotnet --info
dotnet --list-sdks
dotnet restore

echo "🤖 Attempting to build..."
for path in src/**/*.csproj; do
    dotnet build -f netstandard1.3 -c Release ${path}
    dotnet build -f netstandard2.0 -c Release ${path}
    dotnet build -f netstandard2.1 -c Release ${path}
done

echo "🤖 Running tests..."
for path in test/*.Tests/*.csproj; do
    dotnet test -f netcoreapp2.2  -c Release ${path}
    dotnet test -f netcoreapp3.1  -c Release ${path}
done

