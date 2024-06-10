Return-Path: <linux-pwm+bounces-2397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34B901EB6
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 12:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EE0282287
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD68770E7;
	Mon, 10 Jun 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RgHq9TsP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1B757F5
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013709; cv=none; b=P+hXuPpSNsRoBt1nSQaZ4PIa35snlxaRl1NVnjpTSIH7Gf1WtBpSERvgAjOnnXPu7tFpW9lb6zhVpKhMqxWmdOsSHLbpjxLNR9Gq3EMqtRR/xW22g6N9USyAJAkRTWwVjUUJM8G4hDnWBheIWfk57wXeHzkCcJ1xI9UkWFlv+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013709; c=relaxed/simple;
	bh=siiWzuGE50Mi9KUkOoHiER8ElKesN8LN4DOmCBP/3nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RciFXIqb2lZvpjoQO8XoiSBW4X7BOTQv1dkNGQ2l8LMpdySU2Ohue4iONzZEbYozAEYPkBlGpwZ2UK88xTE2ONUMV6jc7bAk9s4pNUPeV5vVWGw97kxqehPZASC6yQqdiB4bWoI9igqezKbxbirvvAFsvs3gNI4AzH3C+AsOf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RgHq9TsP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so2883044a12.3
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718013703; x=1718618503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlO3qdFuRXqKhljshkW+FX9ohtZlehsVLztsRtWfBuY=;
        b=RgHq9TsPkQ8PgwHex746a02XotWaUsCrWcph8er92moZRhc4LPvCw7iZFXVY1khrtp
         J93z2ZbjuxbAgSVK3E3RR4cRwWKWVcXGYc1efp3xcynhO4BJutbgIrZ4FswzI7gtOW7K
         XJbzvInwFb+EbQU7BpfnbzkU0E4Ueb/jJ86GWJv0Kpp0r8lhXGdtxFdylX+cBqk70VOe
         yBAAfdyb+pzXYCsEYohH34vVxVMN0bz3MlpnxxCeY1ii4r1WoyqMyAWAPdSnA66q49S5
         KEcGSXro5gsvoJelBy2vUaaGPOyXutDX3zV5+F46IIbZttclIbqlXeXJJrj26nOVWUsE
         XkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013703; x=1718618503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlO3qdFuRXqKhljshkW+FX9ohtZlehsVLztsRtWfBuY=;
        b=xKak9MHlM3cgin3yEDiVc/wLUbOKDbeFu6p9qYZ0A/fvVM/zAsl6TlpOB1r/VB+vAU
         iCOD0MfS223xTXuoAS/sj+f/2PXS1hGeV4+zy5Xw3cBp91bJF08Stnh+4Ox8WRh3oOud
         oBzSz4hvCJaS171MV6N3HIX1//md6iKO3g8PJH0//icYKutkjYneMmhYzQbV9vvakgw8
         M25vXBHEYjfDI6Th4vGVCfT7RJXKgPWvtmlQCy4T7ZDr+ajK38XNJ5kf9x+n5LIJw96g
         58FKq4fCaLcXJwr1JurtaRzE/JDhoT2f7sXGteNYG/h8TMbGtJbud/5DGvtu2yuI5J29
         U9Og==
X-Forwarded-Encrypted: i=1; AJvYcCVgcGnSomlw6ixLPNdLKRpfgpdpBkOd+N/ENGzF9EKS4dKXFFHKhXNBI2QpQMnRm02p1vY8Ux6Bx2JJ5mkZAqdsFQAi3r9VWjL2
X-Gm-Message-State: AOJu0YzRfzBDKbBd4TGVxHNUsV90BF8QG6pjMKBe2O8HvLB4PdDDmPxh
	/0JBNE1CaeKI/xoWpUVyS9vJY+uSxFrM1Z6Ji+iqUokIer5vY261juTXIb+BFKk8HcA3JA1cCHf
	N+Hw=
X-Google-Smtp-Source: AGHT+IEQn4kiyQuPDHL0x5+ZXCOUbPh3JXB6pe91ho0VaNjqUpRKHCI1IHTq+6t/iyZMr7K/3OywTw==
X-Received: by 2002:a50:871e:0:b0:57c:5fc8:c95e with SMTP id 4fb4d7f45d1cf-57c5fc8ca67mr5324103a12.23.1718013702754;
        Mon, 10 Jun 2024 03:01:42 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7156e6c2sm3570941a12.9.2024.06.10.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:01:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:01:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-pwm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 3/3] regulator: pwm-regulator: Manage boot-on with
 disabled PWM channels
Message-ID: <hf24mrplr76xtziztkqiscowkh2f3vmceuarecqcwnr6udggs6@uiof2rvvqq5v>
References: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
 <20240113224628.377993-4-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hr62idwwdqmqmca"
Content-Disposition: inline
In-Reply-To: <20240113224628.377993-4-martin.blumenstingl@googlemail.com>


--4hr62idwwdqmqmca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

while doing some pwm related cleanup, I stumbled over the part of the
pwm-regulator driver that was added here. This is either wrong or I
don't understand it.

On Sat, Jan 13, 2024 at 11:46:28PM +0100, Martin Blumenstingl wrote:
> Odroid-C1 uses a Monolithic Power Systems MP2161 controlled via PWM for
> the VDDEE voltage supply of the Meson8b SoC. Commit 6b9352f3f8a1 ("pwm:
> meson: modify and simplify calculation in meson_pwm_get_state") results
> in my Odroid-C1 crashing with memory corruption in many different places
> (seemingly at random). It turns out that this is due to a currently not
> supported corner case.
>=20
> The VDDEE regulator can generate between 860mV (duty cycle of ~91%) and
> 1140mV (duty cycle of 0%). We consider it to be enabled by the bootloader
> (which is why it has the regulator-boot-on flag in .dts) as well as
> being always-on (which is why it has the regulator-always-on flag in
> .dts) because the VDDEE voltage is generally required for the Meson8b
> SoC to work. The public S805 datasheet [0] states on page 17 (where "A5"
> refers to the Cortex-A5 CPU cores):
>   [...] So if EE domains is shut off, A5 memory is also shut off. That
>   does not matter. Before EE power domain is shut off, A5 should be shut
>   off at first.
>=20
> It turns out that at least some bootloader versions are keeping the PWM
> output disabled. This is not a problem due to the specific design of the
> regulator: when the PWM output is disabled the output pin is pulled LOW,
> effectively achieving a 0% duty cycle (which in return means that VDDEE
> voltage is at 1140mV).
>=20
> The problem comes when the pwm-regulator driver tries to initialize the
> PWM output. To do so it reads the current state from the hardware, which
> is:
>   period: 3666ns
>   duty cycle: 3333ns (=3D ~91%)
>   enabled: false
> Then those values are translated using the continuous voltage range to
> 860mV.

Maybe pwm_regulator_init_state() needs a similar logic as
pwm_regulator_get_voltage() and then this patch's changes can (and
should) go away?

> Later, when the regulator is being enabled (either by the regulator core
> due to the always-on flag or first consumer - in this case the lima
> driver for the Mali-450 GPU) the pwm-regulator driver tries to keep the
> voltage (at 860mV) and just enable the PWM output. This is when things
> start to go wrong as the typical voltage used for VDDEE is 1100mV.
>=20
> Commit 6b9352f3f8a1 ("pwm: meson: modify and simplify calculation in
> meson_pwm_get_state") triggers above condition as before that change
> period and duty cycle were both at 0. Since the change to the pwm-meson
> driver is considered correct the solution is to be found in the
> pwm-regulator driver. Update the duty cycle during driver probe if the
> regulator is flagged as boot-on so that a call to pwm_regulator_enable()
> (by the regulator core during initialization of a regulator flagged with
> boot-on) without any preceding call to pwm_regulator_set_voltage() does
> not change the output voltage.
>=20
> [0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126=
=2Epdf
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes from v1 -> v2:
> - This patch is new and the idea is to keep the voltage regulator
>   description in device-tree as-is (which means: support for 860mV to
>   1140mV). Instead we allow the pwm-regulator driver to preserve the
>   output voltage at boot when enabling the regulator.
> - note: Mark Brown said in v1 "I'd expect a change in the init_state()
>   function". That function is not updated as it's only relevant for
>   regulators with a voltage table - on Odroid-C1 we have a continuous
>   regulator though.
>=20
>=20
>  drivers/regulator/pwm-regulator.c | 33 +++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-re=
gulator.c
> index d27b9a7a30c9..60cfcd741c2a 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -323,6 +323,32 @@ static int pwm_regulator_init_continuous(struct plat=
form_device *pdev,
>  	return 0;
>  }
> =20
> +static int pwm_regulator_init_boot_on(struct platform_device *pdev,
> +				      struct pwm_regulator_data *drvdata,
> +				      const struct regulator_init_data *init_data)
> +{
> +	struct pwm_state pstate;
> +
> +	if (!init_data->constraints.boot_on || drvdata->enb_gpio)
> +		return 0;
> +
> +	pwm_get_state(drvdata->pwm, &pstate);
> +	if (pstate.enabled)
> +		return 0;
> +
> +	/*
> +	 * Update the duty cycle so the output does not change
> +	 * when the regulator core enables the regulator (and
> +	 * thus the PWM channel).
> +	 */
> +	if (pstate.polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pstate.duty_cycle =3D pstate.period;
> +	else
> +		pstate.duty_cycle =3D 0;

This looks wrong. If you assume that a disabled PWM emits the inactive
level (which is wrong in general, but the best we can assume, and this
is already done in pwm_regulator_get_voltage() since patch #2 in this
series), and you want to call pwm_apply_state() without changing that,
you need to do pstate.duty_cycle =3D 0 unconditionally.

Looking at arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts's &vddee I
guess you only tested the pstate.polarity =3D=3D PWM_POLARITY_NORMAL case,
so didn't suffer from the problem above?!

> +	return pwm_apply_might_sleep(drvdata->pwm, &pstate);

This doesn't necessarily has an effect on the PWM. The HW was disabled
before and here we have pstate.enabled =3D false, too. So the only
reliable effect is that pwm_get_state() returns duty_cycle as set above.
That might be worth to be noted in a comment.

Alternatively (and IMHO nicer) just keep the pwm_state around and don't
use the (mis) feature of the PWM core that pwm_get_state only returns
the last set state.

> +}

Best regards
Uwe

--4hr62idwwdqmqmca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZmzwAACgkQj4D7WH0S
/k6jqwf/YKPLdNCMffFnFQXY40SmaMzyxtujekyudUsSX8Pjr7R8h5oN5RZsPyEp
MUWEal/azCoDBcYFx2lDstfKaJNuEVQVPxkTuVcxvys/JsS0g6H523DSfLLsR/AT
5Uipi9rdYvpYvL56SL2CGZv0UpANVOSf8bjo1kiTkfpM1Ss/3Xm2ftHxFzlrg78j
uozemerDpVpuI5RPBTbToPxjTSlp5Vm1KBWTdIffJuHDItMPdr53jWa2qr/sTfNw
t1sZdVgD2285zBmh0wOdkp9HbR3uDpNnqNtd1PH+v3i4ErOT2soyM760/TQS7Ymd
lMcfOQXx3rC+3vleHaTwyVcQGKYpSQ==
=jaEU
-----END PGP SIGNATURE-----

--4hr62idwwdqmqmca--

