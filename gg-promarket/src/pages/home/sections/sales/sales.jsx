import { useState } from 'react';
import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useProducts, ProductCard } from '@/entities/product';
import { cn } from '@/shared/lib';
import styles from './sales.module.css';

const TABS = ['Любые товары', 'Смесители', 'Полотенцесушители', 'Биде', 'Душевые системы', 'Ванны', 'Унитазы', 'Отопители', 'Посудомоечные машины'];

export function Sales() {
  const [activeTab, setActiveTab] = useState('Любые товары');
  const { data, isLoading, error } = useProducts('sale');

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;
 
  return (
    <section id="sales" className={styles.section}>
      <Container>
        <SectionTitle>Акции</SectionTitle>

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
