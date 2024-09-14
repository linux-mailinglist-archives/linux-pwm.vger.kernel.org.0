Return-Path: <linux-pwm+bounces-3273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7F97905F
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79C5285B87
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCC1CF29E;
	Sat, 14 Sep 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULgm8xVQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310297A15A;
	Sat, 14 Sep 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312495; cv=none; b=g3NxKa4is+TQLdfg3LCQvASY0yKL9SPp8xfDBQKSeMJ4Y/36OfsakMd7+HeYoaryJbWVcwz9t1dIg8TX780a6R2YIgY2dw+Ya5Fl1jen+a5M/vLMFt26YGx8xewUuWhg2lf/A5NsK04YLjScjBsF4W7Pb6T/iKqhvyucJi42/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312495; c=relaxed/simple;
	bh=Tvs8rKtOh38JeCEA9GUNPgIxWa9v19muykiwt28151o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXWLzAaw7+0TEpBSnCCsJfBjYfPWz/vwg8r9wSWbolzEBqBANXSgcOxronKFFjXrAWZTW0vAhYqMrVIuvmnoTZVM3vMEsdxVTTOGRoKdFgovG2+GQUQaEaGg4KoC3weFxjQeVB+jrRimizPSOjCEIwly27waKCHdYbacOSdhSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULgm8xVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A7DC4CEC0;
	Sat, 14 Sep 2024 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726312494;
	bh=Tvs8rKtOh38JeCEA9GUNPgIxWa9v19muykiwt28151o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ULgm8xVQXj5v3Mzgyy/rNhqCGCFeGnR8Gmlo5yz3SPeNYrXoh8rD41xi17866hJI+
	 BIEpOg/FNrdFl2sjxpmzflePSqiQCmdgNgqr70lKCemFcj/5I7OOMRCuyw+2wyq0kl
	 B1ik8/OU5gEeLCwy9rPqzCRA9qmnwKABfhi4rryHGIs6G/fed7fMfw0H2N86wMwzE0
	 s/gL3oy+gbZqF9ZCQ7C3AV7MLkiEzdOotCkfdC83mUEYhdEquxXRZ8hI6Q786aHCp2
	 dDvDeZEtw9+r2PzdG+g0z3ua/GEImXDG8+Sf/vHkdCQOzKBhl19DAnsANAtAxGN+6s
	 qzSCtDjbRm9Nw==
Date: Sat, 14 Sep 2024 12:14:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, aardelean@baylibre.com
Subject: Re: [PATCH 8/8] iio:adc:ad7606: Add iio-backend support
Message-ID: <20240914121442.2ed849a0@jic23-huawei>
In-Reply-To: <c80170b9-a1ea-4e7a-ab9f-83236eac20f3@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
	<20240817164748.30091016@jic23-huawei>
	<c80170b9-a1ea-4e7a-ab9f-83236eac20f3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


...

> >>  =20
> >>   	ret =3D ad7606_read_samples(st);
> >> @@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio_=
dev,
> >>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >>   		*val =3D st->oversampling;
> >>   		return IIO_VAL_INT;
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
> >> +		/* If the PWM is swinging, return the real frequency, otherwise 0 *=
/ =20
> > So this only exists for the pwm case. In that case can we split the cha=
nnel definitions
> > into versions with an without this and register just the right one.
> >
> > A sampling frequency of 0 usually means no sampling, not that we can te=
ll what it
> > is.  If we can't tell don't provide the file. =20
>=20
> The file is provided only for the "backended" device=20
> (AD7606_BI_CHANNEL), BI being Backend Interface. This mode only works=20
> with PWM (and incidentally PWM is meant to be used only in conjuction=20
> with backend).
>=20
> When the PWM is not running because e.g sampling is not enabled, or PWM=20
> failed to start, I return 0. Shall I always return the configured value=20
> instead of the real one ?

Yes. Configured should be fine I think if there is no way to ask
'what will it be when I turn it on'.


> >> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> >> index aab8fefb84be..9a098cd77812 100644
> >> --- a/drivers/iio/adc/ad7606.h
> >> +++ b/drivers/iio/adc/ad7606.h
> >> @@ -34,6 +34,12 @@
> >>   		BIT(IIO_CHAN_INFO_SCALE),		\
> >>   		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> >>  =20
> >> +#define AD7606_BI_CHANNEL(num)				\
> >> +	AD760X_CHANNEL(num, 0,				\
> >> +		BIT(IIO_CHAN_INFO_SCALE),		\
> >> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> >> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> >> +
> >>   #define AD7616_CHANNEL(num)	\
> >>   	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCAL=
E),\
> >>   		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> >> @@ -61,6 +67,7 @@ enum ad7606_supported_device_ids {
> >>    * @os_req_reset	some devices require a reset to update oversampling
> >>    * @init_delay_ms	required delay in miliseconds for initialization
> >>    *			after a restart
> >> + * @has_backend		defines if a backend is available for the given chip=
 =20
> > That seems to me more of a case of does the driver support it.
> > Linux kernel code has no way of knowing if a backend hardware exists
> > or not.  Modify the comment to speak about if we know it works.
> >
> > Or is there something fundamental that stops the backend approach
> > working with some devices?
> >
> > Why does the driver need this flag? =20
>=20
> Potentially, I think any of those parts can have a backend and moreover,=
=20
> I don't see anything preventing any ADC to have a backend.
>=20
> I introduced the flag as a way to differentiate the "new" way of=20
> supporting parallel interface, i.e using backend, from the "old" way=20
> (using port I/O).
>=20
> There is a concurrency between the old implementation using port I/O and=
=20
> the new one using iio-backend, because they are both "platform", so the=20
> initial idea was that it would not make sense and be dangerous to look=20
> for a backend for the parts that have no existing (i'd rather say, like=20
> you pointed out,=C2=A0 supported) backend.
>=20
> Having a second thought at it, the dt bindings already permits only=20
> io-backend property to be populated for the parts that actually have a=20
> backend, hence one of these is superfluous, or maybe even both are and=20
> the user is responsible for setting the right value in the dts. Any advic=
e ?

Dt binding should be enough.  The worst that happens is the driver
tries to use an unsupported backend and that will fail I hope.

So I wouldn't have this driver try to stop it.

> >> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par=
.c
> >> index d83c0edc1e31..5c8a04556e25 100644
> >> --- a/drivers/iio/adc/ad7606_par.c
> >> +++ b/drivers/iio/adc/ad7606_par.c
> >> @@ -102,3 +195,6 @@ MODULE_AUTHOR("Michael Hennerich <michael.henneric=
h@analog.com>");
> >>   MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> >>   MODULE_LICENSE("GPL v2");
> >>   MODULE_IMPORT_NS(IIO_AD7606);
> >> +#ifdef CONFIG_IIO_BACKEND
> >> +MODULE_IMPORT_NS(IIO_BACKEND); =20
> > I'd not bother with config guards.  Importing a namespace we don't
> > use should be harmless. =20
> OK, will remove it. According to Nuno's feedback, I could also force the=
=20
> selection of CONFIG_IIO_BACKEND with the driver, which IMHO is not a bad=
=20
> idea, as it would allow to remove all those ifdefs.

Hmm. I guess the questions is whether that is a bloat anyone will worry abo=
ut
who is using the old way for this device.  I guess that's a problem for
Analog folk if their customers complain.  We can always relax this in future
so for now select IIO_BACKEND is fine by me.

Jonathan


