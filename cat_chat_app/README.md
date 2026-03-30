# 貓談社 CatChat

Flutter Web 應用程式 — 貓保姆預約、行為諮詢、課程報名平台。

## 部署

本專案已整合至 [AI-GO-APP](https://github.com/AI-GO-APP) 組織的自動部署流程。

- **Staging 網址**：https://fde-catbehavior.staging.ai-go.app
- **觸發方式**：Push 至 `main` 分支即自動部署
- **手動觸發**：GitHub Actions → 部署到 Staging → Run workflow

## 本地開發

```bash
cd cat_chat_app

# Flutter 開發伺服器
flutter run -d chrome

# 或使用 Docker
docker-compose -f docker-compose.local.yml up --build
# 開啟 http://localhost:8080
```

## 專案結構

```
FDE-catbehavior/
├── .github/workflows/
│   └── deploy-staging.yml      # CI/CD 自動部署到 Staging
├── docker-compose.staging.yml  # Staging 用 Compose（根目錄）
└── cat_chat_app/               # Flutter 應用原始碼
    ├── Dockerfile              # 多階段建構（Flutter build + Nginx）
    ├── docker-compose.local.yml # 本地 Docker 開發用
    ├── lib/                    # Dart 原始碼
    └── web/                    # Flutter Web 資源
```

## 技術棧

- **前端**：Flutter Web (Dart)
- **容器化**：Docker（多階段建構）
- **Web Server**：Nginx Alpine
- **CI/CD**：GitHub Actions → AI-GO-APP Reusable Workflow
