<template>
  <div class="app" :class="[{ dark: isDark }, weatherClass]">
    <div class="header">
      <h1>🌤️ Weather Dashboard</h1>
      <div class="header-controls">
        <button @click="toggleUnits" class="unit-toggle">
          {{ isCelsius ? '°C' : '°F' }}
        </button>
        <button @click="toggleTheme" class="theme-toggle">
          {{ isDark ? '☀️' : '🌙' }}
        </button>
      </div>
    </div>
    <SearchBar @search="fetchWeather" @locate="getLocation" />
    <Favorites :favorites="favorites" @select="fetchWeather" @remove="removeFavorite" />
    <div v-if="loading" class="loading">Cargando...</div>
    <div v-if="error" class="error">{{ error }}</div>
    <WeatherCard 
      v-if="weather" 
      :weather="weather" 
      :is-favorite="isFavorite(weather.name)"
      :is-celsius="isCelsius"
      @toggle-favorite="toggleFavorite"
    />
    <HourlyForecast v-if="hourlyForecast.length" :forecast="hourlyForecast" :is-celsius="isCelsius" />
    <TemperatureChart v-if="forecast.length" :forecast="forecast" :is-dark="isDark" :is-celsius="isCelsius" />
    <Forecast v-if="forecast.length" :forecast="forecast" :is-celsius="isCelsius" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import SearchBar from './components/SearchBar.vue'
import WeatherCard from './components/WeatherCard.vue'
import Forecast from './components/Forecast.vue'
import Favorites from './components/Favorites.vue'
import TemperatureChart from './components/TemperatureChart.vue'
import HourlyForecast from './components/HourlyForecast.vue'

const API_KEY = import.meta.env.VITE_WEATHER_API_KEY
const weather = ref(null)
const forecast = ref([])
const hourlyForecast = ref([])
const loading = ref(false)
const error = ref('')
const isDark = ref(false)
const favorites = ref([])
const isCelsius = ref(true)
const weatherClass = ref('')

const fetchWeather = async (city) => {
  loading.value = true
  error.value = ''
  weather.value = null
  forecast.value = []
  
  try {
    const currentRes = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric&lang=es`
    )
    weather.value = currentRes.data
    
    const forecastRes = await axios.get(
      `https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${API_KEY}&units=metric&lang=es`
    )
    forecast.value = forecastRes.data.list.filter((_, i) => i % 8 === 0).slice(0, 5)
    hourlyForecast.value = forecastRes.data.list.slice(0, 8)
    updateWeatherBackground(currentRes.data.weather[0].main)
  } catch (err) {
    error.value = 'Ciudad no encontrada. Intenta de nuevo.'
  } finally {
    loading.value = false
  }
}

const fetchWeatherByCoords = async (lat, lon) => {
  loading.value = true
  error.value = ''
  
  try {
    const currentRes = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric&lang=es`
    )
    weather.value = currentRes.data
    
    const forecastRes = await axios.get(
      `https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric&lang=es`
    )
    forecast.value = forecastRes.data.list.filter((_, i) => i % 8 === 0).slice(0, 5)
    hourlyForecast.value = forecastRes.data.list.slice(0, 8)
    updateWeatherBackground(currentRes.data.weather[0].main)
  } catch (err) {
    error.value = 'Error al obtener el clima.'
  } finally {
    loading.value = false
  }
}

const getLocation = () => {
  if (navigator.geolocation) {
    loading.value = true
    navigator.geolocation.getCurrentPosition(
      (position) => {
        fetchWeatherByCoords(position.coords.latitude, position.coords.longitude)
      },
      () => {
        error.value = 'No se pudo obtener tu ubicación.'
        loading.value = false
      }
    )
  } else {
    error.value = 'Geolocalización no disponible.'
  }
}

const toggleTheme = () => {
  isDark.value = !isDark.value
  localStorage.setItem('theme', isDark.value ? 'dark' : 'light')
}

const toggleUnits = () => {
  isCelsius.value = !isCelsius.value
  localStorage.setItem('units', isCelsius.value ? 'celsius' : 'fahrenheit')
}

const updateWeatherBackground = (condition) => {
  const conditions = {
    'Clear': 'clear',
    'Clouds': 'clouds',
    'Rain': 'rain',
    'Drizzle': 'rain',
    'Thunderstorm': 'storm',
    'Snow': 'snow',
    'Mist': 'mist',
    'Fog': 'mist',
    'Haze': 'mist'
  }
  weatherClass.value = conditions[condition] || 'clear'
}

const toggleFavorite = (cityName) => {
  const index = favorites.value.indexOf(cityName)
  if (index > -1) {
    favorites.value.splice(index, 1)
  } else {
    favorites.value.push(cityName)
  }
  localStorage.setItem('favorites', JSON.stringify(favorites.value))
}

const removeFavorite = (cityName) => {
  favorites.value = favorites.value.filter(f => f !== cityName)
  localStorage.setItem('favorites', JSON.stringify(favorites.value))
}

const isFavorite = (cityName) => {
  return favorites.value.includes(cityName)
}

onMounted(() => {
  const savedTheme = localStorage.getItem('theme')
  isDark.value = savedTheme === 'dark'
  
  const savedUnits = localStorage.getItem('units')
  isCelsius.value = savedUnits !== 'fahrenheit'
  
  const savedFavorites = localStorage.getItem('favorites')
  if (savedFavorites) {
    favorites.value = JSON.parse(savedFavorites)
  }
})
</script>

<style scoped>
.app {
  text-align: center;
  transition: all 0.5s ease;
  min-height: 100vh;
}

.app.clear {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.app.clouds {
  background: linear-gradient(135deg, #757F9A 0%, #D7DDE8 100%);
}

.app.rain {
  background: linear-gradient(135deg, #4b6cb7 0%, #182848 100%);
}

.app.storm {
  background: linear-gradient(135deg, #2c3e50 0%, #000000 100%);
}

.app.snow {
  background: linear-gradient(135deg, #E6DADA 0%, #274046 100%);
}

.app.mist {
  background: linear-gradient(135deg, #bdc3c7 0%, #2c3e50 100%);
}

.app.dark {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
}

.header {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2rem;
  margin-bottom: 2rem;
}

.header-controls {
  display: flex;
  gap: 1rem;
}

h1 {
  color: white;
  font-size: 3rem;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
  margin: 0;
}

.theme-toggle, .unit-toggle {
  background: rgba(255,255,255,0.2);
  border: none;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  font-size: 1.2rem;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
  color: white;
}

.theme-toggle:hover, .unit-toggle:hover {
  transform: scale(1.1);
  background: rgba(255,255,255,0.3);
}

.loading, .error {
  color: white;
  font-size: 1.2rem;
  margin: 2rem 0;
  padding: 1rem;
  background: rgba(0,0,0,0.2);
  border-radius: 10px;
  animation: pulse 1.5s ease-in-out infinite;
}

.error {
  background: rgba(255,0,0,0.3);
  animation: shake 0.5s ease-in-out;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.6;
  }
}

@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  25% {
    transform: translateX(-10px);
  }
  75% {
    transform: translateX(10px);
  }
}
</style>
