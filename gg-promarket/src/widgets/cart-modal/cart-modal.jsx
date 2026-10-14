import { Modal, Button } from '@/shared/ui';
import { useCart } from '@/shared/lib';
import styles from './cart-modal.module.css';

export function CartModal({ isOpen, onClose }) {
  const { items, removeItem, total } = useCart();

  const handleCheckout = () => {
    alert('Заказ оформлен!');
    onClose();
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Корзина">
      {items.length === 0 ? (
        <div className={styles.empty}>Корзина пуста</div>
      ) : (
        <>
          {items.map((item) => (
            <div key={item.id} className={styles.item}>
              <div>
                <div className={styles.itemTitle}>{item.title}</div>
                <div className={styles.itemPrice}>{item.price.toLocaleString('ru-RU')} ₽</div>
              </div>
              <div className={styles.qty}>× {item.qty}</div>
              <button className={styles.remove} onClick={() => removeItem(item.id)}>✕</button>
            </div>
          ))}

          <div className={styles.total}>
            <span>Итого:</span>
            <span>{total.toLocaleString('ru-RU')} ₽</span>
          </div>

          <div className={styles.actions}>
            <Button variant="ghost" onClick={onClose}>Продолжить</Button>
            <Button variant="primary" onClick={handleCheckout}>Оформить заказ</Button>
          </div>
        </>
      )}
    </Modal>
  );
}
