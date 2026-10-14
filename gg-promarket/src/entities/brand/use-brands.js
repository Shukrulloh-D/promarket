import { useFetch } from '@/shared/api';

export function useBrands() {
  return useFetch('/brands');
}
