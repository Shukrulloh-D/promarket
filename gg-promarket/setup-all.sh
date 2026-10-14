#!/bin/bash

# ==== ПАПКИ ====
mkdir -p src/app/providers src/app/styles
mkdir -p src/shared/api src/shared/lib
mkdir -p src/shared/ui/{Button,Container,Loader,ErrorMessage,SectionTitle}
mkdir -p src/widgets/{header,footer}
mkdir -p src/entities/{product,banner,collection,brand,article}
mkdir -p src/features/add-to-cart
mkdir -p src/pages/home/sections/{hero,advantages,collections,hits,sales,brands,articles,seo}
mkdir -p ../gg-promarket-server

# ==== MAIN ====
cat > src/main.jsx << 'END'
import React from 'react';
import ReactDOM from 'react-dom/client';
import { App } from './App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
END

# ==== INDEX.CSS ====
cat > src/index.css << 'END'
@import './app/styles/variables.css';

* { margin: 0; padding: 0; box-sizing: border-box; }
html { scroll-behavior: smooth; }
body {
  font-family: var(--font);
  font-size: 15px;
  line-height: 1.5;
  color: var(--color-text);
  background: var(--color-bg);
  -webkit-font-smoothing: antialiased;
}
img { display: block; max-width: 100%; }
a { color: inherit; text-decoration: none; }
button { font: inherit; cursor: pointer; border: none; background: none; }
ul { list-style: none; }
END

cat > src/app/styles/variables.css << 'END'
:root {
  --blue: #1a6ebd;
  --blue-dark: #0d4f8b;
  --blue-light: #e8f0fa;
  --yellow: #ffd700;
  --yellow-dark: #f0c400;
  --red: #e63946;
  --teal: #2ec4b6;
  --color-text: #1a1a1a;
  --color-text-muted: #6b7280;
  --color-bg: #ffffff;
  --color-bg-soft: #f5f7fa;
  --color-border: #e5e7eb;
  --font: 'Inter', system-ui, -apple-system, sans-serif;
  --radius: 8px;
  --radius-pill: 100px;
}
END

# ==== SHARED: API ====
cat > src/shared/api/client.js << 'END'
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

cat > src/shared/api/useFetch.js << 'END'
import { useEffect, useState } from 'react';
import { api } from './client';

export function useFetch(url, params) {
  const [data, setData] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  const paramsKey = params ? JSON.stringify(params) : '';

  useEffect(() => {
    let cancelled = false;
    async function load() {
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
    }
    load();
    return () => { cancelled = true; };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [url, paramsKey]);

  return { data, isLoading, error };
}
END

cat > src/shared/api/useMutation.js << 'END'
import { useState } from 'react';
import { api } from './client';

/**
 * Хук для POST/PUT/PATCH/DELETE.
 * Использование:
 *   const { mutate, isLoading, error } = useMutation('post', '/cart');
 *   mutate({ productId: 1 });
 */
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

echo "export { api } from './client';
export { useFetch } from './useFetch';
export { useMutation } from './useMutation';" > src/shared/api/index.js

# ==== SHARED: UI ====
cat > src/shared/ui/Button/Button.module.css << 'END'
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
.btn--yellow { background: var(--yellow); color: var(--color-text); }
.btn--yellow:hover { background: var(--yellow-dark); }
.btn--outline { border: 1px solid var(--blue); color: var(--blue); background: transparent; }
.btn--outline:hover { background: var(--blue); color: #fff; }
END

cat > src/shared/ui/Button/Button.jsx << 'END'
import { cn } from '@/shared/lib/cn';
import styles from './Button.module.css';

export function Button({ children, variant = 'primary', className, ...props }) {
  return (
    <button className={cn(styles.btn, styles[`btn--${variant}`], className)} {...props}>
      {children}
    </button>
  );
}
END

echo "export { Button } from './Button';" > src/shared/ui/Button/index.js

cat > src/shared/ui/Container/Container.module.css << 'END'
.container {
  width: 100%;
  max-width: 1240px;
  margin: 0 auto;
  padding: 0 20px;
}
END

cat > src/shared/ui/Container/Container.jsx << 'END'
import { cn } from '@/shared/lib/cn';
import styles from './Container.module.css';

export function Container({ children, className }) {
  return <div className={cn(styles.container, className)}>{children}</div>;
}
END

echo "export { Container } from './Container';" > src/shared/ui/Container/index.js

cat > src/shared/ui/Loader/Loader.jsx << 'END'
export function Loader() {
  return (
    <div style={{ padding: 60, textAlign: 'center', color: '#888' }}>
      Загрузка…
    </div>
  );
}
END

echo "export { Loader } from './Loader';" > src/shared/ui/Loader/index.js

cat > src/shared/ui/ErrorMessage/ErrorMessage.jsx << 'END'
export function ErrorMessage({ message }) {
  return (
    <div style={{ padding: 60, textAlign: 'center', color: '#e63946' }}>
      Ошибка: {message}
    </div>
  );
}
END

echo "export { ErrorMessage } from './ErrorMessage';" > src/shared/ui/ErrorMessage/index.js

cat > src/shared/ui/SectionTitle/SectionTitle.module.css << 'END'
.title {
  font-size: 28px;
  font-weight: 700;
  color: var(--color-text);
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

cat > src/shared/ui/SectionTitle/SectionTitle.jsx << 'END'
import styles from './SectionTitle.module.css';

export function SectionTitle({ children }) {
  return <h2 className={styles.title}>{children}</h2>;
}
END

echo "export { SectionTitle } from './SectionTitle';" > src/shared/ui/SectionTitle/index.js

cat > src/shared/ui/index.js << 'END'
export { Button } from './Button';
export { Container } from './Container';
export { Loader } from './Loader';
export { ErrorMessage } from './ErrorMessage';
export { SectionTitle } from './SectionTitle';
END

# ==== SHARED: LIB ====
cat > src/shared/lib/cn.js << 'END'
export function cn(...args) {
  return args.filter(Boolean).join(' ');
}
END

cat > src/shared/lib/index.js << 'END'
export { cn } from './cn';
END

echo "Пакет 1: shared готов"
