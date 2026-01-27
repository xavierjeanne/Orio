import Link from "next/link";

const links = [
  { href: "/events", label: "Événements" },
  { href: "/venues", label: "Lieux" },
  { href: "/blog", label: "Blog" },
];

export function HeaderNav() {
  return (
    <nav className="flex items-center gap-6">
      {links.map((link) => (
        <Link
          key={link.href}
          href={link.href}
          className="text-sm font-medium hover:text-primary"
        >
          {link.label}
        </Link>
      ))}
    </nav>
  );
}
