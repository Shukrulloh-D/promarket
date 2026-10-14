import { useState } from 'react';
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useProducts, ProductCard } from '@/entities/product';
import { cn } from '@/shared/lib';
import styles from './hits.module.css';

const TABS = ['Любые товары', 'Раковины', 'Ванны', 'Унитазы', 'Душевые системы', 'Смесители', 'Зеркала', 'Душевые кабины', 'Стиральные машины'];

export function Hits() {
  const [activeTab, setActiveTab] = useState('Любые товары');
  const { data, isLoading, error } = useProducts('hit');

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;
 
  return (
    <section id="hits" className={styles.section}>
      <Container>
        <SectionTitle>Хиты продаж</SectionTitle>

        <div className={styles.tabs}>
          {TABS.map((tab) => (
            <button
              key={tab}
              className={cn(styles.tab, activeTab === tab && styles.tabActive)}
              onClick={() => setActiveTab(tab)}
            >
              {tab}
            </button>
          ))}
        </div>

        <div className={styles.grid}>
          {data.map((p) => (
            <ProductCard key={p.id} product={p} />
          ))}
        </div>
      </Container>
    </section>
  );
}
