import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useBrands } from '@/entities/brand';
import styles from './brands.module.css';

export function Brands() {
  const { data, isLoading, error } = useBrands();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  return (
   <section id="brands" className={styles.section}>
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
