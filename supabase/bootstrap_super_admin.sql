BEGIN;

DO $$
DECLARE
  target_user auth.users%ROWTYPE;
BEGIN
  SELECT *
  INTO target_user
  FROM auth.users
  WHERE lower(email) = lower('yonoabdulloh@gmail.com')
  LIMIT 1;

  IF target_user.id IS NULL THEN
    RAISE EXCEPTION 'Akun yonoabdulloh@gmail.com belum ada di Supabase Authentication > Users.';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM public.admin_users
    WHERE role = 'super_admin'
      AND is_active = true
      AND id <> target_user.id
  ) THEN
    RAISE EXCEPTION 'Sudah ada super admin aktif dengan akun lain. Tidak ada perubahan yang dibuat.';
  END IF;

  INSERT INTO public.admin_users (id, email, full_name, role, is_active)
  VALUES (
    target_user.id,
    target_user.email,
    COALESCE(target_user.raw_user_meta_data ->> 'full_name', 'Yono Abdulloh'),
    'super_admin',
    true
  )
  ON CONFLICT (id) DO UPDATE
  SET email = EXCLUDED.email,
      full_name = COALESCE(EXCLUDED.full_name, public.admin_users.full_name),
      role = 'super_admin',
      is_active = true,
      updated_at = NOW();
END;
$$;

COMMIT;

SELECT id, email, role, is_active
FROM public.admin_users
WHERE lower(email) = lower('yonoabdulloh@gmail.com');
