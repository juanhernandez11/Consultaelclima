<template>
  <div class="weather-card">
    <div class="title-row">
      <h2>{{ weather.name }}, {{ weather.sys.country }}</h2>
      <button @click="$emit('toggleFavorite', weather.name)" class="fav-btn">
        {{ isFavorite ? '⭐' : '☆' }}
      </button>
    </div>
    <div class="main-info">
      <img :src="`https://openweathermap.org/img/wn/${weather.weather[0].icon}@4x.png`" />
      <div class="temp">{{ convertTemp(weather.main.temp) }}°{{ isCelsius ? 'C' : 'F' }}</div>
    </div>
    <p class="description">{{ weather.weather[0].description }}</p>
    <div class="details">
      <div class="detail">
        <span>💧 Humedad</span>
        <strong>{{ weather.main.humidity }}%</strong>
      </div>
      <div class="detail">
        <span>💨 Viento</span>
        <strong>{{ weather.wind.speed }} m/s</strong>
      </div>
      <div class="detail">
        <span>🌡️ Sensación</span>
        <strong>{{ convertTemp(weather.main.feels_like) }}°{{ isCelsius ? 'C' : 'F' }}</strong>
      </div>
    </div>
    <div class="extra-details">
      <div class="detail">
        <span>🌅 Amanecer</span>
        <strong>{{ formatTime(weather.sys.sunrise) }}</strong>
      </div>
      <div class="detail">
        <span>🌇 Atardecer</span>
        <strong>{{ formatTime(weather.sys.sunset) }}</strong>
      </div>
      <div class="detail">
        <span>🔽 Presión</span>
        <strong>{{ weather.main.pressure }} hPa</strong>
      </div>
      <div class="detail">
        <span>👁️ Visibilidad</span>
        <strong>{{ (weather.visibility / 1000).toFixed(1) }} km</strong>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps(['weather', 'isFavorite', 'isCelsius'])
defineEmits(['toggleFavorite'])

const formatTime = (timestamp) => {
  const date = new Date(timestamp * 1000)
  return date.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' })
}

const convertTemp = (temp) => {
  if (props.isCelsius) {
    return Math.round(temp)
  }
  return Math.round((temp * 9/5) + 32)
}
</script>

<style scoped>
.weather-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  margin: 2rem auto;
  max-width: 500px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.title-row {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

h2 {
  color: #333;
  margin: 0;
}

.fav-btn {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  transition: transform 0.2s;
}

.fav-btn:hover {
  transform: scale(1.2);
}

.main-info {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
}

.temp {
  font-size: 4rem;
  font-weight: bold;
  color: #667eea;
}

.description {
  font-size: 1.5rem;
  color: #666;
  text-transform: capitalize;
  margin: 1rem 0;
}

.details {
  display: flex;
  justify-content: space-around;
  margin-top: 2rem;
  padding-top: 1rem;
  border-top: 2px solid #eee;
}

.detail {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.detail span {
  color: #999;
  font-size: 0.9rem;
}

.detail strong {
  color: #333;
  font-size: 1.1rem;
}

.extra-details {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 2px solid #eee;
}

.extra-details .detail {
  background: #f8f9fa;
  padding: 1rem;
  border-radius: 10px;
  transition: transform 0.2s, box-shadow 0.2s;
}

.extra-details .detail:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}
</style>
