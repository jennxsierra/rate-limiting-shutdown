-- migrations/000003_seed_demo_data.up.sql
-- Seed demo data for MAS.

-- ==============================
-- REFERENCE TABLES
-- ==============================

INSERT INTO contact_type (contact_type_id, contact_type_name) VALUES
  (1, 'email'),
  (2, 'phone')
ON CONFLICT (contact_type_id) DO NOTHING;

INSERT INTO specialty (specialty_id, specialty_name) VALUES
  (1, 'General Practice'),
  (2, 'Pediatrics'),
  (3, 'Cardiology'),
  (4, 'Dermatology'),
  (5, 'Orthopedics')
ON CONFLICT (specialty_id) DO NOTHING;

INSERT INTO appt_type (appt_type_id, appt_type_name) VALUES
  (1, 'Consultation'),
  (2, 'Follow-up'),
  (3, 'Annual Physical')
ON CONFLICT (appt_type_id) DO NOTHING;

INSERT INTO cancellation_reason (reason_id, reason_name) VALUES
  (1, 'Patient request'),
  (2, 'Provider unavailable'),
  (3, 'Insurance issue')
ON CONFLICT (reason_id) DO NOTHING;

-- ==============================
-- PERSONS
-- 5 providers, 2 staff, 10 patients
-- ==============================

INSERT INTO person (person_id, first_name, last_name, date_of_birth, gender, created_at) VALUES
  (1101, 'Maya',    'Lopez',     '1987-04-12', 'female', NOW()),
  (1102, 'Noah',    'Singh',     '1982-07-19', 'male',   NOW()),
  (1103, 'Elena',   'Morales',   '1979-03-08', 'female', NOW()),
  (1104, 'Victor',  'Kim',       '1985-11-22', 'male',   NOW()),
  (1105, 'Priya',   'Patel',     '1990-06-05', 'female', NOW()),
  (1201, 'Aaron',   'Young',     '1986-09-03', 'male',   NOW()),
  (1202, 'Dina',    'Chan',      '1991-01-28', 'female', NOW()),
  (1301, 'Liam',    'Garcia',    '2000-02-14', 'male',   NOW()),
  (1302, 'Sophia',  'Martinez',  '1998-05-21', 'female', NOW()),
  (1303, 'Ethan',   'Nguyen',    '1995-08-02', 'male',   NOW()),
  (1304, 'Olivia',  'Brown',     '2002-12-10', 'female', NOW()),
  (1305, 'Ava',     'Rivera',    '1997-03-30', 'female', NOW()),
  (1306, 'Lucas',   'Wright',    '1993-10-16', 'male',   NOW()),
  (1307, 'Mia',     'Torres',    '2001-09-09', 'female', NOW()),
  (1308, 'Jackson', 'Hernandez', '1996-01-11', 'male',   NOW()),
  (1309, 'Emma',    'Hall',      '1994-07-27', 'female', NOW()),
  (1310, 'Benjamin','Adams',     '1992-04-01', 'male',   NOW())
ON CONFLICT (person_id) DO NOTHING;

-- ==============================
-- ROLES
-- ==============================

INSERT INTO provider (provider_id, license_no) VALUES
  (1101, 'LIC-1101'),
  (1102, 'LIC-1102'),
  (1103, 'LIC-1103'),
  (1104, 'LIC-1104'),
  (1105, 'LIC-1105')
ON CONFLICT (provider_id) DO NOTHING;

INSERT INTO staff (staff_id, staff_no) VALUES
  (1201, 'STF-1201'),
  (1202, 'STF-1202')
ON CONFLICT (staff_id) DO NOTHING;

INSERT INTO patient (patient_id, patient_no, ssn) VALUES
  (1301, 'PAT-1301', '999-10-1301'),
  (1302, 'PAT-1302', '999-10-1302'),
  (1303, 'PAT-1303', '999-10-1303'),
  (1304, 'PAT-1304', '999-10-1304'),
  (1305, 'PAT-1305', '999-10-1305'),
  (1306, 'PAT-1306', '999-10-1306'),
  (1307, 'PAT-1307', '999-10-1307'),
  (1308, 'PAT-1308', '999-10-1308'),
  (1309, 'PAT-1309', '999-10-1309'),
  (1310, 'PAT-1310', '999-10-1310')
ON CONFLICT (patient_id) DO NOTHING;

-- ==============================
-- CONTACTS
-- ==============================

INSERT INTO person_contact (person_contact_id, contact_value, is_primary, person_id, contact_type_id) VALUES
  (2101, 'maya.lopez@clinic.test',        TRUE,  1101, 1),
  (2102, 'noah.singh@clinic.test',        TRUE,  1102, 1),
  (2103, 'elena.morales@clinic.test',     TRUE,  1103, 1),
  (2104, 'victor.kim@clinic.test',        TRUE,  1104, 1),
  (2105, 'priya.patel@clinic.test',       TRUE,  1105, 1),
  (2106, 'aaron.young@clinic.test',       TRUE,  1201, 1),
  (2107, 'dina.chan@clinic.test',         TRUE,  1202, 1),
  (2108, 'liam.garcia@patient.test',      TRUE,  1301, 1),
  (2109, 'sophia.martinez@patient.test',  TRUE,  1302, 1),
  (2110, 'ethan.nguyen@patient.test',     TRUE,  1303, 1),
  (2111, 'olivia.brown@patient.test',     TRUE,  1304, 1),
  (2112, 'ava.rivera@patient.test',       TRUE,  1305, 1),
  (2113, 'lucas.wright@patient.test',     TRUE,  1306, 1),
  (2114, 'mia.torres@patient.test',       TRUE,  1307, 1),
  (2115, 'jackson.hernandez@patient.test',TRUE,  1308, 1),
  (2116, 'emma.hall@patient.test',        TRUE,  1309, 1),
  (2117, 'benjamin.adams@patient.test',   TRUE,  1310, 1)
ON CONFLICT (person_contact_id) DO NOTHING;

-- ==============================
-- PROVIDER SPECIALTIES
-- ==============================

INSERT INTO provider_specialty (provider_id, specialty_id) VALUES
  (1101, 1),
  (1101, 3),
  (1102, 2),
  (1103, 4),
  (1104, 5),
  (1105, 1)
ON CONFLICT DO NOTHING;

-- ==============================
-- APPOINTMENTS
-- ==============================

INSERT INTO appointment (
  appointment_id, start_time, end_time, created_at, updated_at, reason,
  patient_id, provider_id, created_by, appt_type_id
) VALUES
  (3101, TIMESTAMPTZ '2026-03-02 09:00:00-06', TIMESTAMPTZ '2026-03-02 09:30:00-06', NOW(), NULL, 'Annual wellness visit',        1301, 1101, 1201, 3),
  (3102, TIMESTAMPTZ '2026-03-02 10:00:00-06', TIMESTAMPTZ '2026-03-02 10:20:00-06', NOW(), NULL, 'Skin rash consultation',      1302, 1103, 1201, 1),
  (3103, TIMESTAMPTZ '2026-03-02 11:00:00-06', TIMESTAMPTZ '2026-03-02 11:30:00-06', NOW(), NULL, 'Knee pain follow-up',         1303, 1104, 1202, 2),
  (3104, TIMESTAMPTZ '2026-03-03 08:30:00-06', TIMESTAMPTZ '2026-03-03 09:00:00-06', NOW(), NULL, 'Pediatric fever check',       1304, 1102, 1201, 1),
  (3105, TIMESTAMPTZ '2026-03-03 09:30:00-06', TIMESTAMPTZ '2026-03-03 10:00:00-06', NOW(), NULL, 'Blood pressure review',       1305, 1101, 1202, 2),
  (3106, TIMESTAMPTZ '2026-03-03 10:15:00-06', TIMESTAMPTZ '2026-03-03 10:45:00-06', NOW(), NULL, 'Mole evaluation',             1306, 1103, 1201, 1),
  (3107, TIMESTAMPTZ '2026-03-03 11:00:00-06', TIMESTAMPTZ '2026-03-03 11:20:00-06', NOW(), NULL, 'Sports injury consultation',  1307, 1104, 1202, 1),
  (3108, TIMESTAMPTZ '2026-03-04 09:00:00-06', TIMESTAMPTZ '2026-03-04 09:30:00-06', NOW(), NULL, 'Cardiology consultation',     1308, 1101, 1201, 1),
  (3109, TIMESTAMPTZ '2026-03-04 10:00:00-06', TIMESTAMPTZ '2026-03-04 10:30:00-06', NOW(), NULL, 'Annual physical exam',        1309, 1105, 1202, 3),
  (3110, TIMESTAMPTZ '2026-03-04 11:00:00-06', TIMESTAMPTZ '2026-03-04 11:30:00-06', NOW(), NULL, 'General follow-up visit',     1310, 1105, 1201, 2)
ON CONFLICT (appointment_id) DO NOTHING;

-- ==============================
-- CANCELLATIONS (2)
-- ==============================

INSERT INTO appt_cancellation (
  appointment_id, cancelled_at, note, reason_id, recorded_by
) VALUES
  (3104, NOW(), 'Patient requested reschedule due to travel.', 1, 1201),
  (3109, NOW(), 'Provider unavailable due to emergency.',      2, 1202)
ON CONFLICT (appointment_id) DO NOTHING;