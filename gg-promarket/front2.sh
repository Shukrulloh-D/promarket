#!/bin/bash

# =========================================
# АЛИАСЫ
# =========================================
cat > vite.config.js << 'END'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
});
END

cat > jsconfig.json << 'END'
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"]
}
END

cat > index.html << 'END'
<!doctype html>
<html lang="ru">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>GG Promarket — сантехника и плитка</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
END

# =========================================
# ГЛОБАЛЬНЫЕ СТИЛИ
# =========================================
mkdir -p src/app/styles

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

# =========================================
# MAIN.JSX
# =========================================
cat > src/main.jsx << 'END'
import React from 'react';
import ReactDOM from 'react-dom/client';
import { App } from '@/app';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
END

# =========================================
# APP
# =========================================
cat > src/app/app.jsx << 'END'
import { CartProvider } from '@/shared/lib';
import { HomePage } from '@/pages/home';

export function App() {
  return (
    <CartProvider>
      <HomePage />
    </CartProvider>
  );
}
END

echo "export { App } from './app';" > src/app/index.js

# =========================================
# WIDGETS / HEADER
# =========================================
mkdir -p src/widgets/header

cat > src/widgets/header/header.module.css << 'END'
.top {
  background: var(--blue-light);
  padding: 8px 0;
  font-size: 13px;
  color: var(--color-text-muted);
}
.topInner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}
.topLeft, .topRight {
  display: flex;
  align-items: center;
  gap: 20px;
}
.phone { font-weight: 700; font-size: 16px; color: var(--color-text); }
.topRight a:hover { color: var(--blue); }

.main {
  background: #fff;
  border-bottom: 1px solid var(--color-border);
}
.mainInner {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 12px 0;
}
.logo {
  font-size: 22px;
  font-weight: 900;
  color: var(--blue);
  letter-spacing: -0.5px;
  white-space: nowrap;
}
.logoRed { color: var(--red); }
.catalogBtn {
  padding: 12px 18px;
  background: var(--blue);
  color: #fff;
  font-weight: 500;
  border-radius: var(--radius);
  display: inline-flex;
  align-items: center;
  gap: 8px;
  white-space: nowrap;
  transition: background 0.2s;
}
.catalogBtn:hover { background: var(--blue-dark); }
.nav {
  display: flex;
  gap: 20px;
  font-size: 14px;
  font-weight: 600;
  white-space: nowrap;
}
.nav a:hover { color: var(--blue); }

.searchWrap { flex: 1; position: relative; }
.searchInput {
  width: 100%;
  padding: 12px 44px 12px 16px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  font-size: 14px;
  outline: none;
  transition: border-color 0.2s;
}
.searchInput:focus { border-color: var(--blue); }
.searchIcon {
  position: absolute;
  right: 16px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--color-text-muted);
  pointer-events: none;
}

.icons {
  display: flex;
  gap: 16px;
  align-items: center;
  font-size: 20px;
}
.iconBtn {
  position: relative;
  padding: 4px;
  transition: color 0.2s;
}
.iconBtn:hover { color: var(--blue); }
.iconBadge {
  position: absolute;
  top: -4px;
  right: -8px;
  background: var(--yellow);
  color: var(--color-text);
  font-size: 10px;
  font-weight: 700;
  padding: 1px 5px;
  border-radius: 100px;
  min-width: 16px;
  text-align: center;
}

@media (max-width: 900px) {
  .nav, .topRight { display: none; }
}
END

cat > src/widgets/header/header.jsx << 'END'
import { useState } from 'react';
import { Container } from '@/shared/ui';
import { useCart } from '@/shared/lib';
import { CartModal } from '@/widgets/cart-modal';
import styles from './header.module.css';

export function Header() {
  const [cartOpen, setCartOpen] = useState(false);
  const { count } = useCart();

  return (
    <>
      <header>
        <div className={styles.top}>
          <Container>
            <div className={styles.topInner}>
              <div className={styles.topLeft}>
                <span>📍 Москва</span>
              </div>
              <div className={styles.topRight}>
                <span className={styles.phone}>8 495 018-32-10</span>
                <a href="#">Заказать звонок</a>
                <a href="#">Оплата</a>
                <a href="#">Доставка</a>
                <a href="#">Поставщикам</a>
                <a href="#">Статьи</a>
                <a href="#">Контакты</a>
              </div>
            </div>
          </Container>
        </div>

        <div className={styles.main}>
          <Container>
            <div className={styles.mainInner}>
              <a href="/" className={styles.logo}>
                GG <span className={styles.logoRed}>PROMARKET</span>
              </a>
              <button className={styles.catalogBtn}>☰ КАТАЛОГ ТОВАРОВ</button>
              <nav className={styles.nav}>
                <a href="#">АКЦИИ</a>
                <a href="#">БРЕНДЫ</a>
              </nav>
              <div className={styles.searchWrap}>
                <input className={styles.searchInput} placeholder="Что вы ищете?" />
                <span className={styles.searchIcon}>🔍</span>
              </div>
              <div className={styles.icons}>
                <button className={styles.iconBtn} title="Профиль">👤</button>
                <button className={styles.iconBtn} title="Избранное">♡</button>
                <button className={styles.iconBtn} onClick={() => setCartOpen(true)} title="Корзина">
                  🛒
                  {count > 0 && <span className={styles.iconBadge}>{count}</span>}
                </button>
              </div>
            </div>
          </Container>
        </div>
      </header>

      <CartModal isOpen={cartOpen} onClose={() => setCartOpen(false)} />
    </>
  );
}
END

echo "export { Header } from './header';" > src/widgets/header/index.js

# =========================================
# WIDGETS / FOOTER
# =========================================
mkdir -p src/widgets/footer

cat > src/widgets/footer/footer.module.css << 'END'
.footer {
  background: var(--blue-light);
  padding: 60px 0 30px;
  margin-top: 60px;
}
.grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 30px;
  margin-bottom: 40px;
}
.col h4 {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  margin-bottom: 16px;
  color: var(--color-text-muted);
}
.col a {
  display: block;
  font-size: 14px;
  margin-bottom: 10px;
}
.col a:hover { color: var(--blue); }
.contacts {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
.phone {
  font-size: 22px;
  font-weight: 700;
  color: var(--color-text);
}
.callBtn {
  padding: 10px 16px;
  border: 1px solid var(--blue);
  color: var(--blue);
  border-radius: var(--radius);
  font-size: 12px;
  font-weight: 600;
  width: fit-content;
  transition: background 0.2s, color 0.2s;
}
.callBtn:hover { background: var(--blue); color: #fff; }
.schedule {
  font-size: 13px;
  color: var(--color-text-muted);
  line-height: 1.9;
}
.bottom {
  border-top: 1px solid rgba(0, 0, 0, 0.08);
  padding-top: 20px;
  font-size: 12px;
  color: var(--color-text-muted);
  text-align: center;
  line-height: 1.6;
}
@media (max-width: 900px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
}
END

cat > src/widgets/footer/footer.jsx << 'END'
import { Container } from '@/shared/ui';
import styles from './footer.module.css';

const COLUMNS = [
  { title: 'Плитка', links: ['Сантехника', 'Мебель для ванной', 'Электроника и бытовая техника', 'Отопление', 'Напольное покрытие'] },
  { title: 'Оплата', links: ['Доставка', 'Поставщикам', 'Статьи', 'Контакты'] },
  { title: 'Помощь', links: ['Частые вопросы', 'О компании', 'Доставка и оплата', 'Возврат'] },
];

export function Footer() {
  return (
    <footer className={styles.footer}>
      <Container>
        <div className={styles.grid}>
          {COLUMNS.map((col) => (
            <div key={col.title} className={styles.col}>
              <h4>{col.title}</h4>
              {col.links.map((link) => (
                <a key={link} href="#">{link}</a>
              ))}
            </div>
          ))}

          <div className={styles.col}>
            <div className={styles.contacts}>
              <div className={styles.phone}>8 495 018-32-10</div>
              <button className={styles.callBtn}>ЗАКАЗАТЬ ЗВОНОК</button>
              <div className={styles.schedule}>
                Пн-Пт: 10:00 – 20:00<br />
                Сб: 10:00 – 18:00<br />
                Вс: выходной
              </div>
            </div>
          </div>

          <div className={styles.col}>
            <h4>Склад</h4>
            <div className={styles.schedule}>
              Москва, ул. Салтыковская, 6 стр 11<br />
              <a href="mailto:zakaz@ggpromarket.ru">zakaz@ggpromarket.ru</a>
            </div>
          </div>
        </div>

        <div className={styles.bottom}>
          © 2020 ggpromarket.ru · Все права защищены.<br />
          Сайт использует технологию cookie. Используя сайт, вы соглашаетесь с правилами использования cookie.
        </div>
      </Container>
    </footer>
  );
}
END

echo "export { Footer } from './footer';" > src/widgets/footer/index.js

# =========================================
# WIDGETS / CART-MODAL
# =========================================
mkdir -p src/widgets/cart-modal

cat > src/widgets/cart-modal/cart-modal.module.css << 'END'
.empty {
  padding: 40px 0;
  text-align: center;
  color: var(--color-text-muted);
}
.item {
  display: grid;
  grid-template-columns: 1fr auto auto;
  gap: 16px;
  align-items: center;
  padding: 16px 0;
  border-bottom: 1px solid var(--color-border);
}
.itemTitle { font-size: 14px; font-weight: 500; }
.itemPrice { font-size: 13px; color: var(--color-text-muted); }
.qty { font-size: 13px; font-weight: 600; }
.remove {
  color: var(--red);
  font-size: 18px;
  padding: 4px 8px;
  transition: opacity 0.2s;
}
.remove:hover { opacity: 0.6; }
.total {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 0;
  font-size: 18px;
  font-weight: 700;
}
.actions {
  display: flex;
  gap: 12px;
  margin-top: 16px;
}
.actions > * { flex: 1; }
END

cat > src/widgets/cart-modal/cart-modal.jsx << 'END'
import { Modal, Button } from '@/shared/ui';
import { useCart } from '@/shared/lib';
import styles from './cart-modal.module.css';

export function CartModal({ isOpen, onClose }) {
  const { items, removeItem, total } = useCart();

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Корзина">
      {items.length === 0 ? (
        <div className={styles.empty}>Корзина пуста</div>
      ) : (
        <>
          {items.map((item) => (
            <div key={item.id} className={styles.item}>
              <div>
                <div className={styles.itemTitle}>{item.title}</div>
                <div className={styles.itemPrice}>{item.price.toLocaleString()} ₽</div>
              </div>
              <div className={styles.qty}>× {item.qty}</div>
              <button className={styles.remove} onClick={() => removeItem(item.id)}>✕</button>
            </div>
          ))}

          <div className={styles.total}>
            <span>Итого:</span>
            <span>{total.toLocaleString()} ₽</span>
          </div>

          <div className={styles.actions}>
            <Button variant="ghost" onClick={onClose}>Продолжить покупки</Button>
            <Button variant="primary" onClick={() => alert('Заказ оформлен!')}>Оформить заказ</Button>
          </div>
        </>
      )}
    </Modal>
  );
}
END

echo "export { CartModal } from './cart-modal';" > src/widgets/cart-modal/index.js

# =========================================
# СЕКЦИИ СТРАНИЦЫ
# =========================================

# --- HERO ---
mkdir -p src/pages/home/sections/hero
cat > src/pages/home/sections/hero/hero.module.css << 'END'
.section { padding: 20px 0; }
.grid { display: grid; grid-template-columns: 2fr 1fr; gap: 16px; }
.mainBanner {
  background: var(--blue-dark);
  color: #fff;
  padding: 60px 40px;
  border-radius: var(--radius);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  min-height: 380px;
}
.mainBanner h1 {
  font-size: 40px;
  font-weight: 800;
  letter-spacing: 0.05em;
  margin-bottom: 12px;
}
.mainBanner p { font-size: 20px; font-weight: 600; margin-bottom: 24px; }
.detailsBtn {
  padding: 12px 28px;
  background: var(--yellow);
  color: var(--color-text);
  font-weight: 700;
  border-radius: var(--radius);
  transition: background 0.2s;
}
.detailsBtn:hover { background: var(--yellow-dark); }
.side { display: flex; flex-direction: column; gap: 16px; }
.sideBanner {
  flex: 1;
  padding: 30px;
  border-radius: var(--radius);
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}
.sideBlue { background: var(--blue-dark); }
.sideTeal { background: var(--teal); }
.sideBanner h3 { font-size: 24px; font-weight: 700; margin-bottom: 6px; }
.sideBanner p { font-size: 14px; opacity: 0.85; }
@media (max-width: 900px) { .grid { grid-template-columns: 1fr; } .mainBanner h1 { font-size: 28px; } }
END

cat > src/pages/home/sections/hero/hero.jsx << 'END'
import { Container, Loader, ErrorMessage } from '@/shared/ui';
import { useBanners } from '@/entities/banner';
import styles from './hero.module.css';

export function Hero() {
  const { data, isLoading, error } = useBanners();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  const [main, ...rest] = data;

  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <div className={styles.mainBanner}>
            <h1>{main.title}</h1>
            <p>{main.subtitle}</p>
            <button className={styles.detailsBtn}>ПОДРОБНЕЕ</button>
          </div>
          <div className={styles.side}>
            {rest.slice(0, 2).map((banner, i) => (
              <div key={banner.id} className={`${styles.sideBanner} ${i === 0 ? styles.sideBlue : styles.sideTeal}`}>
                <h3>{banner.title}</h3>
                <p>{banner.subtitle}</p>
              </div>
            ))}
          </div>
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Hero } from './hero';" > src/pages/home/sections/hero/index.js

# --- COLLECTIONS ---
mkdir -p src/pages/home/sections/collections
cat > src/pages/home/sections/collections/collections.module.css << 'END'
.section { padding: 40px 0; }
.grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  grid-template-rows: 1fr 1fr;
  gap: 12px;
  height: 500px;
}
.card { position: relative; border-radius: var(--radius); overflow: hidden; cursor: pointer; }
.card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s; }
.card:hover img { transform: scale(1.05); }
.card:nth-child(1) { grid-row: 1 / 3; }
.label {
  position: absolute;
  bottom: 20px;
  left: 20px;
  background: var(--teal);
  color: #fff;
  padding: 6px 14px;
  border-radius: 4px;
  font-size: 13px;
  font-weight: 600;
}
.brand {
  position: absolute;
  bottom: 4px;
  left: 20px;
  color: #fff;
  font-size: 11px;
  text-shadow: 0 1px 4px rgba(0,0,0,0.7);
}
@media (max-width: 900px) {
  .grid { grid-template-columns: 1fr 1fr; height: auto; }
  .card:nth-child(1) { grid-column: 1 / 3; grid-row: auto; height: 300px; }
  .card { height: 200px; }
}
END

cat > src/pages/home/sections/collections/collections.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useCollections } from '@/entities/collection';
import styles from './collections.module.css';

export function Collections() {
  const { data, isLoading, error } = useCollections();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  return (
    <section className={styles.section}>
      <Container>
        <SectionTitle>Коллекции плитки</SectionTitle>
        <div className={styles.grid}>
          {data.map((c) => (
            <div key={c.id} className={styles.card}>
              <img src={c.image} alt={c.name} />
              <span className={styles.label}>{c.name}</span>
              <span className={styles.brand}>{c.brand}</span>
            </div>
          ))}
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Collections } from './collections';" > src/pages/home/sections/collections/index.js

# --- HITS ---
mkdir -p src/pages/home/sections/hits
cat > src/pages/home/sections/hits/hits.module.css << 'END'
.section { padding: 40px 0; }
.grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 16px; }
@media (max-width: 1100px) { .grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 640px) { .grid { grid-template-columns: repeat(2, 1fr); } }
END

cat > src/pages/home/sections/hits/hits.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useProducts, ProductCard } from '@/entities/product';
import styles from './hits.module.css';

export function Hits() {
  const { data, isLoading, error } = useProducts('hit');

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  return (
    <section className={styles.section}>
      <Container>
        <SectionTitle>Хиты продаж</SectionTitle>
        <div className={styles.grid}>
          {data.map((p) => <ProductCard key={p.id} product={p} />)}
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Hits } from './hits';" > src/pages/home/sections/hits/index.js

# --- SALES ---
mkdir -p src/pages/home/sections/sales
cat > src/pages/home/sections/sales/sales.module.css << 'END'
.section { padding: 40px 0; }
.grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 16px; }
@media (max-width: 1100px) { .grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 640px) { .grid { grid-template-columns: repeat(2, 1fr); } }
END

cat > src/pages/home/sections/sales/sales.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useProducts, ProductCard } from '@/entities/product';
import styles from './sales.module.css';

export function Sales() {
  const { data, isLoading, error } = useProducts('sale');

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  return (
    <section className={styles.section}>
      <Container>
        <SectionTitle>Акции</SectionTitle>
        <div className={styles.grid}>
          {data.map((p) => <ProductCard key={p.id} product={p} />)}
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Sales } from './sales';" > src/pages/home/sections/sales/index.js

# --- BRANDS ---
mkdir -p src/pages/home/sections/brands
cat > src/pages/home/sections/brands/brands.module.css << 'END'
.section { padding: 40px 0; }
.grid { display: grid; grid-template-columns: repeat(6, 1fr); gap: 12px; }
.card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  aspect-ratio: 2 / 1.2;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  transition: border-color 0.2s, box-shadow 0.2s;
}
.card:hover { border-color: var(--blue); box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06); }
.card img { max-height: 40px; object-fit: contain; }
@media (max-width: 900px) { .grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 500px) { .grid { grid-template-columns: repeat(2, 1fr); } }
END

cat > src/pages/home/sections/brands/brands.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useBrands } from '@/entities/brand';
import styles from './brands.module.css';

export function Brands() {
  const { data, isLoading, error } = useBrands();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  return (
    <section className={styles.section}>
      <Container>
        <SectionTitle>Популярные бренды</SectionTitle>
        <div className={styles.grid}>
          {data.map((b) => (
            <div key={b.id} className={styles.card}>
              <img src={b.logo} alt={b.name} />
            </div>
          ))}
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Brands } from './brands';" > src/pages/home/sections/brands/index.js

# --- ARTICLES ---
mkdir -p src/pages/home/sections/articles
cat > src/pages/home/sections/articles/articles.module.css << 'END'
.section { padding: 40px 0 80px; }
.grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
.card { display: flex; flex-direction: column; gap: 12px; cursor: pointer; }
.card img { width: 100%; aspect-ratio: 4 / 3; object-fit: cover; border-radius: var(--radius); transition: opacity 0.2s; }
.card:hover img { opacity: 0.85; }
.title { font-size: 14px; line-height: 1.4; }
@media (max-width: 900px) { .grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 500px) { .grid { grid-template-columns: 1fr; } }
END

cat > src/pages/home/sections/articles/articles.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useArticles } from '@/entities/article';
import styles from './articles.module.css';

export function Articles() {
  const { data, isLoading, error } = useArticles();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  return (
    <section className={styles.section}>
      <Container>
        <SectionTitle>Статьи</SectionTitle>
        <div className={styles.grid}>
          {data.map((a) => (
            <div key={a.id} className={styles.card}>
              <img src={a.image} alt={a.title} />
              <div className={styles.title}>{a.title}</div>
            </div>
          ))}
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Articles } from './articles';" > src/pages/home/sections/articles/index.js

# --- SEO ---
mkdir -p src/pages/home/sections/seo
cat > src/pages/home/sections/seo/seo.module.css << 'END'
.section { padding: 60px 0; background: var(--color-bg-soft); }
.grid { display: grid; grid-template-columns: 1fr 1.2fr; gap: 40px; align-items: center; }
.grid img { width: 100%; border-radius: var(--radius); }
.content h2 { font-size: 32px; font-weight: 700; margin-bottom: 20px; }
.content p { font-size: 15px; line-height: 1.7; color: var(--color-text-muted); margin-bottom: 16px; }
@media (max-width: 900px) { .grid { grid-template-columns: 1fr; } }
END

cat > src/pages/home/sections/seo/seo.jsx << 'END'
import { Container } from '@/shared/ui';
import styles from './seo.module.css';

export function Seo() {
  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <img src="/images/seo-image.png" alt="" />
          <div className={styles.content}>
            <h2>Блок SEO-текста про магазин</h2>
            <p>GG Promarket — крупный ритейлер сантехнического оборудования, плитки и аксессуаров. Мы нацелены на то, чтобы сделать процесс выбора и покупки сантехники максимально простым и интуитивно понятным.</p>
            <p>При создании и обновлении сайта мы продумали логичную структуру каталога, организовали систему поиска, снабдили карточки товаров подробными описаниями и характеристиками.</p>
            <p>Выбрать оборудование в нашем магазине легко даже тем, кто впервые имеет дело с сантехникой. Уточнить детали и получить информацию о совместимости товаров помогут опытные консультанты контакт-центра.</p>
          </div>
        </div>
      </Container>
    </section>
  );
}
END
echo "export { Seo } from './seo';" > src/pages/home/sections/seo/index.js

# =========================================
# PAGE: HOME
# =========================================
cat > src/pages/home/home-page.jsx << 'END'
import { Header } from '@/widgets/header';
import { Footer } from '@/widgets/footer';
import { Hero } from './sections/hero';
import { Collections } from './sections/collections';
import { Hits } from './sections/hits';
import { Sales } from './sections/sales';
import { Brands } from './sections/brands';
import { Articles } from './sections/articles';
import { Seo } from './sections/seo';

export function HomePage() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <Collections />
        <Hits />
        <Sales />
        <Brands />
        <Articles />
        <Seo />
      </main>
      <Footer />
    </>
  );
}
END

echo "export { HomePage } from './home-page';" > src/pages/home/index.js

# Убираем старый App.jsx (перенесли в src/app/app.jsx)
rm -f src/App.jsx
rm -rf src/pages/home/sections/advantages

echo ""
echo "==========================================="
echo "ФРОНТ СОБРАН"
echo "==========================================="
echo ""
echo "Проверь что запущено:"
echo "  1) Терминал 1: cd gg-promarket-server && npm start"
echo "  2) Терминал 2: cd gg-promarket && npm run dev"
echo ""
echo "Открой: http://localhost:5173"
echo ""
