-- Create the game covers cache table
create table if not exists public.game_covers (
  game_title text primary key,
  cover_url text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Row Level Security (RLS) for game covers
alter table public.game_covers enable row level security;

create policy "Permitir leitura pública de capas"
  on public.game_covers for select
  using (true);

create policy "Permitir inserção de capas"
  on public.game_covers for insert
  with check (true);
