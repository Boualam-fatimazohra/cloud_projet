<template>
    <div>
      <h2>Contact Us</h2>
      <form>
        <div>
          <label for="name">Name:</label>
          <input type="text" id="name" v-model="name" required>
        </div>
        <div>
          <label for="email">Email:</label>
          <input type="email" id="email" v-model="email" required>
        </div>
        <div>
          <label for="message">Message:</label>
          <textarea id="message" v-model="message" rows="5" required></textarea>
        </div>
        <button type="submit">Send Message</button>
      </form>
    </div>
  </template>
  
  <script>
  export default {
    name: 'Contact',
    data() {
      return {
        name: '',
        email: '',
        message: '',
      };
    },
    methods: {
      // Handle form submission
      handleSubmit() {
        // Send the form data to the server (e.g., using Axios)
        console.log('Form submitted:', { name: this.name, email: this.email, message: this.message });
        // Reset the form
        this.name = '';
        this.email = '';
        this.message = '';
      },
    },
  };
  </script>
  
  <style>
  /* Optional CSS styles for the contact form */
  </style>