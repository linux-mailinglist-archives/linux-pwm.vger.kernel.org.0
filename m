Return-Path: <linux-pwm+bounces-2933-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F6940060
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 23:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F32C1F22742
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AF418D4C2;
	Mon, 29 Jul 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T52My0+7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AE18A93C
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288545; cv=none; b=Tl9I+NdT/qdMLv3a73l/sW78svGgzDJXZwKZE/YZ6llOoABXZEnj+SN5LvF6QMx2TxkJGUJVsiLE5vKpYAgL55qYsHoIm7uQmyfpxQP3u7VjRyibgsH+kvt/y0oJvOx3TRDzEVb2ZQIrwDLbnAHmT0MrGUTZ2fwk0rb3qN4MhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288545; c=relaxed/simple;
	bh=QFV2qmQz26sFTRFMCHxGRzSOy7flmRvNfoiw+6kBYCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUEVCQ2kvYK+Vpz976hDhrsF1JtQkpF2bRNGchl0C+EzibJnSA0stBdZ7LbEdN3APngE4+fFZP3I66THN+YSMKFdL5XVZR18uI5MzA+N43ezIvJqKQYVbYv6t1i8W/zXGo8xxxxaOtBDcp34hkbofKXoaIyuExwh47ng61AALXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T52My0+7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso1923679f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722288540; x=1722893340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4cErnTb1l8yhpg9Tg8ypbE+BCEieRlUIej+QcI2FRX0=;
        b=T52My0+7Gmtx4NAtVrSFaMTg2gEeWoG5jDAxJzsV0I5N07330b1OWIJJ7fKllqvbG/
         l4UvSYqxifywEl1IWOc1GR6W+uI+ivmaKf5Gqfki6G9Dlk2blYwokOneI9kKPsfvOTJy
         E8S4Di/jYkLloKLlvH9p+capbmL8vLWp1O8X7mZNN4jCbb1mhmGufiQC0xQGkhiBcxA2
         +CUlPz8bvJs7pdJiqkRSPx1F4dF/dFDg235UZ8VcJ/tJc4ENFHTIb7YolxVq2knGuOb/
         YPmOh5caE0PM4Gw8PA6b1CboU0QRc3N8uU2HPrweaejKd6IYbUgY16KwLK4CYHzoFBWs
         wbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288540; x=1722893340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cErnTb1l8yhpg9Tg8ypbE+BCEieRlUIej+QcI2FRX0=;
        b=Qg7QHlqHVolgGm7ppsEWqbmI6Ia99DA0ABxsUgu967qT2I1gvpYkH2ddxG77tQzZ/f
         MNSzjFwSynosfgTObADSUFslqIcnw6azfteCM/Pwt6qif/cnymOx6LahjuToLYBprvQT
         ixLpPtQW/g6mHr8Lu/XGe8eGmS9JNXDrHWmpFSWQLkgyAsj1DeJywT4L8pSV7x61hd6J
         Av54ZzeYMDSET81LKQZ571yIQQHjX9zJZqgfg29jev77Wvmo415BDdiKa8Ska5S26Xhj
         1ISMXecY6pVBimJS/yORH1Yq3LAT5Yq0lH9vru85qmM+RmV/dr76mpZyiRy9HmYeVa1D
         jVEw==
X-Forwarded-Encrypted: i=1; AJvYcCVJLQ5EOH8eHZA1eMJduqteo/S0mqt1u3CO5aPq8mzQ8AcyH/jwwchilbPbocIAFdRQxvzq3XykRuVZ0f3dne6tZAm+41PnnB97
X-Gm-Message-State: AOJu0YzWlkugQdTQGXrkYFktIWCTRmneqHZnnD8j+/xKa7GeuNb9ykYu
	NBWvOnPtQzsoHktBTP+p/kin/3vqSaq7wNh/5a21Kt0Zj7i2Nd0d0wPmAyFOidM=
X-Google-Smtp-Source: AGHT+IGhSm3nq8nMhPLKmqoYbbfdLfGUwTrnX7GQ11Xjp/jK9udRNVktuEPxWgIWLY3VJ3gPERx9CA==
X-Received: by 2002:adf:e263:0:b0:367:4ddf:385c with SMTP id ffacd0b85a97d-36b5d0b033cmr6147968f8f.6.1722288539773;
        Mon, 29 Jul 2024 14:28:59 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:9281:2426:cfd1:cea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e51f0sm13093207f8f.46.2024.07.29.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:28:59 -0700 (PDT)
Date: Mon, 29 Jul 2024 23:28:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <aczpsiqyh4qsbvnqhqdnvkj2j3fihkltafop5ajkxm57sehbx5@mn4vp7avpeac>
References: <20240515112034.298116-1-dima.fedrau@gmail.com>
 <20240515112034.298116-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbbjns3pyudpuy4n"
Content-Disposition: inline
In-Reply-To: <20240515112034.298116-3-dima.fedrau@gmail.com>


--bbbjns3pyudpuy4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Wed, May 15, 2024 at 01:20:34PM +0200, Dimitri Fedrau wrote:
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> new file mode 100644
> index 000000000000..1904d1ee0652
> --- /dev/null
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + *
> + * Limitations:
> + * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
> + *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
> + *   - 2 Hz steps from 2 Hz to 128 Hz
> + *   - 8 Hz steps from 8 Hz to 512 Hz
> + *   - 32 Hz steps from 32 Hz to 2048 Hz
> + * - Cannot generate a 0 % duty cycle.
> + * - Always produces low output if disabled.
> + * - Configuration isn't atomic. When changing polarity, duty cycle or period
> + *   the data is taken immediately, counters not being affected, resulting in a
> + *   behavior of the output pin that is neither the old nor the new state,
> + *   rather something in between.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#define MC33XS2410_GLB_CTRL		0x00
> +#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
> +#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
> +#define MC33XS2410_PWM_CTRL1		0x05
> +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
> +#define MC33XS2410_PWM_CTRL3		0x07
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
> +#define MC33XS2410_PWM_FREQ1		0x08
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x - 1))
> +#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
> +#define MC33XS2410_PWM_FREQ_COUNT_MASK	GENMASK(5, 0)
> +#define MC33XS2410_PWM_DC1		0x0c
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x - 1))
> +#define MC33XS2410_WDT			0x14
> +
> +#define MC33XS2410_WR			BIT(7)
> +#define MC33XS2410_RD_CTRL		BIT(7)
> +#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
> +
> +#define MC33XS2410_MIN_PERIOD_STEP0	31250000
> +#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_MIN_PERIOD_STEP(x)	(MC33XS2410_MIN_PERIOD_STEP0 >> (2 * x))
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >> (2 * x))
> +
> +#define MC33XS2410_MAX_TRANSFERS	5
> +#define MC33XS2410_WORD_LEN		2
> +
> +struct mc33xs2410_pwm {
> +	struct spi_device *spi;
> +};
> +
> +static
> +inline struct mc33xs2410_pwm *to_pwm_mc33xs2410_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u8 *reg,
> +				u16 *val, bool *ctrl, int len)
> +{
> +	struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] = { { 0 } };
> +	u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> +	u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> +	int i, ret, reg_i, val_i;
> +
> +	if (!len)
> +		return 0;
> +
> +	if (read)
> +		len++;
> +
> +	if (len > MC33XS2410_MAX_TRANSFERS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < len; i++) {
> +		reg_i = i * MC33XS2410_WORD_LEN;
> +		val_i = reg_i + 1;
> +		if (read) {
> +			if (i < len - 1) {
> +				tx[reg_i] = reg[i];
> +				tx[val_i] = ctrl[i] ? MC33XS2410_RD_CTRL : 0;
> +				t[i].tx_buf = &tx[reg_i];
> +			}
> +
> +			if (i > 0)
> +				t[i].rx_buf = &rx[reg_i - MC33XS2410_WORD_LEN];
> +		} else {
> +			tx[reg_i] = reg[i] | MC33XS2410_WR;
> +			tx[val_i] = val[i];
> +			t[i].tx_buf = &tx[reg_i];
> +		}
> +
> +		t[i].len = MC33XS2410_WORD_LEN;
> +		t[i].cs_change = 1;
> +	}
> +
> +	t[len - 1].cs_change = 0;
> +
> +	ret = spi_sync_transfer(spi, &t[0], len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (read) {
> +		for (i = 0; i < len - 1; i++) {
> +			reg_i = i * MC33XS2410_WORD_LEN;
> +			val[i] = FIELD_GET(MC33XS2410_RD_DATA_MASK,
> +					   get_unaligned_be16(&rx[reg_i]));
> +		}
> +	}
> +
> +	return 0;

Huh, this is complicated. Isn't that covered by regmap somehow?

> +}
> +
> [...]
> +
> +static u8 mc33xs2410_pwm_get_freq(u64 period)
> +{
> +	u8 step, count;
> +
> +	/*
> +	 * Check if period is within the limits of each of the four frequency
> +	 * ranges, starting with the highest frequency(lowest period). Higher
> +	 * frequencies are represented with better resolution by the device.
> +	 * Therefore favor frequency range with the better resolution to
> +	 * minimize error introduced by the frequency steps.

I'm not a native English speaker, but I find that misleading. That
period is in the "possible" range is already asserted by the caller. So
the switch is about "Check which step is appropriate for the given
period", right?

> +	 */
> +
> +	switch (period) {
> +	case MC33XS2410_MIN_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(3):
> +		step = 3;
> +		break;
> +	case MC33XS2410_MAX_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(2):
> +		step = 2;
> +		break;
> +	case MC33XS2410_MAX_PERIOD_STEP(2) + 1 ... MC33XS2410_MAX_PERIOD_STEP(1):
> +		step = 1;
> +		break;
> +	case MC33XS2410_MAX_PERIOD_STEP(1) + 1 ... MC33XS2410_MAX_PERIOD_STEP(0):
> +		step = 0;
> +		break;
> +	}
> +
> +	count = DIV_ROUND_UP(MC33XS2410_MAX_PERIOD_STEP(step), period) - 1;
> +
> +	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
> +	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count);
> +}
> +
> [...]
> +
> +static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
> +{
> +	if (!period)
> +		return 0;
> +
> +	duty_cycle *= 256;

This might overflow.

> +	duty_cycle = DIV_ROUND_CLOSEST_ULL(duty_cycle, period);

round-closest is most probably wrong. Please test your driver with
PWM_DEBUG enabled and increasing and decreasing series of duty_cycle and
period.

> +
> +	/* Device is not able to generate 0% duty cycle */
> +	if (!duty_cycle)
> +		return -ERANGE;

Given that the hardware emits a low level when disabled, please disable
if duty_cycle = 0 is requested.

> +	return duty_cycle - 1;
> +}
> +
> [...]
> +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
> +	struct spi_device *spi = mc33xs2410->spi;
> +	u8 reg[4] = {
> +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_CTRL1,
> +			MC33XS2410_PWM_CTRL3,
> +		    };
> +	bool ctrl[4] = { true, true, true, true };
> +	u16 val[4];
> +	int ret;
> +
> +	ret = mc33xs2410_read_regs(spi, reg, ctrl, val, 4);
> +	if (ret < 0)
> +		return ret;
> +
> +	state->period = mc33xs2410_pwm_get_period(val[0]);
> +	pwm_set_relative_duty_cycle(state, val[1] + 1, 256);

pwm_set_relative_duty_cycle doesn't use the right rounding for
.get_state().

> +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +
> +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> [...]
> +static int mc33xs2410_probe(struct spi_device *spi)
> +{
> [...]
> +	/* Disable watchdog */
> +	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");

Wouldn't the watchdog functionality better be handled by a dedicated
watchdog driver? Disabling it here unconditionally looks wrong.

> +	/* Transition to normal mode */
> +	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> +				    MC33XS2410_GLB_CTRL_MODE_MASK,
> +				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
> [...]

Best regards
Uwe

--bbbjns3pyudpuy4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaoCZUACgkQj4D7WH0S
/k5krwgAnusykD9o65Uxr7SGCwAZy4+TP1jawyHLjKBmdQMxzqoyzrg1ZHhxvK0G
uBIHVOHYBoJe03YpjUfjPFkXHD3nzbWNrN4UQ/wMVquDuZp/mEv+ku/kVSS4/C4z
asELbHeMdjY7M5cpYNGopoSbVDsUMPXEbN69FLEluWVi32qh/dJofShf/XdWF1x3
Z8DF7rBU4m1+LHDWl2cz6TcDwc/TcgK9usmlNYoED/Zi56JenK1JzoBLiQ4iJ3VB
pZYvhKvJEMhDselSe8xp52PFnhbdoguCoQ02+WS22gPjVTo6YJzr84GImkt5eLzE
LgP+rlJwZbl+Ja4guJF4kxk5tl5twg==
=Yv+K
-----END PGP SIGNATURE-----

--bbbjns3pyudpuy4n--

