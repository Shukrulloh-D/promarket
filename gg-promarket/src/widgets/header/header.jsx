import { useState } from 'react';
import { Container } from '@/shared/ui';
import { useCart, useFavorites } from '@/shared/lib';
import { CartModal } from '@/widgets/cart-modal';
import styles from './header.module.css';

export function Header() {
  const [cartOpen, setCartOpen] = useState(false);
  const { count } = useCart();
  const { ids } = useFavorites();

  return (
    <>
      <header>
        <div className={styles.top}>
          <Container>
            <div className={styles.topInner}>
              <div className={styles.location}>📍 Москва</div>

              <div className={styles.phoneBlock}>
                <span className={styles.phone}>8 495 018-32-10</span>
                <a href="#" className={styles.callback}>Заказать звонок</a>
              </div>

              <nav className={styles.topLinks}>
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
              <button className={styles.catalogBtn}>☰ КАТАЛОГ ТОВАРОВ</button>
              <button className={styles.navBtn}>АКЦИИ</button>
              <button className={`${styles.navBtn} ${styles.navBtnBrands}`}>БРЕНДЫ</button>

              <div className={styles.searchWrap}>
                <input className={styles.searchInput} placeholder="Что вы ищете?" />
                <span className={styles.searchIcon}>🔍</span>
              </div>

              <div className={styles.icons}>
                <button className={styles.iconBtn} title="Профиль">👤</button>
                <button className={styles.iconBtn} title="Избранное">
                  ♡
                  {ids.length > 0 && <span className={styles.iconBadge}>{ids.length}</span>}
                </button>
                <button
                  className={styles.iconBtn}
                  onClick={() => setCartOpen(true)}
                  title="Корзина"
                >
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
