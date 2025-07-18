Return-Path: <linux-pwm+bounces-6853-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF5B09DD2
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jul 2025 10:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457A31C42271
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jul 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D20221557;
	Fri, 18 Jul 2025 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NZC7xGRb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5B1D8DFB
	for <linux-pwm@vger.kernel.org>; Fri, 18 Jul 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827089; cv=none; b=Bs4HIsgjeNab72RAaNzeeVh6C6f8RQL9Lo5VwCE9mIEcTBKoGcCQd7yGChyV9cltFZbW52Do+1/lHo3ViOXapo34mLOFfMutUpflq1eQ/APaus2wTykx/3Fp4CWm6txJaTOvTEDsKnQscPclk7++WzXeiWq2gzMi1A+C/wWO+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827089; c=relaxed/simple;
	bh=a3MIC7RxixPUwwhGsl42BKsPKoxmkQUFuNgilLzgAQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V222VbTX9iqm/qhWsWch7w3N7KJqVGC6dlyHN/plhxI+VMJO1aLWZZXRx3sryIbHYXxbc+WfjM7iS5eewj2wbECI/UhddvsGhLi1oabkn7xmUvOMapjOvEIs7Z/zLOxJmHHUy1w7OaoLrbFnD3kVcrdluqi+hpw4EjOegpJm0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NZC7xGRb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5562838ce68so1799005e87.2
        for <linux-pwm@vger.kernel.org>; Fri, 18 Jul 2025 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752827086; x=1753431886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDy9TTBigj7nc3pLpQhSmWpeNqPalWZSN8wozU2T8n8=;
        b=NZC7xGRbeWBISykkL42c63rxZe+myLzF7kcsjr3iOrQlZngCQPEBxTNnrLIgielbmn
         0V20wBJR4S9UdeKobo09D9QAMgBxAkyWym5FPv3BcZGrXuwDtBAPgSpm2Mgo4Dmg6Shz
         ocj1kH3i79PlSCbHwSKXFiQ4ONe96+OerZitv69kDW88rl3ufUSz+wfXhFrY9jWbtZQu
         NHjlJqKdpNOvIuA2nd1dStCNlzAs7PXVlsgUjqeoYKz+JkQShSNT2wzwxwbkAlsEjtkE
         ULEF6GfpxN9QZ65sQWDFCpvwuF43BLIKoTu99PDkgqZBKVUiMRq2XdE9U8b4nKVeBs8R
         1+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827086; x=1753431886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDy9TTBigj7nc3pLpQhSmWpeNqPalWZSN8wozU2T8n8=;
        b=Jh14A4TscqViLWXlk/oiMfJcHxJ1SaL6gPt0rUw4mKpoRBjWWooeUljICAE5RQlIy3
         fcAdTaiW6KbDODW/W2J/eTzJoht/6vOq/FpJ6GZi6Bs567lm/JH73me8qktMFzloP8FI
         my5CuBrRnkhH7uuAteqgV/5btePZ2Ey6GZmCgNWLHspB17zmiGmhbuAfRDSu8PMnOrOR
         T8C/YoM8QYE7+xHfJGrPwcY2xqSB3fLx0ABbHNo8BWf8iw1bngFfs8VEiYNVb2gMprJ1
         zC+McZA2MSGfBa3+HC+AZo1PHknO2K+PwqPLA3p7aU2FQPXxEOsAn9cNB23qW9802rhZ
         VJWw==
X-Gm-Message-State: AOJu0YzmBntZXaBjv3ZvmIQGhRyV6L3lqR+0Pk6T+JYi0CGc1kS0Lzoh
	4vyeLGJSCFfFVVsBXVsVeMOVx3j/S8edqfZlfwViEmvuiJp7JLoenrONq8nQ2LZ1DV0lAVQf7X6
	Tyctdc2UljYlZh/uAHQjVomjjSyVwQrzRoCB9Mzau4A==
X-Gm-Gg: ASbGncsXb+kpCIdVJg56G8Yb3z/FV+ybFS3UuYlak5DulKOfxhqxnrfCewK6l5IVpdM
	OchEZKExhKO9/d22m//3lJmNf/t6Wt/thniEA53zjJLLB+JAqWr9Om8MoWlRaNPguD+A7qAfIlV
	0hmVrda0uJsZh8/v3w0AHDq1MqOSFEQFhLDKY5kOvLzLiLHUU/PB34YPnemfRc7iqTy+f7dtdHo
	LpZ0+4uHanjPnsunwm16qzKWIgTN8HczK8j1paX1zjKGUt+
X-Google-Smtp-Source: AGHT+IFecY9ddtgeFWtrSq4/qItewsVx5rXnyCa9Gnx3yNTpoIlCl9hmQqq62ZgP9tK1+Hs15tO0SCuUkwfIeQMfPc4=
X-Received: by 2002:a05:6512:3402:b0:554:f74b:78ae with SMTP id
 2adb3069b0e04-55a23f388e9mr3654046e87.31.1752827086370; Fri, 18 Jul 2025
 01:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Jul 2025 10:24:35 +0200
X-Gm-Features: Ac12FXyB2RNStkSqdQL4qgdh5iipyZ8EEKsKQ8ozC2QQ16JzE-lIp7tuD27i7dE
Message-ID: <CAMRc=MdVLxBcH7EbVC_ce_V74W1+pLTX0js5__db1puVwwXAnw@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Clemens Gruber <clemens.gruber@pqgruber.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 5:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> A PWM is a more general concept than an output-only GPIO. When using
> duty_length =3D period_length the PWM looks like an active GPIO, with
> duty_length =3D 0 like an inactive GPIO. With the waveform abstraction
> there is enough control over the configuration to ensure that PWMs that
> cannot generate a constant signal at both levels error out.
>
> The pwm-pca9685 driver already provides a gpio chip. When this driver is
> converted to the waveform callbacks, the gpio part can just be dropped.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> I found some uncommitted changes in my tree that belong in this patch.
> This v2 actually compiles ...
>
> Best regards
> Uwe
>

[...]

> +
>  /**
>   * __pwmchip_add() - register a new PWM chip
>   * @chip: the PWM chip to add
> @@ -2449,9 +2494,33 @@ int __pwmchip_add(struct pwm_chip *chip, struct mo=
dule *owner)
>         if (ret)
>                 goto err_device_add;
>
> +       if (IS_ENABLED(CONFIG_PWM_PROVIDE_GPIO) && chip->ops->write_wavef=
orm) {
> +               struct device *parent =3D pwmchip_parent(chip);
> +
> +               chip->gpio =3D (typeof(chip->gpio)){
> +                       .label =3D dev_name(parent),
> +                       .parent =3D parent,
> +                       .request =3D pwm_gpio_request,
> +                       .free =3D pwm_gpio_free,
> +                       .get_direction =3D pwm_gpio_get_direction,
> +                       .set_rv =3D pwm_gpio_set,
> +                       .base =3D -1,
> +                       .ngpio =3D chip->npwm,
> +                       .can_sleep =3D true,
> +               };

I would have probably just assigned each field separately and avoid
the cast but it's your code so I don't have a strong opinion.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[...]

