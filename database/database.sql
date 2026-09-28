-- RehixPK Database Schema & Initial Data
-- Production Ready SQL Dump for RehixPK Gaming Marketplace

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `activity_logs`;
DROP TABLE IF EXISTS `contact_messages`;
DROP TABLE IF EXISTS `coupon_usage`;
DROP TABLE IF EXISTS `coupons`;
DROP TABLE IF EXISTS `payment_logs`;
DROP TABLE IF EXISTS `payments`;
DROP TABLE IF EXISTS `order_items`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `product_images`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `settings`;
DROP TABLE IF EXISTS `login_attempts`;
DROP TABLE IF EXISTS `password_resets`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `admins`;

SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------
-- Table: admins
-- --------------------------------------------------------
CREATE TABLE `admins` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `is_temporary_password` TINYINT(1) DEFAULT 1,
  `role` VARCHAR(50) DEFAULT 'admin',
  `last_login_at` DATETIME NULL,
  `last_login_ip` VARCHAR(45) NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Initial Admin Account: shahzaibkhokher030@gmail.com / admin123
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `is_temporary_password`, `role`) VALUES
(1, 'Shahzaib Admin', 'shahzaibkhokher030@gmail.com', '$2y$10$QD7yjtpWMbg2juSIwTSytejx25S5q08wgSDEK6dl2d1Q5Lypw/jsi', 1, 'super_admin');

-- --------------------------------------------------------
-- Table: users (Customers)
-- --------------------------------------------------------
CREATE TABLE `users` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `whatsapp` VARCHAR(30) NULL,
  `password` VARCHAR(255) NOT NULL,
  `status` ENUM('active', 'suspended') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `whatsapp`, `password`) VALUES
(1, 'Demo Customer', 'customer@example.com', '+923001234567', '$2y$10$TOtMR8kSZ93Ux7dsomopf.BAh.kyoP6xPXDdeSCQOPnHqT4tPEQvK');

-- --------------------------------------------------------
-- Table: categories
-- --------------------------------------------------------
CREATE TABLE `categories` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `slug` VARCHAR(120) NOT NULL UNIQUE,
  `description` TEXT NULL,
  `icon` VARCHAR(100) DEFAULT 'fa-fire',
  `status` TINYINT(1) DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `icon`) VALUES
(1, 'Premium IDs', 'premium-ids', 'Ultra rare account collections with multiple MAX Evo guns and elite bundles', 'fa-crown'),
(2, 'Budget IDs', 'budget-ids', 'Affordable gaming accounts with high levels and great stats', 'fa-tag'),
(3, 'High Level Accounts', 'high-level', 'Accounts above level 70 with top-tier account age and badges', 'fa-bolt'),
(4, 'Evo Gun Accounts', 'evo-gun-accounts', 'Specialized accounts packed with upgraded Evo Gun skins', 'fa-crosshairs'),
(5, 'Rare Collection', 'rare-collection', 'Accounts featuring rare old season elite passes, Sakura, and Hip Hop bundles', 'fa-gem'),
(6, 'High Rank Accounts', 'high-rank', 'Grandmaster & Master rank pushed account listings', 'fa-trophy');

-- --------------------------------------------------------
-- Table: products
-- --------------------------------------------------------
CREATE TABLE `products` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `product_code` VARCHAR(50) NOT NULL UNIQUE,
  `slug` VARCHAR(220) NOT NULL UNIQUE,
  `price` DECIMAL(10,2) NOT NULL,
  `original_price` DECIMAL(10,2) NULL,
  `main_image` VARCHAR(255) NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  `account_level` INT DEFAULT 1,
  `server_region` VARCHAR(50) DEFAULT 'Pakistan',
  `rank` VARCHAR(50) DEFAULT 'Heroic',
  `likes` INT DEFAULT 0,
  `diamonds` INT DEFAULT 0,
  `character_count` INT DEFAULT 0,
  `gun_skins` VARCHAR(255) DEFAULT '',
  `evo_guns` VARCHAR(255) DEFAULT '',
  `emotes` INT DEFAULT 0,
  `bundles` VARCHAR(255) DEFAULT '',
  `pets` INT DEFAULT 0,
  `account_age` VARCHAR(50) DEFAULT '3+ Years',
  `login_method` VARCHAR(50) DEFAULT 'Facebook / Gmail',
  `description` LONGTEXT NULL,
  `highlights` TEXT NULL,
  `status` ENUM('available', 'sold', 'disabled') DEFAULT 'available',
  `is_featured` TINYINT(1) DEFAULT 0,
  `is_bestseller` TINYINT(1) DEFAULT 0,
  `is_new` TINYINT(1) DEFAULT 1,
  `views_count` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Demo Free Fire Accounts Data
INSERT INTO `products`
(`id`, `title`, `product_code`, `slug`, `price`, `original_price`, `main_image`, `category_id`, `account_level`, `server_region`, `rank`, `likes`, `diamonds`, `character_count`, `gun_skins`, `evo_guns`, `emotes`, `bundles`, `pets`, `account_age`, `login_method`, `description`, `highlights`, `status`, `is_featured`, `is_bestseller`, `is_new`) VALUES
(1, 'Level 78 Ultra Rare Free Fire Account - 7 MAX Evo Guns & Sakura Bundle', 'RPK-FF-1001', 'level-78-ultra-rare-free-fire-account-7-max-evo-guns', 45000.00, 55000.00, '/assets/images/demo/p1.svg', 1, 78, 'Pakistan', 'Grandmaster', 24500, 450, 48, '120+ Mythic Guns', 'AK Blue Flame (MAX), M1014 Green Dragon (MAX), MP40 Cobra (MAX), SCAR Megalodon (MAX)', 85, 'Sakura Bundle, Hip Hop, Cobra Bundle, Criminal Red', 22, '4 Years+', 'FB Clean Single Log', 'This is an absolute powerhouse account! Loaded with Season 1 Sakura Bundle, Hip Hop, Cobra Bundle, and 7 MAX level Evo guns. Perfect for competitive tournament players and serious collectors looking for immediate prestige.', '7 MAX Evo Guns\nSeason 1 & 2 Elite Passes\n24,500+ Likes\n100% Secure FB Transfer', 'available', 1, 1, 1),

(2, 'Level 72 High Rank Account - Cobra MP40 & 15k Likes', 'RPK-FF-1002', 'level-72-high-rank-account-cobra-mp40', 22000.00, 28000.00, '/assets/images/demo/p2.svg', 6, 72, 'Pakistan', 'Master 5 Star', 15200, 120, 42, '85+ Legendary Guns', 'MP40 Cobra (Level 6), AK Blue Flame (Level 5)', 62, 'Artic Blue, Breakdancer, Season 5 Elite', 18, '3 Years', 'Gmail Binding', 'Awesome Master rank account with high KD ratio in CS Ranked and BR Ranked. Features Cobra MP40 level 6 with full killing effect and custom emotes.', 'Master 5 Star CS Rank\nMP40 Cobra Lv 6\n15,200 Likes\nClean Gmail Login', 'available', 1, 0, 1),

(3, 'Level 68 Evo Gun Specialist ID - 5 Evo Guns & 40+ Emotes', 'RPK-FF-1003', 'level-68-evo-gun-specialist-id-5-evo-guns', 18500.00, 22000.00, '/assets/images/demo/p3.svg', 4, 68, 'Pakistan', 'Heroic', 11800, 50, 38, '70+ Gun Skins', 'M1014 Green Flame, MP40 Cobra, XM8 Destiny, SCAR Megalodon', 48, 'Criminal Yellow, Incubator Bundles', 15, '2.5 Years', 'FB (Single Login)', 'Evo gun collection ready account! Equipped with 5 top Evo guns with high levels unlocked and rare kill notifications.', '5 Evo Guns Unlocked\n48 Emotes including Throne Emote\nHeroic Banner', 'available', 0, 1, 1),

(4, 'Level 65 Budget Friendly Free Fire ID - Great Collection', 'RPK-FF-1004', 'level-65-budget-friendly-free-fire-id', 8500.00, 12000.00, '/assets/images/demo/p4.svg', 2, 65, 'Pakistan', 'Diamond IV', 7400, 80, 35, '45+ Gun Skins', 'MP40 Cobra (Level 3)', 32, 'Street Boy, Bunny Bundle', 12, '2 Years', 'Gmail Direct Transfer', 'Great budget deal for starting strong in Free Fire. Has solid level 65 stats, popular Cobra MP40 level 3, and popular street character bundles.', 'Affordable Price\nLevel 65\nCobra MP40 Level 3\nFull Email Ownership', 'available', 0, 0, 1),

(5, 'Level 80 Legendary God Tier ID - All Incubator Bundles + 10 Evo Guns', 'RPK-FF-1005', 'level-80-legendary-god-tier-id-all-incubators', 75000.00, 90000.00, '/assets/images/demo/p5.svg', 1, 80, 'Pakistan', 'Grandmaster Top 100', 38000, 1200, 52, '180+ Gun Skins', '10 Evo Guns (5 MAX)', 110, 'Full Criminal Set (Red, Yellow, Blue, Green, Purple)', 25, '5 Years', 'FB / Gmail Dual Clean', 'Ultimate VIP Account for top tier streamers and esport players. Features all 5 Criminal Bundles, 10 Evo Guns, and massive emote library.', 'Top 100 Grandmaster Badge\nFull Criminal Bundle Collection\n38,000+ Likes\nInstant Email Transfer', 'available', 1, 1, 0),

(6, 'Level 70 Old Season Account - Rare S3 & S4 Badges', 'RPK-FF-1006', 'level-70-old-season-account-rare-badges', 16000.00, 19500.00, '/assets/images/demo/p6.svg', 5, 70, 'Pakistan', 'Heroic', 9800, 0, 40, '60+ Guns', 'AK Flame Dragon, SCAR Titan', 50, 'Season 3 Elite Pass Bundle, Season 4 Elite', 14, '4 Years', 'FB Login', 'Nostalgic old account from early Free Fire days with rare badges, OG avatar frames, and classic incubator gun skins.', 'Old Season Pass Bundles\nClassic Titan SCAR & Dragon AK\nClean Record', 'available', 0, 0, 0),

(7, 'Level 74 Collector Account - 30,000+ Likes & Max Evo MP40', 'RPK-FF-1007', 'level-74-collector-account-30k-likes-max-evo-mp40', 29000.00, 35000.00, '/assets/images/demo/p7.svg', 3, 74, 'Pakistan', 'Master', 31200, 300, 45, '110+ Guns', 'MP40 Cobra (MAX), UMP Booyah (MAX)', 75, 'Golden Shade, Bandit Bundle', 20, '3.5 Years', 'Gmail Transfer', 'High like count profile with maxed MP40 and UMP Booyah Day Evo guns. Extremely clean match profile history.', '31,200+ Profile Likes\n2 MAX Evo Guns\nMaster Rank Shield', 'available', 1, 0, 0),

(8, 'Level 60 Starter Account - Cobra MP40 & Alok/Chronos', 'RPK-FF-1008', 'level-60-starter-account-cobra-mp40-alok', 6500.00, 9000.00, '/assets/images/demo/p8.svg', 2, 60, 'Pakistan', 'Platinum III', 4200, 15, 28, '30+ Guns', 'MP40 Cobra (Lv 2)', 20, 'Night Panther, DJ Alok Bundle', 8, '1.5 Years', 'FB Direct', 'Best entry level account for beginners. Comes with DJ Alok unlocked, basic Cobra MP40, and clean Facebook credentials.', 'Very Affordable\nLevel 60\nDJ Alok Unlocked', 'available', 0, 0, 1);

-- --------------------------------------------------------
-- Table: product_images
-- --------------------------------------------------------
CREATE TABLE `product_images` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NOT NULL,
  `image_path` VARCHAR(255) NOT NULL,
  `sort_order` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Demo Gallery Images for Product 1
INSERT INTO `product_images` (`product_id`, `image_path`, `sort_order`) VALUES
(1, '/assets/images/demo/p1.svg', 1),
(1, '/assets/images/demo/p1_gallery1.svg', 2),
(1, '/assets/images/demo/p1_gallery2.svg', 3),
(2, '/assets/images/demo/p2.svg', 1),
(3, '/assets/images/demo/p3.svg', 1),
(4, '/assets/images/demo/p4.svg', 1),
(5, '/assets/images/demo/p5.svg', 1),
(6, '/assets/images/demo/p6.svg', 1),
(7, '/assets/images/demo/p7.svg', 1),
(8, '/assets/images/demo/p8.svg', 1);

-- --------------------------------------------------------
-- Table: coupons
-- --------------------------------------------------------
CREATE TABLE `coupons` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `code` VARCHAR(50) NOT NULL UNIQUE,
  `discount_type` ENUM('percentage', 'fixed') DEFAULT 'percentage',
  `discount_amount` DECIMAL(10,2) NOT NULL,
  `min_order_amount` DECIMAL(10,2) DEFAULT 0.00,
  `max_discount_amount` DECIMAL(10,2) NULL,
  `usage_limit` INT DEFAULT 100,
  `used_count` INT DEFAULT 0,
  `expiry_date` DATE NULL,
  `status` TINYINT(1) DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `coupons` (`code`, `discount_type`, `discount_amount`, `min_order_amount`, `max_discount_amount`, `usage_limit`, `expiry_date`) VALUES
('WELCOME10', 'percentage', 10.00, 1000.00, 3000.00, 500, '2027-12-31'),
('REHIX500', 'fixed', 500.00, 5000.00, 500.00, 100, '2027-12-31');

-- --------------------------------------------------------
-- Table: orders
-- --------------------------------------------------------
CREATE TABLE `orders` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_number` VARCHAR(50) NOT NULL UNIQUE,
  `user_id` INT UNSIGNED NULL,
  `customer_name` VARCHAR(100) NOT NULL,
  `customer_email` VARCHAR(150) NOT NULL,
  `customer_whatsapp` VARCHAR(30) NOT NULL,
  `alternate_phone` VARCHAR(30) NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(10,2) DEFAULT 0.00,
  `coupon_code` VARCHAR(50) NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `payment_method` VARCHAR(50) NOT NULL DEFAULT 'easypaisa',
  `payment_reference` VARCHAR(100) NULL,
  `payment_status` ENUM('pending', 'paid', 'failed', 'refunded', 'cancelled') DEFAULT 'pending',
  `order_status` ENUM('new', 'payment_pending', 'paid', 'processing', 'completed', 'cancelled', 'refunded') DEFAULT 'new',
  `customer_notes` TEXT NULL,
  `admin_notes` TEXT NULL,
  `ip_address` VARCHAR(45) NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: order_items
-- --------------------------------------------------------
CREATE TABLE `order_items` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NULL,
  `product_title` VARCHAR(200) NOT NULL,
  `product_code` VARCHAR(50) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: payments
-- --------------------------------------------------------
CREATE TABLE `payments` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT UNSIGNED NOT NULL,
  `transaction_id` VARCHAR(100) NOT NULL UNIQUE,
  `gateway` VARCHAR(50) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `currency` VARCHAR(10) DEFAULT 'PKR',
  `status` ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
  `proof_image` VARCHAR(255) NULL,
  `gateway_response` LONGTEXT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: payment_logs
-- --------------------------------------------------------
CREATE TABLE `payment_logs` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `order_id` INT UNSIGNED NULL,
  `event` VARCHAR(100) NOT NULL,
  `payload` LONGTEXT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: coupon_usage
-- --------------------------------------------------------
CREATE TABLE `coupon_usage` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `coupon_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NULL,
  `discount_applied` DECIMAL(10,2) NOT NULL,
  `used_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: reviews
-- --------------------------------------------------------
CREATE TABLE `reviews` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT UNSIGNED NULL,
  `customer_name` VARCHAR(100) NOT NULL,
  `rating` TINYINT DEFAULT 5,
  `comment` TEXT NOT NULL,
  `status` ENUM('approved', 'pending', 'rejected') DEFAULT 'approved',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `reviews` (`product_id`, `customer_name`, `rating`, `comment`, `status`) VALUES
(1, 'Ali Raza', 5, 'Bought Level 78 Free Fire ID! Credentials delivered within 15 minutes after Easypaisa confirmation. Account is 100% genuine with Sakura bundle and clean FB binding.', 'approved'),
(2, 'Hamza Khan', 5, 'Best marketplace for gaming accounts in Pakistan. Support on WhatsApp is super fast and polite. Will buy again!', 'approved'),
(3, 'Usman Tariq', 5, 'Smooth purchase experience. The Cobra MP40 account had exact stats as described. Recommended 10/10!', 'approved');

-- --------------------------------------------------------
-- Table: settings (CMS Config)
-- --------------------------------------------------------
CREATE TABLE `settings` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `setting_key` VARCHAR(100) NOT NULL UNIQUE,
  `setting_value` LONGTEXT NULL,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('site_name', 'RehixPK'),
('site_tagline', 'Pakistan\'s Premier Free Fire ID & Digital Gaming Marketplace'),
('currency_symbol', 'Rs.'),
('currency_code', 'PKR'),
('support_whatsapp', '+923001234567'),
('support_email', 'rehixpk@gofluxpay.site'),
('announcement_text', '🔥 Special Sale! Use coupon code WELCOME10 for 10% instant discount on all Free Fire IDs!'),
('hero_title', 'Find Your Next Free Fire Account'),
('hero_description', 'Browse thousands of verified, high-level Free Fire gaming accounts with instant delivery, secure payment options, and 100% money-back guarantee.'),
('easypaisa_enabled', '1'),
('easypaisa_title', 'RehixPK Official'),
('easypaisa_number', '03001234567'),
('easypaisa_instructions', 'Send total order amount to Easypaisa account above. Keep transaction SMS ID for fast verification.'),
('jazzcash_enabled', '1'),
('jazzcash_title', 'RehixPK Official'),
('jazzcash_number', '03001234567'),
('jazzcash_instructions', 'Send total order amount to JazzCash account above. Enter TID in order form.'),
('bank_enabled', '1'),
('bank_name', 'Meezan Bank'),
('bank_title', 'RehixPK Digital Enterprise'),
('bank_account', '0102030405060708'),
('bank_iban', 'PK00MEZN0001020304050607'),
('online_gateway_enabled', '1'),
('maintenance_mode', '0'),
('meta_title', 'RehixPK - Buy & Sell Free Fire IDs & Gaming Accounts Safely'),
('meta_description', 'RehixPK is Pakistan\'s #1 secure digital marketplace for Free Fire IDs, rare accounts, Evo guns, and gaming products with instant delivery.');

-- --------------------------------------------------------
-- Table: contact_messages
-- --------------------------------------------------------
CREATE TABLE `contact_messages` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `whatsapp` VARCHAR(30) NULL,
  `order_number` VARCHAR(50) NULL,
  `subject` VARCHAR(200) NOT NULL,
  `message` TEXT NOT NULL,
  `status` ENUM('unread', 'read', 'replied') DEFAULT 'unread',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: activity_logs
-- --------------------------------------------------------
CREATE TABLE `activity_logs` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `admin_id` INT UNSIGNED NULL,
  `action` VARCHAR(200) NOT NULL,
  `details` TEXT NULL,
  `ip_address` VARCHAR(45) NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: login_attempts
-- --------------------------------------------------------
CREATE TABLE `login_attempts` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `ip_address` VARCHAR(45) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `attempts` INT DEFAULT 1,
  `last_attempt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: password_resets
-- --------------------------------------------------------
CREATE TABLE `password_resets` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(150) NOT NULL,
  `token` VARCHAR(100) NOT NULL UNIQUE,
  `expires_at` DATETIME NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
