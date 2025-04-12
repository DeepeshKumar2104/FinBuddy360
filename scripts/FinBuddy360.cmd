@echo off
cd /d %~dp0
echo.
echo ✅ Starting full setup for FinBuddy360...

:: ========== Create Solution ==========
dotnet new sln -n FinBuddy360

:: ========== Create Main Projects ==========
dotnet new webapi -n FinBuddy360.Api -o src\Api\FinBuddy360.Api
dotnet new classlib -n FinBuddy360.Application -o src\Application\FinBuddy360.Application
dotnet new classlib -n FinBuddy360.Domain -o src\Domain\FinBuddy360.Domain
dotnet new classlib -n FinBuddy360.Infrastructure -o src\Infrastructure\FinBuddy360.Infrastructure
dotnet new classlib -n FinBuddy360.Shared -o src\Shared\FinBuddy360.Shared

:: ========== Add Projects to Solution ==========
dotnet sln add src\Api\FinBuddy360.Api\FinBuddy360.Api.csproj
dotnet sln add src\Application\FinBuddy360.Application\FinBuddy360.Application.csproj
dotnet sln add src\Domain\FinBuddy360.Domain\FinBuddy360.Domain.csproj
dotnet sln add src\Infrastructure\FinBuddy360.Infrastructure\FinBuddy360.Infrastructure.csproj
dotnet sln add src\Shared\FinBuddy360.Shared\FinBuddy360.Shared.csproj

:: ========== Add References ==========
dotnet add src\Application\FinBuddy360.Application\FinBuddy360.Application.csproj reference src\Domain\FinBuddy360.Domain\FinBuddy360.Domain.csproj

dotnet add src\Infrastructure\FinBuddy360.Infrastructure\FinBuddy360.Infrastructure.csproj reference src\Application\FinBuddy360.Application\FinBuddy360.Application.csproj
dotnet add src\Infrastructure\FinBuddy360.Infrastructure\FinBuddy360.Infrastructure.csproj reference src\Domain\FinBuddy360.Domain\FinBuddy360.Domain.csproj
dotnet add src\Infrastructure\FinBuddy360.Infrastructure\FinBuddy360.Infrastructure.csproj reference src\Shared\FinBuddy360.Shared\FinBuddy360.Shared.csproj

dotnet add src\Api\FinBuddy360.Api\FinBuddy360.Api.csproj reference src\Application\FinBuddy360.Application\FinBuddy360.Application.csproj
dotnet add src\Api\FinBuddy360.Api\FinBuddy360.Api.csproj reference src\Infrastructure\FinBuddy360.Infrastructure\FinBuddy360.Infrastructure.csproj
dotnet add src\Api\FinBuddy360.Api\FinBuddy360.Api.csproj reference src\Shared\FinBuddy360.Shared\FinBuddy360.Shared.csproj

:: ========== Create Test Projects ==========
dotnet new xunit -n FinBuddy360.Tests.Unit -o tests\FinBuddy360.Tests.Unit
dotnet new xunit -n FinBuddy360.Tests.Integration -o tests\FinBuddy360.Tests.Integration
dotnet new xunit -n FinBuddy360.Tests.Functional -o tests\FinBuddy360.Tests.Functional

dotnet sln add tests\FinBuddy360.Tests.Unit\FinBuddy360.Tests.Unit.csproj
dotnet sln add tests\FinBuddy360.Tests.Integration\FinBuddy360.Tests.Integration.csproj
dotnet sln add tests\FinBuddy360.Tests.Functional\FinBuddy360.Tests.Functional.csproj

:: ========== Create Dummy Projects for docs and scripts ==========
dotnet new classlib -n FinBuddy360.Docs -o docs\FinBuddy360.Docs
dotnet sln add docs\FinBuddy360.Docs\FinBuddy360.Docs.csproj

dotnet new classlib -n FinBuddy360.Scripts -o scripts\FinBuddy360.Scripts
dotnet sln add scripts\FinBuddy360.Scripts\FinBuddy360.Scripts.csproj

:: ========== Create Empty Files in Subfolders ==========

:: === API ===
cd src\Api\FinBuddy360.Api
mkdir Controllers && type nul > Controllers\Controllers.cs
mkdir Extensions && type nul > Extensions\Extensions.cs
mkdir Middleware && type nul > Middleware\Middleware.cs
mkdir Filters && type nul > Filters\Filters.cs
mkdir Properties && type nul > Properties\Properties.cs
cd ..\..\..\

:: === APPLICATION ===
cd src\Application\FinBuddy360.Application
mkdir Common && type nul > Common\Common.cs
mkdir Behaviors && type nul > Behaviors\Behaviors.cs
mkdir Contracts && type nul > Contracts\Contracts.cs
mkdir Exceptions && type nul > Exceptions\Exceptions.cs
mkdir Services && type nul > Services\Services.cs
mkdir Features
cd Features
mkdir ExampleFeature
cd ExampleFeature
mkdir Commands && type nul > Commands\Commands.cs
mkdir Queries && type nul > Queries\Queries.cs
mkdir Handlers && type nul > Handlers\Handlers.cs
mkdir Validators && type nul > Validators\Validators.cs
cd ..\..\..\..\..\

:: === DOMAIN ===
cd src\Domain\FinBuddy360.Domain
mkdir Entities && type nul > Entities\Entities.cs
mkdir ValueObjects && type nul > ValueObjects\ValueObjects.cs
mkdir Enums && type nul > Enums\Enums.cs
mkdir Exceptions && type nul > Exceptions\Exceptions.cs
mkdir Events && type nul > Events\Events.cs
mkdir Interfaces && type nul > Interfaces\Interfaces.cs
mkdir Common && type nul > Common\Common.cs
cd ..\..\..\

:: === INFRASTRUCTURE ===
cd src\Infrastructure\FinBuddy360.Infrastructure
mkdir Persistence
cd Persistence
mkdir DbContexts && type nul > DbContexts\DbContexts.cs
mkdir Repositories && type nul > Repositories\Repositories.cs
mkdir Configurations && type nul > Configurations\Configurations.cs
mkdir Migrations && type nul > Migrations\Migrations.cs
cd ..
mkdir Services
cd Services
mkdir EmailService && type nul > EmailService\EmailService.cs
mkdir StorageService && type nul > StorageService\StorageService.cs
cd ..
mkdir Authentication
cd Authentication
mkdir Jwt && type nul > Jwt\Jwt.cs
cd ..\..\..\..\

:: === SHARED ===
cd src\Shared\FinBuddy360.Shared
mkdir Helpers && type nul > Helpers\Helpers.cs
mkdir Constants && type nul > Constants\Constants.cs
mkdir Extensions && type nul > Extensions\Extensions.cs
mkdir Utilities && type nul > Utilities\Utilities.cs
cd ..\..\..\

:: === DOCS (non-project folders) ===
mkdir docs\architecture
mkdir docs\api-documentation
mkdir docs\setup-guides
mkdir docs\usage-guides

:: === ROOT FILES ===
type nul > docker-compose.yml
type nul > .gitignore
type nul > README.md

echo.
echo ✅ ALL DONE! Full solution, projects, structure, and visibility in Solution Explorer is ready!
pause
exit /b
REM End of script   