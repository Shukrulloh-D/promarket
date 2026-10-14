import styles from './error-message.module.css';

export function ErrorMessage({ message }) {
  return (
    <div className={styles.wrap}>
      <div className={styles.title}>Не удалось загрузить данные</div>
      <div>{message}</div>
    </div>
  );
}
