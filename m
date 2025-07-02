Return-Path: <linux-pwm+bounces-6684-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3ECAF0B15
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 08:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B7D17D6AC
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44491EFF93;
	Wed,  2 Jul 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovsAoToY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45E1DF96F;
	Wed,  2 Jul 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436068; cv=none; b=OjZXu/1KqsWyy2L5mYQzUafUMreDZ4l6PWr4UHTucTnE8oPoaYnlEDoaJ6NNy3bDuDyfTwef1B0YyaaDOlHTpn6wM/aWASDM0KyKO79WZi3xv4Djqla0d+KNyqvp8CiENmnUzc7toBGMrxrjpMeGBmPyl1OCzlHatyh5ZkrPIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436068; c=relaxed/simple;
	bh=uiChSvZj4suPEgBnlqfn38z0ZrpKB48CFH9gUHqFA9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgcgwqU6vgk8iNvIMYyJjcZDDS60D9fd+gQ4xlyejTzErPnH8FDG09o7/I5E+gtYJjC9NBwd1G98+9uoWP1Pi4QYfbulAMCXg651lTibBKQZHw2O4YF3VF0MVed3KiN7kbbREMWxsfGJjub09crmTwUV1fvrSR0Yl+4B/WkhwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovsAoToY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB46FC4CEEE;
	Wed,  2 Jul 2025 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751436068;
	bh=uiChSvZj4suPEgBnlqfn38z0ZrpKB48CFH9gUHqFA9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovsAoToYxtNoitFll0qxh4FcNat2AtZHg5/hEee2H5KzClsgV1iFHvomVrJ5SEB+5
	 UF0WDWi9DQIlCNvWpuNsBIny4kK5vKBCwc9vgYKMOLjPNfKyXgPja3svXpIl9lvhKP
	 xvRAIt6WznV/Gpy1oikITJLrGMmT4TqdVHKKVRUkpqn8XDxAYurDtmCu/14qKH7VNa
	 jOuZ0qk4mZm6mOaAOEfy0ON3sp0Q3s6JlMuYnHtFfk5Cyy8aOqQb2tXbc3jBpS6gXd
	 WIQVeXVA88BEaMi8AI/a7iag6KPBcUtzbXsbxkNixl9+swVZV29QOxxK9d4DQFQAxn
	 rralP+/VQ7pkg==
Date: Wed, 2 Jul 2025 08:01:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
Message-ID: <wntjec4p7nepuauucwqwgwcresphjikln7cqchep3vjocpuo6u@6hjpkwcbvx7d>
References: <20250630114504.8308-1-ansuelsmth@gmail.com>
 <bwtk2nac2eo2jgf2lousguw7o34tzhz7mesdo3jfaf4gc3pri6@tff3h4f4274u>
 <686434fb.050a0220.efc3e.909b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hra54f6mnib5eiut"
Content-Disposition: inline
In-Reply-To: <686434fb.050a0220.efc3e.909b@mx.google.com>


--hra54f6mnib5eiut
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

On Tue, Jul 01, 2025 at 09:20:24PM +0200, Christian Marangi wrote:
> On Tue, Jul 01, 2025 at 09:40:03AM +0200, Uwe Kleine-K=F6nig wrote:
> > > +	shift =3D AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > > +
> > > +	/* Configure frequency divisor */
> > > +	mask =3D AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> > > +	val =3D FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_ticks) << shif=
t;
> > > +	ret =3D regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VAL=
UE(offset),
> > > +				 mask, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	offset =3D bucket;
> > > +	shift =3D do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> > > +	shift =3D AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > > +
> > > +	/* Configure duty cycle */
> > > +	mask =3D AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> > > +	val =3D FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << s=
hift;
> > > +	ret =3D regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PR=
D_SET(offset),
> > > +				 mask, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mask =3D AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> > > +	val =3D FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> > > +			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
> > > +	return regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD=
_SET(offset),
> > > +				  mask, val);
> >=20
> > Strange hardware, why do you have to configure both the high and the low
> > relative duty? What happens if AIROHA_PWM_GPIO_FLASH_PRD_LOW +
> > AIROHA_PWM_GPIO_FLASH_PRD_HIGH !=3D AIROHA_PWM_DUTY_FULL?
>=20
> From documentation it gets rejected and configured bucket doesn't work.

ok.

> > > [...]
> > > +	/*
> > > +	 * Duty is divided in 255 segment, normalize it to check if we
> > > +	 * can share a generator.
> > > +	 */
> > > +	duty_ns =3D DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
> > > +				   AIROHA_PWM_DUTY_FULL);
> >=20
> > This looks bogus. This is just duty_ns =3D duty_ns, or what do I miss?
> > Also duty_ns is an u32 and AIROHA_PWM_DUTY_FULL an int, so there is no
> > need for a 64 bit division.
>=20
> duty_ns * 255 goes beyond max u32.

In that case duty_ns * AIROHA_PWM_DUTY_FULL overflows to a smaller
value. Just because the value then is used by DIV_U64_ROUND_UP doesn't
fix the overflow. You need (u64)duty_ns * AIROHA_PWM_DUTY_FULL then.

> 225000000000.
>=20
> Some revision ago it was asked to round also the duty_ns. And this is
> really to round_up duty in 255 segment.

Yes, and I identified this as the code that intends to do that. Please
double check this really works. I would claim you need:

	duty_ns =3D DIV_ROUND_UP(duty_ns, AIROHA_PWM_DUTY_FULL) * AIROHA_PWM_DUTY_=
FULL;

here because no matter if you round up or down, dividing
n * AIROHA_PWM_DUTY_FULL by AIROHA_PWM_DUTY_FULL yields n.

Best regards
Uwe

--hra54f6mnib5eiut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhkyx4ACgkQj4D7WH0S
/k6ylQgAoJB6fA64UueHzEZkMoZSOrwR5C7d2I24qhxKbrkbkiJdNqzO8HvRWlGs
sXTY04ZbJauj63r8WRXvV86biiTSYv+EV0qkT5mOOyLI9/9oiIOPuvtTFQPoryQc
xRF7q7csHZFryIqxO36q7vcGZB7Pw4LOwzAf/weUNsR1tKAHaQtE2gErbxGl7zZ8
tzAeqwsvsdcZthjaD95SGe+YnrSJ/uD79Vv8ks0e4tbcKKD+HIKN15topqrS9bfP
1UqsYZ6m2v5Pl9bnGM+CRr48reQJtIo7eNYKLyIVXkZydJVnjKaJMV2bWVnFrzWk
1Tkz3d/JFO2W3fZStA7u/neMOOotRw==
=hcqn
-----END PGP SIGNATURE-----

--hra54f6mnib5eiut--

