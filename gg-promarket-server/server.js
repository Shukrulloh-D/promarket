/* eslint-env node */
import express from 'express';
import cors from 'cors';
import { readFile, writeFile } from 'node:fs/promises';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const readDb = async () => JSON.parse(await readFile('./db.json', 'utf-8'));
const writeDb = (data) => writeFile('./db.json', JSON.stringify(data, null, 2));

// GET: /api/banners, /api/brands, /api/articles и т.д.
app.get('/api/:section', async (req, res) => {
  const db = await readDb();
  const data = db[req.params.section];
  if (data === undefined) return res.status(404).json({ message: 'Not found' });
  res.json(data);
});

// GET с фильтром: /api/products?category=hit
app.get('/api/products', async (req, res) => {
  const db = await readDb();
  const { category } = req.query;
  let products = db.products;
  if (category) products = products.filter(p => p.category === category);
  res.json(products);
});

// POST — добавить в корзину
app.post('/api/cart', async (req, res) => {
  const { productId, qty = 1 } = req.body;
  const db = await readDb();
  const product = db.products.find(p => p.id === productId);
  if (!product) return res.status(404).json({ message: 'Product not found' });

  const existing = db.cart.find(item => item.id === productId);
  if (existing) {
    existing.qty += qty;
  } else {
    db.cart.push({ id: product.id, title: product.title, price: product.price, qty });
  }
  await writeDb(db);
  res.json(db.cart);
});

// DELETE — удалить из корзины
app.delete('/api/cart/:id', async (req, res) => {
  const db = await readDb();
  db.cart = db.cart.filter(item => item.id !== Number(req.params.id));
  await writeDb(db);
  res.json(db.cart);
});

app.listen(PORT, () => console.log(`Server started: http://localhost:${PORT}`));