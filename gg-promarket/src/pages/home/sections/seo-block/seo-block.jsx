import { Container } from '@/shared/ui';
import styles from './seo-block.module.css';

export function SeoBlock() {
  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <img className={styles.image} src="/images/seo-image.png" alt="seo" />
          <div className={styles.content}>
            <h2>Блок SEO-текста про магазин</h2>
            <p>GG Promarket — крупный ритейлер сантехнического оборудования, плитки и аксессуаров. Мы нацелены на то, чтобы сделать процесс выбора и покупки сантехники максимально простым и интуитивно понятным.</p>
            <p>При создании и обновлении сайта santehnika-online.ru мы продумали логичную структуру каталога, организовали систему поиска, снабдили карточки товаров подробными описаниями и характеристиками.</p>
            <p>Выбрать оборудование в нашем магазине легко даже тем, кто впервые имеет дело с сантехникой. Уточнить детали и получить информацию о совместимости товаров помогут опытные консультанты нашего контакт-центра. С нами вы полюбите выбирать!</p>
          </div>
        </div>
      </Container>
    </section>
  );
}
