/**
 * Auth Middleware
 * Protects admin routes
 */

export default defineRouteMiddleware(async (to, from) => {
  // TODO: Implement Supabase auth check
  // Example:
  // const { $supabase } = useNuxtApp();
  // const session = await $supabase.auth.getSession();
  // if (!session) {
  //   return navigateTo('/login');
  // }
});
