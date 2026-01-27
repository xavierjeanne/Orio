import Link from "next/link";
import { HeaderNav } from "./header-nav";
import { MobileMenu } from "./mobile-menu";

export function Header() {
  return (
    <header className="border-b">
      <div className="container flex h-16 items-center justify-between">
        {/* Logo */}
        <Link href="/" className="text-xl font-bold">
          Orio
        </Link>

        {/* Desktop */}
        <div className="hidden md:flex">
          <HeaderNav />
        </div>

        {/* Mobile */}
        <div className="md:hidden">
          <MobileMenu />
        </div>
      </div>
    </header>
  );
}
