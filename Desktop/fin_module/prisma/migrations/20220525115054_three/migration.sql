/*
  Warnings:

  - You are about to drop the column `contenu` on the `article` table. All the data in the column will be lost.
  - You are about to drop the column `titre` on the `article` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `article` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `categorie` table. All the data in the column will be lost.
  - You are about to drop the column `contenu` on the `commentaire` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `commentaire` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `commentaire` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `user` table. All the data in the column will be lost.
  - You are about to alter the column `role` on the `user` table. The data in that column could be lost. The data in that column will be cast from `Enum("user_role")` to `Enum("user_role")`.
  - Added the required column `authorId` to the `article` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `article` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nom` to the `categorie` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `categorie` table without a default value. This is not possible if the table is not empty.
  - Added the required column `comment` to the `commentaire` table without a default value. This is not possible if the table is not empty.
  - Added the required column `postId` to the `commentaire` table without a default value. This is not possible if the table is not empty.
  - Added the required column `writtenById` to the `commentaire` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `article` DROP COLUMN `contenu`,
    DROP COLUMN `titre`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `authorId` INTEGER NOT NULL,
    ADD COLUMN `content` VARCHAR(191) NULL,
    ADD COLUMN `image` VARCHAR(191) NULL,
    ADD COLUMN `title` VARCHAR(191) NOT NULL,
    MODIFY `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    MODIFY `published` BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE `categorie` DROP COLUMN `name`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `nom` VARCHAR(191) NOT NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `commentaire` DROP COLUMN `contenu`,
    DROP COLUMN `email`,
    DROP COLUMN `name`,
    ADD COLUMN `comment` VARCHAR(191) NOT NULL,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `postId` INTEGER NOT NULL,
    ADD COLUMN `writtenById` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `password`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `passwrd` VARCHAR(191) NULL,
    MODIFY `name` VARCHAR(191) NULL,
    MODIFY `role` ENUM('ADMIN', 'AUTHOR', 'GUEST') NOT NULL DEFAULT 'GUEST';

-- CreateTable
CREATE TABLE `_TagToPost` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_TagToPost_AB_unique`(`A`, `B`),
    INDEX `_TagToPost_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `article` ADD CONSTRAINT `article_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commentaire` ADD CONSTRAINT `commentaire_writtenById_fkey` FOREIGN KEY (`writtenById`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commentaire` ADD CONSTRAINT `commentaire_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `article`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `_TagToPost` ADD CONSTRAINT `_TagToPost_A_fkey` FOREIGN KEY (`A`) REFERENCES `article`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_TagToPost` ADD CONSTRAINT `_TagToPost_B_fkey` FOREIGN KEY (`B`) REFERENCES `categorie`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
