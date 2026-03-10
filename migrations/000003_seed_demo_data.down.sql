-- migrations/000003_seed_demo_data.down.sql
-- Remove seeded demo data.

-- Cancellations
DELETE FROM appt_cancellation
WHERE appointment_id IN (3104, 3109);

-- Appointments
DELETE FROM appointment
WHERE appointment_id IN (3101, 3102, 3103, 3104, 3105, 3106, 3107, 3108, 3109, 3110);

-- Provider specialties
DELETE FROM provider_specialty
WHERE (provider_id, specialty_id) IN (
	(1101, 1),
	(1101, 3),
	(1102, 2),
	(1103, 4),
	(1104, 5),
	(1105, 1)
);

-- Contacts
DELETE FROM person_contact
WHERE person_contact_id IN (
	2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109,
	2110, 2111, 2112, 2113, 2114, 2115, 2116, 2117
);

-- Roles
DELETE FROM patient
WHERE patient_id IN (1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310);

DELETE FROM staff
WHERE staff_id IN (1201, 1202);

DELETE FROM provider
WHERE provider_id IN (1101, 1102, 1103, 1104, 1105);

-- Persons
DELETE FROM person
WHERE person_id IN (
	1101, 1102, 1103, 1104, 1105,
	1201, 1202,
	1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310
);

-- Reference tables
DELETE FROM cancellation_reason
WHERE reason_id IN (1, 2, 3);

DELETE FROM appt_type
WHERE appt_type_id IN (1, 2, 3);

DELETE FROM specialty
WHERE specialty_id IN (1, 2, 3, 4, 5);

DELETE FROM contact_type
WHERE contact_type_id IN (1, 2);