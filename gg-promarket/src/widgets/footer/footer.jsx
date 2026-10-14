import { Container } from '@/shared/ui';
import { useState } from 'react';
import { CallModal } from '@/widgets/call-modal';
import styles from './footer.module.css';

const COLUMNS = [
  {
    title: 'Плитка',
    links: ['Сантехника', 'Мебель для ванной', 'Электроника и бытовая техника', 'Отопление', 'Напольное покрытие'],
  },
  {
    title: 'Оплата',
    links: ['Доставка', 'Поставщикам', 'Статьи', 'Контакты'],
  },
];

export function Footer() {
  const [callOpen, setCallOpen] = useState(false);

  return (
    <>
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
                <button className={styles.callBtn} onClick={() => setCallOpen(true)}>
                  ЗАКАЗАТЬ ЗВОНОК
                </button>
                <div className={styles.schedule}>
                  Пн-Пт: 10:00 – 20:00<br />
                  Сб: 10:00 – 18:00<br />
                  Вс: выходной
                </div>
                <div className={styles.social}>
                  <a href="#" aria-label="VK">
                    <img src="/images/icon-vk.png" alt="VK" />
                  </a>
                  <a href="#" aria-label="Instagram">
                    <img src="/images/icon-instagram.png" alt="Instagram" />
                  </a>
                  <a href="#" aria-label="Telegram">
                    <img src="/images/icon-telegram.png" alt="Telegram" />
                  </a>
                </div>
              </div>
            </div>

            <div className={styles.col}>
              <h4>Склад</h4>
              <div className={styles.schedule}>
                Москва, ул. Салтыковская, 6 стр 11<br />
                <a href="mailto:zakaz@ggpromarket.ru">zakaz@ggpromarket.ru</a>
              </div>
              <a href="#" className={styles.marketBtn}>
                <img src="/images/icon-yandex.png" alt="Яндекс.Маркет" />
                <span>Оцените магазин</span>
              </a>
            </div>
          </div>

          <div className={styles.bottom}>
            Копирование всех составляющих частей сайта в какой бы то ни было форме без письменного разрешения владельцев авторских прав запрещено. Сайт носит исключительно информационный характер, и ни при каких условиях не является публичной офертой.
            <div className={styles.bottomRow}>
              Сайт использует технологию cookie. Используя сайт, Вы соглашаетесь с{' '}
              <a href="#">правилами использования cookie</a>, а также даете{' '}
              <a href="#">согласие на обработку персональных данных</a>
            </div>
          </div>
        </Container>
      </footer>

      <CallModal isOpen={callOpen} onClose={() => setCallOpen(false)} />
    </>
  );
}