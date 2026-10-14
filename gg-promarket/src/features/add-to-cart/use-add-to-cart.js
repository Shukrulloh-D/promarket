import { useMutation } from '@/shared/api';
// Корзина
export function useAddToCart() {
  return useMutation('post', '/cart');
}
