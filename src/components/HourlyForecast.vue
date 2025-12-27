<template>
  <div class="hourly-forecast">
    <h3>🕐 Pronóstico por Horas</h3>
    <div class="hourly-scroll">
      <div v-for="hour in forecast" :key="hour.dt" class="hour-item">
        <p class="time">{{ formatTime(hour.dt) }}</p>
        <img :src="`https://openweathermap.org/img/wn/${hour.weather[0].icon}.png`" />
        <p class="temp">{{ convertTemp(hour.main.temp) }}°</p>
        <p class="rain">💧 {{ hour.pop ? Math.round(hour.pop * 100) : 0 }}%</p>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps(['forecast', 'isCelsius'])

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
.hourly-forecast {
  background: white;
  border-radius: 20px;
  padding: 1.5rem;
  margin: 2rem auto;
  max-width: 900px;
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

h3 {
  color: #333;
  margin-bottom: 1rem;
}

.hourly-scroll {
  display: flex;
  gap: 1rem;
  overflow-x: auto;
  padding: 1rem 0;
  scroll-behavior: smooth;
}

.hourly-scroll::-webkit-scrollbar {
  height: 8px;
}

.hourly-scroll::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

.hourly-scroll::-webkit-scrollbar-thumb {
  background: #667eea;
  border-radius: 10px;
}

.hour-item {
  min-width: 100px;
  padding: 1rem;
  background: #f8f9fa;
  border-radius: 15px;
  text-align: center;
  transition: all 0.3s ease;
  cursor: pointer;
}

.hour-item:hover {
  transform: translateY(-5px);
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.hour-item:hover .time,
.hour-item:hover .temp,
.hour-item:hover .rain {
  color: white;
}

.time {
  font-weight: bold;
  color: #667eea;
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
}

.temp {
  font-size: 1.3rem;
  font-weight: bold;
  color: #333;
  margin: 0.5rem 0;
}

.rain {
  font-size: 0.8rem;
  color: #666;
}
</style>
