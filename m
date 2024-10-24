Return-Path: <linux-pwm+bounces-3847-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D09AF497
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 23:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D321C215BC
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C521B0F32;
	Thu, 24 Oct 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sOktyzE6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764841AF0AA
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804763; cv=none; b=cNuH9s/jPapERdZAscpv1RgAIzuACtC2KZTUXgkt1Ymzp9myPFPRBIe3aEf+nplooqNk+QdfpTmy1GNTxizfK1WOXKbEgj0dDDu1VBALRLkHVuwNJtrBouyOUWMW3HWJ+RFT3doTS2HgvNU+Lh1blLsKwF11WRL7Lh08o3EQ+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804763; c=relaxed/simple;
	bh=LxNgM6OEG2refdE79AhxcGjPuTQUMHo9o67bdSKSZbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=angIuzLGfXgWEON8rJLxqE78QWXi+NNPyBfwPphneex74LKRxRyJ8/J/eD0zrjnO3ENAsEj1w8TVkmjpEHREcazNg10PFbwSQXXny/7YCwlMVPgFAi2dWGhsvdZGDtL9dlLcoTho8rkKbqSPdCKE2xoPnZRyDFoboWZb6tiLd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sOktyzE6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d47b38336so933552f8f.3
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729804759; x=1730409559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFvcoC488AfGA71diUr5gnpB0vBErIdVBK6D3oD+0Qg=;
        b=sOktyzE6MNNawguKOwqZDn5nyBYa7vtBbgEh7y9T8jGt2nD0QXEGeDq0FOn1ajHoa9
         jclGPCwrGu8dYy4nk9FZ62el0WaNpEzSgP7yAfcgCF/IV6cMMquLntrZH8uN9y22w6ck
         EcxqUiXbttCsGrpe1E2WH8GEqk6+e0Irm2j/oJJwWlHEfiT+yZdUFzoNe0oiLJsgNi7k
         5Ckxv6x6sTcbcKIP0ooR+nFQqHMPb7XtNCK7X5aTvMkgDq9EzP1JlbAcp4uXUV0Gn9kN
         m//qMlGluKc2tUbgJnETh0VTnYu3zl3j2hI9F9SdI/O1NoZJlyBC59PST2pZ1s4tQKT2
         NkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804759; x=1730409559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFvcoC488AfGA71diUr5gnpB0vBErIdVBK6D3oD+0Qg=;
        b=RHiKEIq6mW/DHxtzQDB93SNeFeAMXtWwk9xkRFOZ3vtEfLZBI0Y0vWD0ps3bldMX+z
         o/AQCu65mGi07qG5lO5DORvoDtgxaTDcGVCJdzQtOw2PMuOqlqSIMTMzrA0sPw7U9jil
         C6mowoTqu3x9PAdV2JQg2SJM9kGPD8AupXcND6MKDxnRb9HUK0Ukox/weSpV1ijqiSis
         CUqHNndhiH5pt5ZGLc9wGLIzHoWN6kw4dS3JK81PKscl6NjxBLM0Q0bdP5G0Jhc5Wimv
         p8atDrzZlG4cLgWOepMaRYm6MmVbLYmp3dEszPxkmjK0NkxTADhoiHn271RPdbCoe2Zd
         8jHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4GsicdJ+s82e/cqu2FgZadR/EktQ8Lry+NCZp/xFcaSfqi8b0gtMcDqE2br8x6NecOSQxjhbDX9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszQ9COCqENKlJSM2DXjDYG5h99dktBbLiqAFoCLvtkXdyZXhp
	m2OZHa3b/5QB+fUT/xCaqj2QS2WmRh459wpKoeK+UXQ9skiNNMvDnIMFnfsiLSk=
X-Google-Smtp-Source: AGHT+IF3Wed+9TpTr9IMYHVE4Wg8LEyIqO5P26hksneByyONbFAY+RZznN2gRhFwj781oZ2PZlP+6Q==
X-Received: by 2002:a5d:444f:0:b0:37d:4956:b0b4 with SMTP id ffacd0b85a97d-380458f42c6mr2398340f8f.59.1729804758627;
        Thu, 24 Oct 2024 14:19:18 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:b203:5494:7e5a:8c7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37e1asm12197642f8f.20.2024.10.24.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:19:18 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:19:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qeuo22de2j43gzbl"
Content-Disposition: inline
In-Reply-To: <20241023125221.GA197308@debian>


--qeuo22de2j43gzbl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

On Wed, Oct 23, 2024 at 02:52:21PM +0200, Dimitri Fedrau wrote:
> Am Tue, Oct 22, 2024 at 09:54:50AM +0200 schrieb Uwe Kleine-K=F6nig:
>=20
> [...]
> > > +
> > > +#define MC33XS2410_MIN_PERIOD		488282
> > > +#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
> > > +/* x in { 0 ... 3 } */
> > > +#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >=
> (2 * x))
> >=20
> > Nitpick: These register definition become easier to parse for a human if
> > you indent the RHS of register fields one tab further and add an empty
> > line between the definitions for different registers.
>=20
> Adding an empty line seems reasonable to me but the additional tab doesn't
> help me to improve readability.

OK, fine for me.

> > MC33XS2410_PWM_DC1 is only used once, I'd hard-code it into the
> > definition of MC33XS2410_PWM_DC.
>=20
> Ok. Should I do the same for MC33XS2410_PWM_FREQ1 and
> MC33XS2410_MAX_PERIOD_STEP0 ?

yepp.

> > The register fields [7:4] in MC33XS2410_PWM_CTRL3 are called PWM_ON4 ..
> > PWM_ON1. So your x in { 0 ... 3 } is wrong. (Luckily, having some x
> > range over { 0 ... 3 } and others orver { 1 ... 4 } is prone to error
> > and confusion.)
>=20
> Will fix it. Should I do the same for MC33XS2410_PWM_CTRL1_POL_INV ?

I guess so, otherwise you don't get consistent ranges.

> > For MC33XS2410_MAX_PERIOD_STEP maybe use a different variable name than
> > for the others. For the register definitions the range is over hwpwm
> > (which might be a good name there?), for MC33XS2410_MAX_PERIOD_STEP it's
> > about MC33XS2410_PWM_FREQ_STEP.
>=20
> What about MC33XS2410_PWM_MAX_PERIOD(x) ?

Consistency is trump.

> > > +#define MC33XS2410_MAX_TRANSFERS	5
> > > +#define MC33XS2410_WORD_LEN		2
> > > +
> > > +struct mc33xs2410_pwm {
> > > +	struct spi_device *spi;
> > > +};
> > > +
> > > +static inline struct mc33xs2410_pwm *mc33xs2410_from_chip(struct pwm=
_chip *chip)
> > > +{
> > > +	return pwmchip_get_drvdata(chip);
> > > +}
> > > +
> > > +static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u=
8 *reg,
> > > +				u16 *val, bool *ctrl, int len)
> >=20
> > Unless I missed something all ctrl[x] are always identical. If so
> > represent that by a single bool.
>=20
> Yes, they are identical. I added the crtl[x] to be able read from ctrl and
> diag registers. I will change it so it is represented by a single bool, if
> the feature is needed in the future I can still add it.

ack.

> > > +{
> > > +	struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] =3D { { 0 } };
> > > +	u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> > > +	u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> > > +	int i, ret, reg_i, val_i;
> > > +
> > > +	if (!len)
> > > +		return 0;
> > > +
> > > +	if (read)
> > > +		len++;
> > > +
> > > +	if (len > MC33XS2410_MAX_TRANSFERS)
> > > +		return -EINVAL;
> > > +
> > > +	for (i =3D 0; i < len; i++) {
> > > +		reg_i =3D i * MC33XS2410_WORD_LEN;
> > > +		val_i =3D reg_i + 1;
> > > +		if (read) {
> > > +			if (i < len - 1) {
> > > +				tx[reg_i] =3D reg[i];
> > > +				tx[val_i] =3D ctrl[i] ? MC33XS2410_RD_CTRL : 0;
> > > +				t[i].tx_buf =3D &tx[reg_i];
> > > +			}
> > > +
> > > +			if (i > 0)
> > > +				t[i].rx_buf =3D &rx[reg_i - MC33XS2410_WORD_LEN];
> > > +		} else {
> > > +			tx[reg_i] =3D reg[i] | MC33XS2410_WR;
> > > +			tx[val_i] =3D val[i];
> > > +			t[i].tx_buf =3D &tx[reg_i];
> > > +		}
> > > +
> > > +		t[i].len =3D MC33XS2410_WORD_LEN;
> > > +		t[i].cs_change =3D 1;
> >=20
> > Not sure if MC33XS2410_WORD_LEN really improves readability here.
>=20
> It is used throughout in the function and improves readability overall,
> maybe not here but for consistency I would stick to it.

Seems to be subjective.

> > Why is this done using $len transfers, wouldn't a single one do (and
> > maybe be more performant and not rely on a spi controller that supports
> > cs_change)?
>=20
> Without cs_change after every 16 bit, requests aren't processed by the
> device. Reading/writing from/to device fails. The SPI controller therefore
> must support cs_change. Single transfer is not possible because of the
> cs_change after every 16bit.

There is SPI_CS_WORD for this usecase.
=20
> > > +	/* polarity */
> > > +	mask =3D MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> > > +	val[2] =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> > > +		 (val[2] | mask) : (val[2] & ~mask);
> > > +
> > > +	/* enable output */
> > > +	mask =3D MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> > > +	val[3] =3D (state->enabled && rel_dc >=3D 0) ? (val[3] | mask) :
> > > +						   (val[3] & ~mask);
> > > +
> > > +	return mc33xs2410_write_regs(spi, reg, val, 4);
> > > +}
> > > +
> > > +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> > > +				    struct pwm_device *pwm,
> > > +				    struct pwm_state *state)
> > > +{
> > > [...]
> > > +	state->period =3D mc33xs2410_pwm_get_period(val[0]);
> > > +	state->polarity =3D (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwp=
wm)) ?
> > > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > > +	state->enabled =3D !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> > > +	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);
> >=20
> > No need to set state->duty_cycle =3D 0 if state->enabled is false. This=
 is
> > another function I suggest to unroll as it hides more than it abstracts.
>=20
> Function can be unrolled, but the check for state->enabled is needed. The
> device is unable to generate a 0% duty cycle, so it is turned off to
> generate a 0% duty cylce.

What breaks if you drop the check for state->enabled?
=20
> > > [...]
> > > +static int mc33xs2410_probe(struct spi_device *spi)
> > > +{
> > > [...]
> > > +	/* Transition to normal mode */
> > > +	ret =3D mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> > > +				    MC33XS2410_GLB_CTRL_MODE,
> > > +				    MC33XS2410_GLB_CTRL_MODE_NORMAL);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret,
> > > +				     "Failed to transition to normal mode\n");
> >=20
> > What is the effect of this register write if the PWM was already setup
> > by the bootloader?
> >=20
>=20
> When its setup is done in the bootloader and the watchdog is disabled in
> the bootloader it shouldn't have any impact.

ok.

Best regards
Uwe

--qeuo22de2j43gzbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcaudEACgkQj4D7WH0S
/k412wgAhhuGRzfQOKAF0X4Z4/t1WK1gdfi8iWhKvKvP4hrx1ESX2QYqkAmfPa+2
iz/EPW5egD5uVccERgRiUpYsn++lueMwY7a+096LkSzirBCZeQnlH5VBfwJkd7Ko
l+on/AXmpCiSthFX8pqyv4h4wnBSz+ye4XeFi3tjpKiJxGZ2HmRLVJNDNzkAemKA
dObtrDQfPkWOK1lTpeuF1c8YIWOxBMBMIHajTZ+yv4feSwquQDO9FONeN/lQgRyy
7yhGv3ZOKv2ly34oa2K55+I9A43IP63QiFRWa5NY4bvUR8mPH4rvyuOWJEVH4tMG
HObe9Cenh515ReB0rNQ35Ij+vGO9RA==
=SOJB
-----END PGP SIGNATURE-----

--qeuo22de2j43gzbl--

