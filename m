Return-Path: <linux-pwm+bounces-2277-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173328D2D0A
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4924E1C24027
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 06:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF515EFC7;
	Wed, 29 May 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGTSurKp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEC15B124;
	Wed, 29 May 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963443; cv=none; b=Lj4rjOLcbBgGX68YLNaHg9HCM3/6kNomYQlPc2TwkuS6mDIHbvGzHy4izvZX29TbhpPvfDAgcYny3J2X/2XtL0sk9Cd+qExVAHE402FLeX8AZNqKN7gnLonftLjppDic+x9Qdb5ilakWyhgJqv1gFZum1Pyk8X1XrfY4ieENifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963443; c=relaxed/simple;
	bh=wHvqAUeMGgo6S8SfrtOUu1hNJk5CbIEx1+ZZ5PXh9hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZbsPmMQjlsUb7ipfcOJ55t7q9PJyzYNb3TKrFH3x2zolkAzwbiI3tws4v5W/hMXHIpfX/n5eCH8G6B20R+vwHfMweHfT8dUTgclOqDS9rtGRJPftxeeVAMLVlY76tZst3pnFPbHVmxXyQy4NKyGjjblNcQIiheCp/r6royDMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGTSurKp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a609dd3fso99463666b.0;
        Tue, 28 May 2024 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716963440; x=1717568240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saVQL0reWoLiHVwsjX27qoU6xlrMeCDz+f6iomHsQmE=;
        b=IGTSurKp9m/aThm+faMczdlgKDFx8/aq0Dhoewu1yUlbd81y8YCHsbqkefP4Ivqwp3
         fQ5f4qFR5zHMyFLDh26UaKHs4mk7Zx1JWoldcQ3+eOQYMCd2feS69ToC5N1hNm6ONR/2
         ydeztbPMhxSP85LHowjwh3KaqhUR/q7oycOHUPLAeV/BvZnsOoXOXHqX/etcLtqfpF3n
         rcGhI9kiJw0qtxMMxXfHLlKL4MPvqCpvP0/qCLeYQW04YSnyXKOfLxYcN9Mg4R/zg+jR
         Gy3TTSIii+QiL7WYqq9RRVZVN+btvt3h18tEyR3P7Ua2W3hJGT1hcX2T3astdYdlceZV
         nxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716963440; x=1717568240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saVQL0reWoLiHVwsjX27qoU6xlrMeCDz+f6iomHsQmE=;
        b=AktKdOBrczAEpcGEif/l1UQzJd6nDtI/oEWD4ibP+IILWkHbxtZpgQ5sX7HWKHa0nq
         AD3CAcsGPJzApBQvpirMA9cfeLU+DOx6wvoVK8OJ4oJEaEX/papCSSt78GKZ/JFbGba6
         uIum8LegKNggMmtAHaw19g4mk58c/Wd9SuhMV7UmknjOwnPgoAPw6EJgWkE+OeGTnjIO
         iBUGPBCSePkVE7cpvysSfI0/I5py+0wLBaOPFS995yyGeuylNA7ARYiPjTSJcnBw+lgf
         zf0NtJ9V0jxhKpbtZKZ3fq4Jm+CtaC4zOHMmpg4rhyMApo2mzlVORhCIxchcxru3frYH
         ViJA==
X-Forwarded-Encrypted: i=1; AJvYcCUA5SgXs3CzPAFRnpABBj9buZKlObH6IEC3+HMEl4AsSQOexMmklUG9BBLrcMi6qN2f8FbStstA3AIE7qd12yiRgYsT2zxY0xI/wgcZRz3v7ZeC5zw2VQHsWnPoTUewzg0W+GHJpy1QkpRh+gJYUlUZgJZRzZMmqkzpiIjNxPp28ek=
X-Gm-Message-State: AOJu0YzExcPFapAuvswagy5QMcB62y3vuWK9uCJzpR1WFBG98ty+a0tT
	5H1IF2ik7zGwy8RIG9aBofSCl4/Ah1rzGmPukurYceCeqJjMTRfIdPa3Frd472BgSffb/2PXx7W
	/55K4rmvSH+gJlp/Lxsu4P7SMC6s=
X-Google-Smtp-Source: AGHT+IECFXdOSBQ6/aZ4435KqpAo2/qcF1vE8EyUqs/8Q495km6FzJ+Hh4GC/X4E3l953YMk17jX7QDlTUI8rsWphKY=
X-Received: by 2002:a17:906:3989:b0:a63:560d:fe0f with SMTP id
 a640c23a62f3a-a642d37e307mr97014366b.14.1716963440200; Tue, 28 May 2024
 23:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com> <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com>
In-Reply-To: <20240528202044.GB8500@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 09:16:43 +0300
Message-ID: <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:20=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:

...

> > > +   bit =3D off * 2 + (off > 5 ? 4 : 0);
> >
> > Right, but can you use >=3D 6 here which immediately follows to the nex=
t
> > question, i.e. why not use bank in this conditional?
>
> The ADP5585_BANK() macro is meant to be used with ADP5585_BIT(), for a
> set of registers with the same layout. Here the layout is different, the
> registers contain multi-bit fields. I can't use ADP5585_BIT(), so I'd
> rather not use ADP5585_BANK() either. I have decided to use > 5 instead
> of >=3D 6 to match the R5 field name in the comment above:
>
>         /*
>          * The bias configuration fields are 2 bits wide and laid down in
>          * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4=
 bits
>          * after R5.
>          */

First of all, the 5 sounds misleading as one needs to think about "how
many are exactly per the register" and the answer AFAIU is 6. >=3D 6
shows this. Second, I haven't mentioned _BANK(), what I meant is
something to

  unsigned int bank =3D ... >=3D 6 ? : ;

...

> > > +   struct adp5585_dev *adp5585 =3D dev_get_drvdata(pdev->dev.parent)=
;
> >
> > (see below)
> >
> > > +   struct adp5585_gpio_dev *adp5585_gpio;
> > > +   struct device *dev =3D &pdev->dev;
> >
> >       struct adp5585_dev *adp5585 =3D dev_get_drvdata(dev->parent);
>
> I prefer keeping the current ordering, with long lines first, I think
> that's more readable.

Does the compiler optimise these two?

> > > +   struct gpio_chip *gc;
> > > +   int ret;

...

> > > +   device_set_of_node_from_dev(dev, dev->parent);
> >
> > Why not device_set_node()?
>
> Because device_set_of_node_from_dev() is meant for this exact use case,
> where the same node is used for multiple devices. It also puts any
> previous dev->of_node, ensuring proper refcounting when devices are
> unbound and rebound, without being deleted.

When will the refcount be dropped (in case of removal of this device)?
Or you mean it shouldn't?

--=20
With Best Regards,
Andy Shevchenko

