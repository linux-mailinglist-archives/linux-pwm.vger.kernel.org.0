Return-Path: <linux-pwm+bounces-1610-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9B85F548
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Feb 2024 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CEF282819
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Feb 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DC38FB9;
	Thu, 22 Feb 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTR77EIv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13F39875
	for <linux-pwm@vger.kernel.org>; Thu, 22 Feb 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596342; cv=none; b=EPQb05lpg0OHvOjS4Yy+pnKswIRwBYi+0eV0NgwQUu2MaRWJ+K/negkdxNVbejcWCzBAh99R+j5s0aWdlW++xsfVuZXjEWvfxeDEo/ARBYyc/tA7A03YeBotzSGvLD3USRN1tPSUoYiRGTzF2x4vShf7GVT5L8dG9JOTfg3JBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596342; c=relaxed/simple;
	bh=vA6KsjMDsYeJUiouncuiAPyK9eMMam0b7PQVbEpCwaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pG0GTq7Xo0Q8qNlYdbBz/LLYIojt7biAj0UiCIoJPrGwuPnQhYbMi28XJBeaIn1p8lajNqieFgEQL75GZ5pydFA6k6F4GDKYvv+RxACmXPf0NI6t/Oi/n/mn15Yzj5Aj4cC2tGv6ZOLnj9hcJyBpSZDUzKo4fFfpWjyRcbQi1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTR77EIv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21eea6aab5eso2927431fac.0
        for <linux-pwm@vger.kernel.org>; Thu, 22 Feb 2024 02:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708596339; x=1709201139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8JLVZ3R2EYq4krc64UFvuONXpDU+DWTCnVeyLLYpCE=;
        b=jTR77EIvhh+fo1OGAAs5LHWBabMimy6aAccSsQuJmxO5jIi9wWXKiUZSiBrnOT95xM
         T2aBo+TJnBLGzDYQoiyKiGfM7BTR5vZViSNVF+PzFaQW70Zvn+WK9NqUtNNRDh24l54Q
         QWflByMu+qsDCzE7SLG9dv5BsZkDJn0Is79HZeeQ7FpF2ogntfB7zx8Ua+ktODFRJEM6
         ZkiDgTkJKW8JqmlE84x+BBlvJDyIvsUSg+DmKZpHBnLQ7JLRfEhVVezBQjVt5Tlv7TQn
         WZFwY6n1GaKWdG/2rzeVUNqEMfkqVr6RsJ3x3pEEGiyKotpplCuDz7WisZjuPYZll9Nj
         yxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596339; x=1709201139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8JLVZ3R2EYq4krc64UFvuONXpDU+DWTCnVeyLLYpCE=;
        b=B6Z111clysJgjajCUooVxyTZmLTnqbTbDyF9F0xMVRe0VYwgt3ITNnDuPAG2FfsX3f
         kA49opuhLGKACqGfNi3MsThqBq42OLBdOQPoZyLzoSTNN62ewBaECQFDS1iPJxiMuEG3
         RRUCYwWmCvdNs82iR6bz0vpkRmBcESa2+R8zBxMl7gmK35zI3clNtqsTB4P3uIhIU0au
         Lmi5hvmfu8EbDPN9piWPbbyrgmbPQttyuFRyyJqXGdqREhZp/zwOP/MdRY2SZQ7isfqJ
         rF13RERAckFlu1fpE80uejueVqz4dmdU7JVk0hy5ppsSF4l6O95OVlnaEiHIH6tfmdQI
         9+vA==
X-Forwarded-Encrypted: i=1; AJvYcCXnv/sik52o9HrSVcyb6KWJFGRAV3vSD6lQEsKvqXfUVUHiQ8xa47EWrnJC+yJT6AzRRBTaVBdB5+k/ms66ZDA8/brPD1E2+tyD
X-Gm-Message-State: AOJu0YwkveAqZ+p8jMkc/IqhRoP0dgJNcGye8Z94I5A5X0HzQt+7V0vo
	dZKtj3DVGH8M5YgRdHCuic26SjdP+wuE9TmtX/CP7nxP8Gtc/LfpTArj7lsz/60fc+hzMBWthjA
	HQiw3HPQJxab45y01vcsFdwne9mrGRH55kJg=
X-Google-Smtp-Source: AGHT+IFUz4e5B4koxcZS0k88K27v7TRe/CZzFuzGGbHXOvNhbuyH7hdx1GUCGyTiIHzzpSBa8smDYyqZZc9vg9ITwz4=
X-Received: by 2002:a05:6870:548a:b0:21f:a33:e493 with SMTP id
 f10-20020a056870548a00b0021f0a33e493mr9277356oan.16.1708596339482; Thu, 22
 Feb 2024 02:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de> <543213f44686ee72d8f88897bf2ca616e837ae44.1707900770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <543213f44686ee72d8f88897bf2ca616e837ae44.1707900770.git.u.kleine-koenig@pengutronix.de>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 22 Feb 2024 18:05:03 +0800
Message-ID: <CAAfSe-vdsPxLzQCk4XFd4OiT=B27zGKLxY39A4S81G=FJ97TgA@mail.gmail.com>
Subject: Re: [PATCH v6 110/164] pwm: sprd: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-pwm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 17:34, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> This prepares the pwm-sprd driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Tested-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/pwm/pwm-sprd.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index a38f50c3dc00..4c76ca5e4cdd 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -34,13 +34,12 @@ struct sprd_pwm_chn {
>
>  struct sprd_pwm_chip {
>         void __iomem *base;
> -       struct pwm_chip chip;
>         struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
>  };
>
>  static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *=
chip)
>  {
> -       return container_of(chip, struct sprd_pwm_chip, chip);
> +       return pwmchip_get_drvdata(chip);
>  }
>
>  /*
> @@ -248,6 +247,7 @@ static int sprd_pwm_clk_init(struct device *dev,
>
>  static int sprd_pwm_probe(struct platform_device *pdev)
>  {
> +       struct pwm_chip *chip;
>         struct sprd_pwm_chip *spc;
>         struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
>         int ret, npwm;
> @@ -256,9 +256,10 @@ static int sprd_pwm_probe(struct platform_device *pd=
ev)
>         if (npwm < 0)
>                 return npwm;
>
> -       spc =3D devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
> -       if (!spc)
> -               return -ENOMEM;
> +       chip =3D devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*spc));
> +       if (IS_ERR(chip))
> +               return PTR_ERR(chip);
> +       spc =3D sprd_pwm_from_chip(chip);
>
>         spc->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(spc->base))
> @@ -266,11 +267,9 @@ static int sprd_pwm_probe(struct platform_device *pd=
ev)
>
>         memcpy(spc->chn, chn, sizeof(chn));
>
> -       spc->chip.dev =3D &pdev->dev;
> -       spc->chip.ops =3D &sprd_pwm_ops;
> -       spc->chip.npwm =3D npwm;
> +       chip->ops =3D &sprd_pwm_ops;
>
> -       ret =3D devm_pwmchip_add(&pdev->dev, &spc->chip);
> +       ret =3D devm_pwmchip_add(&pdev->dev, chip);
>         if (ret)
>                 dev_err(&pdev->dev, "failed to add PWM chip\n");
>
> --
> 2.43.0
>

