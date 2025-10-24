CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO roles (nombre, descripcion) VALUES 
    ('Admin', 'Administrador del sistema'),
    ('Usuario', 'Usuario regular')
ON CONFLICT (nombre) DO NOTHING;
SELECT * FROM roles;
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    rol_id INTEGER NOT NULL DEFAULT 2,
    avatar INTEGER DEFAULT 1 CHECK (avatar BETWEEN 1 AND 5),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE RESTRICT
);
CREATE INDEX IF NOT EXISTS idx_usuarios_email ON usuarios(email);
CREATE INDEX IF NOT EXISTS idx_usuarios_rol_id ON usuarios(rol_id);
CREATE TABLE IF NOT EXISTS gorras (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    color VARCHAR(50),
    imagen_url TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_gorras_nombre ON gorras(nombre);
CREATE TABLE IF NOT EXISTS playeras (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    color VARCHAR(50),
    talla VARCHAR(20) CHECK (talla IN ('XS', 'S', 'M', 'L', 'XL', 'XXL')),
    tipo VARCHAR(50), -- manga corta, manga larga, sin mangas
    material VARCHAR(100),
    imagen_url TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Índices para playeras
CREATE INDEX IF NOT EXISTS idx_playeras_nombre ON playeras(nombre);
CREATE INDEX IF NOT EXISTS idx_playeras_talla ON playeras(talla);
-- Trigger para actualizar fecha_actualizacion en gorras
CREATE OR REPLACE FUNCTION update_fecha_actualizacion_gorras()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_update_gorras
BEFORE UPDATE ON gorras
FOR EACH ROW
EXECUTE FUNCTION update_fecha_actualizacion_gorras();
-- Trigger para actualizar fecha_actualizacion en playeras
CREATE OR REPLACE FUNCTION update_fecha_actualizacion_playeras()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_update_playeras
BEFORE UPDATE ON playeras
FOR EACH ROW
EXECUTE FUNCTION update_fecha_actualizacion_playeras();
