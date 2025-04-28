Return-Path: <linux-pwm+bounces-5734-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B3A9E88A
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 08:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CAA1895FCE
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2E610C;
	Mon, 28 Apr 2025 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1K6otC4L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D11C5F13
	for <linux-pwm@vger.kernel.org>; Mon, 28 Apr 2025 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823078; cv=none; b=CT89xE1cuVSTVyxoZEZ3SX6csyax/TR9QnUDm4ADlDPEKN8N98JLIHXQX+t74Zn7ZrsiBrZOCQ9XLTeAMq1y7+R0IPy5yLE3VMIBmxQ5mSjP9m9Gs7TLgY0/UWl2hgwCjMjrWQcJz/tqUSfjNO/osywLJfjb/pXxASDQP2F0n/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823078; c=relaxed/simple;
	bh=yPwiv3LIPXq7QwC+Z6qeGGumORWMUcAQ8Rt34+S+TqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyUhaQJgiRnr1dgShBrPxYOAgqGjqeGsji7tDUX0nLVJGwelcEdD+vvDTt48ptNlmmiXTJsT39hdDIQB3CKdTrcu+22cug4yTQXQc0LfmZQU/3gGeySX8T6Sfpyn0d1XzAR5OE8enZAp9yWsJK84lhCZf+zcxB2PIdn6olTiE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1K6otC4L; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso734791366b.1
        for <linux-pwm@vger.kernel.org>; Sun, 27 Apr 2025 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745823074; x=1746427874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olp7njR9Ybm79qV02JWYfEZZNtFSE8MfHDfoR2yiSUc=;
        b=1K6otC4LVS8Mr2e6mKhawp9VCVtNjoaiXCOU8gPOnpx/XLl/euBLq5mV+dzC8MRa9u
         xyD/rBCRFZ2eOrfwngfGPbTYBhMA7O4xaJ8h9GQKDMiLIN6zKbjHtVBA72pG8tc4wNy8
         r93ENVJB9hSzfvDyd+6Ogdx+48I7BRzwGceuOtj4aGnt5SI1tBwletGkBUsg1AcM1mx+
         yau5zc/m4KGbPKUZdH50LBq7TvHx+k1jM8yNY28SWcZHZx0KZOWzjthAEhJ0xGhKYU7K
         lWqSlyZDLLff1ywCcDvWOXXJ/EOPC/Gzo2G7WILW5jiyPDSDcQZerUA97EgJHHUllxdt
         tFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823074; x=1746427874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olp7njR9Ybm79qV02JWYfEZZNtFSE8MfHDfoR2yiSUc=;
        b=QaH3lGhLmsUyRxT4Xao3y7NlPzk8KMgEZtkooCh2X4PaxuakBUM/qB9QUjVdssyPFs
         hSaVpi+3+wdDz8ImKrIs5RCFPGt9fix2ruwKm6r6a74LYUyqjm+/NiLpikNqZkO+dP9k
         O5zVijdPgyrskbpIDYlg2x8obKHf/eWjDdi/NmBfvzMZxywVWTavgEtqOw+ptXk5XiSY
         POY54g6MTzNhtiJafnmWR6SzdTc01K7EiCWJcPc68yMh2+7qAaAxM8tMxUG6oqyIcg9S
         5k9jOzCIVlXHr9mAjO1OXSO2P9lA9sAP233S2FcX+7MXLmfXE2c0IpZpg7ot3dy3jOcp
         mUYA==
X-Forwarded-Encrypted: i=1; AJvYcCXjshtNh2rl0dPHndzryda/crVIGiQ89DttVri8/i+kiE5fQE9RXX1yM46zExtsd3oBhFFp2gnO40E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CD+qReP/qcRO4rU9IecTv+Zz5f32gKPfH/OVL1QX/XNGpmrn
	F9DLItfakEETZ+jqTp3eQD6/vnjCwHqSHLC+YFvQh5zDRn0IlDsakG7PpaCfizbbG5f5x3H0C6X
	ZMYd5kFWkRtOEsWS0hJ5cqIEh9aDa4T/YiCjaWw==
X-Gm-Gg: ASbGnctTFKxGmS6aB8bZuIGc10nT6UMIxtJjD9zzrp9yAENjYCPENlkiwP4KpwV1ZfX
	GwobY5haQkIwqVipch06o713ybfuS3sAU4rkC1YqCLL10UO0/NK29idw95mZy/WI5eHTSphH4uZ
	An7ZjpAjI4gciy6Et83XR/rNY=
X-Google-Smtp-Source: AGHT+IEtEaxs9n/fqGJEuZ8Xotr69RVdjbKFMaVctCQmuSvnkMpXaGIdiMr0ZU582rbQFSZfQks/8XyJ+CzfPm0I+P0=
X-Received: by 2002:a17:907:1b0b:b0:ac7:4d45:f13e with SMTP id
 a640c23a62f3a-ace710a0eacmr947603266b.13.1745823074048; Sun, 27 Apr 2025
 23:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420070251.378950-1-guodong@riscstar.com> <20250420070251.378950-3-guodong@riscstar.com>
 <mzfiyc2me2smqrrmiymzkzxvsyjmst6ggy7scq4wxz2yfj2ef5@np3h3k467mbl>
In-Reply-To: <mzfiyc2me2smqrrmiymzkzxvsyjmst6ggy7scq4wxz2yfj2ef5@np3h3k467mbl>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 28 Apr 2025 14:50:52 +0800
X-Gm-Features: ATxdqUER8JSTuuOTantCFeixTZRLC93zvf7G5uIviwPU2QmuQNBr7asOpX-Fl3I
Message-ID: <CAH1PCMZ4hqYo9SLCnzHYp_EiQKs5nhgW3XpxwqLEk4eX8=vWPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] pwm: pxa: add optional reset control
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, 
	tglx@linutronix.de, hal.feng@starfivetech.com, unicorn_wang@outlook.com, 
	duje.mihanovic@skole.hr, elder@riscstar.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:30=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Sun, Apr 20, 2025 at 03:02:47PM +0800, Guodong Xu wrote:
> > @@ -49,10 +50,10 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
> >  #define PWMDCR_FD    (1 << 10)
> >
> >  struct pxa_pwm_chip {
> > -     struct device   *dev;
> > -
> > -     struct clk      *clk;
> > -     void __iomem    *mmio_base;
> > +     struct device           *dev;
> > +     struct clk              *clk;
> > +     void __iomem            *mmio_base;
> > +     struct reset_control    *reset;
>
> Changes like these are the reason I prefer to not align the member
> names. Luckily reset is a write only variable and you can just drop this
> hunk if you use a local variable for it in pwm_probe() below.
>

Thanks Uwe for the suggestion, I agree.
I will update it in v3 by dropping this hunk and using a local variable for
reset in pwm_probe() as you recommended.

BR,
Guodong

> >  };
> >
> >  static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *ch=
ip)
> > @@ -179,6 +180,11 @@ static int pwm_probe(struct platform_device *pdev)
> >       if (IS_ERR(pc->clk))
> >               return PTR_ERR(pc->clk);
> >
> > +     pc->reset =3D devm_reset_control_get_optional_exclusive_deasserte=
d(
> > +                     &pdev->dev, NULL);
> > +     if (IS_ERR(pc->reset))
> > +             return PTR_ERR(pc->reset);
> > +
> >       chip->ops =3D &pxa_pwm_ops;
> >
> >       if (IS_ENABLED(CONFIG_OF))
>
> Best regards
> Uwe

