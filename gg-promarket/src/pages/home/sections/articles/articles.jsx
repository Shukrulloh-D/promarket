import { Container, Loader, ErrorMessage, SectionTitle } from '@/shared/ui';
import { useArticles } from '@/entities/article';
import styles from './articles.module.css';

export function Articles() {
  const { data, isLoading, error } = useArticles();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;
 
  return (<section id="articles" className={styles.section}>
      <Container>
        <SectionTitle>Статьи</SectionTitle>
        <div className={styles.gridWrap}>
          <button className={`${styles.arrow} ${styles.arrowLeft}`}>‹</button>
          <div className={styles.grid}>
            {data.map((a) => (
              <div key={a.id} className={styles.card}>
                <img src={a.image} alt={a.title} />
                <div className={styles.title}>{a.title}</div>
              </div>
            ))}
          </div>
          <button className={`${styles.arrow} ${styles.arrowRight}`}>›</button>
        </div>
      </Container>
    </section>
  );
}
