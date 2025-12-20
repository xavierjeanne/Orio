import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Orio - Agrégateur d\'événements',
  description: 'Découvrez les événements près de chez vous',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="fr">
      <body>{children}</body>
    </html>
  )
}
