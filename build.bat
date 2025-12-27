@echo off
echo Construyendo proyecto para produccion...
npm run build
echo.
echo Build completado! La carpeta 'dist' esta lista para Netlify.
echo.
echo Para desplegar:
echo 1. Arrastra la carpeta 'dist' a netlify.com/drop
echo 2. O usa: netlify deploy --prod
pause
