# 📖 TUTORIAL DEPLOYMENT

## Wedding Invitation — Adellian \& Alfiyan

\---

## LANGKAH 1 — SETUP SUPABASE (Database)

### 1.1 Buat Project

1. Buka https://supabase.com → Sign Up / Login
2. Klik **"New Project"**
3. Isi:

   * **Name**: `wedding-adellian-alfiyan`
   * **Database Password**: buat password kuat, simpan (Password: inv-Adellian)
   * **Region**: Southeast Asia (Singapore)
4. Klik **"Create new project"** → tunggu \~2 menit

### 1.2 Jalankan SQL Schema

1. Di sidebar kiri → klik **"SQL Editor"**
2. Klik **"New query"**
3. Copy-paste seluruh isi file `supabase/schema.sql`
4. Klik tombol **"Run"** (▶)
5. Pastikan muncul: `Success. No rows returned`

### 1.3 Ambil Kredensial

1. Di sidebar kiri → **Settings** → **API**
2. Catat dua nilai ini:

   * **Project URL** → contoh: `https://abcdefgh.supabase.co`
   * **anon / public key** → string panjang mulai `eyJ...`

### 1.4 Pasang Kredensial di HTML

1. Buka file `public/index.html`
2. Cari baris (sekitar baris 5 dari akhir):

```
   var SUPA\_URL='https://YOUR\_PROJECT\_ID.supabase.co';
   var SUPA\_KEY='YOUR\_ANON\_PUBLIC\_KEY';
   ```

3. Ganti dengan nilai dari langkah 1.3:

```
   var SUPA\_URL='https://abcdefgh.supabase.co';
   var SUPA\_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
   ```

4. **Save** file

\---

## LANGKAH 2 — UPLOAD KE GITHUB

### 2.1 Buat Repository

1. Buka https://github.com → Login
2. Klik **"+"** → **"New repository"**
3. Isi:

   * **Repository name**: `wedding-invitation`
   * Pilih **Public** (agar Vercel bisa akses gratis)
   * Jangan centang apapun
4. Klik **"Create repository"**

### 2.2 Upload File

1. Di halaman repo yang baru dibuat, klik **"uploading an existing file"**
2. Drag \& drop semua file/folder:

```
   public/
     index.html
   supabase/
     schema.sql
   vercel.json
   .gitignore
   README.md
   TUTORIAL.md
   ```

3. Scroll bawah → isi commit message: `Initial upload`
4. Klik **"Commit changes"**

\---

## LANGKAH 3 — DEPLOY KE VERCEL

### 3.1 Connect Vercel

1. Buka https://vercel.com → Sign Up dengan akun GitHub
2. Klik **"Add New Project"**
3. Pilih repository `wedding-invitation` → klik **"Import"**

### 3.2 Konfigurasi Build

1. **Framework Preset**: pilih **"Other"**
2. **Root Directory**: ketik `public`
3. **Build Command**: kosongkan (hapus semua)
4. **Output Directory**: kosongkan
5. Klik **"Deploy"**

### 3.3 Dapat Domain

Setelah deploy selesai (\~1 menit), kamu dapat URL:

```
https://wedding-invitation-xxxx.vercel.app
```

Ini adalah base URL undanganmu.

### 3.4 Custom Domain (Opsional)

1. Di Vercel → project → **Settings** → **Domains**
2. Tambahkan domain kamu (contoh: `undangan.adellian-alfiyan.com`)
3. Ikuti instruksi DNS yang diberikan Vercel

\---

## LANGKAH 4 — GENERATE LINK PER TAMU (Excel)

### 4.1 Buka Excel Guest List

Buka file Excel guest list kamu yang sudah ada.

### 4.2 Tambah Kolom "Link Undangan"

1. Tambah kolom baru di sebelah kanan (misal kolom E)
2. Beri header: `Link Undangan`
3. Di sel **E2**, masukkan formula:

```excel
="https://wedding-invitation-xxxx.vercel.app/?to="\&SUBSTITUTE(C2," ","+")\&"\&id="\&B2
```

Keterangan:

* Ganti `wedding-invitation-xxxx.vercel.app` dengan URL Vercel kamu
* `C2` = kolom nama tamu
* `B2` = kolom Guest ID
4. Drag formula ke bawah untuk semua 172 baris
5. Hasilnya otomatis seperti:

```
   https://domain.com/?to=Bpk+Abdul+Rois\&id=NA-001
   https://domain.com/?to=Ibu+Sari\&id=NB-002
   ```

### 4.3 Kirim via WhatsApp

Copy link per baris → paste ke chat WhatsApp masing-masing tamu.

\---

## LANGKAH 5 — DOWNLOAD DATA RSVP

### Cara A — Dari Supabase Dashboard

1. Buka https://supabase.com → project kamu
2. Sidebar → **Table Editor** → pilih tabel `rsvp`
3. Klik ikon **download** (pojok kanan atas) → **Export to CSV**

### Cara B — Query SQL Custom

1. **SQL Editor** → New query:

```sql
SELECT
  guest\_id,
  guest\_name,
  respondent\_name,
  attendance,
  guest\_count,
  message,
  created\_at
FROM rsvp
ORDER BY created\_at ASC;
```

2. Klik **Run** → klik **Export** → pilih CSV

\---

## RINGKASAN URL FORMAT

|Tamu|URL|
|-|-|
|Bpk Abdul Rois (NA-001)|`domain.com/?to=Bpk+Abdul+Rois\&id=NA-001`|
|Ibu Sari (NB-002)|`domain.com/?to=Ibu+Sari\&id=NB-002`|
|Keluarga Besar (NC-005)|`domain.com/?to=Keluarga+Besar+Sugeng\&id=NC-005`|

QR Code di halaman terakhir otomatis berisi Guest ID dari URL.

\---

## TROUBLESHOOTING

**QR tidak muncul?**
→ Pastikan URL punya parameter `?id=NA-001`

**RSVP gagal kirim?**
→ Cek SUPA\_URL dan SUPA\_KEY sudah benar di index.html

**Wishes tidak tampil?**
→ Cek policy Supabase sudah dijalankan (langkah 1.2)

**Halaman tidak terbuka di Vercel?**
→ Pastikan Root Directory diset ke `public` saat deploy

\---

*Dibuat dengan ❤ untuk Adellian \& Alfiyan · 22 Mei 2027*

