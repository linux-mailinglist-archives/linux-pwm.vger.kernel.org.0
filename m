Return-Path: <linux-pwm+bounces-139-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0087F43FF
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 11:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14586281482
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A262751028;
	Wed, 22 Nov 2023 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ieMzyl7T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939FB93
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 02:36:31 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4ac0d137835so2316381e0c.2
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700649390; x=1701254190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9RyNwxUxAvjA0TdUC6Ufzxi+Ut58Ntu1Up0AV6WgKU=;
        b=ieMzyl7TAhyKFXSmDYqD5vkpxRPq8wOgOrvht8W4YJPXccaCYXBorw1AWtnQtAteBb
         V3MbZbw2/kaCwG8TwPhITHMzHaXT/RFgmVE2UeA7a/7sTGPdZc+c/7TAjhULVWKQXUoD
         ifHrQWE9Q1Y53aGDnsMugvmD7lA2UQiuXd9PLA84l4qe6BPIhuUHnPU8ZtQCG4UBImtZ
         W6c2atutvPGfRVLo96SJrUuApSPE+LstKe/mxFZBt4bRmTgpNxrXzBsVkMithztvWiyy
         AX2g2joqTT6/gJ+DRMtXM7pTxv5oj2kkfVbo9CPOotVMYtBnh+uMXlUhU69r0wbKkgO6
         wDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649390; x=1701254190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9RyNwxUxAvjA0TdUC6Ufzxi+Ut58Ntu1Up0AV6WgKU=;
        b=fi+LxtKQdYsu4fSVlT0Hk4/Fts6yHIZU1kSY7Qs2k78lFrWenz0AFMc6g8lcEOUt8a
         AIojsGSHt5zkeJtl49g/BsI02cPWTGZGyT+x3wqm0USHLOG+Cwvbuf4Su5Wx69tYh+7H
         5uZrxYsZQhJxm2x4E+QULw5os7Z+m7orxHIWrK47yYdHkX2RKk6/lEdGiMY2LlznTOBg
         0b2syuRj50nKmfhzW5pYMvY+U+D1/hAixbHdJjoihpp8NJ1eUFr52eetyP4LSxYRMNUI
         jyK6Bp9gO65Pig6bi2e5fIklMeYpn7UQLbyxIxtkrl4V+OWKJGSq/d5DfpYyXN6zsVB9
         q0QQ==
X-Gm-Message-State: AOJu0Yx7rweYtjSIZuliAm4D3dvckMUumEk75UmalFFNHWqu+fH8qv2s
	dG8Nr7Le0ODeN7epwIo7R8UVc5aJpAlkh2pT36bXow==
X-Google-Smtp-Source: AGHT+IGBmf9hKkcw0T0mIrzTDLT0xt+Rd6Nod7NHY12KYAvmvBBQlY44CbfzsUYMzXlVL26LHzu7CyU/JturzSt0+Vs=
X-Received: by 2002:a1f:ed01:0:b0:499:dec9:e1a8 with SMTP id
 l1-20020a1fed01000000b00499dec9e1a8mr2060220vkh.14.1700649390653; Wed, 22 Nov
 2023 02:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de> <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
In-Reply-To: <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Nov 2023 11:36:19 +0100
Message-ID: <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Bart,
>
> On Tue, Nov 21, 2023 at 05:11:11PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wrote:
> > > Eh... I had a talk at LPC where I explained why I really dislike this
> > > approach but I guess this ship has sailed now and it's not a subsyste=
m
> > > where I have any say anyway.
> >
> > Is there a record of your talk? I'm open to hear your arguments.
>
> I found your slides at
> https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Linu=
x%20Plumbers%20Conference%202023.pdf
>

My talk is here: https://www.youtube.com/watch?v=3DVxaAorwL89c&t=3D29310s

> The main critic as I understand it about the "alloc_foo() +
> register_foo()" approach is: "Breaks life-time logic - the driver
> allocates the object but is not responsible for freeing it".
>
> Yes, the driver allocates the object (via a subsystem helper). It is not
> responsible for freeing the object, but the driver must drop its
> reference to this object when going away. So foo_alloc() is paired by
> foo_put().
>

Is it though? I don't see any pwmchip_put() being called in this
patch. I assume it's done implicitly but that's just confusing and
does break the scope.

> The solution you present as the good way has the struct device in the
> foo_wrapper. In GPIO land that's struct gpio_device, right?

Exactly.

> gpiochip_add_data_with_key() allocates that using kzalloc() and "frees"
> it with gpio_device_put() right? So your approach suffers from the same

No, the structure is allocated by kzalloc() but it's life-time is tied
with the struct device embedded in it and it's freed in the device's
.release() callback when the last reference is dropped.

> inconsistency, the only upside is that you do that once at the subsystem
> level instead of in each driver. (And in return you have two allocations
> (priv + foo_wrapper) while the "alloc_foo() + register_foo()" approach
> only needs one.)

Memory is cheap and this is not a hot path, so it isn't a big deal.

>
> Let's just rename foo_alloc() to foo_get_new() and the problem is gone?
>

Nope, because from a quick glance at PWM code, I'm convinced it will
suffer from the same hot-unplug problem I described in my talk. In
which case this rework will not fix all the issues.

> In the implementation of foo_get_new() kzalloc() is still paired with
> put_device() in foo_put(), but IMHO that's fine. The responsibility to
> kfree() is traded to the struct device with device_initialize() in
> return for a reference to the device. That's something you won't get rid
> of while keeping the concept of reference counting.
>

But if the PWM driver is unbound with users still holding references -
do you have a mechanism to handle that?

Bart

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

