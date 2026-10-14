#!/bin/bash

# ==== ENTITY: product ====
cat > src/entities/product/useProducts.js << 'END'
import { useFetch } from '@/shared/api';

/**
 * GET /products?category=hit
 * Возвращает { data, isLoading, error }
 */
export function useProducts(category) {
  return useFetch('/products', category ? { category } : undefined);
}
END

cat > src/entities/product/ProductCard.module.css << 'END'
.card {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 16px;
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  transition: transform 0.25s, box-shadow 0.25s;
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.08);
}
.badge {
  position: absolute;
  top: 12px;
  left: 12px;
  padding: 4px 10px;
  background: var(--yellow);
  color: var(--color-text);
  font-size: 11px;
  font-weight: 600;
  border-radius: 4px;
  z-index: 1;
}
.badgeSale { background: var(--red); color: #fff; }
.image { width: 100%; aspect-ratio: 1; object-fit: contain; }
.title { font-size: 14px; font-weight: 500; line-height: 1.35; min-height: 38px; }
.size { font-size: 12px; color: var(--color-text-muted); }
.country { font-size: 13px; color: var(--color-text-muted); }
.prices {
  display: flex;
  gap: 10px;
  align-items: baseline;
  margin-top: auto;
}
.price { font-size: 20px; font-weight: 700; }
.oldPrice { font-size: 13px; color: var(--red); text-decoration: line-through; }
.cartBtn {
  padding: 10px;
  border: 1px solid var(--blue);
  border-radius: var(--radius);
  background: #fff;
  color: var(--blue);
  font-weight: 500;
  cursor: pointer;
  transition: background 0.2s, color 0.2s;
}
.cartBtn:hover { background: var(--blue); color: #fff; }
.cartBtn:disabled { opacity: 0.5; cursor: not-allowed; }
END

cat > src/entities/product/ProductCard.jsx << 'END'
import { useAddToCart } from '@/features/add-to-cart';
import styles from './ProductCard.module.css';

export function ProductCard({ product }) {
  const { mutate: addToCart, isLoading } = useAddToCart();
  const isSale = product.badge === 'АКЦИЯ';

  const handleAdd = async () => {
    try {
      await addToCart({ productId: product.id, qty: 1 });
      alert('Товар добавлен в корзину');
    } catch (err) {
      alert('Ошибка: ' + err.message);
    }
  };

  return (
    <div className={styles.card}>
      {product.badge && (
        <span className={`${styles.badge} ${isSale ? styles.badgeSale : ''}`}>
          {product.badge}
        </span>
      )}
      <img src={product.image} alt={product.title} className={styles.image} />
      <div className={styles.title}>{product.title}</div>
      <div className={styles.size}>{product.size}</div>
      <div className={styles.country}>{product.country}</div>
      <div className={styles.prices}>
        <span className={styles.price}>{product.price?.toLocaleString()} ₽</span>
        {product.oldPrice && (
          <span className={styles.oldPrice}>{product.oldPrice.toLocaleString()} ₽</span>
        )}
      </div>
      <button className={styles.cartBtn} onClick={handleAdd} disabled={isLoading}>
        {isLoading ? 'Добавляем…' : 'В корзину'}
      </button>
    </div>
  );
}
END

cat > src/entities/product/index.js << 'END'
export { ProductCard } from './ProductCard';
export { useProducts } from './useProducts';
END

# ==== ENTITY: banner ====
cat > src/entities/banner/useBanners.js << 'END'
import { useFetch } from '@/shared/api';

export function useBanners() {
  return useFetch('/banners');
}
END

cat > src/entities/banner/index.js << 'END'
export { useBanners } from './useBanners';
END

# ==== ENTITY: collection ====
cat > src/entities/collection/useCollections.js << 'END'
import { useFetch } from '@/shared/api';

export function useCollections() {
  return useFetch('/collections');
}
END

cat > src/entities/collection/index.js << 'END'
export { useCollections } from './useCollections';
END

# ==== ENTITY: brand ====
cat > src/entities/brand/useBrands.js << 'END'
import { useFetch } from '@/shared/api';

export function useBrands() {
  return useFetch('/brands');
}
END

cat > src/entities/brand/index.js << 'END'
export { useBrands } from './useBrands';
END

# ==== ENTITY: article ====
cat > src/entities/article/useArticles.js << 'END'
import { useFetch } from '@/shared/api';

export function useArticles() {
  return useFetch('/articles');
}
END

cat > src/entities/article/index.js << 'END'
export { useArticles } from './useArticles';
END

# ==== FEATURE: add-to-cart ====
cat > src/features/add-to-cart/useAddToCart.js << 'END'
import { useMutation } from '@/shared/api';

/**
 * POST /cart
 * Возвращает { mutate, isLoading, error }
 */
export function useAddToCart() {
  return useMutation('post', '/cart');
}
END

cat > src/features/add-to-cart/index.js << 'END'
export { useAddToCart } from './useAddToCart';
END

echo "Пакет 2 готов: entities + features"
