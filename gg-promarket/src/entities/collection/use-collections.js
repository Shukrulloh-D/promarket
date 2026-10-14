import { useFetch } from '@/shared/api';

export function useCollections() {
  return useFetch('/collections');
}
 