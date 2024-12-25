<template>
    <div style="display: flex; align-items: flex-start; padding: 20px; gap: 20px;">
      <div>
        <img 
          v-if="product.images && product.images.length > 0" 
          :src="`/product_images/${product.images[0].image}`" 
          :alt="product.title" 
          style="width: 300px; height: auto; object-fit: cover;" 
        />
        <div v-else>
          <p>No image available</p> 
        </div>
      </div>
      <div class="product-details"> 
        <div class="product-info">
          <h1 class="product-title">{{ product.title }}</h1>
          <p class="product-description">{{ product.description }}</p>
  
          <div class="product-price">
            <span class="price-label">Prix :</span>
            <span class="price-value">{{ product.price }} €</span>
          </div>
  
          <div class="product-stock">
            <span class="stock-label">Quantité en stock :</span>
            <span class="stock-value">{{ product.quantity }}</span>
          </div>
  
          <div class="product-category">
            <span class="category-label">Catégorie :</span>
            <span class="category-value">{{ product.category?.name || 'Non spécifiée' }}</span>
          </div>
  
          <div class="product-brand">
            <span class="brand-label">Marque :</span>
            <span class="brand-value">{{ product.brand?.name || 'Non spécifiée' }}</span>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      product: {
        type: Object,
        required: true,
      },
    },
  };
  </script>
  
  <style scoped>
  .product-details {
    display: flex;
    flex-direction: column;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
  
  .product-info {
    margin-left: 20px; /* Adjust margin as needed */
  }
  
  .product-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
  }
  
  .product-description {
    color: #666;
    margin-bottom: 20px;
  }
  
  .product-price,
  .product-stock,
  .product-category,
  .product-brand {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }
  
  .price-label,
  .stock-label,
  .category-label,
  .brand-label {
    font-weight: bold;
    margin-right: 5px;
  }
  
  /* Add your desired colors and styles here */
  .price-value {
    color: #007bff; /* Blue for price */
  }
  
  .stock-value {
    color: #28a745; /* Green for stock */
  }
  
  .category-value {
    color: #ffc107; /* Yellow for category */
  }
  
  .brand-value {
    color: #6c757d; /* Gray for brand */
  }
  </style>