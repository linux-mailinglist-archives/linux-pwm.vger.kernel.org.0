Return-Path: <linux-pwm+bounces-1546-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D13859EC6
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Feb 2024 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A82128123C
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Feb 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21C224ED;
	Mon, 19 Feb 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfaIsOWy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375422325
	for <linux-pwm@vger.kernel.org>; Mon, 19 Feb 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332610; cv=none; b=iDp8b8kD21MV2kEc47TDvXGFoKm2dO/Se1pIpGJTlD1qUzIOSNanWixlh32LmuPSuTkGzRZ4poKmhA716Z/k6RpnuVH4aM60UM94g9H7YT4YG3w1wx5OqFj7xjsdBuYzg+MfXndy4TzFgmZHFF7ssdsQTUAjkUEejUDQmee6MVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332610; c=relaxed/simple;
	bh=esPLRAHg0TX3/OOMD3XKtCq7Y+tA1RibVZFO52hyKF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKkbyYJ1iWfG5UW+JDnDKHKHk7YPJXeanGVgvRP2mzqy7Hvz7j4bnoDAhkmwNr04WYWPqkN3YF9xcWODeTs4CuxumPT8CjhF0jFVc1+jGToqOjYbV8vHPXeMVB9Pq2cXNtPvEPo0EyOx+hnkFPp4Xz/dIgwe/mQe17t51sWdYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfaIsOWy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-20536d5c5c7so2523465fac.2
        for <linux-pwm@vger.kernel.org>; Mon, 19 Feb 2024 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708332608; x=1708937408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESvIuNfO7GiyzxKM/JhFMh6Wqkd03jY1rdDDE9ulJwQ=;
        b=HfaIsOWyPocBYXILT04hrkXtXRI38FyurwrIPEiNzSbgN4v7bmyByPHfu8Y2P2dHaw
         nDr1PJ9cyFuWx7sia/Rjpy5FQssAZFPj4s2Rc+NLcHHxQOCrucUmRPGchCeEjibd/Rtj
         SkcCdxMeKzUm81T1FHT+9xL6vlR/F9tGWxHSb/sdHSQUxm8vHy5cIV2cF8zZRhbKrEnp
         whjsirkR8WncHJwjghtEemz5XYOd99MZo/dbV+/6Xg+8Xl8Z53EMsQueeJdbBS/8rlSS
         2QMB65IDJZ2MjGJYmpEL2C5/Y+iB5y2gCS11KLdCet575rhlUqrsBC5i0R5GyTjWBoRG
         xlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332608; x=1708937408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESvIuNfO7GiyzxKM/JhFMh6Wqkd03jY1rdDDE9ulJwQ=;
        b=pq3La+wBzaqOVy3o325kYxSiVF82iEY5iPiWdcwiOfYAuHns68D0H8v+XWRHF72WIo
         08Dq4R74IqcUFecmdDrarHSdqPwZJovjvEtHaWNN0hj4FrfGDP1sPyqjWSh29hb4D1sk
         p7rCTrwBtoRLXr7h16/wWfaFas4nZUIlFQvQoBlgLh/Jhgik/k1vzw0AXe3eYKCijvSK
         RapMhfommzGtE4Bi1aIyZBloqVmsT9ukzoHQpby3282XWO+lRAj/X9syYt1K3jCW/nCn
         VdJOcAuzObLsnMrXoaV8T1rb2y5CJ/IHupOUnyWR6PoB0sg55ygwR9kfYPD00IweNyBf
         RWnw==
X-Forwarded-Encrypted: i=1; AJvYcCUzitMh8WLj7HVYIjMpc3nqDP9OhtMfUYmWGJVCFRUjR/ONH6s7nhBVlhzPI/hH2n5tW6m28qkB+uG88XuqC+JY4cvBw6J3YLL+
X-Gm-Message-State: AOJu0YyGf4FBQCaGmCMCCG2pwuT2LoD6RyZx+Qsj1ikpa4DgIysvDcQr
	ySOI9usb561hsrhXNOtPl9/IPo9KsypO1o6RQlvpcypulQoDcgWeEKNsCFI0EHHxcHF02TSdG0c
	p3GwyzS1cUVt65GvUIU8mssNsqlRlp/ol
X-Google-Smtp-Source: AGHT+IFk/vyytTxZ463FDWbtOls2KtKhGoEV3L/K2QstCieKsP3xFxMSc91Ol1jMcTxJuAh/3H6zdfCyCgZTaD0ZcDw=
X-Received: by 2002:a05:6870:d392:b0:21e:a1aa:ab6b with SMTP id
 k18-20020a056870d39200b0021ea1aaab6bmr4494897oag.6.1708332607814; Mon, 19 Feb
 2024 00:50:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de> <682cbbafbfc4982383d66c3871bb9e52d4e03195.1707900770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <682cbbafbfc4982383d66c3871bb9e52d4e03195.1707900770.git.u.kleine-koenig@pengutronix.de>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 19 Feb 2024 16:49:31 +0800
Message-ID: <CAAfSe-uoJ6SevntMBqDn-Mn+z6xN_tLba+xy_LPoyyDQ7Z8ODw@mail.gmail.com>
Subject: Re: [PATCH v6 108/164] pwm: sprd: Rework how the available channels
 are counted
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-pwm@vger.kernel.org, kernel@pengutronix.de, 
	wenhua lin <wenhua.lin1994@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 17:34, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> To be able to convert the sprd driver to pwmchip_alloc() the number of
> PWM channels must be known when the driver private data is allocated. So
> make sprd_pwm_clk_init() not take a struct sprd_pwm_chip. On the plus
> side this allows to drop a member of said driver private data.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/pwm/pwm-sprd.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index 77939e161006..2e87666ad2b9 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -36,7 +36,6 @@ struct sprd_pwm_chip {
>         void __iomem *base;
>         struct device *dev;
>         struct pwm_chip chip;
> -       int num_pwms;
>         struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
>  };
>
> @@ -215,45 +214,48 @@ static const struct pwm_ops sprd_pwm_ops =3D {
>         .get_state =3D sprd_pwm_get_state,
>  };
>
> -static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> +static int sprd_pwm_clk_init(struct device *dev,
> +                            struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM])
>  {
>         struct clk *clk_pwm;
>         int ret, i;
>
>         for (i =3D 0; i < SPRD_PWM_CHN_NUM; i++) {
> -               struct sprd_pwm_chn *chn =3D &spc->chn[i];
>                 int j;
>
>                 for (j =3D 0; j < SPRD_PWM_CHN_CLKS_NUM; ++j)
> -                       chn->clks[j].id =3D
> +                       chn[i].clks[j].id =3D
>                                 sprd_pwm_clks[i * SPRD_PWM_CHN_CLKS_NUM +=
 j];
>
> -               ret =3D devm_clk_bulk_get(spc->dev, SPRD_PWM_CHN_CLKS_NUM=
,
> -                                       chn->clks);
> +               ret =3D devm_clk_bulk_get(dev, SPRD_PWM_CHN_CLKS_NUM,
> +                                       chn[i].clks);
>                 if (ret) {
>                         if (ret =3D=3D -ENOENT)
>                                 break;
>
> -                       return dev_err_probe(spc->dev, ret,
> +                       return dev_err_probe(dev, ret,
>                                              "failed to get channel clock=
s\n");
>                 }
>
> -               clk_pwm =3D chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
> -               chn->clk_rate =3D clk_get_rate(clk_pwm);
> +               clk_pwm =3D chn[i].clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
> +               chn[i].clk_rate =3D clk_get_rate(clk_pwm);
>         }
>
>         if (!i)
> -               return dev_err_probe(spc->dev, -ENODEV, "no available PWM=
 channels\n");
> +               return dev_err_probe(dev, -ENODEV, "no available PWM chan=
nels\n");
>
> -       spc->num_pwms =3D i;
> -
> -       return 0;
> +       return i;
>  }
>
>  static int sprd_pwm_probe(struct platform_device *pdev)
>  {
>         struct sprd_pwm_chip *spc;
> -       int ret;
> +       struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
> +       int ret, npwm;
> +
> +       npwm =3D sprd_pwm_clk_init(&pdev->dev, chn);
> +       if (npwm < 0)
> +               return npwm;
>
>         spc =3D devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
>         if (!spc)
> @@ -264,14 +266,11 @@ static int sprd_pwm_probe(struct platform_device *p=
dev)
>                 return PTR_ERR(spc->base);
>
>         spc->dev =3D &pdev->dev;
> -
> -       ret =3D sprd_pwm_clk_init(spc);
> -       if (ret)
> -               return ret;
> +       memcpy(spc->chn, chn, sizeof(chn));
>
>         spc->chip.dev =3D &pdev->dev;
>         spc->chip.ops =3D &sprd_pwm_ops;
> -       spc->chip.npwm =3D spc->num_pwms;
> +       spc->chip.npwm =3D npwm;
>
>         ret =3D devm_pwmchip_add(&pdev->dev, &spc->chip);
>         if (ret)
> --
> 2.43.0
>

