-- schema.sql

CREATE DATABASE IF NOT EXISTS `todo_app` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `todo_app`;

CREATE TABLE `User` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `date_created` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `last_login` DATETIME
) ENGINE=InnoDB;

CREATE TABLE `Category` (
    `category_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(255),
    FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `Task` (
    `task_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `due_date` DATETIME,
    `date_created` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `date_completed` DATETIME,
    `priority` INT DEFAULT 0,
    `status` ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    `category_id` INT,
    FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`) REFERENCES `Category`(`category_id`)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;
