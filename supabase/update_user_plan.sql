-- Run this query in your Supabase Dashboard SQL Editor to upgrade the user.

UPDATE public.profiles
SET plan_tier = 'ultimate'
WHERE id = (
  SELECT id FROM auth.users WHERE email = 'otavio100206@gmail.com'
);

-- Verification (Optional)
SELECT * FROM public.profiles 
WHERE id = (
  SELECT id FROM auth.users WHERE email = 'otavio100206@gmail.com'
);
