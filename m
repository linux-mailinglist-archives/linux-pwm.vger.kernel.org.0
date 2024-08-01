Return-Path: <linux-pwm+bounces-2958-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20AA9454D6
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 01:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62721C22DE0
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4414B96F;
	Thu,  1 Aug 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6i2B2Uj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24A25757;
	Thu,  1 Aug 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554148; cv=none; b=Xfy+w/D04s+RuNMfoL4AP77kErZN9k8DLhfCNuFlIkh9cKryUjJ2YUSrVTXIT/qCVfsVg/3fSoeruwBOlPXKqvOYPRZqJXE5CuvaxiBPw+uzvkrKuaMOpmbMN3aDAw0LDfOpu4gBnAPtp1QgqKmwVZLdIwIojP/uQFgwwnZzksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554148; c=relaxed/simple;
	bh=xIEY5rR27yn9RRp2zVKcZiobCp0yYZORKifs1EvpsbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nsc3BoJgr2KrJCbOOLKy0INcUrgP95AEordeU55d6NSDI5yZnLM0I94R4BvZ4r8gg/2Pcexqh0V/dTmmi29lQhR1J5wb+tibZIbd3C38nNqZovKlNrOR7fdxj6lu6h1cLq6lTYyT1ncJK9DdViFWIMySOh7dNS1wKl/X+9rDX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6i2B2Uj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so11250630a12.0;
        Thu, 01 Aug 2024 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722554145; x=1723158945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLRwfCdQETkjG/YfGs/h8tG3G0CkshB0kpr2NbWcQ+o=;
        b=a6i2B2Uj3BSFP9MiyrTJGX12jCwKwQomiV4eRW6hJA2ZDy/prUuBkKhnkvS/JSFbRH
         972ythlDuFQ3M1OVw02Z9BUR+kVeSS1YGPMTgSGUJLSPKpHPbhp7PAgH78DvG1JjIt6R
         4lY+VL4ca1r8pza60IapnqErqqkYf/hmmFKPSxrTDMv3i1oU/jmBJqs0T7A2eNkNAWTa
         fOWqzRN2TFcBC0XioCqfWcOJ7aLpWh4gma8ZknSKlmYxFiQsqMP1qsjoi2GG/JD1yV+l
         7Y+mzqtK5iXu9I1A9r3DjtW2fNlm46VqNXLLf7JvWMye3RQpXl4GqimNj0EuJ1aCkJAn
         5bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722554145; x=1723158945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLRwfCdQETkjG/YfGs/h8tG3G0CkshB0kpr2NbWcQ+o=;
        b=wEQXOakNHWP6bG6HGdGWirBuVrSCCLgWlkUBf7vntVCNa3y8XSImTR1gpU6Dxzjdtj
         NeuKT6bC4sPMKbhn7/XfsVZUdP57rYNLrY9RzFQt1lS8nhH6Yc74p3dSiqx77n439ULM
         J8vqaGkN8bfPSQCiuQz3Jlt3Vza5oLhHjA7CJoLDSju54td2gNRsXwAi2G6w8w5S5l/Z
         8AsfV0hxhlxBq+ZMUVZCW7xVv3UnsKinq1B/7vaBBxgsfEiLq2kaOyvXC38fzbg0CTK9
         T6q/ubIq/5+czYZoW0Y7VWy1sj/Qm7m9nNQxJpQ/ou0Xqr50oQhFjKDH92/VzVNVTsER
         xEwg==
X-Forwarded-Encrypted: i=1; AJvYcCUMGk7Ez16DKhUVJeTEaMcs78YcXhH6+0pDvTPP566LzmCbI0PTF92zFhAIiCAI/eRkvbPgnGgS3W0LGzgktLJxXoBr+4TVq1IuunnF/NCcGAu+pm84KYdQw0UG9VOtcCsiGJ4LlveMXN+30C+au+FJ7pibNpRirgKjbDzUHor/OU4=
X-Gm-Message-State: AOJu0YyfiWHQu1xc3MZJtpMR4y0tGkI0hpOzMF8iK1bDzdhqmxfvnFbt
	AETiC8Mvaj0fZHeL/cn4NSeV6WRYrHEhpgouSJ39jkkDtWt9vlKFHXWQPqf7upuYDEq8XJSijrA
	I5uQBmuEpn7+hSF00FJ+50vWn2nc=
X-Google-Smtp-Source: AGHT+IF/hswnChnebe6R0QxeY5fSBqmjf0O5AvkNodYLB4It+AENYyQZH6xf825LuQTBN2qV8LOyreT8EtTt1azveJw=
X-Received: by 2002:a17:907:3f13:b0:a77:cc6f:e791 with SMTP id
 a640c23a62f3a-a7dc4ff1addmr151484266b.38.1722554144535; Thu, 01 Aug 2024
 16:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-4-laurent.pinchart@ideasonboard.com> <ZmcYnDf0YIWA9A85@surfacebook.localdomain>
 <20240610152555.GV18479@pendragon.ideasonboard.com> <CAHp75Vd-TZYsm+fe+o1XvDYGHO6sDqZhMFqojowRx2scwxEhLw@mail.gmail.com>
 <20240719135515.GB637@pendragon.ideasonboard.com>
In-Reply-To: <20240719135515.GB637@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 Aug 2024 01:15:08 +0200
Message-ID: <CAHp75VdztEuQbvEbirrzqYOdYjNrJADgwC5O40fU_BzsxEmWXg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
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

On Fri, Jul 19, 2024 at 3:55=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Jun 10, 2024 at 07:29:09PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 10, 2024 at 6:26=E2=80=AFPM Laurent Pinchart wrote:
> > > On Mon, Jun 10, 2024 at 06:15:40PM +0300, Andy Shevchenko wrote:
> > > > Sat, Jun 08, 2024 at 05:16:32PM +0300, Laurent Pinchart kirjoitti:

...

> > > > > +static const struct platform_device_id adp5585_gpio_id_table[] =
=3D {
> > > > > +   { "adp5585-gpio" },
> > > >
> > > > > +   { /* Sentinel */ },
> > > >
> > > > Drop the comma.
> > >
> > > I prefer keeping it.
> >
> > For what reason?
> > The sentinel should be runtime and compile time one. Why should we
> > make our lives worse by neglecting help from a compiler?
>
> Do you really think there's a risk here and that this will make a
> difference ?

There are two aspects (or more?):
1) potential mis-rebase or other thing that makes possible to have an
entry _after_ the terminator and having it being compiled
successfully, while we may prevent this from happening on the
compilation phase (as you noticed this is quite unlikely to happen
IRL);
2) educational part, as somebody may use your code as a good standard.

> I do appreciate most of your review comments, even
> pendantic ones, as they can help making the code better, but we also all
> need a little bit of space to breathe when it comes to coding style.

Some of the coding style decisions can be considered slightly better
than others. I have a rationale for this case. But of course, it's up
to you and the subsystem maintainer on how to proceed with this. I
wouldn't take your breath away.

> > > > > +};


--=20
With Best Regards,
Andy Shevchenko

