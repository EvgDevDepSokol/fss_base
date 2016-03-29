find . -type f -name '*.haml' -exec sed -i -r 's/property:"REF"/property:"IC"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Сист."/property:"Система"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"TAG\/KKS"/property:"tag"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Описание"/property:"Desc"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Описание"/property:"ShortDesc"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Описание"/property:"Desc_RU"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Описание(EN)"/property:"Desc_EN"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Соединение"/property:"connection"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Помещение"/property:"room"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Компонент"/property:"model"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Алгоритм"/property:"Algorithm"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Сим. диаграмма"/property:"sd_N"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"TAG_RU"/property:"tag_RU"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"TAG\/KKS"/property:"tag_EN"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Сил. пит."/property:"ed_power"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Пит. сигн."/property:"anc_power"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"Тип в ИС"/property:"Тип В ИС"/g' {} \;
find . -type f -name '*.haml' -exec sed -i -r 's/property:"TAG\/KKS"/property:"kks"/g' {} \;
#%s/\("[^"]*"\)\/\("[^"]*"\)/property:\2\/property:\1/g
