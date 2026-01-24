-- Feedback table for user submissions.

CREATE TABLE IF NOT EXISTS feedback (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL DEFAULT auth.uid(),
  email TEXT,
  message TEXT NOT NULL,
  page_path TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE feedback ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can submit feedback"
ON feedback
FOR INSERT
WITH CHECK (true);
