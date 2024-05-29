Return-Path: <linux-pwm+bounces-2292-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE78D37ED
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218611F2157A
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784DF17991;
	Wed, 29 May 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRU53TuQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1014AA9;
	Wed, 29 May 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989960; cv=none; b=qiRfQcFLPN/RWXQGyCaJBbVWZLJbZDfde86jJzO9JLPmzZpDxL5kIg+BpRD1QdXulFHR1LP/LPJ/nGUIltPbeOnbdRHwSwJwjODzWKfqQvAAdAOjJd9XKSmvPbiNOjuuXLOmoRjD/R1EI1yYFs4iKZUA0v3sNkcE5MCxjrSpZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989960; c=relaxed/simple;
	bh=R3h5tSBPfEHGlt3Qf5kTWfRHMfookplRqGhxVq0OW2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnVAOPq0ELV01zqga3EvSPGzWGdWuOJGGCALYiJcsPPLYaNAn6D+u3elK4c45J7aYKsFEvLqRcydFaNRh86cM05MNo4jtwL03tWbduIUzslRr0FzWx1cxeGIPR48fO0NrtqC1N3DOgasdP1v1bKy1NWzU49PzI/l7qCXzZC4uos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRU53TuQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-529614b8c29so3362328e87.2;
        Wed, 29 May 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989957; x=1717594757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OSOPo7Lbda7dPzDxelwiNRlHm/oYGM0dTgvUx1nRbg=;
        b=VRU53TuQHJIY840hcXzPUGBWV5XKo5psl+MfCFGMiubddH3c+W6lmzQgbFJx9GN39N
         cBCMX3C5wX/rW8Wg7od8WRfBRyccxhC1ERJB3RlElph6UcShO8CwXBBF2lPzACHtI87u
         yYOn9jh2UYK5bliR9wM/O8qT3gtVaFJlKjCwtI0M2a46Cew3VBztgPUmJxnCWqGmaeob
         EKeuphOMzSh5jx/B4jfBTceA6sCyIEg8rIpyOZWUJ1iXUTmWengessqxdnSJp7czKGKm
         17MnZj4OwMKNEDWr8fI06nt3IynIZPBJN40jhzgOEhOV+eGJC5zPXv53MdXl3MMRQQtn
         +y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989957; x=1717594757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OSOPo7Lbda7dPzDxelwiNRlHm/oYGM0dTgvUx1nRbg=;
        b=pouTgx0qkl5VqxIclebWLZlxFq+yXncBg3CNBfxZjDHW/n56ClnfYgare7zBLm9Eqm
         V+EvDBBO1v8y0ttuy0rb9G/ddgsJJNSleJHJv8zm8SNjDcFvXa+yqga5Msh+p0kfkUG7
         FkfHDGWXMBSD21aSEsQEzicQyMcn0LEpsTkBJc3oWQcMizvtXetu20slGI/KHRQX3e1t
         BzlYVpmzEXsHkEEn8uultsak5N6k7TWlQL4aG/oBjvrDcA3QJGQXhnGDbXjv+IHL/LBR
         TN5m/LWUH/wCwEn7A/LANcDEnkJWDGuilD2JxBpWJ6gyW7yX3ONcQPQ2czn7+2ZT/KTT
         lRPA==
X-Forwarded-Encrypted: i=1; AJvYcCVdzE4kezQct5F7/4rIup1Jw8J7P4vfmo212lHj3ic753dyJN/JreYfQEs+7vIoAghPLaq1aAJkfN1U4omE2uL1IjDt0tf4BN8C0Ay3D9RUk5FbBuDL7GyoDwpvzJWrylR4e2/cZ3uGQPNY/5iUqrGiwmoluWb7LQoc20bll4ooDHQ=
X-Gm-Message-State: AOJu0YxhIVekDoLoVjF45/XqgIop2lzKpOoEBfndn/TkXC/ycNc3a71w
	j5snbZ65ePeO3uLIx0lUT4oRJkR4WY3AoXoFyM1GF/vXx1XU4Mc7ck6GSkLqN28scaTxPJyWa7L
	jfag4iGW9Jya6qOHgYFv5D/pou2iAj/XX
X-Google-Smtp-Source: AGHT+IF/Mx+aeQaDKWNtONCluGWzcUX4rpkMKxmKVHQ27MIk0ibKAqPWIDbQ7NzwC9rfk9DG3bxn038hq6LXNmgObN8=
X-Received: by 2002:a19:ca01:0:b0:51a:df97:cc8d with SMTP id
 2adb3069b0e04-52965a421acmr10862970e87.26.1716989956613; Wed, 29 May 2024
 06:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-3-laurent.pinchart@ideasonboard.com> <ZlYwJryxeZ2LAKYG@surfacebook.localdomain>
 <20240528201326.GA8500@pendragon.ideasonboard.com> <CAHp75VeHA8qH_S=KJjAMv24vGP=hmeN9wSt1_NPsRhBZfEYXXw@mail.gmail.com>
 <20240529093541.GL1436@pendragon.ideasonboard.com>
In-Reply-To: <20240529093541.GL1436@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 16:38:40 +0300
Message-ID: <CAHp75Vf1EgHOs2jBZPWtX7PdaNcEX_J4wX_aXDehNgxhDf39dw@mail.gmail.com>
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

On Wed, May 29, 2024 at 12:35=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, May 29, 2024 at 08:44:26AM +0300, Andy Shevchenko wrote:
> > On Tue, May 28, 2024 at 11:13=E2=80=AFPM Laurent Pinchart wrote:
> > > On Tue, May 28, 2024 at 10:27:34PM +0300, Andy Shevchenko wrote:
> > > > Tue, May 28, 2024 at 10:03:12PM +0300, Laurent Pinchart kirjoitti:

...

> > > > > +   depends on I2C && OF
> > > >
> > > > Why OF?
> > >
> > > Because the driver works on OF systems only.
> > >
> > > > No COMPILE_TEST?
> > >
> > > The driver won't compile without CONFIG_I2C, so I can use
> > >
> > >         depends on I2C
> > >         depends on OF || COMPILE_TEST
> > >
> > > Do you think that's better ?
> >
> > I think that dropping OF completely is the best.
> > OF || COMPILE_TEST would work as well, but I still don't know why we ne=
ed this.
>
> For the same reason that many drivers depend on specific CONFIG_$ARCH.

It's different. You may not do in many cases the $ARCH ||
COMPILE_TEST, while OF || COMPILE_TEST should just work in 100% cases.

> They can't run on other platforms, the dependency hides the symbol for
> users who can't use the driver. This driver works on OF platforms only.

What you are talking about is functional dependency, what I'm talking
about is the compilation one.
So, it's a pity that Kbuild doesn't distinguish these two basic
concepts in dependencies and
FOO || COMPILE_TEST is basically an artificial hack to tell "hey, FOO
is _functional_ dependency, I do not care if I can compile without
it".

...

> > > > > +#define            ADP5585_MAN_ID(v)               (((v) & 0xf0)=
 >> 4)
> > > >
> > > > GENMASK()
> > >
> > > This is not a mask. Or do you mean
> > >
> > >         (((v) & GENMASK(7, 4)) >> 4)
> > >
> > > ?
> >
> > Yes.
> >
> > > I think that's overkill.
> >
> > Why? You have a mask, use it for less error prone code.
>
> I'll change this to

...

> -       if (ADP5585_MAN_ID(id) !=3D ADP5585_MAN_ID_VALUE)
> +       if (id & ADP5585_MAN_ID_MASK !=3D ADP5585_MAN_ID_VALUE)

(Don't forget inner parentheses)

...

> > > > > +#define            ADP5585_Rx_PULL_CFG_MASK        (3)
> > > >
> > > > GENMASK()
> > >
> > > Not here, as this value is meant to be passed to ADP5585_Rx_PULL_CFG(=
).
> >
> > Why is it marked as a mask? Rename it to _ALL or alike.
>
> It's a mask, but used as
>
>         ADP5585_Rx_PULL_CFG(ADP5585_Rx_PULL_CFG_MASK)
>
> We're reaching a level of bike-shedding that even I find impressive :-)
> As with a few other of your review comments that I think are related to
> personal taste more than anything else, I'll defer to the subsystem
> maintainer and follow their preference on this one.

I would name it _ALL and use (BIT(2) - 1) notation to show that you
want all of them to be set. But okay, let's leave this to the
maintainer.

--=20
With Best Regards,
Andy Shevchenko

