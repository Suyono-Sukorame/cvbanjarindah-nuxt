/**
 * Auth Middleware
 * Protects admin routes
 */

export default defineNuxtRouteMiddleware(async (to) => {
  if (!to.path.startsWith('/admin') || to.path === '/admin/login') return;

  const { checkAuth } = useAuth();
  try {
    const user = await checkAuth();
    if (!user) {
      return navigateTo({ path: '/admin/login', query: { redirect: to.fullPath } });
    }
  } catch {
    return navigateTo({ path: '/admin/login', query: { redirect: to.fullPath } });
  }
});
