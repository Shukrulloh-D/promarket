import { useState } from 'react';
import { Modal, Button } from '@/shared/ui';
import styles from './call-modal.module.css';

export function CallModal({ isOpen, onClose }) {
  const [form, setForm] = useState({ name: '', phone: '' });
  const [sent, setSent] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!form.name || !form.phone) return;
    setSent(true);
    setTimeout(() => {
      setSent(false);
      setForm({ name: '', phone: '' });
      onClose();
    }, 1500);
  };
 
  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Заказать звонок">
      {sent ? (
        <div className={styles.success}>
          ✓ Спасибо! Мы перезвоним в течение 15 минут.
        </div>
      ) : (
        <form className={styles.form} onSubmit={handleSubmit}>
          <div className={styles.field}>
            <label className={styles.label}>Ваше имя</label>
            <input
              className={styles.input}
              placeholder="Джон Уик"
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
            />
          </div>
          <div className={styles.field}>
            <label className={styles.label}>Телефон</label>
            <input
              className={styles.input}
              placeholder="+1 (10) 2026-10-14"
              value={form.phone}
              onChange={(e) => setForm({ ...form, phone: e.target.value })}
            />
          </div>
          <label className={styles.checkbox}>
            <input type="checkbox" defaultChecked />
            Согласен на обработку персональных данных
          </label>
          <Button type="submit" variant="primary">Отправить</Button>
        </form>
      )}
    </Modal>
  );
}