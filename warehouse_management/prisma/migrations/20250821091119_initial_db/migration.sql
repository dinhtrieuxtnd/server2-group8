-- CreateTable
CREATE TABLE "public"."products" (
    "id" BIGSERIAL NOT NULL,
    "sku" VARCHAR(64) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "category_id" BIGINT,
    "brand_id" BIGINT,
    "unit" VARCHAR(16) NOT NULL DEFAULT 'pcs',
    "cost_price" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "sell_price" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "min_stock" DECIMAL(18,3) NOT NULL DEFAULT 0.0,
    "barcode" VARCHAR(64),
    "status" VARCHAR(16) NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."suppliers" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "tax_code" VARCHAR(64),
    "email" VARCHAR(255),
    "phone" VARCHAR(64),
    "address" TEXT,
    "status" VARCHAR(16) NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "suppliers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."supplier_products" (
    "supplier_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "supplier_sku" VARCHAR(64),
    "lead_time_days" INTEGER DEFAULT 0,
    "last_cost_price" DECIMAL(18,2) NOT NULL DEFAULT 0.0,

    CONSTRAINT "supplier_products_pkey" PRIMARY KEY ("supplier_id","product_id")
);

-- CreateTable
CREATE TABLE "public"."warehouses" (
    "id" BIGSERIAL NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "address" TEXT,
    "status" VARCHAR(16) NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "warehouses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."inventory" (
    "warehouse_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "qty_on_hand" DECIMAL(18,3) NOT NULL DEFAULT 0.0,
    "qty_reserved" DECIMAL(18,3) NOT NULL DEFAULT 0.0,

    CONSTRAINT "inventory_pkey" PRIMARY KEY ("warehouse_id","product_id")
);

-- CreateTable
CREATE TABLE "public"."stock_movements" (
    "id" BIGSERIAL NOT NULL,
    "warehouse_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "type" VARCHAR(32) NOT NULL,
    "quantity" DECIMAL(18,3) NOT NULL,
    "ref_type" VARCHAR(16),
    "ref_id" BIGINT,
    "note" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "stock_movements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."purchase_orders" (
    "id" BIGSERIAL NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "supplier_id" BIGINT NOT NULL,
    "warehouse_id" BIGINT NOT NULL,
    "order_date" TIMESTAMP(3) NOT NULL,
    "expected_date" TIMESTAMP(3),
    "status" VARCHAR(16) NOT NULL DEFAULT 'draft',
    "currency" VARCHAR(8) DEFAULT 'VND',
    "exchange_rate" DECIMAL(18,6) NOT NULL DEFAULT 1.0,
    "subtotal" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "tax_total" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "discount_total" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "total_amount" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "purchase_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."purchase_order_items" (
    "id" BIGSERIAL NOT NULL,
    "purchase_order_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "unit_price" DECIMAL(18,2) NOT NULL,
    "qty_ordered" DECIMAL(18,3) NOT NULL,
    "qty_received" DECIMAL(18,3) NOT NULL DEFAULT 0.0,
    "tax_percent" DECIMAL(5,2) DEFAULT 0.0,
    "discount_percent" DECIMAL(5,2) DEFAULT 0.0,

    CONSTRAINT "purchase_order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."sales_orders" (
    "id" BIGSERIAL NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "customer_id" BIGINT,
    "warehouse_id" BIGINT NOT NULL,
    "order_date" TIMESTAMP(3) NOT NULL,
    "status" VARCHAR(16) NOT NULL DEFAULT 'pending',
    "subtotal" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "tax_total" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "discount_total" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "total_amount" DECIMAL(18,2) NOT NULL DEFAULT 0.0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sales_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."sales_order_items" (
    "id" BIGSERIAL NOT NULL,
    "sales_order_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "unit_price" DECIMAL(18,2) NOT NULL,
    "qty_ordered" DECIMAL(18,3) NOT NULL,
    "qty_allocated" DECIMAL(18,3) NOT NULL DEFAULT 0.0,
    "qty_shipped" DECIMAL(18,3) NOT NULL DEFAULT 0.0,
    "tax_percent" DECIMAL(5,2) DEFAULT 0.0,
    "discount_percent" DECIMAL(5,2) DEFAULT 0.0,

    CONSTRAINT "sales_order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."User" (
    "id" BIGSERIAL NOT NULL,
    "username" VARCHAR(64) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password_hash" VARCHAR(255) NOT NULL,
    "full_name" VARCHAR(255),
    "role" VARCHAR(32) NOT NULL DEFAULT 'user',
    "status" VARCHAR(16) NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."RefreshToken" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "token" VARCHAR(512) NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RefreshToken_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "products_sku_key" ON "public"."products"("sku");

-- CreateIndex
CREATE UNIQUE INDEX "suppliers_name_key" ON "public"."suppliers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "warehouses_code_key" ON "public"."warehouses"("code");

-- CreateIndex
CREATE UNIQUE INDEX "purchase_orders_code_key" ON "public"."purchase_orders"("code");

-- CreateIndex
CREATE UNIQUE INDEX "sales_orders_code_key" ON "public"."sales_orders"("code");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "public"."User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- AddForeignKey
ALTER TABLE "public"."supplier_products" ADD CONSTRAINT "supplier_products_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "public"."suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."supplier_products" ADD CONSTRAINT "supplier_products_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."inventory" ADD CONSTRAINT "inventory_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."inventory" ADD CONSTRAINT "inventory_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."stock_movements" ADD CONSTRAINT "stock_movements_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."stock_movements" ADD CONSTRAINT "stock_movements_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."purchase_orders" ADD CONSTRAINT "purchase_orders_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "public"."suppliers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."purchase_orders" ADD CONSTRAINT "purchase_orders_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."purchase_order_items" ADD CONSTRAINT "purchase_order_items_purchase_order_id_fkey" FOREIGN KEY ("purchase_order_id") REFERENCES "public"."purchase_orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."purchase_order_items" ADD CONSTRAINT "purchase_order_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sales_orders" ADD CONSTRAINT "sales_orders_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sales_order_items" ADD CONSTRAINT "sales_order_items_sales_order_id_fkey" FOREIGN KEY ("sales_order_id") REFERENCES "public"."sales_orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sales_order_items" ADD CONSTRAINT "sales_order_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RefreshToken" ADD CONSTRAINT "RefreshToken_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
