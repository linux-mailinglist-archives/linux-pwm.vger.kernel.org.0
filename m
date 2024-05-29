Return-Path: <linux-pwm+bounces-2293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DD18D3913
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 16:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82121F24673
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3A1586FE;
	Wed, 29 May 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgWnHcp2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708A1586C6;
	Wed, 29 May 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992683; cv=none; b=TKwm485mKhDhCcUVhN5CwQ/gdldR5pLSmmeSVjo7u9sBjMnVdVF1LNHjKuu+skT5ZeCMnBRtfqhZk2/rsF4UiyhC1WPrubGt5VWbX0c4vJOOulT/Ob48BEMYJgSxZlw+leFAK8ZTNHnXcnPjfF3bYZPJ/d5f/9L5IRxLektzht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992683; c=relaxed/simple;
	bh=mNgUYEnubcG8x6sqIvwYtUSCoKzzcOYzQhUu7gFNBSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuqtO01X19K2/Mj1OIf6x+sIIYY7I/9WhoQV3rtGvCM+lvFHYrSmRSkINxs4yZI3SNHLpIXTB60beYMHbahM5EOtxdrOoRrZ2NKRO35je6VlqY6anssc5BYYataAuOo+9eiHw8OqZM56wdpx2ZX7c3fQzTI/8ICjrdR5qkTevq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgWnHcp2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a630ff4ac84so244017266b.1;
        Wed, 29 May 2024 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716992680; x=1717597480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXUaCkB6tMzvL4LfnqvowAZkzoZ/9h0tRmEhy+jXdZA=;
        b=UgWnHcp2nMy92Z71MaWa1rFD8SbWvyOsiINSOheSyQL/6CjxGQ+CX/BQuX2xaoyf+C
         szANyfWicq/zjhreAoWuoKefLDtRy5O9Ctc5C9+XDnIYgI0j7pBQtUwONJCYfdSiDSGC
         OcZGNlyTqcjGEmxv9NQ3JzUrGSu5JtdDzOwwvhl8OOaQZddH88/rw3/kFhJzqsMtAe28
         vOHwTJCtZs3Ow5tyQE5PTT8ysdHAGw8c5HlrIGZkamB8Bi6qAb27Uzx7q0UrxT8mANTQ
         4fznhDazqnhnFmclBrpQ5Q8UJKjOpV/QLRZu6HODIzulLFbjjlyKlm+ycLSbXD0JpJ6t
         R7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992680; x=1717597480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXUaCkB6tMzvL4LfnqvowAZkzoZ/9h0tRmEhy+jXdZA=;
        b=pJ4whqEASyPzNQ/UmcYvI5Q0YxvbBMlt8LlcC1aqcwWi5ZxxLqL+NdZU+qw92WJnJE
         9ROXCuhPIyn6JGdV7OGOslfrK8jTCMTK+CjK59ZU7DFtjoYisE33WsRJcrsW8hxU/ZOP
         9gDSpczJLmAvl8fvSX930xkIe6+t+SY0lK8uBeJJMeEKuSu+5uxUmzFoWghGgntEZdAx
         eRwIB/UyQuc15BniCfedV6zo8Lz8BdO21R7x1Hr1qOtpTAkANUTl17Zpa96XAMpxSidG
         JW1YQxTZvPhRuusvAWR5BiLRCRpBCrcvWEU623+kADG04XqjWv267IYzZwfp8/YC4FhU
         XL3w==
X-Forwarded-Encrypted: i=1; AJvYcCUrCoNX1IxK0UQgnx2fICkn36hJCXdWxNlLJCGTghZ3EMlf2KdUoQnawsce3GS03pXXNXl2gpkRpfssJb34QFtrgcFba8id5n0QgDYpoyYnMQOGquYYpPbBFTuQvGcrvQhjF0fKdGqSO07dAi836hVnUFQZ32ujiAK/bocPkV+9klI=
X-Gm-Message-State: AOJu0Yzk646NzqspK6IgrlVnVuyt3SRqttb/fSWbhYejhWRYbUdPyxY8
	Hz6VYXW+0uniiOyI2toKmik72mDr4qMIu98hLbxwOVWA2fkNKxmeHrr9l3XnGk+tEJbqfAruMKV
	G5n6Oy0SvWyx7zhw5Wo8LCXPNibY=
X-Google-Smtp-Source: AGHT+IHyZuAkokx73kdGAbIZ/CLYololxUsLncCUOjD0KN1JH9pe4IZRwVZJaedOC5UYnHuNWa89YDIMQfY5VzWtOtc=
X-Received: by 2002:a17:906:384:b0:a62:2ef9:131 with SMTP id
 a640c23a62f3a-a62641a2aecmr975337266b.6.1716992679816; Wed, 29 May 2024
 07:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com> <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com> <CAHp75Vc2-jOMybL7vwJHgrvb_434p094tgdLo1SyK4i_RXYiDw@mail.gmail.com>
 <20240529094748.GM1436@pendragon.ideasonboard.com>
In-Reply-To: <20240529094748.GM1436@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 17:24:03 +0300
Message-ID: <CAHp75Vf1uBTKHGazcuLCRvEo9k01t3+6oJnfZgpPZQ_dVCOeDg@mail.gmail.com>
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

On Wed, May 29, 2024 at 12:48=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, May 29, 2024 at 09:16:43AM +0300, Andy Shevchenko wrote:
> > On Tue, May 28, 2024 at 11:20=E2=80=AFPM Laurent Pinchart wrote:
> > > On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:

...

> > > > > +   device_set_of_node_from_dev(dev, dev->parent);
> > > >
> > > > Why not device_set_node()?
> > >
> > > Because device_set_of_node_from_dev() is meant for this exact use cas=
e,
> > > where the same node is used for multiple devices. It also puts any
> > > previous dev->of_node, ensuring proper refcounting when devices are
> > > unbound and rebound, without being deleted.
> >
> > When will the refcount be dropped (in case of removal of this device)?
> > Or you mean it shouldn't?
>
> Any refcount taken on the OF node needs to be dropped. The device core
> only drops the refcount when the device is being deleted, not when
> there's an unbind-rebind cycle without deletion of the device (as
> happens for instance when the module is unloaded and reloaded).

Under "device" you meant the real hardware, as Linux device (instance
of the struct device object) is being rebuilt AFAIK)?

> This has
> to be handled by the driver. device_set_of_node_from_dev() handles it.

But why do you need to keep a parent node reference bumped?
Only very few drivers in the kernel use this API and I believe either
nobody knows what they are doing and you are right, or you are doing
something which is not needed.

--
With Best Regards,
Andy Shevchenko

