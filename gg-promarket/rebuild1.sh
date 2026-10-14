#!/bin/bash

rm -rf src
mkdir -p src/app/styles
mkdir -p src/shared/api
mkdir -p src/shared/lib
mkdir -p src/shared/ui/{button,container,loader,error-message,section-title,modal}
mkdir -p src/entities/{product,banner,collection,brand,article}
mkdir -p src/features/add-to-cart
mkdir -p src/widgets/{header,footer,cart-modal,hero,collections,hits,sales,brands,articles,seo-block}
mkdir -p src/pages/home

# =========================================
# MAIN.JSX
# =========================================
cat > src/main.jsx << 'END'
import React from 'react';
import ReactDOM from 'react-dom/client';
import { App } from '@/app';
import './app/styles/index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
END

# =========================================
# STYLES
# =========================================
cat > src/app/styles/variables.css << 'END'
:root {
  --blue: #1a6ebd;
  --blue-dark: #0d4f8b;
  --blue-light: #e8f0fa;
  --yellow: #ffd700;
  --yellow-dark: #f0c400;
  --red: #e63946;
  --teal: #2ec4b6;
  --text: #1a1a1a;
  --text-muted: #6b7280;
  --bg: #ffffff;
  --bg-soft: #f5f7fa;
  --border: #e5e7eb;
  --font: 'Inter', system-ui, sans-serif;
  --radius: 8px;
}
END

cat > src/app/styles/index.css << 'END'
@import './variables.css';

* { margin: 0; padding: 0; box-sizing: border-box; }
html { scroll-behavior: smooth; }

body {
  font-family: var(--font);
  font-size: 15px;
  line-height: 1.5;
  color: var(--text);
  background: var(--bg);
  -webkit-font-smoothing: antialiased;
}

img { display: block; max-width: 100%; }
a { color: inherit; text-decoration: none; }
button { font: inherit; cursor: pointer; border: none; background: none; }
ul { list-style: none; }
END

# =========================================
# SHARED / LIB
# =========================================
cat > src/shared/lib/cn.js << 'END'
export function cn(...args) {
  return args.filter(Boolean).join(' ');
}
END

cat > src/shared/lib/cart-context.jsx << 'END'
import { createContext, useContext, useEffect, useState } from 'react';
import { api } from '@/shared/api';

const CartContext = createContext(null);

export function CartProvider({ children }) {
  const [items, setItems] = useState([]);

  const refresh = async () => {
    try {
      const { data } = await api.get('/cart');
      setItems(data || []);
    } catch {
      setItems([]);
    }
  };

  useEffect(() => { refresh(); }, []);

  const addItem = async (product) => {
    const { data } = await api.post('/cart', { productId: product.id, qty: 1 });
    setItems(data);
  };

  const removeItem = async (id) => {
    const { data } = await api.delete(`/cart/${id}`);
    setItems(data);
  };

  const count = items.reduce((sum, item) => sum + item.qty, 0);
  const total = items.reduce((sum, item) => sum + item.price * item.qty, 0);

  return (
    <CartContext.Provider value={{ items, addItem, removeItem, count, total }}>
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  return useContext(CartContext);
}
END

cat > src/shared/lib/favorites-context.jsx << 'END'
import { createContext, useContext, useState } from 'react';

const FavoritesContext = createContext(null);

export function FavoritesProvider({ children }) {
  const [ids, setIds] = useState([]);

  const toggle = (id) => {
    setIds((prev) => prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]);
  };

  const isFavorite = (id) => ids.includes(id);

  return (
    <FavoritesContext.Provider value={{ ids, toggle, isFavorite }}>
      {children}
    </FavoritesContext.Provider>
  );
}

export function useFavorites() {
  return useContext(FavoritesContext);
}
END

cat > src/shared/lib/index.js << 'END'
export { cn } from './cn';
export { CartProvider, useCart } from './cart-context';
export { FavoritesProvider, useFavorites } from './favorites-context';
END

# =========================================
# SHARED / API
# =========================================
cat > src/shared/api/api.js << 'END'
import axios from 'axios';

export const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:3001/api',
  timeout: 8000,
  headers: { 'Content-Type': 'application/json' },
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) localStorage.removeItem('token');
    return Promise.reject(error);
  }
);
END

cat > src/shared/api/use-fetch.js << 'END'
import { useEffect, useState } from 'react';
import { api } from './api';

export function useFetch(url, params) {
  const [data, setData] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  const paramsKey = params ? JSON.stringify(params) : '';

  useEffect(() => {
    let cancelled = false;

    (async () => {
      setIsLoading(true);
      setError(null);
      try {
        const response = await api.get(url, { params });
        if (!cancelled) setData(response.data);
      } catch (err) {
        if (!cancelled) setError(err.response?.data?.message || err.message);
      } finally {
        if (!cancelled) setIsLoading(false);
      }
    })();

    return () => { cancelled = true; };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [url, paramsKey]);

  return { data, isLoading, error };
}
END

cat > src/shared/api/use-mutation.js << 'END'
import { useState } from 'react';
import { api } from './api';

export function useMutation(method, url) {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  const mutate = async (data) => {
    setIsLoading(true);
    setError(null);
    try {
      const response = await api[method](url, data);
      return response.data;
    } catch (err) {
      const message = err.response?.data?.message || err.message;
      setError(message);
      throw err;
    } finally {
      setIsLoading(false);
    }
  };

  return { mutate, isLoading, error };
}
END

cat > src/shared/api/index.js << 'END'
export { api } from './api';
export { useFetch } from './use-fetch';
export { useMutation } from './use-mutation';
END

# =========================================
# SHARED / UI
# =========================================

# --- button ---
cat > src/shared/ui/button/button.module.css << 'END'
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 12px 24px;
  border-radius: var(--radius);
  font-weight: 500;
  font-size: 14px;
  white-space: nowrap;
  transition: background 0.2s, color 0.2s;
}
.btn--primary { background: var(--blue); color: #fff; }
.btn--primary:hover { background: var(--blue-dark); }
.btn--yellow { background: var(--yellow); color: var(--text); }
.btn--yellow:hover { background: var(--yellow-dark); }
.btn--outline { border: 1px solid var(--blue); color: var(--blue); }
.btn--outline:hover { background: var(--blue); color: #fff; }
.btn--ghost { background: var(--bg-soft); color: var(--text); }
.btn--ghost:hover { background: var(--border); }
END

cat > src/shared/ui/button/button.jsx << 'END'
import { cn } from '@/shared/lib';
import styles from './button.module.css';

export function Button({ children, variant = 'primary', className, ...props }) {
  return (
    <button className={cn(styles.btn, styles[`btn--${variant}`], className)} {...props}>
      {children}
    </button>
  );
}
END

echo "export { Button } from './button';" > src/shared/ui/button/index.js

# --- container ---
cat > src/shared/ui/container/container.module.css << 'END'
.container {
  width: 100%;
  max-width: 1240px;
  margin: 0 auto;
  padding: 0 20px;
}
END

cat > src/shared/ui/container/container.jsx << 'END'
import { cn } from '@/shared/lib';
import styles from './container.module.css';

export function Container({ children, className }) {
  return <div className={cn(styles.container, className)}>{children}</div>;
}
END

echo "export { Container } from './container';" > src/shared/ui/container/index.js

# --- loader ---
cat > src/shared/ui/loader/loader.module.css << 'END'
.wrap { padding: 60px; text-align: center; color: var(--text-muted); font-size: 14px; }
.spinner {
  display: inline-block;
  width: 24px;
  height: 24px;
  border: 2px solid var(--border);
  border-top-color: var(--blue);
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
  margin-bottom: 12px;
}
@keyframes spin { to { transform: rotate(360deg); } }
END

cat > src/shared/ui/loader/loader.jsx << 'END'
import styles from './loader.module.css';

export function Loader({ text = 'Загрузка…' }) {
  return (
    <div className={styles.wrap}>
      <div className={styles.spinner} />
      <div>{text}</div>
    </div>
  );
}
END

echo "export { Loader } from './loader';" > src/shared/ui/loader/index.js

# --- error-message ---
cat > src/shared/ui/error-message/error-message.module.css << 'END'
.wrap { padding: 60px; text-align: center; color: var(--red); font-size: 14px; }
.title { font-weight: 600; margin-bottom: 4px; }
END

cat > src/shared/ui/error-message/error-message.jsx << 'END'
import styles from './error-message.module.css';

export function ErrorMessage({ message }) {
  return (
    <div className={styles.wrap}>
      <div className={styles.title}>Не удалось загрузить данные</div>
      <div>{message}</div>
    </div>
  );
}
END

echo "export { ErrorMessage } from './error-message';" > src/shared/ui/error-message/index.js

# --- section-title ---
cat > src/shared/ui/section-title/section-title.module.css << 'END'
.title {
  font-size: 28px;
  font-weight: 700;
  color: var(--text);
  position: relative;
  display: inline-block;
  padding-bottom: 6px;
  margin-bottom: 24px;
}
.title::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 3px;
  background: var(--blue);
}
END

cat > src/shared/ui/section-title/section-title.jsx << 'END'
import styles from './section-title.module.css';

export function SectionTitle({ children }) {
  return <h2 className={styles.title}>{children}</h2>;
}
END

echo "export { SectionTitle } from './section-title';" > src/shared/ui/section-title/index.js

# --- modal ---
cat > src/shared/ui/modal/modal.module.css << 'END'
.overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}
.dialog {
  background: #fff;
  border-radius: var(--radius);
  max-width: 560px;
  width: 100%;
  max-height: 90vh;
  overflow-y: auto;
  animation: slide 0.25s ease;
}
@keyframes slide {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: none; }
}
.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 24px;
  border-bottom: 1px solid var(--border);
}
.title { font-size: 18px; font-weight: 700; }
.close {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  font-size: 20px;
  color: var(--text-muted);
  transition: background 0.2s;
}
.close:hover { background: var(--bg-soft); }
.body { padding: 24px; }
END

cat > src/shared/ui/modal/modal.jsx << 'END'
import { useEffect } from 'react';
import styles from './modal.module.css';

export function Modal({ isOpen, onClose, title, children }) {
  useEffect(() => {
    const onEsc = (e) => { if (e.key === 'Escape') onClose(); };
    if (isOpen) document.addEventListener('keydown', onEsc);
    return () => document.removeEventListener('keydown', onEsc);
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  return (
    <div className={styles.overlay} onClick={onClose}>
      <div className={styles.dialog} onClick={(e) => e.stopPropagation()}>
        <div className={styles.header}>
          <div className={styles.title}>{title}</div>
          <button className={styles.close} onClick={onClose}>✕</button>
        </div>
        <div className={styles.body}>{children}</div>
      </div>
    </div>
  );
}
END

echo "export { Modal } from './modal';" > src/shared/ui/modal/index.js

cat > src/shared/ui/index.js << 'END'
export { Button } from './button';
export { Container } from './container';
export { Loader } from './loader';
export { ErrorMessage } from './error-message';
export { SectionTitle } from './section-title';
export { Modal } from './modal';
END

# =========================================
# ENTITIES
# =========================================

# --- product ---
cat > src/entities/product/use-products.js << 'END'
import { useFetch } from '@/shared/api';

export function useProducts(category) {
  return useFetch('/products', category ? { category } : undefined);
}
END

cat > src/entities/product/product-card.module.css << 'END'
.card {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 16px;
  background: #fff;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  transition: transform 0.25s, box-shadow 0.25s;
}
.card:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(0,0,0,0.08); }
.badge {
  position: absolute;
  top: 12px;
  left: 12px;
  padding: 4px 10px;
  background: var(--yellow);
  color: var(--text);
  font-size: 11px;
  font-weight: 700;
  border-radius: 4px;
  z-index: 1;
}
.badgeSale { background: var(--red); color: #fff; }
.fav {
  position: absolute;
  top: 12px;
  right: 12px;
  font-size: 20px;
  color: #ccc;
  z-index: 2;
  transition: color 0.2s, transform 0.2s;
}
.fav:hover { transform: scale(1.15); }
.favActive { color: var(--red); }
.image { width: 100%; aspect-ratio: 1; object-fit: contain; }
.title { font-size: 14px; font-weight: 500; line-height: 1.35; min-height: 38px; }
.size { font-size: 12px; color: var(--text-muted); }
.country { font-size: 13px; color: var(--text-muted); }
.prices { display: flex; gap: 10px; align-items: baseline; margin-top: auto; }
.price { font-size: 20px; font-weight: 700; }
.oldPrice { font-size: 13px; color: var(--red); text-decoration: line-through; }
.cartBtn {
  padding: 10px;
  border: 1px solid var(--blue);
  border-radius: var(--radius);
  background: #fff;
  color: var(--blue);
  font-weight: 500;
  transition: background 0.2s, color 0.2s;
}
.cartBtn:hover { background: var(--blue); color: #fff; }
.cartBtn:disabled { opacity: 0.5; cursor: not-allowed; }
END

cat > src/entities/product/product-card.jsx << 'END'
import { useState } from 'react';
import { useCart, useFavorites, cn } from '@/shared/lib';
import styles from './product-card.module.css';

export function ProductCard({ product }) {
  const { addItem } = useCart();
  const { toggle, isFavorite } = useFavorites();
  const [isAdding, setIsAdding] = useState(false);
  const isSale = product.badge === 'АКЦИЯ';
  const liked = isFavorite(product.id);

  const handleAdd = async () => {
    setIsAdding(true);
    try { await addItem(product); }
    finally { setIsAdding(false); }
  };

  return (
    <div className={styles.card}>
      {product.badge && (
        <span className={cn(styles.badge, isSale && styles.badgeSale)}>{product.badge}</span>
      )}
      <button className={cn(styles.fav, liked && styles.favActive)} onClick={() => toggle(product.id)}>
        {liked ? '♥' : '♡'}
      </button>

      <img src={product.image} alt={product.title} className={styles.image} />
      <div className={styles.title}>{product.title}</div>
      <div className={styles.size}>{product.size}</div>
      <div className={styles.country}>{product.country}</div>

      <div className={styles.prices}>
        <span className={styles.price}>{product.price?.toLocaleString()} ₽</span>
        {product.oldPrice && <span className={styles.oldPrice}>{product.oldPrice.toLocaleString()} ₽</span>}
      </div>

      <button className={styles.cartBtn} onClick={handleAdd} disabled={isAdding}>
        {isAdding ? 'Добавляем…' : 'В корзину'}
      </button>
    </div>
  );
}
END

cat > src/entities/product/index.js << 'END'
export { ProductCard } from './product-card';
export { useProducts } from './use-products';
END

# --- остальные сущности (только хуки) ---
mkdir -p src/entities/{banner,collection,brand,article}

cat > src/entities/banner/use-banners.js << 'END'
import { useFetch } from '@/shared/api';
export function useBanners() { return useFetch('/banners'); }
END
echo "export { useBanners } from './use-banners';" > src/entities/banner/index.js

cat > src/entities/collection/use-collections.js << 'END'
import { useFetch } from '@/shared/api';
export function useCollections() { return useFetch('/collections'); }
END
echo "export { useCollections } from './use-collections';" > src/entities/collection/index.js

cat > src/entities/brand/use-brands.js << 'END'
import { useFetch } from '@/shared/api';
export function useBrands() { return useFetch('/brands'); }
END
echo "export { useBrands } from './use-brands';" > src/entities/brand/index.js

cat > src/entities/article/use-articles.js << 'END'
import { useFetch } from '@/shared/api';
export function useArticles() { return useFetch('/articles'); }
END
echo "export { useArticles } from './use-articles';" > src/entities/article/index.js

# =========================================
# FEATURES
# =========================================
cat > src/features/add-to-cart/add-to-cart.js << 'END'
import { useMutation } from '@/shared/api';

export function useAddToCart() {
  return useMutation('post', '/cart');
}
END

echo "export { useAddToCart } from './add-to-cart';" > src/features/add-to-cart/index.js

echo ""
echo "ЧАСТЬ 1 ГОТОВА"
