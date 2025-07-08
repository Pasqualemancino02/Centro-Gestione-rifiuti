-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Lug 08, 2025 alle 14:49
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestione rifiuti`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `conferimenti`
--

CREATE TABLE `conferimenti` (
  `ID_conferimento` int(11) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `data` date NOT NULL,
  `peso` decimal(10,2) NOT NULL,
  `stato` varchar(50) NOT NULL,
  `impianto_id` int(11) NOT NULL,
  `dipendente_id` int(11) NOT NULL,
  `provenienza` varchar(100) NOT NULL DEFAULT '',
  `tipo_smaltimento` varchar(100) NOT NULL,
  `pericolosita` enum('no','si') NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `conferimenti`
--

INSERT INTO `conferimenti` (`ID_conferimento`, `tipo`, `data`, `peso`, `stato`, `impianto_id`, `dipendente_id`, `provenienza`, `tipo_smaltimento`, `pericolosita`) VALUES
(3, 'Organico', '2025-07-03', 220.00, 'completato', 1, 7, '', '', 'no'),
(5, 'Vetro', '0001-01-01', 98.00, 'processato', 1, 7, '', '', 'no'),
(6, 'Plastica', '2025-07-02', 25.00, 'completato', 1, 7, '', '', 'no'),
(11, 'Vetro', '2025-07-03', 23.00, 'in attesa', 1, 5, 'Via Santa Chiara ,13', 'Riciclaggio', 'no'),
(12, 'Plastica', '2025-07-04', 500.00, 'in attesa', 2, 5, 'Via Santa Chiara ,13', 'Riciclaggio', 'no'),
(14, 'Carta', '2025-07-05', 1000.00, 'in attesa', 2, 5, 'Via Santa Chiara ,13', 'Riciclaggio', 'no'),
(16, 'Plastica', '2025-07-07', 0.02, 'in attesa', 2, 5, 'Napoli Centro', 'Discarica', 'no'),
(17, 'Carta', '2025-07-08', 10.00, 'in attesa', 2, 5, 'Napoli Centro', 'Riciclaggio', 'no'),
(18, 'Vetro', '2025-07-10', 50.00, 'in attesa', 1, 5, 'Milano ', 'Riciclaggio', 'no'),
(19, 'Organico', '2025-07-08', 20.00, 'in attesa', 5, 10, 'Zona A', 'Discarica', 'no');

-- --------------------------------------------------------

--
-- Struttura della tabella `impianti`
--

CREATE TABLE `impianti` (
  `ID_impianto` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `localita` varchar(150) NOT NULL,
  `tipo_impianto` varchar(100) NOT NULL,
  `capacita_massima` decimal(10,2) NOT NULL,
  `stato` enum('attivo','inattivo') NOT NULL DEFAULT 'attivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `impianti`
--

INSERT INTO `impianti` (`ID_impianto`, `nome`, `localita`, `tipo_impianto`, `capacita_massima`, `stato`) VALUES
(1, 'Impianto1', 'Napoli', 'Riciclo', 5000.00, 'attivo'),
(2, 'Impianto 2', 'Sud', 'Smaltimento', 1000.00, 'attivo'),
(4, 'Impianto Smaltimento Plastica', 'Nord-est', 'Smaltimento', 10000.00, 'attivo'),
(5, 'impianto sud', 'sud', 'riciclaggio', 2000.00, 'attivo');

-- --------------------------------------------------------

--
-- Struttura della tabella `manutenzioni`
--

CREATE TABLE `manutenzioni` (
  `id` int(11) NOT NULL,
  `id_impianto` int(11) NOT NULL,
  `data_manutenzione` date NOT NULL,
  `tipo_intervento` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `completata` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `manutenzioni`
--

INSERT INTO `manutenzioni` (`id`, `id_impianto`, `data_manutenzione`, `tipo_intervento`, `note`, `completata`) VALUES
(21, 4, '2025-07-25', 'Manutenzione ordinaria', 'Manutenzione per il mantenimento degli impianti attivi', 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `monitoraggio_emissioni_percolato`
--

CREATE TABLE `monitoraggio_emissioni_percolato` (
  `ID_monitoraggio` int(11) NOT NULL,
  `conferimento_id` int(11) NOT NULL,
  `data_rilevazione` date NOT NULL,
  `co2_emessa` decimal(10,3) NOT NULL,
  `percolato_rilevato` decimal(10,3) NOT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `monitoraggio_emissioni_percolato`
--

INSERT INTO `monitoraggio_emissioni_percolato` (`ID_monitoraggio`, `conferimento_id`, `data_rilevazione`, `co2_emessa`, `percolato_rilevato`, `note`) VALUES
(3, 11, '2025-07-04', 34.000, 12.000, 'ooooo'),
(5, 11, '2025-07-04', 23.000, 4.000, 'valori nella norma '),
(6, 12, '2025-07-05', 50.000, 15.000, 'tutti i valori nella norma '),
(7, 14, '2025-07-05', 50.000, 15.000, 'TUTTI I VALORI RISPETTANO LE NORME EUROPEE'),
(8, 16, '2025-07-07', 0.004, 0.004, ''),
(9, 19, '2025-07-09', 25.000, 5.000, 'Conferimento in fase di smaltimento secondo le norme Europee');

-- --------------------------------------------------------

--
-- Struttura della tabella `report`
--

CREATE TABLE `report` (
  `id` int(11) NOT NULL,
  `utente_id` int(11) NOT NULL,
  `data_generazione` timestamp NOT NULL DEFAULT current_timestamp(),
  `filtro_data_inizio` date DEFAULT NULL,
  `filtro_data_fine` date DEFAULT NULL,
  `filtro_impianto_id` int(11) DEFAULT NULL,
  `filtro_tipo_rifiuto` varchar(100) DEFAULT NULL,
  `percorso_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `report`
--

INSERT INTO `report` (`id`, `utente_id`, `data_generazione`, `filtro_data_inizio`, `filtro_data_fine`, `filtro_impianto_id`, `filtro_tipo_rifiuto`, `percorso_file`, `note`) VALUES
(1, 2, '2025-07-03 15:38:57', '2025-07-02', '2025-07-03', NULL, NULL, 'report_conferimenti_20250702_al_20250703.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(2, 2, '2025-07-03 16:46:35', '2025-07-02', '2025-07-03', NULL, NULL, 'report_conferimenti_20250702_al_20250703.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(3, 8, '2025-07-04 09:21:52', '2025-07-02', '2025-07-04', NULL, NULL, 'report_conferimenti_20250702_al_20250704.pdf', 'Report generato da salvaotresantagata@gmail.com'),
(4, 2, '2025-07-04 09:35:17', '2025-07-03', '2025-07-04', NULL, NULL, 'report_conferimenti_20250703_al_20250704.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(5, 2, '2025-07-04 09:35:26', '2025-07-04', '2025-07-04', NULL, NULL, 'report_conferimenti_20250704_al_20250704.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(6, 2, '2025-07-04 09:41:34', '2025-07-04', '2025-07-04', NULL, NULL, 'report_conferimenti_20250704_al_20250704.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(7, 2, '2025-07-04 09:43:13', '2025-07-04', '2025-07-04', NULL, NULL, 'report_conferimenti_20250704_al_20250704.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(8, 2, '2025-07-04 13:36:36', '2025-07-04', '2025-07-05', NULL, NULL, 'report_conferimenti_20250704_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(9, 2, '2025-07-05 12:29:12', '2025-07-04', '2025-07-05', NULL, NULL, 'report_conferimenti_20250704_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(10, 2, '2025-07-05 12:29:54', '2025-07-05', '2025-07-05', NULL, NULL, 'report_conferimenti_20250705_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(11, 2, '2025-07-05 12:31:07', '2025-07-04', '2025-07-05', NULL, NULL, 'report_conferimenti_20250704_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(12, 2, '2025-07-05 12:32:17', '2025-07-04', '2025-07-05', NULL, NULL, 'report_conferimenti_20250704_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(13, 2, '2025-07-05 12:33:03', '2025-07-04', '2025-07-05', NULL, NULL, 'report_conferimenti_20250704_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(14, 2, '2025-07-05 12:33:29', '2025-07-04', '2025-07-05', NULL, NULL, 'report_conferimenti_20250704_al_20250705.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(15, 2, '2025-07-07 17:14:40', '2025-07-03', '2025-07-07', NULL, NULL, 'report_conferimenti_20250703_al_20250707.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(16, 2, '2025-07-07 17:18:20', '2025-07-07', '2025-07-07', NULL, NULL, 'report_conferimenti_20250707_al_20250707.pdf', 'Report generato da pasqualemancino25@gmail.com'),
(17, 9, '2025-07-07 18:13:12', '2025-07-04', '2025-07-07', NULL, NULL, 'report_conferimenti_20250704_al_20250707.pdf', 'Report generato da amministratore@test.com'),
(18, 9, '2025-07-08 12:42:25', '2025-07-01', '2025-07-08', NULL, NULL, 'report_conferimenti_20250701_al_20250708.pdf', 'Report generato da amministratore@test.com');

-- --------------------------------------------------------

--
-- Struttura della tabella `storico_conferimenti`
--

CREATE TABLE `storico_conferimenti` (
  `ID_storico` int(11) NOT NULL,
  `ID_conferimento_originale` int(11) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `data` date NOT NULL,
  `peso` decimal(10,2) NOT NULL,
  `stato` varchar(50) NOT NULL,
  `impianto_id` int(11) NOT NULL,
  `dipendente_id` int(11) NOT NULL,
  `provenienza` varchar(100) NOT NULL,
  `tipo_smaltimento` varchar(100) NOT NULL,
  `pericolosita` enum('no','si') NOT NULL DEFAULT 'no',
  `motivazione_eliminazione` text DEFAULT NULL,
  `data_eliminazione` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `storico_conferimenti`
--

INSERT INTO `storico_conferimenti` (`ID_storico`, `ID_conferimento_originale`, `tipo`, `data`, `peso`, `stato`, `impianto_id`, `dipendente_id`, `provenienza`, `tipo_smaltimento`, `pericolosita`, `motivazione_eliminazione`, `data_eliminazione`) VALUES
(7, 13, 'Organico', '2025-07-05', 50.00, 'in attesa', 2, 5, 'Giugliano in Campania', 'Discarica', 'no', 'Prodotto smaltito', '2025-07-05 12:26:51'),
(8, 15, 'Vetro', '2025-07-07', 34.00, 'in attesa', 2, 5, 'Milano ', 'Discarica', 'no', 'kkk', '2025-07-07 17:17:05');

-- --------------------------------------------------------

--
-- Struttura della tabella `storico_manutenzioni`
--

CREATE TABLE `storico_manutenzioni` (
  `id` int(11) NOT NULL,
  `id_manutenzione` int(11) NOT NULL,
  `azione` varchar(20) NOT NULL,
  `utente` varchar(50) NOT NULL,
  `data_azione` datetime NOT NULL DEFAULT current_timestamp(),
  `dati_precedenti` text DEFAULT NULL,
  `dati_nuovi` text DEFAULT NULL,
  `note_azione` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `storico_manutenzioni`
--

INSERT INTO `storico_manutenzioni` (`id`, `id_manutenzione`, `azione`, `utente`, `data_azione`, `dati_precedenti`, `dati_nuovi`, `note_azione`) VALUES
(12, 14, 'completata', 'sconosciuto', '2025-07-07 16:36:33', '{\"id\":14,\"id_impianto\":4,\"data_manutenzione\":\"2025-07-08\",\"tipo_intervento\":\"Manutenzione ordinaria\",\"note\":\"\",\"completata\":0}', NULL, ''),
(13, 15, 'completata', 'sconosciuto', '2025-07-07 16:41:57', '{\"id\":15,\"id_impianto\":4,\"data_manutenzione\":\"2025-07-08\",\"tipo_intervento\":\"Manutenzione ordinaria\",\"note\":\"\",\"completata\":0}', NULL, ''),
(14, 16, 'completata', 'sconosciuto', '2025-07-07 16:45:02', '{\"id\":16,\"id_impianto\":4,\"data_manutenzione\":\"2025-07-11\",\"tipo_intervento\":\"Manutenzione ordinaria\",\"note\":\"\",\"completata\":0}', NULL, ''),
(15, 18, 'completata', 'sconosciuto', '2025-07-07 16:50:41', '{\"id\":18,\"id_impianto\":4,\"data_manutenzione\":\"2025-07-10\",\"tipo_intervento\":\"Manutenzione ordinaria\",\"note\":\"\",\"completata\":0}', NULL, ''),
(16, 19, 'completata', 'sconosciuto', '2025-07-07 19:15:48', '{\"id\":19,\"id_impianto\":4,\"data_manutenzione\":\"2025-07-09\",\"tipo_intervento\":\"Manutenzione ordinaria\",\"note\":\"\",\"completata\":0}', NULL, '');

-- --------------------------------------------------------

--
-- Struttura della tabella `turnazioni`
--

CREATE TABLE `turnazioni` (
  `id` int(11) NOT NULL,
  `id_impianto` int(11) NOT NULL,
  `tipo_turno` enum('Mattina','Pomeriggio','Notte') NOT NULL,
  `note` text DEFAULT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `turnazioni`
--

INSERT INTO `turnazioni` (`id`, `id_impianto`, `tipo_turno`, `note`, `data_inizio`, `data_fine`) VALUES
(1, 2, 'Mattina', 'turnazione impianto 2 per questi giorni vista l\'affluenza di conferimenti per questo impianto', '2025-07-04', '2025-07-06'),
(2, 1, 'Pomeriggio', '', '2025-07-04', '2025-07-08'),
(3, 4, 'Notte', 'l\'impianto resterà in funznione dalle 22:00 alle 6:00', '2025-07-08', '2025-07-13');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ruolo` varchar(20) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `data_registrazione` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`id`, `email`, `password`, `ruolo`, `nome`, `cognome`, `data_registrazione`) VALUES
(2, 'pasqualemancino25@gmail.com', '$2y$10$jOkx4ymbr9IiWmKFMbGYDeqfdkWmEq1jHxerZcoi1esTXPelVwDF2', 'amministratore', NULL, NULL, '2025-06-14 15:47:44'),
(3, 'rossi@gmail.com', '$2y$10$WGqJN0k2U9Y.sSNmH5CCQ.7AvTcA/EECr4uogw.D/Sz1CzGiEXVQu', 'dipendente', NULL, NULL, '2025-06-14 16:12:48'),
(5, 'dinardo@gmail.com', '$2y$10$XxvRpEduXcricBnrJRpHZO58DLlaE5dRyXRaCClwAPVgjE1XGofZu', 'dipendente', NULL, NULL, '2025-07-02 10:02:06'),
(7, 'giovannimancino@gmail.com', '$2y$10$hHlL8dPH2fGrmIElngKgmeXDiiJsxOIEqi4lAjE47Vm4Cz4u6A91y', 'dipendente', 'Giovanni ', 'Mancino', '2025-07-02 15:37:17'),
(8, 'salvaotresantagata@gmail.com', '$2y$10$bf2iUxzL67hvb0vxBKk6Uefmwsqp1Vfqm.yX.okSIiyjdSJ4n0NQ6', 'amministratore', 'Salvatore', 'Santagata', '2025-07-04 09:21:02'),
(9, 'amministratore@test.com', '$2y$10$OQVsZf8hMGwDlOgpzUZORefxtS.7B4XJEVjL/jA1eD4l7WUwqfw5e', 'amministratore', 'admin', 'Test', '2025-07-07 17:36:52'),
(10, 'dipendente@test.com', '$2y$10$cNIyn7lPeCZ6WNAFe8CMw.I4hH/B5rG2fisg1JlE/RMzix.LYS1Ji', 'dipendente', 'dipendente', '123', '2025-07-08 12:45:58');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `conferimenti`
--
ALTER TABLE `conferimenti`
  ADD PRIMARY KEY (`ID_conferimento`),
  ADD KEY `fk_impianto` (`impianto_id`),
  ADD KEY `fk_dipendente` (`dipendente_id`);

--
-- Indici per le tabelle `impianti`
--
ALTER TABLE `impianti`
  ADD PRIMARY KEY (`ID_impianto`);

--
-- Indici per le tabelle `manutenzioni`
--
ALTER TABLE `manutenzioni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_impianto` (`id_impianto`);

--
-- Indici per le tabelle `monitoraggio_emissioni_percolato`
--
ALTER TABLE `monitoraggio_emissioni_percolato`
  ADD PRIMARY KEY (`ID_monitoraggio`),
  ADD KEY `conferimento_id` (`conferimento_id`);

--
-- Indici per le tabelle `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utente_id` (`utente_id`),
  ADD KEY `filtro_impianto_id` (`filtro_impianto_id`);

--
-- Indici per le tabelle `storico_conferimenti`
--
ALTER TABLE `storico_conferimenti`
  ADD PRIMARY KEY (`ID_storico`),
  ADD KEY `impianto_id` (`impianto_id`),
  ADD KEY `dipendente_id` (`dipendente_id`);

--
-- Indici per le tabelle `storico_manutenzioni`
--
ALTER TABLE `storico_manutenzioni`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `turnazioni`
--
ALTER TABLE `turnazioni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_impianto` (`id_impianto`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `conferimenti`
--
ALTER TABLE `conferimenti`
  MODIFY `ID_conferimento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT per la tabella `impianti`
--
ALTER TABLE `impianti`
  MODIFY `ID_impianto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `manutenzioni`
--
ALTER TABLE `manutenzioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT per la tabella `monitoraggio_emissioni_percolato`
--
ALTER TABLE `monitoraggio_emissioni_percolato`
  MODIFY `ID_monitoraggio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la tabella `report`
--
ALTER TABLE `report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT per la tabella `storico_conferimenti`
--
ALTER TABLE `storico_conferimenti`
  MODIFY `ID_storico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT per la tabella `storico_manutenzioni`
--
ALTER TABLE `storico_manutenzioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT per la tabella `turnazioni`
--
ALTER TABLE `turnazioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `conferimenti`
--
ALTER TABLE `conferimenti`
  ADD CONSTRAINT `conferimenti_ibfk_1` FOREIGN KEY (`impianto_id`) REFERENCES `impianti` (`ID_impianto`),
  ADD CONSTRAINT `conferimenti_ibfk_2` FOREIGN KEY (`dipendente_id`) REFERENCES `utenti` (`id`),
  ADD CONSTRAINT `fk_dipendente` FOREIGN KEY (`dipendente_id`) REFERENCES `utenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_impianto` FOREIGN KEY (`impianto_id`) REFERENCES `impianti` (`ID_impianto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `manutenzioni`
--
ALTER TABLE `manutenzioni`
  ADD CONSTRAINT `manutenzioni_ibfk_1` FOREIGN KEY (`id_impianto`) REFERENCES `impianti` (`ID_impianto`);

--
-- Limiti per la tabella `monitoraggio_emissioni_percolato`
--
ALTER TABLE `monitoraggio_emissioni_percolato`
  ADD CONSTRAINT `monitoraggio_emissioni_percolato_ibfk_1` FOREIGN KEY (`conferimento_id`) REFERENCES `conferimenti` (`ID_conferimento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`utente_id`) REFERENCES `utenti` (`id`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`filtro_impianto_id`) REFERENCES `impianti` (`ID_impianto`);

--
-- Limiti per la tabella `storico_conferimenti`
--
ALTER TABLE `storico_conferimenti`
  ADD CONSTRAINT `storico_conferimenti_ibfk_1` FOREIGN KEY (`impianto_id`) REFERENCES `impianti` (`ID_impianto`),
  ADD CONSTRAINT `storico_conferimenti_ibfk_2` FOREIGN KEY (`dipendente_id`) REFERENCES `utenti` (`id`);

--
-- Limiti per la tabella `turnazioni`
--
ALTER TABLE `turnazioni`
  ADD CONSTRAINT `turnazioni_ibfk_1` FOREIGN KEY (`id_impianto`) REFERENCES `impianti` (`ID_impianto`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
