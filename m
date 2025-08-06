Return-Path: <linux-pwm+bounces-6972-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ECCB1C73B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF333BE280
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7C28C03C;
	Wed,  6 Aug 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk0w+Mq+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86E45038;
	Wed,  6 Aug 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488978; cv=none; b=sHKwfsrTmFRfjemzTQXDJ6YDyl6lkgLwsDDxijekSYtQsLLllNd5JcoMWctA76zHmOqgvbkoOKje2pmNotpO9iUdlPC50WfZtbnAJjld3u+hMs9N5rm/nYWIep69gjiRJ4W1oDY3vH1m9DIyzvBp7fIFaDgrpspnquWSfnCr3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488978; c=relaxed/simple;
	bh=Ld10HX6wcdjfxV5yipYWv01NFSUYgG22JBf72BAdDas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK1JBU8F0ck50GabG5hz4ggq3wEcjVCutTsTfhfYxLN/B2shy0qN8uA/Vaxb8EUx+nO0LTGJNdpAp9+r6ro888uWd4OA0P4Ff0JB2Oc80MXgrJKB3LOTcPIgU7gX31d6KouTkDIAWqRl8cMYljQH8nZ+lWfLrNdBlovJx6pGrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk0w+Mq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE5C4CEE7;
	Wed,  6 Aug 2025 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754488977;
	bh=Ld10HX6wcdjfxV5yipYWv01NFSUYgG22JBf72BAdDas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nk0w+Mq+QoCcYJy7kSTNbI/5ViGQHX3jC7m7Y899CwwtidK440N++gOQZJUH4PXnB
	 LIr91wt8hGhocNtVqVzuRKzuBwNKp0TcMb7QcfvzKSbNYvCJYO+QQC2D3MaXaRuDV+
	 O/OzGb0jOId5i7b8Qzr36wcy8bdzBHjdBI05Ov2Bg1+6/yPeLGZn6ivaa6fR46f35X
	 p2689VS7/YeiL46YGee6KZkoEnElNCIz/BEgkdhoSSWGcP32BIkFyordMa/RIjWbEM
	 LhN+xnuxLOkao2PobEYAn1N5lA6M/Nm7vsqxymbf40qHNDpk4sgAt4yWTiz+7pTskC
	 oNUlY3nLrU3Xg==
Date: Wed, 6 Aug 2025 16:02:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <praujgmc3c63j6brecp5kwn7tbdd7rcxmrxn67kxhxcr7rpyhw@pfbsgycx4aop>
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
 <20250722-mdb-max7360-support-v12-4-3747721a8d02@bootlin.com>
 <2msg7e7q42ocjewv35rytdtxwrfqrndpm2y5ustqeaeodencsd@nfdufgtevxte>
 <DBVBZ48R7DNR.850O5X7MLMEF@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zq2dttqccfhukbbe"
Content-Disposition: inline
In-Reply-To: <DBVBZ48R7DNR.850O5X7MLMEF@bootlin.com>


--zq2dttqccfhukbbe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Wed, Aug 06, 2025 at 02:07:15PM +0200, Mathieu Dubois-Briand wrote:
> On Fri Aug 1, 2025 at 12:11 PM CEST, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 22, 2025 at 06:23:48PM +0200, Mathieu Dubois-Briand wrote:
> >> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> >> +					   struct pwm_device *pwm,
> >> +					   const struct pwm_waveform *wf,
> >> +					   void *_wfhw)
> >> +{
> >> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> >> +	u64 duty_steps;
> >> +
> >> +	/*
> >> +	 * Ignore user provided values for period_length_ns and duty_offset_=
ns:
> >> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset =
of 0.
> >> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/=
256
> >> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
> >> +	 */
> >> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
> >> +		duty_steps =3D MAX7360_PWM_MAX;
> >> +	} else {
> >> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX736=
0_PWM_PERIOD_NS;
> >> +		if (duty_steps =3D=3D MAX7360_PWM_MAX)
> >> +			duty_steps =3D MAX7360_PWM_MAX - 1;
> >> +	}
> >> +
> >> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX, duty_steps);
> >> +	wfhw->enabled =3D !!wf->period_length_ns;
> >> +
> >> +	return 0;
> >
> > The unconditional return 0 is wrong and testing with PWM_DEBUG enabled
> > should tell you that.
> >
>=20
> When you say should, does that mean the current version of PWM core will
> tell me that with PWM_DEBUG enabled, or does that mean we should modify
> the code so it does show a warning? As I did not see any warning when
> specifying a wf->period_length_ns > MAX7360_PWM_PERIOD_NS, even with
> PWM_DEBUG enabled.
>=20
> On the other hand, if I specify a wf->period_length_ns value below
> MAX7360_PWM_PERIOD_NS, I indeed get an error:
> pwm pwmchip0: Wrong rounding: requested 1000000/1000000 [+0], result 1000=
000/2000000 [+0]

Yes, that's how I expect it.

> > I think the right thing to do here is:
> >
> > 	if (wf->period_length_ns > MAX7360_PWM_PERIOD_NS)
> > 		return 1;
> > 	else
> > 		return 0;
>=20
> I can definitely do that, but now I'm a bit confused by the meaning of
> this return value: is it 0 on success, 1 if some rounding was made,
> -errno on error? So I believe I should only return 0 if
> wf->period_length_ns =3D=3D MAX7360_PWM_PERIOD_NS, no?
>=20
> Or reading this comment on pwm_round_waveform_might_sleep(), maybe we
> only have to return 1 if some value is rounded UP. So I believe the test
> should be (wf->period_length_ns < MAX7360_PWM_PERIOD_NS).

Right,

	if (wf->period_length_ns < MAX7360_PWM_PERIOD_NS)
		return 1;
	else
		return 0;

So 0 =3D request could be matched by only rounding down, 1 =3D request could
be matched but rounding up was needed, negative value =3D error.

> >  * Returns: 0 on success, 1 if at least one value had to be rounded up =
or a
> >  * negative errno.
>=20
> This is kinda confirmed by this other comment, in the code checking the
> above returned value in __pwm_apply(), even its just typical examples:

pwm_apply() has different rules. (.apply() fails when .period is too
small. This has the downside that finding a valid period is hard. For
that reason the waveform callbacks round up and signal that by returning
1.)

Best regards
Uwe

--zq2dttqccfhukbbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiTYIQACgkQj4D7WH0S
/k727wf8Cn26RaEXwkMI8JYfUk9FVhUwgJHCUzDgN2ENtdhCyWse7bHI3dIHY0w1
/c4hyw9YGVbZVv3jKebuHDdbRA8z7XMIYc6ZpqwGiOhzwUTXh91zZBzgcqKrt0yq
xIHJsLT/8YxFMb8g5cGnoX145K22M9ciuwCbaHCXj8NB7plu7zsYvbkJxxRErxAC
F0AihAj6BDXOSFUKy8ZsPDo5joj3PTxwpff+oNXRHokuPnmdKlkb0nB0mWKVDwkC
jKU9+qRLp1uda+EtDEydpASkY5tbuO4JMSTcSxcaxwWS8YY0+i/dJYBxRaK1vZ/u
02o36rGywRxJMVpXb+KOVrz/fr+OnA==
=4kNb
-----END PGP SIGNATURE-----

--zq2dttqccfhukbbe--

