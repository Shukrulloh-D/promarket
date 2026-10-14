import { useState } from 'react';
import { Container } from '@/shared/ui';
import { useCart, useFavorites } from '@/shared/lib';
import { CartModal } from '@/widgets/cart-modal';
import { CallModal } from '@/widgets/call-modal';
import styles from './header.module.css';

export function Header() {
  const [cartOpen, setCartOpen] = useState(false);
  const [callOpen, setCallOpen] = useState(false);
  const { count } = useCart();
  const { ids } = useFavorites();

  return (
    <>
      <header className={styles.header}>
        {/* Верхняя строка */}
        <div className={styles.top}>
          <Container>
            <div className={styles.topInner}>
              <a href="/" className={styles.logo}>
                <img src="/images/logo.png" alt="GG PROMARKET" />
              </a> 

              <div className={styles.location}>Москва</div>

              <div className={styles.phoneBlock}>
                <span className={styles.phone}>8 495 018-32-10</span>
                <button className={styles.callback} onClick={() => setCallOpen(true)}>
                  Заказать звонок
                </button>
              </div>

              <nav className={styles.topLinks}>
                <a href="#">Оплата</a>
                <a href="#">Доставка</a>
                <a href="#">Поставщикам</a>
                <a href="#articles">Статьи</a>
                <a href="#">Контакты</a>
              </nav>
            </div>
          </Container>
        </div>

        <div className={styles.main}>
          <Container>
            <div className={styles.mainInner}>
              <button className={styles.catalogBtn}>КАТАЛОГ ТОВАРОВ</button>
              <a href="#sales" className={styles.navBtn}>АКЦИИ</a>
              <a href="#brands" className={styles.navBtn + ' ' + styles.navBtnBrands}>БРЕНДЫ</a>

              <div className={styles.searchWrap}>
                <input
                  className={styles.searchInput}
                  placeholder="Что вы ищете?"
                />
                <button className={styles.searchIcon} aria-label="Найти">
                  <svg viewBox="0 0 24 24" width="18" height="18" fill="none"
                    stroke="currentColor" strokeWidth="2" strokeLinecap="round">
                    <circle cx="11" cy="11" r="7" />
                    <path d="m21 21-4.35-4.35" />
                  </svg>
                </button>
              </div>

              <div className={styles.icons}>
                <button className={styles.iconBtn} title="Профиль">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                    strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                    <circle cx="12" cy="7" r="4" />
                  </svg>
                </button>

                <button className={styles.iconBtn} title="Избранное">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                    strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                  </svg>
                  {ids.length > 0 && <span className={styles.iconBadge}>{ids.length}</span>}
                </button>

                <button
                  className={styles.iconBtn}
                  onClick={() => setCartOpen(true)}
                  title="Корзина"
                >
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                    strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                    <circle cx="9" cy="21" r="1" />
                    <circle cx="20" cy="21" r="1" />
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" />
                  </svg>
                  {count > 0 && <span className={styles.iconBadge}>{count}</span>}
                </button>
              </div>
            </div>
          </Container>
        </div>
      </header>

      <CartModal isOpen={cartOpen} onClose={() => setCartOpen(false)} />
      <CallModal isOpen={callOpen} onClose={() => setCallOpen(false)} />
    </>
  );
}