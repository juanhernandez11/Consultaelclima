<template>
  <div class="forecast">
    <h3>Pronóstico 5 días</h3>
    <div class="forecast-grid">
      <div v-for="day in forecast" :key="day.dt" class="forecast-item">
        <p class="date">{{ formatDate(day.dt) }}</p>
        <img :src="`https://openweathermap.org/img/wn/${day.weather[0].icon}@2x.png`" />
        <p class="temp">{{ convertTemp(day.main.temp) }}°{{ isCelsius ? 'C' : 'F' }}</p>
        <p class="desc">{{ day.weather[0].description }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps(['forecast', 'isCelsius'])

const formatDate = (timestamp) => {
  const date = new Date(timestamp * 1000)
  return date.toLocaleDateString('es-ES', { weekday: 'short', day: 'numeric', month: 'short' })
}

const convertTemp = (temp) => {
  if (props.isCelsius) {
    return Math.round(temp)
  }
  return Math.round((temp * 9/5) + 32)
}
</script>

<style scoped>
.forecast {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  margin: 2rem auto;
  max-width: 900px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  animation: fadeIn 0.6s ease-in;
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
  margin-bottom: 1.5rem;
}

.forecast-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 1rem;
}

.forecast-item {
  padding: 1rem;
  background: #f8f9fa;
  border-radius: 10px;
  transition: all 0.3s ease;
  cursor: pointer;
}

.forecast-item:hover {
  transform: translateY(-5px) scale(1.05);
  box-shadow: 0 8px 20px rgba(0,0,0,0.15);
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.forecast-item:hover .date,
.forecast-item:hover .temp,
.forecast-item:hover .desc {
  color: white;
}

.date {
  font-weight: bold;
  color: #667eea;
  text-transform: capitalize;
}

.temp {
  font-size: 1.5rem;
  font-weight: bold;
  color: #333;
  margin: 0.5rem 0;
}

.desc {
  color: #666;
  font-size: 0.9rem;
  text-transform: capitalize;
}
</style>
