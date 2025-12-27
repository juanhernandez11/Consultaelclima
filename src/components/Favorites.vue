<template>
  <div v-if="favorites.length" class="favorites">
    <h3>⭐ Favoritos</h3>
    <div class="favorites-list">
      <div v-for="city in favorites" :key="city" class="favorite-item">
        <button @click="$emit('select', city)" class="city-btn">
          {{ city }}
        </button>
        <button @click="$emit('remove', city)" class="remove-btn">×</button>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps(['favorites'])
defineEmits(['select', 'remove'])
</script>

<style scoped>
.favorites {
  background: rgba(255,255,255,0.1);
  border-radius: 15px;
  padding: 1.5rem;
  margin: 0 auto 2rem;
  max-width: 700px;
  animation: slideDown 0.4s ease-out;
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

h3 {
  color: white;
  margin-bottom: 1rem;
  font-size: 1.2rem;
}

.favorites-list {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  justify-content: center;
}

.favorite-item {
  display: flex;
  gap: 5px;
  background: white;
  border-radius: 20px;
  overflow: hidden;
  animation: fadeIn 0.3s ease-in;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.city-btn {
  padding: 10px 20px;
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1rem;
  transition: all 0.3s ease;
}

.city-btn:hover {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  transform: scale(1.05);
}

.remove-btn {
  padding: 10px 15px;
  background: #ff4444;
  color: white;
  border: none;
  cursor: pointer;
  font-size: 1.2rem;
  transition: all 0.3s ease;
}

.remove-btn:hover {
  background: #cc0000;
  transform: rotate(90deg) scale(1.1);
}
</style>
