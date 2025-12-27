<template>
  <div class="chart-container">
    <h3>📊 Tendencia de Temperatura</h3>
    <canvas ref="chartCanvas"></canvas>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { Chart, registerables } from 'chart.js'

Chart.register(...registerables)

const props = defineProps(['forecast', 'isDark', 'isCelsius'])
const chartCanvas = ref(null)
let chartInstance = null

const createChart = () => {
  if (!chartCanvas.value) return
  
  if (chartInstance) {
    chartInstance.destroy()
  }

  const labels = props.forecast.map(item => {
    const date = new Date(item.dt * 1000)
    return date.toLocaleDateString('es-ES', { weekday: 'short', day: 'numeric' })
  })

  const convertTemp = (temp) => {
    if (props.isCelsius) {
      return Math.round(temp)
    }
    return Math.round((temp * 9/5) + 32)
  }

  const temps = props.forecast.map(item => convertTemp(item.main.temp))
  const feelsLike = props.forecast.map(item => convertTemp(item.main.feels_like))

  const textColor = props.isDark ? '#ffffff' : '#333333'
  const gridColor = props.isDark ? 'rgba(255,255,255,0.1)' : 'rgba(0,0,0,0.1)'

  chartInstance = new Chart(chartCanvas.value, {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Temperatura',
          data: temps,
          borderColor: '#667eea',
          backgroundColor: 'rgba(102, 126, 234, 0.1)',
          tension: 0.4,
          fill: true
        },
        {
          label: 'Sensación térmica',
          data: feelsLike,
          borderColor: '#764ba2',
          backgroundColor: 'rgba(118, 75, 162, 0.1)',
          tension: 0.4,
          fill: true,
          borderDash: [5, 5]
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          labels: {
            color: textColor
          }
        }
      },
      scales: {
        y: {
          ticks: {
            color: textColor,
            callback: (value) => value + '°' + (props.isCelsius ? 'C' : 'F')
          },
          grid: {
            color: gridColor
          }
        },
        x: {
          ticks: {
            color: textColor
          },
          grid: {
            color: gridColor
          }
        }
      }
    }
  })
}

onMounted(() => {
  createChart()
})

watch(() => [props.forecast, props.isDark, props.isCelsius], () => {
  createChart()
}, { deep: true })
</script>

<style scoped>
.chart-container {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  margin: 2rem auto;
  max-width: 900px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  height: 350px;
}

h3 {
  color: #333;
  margin-bottom: 1.5rem;
}

canvas {
  max-height: 250px;
}
</style>
