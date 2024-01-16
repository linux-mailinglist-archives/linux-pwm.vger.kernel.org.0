Return-Path: <linux-pwm+bounces-806-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC982F05F
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AA41C22E1B
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D371BDF1;
	Tue, 16 Jan 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b="n2WiHX16"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B11BDDF
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gadgetoid.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2107f19e331so222377fac.3
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gadgetoid.com; s=google; t=1705414521; x=1706019321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7ITeHnRHAkZbklQNhs4u/b6ecDW9RjUixnOTjPpFPs=;
        b=n2WiHX16MSD4OJxmhWLB4cMVJHsppCGuF7a340QOyPcUq/rxwPSHxmEjVdWN/h7C7S
         uLZalzNFx1gHu4WelgKeCYvCaz5sK51qD8Rbc/rkKdeT0d8khSsLzZk+pipBY003b22c
         4MhG4ZhkpKxqlVTaYdwJyr/H9gE4j99X22889HBk7CyJTqwhI3vhhyuy5jTqRknvbdbM
         NRqUsnk9dtR0f12pRSw82vZlT9x3jY4akeXd+ZhJPSiTW2hCo6k7VwV5gUr+lAbFnECg
         hiYqoM/ku+wk4In3B8U0TLT/VdYJ/gEE2n/5oQCGjoovyS+F+vYRxAfocSnJ+QOPyoXd
         17uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705414521; x=1706019321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7ITeHnRHAkZbklQNhs4u/b6ecDW9RjUixnOTjPpFPs=;
        b=DsFRaUAXF4oYIWMgl0hi1cIfRzqhq7d8SwCem7YHrmCW5jqXdPZLp4Rst6aKZpZIVw
         p+2ieGAMvP2INnh0eZBpK30fkAUcx8DAnjfJnOLbHcSZQxP4ptW8a5zj36A+zcl33gEj
         0+xRIHh70AivZ4NReZpLjNZ+9a+CP15wCcszva1xEfrAOgMUOiMbwfuuuYdwCr+/sNkN
         iMlUG6Rotysahbain07EY6BIMpa9hfza4ttekCgkwZGY+ocLGH8wqxni4EHqqMGeOt+1
         Tev+hJn5rm+ydni7okG7Vq7DFgQ4/vxAqswP1bVqPyykmIhML4BckVjDOwh1JxjcrwaW
         cDpw==
X-Gm-Message-State: AOJu0Yw+RQH4kbcmgi17DhJlhwJODXYqY5rdJCUYXpKpSYkUXRCnwcut
	O4gYjbfDzMFZydNyM76kqda1uYq6rKhD7DiGz+EQfP9eWrJuYw==
X-Google-Smtp-Source: AGHT+IEfF3mO2LyOShyaYtfBBGRQxG+YErn+tn3w2svxKcNAIv62k27kw8BVinLcz0PhBhGG2HOkiPSVEBgKhjMf6DU=
X-Received: by 2002:a05:6871:5829:b0:206:7626:e1bb with SMTP id
 oj41-20020a056871582900b002067626e1bbmr7317002oac.28.1705414520972; Tue, 16
 Jan 2024 06:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com> <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de> <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
 <CA+TH9VnrsSQDUfvXk8c+q6Sx2Jc5TCN5XLYCRLtgv55-6voLWg@mail.gmail.com>
 <Y/YPtJK8nVBthCML@surfacebook> <Y/YuJoxkz+o0Omie@einstein.dilieto.eu>
 <5521796b-d51e-42a3-831a-7fbf75247726@gadgetoid.com> <CAHp75VfLEBw=ypFiLpd8ken5JPkW5DJey_UroV+3B6ZSaK3Jyw@mail.gmail.com>
In-Reply-To: <CAHp75VfLEBw=ypFiLpd8ken5JPkW5DJey_UroV+3B6ZSaK3Jyw@mail.gmail.com>
From: Phil Howard <phil@gadgetoid.com>
Date: Tue, 16 Jan 2024 14:15:09 +0000
Message-ID: <CA+kSVo-yjU17Q97vN+DrpUUxCku6H309iXNDiBy9fJ3QPM8aTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nicola Di Lieto <nicola.dilieto@gmail.com>, 
	Angelo Compagnucci <angelo.compagnucci@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Rob Herring <robh@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jan 2024 at 18:32, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Fri, Jan 12, 2024 at 3:38=E2=80=AFPM Philip Howard <phil@gadgetoid.com=
> wrote:
> > On 22/02/2023 15:00, Nicola Di Lieto wrote:
> > > On Wed, Feb 22, 2023 at 02:51:00PM +0200, andy.shevchenko@gmail.com w=
rote:
>
> ...
>
> > I'd love to know if you're still likely to look into this.
>
> If you are asking me as well (since To refers to me), Cc for the new
> version and I might look at it. Currently I am OoO till the end of
> month and after that I probably will have more tasks to do, so no
> guarantee for this cycle, but just in case Cc and we will see.

Thanks for your reply!

I'm not sure I know how to "Cc for the new version," it took me about
an hour to generate a (hopefully) suitably formatted email response
to this patch. I've only just subbed to linux-pwm.

But yes- my reply was cast out into the ether in the hopes that logging
my interest might get things moving again, or at least let me know if I
should try tackling it myself.

I'm moving over to libgpiod on Raspberry Pi, losing software PWM (
from the library I was using) in the process. I don't want to use or
contrive another not-invented-here solution.

>
> --
> With Best Regards,
> Andy Shevchenko

--
Philip Howard

