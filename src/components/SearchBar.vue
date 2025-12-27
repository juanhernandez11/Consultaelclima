<template>
  <div class="search-bar">
    <input 
      v-model="city" 
      @keyup.enter="search"
      type="text" 
      placeholder="Buscar ciudad..."
    />
    <button @click="search">🔍 Buscar</button>
    <button @click="locate" class="locate-btn">📍 Mi Ubicación</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const emit = defineEmits(['search', 'locate'])
const city = ref('')

const search = () => {
  if (city.value.trim()) {
    emit('search', city.value)
  }
}

const locate = () => {
  emit('locate')
}
</script>

<style scoped>
.search-bar {
  display: flex;
  gap: 10px;
  max-width: 700px;
  margin: 0 auto 2rem;
  flex-wrap: wrap;
  justify-content: center;
}

input {
  flex: 1;
  min-width: 250px;
  padding: 15px;
  font-size: 1rem;
  border: none;
  border-radius: 25px;
  outline: none;
}

button {
  padding: 15px 30px;
  font-size: 1rem;
  background: white;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  transition: transform 0.2s;
}

button:hover {
  transform: scale(1.05);
}

.locate-btn {
  background: #4CAF50;
  color: white;
}
</style>
