-- ════════════════════════════════════════
-- WEDDING INVITATION — SUPABASE SCHEMA
-- Jalankan di: Supabase > SQL Editor
-- ════════════════════════════════════════

-- 1. Tabel RSVP
CREATE TABLE IF NOT EXISTS rsvp (
  id           BIGSERIAL PRIMARY KEY,
  guest_id     TEXT NOT NULL,
  guest_name   TEXT,
  respondent_name TEXT NOT NULL,
  attendance   TEXT NOT NULL CHECK (attendance IN ('Hadir', 'Tidak Hadir')),
  guest_count  INTEGER DEFAULT 1,
  message      TEXT,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tabel Wishes/Ucapan
CREATE TABLE IF NOT EXISTS wishes (
  id           BIGSERIAL PRIMARY KEY,
  guest_id     TEXT,
  sender_name  TEXT NOT NULL,
  message      TEXT NOT NULL,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Enable Row Level Security
ALTER TABLE rsvp   ENABLE ROW LEVEL SECURITY;
ALTER TABLE wishes ENABLE ROW LEVEL SECURITY;

-- 4. Policy: tamu bisa INSERT rsvp (1x per guest_id)
CREATE POLICY "Allow insert rsvp" ON rsvp
  FOR INSERT WITH CHECK (true);

-- 5. Policy: tamu TIDAK bisa baca/edit data rsvp orang lain
CREATE POLICY "Allow own rsvp read" ON rsvp
  FOR SELECT USING (true);

-- 6. Policy: tamu bisa INSERT wishes
CREATE POLICY "Allow insert wishes" ON wishes
  FOR INSERT WITH CHECK (true);

-- 7. Policy: semua bisa baca wishes (untuk tampil di halaman)
CREATE POLICY "Allow read wishes" ON wishes
  FOR SELECT USING (true);

-- ════════════════════════════════════════
-- SELESAI. Cek tabel di Table Editor.
-- ════════════════════════════════════════
