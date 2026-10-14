import { useState } from 'react';
import { api } from './client';

export function useMutation(method, url) {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
 
  const mutate = async (data) => {
    setIsLoading(true);
    setError(null);
    try {
      const response = await api[method](url, data);
      return response.data;
    } catch (err) {
      const message = err.response?.data?.message || err.message;
      setError(message);
      throw err;
    } finally {
      setIsLoading(false);
    }
  };

  return { mutate, isLoading, error };
}
