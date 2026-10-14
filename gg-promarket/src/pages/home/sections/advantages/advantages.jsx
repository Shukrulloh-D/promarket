import { Container } from '@/shared/ui';
import styles from './advantages.module.css';

const ITEMS = [
  { icon: '🚚', text: 'Быстрая доставка по Москве и в любой регион России' },
  { icon: '✓',  text: 'Все товары имеют официальную гарантию производителя' },
  { icon: '🚛', text: 'Более 100 000 товаров' },
  { icon: '₽',  text: 'Любой способ оплаты' },
  { icon: '👍', text: 'Высокие оценки клиентов' },
];

export function Advantages() {
  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          {ITEMS.map((item, i) => (
            <div key={i} className={styles.item}>
              <div className={styles.icon}>{item.icon}</div>
              <div className={styles.text}>{item.text}</div>
            </div>
          ))}
        </div>
      </Container>
    </section>
  );
}
