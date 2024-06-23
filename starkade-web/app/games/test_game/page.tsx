import { redirect } from 'next/navigation';

export default function Page() {
  redirect('http://localhost:5173');

  return null; // This component doesn't render anything
}
