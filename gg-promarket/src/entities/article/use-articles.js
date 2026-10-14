import { useFetch } from '@/shared/api';

export function useArticles() {
  return useFetch('/articles');
}
 