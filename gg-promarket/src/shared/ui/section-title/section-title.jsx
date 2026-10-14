import styles from './section-title.module.css';

export function SectionTitle({ children }) {
  return <h2 className={styles.title}>{children}</h2>;
}
 