<template>
    <section class="bg-gradient-to-b from-gray-50 to-white dark:from-gray-900 dark:to-gray-800">
      <div class="py-12 px-4 mx-auto max-w-screen-xl text-center lg:py-16 lg:px-12">
        <!-- Featured Tag -->
        <a href="#new-releases"
          class="inline-flex justify-between items-center py-1 px-1 pr-4 mb-7 text-sm text-gray-700 bg-gray-100 rounded-full dark:bg-gray-800 dark:text-white hover:bg-gray-200 dark:hover:bg-gray-700"
          role="alert">
          <span class="text-xs bg-blue-600 rounded-full text-white px-4 py-1.5 mr-3">Nouveau</span>
          <span class="text-sm font-medium">Plus de 1000 nouveaux livres ajoutés ce mois-ci</span>
          <svg class="ml-2 w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd"
              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
              clip-rule="evenodd"></path>
          </svg>
        </a>
  
        <!-- Main Heading -->
        <h1 class="mb-4 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
          Votre bibliothèque numérique
          <span class="text-blue-600 dark:text-blue-500">illimitée</span>
        </h1>
  
        <!-- Subheading -->
        <p class="mb-8 text-lg font-normal text-gray-500 lg:text-xl sm:px-16 lg:px-48 dark:text-gray-400">
          Accédez à plus de {{ stats.books }} livres, magazines et ressources académiques. Lisez n'importe où, n'importe quand, sur tous vos appareils.
        </p>
  
        <!-- Action Buttons -->
        <div class="flex flex-col mb-8 lg:mb-16 space-y-4 sm:flex-row sm:justify-center sm:space-y-0 sm:space-x-4">
          <a href="#explore"
            class="inline-flex justify-center items-center py-3 px-5 text-base font-medium text-center text-white rounded-lg bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900">
            Explorer la bibliothèque
            <svg class="ml-2 -mr-1 w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
            </svg>
          </a>
          <a href="#signup"
            class="inline-flex justify-center items-center py-3 px-5 text-base font-medium text-center text-gray-900 rounded-lg border border-gray-300 hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 dark:text-white dark:border-gray-700 dark:hover:bg-gray-700 dark:focus:ring-gray-800">
            S'inscrire gratuitement
          </a>
        </div>
  
        <!-- Stats Grid -->
        <div class="grid grid-cols-2 gap-4 sm:grid-cols-4 sm:gap-6">
          <div v-for="(stat, index) in displayStats" :key="index"
            class="p-4 bg-white rounded-lg shadow-sm dark:bg-gray-800">
            <component :is="stat.icon" class="h-10 w-10 mb-2 mx-auto text-blue-600"></component>
            <h3 class="text-3xl font-bold text-gray-900 dark:text-white">{{ stat.value }}</h3>
            <p class="text-gray-500 dark:text-gray-400">{{ stat.label }}</p>
          </div>
        </div>
      </div>
    </section>
  </template>
  
  <script>
  export default {
    name: 'LibraryHero',
    data() {
      return {
        stats: {
          books: '500K+',
          readers: '1M+',
          access: '24/7',
          categories: '50+'
        },
        displayStats: [
          {
            icon: 'BookIcon',
            value: '500K+',
            label: 'Livres'
          },
          {
            icon: 'UsersIcon',
            value: '1M+',
            label: 'Lecteurs'
          },
          {
            icon: 'SearchIcon',
            value: '24/7',
            label: 'Accès'
          },
          {
            icon: 'BookIcon',
            value: '50+',
            label: 'Catégories'
          }
        ]
      }
    }
  }
  </script>
  
  <style scoped>
  /* Add any additional custom styles here */
  .dark {
    color-scheme: dark;
  }
  </style>