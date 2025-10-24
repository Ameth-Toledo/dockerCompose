# 🚀 Microservicios KarGaps - Ameth de Jesus Mendez Toledo

Sistema de microservicios para gestión de productos (gorras y playeras) desarrollado con Docker, Node.js, Angular y PostgreSQL.

## 📋 Tabla de Contenidos
- [Arquitectura](#arquitectura)
- [Tecnologías](#tecnologías)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Endpoints API](#endpoints-api)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Pruebas de Persistencia](#pruebas-de-persistencia)

## 🏗️ Arquitectura

El sistema está compuesto por tres servicios principales:
```
┌─────────────────────────────────────────────────────────────┐
│                     ARQUITECTURA DE MICROSERVICIOS           │
└─────────────────────────────────────────────────────────────┘

    ┌─────────────────┐
    │   FRONTEND      │ Puerto 3000
    │   Angular 19    │ (ameth-frontend-kargaps)
    │   Node 20       │
    └────────┬────────┘
             │
             │ HTTP Requests
             │
    ┌────────▼────────┐
    │   BACKEND       │ Puerto 5000
    │   Node.js       │ (ameth-backend-kargaps)
    │   Express       │
    │   TypeScript    │
    └────────┬────────┘
             │
             │ SQL Queries
             │
    ┌────────▼────────┐
    │   DATABASE      │ Puerto 5432
    │   PostgreSQL 17 │ (ameth-database-kargaps)
    │   Alpine        │
    └─────────────────┘
             │
             │ Persistencia
             ▼
    ┌─────────────────┐
    │    VOLUMEN      │
    │ ameth_kargaps_  │
    │ persistent_data │
    └─────────────────┘

Red Interna: ameth-network (Bridge)
```

### Flujo de Datos
```
Usuario → Frontend (Angular) → API REST (Express) → PostgreSQL → Volumen
   ↑                                                                  │
   └──────────────────── Respuesta JSON ◄──────────────────────────┘
```

## 🛠️ Tecnologías

### Frontend
- **Framework:** Angular 19
- **Lenguaje:** TypeScript
- **Estilos:** Tailwind CSS
- **Servidor:** serve (para producción)

### Backend
- **Runtime:** Node.js 20
- **Framework:** Express 5
- **Lenguaje:** TypeScript
- **Arquitectura:** Hexagonal (Domain-Driven Design)
- **Autenticación:** JWT + bcrypt
- **ORM:** pg (PostgreSQL native)
- **Upload:** Cloudinary + Multer

### Base de Datos
- **Motor:** PostgreSQL 17 Alpine
- **Persistencia:** Volumen Docker nombrado
- **Nombre BD:** kargaps_db
- **Usuario:** ameth_user

### Infraestructura
- **Contenedores:** Docker
- **Orquestación:** Docker Compose
- **Red:** Bridge personalizada

## 📦 Requisitos Previos

- Docker >= 20.10
- Docker Compose >= 1.29
- Git
```bash
# Verificar instalación
docker --version
docker-compose --version
```

## 🚀 Instalación

### 1. Clonar el Repositorio
```bash
git clone <URL_DEL_REPOSITORIO>
cd microservicios-ameth
```

### 2. Configurar Variables de Entorno (Opcional)

El proyecto ya tiene configuradas las variables en `docker-compose.yml`, pero puedes crear un archivo `.env` si deseas:
```bash
# Base de datos
POSTGRES_DB=kargaps_db
POSTGRES_USER=ameth_user
POSTGRES_PASSWORD=Ameth2005

# Backend
PORT=5000
NODE_ENV=production

# Cloudinary (opcional)
CLOUDINARY_CLOUD_NAME=tu_cloud_name
CLOUDINARY_API_KEY=tu_api_key
CLOUDINARY_API_SECRET=tu_api_secret
```

### 3. Construir y Levantar los Servicios
```bash
# Construir las imágenes
docker-compose build

# Levantar todos los servicios
docker-compose up -d

# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f backend
```

### 4. Verificar que Todo Esté Funcionando
```bash
# Ver contenedores activos
docker ps

# Deberías ver 3 contenedores:
# - ameth-frontend-kargaps (3000:3000)
# - ameth-backend-kargaps (5000:5000)
# - ameth-database-kargaps (5432:5432)
```

## 🌐 Uso

### Acceder a los Servicios

- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:5000
- **Base de Datos:** localhost:5432

### Endpoints Personalizados

**Endpoint con apellido Toledo (requisito del proyecto):**
```bash
curl http://localhost:5000/api/users/toledo

# Respuesta:
{
  "nombre": "Ameth de Jesus Mendez Toledo",
  "apellido": "Toledo",
  "mensaje": "Endpoint personalizado de Ameth"
}
```

## 📡 Endpoints API

### Usuarios
- `POST /api/users/auth/register` - Registrar usuario
- `POST /api/users/auth/login` - Iniciar sesión
- `GET /api/users` - Obtener todos los usuarios (requiere auth)
- `GET /api/users/:id` - Obtener usuario por ID
- `PUT /api/users/:id` - Actualizar usuario
- `DELETE /api/users/:id` - Eliminar usuario
- `GET /api/users/toledo` - **Endpoint personalizado (Ameth)**

### Gorras
- `GET /api/gorras` - Listar todas las gorras
- `GET /api/gorras/:id` - Obtener gorra por ID
- `GET /api/gorras/search?query=` - Buscar gorras
- `POST /api/gorras` - Crear gorra (requiere auth)
- `PUT /api/gorras/:id` - Actualizar gorra
- `DELETE /api/gorras/:id` - Eliminar gorra

### Playeras
- `GET /api/playeras` - Listar todas las playeras
- `GET /api/playeras/:id` - Obtener playera por ID
- `GET /api/playeras/search?query=` - Buscar playeras
- `POST /api/playeras` - Crear playera (requiere auth)
- `PUT /api/playeras/:id` - Actualizar playera
- `DELETE /api/playeras/:id` - Eliminar playera

## 📂 Estructura del Proyecto
```
microservicios-ameth/
├── backend/
│   ├── Dockerfile              # Imagen personalizada Node.js
│   ├── src/
│   │   ├── core/              # Utilidades compartidas
│   │   ├── users/             # Módulo de usuarios
│   │   ├── gorras/            # Módulo de gorras
│   │   └── playeras/          # Módulo de playeras
│   └── package.json
├── frontend/
│   ├── Dockerfile              # Imagen personalizada Angular
│   ├── src/
│   │   └── app/
│   │       ├── components/     # Componentes reutilizables
│   │       ├── modules/        # Páginas/módulos
│   │       ├── services/       # Servicios HTTP
│   │       └── models/         # Interfaces TypeScript
│   └── package.json
├── docker-compose.yml          # Orquestación de servicios
├── init-db.sql                 # Script inicial de BD
└── README.md                   # Este archivo
```

## 🧪 Pruebas de Persistencia

### Verificar Persistencia de Datos
```bash
# 1. Crear un producto de prueba
curl -X POST http://localhost:5000/api/gorras \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Gorra de Prueba",
    "descripcion": "Prueba de persistencia",
    "precio": 199.99,
    "stock": 10,
    "color": "Rojo"
  }'

# 2. Detener todos los contenedores
docker-compose down

# 3. Verificar que el volumen persiste
docker volume ls | grep ameth

# 4. Levantar de nuevo
docker-compose up -d

# 5. Verificar que los datos siguen ahí
curl http://localhost:5000/api/gorras
```

### Inspeccionar el Volumen
```bash
# Ver información del volumen
docker volume inspect ameth_kargaps_persistent_data

# Ver datos en el volumen (requiere acceso root)
docker exec -it ameth-database-kargaps psql -U ameth_user -d kargaps_db -c "SELECT * FROM gorras;"
```

## 🔧 Comandos Útiles

### Docker Compose
```bash
# Construir sin cache
docker-compose build --no-cache

# Ver logs
docker-compose logs -f [servicio]

# Entrar a un contenedor
docker exec -it ameth-backend-kargaps sh
docker exec -it ameth-database-kargaps sh

# Reiniciar un servicio
docker-compose restart backend

# Detener todo
docker-compose down

# Detener y eliminar volúmenes (⚠️ CUIDADO: borra datos)
docker-compose down -v
```

### Base de Datos
```bash
# Conectar a PostgreSQL
docker exec -it ameth-database-kargaps psql -U ameth_user -d kargaps_db

# Backup de la BD
docker exec ameth-database-kargaps pg_dump -U ameth_user kargaps_db > backup.sql

# Restaurar backup
docker exec -i ameth-database-kargaps psql -U ameth_user kargaps_db < backup.sql
```

## 🐛 Troubleshooting

### El frontend no puede conectarse al backend

Verifica que la variable `API_URL` esté correctamente configurada:
```bash
docker exec ameth-frontend-kargaps env | grep API_URL
```

### La base de datos no inicia
```bash
# Ver logs
docker-compose logs database

# Verificar healthcheck
docker inspect ameth-database-kargaps | grep -A 10 Health
```

### Problemas de permisos
```bash
# Agregar usuario al grupo docker
sudo usermod -aG docker $USER
newgrp docker
```

## 👨‍💻 Autor

**Ameth de Jesus Mendez Toledo**

- Proyecto: Arquitectura de Microservicios con Docker
- Base de datos: kargaps_db
- Contenedores: ameth-*-kargaps
- Endpoint personalizado: /api/users/toledo

## 📄 Licencia

Este proyecto es parte de un trabajo académico.

## 🔗 Repositorio

URL: https://github.com/Ameth-Toledo/dockerCompose.git
