Return-Path: <linux-pwm+bounces-1609-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC1785F544
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Feb 2024 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05D31C21601
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Feb 2024 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471A3D988;
	Thu, 22 Feb 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leyBcQwn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6573B290
	for <linux-pwm@vger.kernel.org>; Thu, 22 Feb 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596332; cv=none; b=csMw/5LdE+8S+NvttxGcMdv0vY9frv+y/peQuAlQFae91nr6F2L3NgWtand4ryYS0cgA57Tiq2gxTb/p/VzJRuD8nWCoAuGmrmpyIp5XQFZ/ldXfD7EmQ4DYa4ublmbx9uesDY4Zz1pkcjc3cAW7sfzS7fNkSTNt10dR40642DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596332; c=relaxed/simple;
	bh=V0Zy0+26lqfgeln16GhLaRn2H3MPFwgLIQ8Avuu5vgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvnimxCW7QIN6cEzL/bI1fDYgBR5vqGcnZqxdDG3Gq13wn8KcZbP1Ja3oakT2bRdQ4o5dpWtUVErGdVn0lrNhV+6cf1exlZjau+FTpLURd7ESYkzyOxZHgE3Od08GqexuDho3qnQKaSvBSK0WW43y1xCLyRuVG2gNEIRX/eWu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leyBcQwn; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21f70f72fb5so403489fac.1
        for <linux-pwm@vger.kernel.org>; Thu, 22 Feb 2024 02:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708596317; x=1709201117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGXbz077unoAiqEk0c/IZDMMkN/wJhZu7xIYqrF+sko=;
        b=leyBcQwn8CPFJ95nfibthwQX4BO2Y/hoSeuL6VY72jkS1Ug5d30UIFgkLRdUTmqntM
         pzczJY0Kqn9UCMc/V54qcppCgSSv0tdlQ2wM/U6c0EGLQ0F+Yfz1EyFvPzOnfgplhdL2
         bLeepKM1UA8l7K9uvg6b+T+/frin/Wks/nRej+UJeuxVLcxK7E4WtLn8jzoAl/zgvH0d
         sEnZscT1j55QfxwfcQvy0eqZXCMuII9poe8klAZZ4cI/D4unmALdIsGbRhyCPduJlw0r
         DI11AdxqOJaUsniX6nevMOeNZ2fx5uoCpKd0jeitD5aMKAmtf//cTkx555/YKaIRRc2W
         OQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596317; x=1709201117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGXbz077unoAiqEk0c/IZDMMkN/wJhZu7xIYqrF+sko=;
        b=krQMcb6FwZrjXcqorFPc8p+u/tBiPQ4FW4u1QWDxCIAUTvnTnknJqr5rnMmsrO09l5
         Jrugj3KTBKxTFfPYPVX1seY7D5Rsa+bKZzVwhWUA9Z4JDXD87Ljt7OLJQHp3OFb9JMHl
         eGEJ0+7ssaVQ+y0lm4OAsh/gX2bqnz456jahlDYVv/CbikJatT4cAGFVe7CncRjYlQPS
         NrFXla1KozLU3uL1YbEkVpIzoILiU3NYJLi49gOdVaaJa3X/zbRkBQVTBFoOaGeTcMlb
         wgWsHAcXe7v0VONjnjiyxf+BNxj0B/UP5n9Qqb1aELHrTenrCtr6A5tBToUxQfBdYMMU
         vbSw==
X-Forwarded-Encrypted: i=1; AJvYcCW3KI6C5toj5ksCVTMUqC7F+mrvihqRL5ML7zLwIBjDQfZPjKg9yhRHlRq6xAhsva9lyCgX7EHiN0g/EHFiJgYhwqJni9/Bof3p
X-Gm-Message-State: AOJu0YwLIHIS39z6QkhpiNk69+Oy0z/B9VYEtcIx1jCD9DkFO7mOYDA6
	v877Pc0r5PSThnA1EUF6v2njho26Bo883/SXZLPPyihCz8XpPFkWx5UVi/IIGMSoAuBkYzqB1Ir
	n5VceQPyEufn+4dZzKLxlgcoJI50=
X-Google-Smtp-Source: AGHT+IH3GKW35p2fb/8aXNOuLLHSapXsZf0hifN1zAnGgLYt8LNuO2E3n5uffJNgRf/ywEoluBFoqFYZIXSbSGZUp9I=
X-Received: by 2002:a05:6870:ecaa:b0:21e:6670:b84d with SMTP id
 eo42-20020a056870ecaa00b0021e6670b84dmr20084269oab.34.1708596317588; Thu, 22
 Feb 2024 02:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de> <f85771f4bf659c0fdee30cf117b87fd877bad5e4.1707900770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <f85771f4bf659c0fdee30cf117b87fd877bad5e4.1707900770.git.u.kleine-koenig@pengutronix.de>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 22 Feb 2024 18:04:41 +0800
Message-ID: <CAAfSe-sn1yW5uX1N9Kk5v=tZFokN_6NgjrDYB9SZa_shbn3tnA@mail.gmail.com>
Subject: Re: [PATCH v6 109/164] pwm: sprd: Drop duplicated tracking of the
 parent device
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-pwm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 17:34, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The pwmchip stores a pointer to the parent device, so there is no need
> to store another copy in driver private data. Drop struct
> sprd_pwm_chip::dev and use the pwm_chip's parent pointer instead.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Tested-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/pwm/pwm-sprd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index 2e87666ad2b9..a38f50c3dc00 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -34,7 +34,6 @@ struct sprd_pwm_chn {
>
>  struct sprd_pwm_chip {
>         void __iomem *base;
> -       struct device *dev;
>         struct pwm_chip chip;
>         struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
>  };
> @@ -85,7 +84,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>          */
>         ret =3D clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM, chn->clks)=
;
>         if (ret) {
> -               dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> +               dev_err(pwmchip_parent(chip), "failed to enable pwm%u clo=
cks\n",
>                         pwm->hwpwm);
>                 return ret;
>         }
> @@ -182,7 +181,7 @@ static int sprd_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>                         ret =3D clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS=
_NUM,
>                                                       chn->clks);
>                         if (ret) {
> -                               dev_err(spc->dev,
> +                               dev_err(pwmchip_parent(chip),
>                                         "failed to enable pwm%u clocks\n"=
,
>                                         pwm->hwpwm);
>                                 return ret;
> @@ -265,7 +264,6 @@ static int sprd_pwm_probe(struct platform_device *pde=
v)
>         if (IS_ERR(spc->base))
>                 return PTR_ERR(spc->base);
>
> -       spc->dev =3D &pdev->dev;
>         memcpy(spc->chn, chn, sizeof(chn));
>
>         spc->chip.dev =3D &pdev->dev;
> --
> 2.43.0
>

