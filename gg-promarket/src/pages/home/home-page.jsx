import { Header } from '@/widgets/header';
import { Footer } from '@/widgets/footer';
import { Hero } from './sections/hero';
import { Advantages } from './sections/advantages';
import { Collections } from './sections/collections';
import { Hits } from './sections/hits';
import { Sales } from './sections/sales';
import { BannerStrip } from './sections/banner-strip';
import { Brands } from './sections/brands';
import { Articles } from './sections/articles';
import { SeoBlock } from './sections/seo-block';

export function HomePage() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <Advantages />
        <Collections />
        <Hits />
        <Sales />
        <BannerStrip />
        <Brands />
        <Articles />
        <SeoBlock />
      </main>
      <Footer />
    </>
  );
}
