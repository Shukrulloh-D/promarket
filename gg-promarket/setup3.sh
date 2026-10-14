#!/bin/bash

# ==== WIDGET: header ====
cat > src/widgets/header/Header.module.css << 'END'
.top {
  background: var(--blue-light);
  padding: 8px 0;
  font-size: 13px;
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
.phone {
  font-weight: 600;
  font-size: 16px;
}

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
  font-size: 24px;
  font-weight: 900;
  color: var(--blue);
  letter-spacing: -0.5px;
}
.logoRed { color: var(--red); }
.catalogBtn {
  padding: 12px 20px;
  background: var(--blue);
  color: #fff;
  font-weight: 500;
  border-radius: var(--radius);
  display: inline-flex;
  align-items: center;
  gap: 8px;
}
.nav {
  display: flex;
  gap: 20px;
  font-size: 14px;
  font-weight: 500;
}
.searchWrap {
  flex: 1;
  max-width: 500px;
  position: relative;
}
.searchInput {
  width: 100%;
  padding: 12px 44px 12px 16px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  font-size: 14px;
}
.searchInput:focus { outline: none; border-color: var(--blue); }
.searchIcon {
  position: absolute;
  right: 16px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--color-text-muted);
}
.icons {
  display: flex;
  gap: 16px;
  align-items: center;
}
.iconBtn { position: relative; }
.iconBadge {
  position: absolute;
  top: -6px;
  right: -8px;
  background: var(--yellow);
  color: var(--color-text);
  font-size: 10px;
  font-weight: 700;
  padding: 1px 5px;
  border-radius: 100px;
}
END

cat > src/widgets/header/Header.jsx << 'END'
import { Container } from '@/shared/ui';
import styles from './Header.module.css';

export function Header() {
  return (
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
            </div>
            <nav className={styles.topRight}>
              <a href="#">Оплата</a>
              <a href="#">Доставка</a>
              <a href="#">Поставщикам</a>
              <a href="#">Статьи</a>
              <a href="#">Контакты</a>
            </nav>
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
              <div className={styles.iconBtn}>👤</div>
              <div className={styles.iconBtn}>♡</div>
              <div className={styles.iconBtn}>
                🛒 <span className={styles.iconBadge}>3</span>
              </div>
            </div>
          </div>
        </Container>
      </div>
    </header>
  );
}
END

echo "export { Header } from './Header';" > src/widgets/header/index.js

# ==== WIDGET: footer ====
cat > src/widgets/footer/Footer.module.css << 'END'
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
  font-size: 13px;
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
  color: var(--color-text);
}
.col a:hover { color: var(--blue); }
.contacts {
  display: flex;
  flex-direction: column;
  gap: 8px;
}
.phone {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 8px;
}
.callBtn {
  padding: 8px 16px;
  border: 1px solid var(--blue);
  color: var(--blue);
  border-radius: var(--radius);
  font-size: 13px;
  width: fit-content;
}
.schedule {
  font-size: 13px;
  color: var(--color-text-muted);
  line-height: 1.8;
}
.bottom {
  border-top: 1px solid rgba(0, 0, 0, 0.08);
  padding-top: 20px;
  font-size: 12px;
  color: var(--color-text-muted);
  text-align: center;
  line-height: 1.6;
}
END

cat > src/widgets/footer/Footer.jsx << 'END'
import { Container } from '@/shared/ui';
import styles from './Footer.module.css';

const COLUMNS = [
  { title: 'Плитка', links: ['Сантехника', 'Мебель для ванной', 'Электроника и бытовая техника', 'Отопление', 'Напольное покрытие'] },
  { title: 'Оплата', links: ['Доставка', 'Поставщикам', 'Статьи', 'Контакты'] },
  { title: 'Помощь', links: ['Часто задаваемые вопросы', 'О компании', 'Доставка и оплата', 'Возврат'] },
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

echo "export { Footer } from './Footer';" > src/widgets/footer/index.js

# ==== SECTIONS ====

# --- HERO / BANNERS ---
cat > src/pages/home/sections/hero/Hero.module.css << 'END'
.section { padding: 20px 0; }
.grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 16px;
}
.mainBanner {
  background: var(--blue-dark);
  color: #fff;
  padding: 60px 40px;
  border-radius: var(--radius);
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  min-height: 380px;
}
.mainBanner h1 {
  font-size: 40px;
  font-weight: 800;
  letter-spacing: 0.05em;
  margin-bottom: 12px;
}
.mainBanner p {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 24px;
}
.side {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.sideBanner {
  flex: 1;
  padding: 30px;
  border-radius: var(--radius);
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
}
.sideBlue { background: var(--blue-dark); }
.sideTeal { background: var(--teal); }
.sideBanner h3 { font-size: 24px; font-weight: 700; margin-bottom: 6px; }
.sideBanner p { font-size: 14px; opacity: 0.85; }
.state { padding: 60px; text-align: center; color: #888; }
@media (max-width: 900px) { .grid { grid-template-columns: 1fr; } }
END

cat > src/pages/home/sections/hero/Hero.jsx << 'END'
import { Container, Loader, ErrorMessage } from '@/shared/ui';
import { useBanners } from '@/entities/banner';
import styles from './Hero.module.css';

export function Hero() {
  const { data, isLoading, error } = useBanners();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  const main = data[0];
  const side = data.slice(1, 3);

  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <div className={styles.mainBanner}>
            <h1>{main.title}</h1>
            <p>{main.subtitle}</p>
            <div>
              <a href="#" className="btn-yellow">ПОДРОБНЕЕ</a>
            </div>
          </div>
          <div className={styles.side}>
            {side.map((banner, i) => (
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

echo "export { Hero } from './Hero';" > src/pages/home/sections/hero/index.js

# --- COLLECTIONS ---
cat > src/pages/home/sections/collections/Collections.module.css << 'END'
.section { padding: 40px 0; }
.grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  grid-template-rows: repeat(2, 1fr);
  gap: 12px;
  height: 500px;
}
.card {
  position: relative;
  border-radius: var(--radius);
  overflow: hidden;
  cursor: pointer;
}
.card img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s;
}
.card:hover img { transform: scale(1.05); }
.card:nth-child(1) { grid-row: 1 / 3; }
.card:nth-child(4) { grid-column: 2 / 3; }
.card:nth-child(5) { grid-column: 3 / 4; }
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
  bottom: 0;
  left: 20px;
  padding: 0 0 4px;
  color: #fff;
  font-size: 11px;
  text-shadow: 0 1px 4px rgba(0,0,0,0.6);
}
@media (max-width: 900px) {
  .grid { grid-template-columns: 1fr 1fr; height: auto; }
  .card:nth-child(1) { grid-column: 1 / 3; grid-row: auto; height: 300px; }
  .card { height: 200px; }
}
END

cat > src/pages/home/sections/collections/Collections.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useCollections } from '@/entities/collection';
import styles from './Collections.module.css';

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

echo "export { Collections } from './Collections';" > src/pages/home/sections/collections/index.js

# --- HITS ---
cat > src/pages/home/sections/hits/Hits.module.css << 'END'
.section { padding: 40px 0; }
.grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16px;
}
@media (max-width: 1100px) { .grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 640px) { .grid { grid-template-columns: repeat(2, 1fr); } }
END

cat > src/pages/home/sections/hits/Hits.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useProducts, ProductCard } from '@/entities/product';
import styles from './Hits.module.css';

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
          {data.map((p) => (
            <ProductCard key={p.id} product={p} />
          ))}
        </div>
      </Container>
    </section>
  );
}
END

echo "export { Hits } from './Hits';" > src/pages/home/sections/hits/index.js

# --- SALES ---
cat > src/pages/home/sections/sales/Sales.module.css << 'END'
.section { padding: 40px 0; }
.grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16px;
}
@media (max-width: 1100px) { .grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 640px) { .grid { grid-template-columns: repeat(2, 1fr); } }
END

cat > src/pages/home/sections/sales/Sales.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useProducts, ProductCard } from '@/entities/product';
import styles from './Sales.module.css';

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
          {data.map((p) => (
            <ProductCard key={p.id} product={p} />
          ))}
        </div>
      </Container>
    </section>
  );
}
END

echo "export { Sales } from './Sales';" > src/pages/home/sections/sales/index.js

# --- BRANDS ---
cat > src/pages/home/sections/brands/Brands.module.css << 'END'
.section { padding: 40px 0; }
.grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 12px;
}
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
.card:hover {
  border-color: var(--blue);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
}
.card img { max-height: 40px; object-fit: contain; }
@media (max-width: 900px) { .grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 500px) { .grid { grid-template-columns: repeat(2, 1fr); } }
END

cat > src/pages/home/sections/brands/Brands.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useBrands } from '@/entities/brand';
import styles from './Brands.module.css';

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

echo "export { Brands } from './Brands';" > src/pages/home/sections/brands/index.js

# --- ARTICLES ---
cat > src/pages/home/sections/articles/Articles.module.css << 'END'
.section { padding: 40px 0 80px; }
.grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}
.card {
  display: flex;
  flex-direction: column;
  gap: 12px;
  cursor: pointer;
}
.card img {
  width: 100%;
  aspect-ratio: 4 / 3;
  object-fit: cover;
  border-radius: var(--radius);
  transition: opacity 0.2s;
}
.card:hover img { opacity: 0.85; }
.title {
  font-size: 14px;
  line-height: 1.4;
  color: var(--color-text);
}
@media (max-width: 900px) { .grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 500px) { .grid { grid-template-columns: 1fr; } }
END

cat > src/pages/home/sections/articles/Articles.jsx << 'END'
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useArticles } from '@/entities/article';
import styles from './Articles.module.css';

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

echo "export { Articles } from './Articles';" > src/pages/home/sections/articles/index.js

# --- SEO ---
cat > src/pages/home/sections/seo/Seo.module.css << 'END'
.section { padding: 60px 0; background: var(--color-bg-soft); }
.grid {
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 40px;
  align-items: center;
}
.grid img {
  width: 100%;
  border-radius: var(--radius);
}
.content { padding: 20px; }
.content h2 {
  font-size: 32px;
  font-weight: 700;
  margin-bottom: 20px;
}
.content p {
  font-size: 15px;
  line-height: 1.7;
  color: var(--color-text-muted);
  margin-bottom: 16px;
}
@media (max-width: 900px) { .grid { grid-template-columns: 1fr; } }
END

cat > src/pages/home/sections/seo/Seo.jsx << 'END'
import { Container } from '@/shared/ui';
import styles from './Seo.module.css';

export function Seo() {
  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <img src="/images/seo-image.png" alt="" />
          <div className={styles.content}>
            <h2>Блок SEO-текста про магазин</h2>
            <p>
              GG Promarket — крупный ритейлер сантехнического оборудования,
              плитки и аксессуаров. Мы нацелены на то, чтобы сделать процесс
              выбора и покупки сантехники максимально простым и интуитивно
              понятным.
            </p>
            <p>
              При создании и обновлении сайта мы продумали логичную структуру
              каталога, организовали систему поиска, снабдили карточки товаров
              подробными описаниями и характеристиками.
            </p>
            <p>
              Выбрать оборудование в нашем магазине легко даже тем, кто впервые
              имеет дело с сантехникой. Уточнить детали и получить информацию
              о совместимости товаров помогут опытные консультанты контакт-центра.
            </p>
          </div>
        </div>
      </Container>
    </section>
  );
}
END

echo "export { Seo } from './Seo';" > src/pages/home/sections/seo/index.js

# ==== PAGE: home ====
cat > src/pages/home/HomePage.jsx << 'END'
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

echo "export { HomePage } from './HomePage';" > src/pages/home/index.js

# ==== APP ====
cat > src/App.jsx << 'END'
import { HomePage } from '@/pages/home';

export function App() {
  return <HomePage />;
}
END

echo "Пакет 3 готов: widgets + страницы"
