# 第一階段：編譯前端資源
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

# 複製 pubspec 並取得套件
COPY pubspec.* ./
RUN flutter pub get

# 複製原始碼並編譯 Web 版本
COPY . .
RUN flutter build web --release

# 第二階段：伺服器佈署
FROM nginx:alpine
# 將編譯產出的檔案複製到 nginx 預設的網頁伺服器資料夾
COPY --from=build /app/build/web /usr/share/nginx/html
# 覆蓋預設的 Nginx 配置，以支援 SPA 路由 (History Mode)
RUN echo "server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
        try_files \$uri \$uri/ /index.html; \
    } \
}" > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
