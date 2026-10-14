import { useMutation } from '@/shared/api';

// POST /cart — добавляет товар в корзину
export function useAddToCart() {
  return useMutation('post', '/cart');
}
