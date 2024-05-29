Return-Path: <linux-pwm+bounces-2278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AA8D2D21
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C0C285B7E
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715315EFC9;
	Wed, 29 May 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L54PR1DW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154022F2A;
	Wed, 29 May 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963813; cv=none; b=dotISFpVBsU5B521/vont6GqOdvmQEWbdo32YiSSUPxuHue3kqT2/wSnyZH4F82AqE6YaSa1gVV8929hl2ZpUuBVi9TV8CGZMN/Z8XFh+wIwdQXLvx8rHaSUW4cONCkb7h4muur40dOFje5Sn8763+yrVv4Pts9AnCVymPOLtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963813; c=relaxed/simple;
	bh=GR+LKrFe+UUZWbY8bdBH7a434nQd0Kv7qhsQXr9RVgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djj9qPuzO4CTzED+FhPKH628JBayJ9f5UTY8vKR8LBS8h+9crulfJ4Vw65rRydfDbZaMzG3Gm46C34hQiEnUItv23xvlrJzFsvXL2f3lD5taqqPF165SMSaLLpIZfeMqvwXY0dXZ1J58SGwzl136axibKFq2JGxK/WUxfr+W8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L54PR1DW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6302bdb54aso229798266b.0;
        Tue, 28 May 2024 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716963810; x=1717568610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tLcHWmtFvs9Ytz0eoynxFRfwFldga+uWrm7x0FZZsE=;
        b=L54PR1DWEo8QAXFGRrliNpj8xE2ViPZcDlG5K4og2LBaFrSceetUovJ+ewBJOZ8bs0
         +Gg5lfElbYfixVkCsP3FOd4xR5K/89F4pe5HcRi1Jn+osGoIQiJNg3nm5WjvS0DukMog
         8cpIwNYv27kvQl+knWkR7cWFYYMjlZGwKuehVu4/slK1E66JGcxbMbC3irkydagw+i5H
         MWEjy/rRr+a0AakWdgNOIYjDtnLmvTwBmVopNkCtswp1I7XR22I35BEZ0jVrx1LhHPpp
         vZKYzKd6qnPBXp+aEqbhZjXjV5H7zB4dclxXjwVlcofmzhNwzoYTG5jYzCOpgBKajUGz
         XQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716963810; x=1717568610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tLcHWmtFvs9Ytz0eoynxFRfwFldga+uWrm7x0FZZsE=;
        b=b/gFVqILkGPxKHK4AMX9Z6jnjWX4MwosbSAqOtXEaXZ9aeUZxEeEi+VmGntmaeiWXK
         IqDax3CqWr4y7CETIudTHH0iXGKGkRSVjQiqUbUhXxGjerpNtLpENwpXnsjQ/gCze7I8
         5PNsVtCoiJRBQtmhi1hhV3wgYo9MWz7w5zSlHHqYlalRujiYFzj+OqQmZ4HHdEUJJISA
         AbXL4czWHY9MhIV3P6oYCbuhf7ehA2jxRBp9ovqRN/51uAPCCoB7++TwH05wa8/hytIX
         o1aLFRGOmqA6DR29bKpO3GsgpviSlmJPGweW2GLYfRNzYlBj0l0k4+/cIUanicZeJccW
         JGzg==
X-Forwarded-Encrypted: i=1; AJvYcCV8E4YWEhQojFXyH1XTXJnhOmrbkDp82lTWwwHejYAXThtwNf5ozlRBOp6P63sqk5IXLSjrkDoXgwXWe/mVNjyCqdyyglRGrPhDU/mEE/SxDqNeAw3tz230OiCsAC8MWmC9U0+1T619wDkp8jN7/eAk1Ur5RkUpiIgHJ7svsxfzWKs=
X-Gm-Message-State: AOJu0YxJ/vUWlQ06nxIBkeyaS8Xm6PqZ7gB1DizWoRHcfyBrqxqq0qCE
	nMgWRc8owTZ2SXLRvQWdvhjxeg0bWPDrPZyksw3aXkiM2/yhIxcVxyfQ1COai63DxQge+Vj18Df
	gr1MJMcMgg1RJNo/qd63mckaSjE/trWeL
X-Google-Smtp-Source: AGHT+IG9tZBZb32D7wJefFAQaqxEoTWHfC+q+AoH9WPW4aE941T1sGRfv0CXz76hM9Lhi/j3kfATv7dOpdHufQucW2E=
X-Received: by 2002:a17:906:314e:b0:a59:c319:f1dc with SMTP id
 a640c23a62f3a-a62642daa92mr970246166b.4.1716963810113; Tue, 28 May 2024
 23:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-5-laurent.pinchart@ideasonboard.com> <ZlYzf6mW8RF9w_R7@surfacebook.localdomain>
 <20240528202705.GD8500@pendragon.ideasonboard.com>
In-Reply-To: <20240528202705.GD8500@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 09:22:54 +0300
Message-ID: <CAHp75VfpNsSnyXBb6Oy2-qCYXPR9ROimWhC7yTosrKf4YXHciQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:27=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, May 28, 2024 at 10:41:51PM +0300, Andy Shevchenko wrote:
> > Tue, May 28, 2024 at 10:03:14PM +0300, Laurent Pinchart kirjoitti:

...

> > > +#define ADP5585_PWM_OSC_FREQ_HZ            1000000U
> >
> > (1 * HZ_PER_MHZ) ?
>
> If we had an MHZ macro I would use 1 * MHZ, but I don't think HZ_PER_MHZ
> improves readability here.

We have MEGA. HZ is already the suffix in this definition.

> > > +#define ADP5585_PWM_MIN_PERIOD_NS  (2ULL * NSEC_PER_SEC / ADP5585_PW=
M_OSC_FREQ_HZ)
> > > +#define ADP5585_PWM_MAX_PERIOD_NS  (2ULL * 0xffff * NSEC_PER_SEC / A=
DP5585_PWM_OSC_FREQ_HZ)
> >
> > Wouldn't be better to use GENMASK() or (BIT(x) - 1) notation to show th=
at
> > the limit is due to HW register bits in use?
>
> I think that would decrease readability to be honest.

I think it improves the robustness of the code. I always fail to count
3,4,5,6 f:s in those masks, using BIT()/GENMASK() notation makes it
better.

...

> > > +   ret =3D regmap_write(regmap, ADP5585_PWM_OFFT_LOW,
> > > +                      off & 0xff);
> > > +   if (ret)
> > > +           return ret;
> > > +   ret =3D regmap_write(regmap, ADP5585_PWM_OFFT_HIGH,
> > > +                      (off >> 8) & 0xff);
> > > +   if (ret)
> > > +           return ret;
> > > +   ret =3D regmap_write(regmap, ADP5585_PWM_ONT_LOW,
> > > +                      on & 0xff);
> > > +   if (ret)
> > > +           return ret;
> > > +   ret =3D regmap_write(regmap, ADP5585_PWM_ONT_HIGH,
> > > +                      (on >> 8) & 0xff);
> > > +   if (ret)
> > > +           return ret;
> >
> > Can be proper __le16/__be16 be used in conjunction with regmap bulk API=
?
>
> What I would really like is regmap growing an API similar to
> include/media/v4l2-cci.h. Any volunteer ? :-)

So, the answer here is yes?

...

> > > +   regmap_read(regmap, ADP5585_PWM_OFFT_LOW, &off);
> > > +   regmap_read(regmap, ADP5585_PWM_OFFT_HIGH, &val);
> > > +   off |=3D val << 8;
> > > +
> > > +   regmap_read(regmap, ADP5585_PWM_ONT_LOW, &on);
> > > +   regmap_read(regmap, ADP5585_PWM_ONT_HIGH, &val);
> > > +   on |=3D val << 8;
> >
> > As per above, can it be converted to use proper __le16/__be16 type and
> > regmap bulk API?
>
> As there are only 2 registers, I think that's a bit overkill really.

I do not think so. It increases readability (less LoCs) and improves a
lot of understanding of the hardware layout from reading the code.
Please, consider using it.

...

> > > +   device_set_of_node_from_dev(dev, dev->parent);
> >
> > Why this one? What's wrong with device_set_node()?
>
> See my reply to 3/4.

See additional questions there as well.

--=20
With Best Regards,
Andy Shevchenko

