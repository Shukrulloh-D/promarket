import { useFetch } from '@/shared/api';

export function useBanners() {
  return useFetch('/banners');
}
