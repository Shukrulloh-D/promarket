import { Container, Loader, ErrorMessage } from '@/shared/ui';
import { useBanners } from '@/entities/banner';
import styles from './hero.module.css';

export function Hero() {
  const { data, isLoading, error } = useBanners();

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  const [main, ...rest] = data;

  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <div className={styles.mainBanner}>
            <button className={`${styles.arrow} ${styles.arrowLeft}`}>‹</button>
            <h1>{main.title}</h1>
            <p>{main.subtitle}</p>
            <button className={styles.detailsBtn}>ПОДРОБНЕЕ</button>
            <button className={`${styles.arrow} ${styles.arrowRight}`}>›</button>
            <div className={styles.dots}>
              <span className={`${styles.dot} ${styles.dotActive}`} />
              <span className={styles.dot} />
              <span className={styles.dot} />
              <span className={styles.dot} />
              <span className={styles.dot} />
            </div>
          </div>

          <div className={styles.side}>
            {rest.slice(0, 2).map((banner, i) => (
              <div
                key={banner.id}
                className={`${styles.sideBanner} ${i === 0 ? styles.sideBlue : styles.sideTeal}`}
              >
                <h3>{banner.title}</h3>
                <p>{banner.subtitle}</p>
                <button className={styles.detailsBtn}>ПОДРОБНЕЕ</button>
              </div>
            ))}
          </div>
        </div>
      </Container>
    </section>
  );
}
