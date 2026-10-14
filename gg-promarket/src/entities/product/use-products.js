import { useFetch } from '@/shared/api';

export function useProducts(category) {
  return useFetch('/products', category ? { category } : undefined);
}
 