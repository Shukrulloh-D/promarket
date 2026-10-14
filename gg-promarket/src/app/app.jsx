import { CartProvider, FavoritesProvider } from '@/shared/lib';
import { HomePage } from '@/pages/home';

export function App() {
  return (
    <CartProvider>
      <FavoritesProvider>
        <HomePage />
      </FavoritesProvider>
    </CartProvider>
  );
}
