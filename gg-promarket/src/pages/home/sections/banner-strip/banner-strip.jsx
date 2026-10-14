import { Container } from '@/shared/ui';
import styles from './banner-strip.module.css';

export function BannerStrip() {
  return (
    <section className={styles.section}>
      <Container>
        <div className={styles.strip}>ЕЩЕ ОДИН БАННЕР</div>
      </Container>
    </section>
  );
}
 