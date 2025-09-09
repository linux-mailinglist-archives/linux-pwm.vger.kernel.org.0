Return-Path: <linux-pwm+bounces-7270-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201BB4AA97
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 12:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7620B189DC3A
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE302D0C63;
	Tue,  9 Sep 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvPYCV8r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F54246BB2;
	Tue,  9 Sep 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413611; cv=none; b=slIfc6mPHxZnbxHa+7MshJ7/RO6ohGRIDY3UvOROgQW8S3jJtoy98k6LdW18M5flsQptU9MarrP4069nd32SlpeP4g6/DSWoxMGS7NaBtJqxkGmCClg++HVAJIpuB67cH3ZNuIFqbiCaBNErHNZPRK7vftYmdqEMI1I6FM4KHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413611; c=relaxed/simple;
	bh=R8rJgzV0GkpvyeVk/7ra3rtAhpfBKmMB2QE4UL6QAwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUCilY7bhXRDUk2eFKFxfL+ioueuAylUBAk6GBde5E0zMy9398XbRVkYrDwm+nIxHWt8q7yJ9Kr1weED3YhqWj2cLMdltLlBvEnQ5ll/PvAOXss/IstA7cMIoiEKkHvY0FThb6xuRXBe2VHPvH+/7gQofCoEMDfUxrnXqsNr8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvPYCV8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DE5C4CEF4;
	Tue,  9 Sep 2025 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757413610;
	bh=R8rJgzV0GkpvyeVk/7ra3rtAhpfBKmMB2QE4UL6QAwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvPYCV8rqkQ4ndd3rt4Qz4bwz6NdSDJRtaw71f/axAsG5SK4HBqVrtXHoBoHQ+R0+
	 wfoWxJUih9JfGY8rTsOXQ+KSe/lt8X9O2hf82gV6DYvv/2WqFmfGeOFVoB9Cv1XryX
	 8S1Ijq+f6aO/jC8Dl4LC05KuAs0T4lz990FPCJJrCcncw88S5xAAEMzUrReniT2nQV
	 gzWSYjr1S+vNYbUv+g2aDoc3g/ll5f/StpCrrTrrCsU7HZ5k/ZmulqaY2jpES6nEO8
	 3hRyXnLI7pkBzIw5UtnErkehvwNSfXOc4y3jjpYnCXSmfjVhkkU3OAKGwsqHpm1O+u
	 bLbSbbeYH1bRA==
Date: Tue, 9 Sep 2025 12:26:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
Message-ID: <o32quqohph6xq73f65izjocjdhv2ri4dld4tcmmmtisa632ucq@lpz4ewja3xtd>
References: <20250708145053.798-1-ansuelsmth@gmail.com>
 <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
 <68bf2509.050a0220.702b3.c003@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dynu75es6kbw6gat"
Content-Disposition: inline
In-Reply-To: <68bf2509.050a0220.702b3.c003@mx.google.com>


--dynu75es6kbw6gat
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Mon, Sep 08, 2025 at 08:48:38PM +0200, Christian Marangi wrote:
> On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:
> > > +	duty_ticks =3D airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns=
);
> >=20
> > As duty_ticks depends on the selected period_ticks, I think the bucket
> > selection algorithm is still wrong.
> >=20
> > Consider a request to implement
> >=20
> > 	period_ns =3D 256 ms
> > 	duty_ns =3D 128 ms
> >=20
> > which at first correctly results in
> >=20
> > 	period_ticks =3D 64
> > 	duty_ticks =3D 127
> >=20
> > If however all buckets are used and we only find one with say 62 period
> > ticks we get period_ns =3D 248 and with that duty_ticks should better be
> > 131 and not 127.
>
> sorry for checking this only now and maybe we need to catch this again.

no need to be sorry here. Taking time for replies is fine for me.

> Maybe we are getting confused here but itsn't this already handled by
> the upper condition?
>=20
> 		/* Ignore bucket with invalid configs */
> 		if (bucket_period_ticks > period_ticks ||
> 		    bucket_duty_ticks > duty_ticks)
> 			continue;
>=20
> 		/*
> 		 * Search for a bucket closer to the requested period/duty
> 		 * that has the maximal possible period that isn't bigger
> 		 * than the requested period. For that period pick the maximal
> 		 * duty cycle that isn't bigger than the requested duty_cycle.
> 		 */
> 		if (bucket_period_ticks > best_period_ticks ||
> 		    (bucket_period_ticks =3D=3D best_period_ticks &&
> 		     bucket_duty_ticks > best_duty_ticks)) {
> 			best_period_ticks =3D bucket_period_ticks;
> 			best_duty_ticks =3D bucket_duty_ticks;
> 			best =3D i;
> 		}
>=20
> We first limit for a bucket that doesn't got over both period and duty
> and then we search for period and best duty. This should account for
> never exceeding a duty since both period and duty are precalculated for
> the current bucket and even if duty depends on period, again it's
> precalculated. Am I missing something?

Let me describe the issue in more detail:

The period length is configured in the AIROHA_PWM_WAVE_GEN_CYCLE
register in multiples of 4 ms. The duty length is configured in the
AIROHA_PWM_GPIO_FLASH_PRD_HIGH register in multiples of
$period_length/255.

So if you calcultate the number of multiples you need for duty_ns =3D 128
ms based on the assumption that period_ns =3D 256 ms the result becomes
wrong when you are forced to switch to period_ns =3D 248.

So to implement a request for period =3D 256 ms (64 ticks) and duty_cycle
=3D 128 ms (127.5 duty ticks) having the choice between the two buckets:

 a) period_ticks =3D 62; duty_ticks =3D 127
    (period =3D 248 ms, duty_cycle =3D 123.51372549019608 ms)
 b) period_ticks =3D 62; duty_ticks =3D 131
    (period =3D 248 ms, duty_cycle =3D 127.40392156862744 ms)

b) is the better one despite 127 duty_ticks would be an exact match for
period_ticks =3D 64. So the issue is that the "Ignore bucket with invalid
configs" kicks out b). That's wrong because

	bucket_duty_ticks > duty_ticks

doesn't imply

	bucket_duty > duty

=2E

Best regards
Uwe

--dynu75es6kbw6gat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjAAOUACgkQj4D7WH0S
/k7CSAgAki22lN1bHPIS6kecihLK/yOOxggSBjdqFNeyYEv8GZX56Pbz9JR9V9jM
VQhUuWGJA7rgwqYukKLoS9uW8pe+rCSbUusWO26NFviBYzpZlCzF3xfIH/TKt84t
CdooGAsqb9qwlptN5IRozedy/SNL83OWrvt0OJlSAlBjJhTR2mSMlJU75nQ/nPUl
x4Q+Ar2XlgVt1+ttsVSER6pM5H8yAaG1sXG/ZJa3na6/M4UXYTZlz4GGZ7a7OB4C
bl5enb88ZD7MRZ4zgmCUzLWzLEsc8efdrAuWSJktMotEMrLSoAEnT914F3Y+dO4S
gj32PnUAonZuLjQBEPg1xNJGIi7g7g==
=gvPL
-----END PGP SIGNATURE-----

--dynu75es6kbw6gat--

