Return-Path: <linux-pwm+bounces-5326-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14217A7A5E6
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3481188C20E
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8924E4A1;
	Thu,  3 Apr 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niAfeKup"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41824C080;
	Thu,  3 Apr 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692509; cv=none; b=l9js1b+Zdkd7bBuq0eHvn6J+vIQfcqI5ghce/1pgQiwTayv8DPAA8Cy6T+DFs2Gu6dn59ZbJLaEzCqugRykg6wZmvA2x+mDXDERP5WQqAu9QwwnnR6UYRS4VyUMc7UAp4QLi1eFMmOU9oGSo+8YwbmX77oWYz9/PhAEMzwTq0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692509; c=relaxed/simple;
	bh=xGkor64d/mAWwGW2M/uJgbBXlgSRrmMMXmJy4NWr2FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgYx7LGgti+wQmqqNir3l26A+SPlbVZBKSFIT8uJNTjxHh6R1YqCQ1MOrIHllSWClcmPoOR0/qu3y+N+sZUalcJejZeOLNUaKIVX++8D+3IKjaogzfO92ExTvecQlFLf/QCvrI9fglrq/jx7WCObXzPKh9vyAXsRdOsFPIwcs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niAfeKup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAFFC4CEE3;
	Thu,  3 Apr 2025 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743692509;
	bh=xGkor64d/mAWwGW2M/uJgbBXlgSRrmMMXmJy4NWr2FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niAfeKupZCdW/v65YRBZPto/AOg0FKIEGUVfqHuk/V917Zzv6RSe5h9TeA1y+2GwB
	 y6jcV2yMl8jRWBUPnvCpdWetEOICZmbLZMplTkNmqajUmhLgbZ+wX1pscUly5hThcv
	 00r8ZArknZbaBkQXYhFtsbHpa5D8UxnJgj0Wy4bQURVI/mMK/CgRRKcVMbsYt4V97v
	 KVklRVaeWtWZpCuxX5EqvWpTR5he/cmVLQ6u41nGwGTLP7vooUvJo1ALxnwkgPVyuS
	 qdktePCFV81JXCdQ944gP3TIO2f8H19vr4TYcfaVUtFuEHNXqULkH7XatvX8/1Mfcq
	 WednCxmadBD0A==
Date: Thu, 3 Apr 2025 17:01:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RESEND PATCH v11] pwm: airoha: Add support for EN7581 SoC
Message-ID: <zwckkfd6mzzjxfpitojcmhokhjbtc4u3brf34pcu4phdlipf3z@uijstw7daze2>
References: <20250226002537.3752-1-ansuelsmth@gmail.com>
 <cdwttmqcvhetlf446gsaxsta76ojlqckxc253svho4xsm7qxhs@6otqm6yyuvfh>
 <67ee67f5.050a0220.38e02.5bc2@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="km3jrdcv4oe444nf"
Content-Disposition: inline
In-Reply-To: <67ee67f5.050a0220.38e02.5bc2@mx.google.com>


--km3jrdcv4oe444nf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH v11] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello,

On Thu, Apr 03, 2025 at 12:50:27PM +0200, Christian Marangi wrote:
> On Thu, Apr 03, 2025 at 11:58:48AM +0200, Uwe Kleine-K=F6nig wrote:
> > > +	if (hwpwm >=3D AIROHA_PWM_NUM_GPIO)
> > > +		offset -=3D AIROHA_PWM_NUM_GPIO;
> > > +
> > > +	/* One FLASH_MAP register handles 8 pins */
> > > +	*shift =3D do_div(offset, AIROHA_PWM_PINS_PER_FLASH_MAP);
> > > +	*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(*shift);
> > > +
> > > +	if (offset < AIROHA_PWM_NUM_GPIO)
> > > +		*addr =3D AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> > > +	else
> > > +		*addr =3D AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
> >=20
> > A single if would be a bit more straight forward. Something like:
> >=20
> > 	static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> > 							    unsigned int *addr, unsigned int *shift)
> > 	{
> > 		u64 offset =3D hwpwm;
> > =09
> > 		if (hwpwm >=3D AIROHA_PWM_NUM_GPIO) {
> > 			unsigned sipohwpwm =3D hwpwm - AIROHA_PWM_NUM_GPIO;
> >=20
> > 			*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(sipohwpwm % AIROHA_PW=
M_PINS_PER_FLASH_MAP)
> > 			*addr =3D AIROHA_PWM_REG_SIPO_FLASH_MAP(sipohwpwm);
> > 		} else {
> > 			*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm % AIROHA_PWM_PI=
NS_PER_FLASH_MAP)
> > 			*addr =3D AIROHA_PWM_REG_GPIO_FLASH_MAP(hwpwm);
> > 		}
> > 	}
> >=20
>=20
> I think you missed the do_div that do side effect on offset. Also that
> needs to be / AIROHA_PWM_PINS_PER_FLASH_MAP.

Ack. Luckily you got the idea anyhow. This double effect of do_div() is
easy to miss, so getting rid of them sounds sensible.

> > > +		if (duty_ns =3D=3D bucket->duty_ns &&
> > > +		    period_ns =3D=3D bucket->period_ns)
> > > +			return i;
> >=20
> > If period_ns =3D=3D 4010 and bucket->period_ns =3D=3D 4000 you're not
> > considering *bucket even though it has the right period setting.
> > (period_ns is the requested period and not the expected period actually
> > implemented by HW, right?)
> >=20
>=20
> Doesn't that requires a different generator? The value we store in the
> bucket is the requested period yes.

No it doesn't. If I understood right the possible periods are: 4ms, 8ms,
=2E.., so a request to do 4.01ms will be mapped to 4ms which allows to
share the generator.

> > > +				  AIROHA_PWM_GPIO_FLASH_EN << shift);
> > > +		return;
> > > +	}
> > > +
> > > +	regmap_update_bits(pc->regmap, addr,
> > > +			   AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
> > > +			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);
> >=20
> > Huh, I'd prefer:
> >=20
> > 	regmap_update_bits(pc->regmap, addr,
> > 			   AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8)
> > 			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8), index));
> >=20
> > (That probably doesn't work out of the box because of the
> > __builtin_constant_p check on mask, so you might need a local
> > alternative to FIELD_PREP without that check.)
>=20
> Honestly it's not worth to introduce custom FIELD_PREP for this. Yes the
> problem is that FIELD_PREP requires constant mask so hwpwm % 8 is
> problematic. An old implementation had stuff in define but resulted in
> very ugly and confusing define and macro. The shift and FIELD_PREP
> permits a much cleaner description in the define part at the cost of
> that additional << shift needed.
>=20
> Hope you can understand why I think it's better to keep it this way.

OK, I can live with that.

> > > +	bucket =3D airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> > > +					      hwpwm);
> > > +	if (bucket < 0)
> > > +		return -EBUSY;
> > > +
> > > +	/*
> > > +	 * For SIPO reinit is always needed to trigger the shift register c=
hip
> > > +	 * and apply the new flash configuration.
> >=20
> > I don't understand that sentence. What is the shift register chip? What
> > is a flash configuration?
> >=20
>=20
> The SoC can have attached a shift register chip to supports multiple LEDs.
> The handling of this chip and comunication is done internally to the SoC
> and it's exposed to register with these additional register.
>=20
> When such channel are used with an assumed shift register, to apply the
> new configuration in airoha_pwm_config_flash_map(), the shift register
> chip needs to be reinit to actually refresh the chip internal register
> with the new "flash configuration" (aka the values for
> AIROHA_PWM_GPIO_FLASH_SET_ID)
>=20
> Will add more comments to this to make it more clear.

Sounds good.

> > > +	state->enabled =3D FIELD_GET(AIROHA_PWM_GPIO_FLASH_EN, val >> shift=
);
> > > +	if (!state->enabled)
> > > +		return 0;
> > > +
> > > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > > +
> > > +	bucket =3D FIELD_GET(AIROHA_PWM_GPIO_FLASH_SET_ID, val >> shift);
> > > +	state->period =3D pc->buckets[bucket].period_ns;
> >=20
> > Does .period_ns hold the requested or the actual period? You should
> > return the latter.
>=20
> Problem is that putting .period_ns here cause error in the PWM_DEBUG
> validations. This is caused by the conversion error of the various / and
> * done to convert tick to ns. Also on applying the configuration we
> already do all the validation to make sure the request value is the
> expected one.

Then there is a bug somewhere. I wouldn't completely rule out it's in
the PWM_DEBUG logic, but my bet is on your driver then.
=20
> For the initial values, there is airoha_pwm_fill_bucket that read the
> current PWM values at boot and fill the buckets with the current values.
>=20
> This is the compromise I found to handle both pre-configured bucket and
> also handle the division errors in the ns - tick conversion.
>=20
> Hope this is acceptable, do you have hint on better handling this?

I'd wait for the next iteration of your patch and then take a deeper
look in the maths involved. It should be possible to make PWM_DEBUG
happy and still report the actual configuration.

Best regards
Uwe

--km3jrdcv4oe444nf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfuotgACgkQj4D7WH0S
/k4Wsgf/ckZc2RVC+cZTRSbPOpMS+evNOaG/4zAxD7Q3Nihq7+DtxuospwKQWuq9
78YgPs7+GBWH3VxMMVcNeNBnPgpM8Kz3MfA0EvFV0AyYvweqoHFd9JY4Bhi1m6nf
r8jelwl6BGOuxLunYexRnPsTSiLPK+QioTFX8LUc5k4LVDbBokiFGxMN5tv+ca9q
dpKglieomzZR1QVWYZXVQAuUcYuvZV5UVHndqv6JxtNNAX8LU32m60tsUB/nIh9b
7FIOvjrYwnAMoJNX0OpCt1GXdzEkpVtv4tGLLdREFzcyGxOO2IagywLly0emN4lw
5REbrUS8yJpqOLGqXHcgTyCONWWDVg==
=ILIJ
-----END PGP SIGNATURE-----

--km3jrdcv4oe444nf--

