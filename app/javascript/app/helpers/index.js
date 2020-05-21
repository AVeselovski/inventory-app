export function getError(err) {
  return err[0].charAt(0).toUpperCase() + err[0].slice(1);
}
