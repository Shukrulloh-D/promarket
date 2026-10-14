import styles from './loader.module.css';

export function Loader({ text = 'Загрузка…' }) {
  return (
    <div className={styles.wrap}>
      <div className={styles.spinner} />
      <div>{text}</div>
    </div>
  );
}
 