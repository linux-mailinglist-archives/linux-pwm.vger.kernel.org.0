Return-Path: <linux-pwm+bounces-6251-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D20ACFCE3
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 08:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6824D16BC5F
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7022580FE;
	Fri,  6 Jun 2025 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZkdtQL+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92513259CBA;
	Fri,  6 Jun 2025 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749191619; cv=none; b=ph8zO8Zkj1DDd0GAuZsasVcmMZBWyu1MFaBBKpzKXStjC/otfrJmu21C+ibSpCmr5F/ax/4JdFLjHLK98r/v4vftpEhKeHSUc5/l4qciVujf5gkRtrdEOpfnCiVqg6jsTXEDaxhfL+mf85juJPzQXPljXHIk53N9SY76MKyFoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749191619; c=relaxed/simple;
	bh=aUwDasDA5/2ENB04bUdMswhAWkOrxuJrN+4Xp9A3PL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3d8q4I0H1+5AImJHNKqGZrAh4fQjiCBTCa7fyD2qRhnR8EPyLFsEwM6rkHzzegh9J5d0gwGpjgpadMyQEiptELX+x1RNs5pdQ1V0BJHKVbEWdkMDBCivD+67Io08E65tGfA1yaakFZ+2ayxiT4AppxzxuarYZ55BXeGI6AU12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZkdtQL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2C8C4CEF5;
	Fri,  6 Jun 2025 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749191619;
	bh=aUwDasDA5/2ENB04bUdMswhAWkOrxuJrN+4Xp9A3PL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZkdtQL+wTsE9EqTH4lhD3/nx80cTLT1nBsm7KKYApIpdavFBk6eKOxgCJJgWz2DA
	 emFMMXuD2Kr/+oyogoi2VxMvi685hS3UK2MskOepz9RmRySy17dOYpyYvu/n1+2oC8
	 rzp9No0TboK19JMoscP9alholhZhxajAyP2Na3J7QKtb75BzSQE1+NWXQBKEAc+DTY
	 V2dbZ9INQpfh+gZJPiBj8IVS/l5pT7IcKML73KcvDCncAAAY599Uu9MZqcGUJB5re7
	 Ftw/QiJzUpiBZrbEvGNuiDsVmUumQgwbOmbTXHWlDwJCkqYSvp3hCS078iUfV1kGPO
	 2X5dkFwGjx34A==
Date: Fri, 6 Jun 2025 08:33:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v13] pwm: airoha: Add support for EN7581 SoC
Message-ID: <2nm7l3dsrg3xdzc3zrwfdvcmkiphfxils6yp6njvngvkzmedjd@bxgn2erlp7k4>
References: <20250509223653.8800-1-ansuelsmth@gmail.com>
 <ndntz3ttiosqmduyg5lur6m2rdsg7zbiyrkxjhzknml5bprd4r@76wu76ddp4uj>
 <68416753.050a0220.1b2d45.505c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47x3mymq5bybwzyh"
Content-Disposition: inline
In-Reply-To: <68416753.050a0220.1b2d45.505c@mx.google.com>


--47x3mymq5bybwzyh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Thu, Jun 05, 2025 at 11:45:52AM +0200, Christian Marangi wrote:
> On Tue, Jun 03, 2025 at 06:57:36PM +0200, Uwe Kleine-K=F6nig wrote:
> > [....]
> > It took me a while to come up with that, and it's completely untested.
> >
>=20
> Mhhh it looks quite confusing. Also just to understand and looking at
> the PWM core, we should search for the bucket that is both closer to the
> requested duty and the requested period correct? In v12 I was with the
> idea that only period had to be closer.

The objective is as follows:

Pick the maximal possible period that isn't bigger than the requested
period. For that period pick the maximal duty_cycle that isn't bigger
than the requested duty_cycle. (For the waveform callbacks the algorithm
is slightly different.)

> Anyway do you think this alternative version can work? I applied a more
> simple logic.
>=20
> static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> 				    u64 period_ns)
> {
> 	unsigned long best_bucket_diff =3D ULONG_MAX;
> 	int i, best =3D -ENOENT, unused =3D -ENOENT;
>=20
> 	for (i =3D 0; i < ARRAY_SIZE(pc->buckets); i++) {
> 		struct airoha_pwm_bucket *bucket =3D &pc->buckets[i];
> 		unsigned long duty_diff, period_diff, bucket_diff;
> 		u64 bucket_period_ns =3D bucket->period_ns;
> 		u64 bucket_duty_ns =3D bucket->duty_ns;
> 		u32 duty_ticks, duty_ticks_bucket;
>=20
> 		/* If found, save an unused bucket to return it later */
> 		if (!bucket->used && unused =3D=3D -ENOENT) {

You should drop the check for `unused =3D=3D -ENOENT` here as with
!bucket->used bucket_period_ns and bucket_duty_ns are not values that
you should work with.

> 			unused =3D i;
> 			continue;
> 		}
>=20
> 		/* We found a matching bucket, exit early */
> 		if (duty_ns =3D=3D bucket_duty_ns &&
> 		    period_ns =3D=3D bucket_period_ns)
> 		    	return i;
>=20
> 		/*
> 		 * Unlike duty cycle zero, which can be handled by
> 		 * disabling PWM, a generator is needed for full duty
> 		 * cycle but it can be reused regardless of period
> 		 */
> 		duty_ticks =3D airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> 		duty_ticks_bucket =3D airoha_pwm_get_duty_ticks_from_ns(bucket_period_n=
s,
> 								      bucket_duty_ns);
> 		if (duty_ticks =3D=3D AIROHA_PWM_DUTY_FULL &&
> 		    duty_ticks_bucket =3D=3D AIROHA_PWM_DUTY_FULL)
> 			return i;
>=20
> 		/*
> 		 * With an unused bucket available, skip searching for
> 		 * a bucket to recycle (closer to the requested period/duty)
> 		 */
> 		if (unused !=3D -ENOENT)
> 			continue;
>=20
> 		/* Ignore bucket with invalid configs */
> 		if (bucket_period_ns > period_ns ||
> 		    bucket_duty_ns > duty_ns)
> 			continue;
>=20
> 		/*
> 		 * Search for a bucket closer to the requested period/duty
> 		 * following this logic:
> 		 *  1. Calculate the bucket period diff from the requested period
> 		 *  2. Calculate the duty period diff from the requested duty
> 		 *  3. Sum the 2 diff
> 		 *  4. Search for the bucket that have the minor diff across all
> 		 *     buckets.
> 		 */
> 		period_diff =3D period_ns - bucket_period_ns;
> 		duty_diff =3D duty_ns - bucket_duty_ns;
> 		bucket_diff =3D period_diff + duty_diff;
>=20
> 		/* Save the best found bucket as we test each one */
> 		if (bucket_diff < best_bucket_diff) {
> 			best_bucket_diff =3D bucket_diff;
> 			best =3D i;
> 		}
> 	}

This is the wrong metric. If the request has period =3D 1000 and
duty_cycle =3D 500 the possibility

	period =3D 999
	duty_cycle =3D 1

is considered preferable to

	period =3D 998
	duty_cycle =3D 500

(strange as this might seem). But the condition I used can indeed be
simplified to

	if (bucket_period_ns > pc->buckets[best].period_ns ||
	    (bucket_period_ns =3D=3D pc->buckets[best].period_ns &&
	     bucket_duty_ns > pc->buckets[best].duty_ns)
		best =3D i;

as we already know that bucket_period_ns <=3D period_ns and
bucket_duty_ns <=3D duty_ns.

> > > +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> > > +					u64 duty_ns, u64 period_ns,
> > > +					unsigned int hwpwm)
> > > +{
> > > +	int bucket;
> > > +
> > > +	/*
> > > +	 * Search for a bucket that already satisfy duty and period
> > > +	 * or an unused one.
> > > +	 * If not found, -ENOENT is returned.
> > > +	 */
> > > +	bucket =3D airoha_pwm_get_generator(pc, duty_ns, period_ns);
> > > +	if (bucket < 0)
> > > +		return bucket;
> > > +
> > > +	airoha_pwm_release_bucket_config(pc, hwpwm);
> > > +	pc->buckets[bucket].used |=3D BIT_ULL(hwpwm);
> > > +	pc->buckets[bucket].period_ns =3D period_ns;
> > > +	pc->buckets[bucket].duty_ns =3D duty_ns;
> >=20
> > pc->buckets[bucket].period_ns and pc->buckets[bucket].duty_ns should
> > only get assigned if pc->buckets[bucket].used =3D=3D 0.
> >=20
>=20
> Yesp micro optimization but I changed the logic.

No, that's not a micro optimisation. If you reuse a bucket you're not
supposed to change the configuration of another output.

> > > +	/*
> > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > +	 * share a generator.
> > > +	 */
> > > +	period_ns =3D rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> >=20
> > Do the same for duty_ns?
> >=20
>=20
> Duty is in % so we really can't round it. Am I wrong?

Well, in airoha_pwm_config you do:

	if (duty_ns =3D=3D bucket_duty_ns &&
	    period_ns =3D=3D bucket_period_ns)
		return i;

so better make sure that duty_ns is a value that can be realized.

Best regards
Uwe

--47x3mymq5bybwzyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhCi7IACgkQj4D7WH0S
/k5Z/gf/Vl6aH6I+I0tEdglVqS51yoxx1HkTeNyMM3+Y3FUWG+MzIqZ4jbVg5mEu
N4ZwMI9/wPN8H8bsH0//E90wOgutQEvG0/t8tp2PuxF0g8yzq6EQe5duazV9korB
YBMveHFExt9qIKUgK5OX+ftHe9cvDSSrMz3IQ3+87hPodMAbt4SUv194vOpw91Cg
mIMt6eJQvh3YKorcED3NxNA5Unhep20+SfBmG24+/dt5eKa+DEVovBnvZQrU6QTK
4uqonezSpj0IwJta8WmzAOglar/+ohAB0AdCJu/yZNCXE09WXEjh+lygf15Sz7ZS
c5d680ZshqFkZNWK+qSzg9fhSC6mmg==
=HAGH
-----END PGP SIGNATURE-----

--47x3mymq5bybwzyh--

