<script setup>
import { ref, computed } from 'vue'
import UserLayouts from './Layouts/UserLayouts.vue'

const props = defineProps({
    orders: Array
})

const isExpanded = ref({})
const activeTab = ref('today')
const searchQuery = ref('')
const selectedStatus = ref('all')
const currentPage = ref(1)
const perPage = 10

const stats = computed(() => {
    // Calcul des produits populaires
    const topProducts = (() => {
        const products = {}
        props.orders.forEach(order => {
            order.order_items.forEach(item => {
                if (!products[item.product.title]) {
                    products[item.product.title] = 0
                }
                products[item.product.title]++
            })
        })
        return Object.entries(products)
            .sort(([,a], [,b]) => b - a)
            .slice(0, 5)
    })()

    // Calcul des revenus par période
    const revenueByPeriod = {
        today: props.orders
            .filter(order => new Date(order.created_at).toDateString() === new Date().toDateString())
            .reduce((sum, order) => sum + calculateOrderTotal(order), 0),
        week: props.orders
            .filter(order => {
                const orderDate = new Date(order.created_at)
                const weekAgo = new Date()
                weekAgo.setDate(weekAgo.getDate() - 7)
                return orderDate >= weekAgo
            })
            .reduce((sum, order) => sum + calculateOrderTotal(order), 0),
        month: props.orders
            .filter(order => {
                const orderDate = new Date(order.created_at)
                const monthAgo = new Date()
                monthAgo.setMonth(monthAgo.getMonth() - 1)
                return orderDate >= monthAgo
            })
            .reduce((sum, order) => sum + calculateOrderTotal(order), 0)
    }

    return {
        totalOrders: props.orders.length,
        totalRevenue: props.orders.reduce((sum, order) => 
            sum + calculateOrderTotal(order), 0),
        averageOrderValue: props.orders.length ? 
            (props.orders.reduce((sum, order) => sum + calculateOrderTotal(order), 0) / props.orders.length).toFixed(2) : 0,
        pendingOrders: props.orders.filter(o => o.status === 'pending').length,
        completedOrders: props.orders.filter(o => o.status === 'completed').length,
        topProducts,
        revenueByPeriod
    }
})

const calculateOrderTotal = (order) => {
    return order.order_items.reduce((total, item) => total + item.product.price, 0)
}

const filteredOrders = computed(() => {
    return props.orders.filter(order => {
        const matchesSearch = searchQuery.value === '' || 
            order.id.toString().includes(searchQuery.value) ||
            order.order_items.some(item => 
                item.product.title.toLowerCase().includes(searchQuery.value.toLowerCase()))
        
        const matchesStatus = selectedStatus.value === 'all' || 
            order.status === selectedStatus.value
        
        const matchesDate = (() => {
            const orderDate = new Date(order.created_at)
            const today = new Date()
            
            switch(activeTab.value) {
                case 'today':
                    return orderDate.toDateString() === today.toDateString()
                case 'week':
                    const weekAgo = new Date()
                    weekAgo.setDate(weekAgo.getDate() - 7)
                    return orderDate >= weekAgo
                case 'month':
                    const monthAgo = new Date()
                    monthAgo.setMonth(monthAgo.getMonth() - 1)
                    return orderDate >= monthAgo
                default:
                    return true
            }
        })()
        
        return matchesSearch && matchesStatus && matchesDate
    })
})

const paginatedOrders = computed(() => {
    const start = (currentPage.value - 1) * perPage
    return filteredOrders.value.slice(start, start + perPage)
})

const totalPages = computed(() => 
    Math.ceil(filteredOrders.value.length / perPage)
)

const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('fr-FR', {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    })
}

const formatPrice = (price) => {
    return new Intl.NumberFormat('fr-FR', {
        style: 'currency',
        currency: 'EUR'
    }).format(price)
}
</script>

<template>
    <UserLayouts>
        <div class="max-w-screen-xl mx-auto p-6 bg-gray-50">
            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl shadow-lg p-6 text-white">
                    <div class="text-sm font-medium opacity-80">Total Commandes</div>
                    <div class="mt-2 flex items-baseline">
                        <span class="text-3xl font-bold">{{ stats.totalOrders }}</span>
                        <span class="ml-2 text-sm bg-blue-400/30 px-2 py-1 rounded-full">+12%</span>
                    </div>
                </div>
                
                <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-xl shadow-lg p-6 text-white">
                    <div class="text-sm font-medium opacity-80">Revenu Total</div>
                    <div class="mt-2 flex items-baseline">
                        <span class="text-3xl font-bold">{{ formatPrice(stats.totalRevenue) }}</span>
                        <span class="ml-2 text-sm bg-green-400/30 px-2 py-1 rounded-full">+8%</span>
                    </div>
                </div>
                
                <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl shadow-lg p-6 text-white">
                    <div class="text-sm font-medium opacity-80">Panier Moyen</div>
                    <div class="mt-2 flex items-baseline">
                        <span class="text-3xl font-bold">{{ formatPrice(stats.averageOrderValue) }}</span>
                        <span class="ml-2 text-sm bg-purple-400/30 px-2 py-1 rounded-full">+5%</span>
                    </div>
                </div>

                <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-xl shadow-lg p-6 text-white">
                    <div class="text-sm font-medium opacity-80">Commandes en Attente</div>
                    <div class="mt-2 flex items-baseline">
                        <span class="text-3xl font-bold">{{ stats.pendingOrders }}</span>
                        <span class="ml-2 text-sm bg-orange-400/30 px-2 py-1 rounded-full">{{ stats.pendingOrders }} nouvelles</span>
                    </div>
                </div>
            </div>

            <!-- Revenue by Period -->
            <div class="mb-8 bg-white rounded-xl shadow-sm p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Revenus par période</h3>
                <div class="grid grid-cols-3 gap-4">
                    <div class="p-4 bg-gray-50 rounded-lg">
                        <div class="text-sm text-gray-500">Aujourd'hui</div>
                        <div class="text-xl font-semibold text-gray-900">
                            {{ formatPrice(stats.revenueByPeriod.today) }}
                        </div>
                    </div>
                    <div class="p-4 bg-gray-50 rounded-lg">
                        <div class="text-sm text-gray-500">Cette semaine</div>
                        <div class="text-xl font-semibold text-gray-900">
                            {{ formatPrice(stats.revenueByPeriod.week) }}
                        </div>
                    </div>
                    <div class="p-4 bg-gray-50 rounded-lg">
                        <div class="text-sm text-gray-500">Ce mois</div>
                        <div class="text-xl font-semibold text-gray-900">
                            {{ formatPrice(stats.revenueByPeriod.month) }}
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top Products & Status -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="col-span-2 bg-white rounded-xl shadow-sm p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Produits Populaires</h3>
                    <div class="space-y-4">
                        <div v-for="[product, count] in stats.topProducts" :key="product"
                             class="flex items-center justify-between">
                            <span class="text-sm text-gray-600">{{ product }}</span>
                            <div class="flex items-center space-x-3">
                                <div class="w-32 bg-gray-100 rounded-full h-2">
                                    <div class="bg-blue-500 h-2 rounded-full" 
                                         :style="`width: ${(count / stats.topProducts[0][1]) * 100}%`"></div>
                                </div>
                                <span class="text-sm font-medium text-gray-900">{{ count }} vendus</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Statut des Commandes</h3>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <span class="text-sm text-gray-600">Complétées</span>
                            <span class="px-3 py-1 rounded-full text-sm bg-green-50 text-green-700">
                                {{ stats.completedOrders }}
                            </span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-sm text-gray-600">En attente</span>
                            <span class="px-3 py-1 rounded-full text-sm bg-yellow-50 text-yellow-700">
                                {{ stats.pendingOrders }}
                            </span>
                        </div>
                        <div class="pt-4">
                            <div class="w-full bg-gray-100 rounded-full h-3">
                                <div class="bg-green-500 h-3 rounded-full" 
                                     :style="`width: ${(stats.completedOrders / stats.totalOrders) * 100}%`"></div>
                            </div>
                            <div class="mt-2 text-xs text-gray-500 text-right">
                                {{ Math.round((stats.completedOrders / stats.totalOrders) * 100) }}% complétées
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-xl shadow-sm p-6 mb-8">
                <div class="flex flex-wrap gap-4 items-center">
                    <div class="flex-1">
                        <input 
                            v-model="searchQuery"
                            type="text"
                            placeholder="Rechercher une commande..."
                            class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                        >
                    </div>
                    <select 
                        v-model="selectedStatus"
                        class="px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    >
                        <option value="all">Tous les statuts</option>
                        <option value="pending">En attente</option>
                        <option value="completed">Complété</option>
                    </select>
                    <div class="flex space-x-2">
                        <button 
                            v-for="tab in ['today', 'week', 'month']" 
                            :key="tab"
                            @click="activeTab = tab"
                            :class="[
                                'px-4 py-2 rounded-lg text-sm font-medium transition-colors',
                                activeTab === tab 
                                    ? 'bg-blue-500 text-white' 
                                    : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                            ]"
                        >
                            {{ tab === 'today' ? "Aujourd'hui" : tab === 'week' ? 'Cette semaine' : 'Ce mois' }}
                        </button>
                    </div>
                </div>
            </div>

            <!-- Orders List -->
            <div class="space-y-4">
                <div v-for="order in paginatedOrders" :key="order.id" 
                     class="bg-white rounded-xl shadow-sm border border-gray-100 hover:border-blue-100 transition-colors">
                    <div @click="isExpanded[order.id] = !isExpanded[order.id]" 
                         class="p-6 flex items-center justify-between cursor-pointer">
                        <div class="flex items-center space-x-6">
                            <div class="h-12 w-12 rounded-xl bg-blue-50 flex items-center justify-center">
                                <span class="text-blue-600 font-medium">#{{ order.id }}</span>
                            </div>
                            <div>
                                <div class="font-medium text-gray-900">
                                    Commande #{{ order.id }}
                                </div>
                                <div class="text-sm text-gray-500">
                                    {{ formatDate(order.created_at) }}
                                </div>
                            </div>
                            <div class="px-3 py-1 rounded-full text-xs font-medium" 
                                 :class="order.status === 'completed' ? 'bg-green-50 text-green-700' : 'bg-yellow-50 text-yellow-700'">
                                {{ order.status === 'completed' ? 'Complété' : 'En cours' }}
                            </div>
                        </div>
                        <div class="flex items-center space-x-6">
                            <div class="text-right"><div class="text-sm font-medium text-gray-900">
                                    {{ formatPrice(calculateOrderTotal(order)) }}
                                </div>
                                <div class="text-xs text-gray-500">
                                    {{ order.order_items.length }} articles
                                </div>
                            </div>
                            <svg 
                                :class="{'transform rotate-180': isExpanded[order.id]}"
                                class="h-5 w-5 text-gray-400 transition-transform" 
                                fill="none" viewBox="0 0 24 24" stroke="currentColor"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                            </svg>
                        </div>
                    </div>

                    <div v-show="isExpanded[order.id] && order.order_items.length > 0" 
                         class="border-t border-gray-100">
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Produit</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Marque</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Catégorie</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Prix</th>
                                        <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <tr v-for="item in order.order_items" :key="item.id" 
                                        class="hover:bg-gray-50">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="h-10 w-10 rounded-lg bg-gray-100 flex items-center justify-center mr-3">
                                                    <svg class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                                    </svg>
                                                </div>
                                                <span class="text-sm font-medium text-gray-900">{{ item.product.title }}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-50 text-blue-700">
                                                {{ item.product.brand_id.name }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="text-sm text-gray-500">{{ item.product.category_id.name }}</span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="text-sm font-medium text-gray-900">{{ formatPrice(item.product.price) }}</span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right">
                                            <button class="text-sm text-blue-600 hover:text-blue-700 font-medium">
                                                Voir détails
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <div v-if="totalPages > 1" class="mt-6 flex justify-center">
                <nav class="flex items-center space-x-2">
                    <button 
                        @click="currentPage = Math.max(1, currentPage - 1)"
                        :disabled="currentPage === 1"
                        class="px-3 py-1 rounded-md bg-white border border-gray-300 text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50"
                    >
                        Précédent
                    </button>
                    
                    <button 
                        v-for="page in totalPages" 
                        :key="page"
                        @click="currentPage = page"
                        :class="[
                            'px-3 py-1 rounded-md text-sm font-medium',
                            currentPage === page
                                ? 'bg-blue-500 text-white'
                                : 'bg-white border border-gray-300 text-gray-500 hover:bg-gray-50'
                        ]"
                    >
                        {{ page }}
                    </button>
                    
                    <button 
                        @click="currentPage = Math.min(totalPages, currentPage + 1)"
                        :disabled="currentPage === totalPages"
                        class="px-3 py-1 rounded-md bg-white border border-gray-300 text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50"
                    >
                        Suivant
                    </button>
                </nav>
            </div>
        </div>
    </UserLayouts>
</template>