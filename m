Return-Path: <linux-pwm+bounces-2276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874578D2CB3
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 07:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C78B28CE04
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95715CD43;
	Wed, 29 May 2024 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxJgCyS8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02715B98B;
	Wed, 29 May 2024 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961506; cv=none; b=hd5VDG/iPOm22McxYCWcrY4fNktP9E1CwfagxqysLc+bkm2ZowKRjlG+RJ5j5IsnZoR2z8hoDsUq4m3qemu57bNWcHfTRNlfb5cUnwF6qzoAXvhftw9/dx5Hck7djmmd+vWAsg+1CQy8HtIddkY55X2Ppjs1ofIZGDDJglP0ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961506; c=relaxed/simple;
	bh=cNGxdNuzdI5pKIB6QCt+zvjbCDD1qiXHOix5B2DCynU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unyFU+ZpPXMLmzB5zyUvNjH6MkkMaDJK4qalrP74o7e/qPxjDA0X1cbal4U+1AT0Mhnj/M4g1Q5/ABSh9DO+9kCaKhkbvyiD6HJKCnB6hBMV5oDuhHPiz0hfadum6vJW261i77f3CUkXnyCLE7LAnYsfcAcIgrhEftaqk7LBKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxJgCyS8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354faf5f1b4so1552142f8f.1;
        Tue, 28 May 2024 22:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716961503; x=1717566303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ4JX//TKbZ+BzdC73sUZxj+uGqXuXB1LCY+TXma+K0=;
        b=DxJgCyS8GrUzP++GE37DN5jzzC4SM/j7q48/BWnmn4SP/+LXsTCnZzSGSCuKkVOx7D
         nR+Aic5eOldIPNfvRdVxnDkgt/8TfERl9yVpq2joRq/18jhmgYqZYnT0VHySW0HQOanv
         a6joFTwZbQL7jiyJ5T1MCEx5AtMi1YPeT6r3ww7CLBrCpuzEm3x2pQYphR9+ak79htba
         Jq5Kn5N1aIzzo+d5gMHhBevonH4Al36/UB8N04ozWs3N33bIgLO6HUrm4NL5kde7fh0r
         rfRVPC+zBNGPrreb5+dHRXuK34MfEnUjePBbktHxIE/z7inxEHfJzl96h4F983H0wSVf
         q2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716961503; x=1717566303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ4JX//TKbZ+BzdC73sUZxj+uGqXuXB1LCY+TXma+K0=;
        b=qB7aupZu5iqgRe4NSIliPAl5PZXtUHnIHGtc/jUee5iiwHDx0UOV2ta2SIw+IWGYmB
         C8eEKueBqpURPXfQWnVHRHi2hsdhMoUOVYVjub56O738F25bxSOKZdo2wFdz9/n4qDuR
         ykYTmYJ9Br2+C/wUJO6oJ3yrJDdj06j0BSabNzoJ56eAvj05hlN6gqL3Kj940zZGJljK
         Ton5VDsanPvGI92T3HAjISmd+0ZWeoX3b4JpV6L4p38q01Kg0Bo5Kj/0vEd1wywzxL5w
         Cm1tGey6FA9gNUYT6N+qgfsQwy5SlZxlqhzLAV1WzOgeBAi/eJ/tsjb97TZo3NkoxvwF
         WXqA==
X-Forwarded-Encrypted: i=1; AJvYcCVdgkIQx7ri29juaeQmbXmX47x6OwwrRIAuvXwl1mFvDWKmTZ6mtYOXRuWVT2/FHMZt6BApM+77HlhPtxJcimCCEdR0t6sHQ1DwKTdF0lpaHmrnafnLRTagOSXXzxLWmwUKR5SC+mqPJcpgED/806D8oEhjvDk4yD1i9R7KHsxUcec=
X-Gm-Message-State: AOJu0YwrK77MsQizE61grd+k6tBTCoGHwnVn299p4yjldU+8Xr4usyUY
	sGZWLUarqLyRHp2c6/Ka5HvdNZbhcRvJjanqZGUR2xoa2ymXd88YKJW3afVyw1DDrRrvNDut6uk
	iAS2OA4ALd6pid/E2mAPOM/f2OAg=
X-Google-Smtp-Source: AGHT+IEmXk1ClteOR0CXKb9UTg4kb3FWdCF1Ad1K0lkWzsKgMLOcTXlTYdT2PrlfOVMArx9qthbIYIGvqvAjdH792vw=
X-Received: by 2002:a5d:408d:0:b0:355:4cb:5048 with SMTP id
 ffacd0b85a97d-3552fe02949mr12133703f8f.43.1716961503182; Tue, 28 May 2024
 22:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-3-laurent.pinchart@ideasonboard.com> <ZlYwJryxeZ2LAKYG@surfacebook.localdomain>
 <20240528201326.GA8500@pendragon.ideasonboard.com>
In-Reply-To: <20240528201326.GA8500@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 08:44:26 +0300
Message-ID: <CAHp75VeHA8qH_S=KJjAMv24vGP=hmeN9wSt1_NPsRhBZfEYXXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: adp5585: Add Analog Devices ADP5585 core support
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

On Tue, May 28, 2024 at 11:13=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, May 28, 2024 at 10:27:34PM +0300, Andy Shevchenko wrote:
> > Tue, May 28, 2024 at 10:03:12PM +0300, Laurent Pinchart kirjoitti:

...

> > > +   depends on I2C && OF
> >
> > Why OF?
>
> Because the driver works on OF systems only.
>
> > No COMPILE_TEST?
>
> The driver won't compile without CONFIG_I2C, so I can use
>
>         depends on I2C
>         depends on OF || COMPILE_TEST
>
> Do you think that's better ?

I think that dropping OF completely is the best.
OF || COMPILE_TEST would work as well, but I still don't know why we need t=
his.

...

> > + array_size.h
> > + device.h // e.g., devm_kzalloc()
> >
> > > +#include <linux/module.h>
> > > +#include <linux/moduleparam.h>
> > > +#include <linux/init.h>
> > > +#include <linux/slab.h>
>
> I'll drop those 3 headers, there's not needed anymore.
>
> > > +#include <linux/i2c.h>
> >
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> >
> > You don't need them, instead of proxying...
>
> of.h for of_device_get_match_data() and of_match_ptr(). I'll drop the
> former, but I need the latter, so I'll keep of.h

Why do you need of_match_ptr()? What for?

> of_device.h for historical reasons probably, I'll drop it.
>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/mfd/adp5585.h>
> >
> > m is earlier than 'o', but with above drop no more issue :-)
> >
> > ...just include mod_devicetable.h.
> >
> > > +#include <linux/regmap.h>
> >
> > + types.h // e.g., u8

I assume that all marked with + in my previous reply you agree on?

...

> > > +#define            ADP5585_MAN_ID(v)               (((v) & 0xf0) >> =
4)
> >
> > GENMASK()
>
> This is not a mask. Or do you mean
>
>         (((v) & GENMASK(7, 4)) >> 4)
>
> ?

Yes.

> I think that's overkill.

Why? You have a mask, use it for less error prone code.

...

> > > +#define            ADP5585_Rx_PULL_CFG_MASK        (3)
> >
> > GENMASK()
>
> Not here, as this value is meant to be passed to ADP5585_Rx_PULL_CFG().

Why is it marked as a mask? Rename it to _ALL or alike.

...

> > > +#define            ADP5585_C4_EXTEND_CFG_MASK      (1U << 6)
> >
> > > +#define            ADP5585_R4_EXTEND_CFG_MASK      (1U << 5)
> >
> > > +#define            ADP5585_R3_EXTEND_CFG_MASK      (3U << 2)
> >
> > > +#define            ADP5585_R0_EXTEND_CFG_MASK      (1U << 0)
> >
> > > +#define            ADP5585_OSC_FREQ_MASK           (3U << 5)
> >
> > BIT() / GENMASK()
>
> I'll use GENMASK for the masks.

For a single bit the BIT() is okay, and TBH I don't remember if
GENMASK() supports h =3D=3D l cases.

--=20
With Best Regards,
Andy Shevchenko

