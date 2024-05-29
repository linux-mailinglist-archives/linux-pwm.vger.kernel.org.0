Return-Path: <linux-pwm+bounces-2295-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839C8D3A28
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 17:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E6F1F27CCE
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE415B0F0;
	Wed, 29 May 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcCYzveP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503DD2F0;
	Wed, 29 May 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994859; cv=none; b=IjulY4HUF/WQRvhy6DoinA6nVuiMvFU0exzI1mR1XyQ5z9VhmCVUs2FbIaVdaw8e9H3EE1P+4lgMnlX3sRN6kl3CEgBVY5/YRgon3AnqopFNN41P2ejiv8yID2xhPfBGZWDNsW8yta2lC1UM+SN/vmU8I+5pC4djajOPTKoPXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994859; c=relaxed/simple;
	bh=KDl1A+b14YwNPvzKH7rRyqbVu74d+eFfHz2Qf8NT9hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz7dy3bNtLzyNffQp2ZslvbosbKV2Ovg0MP+cWMFymtzgDBs6MVjNdeiqbn3f5rAOGvAUh/Uzdl30zMVlqNh3Z9f0KcZ/3fixjPFrGVlF7H38OzTdezDt5H1e5nOFTHJOPyp0qteUDvPZDZUj5qo4Y0dKJSI6D3AsWh6JvHy8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcCYzveP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626777f74eso262064066b.3;
        Wed, 29 May 2024 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716994856; x=1717599656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVzJGfLugCHBPVPfzknxVSczkezyisYb+0OUSIk9GzA=;
        b=dcCYzvePYHOpSVljsyJhM845ze5kgaM9yLI3bLtdLQV8L5UletoLaW6KR3pC54HGrf
         qYESLB2bSfCe4+Yya/WrQUB/cCrc/VQcDPskheb6mh0xoB8/jqmZsAw8pW+63wmZ57ZI
         t9P+yUpuCRdKEV2x7LQwn0HGtE00vUzy1sQSgBZNbizbVz/JHu7gqXjPEe+o40+5yZCI
         wEP+xfiblPN0NUNxYwd1xwGOgHgdnfuTYd3Z6HELqTNLF18dLKJ61Ppg2pFvN80y4KSK
         flGMcm71F88aa5WMFOlkktkbXLOPBix94P1w2mwxFzC0w2DSqElVenpZBtNepZM4B73M
         dV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994856; x=1717599656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVzJGfLugCHBPVPfzknxVSczkezyisYb+0OUSIk9GzA=;
        b=jpS8VZhQtjtTLLIbLNaQ52J8V+2vFDPWvlKXWBy43DaDJ/2cT2b71MkKz/bhxqGbTx
         Cm9zSw52anaym7k75sq4sInlxmKL4SDVCLPlcOyzC//QGC8dSalGJ5CX12sLpmMruzaC
         iMT/7H26uUPSQikdLhBLBAOVF1WlcWytISut9UNw2/NKUM5sC5RQgPNMvqJdzkx21Rkb
         B3IgxHZcaMrlsT+RripnpYFpfG5eWTyLJv4es95pDgUSiGwlPIS5BkbQ8ocbIjd7Uga5
         BMgohOlTqH7gidDi1Z1xNJNMfut6jli0B24WaljuS+obcOtLL0zlkDhaeQI0Bgxv9X/N
         oAWw==
X-Forwarded-Encrypted: i=1; AJvYcCWusEUf+7uHuIDZQlwt/AP5zx0HYzc9PRSChvHhhwD0VEJ7pM63dLx/3x+Qu8lrhATWP5zGrqOihixuCPn0BukNdPouOa9GQWY+zvEqlBHdgBCRBotpikMAO7n2Q/ncCW0BW4B/LjcA97sLB5jePjTVuxcgm80b8s/KbxRsHZKs6Wk=
X-Gm-Message-State: AOJu0YzNxCJ6EOvt5v9WZxZLQCSpH9/DU6c9t8C0K5GHQgqWqG4RFpF1
	7THCGd35NR+zKLJ4U3XuQI7rmVcjZz4ZZ4eSm0Gss2zq6L67COyaDZqeflqjn1H0hubXAHl/bA1
	UPjS7Hvk/gxUpQ69greXtYaaHalk=
X-Google-Smtp-Source: AGHT+IGGGoejBmACljG2rzCaUQiTEesPkAzzYqerU3hW0uHhh0rtp8XuLnXmznrkeSrNjNw+QxB2CngEtljbZVCWN1g=
X-Received: by 2002:a17:906:36d5:b0:a62:832a:e2c9 with SMTP id
 a640c23a62f3a-a62832ae3bcmr1310787166b.67.1716994855792; Wed, 29 May 2024
 08:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com> <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com> <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>
 <20240529094748.GM1436@pendragon.ideasonboard.com> <CAHp75Vf1uBTKHGazcuLCRvEo9k01t3+6oJnfZgpPZQ_dVCOeDg@mail.gmail.com>
 <20240529143506.GD19014@pendragon.ideasonboard.com>
In-Reply-To: <20240529143506.GD19014@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 18:00:19 +0300
Message-ID: <CAHp75Vd9kPBZJAod9auvE3W7Wn=0dZ8QSqUARk-aUgxkLHbpaA@mail.gmail.com>
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

On Wed, May 29, 2024 at 5:35=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, May 29, 2024 at 05:24:03PM +0300, Andy Shevchenko wrote:
> > On Wed, May 29, 2024 at 12:48=E2=80=AFPM Laurent Pinchart wrote:
> > > On Wed, May 29, 2024 at 09:16:43AM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 28, 2024 at 11:20=E2=80=AFPM Laurent Pinchart wrote:
> > > > > On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:

...

> > > > > > > +   device_set_of_node_from_dev(dev, dev->parent);
> > > > > >
> > > > > > Why not device_set_node()?
> > > > >
> > > > > Because device_set_of_node_from_dev() is meant for this exact use=
 case,
> > > > > where the same node is used for multiple devices. It also puts an=
y
> > > > > previous dev->of_node, ensuring proper refcounting when devices a=
re
> > > > > unbound and rebound, without being deleted.
> > > >
> > > > When will the refcount be dropped (in case of removal of this devic=
e)?
> > > > Or you mean it shouldn't?
> > >
> > > Any refcount taken on the OF node needs to be dropped. The device cor=
e
> > > only drops the refcount when the device is being deleted, not when
> > > there's an unbind-rebind cycle without deletion of the device (as
> > > happens for instance when the module is unloaded and reloaded).
> >
> > Under "device" you meant the real hardware, as Linux device (instance
> > of the struct device object) is being rebuilt AFAIK)?
>
> I mean struct device. The driver core will drop the reference in
> platform_device_release(), called when the last reference to the
> platform device is released, just before freeing the platform_device
> instance. This happens after the device is removed from the system (e.g.
> hot-unplug), but not when a device is unbound from a driver and rebound
> (e.g. module unload and reload).

This is something I need to refresh in my memory. Any pointers (the
links to the exact code lines are also okay) where I can find the
proof of what you are saying. (It's not that I untrust you, it's just
that I take my time on studying it.)

> > > This has
> > > to be handled by the driver. device_set_of_node_from_dev() handles it=
.
> >
> > But why do you need to keep a parent node reference bumped?
> > Only very few drivers in the kernel use this API and I believe either

s/very/a/ (sorry for the confusion)

> > nobody knows what they are doing and you are right, or you are doing
> > something which is not needed.
>
> I need to set the of_node and fwnode fields of struct device to enable
> OF-based lookups of GPIOs and PWMs. The of_node field is meant to be
> populated by the driver core when the device is created, with a
> reference to the OF node. When populated directly by driver, this needs
> to be taken into account, and drivers need to ensure the reference will
> be released correctly. device_set_of_node_from_dev() is meant for that.

What you are doing is sharing the parent node with the child, but at
the same time you bump the parent's reference count. As this is a
child of MFD I don't think you need this as MFD already takes care of
it via parent -> child natural dependencies. Is it incorrect
understanding?

--=20
With Best Regards,
Andy Shevchenko

