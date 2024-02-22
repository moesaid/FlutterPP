class AppConfig {
  // sizes
  static const double rail = 70.0;
  static const double sidebar = 200.0;

  // supabase
  static String supabaseCallback = 'com.supabase.auth://auth-callback/';
  static String supabaseURL = 'https://prtzqqxkevgnboghrihy.supabase.co';
  static String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBydHpxcXhrZXZnbmJvZ2hyaWh5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzIyMDMyNjAsImV4cCI6MTk4Nzc3OTI2MH0.AELMWxyAPro-xyoDjWj6nfrskT1ETl-NBALLhw7hyKQ';

  // sentry
  static String sentryDNS =
      'https://e407c3ef6cc404c16e122a4f614eb4d1@o4506790254936064.ingest.sentry.io/4506790264504320';
}
