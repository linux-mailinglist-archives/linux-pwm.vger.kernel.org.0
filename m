Return-Path: <linux-pwm+bounces-2946-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4E9438CC
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 00:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E54E1F22444
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44B16D4D0;
	Wed, 31 Jul 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eYA29Yfa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0E16C875
	for <linux-pwm@vger.kernel.org>; Wed, 31 Jul 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464677; cv=none; b=FwO69A3dPo1OtoNyHGk7jsZKHQNuzACTJa2kQf99F+LCMkeUp5lsqglcM70skz+nYx1vf6sKFZe5P34E3fx2X5BahU9IEO8+Q3zDwDnXEcAsAHsiFlajnT/Qo6E9+gHzEbmiUfpx5V2QXEslUBWf5Ytjnq8oBqawlQgzwpNH+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464677; c=relaxed/simple;
	bh=CXSSbh0YIaW34RcUbHuRknjZCmUN+XojVPuNYh/lCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1R1lZrcK5eYoLMD/BADQmQYkxFTIY4A68LTCTeLUVvq6IdlbeUx/qa7lKY7tWPxXmEdSSLgxfKdvJ9WDWRXG/CM878u6NoHt2/AG0oUjwqS5ia9/Gomu/zoIbuFJYUG4ETnApfKoiQbCla6Z8n+yRMmHamRC0x9b9A9dH3PDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eYA29Yfa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso41591005e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 31 Jul 2024 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722464673; x=1723069473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQlMiv99SKoMmbKZZ1ltrZHqFERyiZWEJtmRLsLyF1M=;
        b=eYA29YfawiVvgC9IF/4Vpj49Icm9i6GzQaOfAO/Cz4UORKBdTkQ1L7kXy6fNFV4bNP
         gpJrG2dSaPkYV+Vxc6gDnU8K16nT7PLIdsuGoKPSseCJy+Mxbuha0Zrdj3vbzg/JHFz8
         VGunvKk2J53TzsLc+tR+9aPTtB6i2Z2d09Kq4q4nL2TMNLD+vOZyMuKjsnofsDrwQ3Wz
         TESuMLZsB9k1b8bP/29enZLqAq7D3SiQitNtn9205qYSotVl5do1vDD003S5F8byuoAZ
         aPTJfhuOI5uX71VfFq3QoQzKqxJfKqjPU4eTdp/XiSfkF0JAdY52WR3VCUuPQQgjbIbl
         daLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464673; x=1723069473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQlMiv99SKoMmbKZZ1ltrZHqFERyiZWEJtmRLsLyF1M=;
        b=EdXs3/n8385Rif6jVo9LsbyJkXP2VPBpa/JmrA6ZykE2R4AvVUkDEgFQCBwMaEhZgS
         clfktRqKRv1+rIlzmnhr/wuXOsAQhFXmDT6ex0xYIQiLP3EfVJOmt8wfVm4quoCzLXC5
         W57+SLlvuL/2IXxmPEC9tNXjgSekYKJZYqkhqE0Rnn9nIDHf12Lcww/9/GJiBsauKXFE
         I45f171Rb6E9MzfsnUYWRFGS8nW4BGHTUyvvbkju/81zQjUDCrSEZABe9pcFOsPe9L+y
         3/xEZeXVemE61ePTAL8NLUSHM96GJs70dhArahFxbgV/ja8R083DDDM6k5RyxrqAPD//
         KSCA==
X-Forwarded-Encrypted: i=1; AJvYcCVhgO30XM3TxWPXjOW7+q58getWoEzNdvaUHvdm5sLBJkb4AnggLITkHY38qNkxzbYZJcR7+c8onU9Vk+5ERsbFcLvmV4Wezln5
X-Gm-Message-State: AOJu0YxwKpsdAYA89k7Zwnf9vfIIhpnaNQs1BbZyiOj1Y0UmhyAqQSPg
	VFDyzuvvqApmMthfGlSnJh5BgoGV1hPHgANB1gIbcUmUK33KVKvCh1uz+SjHMu4=
X-Google-Smtp-Source: AGHT+IHEe+B6/mkybCqk++zmz0NLQ7zdxFHmKZ3rRujD/mbhmZ3LhHu3p8qwRPBYIM07qUFvFJMm5g==
X-Received: by 2002:a05:600c:4ece:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-428a9bdb04emr8101645e9.9.1722464672870;
        Wed, 31 Jul 2024 15:24:32 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:e24b:3670:5765:d3ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2475sm35825775e9.9.2024.07.31.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:24:32 -0700 (PDT)
Date: Thu, 1 Aug 2024 00:24:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <bokad5wa2vw5qwdrrqpkkyrxgmxco2ix76wdaxlqv6usi5rdck@46bp6ywqteo2>
References: <20240515112034.298116-1-dima.fedrau@gmail.com>
 <20240515112034.298116-3-dima.fedrau@gmail.com>
 <aczpsiqyh4qsbvnqhqdnvkj2j3fihkltafop5ajkxm57sehbx5@mn4vp7avpeac>
 <20240731084648.GA18584@debian>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r76f7ixvgggnra3n"
Content-Disposition: inline
In-Reply-To: <20240731084648.GA18584@debian>


--r76f7ixvgggnra3n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dimitri,

On Wed, Jul 31, 2024 at 10:46:48AM +0200, Dimitri Fedrau wrote:
> Am Mon, Jul 29, 2024 at 11:28:56PM +0200 schrieb Uwe Kleine-K=F6nig:
> > > +static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u=
8 *reg,
> > > +				u16 *val, bool *ctrl, int len)
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
> > > +	}
> > > +
> > > +	t[len - 1].cs_change =3D 0;
> > > +
> > > +	ret =3D spi_sync_transfer(spi, &t[0], len);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (read) {
> > > +		for (i =3D 0; i < len - 1; i++) {
> > > +			reg_i =3D i * MC33XS2410_WORD_LEN;
> > > +			val[i] =3D FIELD_GET(MC33XS2410_RD_DATA_MASK,
> > > +					   get_unaligned_be16(&rx[reg_i]));
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> >=20
> > Huh, this is complicated. Isn't that covered by regmap somehow?
>=20
> AFAIK it isn't supported. The main reason why regmap-spi doesn't work for
> this device is that the device needs a CS change after transmitting 16
> bits. This is not covered by regmap-spi. So I would end up implementing
> reg_read, regmap_write should be fine in regmap-spi. Besides that if I
> want to come as close as possible to an atomic configuration, which is not
> possible, I would have to implement some bulk read/write operations and
> end up with a similar implementation. I would stick to the current
> implementation if you agree.

ack.

> > > +static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 du=
ty_cycle)
> > > +{
> > > +	if (!period)
> > > +		return 0;
> > > +
> > > +	duty_cycle *=3D 256;
> >=20
> > This might overflow.
> >=20
>=20
> How ? Max period and duty_cycle is checked by the caller and can be
> maximum 2000000000, 2000000000 * 256 =3D 512000000000, fits in u64. Did I
> miss anything ?

I didn't notice the check in the caller. Please add a respective comment
for the next reader who might miss that.

> > > +	duty_cycle =3D DIV_ROUND_CLOSEST_ULL(duty_cycle, period);
> >=20
> > round-closest is most probably wrong. Please test your driver with
> > PWM_DEBUG enabled and increasing and decreasing series of duty_cycle and
> > period.
>=20
> Yes, I should probably round it down. But I tested with PWM_DEBUG enabled
> and it gave me the best results so far. There are still few cases where
> there are complaints. I try to fix it.

I don't have the hardware so I cannot test myself. Please make sure that
there are no more complaints, at least none you are aware of. PWM_DEBUG
should be happy if you pick a hardware setting where period is maximal
but not bigger than requested and then for that given period duty_cycle
is maximal but not bigger than requested. So typically use round-down
division in .apply(). In .get_state() you should return a pwm_state that
makes .apply() write the exact same state as found when .get_state() was
called. So typically you have to use round-up there.
=20
> > > +	state->polarity =3D (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwp=
wm)) ?
> > > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > > +
> > > +	state->enabled =3D !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > [...]
> > > +static int mc33xs2410_probe(struct spi_device *spi)
> > > +{
> > > [...]
> > > +	/* Disable watchdog */
> > > +	ret =3D mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
> >=20
> > Wouldn't the watchdog functionality better be handled by a dedicated
> > watchdog driver? Disabling it here unconditionally looks wrong.
>=20
> Yes, would be better. I planned this after this patchset is accepted.
> Without disabling the watchdog, the device is not able to operate. So I
> would stick to it for now and come up with a patch later on.

How long is the default timeout? Don't you need to disable the watchdog
in the bootloader anyhow?

If you still think the watchdog should be disabled here, please add a
comment that it's conceptually wrong to do here, but needed until there
is a proper watchdog driver.

Should this better be a mfd driver then?

Best regards
Uwe

--r76f7ixvgggnra3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaquZgACgkQj4D7WH0S
/k6tEAf+InTFr4VRf+x21Q9Hn8F37H/X/QwTJcQkDU44YHHwidAZkEPPmOjiH/XC
TV2XeP+d8PiaEgDVxbKrQs/TC9a+gfioEt2j/kAQk92QNcL2DX+zPgOtjF/20+5Q
oOY6FOO2/4mUkz/sFWYAaOiYaytxc6GjRcCjIy61rP96Q0yz57js9dq/fnoG2mG2
tV13fQ/B7P1McJhmIuzt7Eas+ZGSQAnb7WjtAeXIpx7aXRD/2MOOWCh0gUWouH8M
3RNTN5zaiN6oeHm/u44wT3YlEt9h86rZpeYOU8MkMbSYWG4T8IGoQM3azVv3r9Eq
RGhrrnv+P8rB3Vg8O0AbnknulO1/Jg==
=0W2O
-----END PGP SIGNATURE-----

--r76f7ixvgggnra3n--

