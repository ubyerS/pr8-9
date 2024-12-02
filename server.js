const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

let products = [
  {
    product_id: 1,
    name: 'Forza Horizon 4',
    description: 'Гоночная игра в открытом мире.',
    price: 49.99,
    stock: 10,
    image_url: 'assets/forza.jpg'
  },
  {
    product_id: 2,
    name: 'Stardew Valley',
    description: 'Симулятор фермы и ролевой игры.',
    price: 14.99,
    stock: 20,
    image_url: 'assets/stardew_valley.jpg'
  }
];

app.get('/products', (req, res) => {
  res.json(products);
});

app.post('/products/create', (req, res) => {
  const newProduct = req.body;
  newProduct.product_id = products.length + 1;
  products.push(newProduct);
  res.status(201).json(newProduct);
});

app.get('/products/:id', (req, res) => {
  const productId = parseInt(req.params.id);
  const product = products.find(p => p.product_id === productId);
  if (product) {
    res.json(product);
  } else {
    res.status(404).send('Product not found');
  }
});

app.put('/products/update/:id', (req, res) => {
  const productId = parseInt(req.params.id);
  const productIndex = products.findIndex(p => p.product_id === productId);
  if (productIndex !== -1) {
    const updatedProduct = req.body;
    updatedProduct.product_id = productId;
    products[productIndex] = updatedProduct;
    res.json(updatedProduct);
  } else {
    res.status(404).send('Product not found');
  }
});

app.delete('/products/delete/:id', (req, res) => {
  const productId = parseInt(req.params.id);
  const productIndex = products.findIndex(p => p.product_id === productId);
  if (productIndex !== -1) {
    products.splice(productIndex, 1);
    res.status(204).send();
  } else {
    res.status(404).send('Product not found');
  }
});

const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

