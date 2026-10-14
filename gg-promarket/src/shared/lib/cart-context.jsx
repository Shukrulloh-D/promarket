import { createContext, useContext, useEffect, useState } from 'react';
import { api } from '@/shared/api';

const CartContext = createContext(null);
 
export function CartProvider({ children }) {
  const [items, setItems] = useState([]);

  const refresh = async () => {
    try {
      const { data } = await api.get('/cart');
      setItems(data || []);
    } catch {
      setItems([]);
    }
  };
 
  useEffect(() => { refresh(); }, []);

  const addItem = async (product) => {
    const { data } = await api.post('/cart', { productId: product.id, qty: 1 });
    setItems(data);
  };

  const removeItem = async (id) => {
    const { data } = await api.delete(`/cart/${id}`);
    setItems(data);
  };

  const count = items.reduce((sum, item) => sum + item.qty, 0);
  const total = items.reduce((sum, item) => sum + item.price * item.qty, 0);

  return (
    <CartContext.Provider value={{ items, addItem, removeItem, count, total }}>
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  return useContext(CartContext);
}
