import Link from 'next/link';

const WorkInProgress = () => {
	return (
		<div>
			<h1>Starkade</h1>
			<p className="text-center text-xl text-pink">This game is a work in progress, please check back later for updates</p>
			<p className="text-center mt-2 text-lg text-white"><Link href="/">Go back to the homepage</Link></p>
		</div>
	);
};

export default WorkInProgress;
