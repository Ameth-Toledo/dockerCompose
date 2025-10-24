# 🏗️ Arquitectura del Sistema - KarGaps

## Diagrama General de Microservicios
```
┌─────────────────────────────────────────────────────────────────────┐
│                    ARQUITECTURA DE MICROSERVICIOS                    │
│                   Ameth de Jesus Mendez Toledo                       │
└─────────────────────────────────────────────────────────────────────┘

                           USUARIO FINAL
                                │
                                │ HTTP
                                ▼
                    ┌───────────────────────┐
                    │   NAVEGADOR WEB       │
                    │   Chrome/Firefox/etc  │
                    └───────────┬───────────┘
                                │
                                │ Puerto 3000
                                ▼
┌───────────────────────────────────────────────────────────────────┐
│  CONTENEDOR: ameth-frontend-kargaps                               │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  FRONTEND - Angular 19                                      │ │
│  │  ───────────────────────────                                │ │
│  │  • Framework: Angular 19                                    │ │
│  │  • Lenguaje: TypeScript                                     │ │
│  │  • Estilos: Tailwind CSS                                    │ │
│  │  • Servidor: serve                                          │ │
│  │  • Puerto: 3000                                             │ │
│  │                                                              │ │
│  │  Componentes:                                               │ │
│  │  ├── Header (con nombre de Ameth)                          │ │
│  │  ├── Hero                                                   │ │
│  │  ├── Card Gorras                                            │ │
│  │  └── Card Playeras                                          │ │
│  │                                                              │ │
│  │  Servicios:                                                 │ │
│  │  ├── AuthService                                            │ │
│  │  ├── GorrasService                                          │ │
│  │  ├── PlayerasService                                        │ │
│  │  ├── UsersService                                           │ │
│  │  └── CarritoService                                         │ │
│  └─────────────────────────────────────────────────────────────┘ │
└───────────────────────────┬───────────────────────────────────────┘
                            │
                            │ HTTP REST API
                            │ http://backend:5000/api
                            ▼
┌───────────────────────────────────────────────────────────────────┐
│  CONTENEDOR: ameth-backend-kargaps                                │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  BACKEND API - Node.js + Express                            │ │
│  │  ────────────────────────────────────                       │ │
│  │  • Runtime: Node.js 20                                      │ │
│  │  • Framework: Express 5                                     │ │
│  │  • Lenguaje: TypeScript                                     │ │
│  │  • Arquitectura: Hexagonal (DDD)                            │ │
│  │  • Puerto: 5000                                             │ │
│  │                                                              │ │
│  │  Endpoints Principales:                                     │ │
│  │  ┌──────────────────────────────────────┐                  │ │
│  │  │ /api/users/toledo    [GET]           │ ← Endpoint       │ │
│  │  │ Retorna: "Ameth de Jesus             │   Personalizado  │ │
│  │  │          Mendez Toledo"              │                  │ │
│  │  └──────────────────────────────────────┘                  │ │
│  │                                                              │ │
│  │  Módulos (Arquitectura Hexagonal):                          │ │
│  │  ┌────────────────────────────────────────────────┐        │ │
│  │  │ USERS                                          │        │ │
│  │  │ ├── Domain (Entities, Repository Interface)   │        │ │
│  │  │ ├── Application (Use Cases)                   │        │ │
│  │  │ └── Infrastructure                             │        │ │
│  │  │     ├── Controllers                            │        │ │
│  │  │     ├── Adapters (PostgreSQL)                 │        │ │
│  │  │     └── Routes                                 │        │ │
│  │  └────────────────────────────────────────────────┘        │ │
│  │                                                              │ │
│  │  ┌────────────────────────────────────────────────┐        │ │
│  │  │ GORRAS                                         │        │ │
│  │  │ ├── Domain                                     │        │ │
│  │  │ ├── Application (CRUD Use Cases)              │        │ │
│  │  │ └── Infrastructure                             │        │ │
│  │  └────────────────────────────────────────────────┘        │ │
│  │                                                              │ │
│  │  ┌────────────────────────────────────────────────┐        │ │
│  │  │ PLAYERAS                                       │        │ │
│  │  │ ├── Domain                                     │        │ │
│  │  │ ├── Application (CRUD Use Cases)              │        │ │
│  │  │ └── Infrastructure                             │        │ │
│  │  └────────────────────────────────────────────────┘        │ │
│  │                                                              │ │
│  │  Core:                                                      │ │
│  │  ├── Security (JWT, bcrypt, auth middleware)               │ │
│  │  ├── Database (PostgreSQL connection)                      │ │
│  │  └── Cloudinary (Image upload)                             │ │
│  └─────────────────────────────────────────────────────────────┘ │
└───────────────────────────┬───────────────────────────────────────┘
                            │
                            │ SQL Queries
                            │ postgresql://ameth_user:***@database:5432
                            ▼
┌───────────────────────────────────────────────────────────────────┐
│  CONTENEDOR: ameth-database-kargaps                               │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │  BASE DE DATOS - PostgreSQL 17 Alpine                      │ │
│  │  ─────────────────────────────────────────                 │ │
│  │  • Motor: PostgreSQL 17                                     │ │
│  │  • Base de Datos: kargaps_db                               │ │
│  │  • Usuario: ameth_user                                      │ │
│  │  • Puerto: 5432                                             │ │
│  │                                                              │ │
│  │  Tablas:                                                    │ │
│  │  ┌──────────────────────────────────────┐                  │ │
│  │  │ roles                                │                  │ │
│  │  │ ├── id (PK)                          │                  │ │
│  │  │ ├── nombre                           │                  │ │
│  │  │ └── descripcion                      │                  │ │
│  │  └──────────────────────────────────────┘                  │ │
│  │                                                              │ │
│  │  ┌──────────────────────────────────────┐                  │ │
│  │  │ usuarios                             │                  │ │
│  │  │ ├── id (PK)                          │                  │ │
│  │  │ ├── nombres                          │                  │ │
│  │  │ ├── apellido_paterno                 │                  │ │
│  │  │ ├── apellido_materno                 │                  │ │
│  │  │ ├── email (UNIQUE)                   │                  │ │
│  │  │ ├── password_hash                    │                  │ │
│  │  │ ├── rol_id (FK → roles)              │                  │ │
│  │  │ └── avatar                           │                  │ │
│  │  └──────────────────────────────────────┘                  │ │
│  │                                                              │ │
│  │  ┌──────────────────────────────────────┐                  │ │
│  │  │ gorras                               │                  │ │
│  │  │ ├── id (PK)                          │                  │ │
│  │  │ ├── nombre                           │                  │ │
│  │  │ ├── descripcion                      │                  │ │
│  │  │ ├── precio                           │                  │ │
│  │  │ ├── stock                            │                  │ │
│  │  │ ├── color                            │                  │ │
│  │  │ └── imagen_url                       │                  │ │
│  │  └──────────────────────────────────────┘                  │ │
│  │                                                              │ │
│  │  ┌──────────────────────────────────────┐                  │ │
│  │  │ playeras                             │                  │ │
│  │  │ ├── id (PK)                          │                  │ │
│  │  │ ├── nombre                           │                  │ │
│  │  │ ├── descripcion                      │                  │ │
│  │  │ ├── precio                           │                  │ │
│  │  │ ├── stock                            │                  │ │
│  │  │ ├── color                            │                  │ │
│  │  │ ├── talla                            │                  │ │
│  │  │ ├── tipo                             │                  │ │
│  │  │ ├── material                         │                  │ │
│  │  │ └── imagen_url                       │                  │ │
│  │  └──────────────────────────────────────┘                  │ │
│  └─────────────────────────────────────────────────────────────┘ │
└───────────────────────────┬───────────────────────────────────────┘
                            │
                            │ Persistencia
                            ▼
                ┌───────────────────────────┐
                │  VOLUMEN DOCKER           │
                │  ameth_kargaps_           │
                │  persistent_data          │
                │                           │
                │  /var/lib/postgresql/data │
                └───────────────────────────┘


┌─────────────────────────────────────────────────────────────────┐
│                        RED DOCKER                                │
│                     ameth-network (bridge)                       │
│                                                                   │
│  Permite la comunicación interna entre contenedores usando       │
│  nombres de servicio como DNS:                                   │
│  • frontend → http://backend:5000                                │
│  • backend → postgresql://database:5432                          │
└─────────────────────────────────────────────────────────────────┘
```

## Flujo de Datos Detallado
```
┌──────────────────────────────────────────────────────────────────┐
│                      FLUJO DE SOLICITUD HTTP                      │
└──────────────────────────────────────────────────────────────────┘

1. USUARIO hace clic en "Ver Gorras"
   │
   ▼
2. FRONTEND (Angular) → Servicio HTTP
   │  Método: gorrasService.getAll()
   │  URL: http://backend:5000/api/gorras
   │
   ▼
3. BACKEND recibe solicitud
   │  Router → /api/gorras
   │  Controller → GetAllGorrasController
   │  Use Case → GetAllGorrasUseCase
   │
   ▼
4. REPOSITORY (Patrón Adapter)
   │  PostgreSQLAdapter → Ejecuta Query
   │  SQL: SELECT * FROM gorras;
   │
   ▼
5. DATABASE (PostgreSQL)
   │  Ejecuta consulta
   │  Lee datos del volumen persistente
   │  Retorna filas
   │
   ▼
6. BACKEND procesa respuesta
   │  Mapea datos a entidades
   │  Serializa a JSON
   │  Status: 200 OK
   │
   ▼
7. FRONTEND recibe JSON
   │  Actualiza componente
   │  Renderiza cards de gorras
   │  Usuario ve productos
   │
   ✅ FLUJO COMPLETADO
```

## Arquitectura Hexagonal (Backend)
```
┌────────────────────────────────────────────────────────────────┐
│                    ARQUITECTURA HEXAGONAL                       │
└────────────────────────────────────────────────────────────────┘

                    ┌───────────────────┐
                    │   Controllers     │ ← Capa de Presentación
                    │  (HTTP Handlers)  │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    Use Cases      │ ← Capa de Aplicación
                    │ (Lógica Negocio)  │
                    └─────────┬─────────┘
                              │
                              ▼
                ┌─────────────────────────────┐
                │         DOMAIN              │ ← Núcleo
                │  ┌─────────────────────┐    │
                │  │  Entities (Gorra,  │    │
                │  │  Playera, User)     │    │
                │  └─────────────────────┘    │
                │  ┌─────────────────────┐    │
                │  │  Repository         │    │
                │  │  Interfaces         │    │
                │  └─────────────────────┘    │
                └─────────────┬───────────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    Adapters       │ ← Capa de Infraestructura
                    │  (PostgreSQL)     │
                    └───────────────────┘
```

## Seguridad
```
┌────────────────────────────────────────────────────────────────┐
│                      FLUJO DE AUTENTICACIÓN                     │
└────────────────────────────────────────────────────────────────┘

1. Usuario envía credenciales
   POST /api/auth/login
   { "email": "user@example.com", "password": "****" }
   │
   ▼
2. Backend valida con bcrypt
   • Hash almacenado vs Password ingresada
   • bcrypt.compare(password, hash)
   │
   ▼
3. Si es válido, genera JWT
   • Payload: { userId, email, role }
   • Firma con SECRET_KEY
   • Expira en 24h
   │
   ▼
4. Frontend almacena token
   • LocalStorage/SessionStorage
   • Incluye en headers: Authorization: Bearer <token>
   │
   ▼
5. Requests posteriores
   • Backend valida JWT con middleware
   • Extrae userId del payload
   • Permite/Deniega acceso
```

## Persistencia de Datos
```
┌────────────────────────────────────────────────────────────────┐
│                    PERSISTENCIA CON VOLÚMENES                   │
└────────────────────────────────────────────────────────────────┘

Contenedor PostgreSQL
├── /var/lib/postgresql/data  ← Directorio de datos
│   └── (archivos BD)
│
└── MONTADO EN → Volumen Docker: ameth_kargaps_persistent_data

BENEFICIOS:
✅ Datos persisten aunque se detenga/elimine el contenedor
✅ Backup fácil con `docker volume`
✅ Compartible entre recreaciones del contenedor
✅ Independiente del ciclo de vida del contenedor

COMPROBACIÓN:
$ docker-compose down        # Detiene y elimina contenedores
$ docker volume ls           # Volumen sigue existiendo
$ docker-compose up -d       # Levanta de nuevo
$ # Los datos siguen ahí ✅
```

## Variables de Entorno
```yaml
Backend:
  DB_HOST: database           # Nombre del servicio en red Docker
  DB_PORT: 5432
  DB_NAME: kargaps_db         # ✅ Base de datos con nombre de Ameth
  DB_USER: ameth_user
  DB_PASSWORD: Ameth2005
  PORT: 5000
  NODE_ENV: production

Database:
  POSTGRES_DB: kargaps_db
  POSTGRES_USER: ameth_user
  POSTGRES_PASSWORD: Ameth2005

Frontend:
  API_URL: http://backend:5000
```

---

**Desarrollado por:** Ameth de Jesus Mendez Toledo  
**Proyecto:** Microservicios con Docker Compose  
**Fecha:** 2025
