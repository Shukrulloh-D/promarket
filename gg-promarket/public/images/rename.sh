#!/bin/bash

cd ~/Full/gg-promarket/public/images

# ========== БРЕНДЫ ==========
# Открой картинку через просмотрщик (двойной клик) — увидишь логотип.
# Подставь правильный номер файла.

# Например: если в "image 17.png" ты видишь Hansgrohe — запусти:
# mv "image 17.png" "brand-hansgrohe.png"

mv "image 17.png" "brand-hansgrohe.png"       # ← проверь что это Hansgrohe
mv "image 20.png" "brand-just.png"            # ← Just Deluxe
mv "image 21.png" "brand-cersanit.png"        # ← Cersanit
mv "image 25.png" "brand-villeroy.png"        # ← Villeroy & Boch
mv "image 26.png" "brand-ideal.png"           # ← Ideal Standard
mv "image 27.png" "brand-aquanika.png"        # ← Aquanika
mv "image 28.png" "brand-benetto.png"         # ← Benetto
mv "image 29.png" "brand-colombo.png"         # ← Colombo
mv "image 31.png" "brand-gorenje.png"         # ← Gorenje
mv "image 33.png" "brand-lvi.png"             # ← LVI

# ========== SEO-КАРТИНКА ==========
# "image 39(1).png" — там скорее всего кухня или ванная для SEO-блока
mv "image 39(1).png" "seo-image.png"

# ========== ОСТАЛЬНОЕ ==========
# "image 42.png" — скорее всего радиатор или что-то для хитов
# "image 45.png" — логотип Яндекс "Оцените магазин", оставь как есть
# "logo.png" — это логотип GG PROMARKET, оставь

# Проверь результат:
echo ""
echo "После переименования:"
ls -1
