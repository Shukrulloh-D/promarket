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
    <div className="page-appear">
      <Header />
      <main>
        <Hero />
        <div className="section-appear section-appear--1"><Advantages /></div>
        <div className="section-appear section-appear--2"><Collections /></div>
        <div className="section-appear section-appear--3"><Hits /></div>
        <div className="section-appear section-appear--4"><Sales /></div>
        <div className="section-appear section-appear--5"><BannerStrip /></div>
        <div className="section-appear section-appear--6"><Brands /></div>
        <div className="section-appear section-appear--7"><Articles /></div>
        <SeoBlock />
      </main>
      <Footer />
    </div>
  );
}