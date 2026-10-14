import { useState } from 'react';
import { useCart, useFavorites, cn } from '@/shared/lib';
import styles from './product-card.module.css';
 
export function ProductCard({ product }) {
  const { addItem } = useCart();
  const { toggle, isFavorite } = useFavorites();
  const [isAdding, setIsAdding] = useState(false);

  const isSale = product.badge === 'АКЦИЯ';
  const liked = isFavorite(product.id);
  const rating = product.rating ?? 5;
  const reviews = product.reviews ?? 0;

  const handleAdd = async () => {
    setIsAdding(true);
    try {
      await addItem(product);
    } catch (err) {
      alert('Ошибка: ' + err.message);
    } finally {
      setIsAdding(false);
    }
  };

  return (
    <div className={styles.card}>
      {product.badge && (
        <span className={cn(styles.badge, isSale && styles.badgeSale)}>
          {product.badge}
        </span>
      )}

      <button
        className={cn(styles.fav, liked && styles.favActive)}
        onClick={() => toggle(product.id)}
        aria-label="В избранное"
      >
        {liked ? '♥' : '♡'}
      </button>

      <img src={product.image} alt={product.title} className={styles.image} />

      <div className={styles.rating}>
        <span className={styles.stars}>{'★'.repeat(rating)}</span>
        <span className={styles.reviews}>{reviews}</span>
      </div>

      <div className={styles.title}>{product.title}</div>
      <div className={styles.size}>{product.size}</div>
      <div className={styles.country}>{product.country}</div>

      <div className={styles.prices}>
        <span className={styles.price}>{product.price?.toLocaleString('ru-RU')} ₽</span>
        {product.oldPrice && (
          <span className={styles.oldPrice}>
            {product.oldPrice.toLocaleString('ru-RU')} ₽
          </span>
        )}
      </div>

      <button className={styles.cartBtn} onClick={handleAdd} disabled={isAdding}>
        {isAdding ? 'Добавляем…' : 'В КОРЗИНУ'}
      </button>
    </div>
  );
}
