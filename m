Return-Path: <linux-pwm+bounces-7282-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7331B50F85
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 09:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937133B573F
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F830BB81;
	Wed, 10 Sep 2025 07:33:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A8307AE0
	for <linux-pwm@vger.kernel.org>; Wed, 10 Sep 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489637; cv=none; b=sivLBt29n67gBlpIfh4RSbQjZ88v9iKcqIGEF67X/gIRpTQ2pbDnrnY9CvsVpzNqsoMQFfeI5y8NmmWoHI+7J4bc594uZDVEqsiEClmSVx8PEsTv2ClpCLHZNIFUq68Oq8MpxS++O6+LB56zr/dQ4sgz45CdfEpYRnAZuHaJOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489637; c=relaxed/simple;
	bh=mh9v/gr8Q8swnB0yhey2ANHnfKU52XeVBg3bZ6V/DuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb8u0tgkdLpQpdy6SQc8Pzfl+161Z3oJxbrFX3CgWeS0GkhS9v1rszQL+Jrm+to5NPDgCUwfE+vJU9zcWTsEtnntlOmJlUqiRCAFmgpEWqC0dCpGNXcGvvF0VZewqqctkSl5PKHEjazhcfxuS565buMNeWTx49CYQfGCz6bAj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1uwFKn-0001RR-NW; Wed, 10 Sep 2025 09:33:41 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1uwFKn-000YM5-12;
	Wed, 10 Sep 2025 09:33:41 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1uwFKn-00GA2l-0e;
	Wed, 10 Sep 2025 09:33:41 +0200
Date: Wed, 10 Sep 2025 09:33:41 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aMEp1S4Yw1mxkjlH@pengutronix.de>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <n6rltuxqwybh2mwzz3hxi3tzix2c7q3mbovscobzzmkj6puo6w@gc3qnchjlagq>
 <7zae3uaz5wdk2ktmg44aqdnfjglklqujtktslvlye3ssd3xvbv@qwwjiip6kgfo>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqT2zYJdWIxJu/lU"
Content-Disposition: inline
In-Reply-To: <7zae3uaz5wdk2ktmg44aqdnfjglklqujtktslvlye3ssd3xvbv@qwwjiip6kgfo>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--bqT2zYJdWIxJu/lU
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Uwe

On Tue, Sep 09, 2025 at 03:49:22PM +0200, Uwe Kleine-K=F6nig wrote:
>On Fri, Aug 01, 2025 at 08:32:20AM +0200, Uwe Kleine-K=F6nig wrote:
>> On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
>> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backligh=
t/pwm_bl.c
>> > index 237d3d3f3bb1a..5924e0b9f01e7 100644
>> > --- a/drivers/video/backlight/pwm_bl.c
>> > +++ b/drivers/video/backlight/pwm_bl.c
>> > @@ -518,13 +518,6 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>> >  	if (!state.period && (data->pwm_period_ns > 0))
>> >  		state.period =3D data->pwm_period_ns;
>> >
>> > -	ret =3D pwm_apply_might_sleep(pb->pwm, &state);
>> > -	if (ret) {
>> > -		dev_err_probe(&pdev->dev, ret,
>> > -			      "failed to apply initial PWM state");
>> > -		goto err_alloc;
>> > -	}
>> > -
>> >  	memset(&props, 0, sizeof(struct backlight_properties));
>> >
>> >  	if (data->levels) {
>> > @@ -582,6 +575,15 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>> >  	pb->lth_brightness =3D data->lth_brightness * (div_u64(state.period,
>> >  				pb->scale));
>> >
>> > +	state.duty_cycle =3D compute_duty_cycle(pb, data->dft_brightness, &s=
tate);
>> > +
>> > +	ret =3D pwm_apply_might_sleep(pb->pwm, &state);
>> > +	if (ret) {
>> > +		dev_err_probe(&pdev->dev, ret,
>> > +			      "failed to apply initial PWM state");
>> > +		goto err_alloc;
>> > +	}
>> > +
>>
>> I wonder why the PWM is updated at all in .probe(). Wouldn't it be the
>> natural thing to keep the PWM configured as it was (in its reset default
>> state or how the bootloader set it up)?
>>
>> Orthogonal to your change, while looking at the driver I wondered about:
>>
>>         bl =3D backlight_device_register(dev_name(&pdev->dev), &pdev->de=
v, pb,
>>                                        &pwm_backlight_ops, &props);
>>         if (IS_ERR(bl)) {
>>                 ret =3D dev_err_probe(&pdev->dev, PTR_ERR(bl),
>>                                     "failed to register backlight\n");
>>                 goto err_alloc;
>>         }
>>
>>         if (data->dft_brightness > data->max_brightness) {
>>                 dev_warn(&pdev->dev,
>>                          "invalid default brightness level: %u, using %u=
\n",
>>                          data->dft_brightness, data->max_brightness);
>>                 data->dft_brightness =3D data->max_brightness;
>>         }
>>
>>         bl->props.brightness =3D data->dft_brightness;
>>         bl->props.power =3D pwm_backlight_initial_power_state(pb);
>>         backlight_update_status(bl);
>>
>> Shoudn't setting data->dft_brightness, bl->props.brightness and
>> bl->props.power better happen before backlight_device_register()? Also
>> calling backlight_update_status() after backlight_device_register()
>> seems wrong to me, I'd claim the backend driver shouldn't call that.
>
>Do you intend to work on this orthogonal feedback? If not, I'll put it
>on my todo list.

Oh, yes, the orthogonal feedback. Thanks for the reminder of this
actually intended patch not being ready. I will work on this first. If you
like, please take the opurtunity to fix the issue you found.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bqT2zYJdWIxJu/lU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmjBKc4ACgkQC+njFXoe
LGToNA//aIR5pPEwKcP/MWGus4W52lHrTsHAlXrmVHzWz0xX/sh3asgjiJ/iw29P
vsA/LhTwEKmmHu9CvpKcwTHUHNULIN0wbgh66RNZDiYXxZrxELdQCBEA0OFOPfQS
F8NnU7mBa7WsHG7IRi2XgBch9Ke/xfq5qXA5I62Z+Bw5X9UPn3dxSH66Rm8MLOyL
P0vCwcVogzW6rmMaXe/PqB2go8k7h/YEJmpMmB89IWFBFfvY+85FQJue8ZsuEFA2
Pyi2mCIdQbLN79M7LofhGd4C4jlZt+1EMXz+WI9f3+UU38ukYTAAlBU7DstzIU5M
0BvRTZlnThyJdlXsfQ5NgqvnpMsJKJZRxG1BqEHp8Ar8RdudadGB6y1C36GDfF+b
wJnGK/S2h8K9DMjmXgkyLBozPIqHs+hP2Jgx88rOJ0TezsqqkAMpU0dEsmd/1rJm
yc2lOTfuhwVicLHItpKqblm00n/ELZ89c1arIRRbsOdv106+2gIZ+olOZ1zY1SXO
NNTIXx0yogb99UaKEGBWCeSXKcDIQ0dj1F7C8uYLLTB6h0y0UZfFn6pDTGjZKokx
twsAN3sMpcs/2uwPy1hkDnpNI0m0wVaqGJ/jVJMElg2pG1DW2d6loDvQ43mzv+Pd
huJhp+APt6QGcIDadcCX1JWzT+leUlprdWLFkNwd5KYGq3w03hc=
=iZKH
-----END PGP SIGNATURE-----

--bqT2zYJdWIxJu/lU--

