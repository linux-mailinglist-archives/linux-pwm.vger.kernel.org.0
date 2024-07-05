Return-Path: <linux-pwm+bounces-2714-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC804928F86
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jul 2024 01:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31581C213C4
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE4D145A0E;
	Fri,  5 Jul 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="okYXYmty"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2379F3
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720221969; cv=none; b=BbiJTX5hdp20SGWs4G9r1au2B9BA7a0XhHYbJWgqM0T1kKQKQLZHfxl1bFz4lai5W5m09poiX4F/xO8MCIPd1aEI+Gi6zBzZxqOWbp/7G2q891OtLDumnkkq1NDcrfErFQXVkBSxIloqTIP0gURFtX1IP0GfILmMMDiH3y0G8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720221969; c=relaxed/simple;
	bh=3gMAndsUvgabh9qev+8EmCJaTlEII5ryUC+FGczY84o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4RRp9WWZXM10JMINxFvBEYsvUp3h1f18bpWos8gIjHUbpu1pieQH2KUDQ9TLr1occyYdtKCww+sM+p8v6gRoTTtcVLjXtR/D/ZhJFqduOyMO6Ess1ZweMXsqPgK2y/nT4vn1AuajE6E6uhVLKkXryaWFstJY2/CV5nimxgsIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=okYXYmty; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so3300315a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720221966; x=1720826766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FIGyFLoN5cw68zfKfOk7jOzbeIQ4UpGai4sSTRJq1M=;
        b=okYXYmtyQBk+x56wcaBzuuF38eBKM+Ukl7sZqj8XHTMDa7sM6vPFmp6Jyjk+qgojfL
         VeFG+M2XFrTUDkTsSomkpHbW44afBWzxC6RsFfQ4qiBt7f3NmD4f/qf0BMdawhN8fnqe
         nEwH2npskAd5mVeqxFZiUpTGfyMd6etrqVkZmLecuIVdtZwOKlnaT6TXoqCO/0woakPw
         pYSVADAcgqC+IbZSrjN/K+SRMh5w7E1i1PBVdpiI/HZCc/I38qD4VgQuxkH77AhSabxb
         IpQpb7zNd7TBFV1VotgvgWNcKTmEIXO82DHynLqWbaX9A0vo8N3xBBc/W4skUAyJbAap
         DJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720221966; x=1720826766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FIGyFLoN5cw68zfKfOk7jOzbeIQ4UpGai4sSTRJq1M=;
        b=GiUpE0+9UaU3L5sjFBSPQfdBKWW5NDFPSWb4jVwl9YtvzVM669p0VDnU3x/djsbfxt
         s+UXj6bmSKNhPl2jPqKNLxQt3PeLz/J4Y5iQUfEdtlbLvaCE0kyWecZzEFC2coZk57vN
         nJMrKzMZ72FVzLaxdIa1ylWlDxaxF1crsDCHcDxa836uv04BryKiJ6f6gxu9k7B2U0o2
         sLWAws3hpgRucULrAiK/SHrBh8x+FtHt+bAs415Oe1aJl+aIasXypuxMW4R/DU1faR50
         bHDjqaGgc99JiSDhcFYFdMoR7s2dWRRDzLXsEt3jMWvKQBvciv+A0mqSe5SCOj8Y7t35
         F8fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzJ+hAW5EmnIi/IhxPtqQQ1eUmIlNL5m8lC62g4IjnAc/PyEIhHdwYa9aqotd1/9usRTZDSsawBPVRMSf7d+oNR1bYn8Iybe8i
X-Gm-Message-State: AOJu0YzZNEbkExHwBo1MzFSYdmFkOyv5kc4ucN+czoNWCivoJV94V2Ea
	glv23iqRtl+kIYMB+UG3NpGi1CpwhZz91wnqnZ7e5orU1e0oQZXaXWP+/iMColc=
X-Google-Smtp-Source: AGHT+IFg+5A1xjo41b4Ew2aKc+k+EzcATPIJ3+HMQghpCnt6pAjcGISfM1fIKkVdIzfPnRvqY87VSw==
X-Received: by 2002:a05:6402:234c:b0:57d:3e48:165d with SMTP id 4fb4d7f45d1cf-58e7a74e11dmr4508736a12.4.1720221965757;
        Fri, 05 Jul 2024 16:26:05 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:5898:1844:403c:d2d6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d242037afsm3768133a12.51.2024.07.05.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 16:26:05 -0700 (PDT)
Date: Sat, 6 Jul 2024 01:26:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] pwm: Add Loongson PWM controller support
Message-ID: <b2lyte7dtrdxxoj4rwwrxbt5myc3td7v3psus7h36qc7dp3thh@czfp25bferl4>
References: <cover.1716795485.git.zhoubinbin@loongson.cn>
 <23d08fa45237efd83cb9dd51a259e2c980f01b3f.1716795485.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3levmdfnv3vsobbm"
Content-Disposition: inline
In-Reply-To: <23d08fa45237efd83cb9dd51a259e2c980f01b3f.1716795485.git.zhoubinbin@loongson.cn>


--3levmdfnv3vsobbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Mon, May 27, 2024 at 03:51:12PM +0800, Binbin Zhou wrote:
> +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
> +{
> +	int ret;
> +	u64 period, duty_cycle;
> +	bool enabled = pwm->state.enabled;
> +
> +	period = min(state->period, NANOHZ_PER_HZ);
> +	duty_cycle = min(state->duty_cycle, NANOHZ_PER_HZ);
> +
> +	if (state->polarity != pwm->state.polarity) {
> +		if (enabled) {
> +			pwm_loongson_disable(chip, pwm);
> +			enabled = false;
> +		}
> +
> +		ret = pwm_loongson_set_polarity(chip, pwm, state->polarity);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			pwm_loongson_disable(chip, pwm);
> +		return 0;
> +	}

Given that the configured polarity isn't relevant for a disabled PWM, I
suggest to swap these two if blocks. However then you have to be a bit
more careful for the polarity check because otherwise the following
series of commands yields wrong results:

	pwm_apply_might_sleep(pwm, {.duty_cycle = D, .period = P, .polarity = PWM_POLARITY_NORMAL, .enabled = true});
	pwm_apply_might_sleep(pwm, {.duty_cycle = D, .period = P, .polarity = PWM_POLARITY_INVERSED, .enabled = false});
	pwm_apply_might_sleep(pwm, {.duty_cycle = D, .period = P, .polarity = PWM_POLARITY_INVERSED, .enabled = true});

> +	ret = pwm_loongson_config(chip, pwm, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret = pwm_loongson_enable(chip, pwm);
> +
> +	return ret;
> +}
> +
> +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	u32 duty, period, ctrl;
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	/* duty_cycle = ddata->duty * NSEC_PER_SEC / ddata->clk_rate */
> +	duty = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> +	state->duty_cycle = mul_u64_u64_div_u64(duty, NSEC_PER_SEC, ddata->clk_rate);
> +
> +	/* period = ddata->period * NSEC_PER_SEC / ddata->clk_rate */
> +	period = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> +	state->period = mul_u64_u64_div_u64(period, NSEC_PER_SEC, ddata->clk_rate);
> +
> +	ctrl = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	state->polarity = (ctrl & LOONGSON_PWM_CTRL_INVERT) ? PWM_POLARITY_INVERSED :
> +			  PWM_POLARITY_NORMAL;
> +	state->enabled = (ctrl & LOONGSON_PWM_CTRL_EN) ? true : false;
> +
> +	return 0;

You didn't test extensively with PWM_DEBUG enabled, right? You need to
round up the divisions here otherwise you get strange rounding results:

Consider ddata->clk_rate = 1594323. When a state with .period = 20000 is
applied, LOONGSON_PWM_REG_PERIOD is assigned 31.
Calling .get_state() in this situation gives .period = 19443. Reapplying
.period = 19443 results in LOONGSON_PWM_REG_PERIOD := 30. Iterating this
further yields:

 - .period = 18816
 - LOONGSON_PWM_REG_PERIOD := 29
 - .period = 18189
 - LOONGSON_PWM_REG_PERIOD := 28
 - ...

> +}
> +
> +static const struct pwm_ops pwm_loongson_ops = {
> +	.apply = pwm_loongson_apply,
> +	.get_state = pwm_loongson_get_state,
> +};
> +
> +static int pwm_loongson_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct pwm_chip *chip;
> +	struct pwm_loongson_ddata *ddata;
> +	struct device *dev = &pdev->dev;
> +
> +	chip = devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = to_pwm_loongson_ddata(chip);
> +
> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	if (!has_acpi_companion(dev)) {
> +		ddata->clk = devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(ddata->clk))
> +			return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +					     "failed to get pwm clock\n");
> +		ddata->clk_rate = clk_get_rate(ddata->clk);
> +	} else {
> +		ddata->clk_rate = LOONGSON_PWM_FREQ_STD;
> +	}
> +
> +	chip->ops = &pwm_loongson_ops;
> +	dev_set_drvdata(dev, chip);
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		clk_disable_unprepare(ddata->clk);

This is wrong. You aquired the clk using devm_clk_get_enabled(), so you
don't need (and must not) care for disable.

> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +	}
> +
> +	return 0;
> +}

Best regards
Uwe

--3levmdfnv3vsobbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaIgQgACgkQj4D7WH0S
/k5DmAgAgy9+bQt6LKhD22GPl2c+8gLHZtUHK+moqqjXgshYlaNilsgaj4Uc1fPD
FQys3BoRj6KRIumOZ3DHeXzeJFUxvykf4+DlSglb5irhXw6sJsSLr9IsSQpIxuLR
RKmozBhHrmlfuKsRADcUB+3taW8WQVacDqqMCKG4uH9+iKOif8o2+f5RE2xs7AZL
p9lChxf/UCxULkPwqUEYPsUncgH1/87ozGT9NfUSYQqXR+jJKvermAeMFj3AGeDd
3ThB5rP2WOYSMcvLbazL5PhTcrvo4nlxMPSelZf+fzDA2H6XBpBwF3pfVgKwR3SE
FGZ6cq0bx8AobIhqzJ5HE9ylf0hlNw==
=NAGs
-----END PGP SIGNATURE-----

--3levmdfnv3vsobbm--

