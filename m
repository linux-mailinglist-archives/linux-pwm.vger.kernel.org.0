Return-Path: <linux-pwm+bounces-3568-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1B996DC7
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B0EB21759
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA619DF60;
	Wed,  9 Oct 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYegVRLP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA53190671;
	Wed,  9 Oct 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484183; cv=none; b=Vs7XXyIIf56ef/+3VJuvAzUcUmTJ89f1AnzIhWtMr3uvDvll8cYOPx4sDD1gfYBwojEZBBs9dP3rKurfx8tvRXw15urrRkZoM+5i2gpyndmGN6jWxv9LeW2kaT3c2JpX3vCCuLFdtlJUuRwkUKaLvlSS6z/ORxTu91uhuSa7k4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484183; c=relaxed/simple;
	bh=E5l7XLUph4CroFoG9mgsfyCmACzVRqqisf8fJBYUGFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/ckAwlgcWIVicQdK2RoGHgNvp9BqAee6VJlAP0pJtvyOkdT1n2LO9hU7mSjePdY1ELk3VSEe09aNf6aRoG991JfDn5YIwkiED44SzBae5NEbaycoDzc2SRTJJlG7DZHhoC+1iFrrqjCz3pUnxXu6C4D67EJoE5yu4NdX6OLV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYegVRLP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53997328633so9365706e87.3;
        Wed, 09 Oct 2024 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484176; x=1729088976; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x1exwFMCtjID6DoZpDSkqCzWTlshQQhxAhHFrjRH1NA=;
        b=DYegVRLPMOUWFNc5e9bJVPrdCZHicA2qVQ6OPwafLliK1XS4pYZfccjX4hNxXeHX9l
         HTFSmkuuooshHtxOMSwAfOFZ7/fbCis6EIoXZOejs5lS9f1JlDMagJfmI7ioEPAn2ja5
         7xZiTpbOS10SZEwDEDDgUEp7rkDZygnrZzqt5/hopHbncLGXFs57Rpi04dJvcxNagjgA
         uIhHTFSW3YYGI8+L2WW709AzRox3o8dq0IyF2wwCojYwFDK//6tDsmObEao2gppOCyH+
         eZ4ShYs1Ufm1oM9aIBQPO2RhHrcTBluWCsKQCHCVaD6u4ATT2yTYawN0iUCfXg/z6sdc
         wczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484176; x=1729088976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1exwFMCtjID6DoZpDSkqCzWTlshQQhxAhHFrjRH1NA=;
        b=fm0rG5BWTCEiZGfwiTMccheCUoNM2d/HxjWZ/lzkd0rAnLWR3yozKlMw0Oxb0yo0KU
         ARZXxdsYeWeatYIjCpOKSCpHR8NNBqLsce8l66Q+FrdDWT092s0yNoofcUsamX2xnRsD
         m/my/DmOKXSpDkseAAnwE0AX3cm0VC1UoUgpxX1iWrm5c4CoX8j96xduJXydUGiwUfgK
         0kgtfNyzDJC5aO/ewMXcJrhOzSclwCm3Ft0G5zzANZXfYdRG9QA3Hx742q+6MAbZXGDJ
         ++A8DYL94a4qKo02jIFgtQWJWehltqDRT+mSTphmvsggTyEe+V93CpVloJ3QxNQ7rKyu
         rnxA==
X-Forwarded-Encrypted: i=1; AJvYcCVG+FKKe3rCEgsgtsH4pP5kFK0A13PfbXrtBtIYAWcshXHiYimW/uEwHxOF2Tk6jFvG+XjKsVyB/0Ki@vger.kernel.org, AJvYcCVSWTciFWL0gf7GZS4SRvXcWTzuNUM0Ijn8RnCw7wQvsbsiGtEFVoALVEa/qNrdVoUb8dXYcTD0Ya8v@vger.kernel.org, AJvYcCX1//2YmP6NInH4R/e/OENZamXaH6Tmo/xI5DBTQyrH0Ie/cYnqZo+VagHiepwuCdu2UIZnK+fiEyqJgvMK@vger.kernel.org, AJvYcCXpuExWdzlRiZ20V4uoibLyYwHcbMDf4O27EVJF4HAQj5G6dcJa9Q5aDfnMI9Yqf21Z7BLLM9DWqk57VAc=@vger.kernel.org, AJvYcCXqMMNHJgWRRa6wxCI19POGLV7AjIHr2Ws2l84n7k/vG9DhaQJOq9ltHw2bkw/mbOZ8Ef9gxndy8hII@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIU7iF0H4yHRY148cjZu88wQszR5HPibz9pijG9Pf2NqwTk49
	96TJYPZNce8MvNo46g9VOGM1dyBDPbxITVgOWccyqhuk/Qwupewq
X-Google-Smtp-Source: AGHT+IHypRgzpda4UOn7tUpkG6oM5G0fDPn+ptPE33yjZYSablG58wP1fcey4fCgQzqtBNml3VEhew==
X-Received: by 2002:a05:6512:3a91:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-539c4967fd4mr2586186e87.52.1728484175915;
        Wed, 09 Oct 2024 07:29:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9963760779sm298304366b.204.2024.10.09.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:29:34 -0700 (PDT)
Message-ID: <5860310e0413038ac477b9e191c3d15029487628.camel@gmail.com>
Subject: Re: [PATCH v4 4/8] iio: adc: ad7606: Add PWM support for conversion
 trigger
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com,  dlechner@baylibre.com, jstephan@baylibre.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 09 Oct 2024 16:29:33 +0200
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-4-6971a8c0f1d5@baylibre.com>
References: 
	<20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	 <20241009-ad7606_add_iio_backend_support-v4-4-6971a8c0f1d5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> Until now, the conversion were triggered by setting high the GPIO
> connected to the convst pin. This commit gives the possibility to
> connect the convst pin to a PWM.
> Connecting a PWM allows to have a better control on the samplerate,
> but it must be handled with care, as it is completely decorrelated of
> the driver's busy pin handling.
> Hence it is not recommended to be used "as is" but must be exploited
> in conjunction with IIO backend, and for now only a mock functionality
> is enabled, i.e PWM never swings, but is used as a GPIO, i.e duty_cycle
> =3D=3D period equals high state, duty_cycle =3D=3D 0 equals low state.
>=20
> This mock functionality will be disabled after the IIO backend usecase
> is introduced.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Hi Guillaume,

Looks overall good, just some minor stuff

> =C2=A0drivers/iio/adc/ad7606.c | 143 ++++++++++++++++++++++++++++++++++++=
+++++++----
> =C2=A0drivers/iio/adc/ad7606.h |=C2=A0=C2=A0 2 +
> =C2=A02 files changed, 135 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 71362eafe838..5b276d087ec3 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -13,10 +13,12 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/property.h>
> +#include <linux/pwm.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/sysfs.h>
> +#include <linux/units.h>
> =C2=A0#include <linux/util_macros.h>
> =C2=A0
> =C2=A0#include <linux/iio/buffer.h>
> @@ -299,6 +301,82 @@ static int ad7606_reg_access(struct iio_dev *indio_d=
ev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad7606_pwm_set_high(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +	int ret;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;
> +

Maybe consider doing the check before calling the API (for the cases that n=
eed it)?
It seems at least that in a couple of cases you actually already know that =
the PWM
must be here (since you check for the gpio presence)...

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled =3D true;
> +	cnvst_pwm_state.duty_cycle =3D cnvst_pwm_state.period;
> +
> +	ret =3D pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +	/* sleep 2 =C2=B5S to let finish the current pulse */
> +	fsleep(2);
> +
> +	return ret;
> +}
> +
> +static int ad7606_pwm_set_low(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +	int ret;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;
> +

Same deal...

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled =3D true;
> +	cnvst_pwm_state.duty_cycle =3D 0;
> +
> +	ret =3D pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +	/* sleep 2 =C2=B5S to let finish the current pulse */
> +	fsleep(2);
> +
> +	return ret;
> +}
> +
> +static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return false;
> +

This one also seems to be redundant? ad7606_set_sampling_freq() should be o=
nly called
from a context where the PWM exists right?

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +
> +	return cnvst_pwm_state.duty_cycle !=3D cnvst_pwm_state.period &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cnvst_pwm_state.duty_cycle !=3D 0;
> +}
> +
> +static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned lo=
ng freq)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +	bool is_swinging =3D ad7606_pwm_is_swinging(st);
> +	bool is_high;
> +
> +	if (freq =3D=3D 0)
> +		return -EINVAL;
> +
> +	/* Retrieve the previous state. */
> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	is_high =3D cnvst_pwm_state.duty_cycle =3D=3D cnvst_pwm_state.period;
> +
> +	cnvst_pwm_state.period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +	cnvst_pwm_state.polarity =3D PWM_POLARITY_NORMAL;
> +	if (is_high)
> +		cnvst_pwm_state.duty_cycle =3D cnvst_pwm_state.period;
> +	else if (is_swinging)
> +		cnvst_pwm_state.duty_cycle =3D cnvst_pwm_state.period / 2;
> +	else
> +		cnvst_pwm_state.duty_cycle =3D 0;
> +
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
> =C2=A0static int ad7606_read_samples(struct ad7606_state *st)
> =C2=A0{
> =C2=A0	unsigned int num =3D st->chip_info->num_channels - 1;
> @@ -325,6 +403,7 @@ static irqreturn_t ad7606_trigger_handler(int irq, vo=
id *p)
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
> =C2=A0	/* The rising edge of the CONVST signal starts a new conversion. *=
/
> =C2=A0	gpiod_set_value(st->gpio_convst, 1);
> +	ad7606_pwm_set_high(st);
> =C2=A0
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> @@ -337,7 +416,13 @@ static int ad7606_scan_direct(struct iio_dev *indio_=
dev,
> unsigned int ch,
> =C2=A0	const struct iio_chan_spec *chan;
> =C2=A0	int ret;
> =C2=A0
> -	gpiod_set_value(st->gpio_convst, 1);
> +	if (st->gpio_convst) {
> +		gpiod_set_value(st->gpio_convst, 1);
> +	} else {
> +		ret =3D ad7606_pwm_set_high(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> =C2=A0	ret =3D wait_for_completion_timeout(&st->completion,
> =C2=A0					=C2=A0 msecs_to_jiffies(1000));
> =C2=A0	if (!ret) {
> @@ -363,6 +448,11 @@ static int ad7606_scan_direct(struct iio_dev *indio_=
dev,
> unsigned int ch,
> =C2=A0	}
> =C2=A0
> =C2=A0error_ret:
> +	if (!st->gpio_convst) {
> +		ret =3D ad7606_pwm_set_low(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> =C2=A0	gpiod_set_value(st->gpio_convst, 0);
> =C2=A0
> =C2=A0	return ret;
> @@ -662,8 +752,9 @@ static int ad7606_request_gpios(struct ad7606_state *=
st)
> =C2=A0{
> =C2=A0	struct device *dev =3D st->dev;
> =C2=A0
> -	st->gpio_convst =3D devm_gpiod_get(dev, "adi,conversion-start",
> -					 GPIOD_OUT_LOW);
> +	st->gpio_convst =3D devm_gpiod_get_optional(dev, "adi,conversion-start"=
,
> +						=C2=A0 GPIOD_OUT_LOW);
> +
> =C2=A0	if (IS_ERR(st->gpio_convst))
> =C2=A0		return PTR_ERR(st->gpio_convst);
> =C2=A0
> @@ -708,6 +799,7 @@ static irqreturn_t ad7606_interrupt(int irq, void *de=
v_id)
> =C2=A0
> =C2=A0	if (iio_buffer_enabled(indio_dev)) {
> =C2=A0		gpiod_set_value(st->gpio_convst, 0);
> +		ad7606_pwm_set_low(st);
> =C2=A0		iio_trigger_poll_nested(st->trig);
> =C2=A0	} else {
> =C2=A0		complete(&st->completion);
> @@ -732,6 +824,7 @@ static int ad7606_buffer_postenable(struct iio_dev *i=
ndio_dev)
> =C2=A0	struct ad7606_state *st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	gpiod_set_value(st->gpio_convst, 1);
> +	ad7606_pwm_set_high(st);

error handling?
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -741,6 +834,7 @@ static int ad7606_buffer_predisable(struct iio_dev *i=
ndio_dev)
> =C2=A0	struct ad7606_state *st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	gpiod_set_value(st->gpio_convst, 0);
> +	ad7606_pwm_set_low(st);
>=20

error handling?

> =C2=A0	return 0;
> =C2=A0}
> @@ -874,6 +968,11 @@ static int ad7606_chan_scales_setup(struct iio_dev *=
indio_dev)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static void ad7606_pwm_disable(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
> =C2=A0int ad7606_probe(struct device *dev, int irq, void __iomem *base_ad=
dress,
> =C2=A0		 const char *name, unsigned int id,
> =C2=A0		 const struct ad7606_bus_ops *bops)
> @@ -950,6 +1049,31 @@ int ad7606_probe(struct device *dev, int irq, void =
__iomem
> *base_address,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	/* If convst pin is not defined, setup PWM. */
> +	if (!st->gpio_convst) {
> +		st->cnvst_pwm =3D devm_pwm_get(dev, NULL);
> +		if (IS_ERR(st->cnvst_pwm))
> +			return PTR_ERR(st->cnvst_pwm);
> +
> +		/* The PWM is initialized at 1MHz to have a fast enough GPIO
> emulation. */
> +		ret =3D ad7606_set_sampling_freq(st, 1 * MEGA);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad7606_pwm_set_low(st);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * PWM is not disabled when sampling stops, but instead its duty
> cycle is set
> +		 * to 0% to be sure we have a "low" state. After we unload the
> driver, let's
> +		 * disable the PWM.
> +		 */
> +		ret =3D devm_add_action_or_reset(dev, ad7606_pwm_disable,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->cnvst_pwm);
> +		if (ret)
> +			return ret;
> +	}
> =C2=A0	st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> =C2=A0					=C2=A0 indio_dev->name,
> =C2=A0					=C2=A0 iio_device_id(indio_dev));
> @@ -963,6 +1087,12 @@ int ad7606_probe(struct device *dev, int irq, void =
__iomem
> *base_address,
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	indio_dev->trig =3D iio_trigger_get(st->trig);
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_pollfunc_store_time,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad7606_trigger_handler,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad7606_buffer_ops);
> +	if (ret)
> +		return ret;
>=20

The above change seems unrelated?

- Nuno S=C3=A1


