# 🌤️ Weather Dashboard Vue.js

Dashboard del clima moderno con Vue 3, Chart.js y OpenWeatherMap API.

## ✨ Características

- 🔍 Búsqueda de ciudades
- 📍 Geolocalización automática
- ⭐ Ciudades favoritas (guardadas en localStorage)
- 🌙 Modo oscuro/claro
- 📊 Gráfico de tendencia de temperatura
- 🌡️ Información detallada: temperatura, humedad, viento, presión, visibilidad
- 🌅 Horarios de amanecer y atardecer
- 📅 Pronóstico de 5 días
- 🎨 Animaciones suaves y diseño responsive

## 🚀 Instalación

```bash
npm install
```

## 💻 Desarrollo

```bash
npm run dev
```

O simplemente ejecuta `start.bat` en Windows.

## 🎯 Uso

1. Busca cualquier ciudad en el mundo
2. Usa el botón "Mi Ubicación" para clima local
3. Agrega ciudades a favoritos con la estrella ⭐
4. Cambia entre modo claro/oscuro con 🌙/☀️
5. Visualiza el gráfico de temperatura de los próximos días

## 🛠️ Tecnologías

- Vue 3 (Composition API)
- Vite
- Axios
- Chart.js
- OpenWeatherMap API

## 🚀 Despliegue en Netlify

### Opción 1: Deploy Manual
1. Ejecuta `npm run build`
2. Arrastra la carpeta `dist` a Netlify

### Opción 2: Deploy con Git
1. Sube tu proyecto a GitHub
2. Conecta tu repo en Netlify
3. Configuración automática (netlify.toml incluido)

### Opción 3: Deploy con CLI
```bash
npm install -g netlify-cli
netlify login
netlify deploy --prod
```

## 🆕 Nuevas Características

- 🌡️ **Toggle °C/°F**: Cambia entre Celsius y Fahrenheit
- 🌈 **Fondos Dinámicos**: El fondo cambia según el clima (soleado, lluvioso, nublado, etc.)
- 🕐 **Pronóstico por Horas**: Ve el clima hora por hora con probabilidad de lluvia
