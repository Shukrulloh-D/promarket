import { Container } from '@/shared/ui';
import styles from './advantages.module.css';

const ICONS = {
  truck: (
    <svg viewBox="0 0 48 48">
      <path d="M4 34V14a2 2 0 0 1 2-2h20v22" />
      <path d="M26 18h10l8 8v8h-4" />
      <circle cx="12" cy="36" r="4" />
      <circle cx="34" cy="36" r="4" />
      <path d="M16 36h14" />
    </svg>
  ),
  shield: (
    <svg viewBox="0 0 48 48">
      <path d="M24 4 8 11v12c0 9 7 17 16 21 9-4 16-12 16-21V11z" />
      <path d="m17 24 5 5 10-11" />
    </svg>
  ),
  goods: (
    <svg viewBox="0 0 48 48">
      <rect x="6" y="16" width="24" height="16" rx="1" />
      <path d="M30 20h8l6 6v6h-4" />
      <circle cx="14" cy="36" r="3" />
      <circle cx="36" cy="36" r="3" />
    </svg>
  ),
  ruble: (
    <svg viewBox="0 0 48 48">
      <circle cx="24" cy="24" r="18" />
      <path d="M20 34V14h6a6 6 0 0 1 0 12h-8M16 22h12" />
    </svg>
  ),
  thumbUp: (
    <svg viewBox="0 0 48 48">
      <path d="M14 22v16h24a4 4 0 0 0 4-3.5l2-10a3 3 0 0 0-3-3.5h-9l2-6a3 3 0 0 0-3-4l-6 10" />
      <rect x="6" y="22" width="8" height="16" rx="1" />
    </svg>
  ),
};

const ITEMS = [
  { icon: 'truck',  text: 'Быстрая доставка по Москве и в любой регион России' },
  { icon: 'shield', text: 'Все товары имеют официальную гарантию производителя' },
  { icon: 'goods',  text: 'Более 100 000 товаров' },
  { icon: 'ruble',  text: 'Любой способ оплаты' },
  { icon: 'thumbUp',text: 'Высокие оценки клиентов' },
];

export function Advantages() {
  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          {ITEMS.map((item) => (
            <div key={item.icon} className={styles.item}>
              <div className={styles.icon}>{ICONS[item.icon]}</div>
              <div className={styles.text}>{item.text}</div>
            </div>
          ))}
        </div>
      </Container>
    </section>
  );
}