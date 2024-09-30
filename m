Return-Path: <linux-pwm+bounces-3408-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2E98A0B8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 13:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98335B28B5D
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592E190079;
	Mon, 30 Sep 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X5VXd/mH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF218E04B
	for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695742; cv=none; b=M04oR3Xb72OjFKQIw4fdShnq30oqz14XbYOF+PRWYYTG8kt2Tef99pDD8gd/O8s8FaRF/FOGe4hVJI3w3UQ0jDm5HgvWFXPHnIXOQ4QDDNdpDCnlILDfHUsw5yB05fYNc2rp+CDJ1ABZ4YsofS2+bA1m1g5EhdAMggoc4YDjW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695742; c=relaxed/simple;
	bh=GTATx1ZjgRAIeRb4gVhlCtdMSImGj/h83r+eF+k6xOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evMDHzfV1rKK5OoMJP7jSdzxbEg7IMTfLDFH9x2+TXtF/kvoH6cqfgQKNahTWHN1DXs/By1cQJzbAjIQkFQNrFpxZ9On8p+ldGR//RzXhLY4jqDjiot2zRdPe1UwezezVjxf4tKgpHs8s2ew+Ez8OaVvoQ8t6Jv7wg/QmeZZsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X5VXd/mH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71100987d1cso2569823a34.2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727695740; x=1728300540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESV9e65f4opp3oYhgp6rCKPns7ySl2JgdhTmlcbTiZU=;
        b=X5VXd/mHV7Dm6OJ7MXNbeLSGpHHFdF1OxtD8B+rBt50P6C6O95q3/kQ2LUzABFax6O
         RRLGAVvJe40ZrXGKXjJ0NBg19T6Lezjy4BTbipgmmwJRvn5qG2U/mNBl5GfCRSrHohbc
         mKf8yQDZeLYr1Ufh+xYcdM3sG7L01TFkVeTyxcdL+ti/l21cOCGDmh4j/cP86slxGthJ
         grZptFAhCUsIwoxU1vtJN02cCjR/3By8YWg7MrL2yia+itOMezd5+TreFFJJY/FFxlFc
         ckRnDVBt+fqFvmrlt+PBYAG/GDRJjjtY0XRXr+v7vp38tK1BCFK1VWFCzYMJoR0gDGwh
         ebeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695740; x=1728300540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESV9e65f4opp3oYhgp6rCKPns7ySl2JgdhTmlcbTiZU=;
        b=psJFlIa5xbe6wVpFWpb+B70mT2yVUN7eTuAOP4AFKjuiF+7UOTkpsb2qo2YPBrL9DS
         FtKtpytWmAZV+t6GD3A8Geo6AwQXQU2docq15F24RbpJK7rbp7HIVcglfhO+BifkTsbw
         FIVL7EBfQScvNbVuCV68eWlyAs3dqNLdtwsNHu+BvzcTzUJ2Qp2wfEXuSfDDvcKDhr9t
         nYKPbJbNUUgNEVBeXN06QRsZYk2y+0VFQeputLCXgshY8LkuJIYfaII8zrfzXWRtnTVn
         V/PxUQbCgdECg5V65aVJ61nAYWQ1LSdWuSSqJVzPhFL3iRsiCaOSM/mTaEY9mN6YjyoP
         bEGg==
X-Forwarded-Encrypted: i=1; AJvYcCWNlV6dchCqSSBKaKUDFQVoBl+c11Jx90hPNiu9uTD3rZNwu6CacFJ69gJ8M4fGgUV0ZZ7lO2Baffg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QsAwUa0yVzPpy2sf3UAW+1bUzstU1tgM6xOHMMGyzaXKrcAT
	lPZN4tTOh7aB9ug4BSvKGY1PuwhVQaDo5HF62W+AtrPsa4OH/9qObk3lqu2n9Sjtv+VYtknc7Iy
	6j7gwH+hi1zPe2j9Q27jgPqhC0sGXIi08cNcecw==
X-Google-Smtp-Source: AGHT+IHlrk+6ylJNPNwIsyMeU+6MgSCPdtd1Tld1jqABl45ABUDHKKwEQnK828Pbh+a/oWL/55rN02vH87DWZloHkoc=
X-Received: by 2002:a05:6808:3387:b0:3e2:9e00:5a16 with SMTP id
 5614622812f47-3e3939600f3mr6239921b6e.11.1727695739914; Mon, 30 Sep 2024
 04:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930103157.49259-1-brgl@bgdev.pl> <20240930103157.49259-2-brgl@bgdev.pl>
In-Reply-To: <20240930103157.49259-2-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 30 Sep 2024 13:28:46 +0200
Message-ID: <CAMRc=MfCOuTweTVObh5qP0CftUM_W9cduT2R=r+LP3FKrS=8ww@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: syscon: use generic device properties
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 12:32=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> OF-specific routines should not be used unless necessary. Generic device
> properties are preferred so switch to using them in the driver code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-syscon.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> index 638095d5f459..06c07085feb8 100644
> --- a/drivers/gpio/gpio-syscon.c
> +++ b/drivers/gpio/gpio-syscon.c
> @@ -9,7 +9,6 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>
> @@ -208,12 +207,13 @@ static int syscon_gpio_probe(struct platform_device=
 *pdev)
>         struct device_node *np =3D dev->of_node;
>         int ret;
>         bool use_parent_regmap =3D false;
> +       unsigned int props[] =3D { 0, 0 };
>
>         priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
> -       priv->data =3D of_device_get_match_data(dev);
> +       priv->data =3D device_get_match_data(dev);
>
>         priv->syscon =3D syscon_regmap_lookup_by_phandle(np, "gpio,syscon=
-dev");
>         if (IS_ERR(priv->syscon) && np->parent) {
> @@ -224,19 +224,15 @@ static int syscon_gpio_probe(struct platform_device=
 *pdev)
>                 return PTR_ERR(priv->syscon);
>
>         if (!use_parent_regmap) {
> -               ret =3D of_property_read_u32_index(np, "gpio,syscon-dev",=
 1,
> -                                                &priv->dreg_offset);
> -               if (ret)
> +               ret =3D device_property_read_u32_array(dev, "gpio,syscon-=
dev",
> +                                                    props, 2);
> +               if (ret < 0)
>                         dev_err(dev, "can't read the data register offset=
!\n");
> -
> -               priv->dreg_offset <<=3D 3;
> -
> -               ret =3D of_property_read_u32_index(np, "gpio,syscon-dev",=
 2,
> -                                                &priv->dir_reg_offset);
> -               if (ret)
> +               if (ret !=3D 2)

Sorry, this is wrong, it doesn't return the prop count unless val is NULL.

I'll send a better version.

Bart

>                         dev_dbg(dev, "can't read the dir register offset!=
\n");
>
> -               priv->dir_reg_offset <<=3D 3;
> +               priv->dreg_offset =3D props[0] << 3;
> +               priv->dir_reg_offset =3D props[1] << 3;
>         }
>
>         priv->chip.parent =3D dev;
> --
> 2.43.0
>

