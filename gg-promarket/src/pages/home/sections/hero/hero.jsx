import { useState } from 'react';
import { Container, Loader, ErrorMessage } from '@/shared/ui';
import { useBanners } from '@/entities/banner';
import { cn } from '@/shared/lib';
import styles from './hero.module.css';
 
export function Hero() {
  const { data, isLoading, error } = useBanners();
  const [slide, setSlide] = useState(0);

  if (isLoading) return <Loader />;
  if (error) return <ErrorMessage message={error} />;
  if (!data?.length) return null;

  const total = data.length;
  const next = () => setSlide((s) => (s + 1) % total);
  const prev = () => setSlide((s) => (s - 1 + total) % total);

  const main = data[slide];
  const side = data.filter((_, i) => i !== slide).slice(0, 2);

  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.grid}>
          <div className={styles.mainBanner}>
            <button className={`${styles.arrow} ${styles.arrowLeft}`} onClick={prev} aria-label="Предыдущий">‹</button>

            <div className={styles.mainContent} key={slide}>
              <h1>{main.title}</h1>
              <div className={styles.subtitle}>{main.subtitle}</div>
              <button className={styles.detailsBtn}>ПОДРОБНЕЕ</button>
            </div>

            <button className={`${styles.arrow} ${styles.arrowRight}`} onClick={next} aria-label="Следующий">›</button>

            <div className={styles.dots}>
              {data.map((_, i) => (
                <span
                  key={i}
                  className={cn(styles.dot, i === slide && styles.dotActive)}
                  onClick={() => setSlide(i)}
                />
              ))}
            </div>
          </div>

          <div className={styles.side}>
            {side.map((banner, i) => (
              <div
                key={banner.id}
                className={cn(styles.sideBanner, i === 0 ? styles.sideBlue : styles.sideTeal)}
              >
                <h3>{banner.title}</h3>
                <div className={styles.sideSub}>{banner.subtitle}</div>
                <button className={styles.detailsBtn}>ПОДРОБНЕЕ</button>
              </div>
            ))}
          </div>
        </div>
      </Container>
    </section>
  );
}