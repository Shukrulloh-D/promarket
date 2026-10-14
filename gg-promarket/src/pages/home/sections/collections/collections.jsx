import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useCollections } from '@/entities/collection';
import styles from './collections.module.css';

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
          {data.slice(0, 5).map((c) => (
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
