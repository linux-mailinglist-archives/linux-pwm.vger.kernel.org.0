Return-Path: <linux-pwm+bounces-196-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8AD7F8565
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D620B29BD9
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3B33CC1;
	Fri, 24 Nov 2023 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pHAgV2s7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BAD19A6
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:16:52 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7c451cc7fe8so1373950241.0
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700860611; x=1701465411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYhutocak3//Pg1G4wFBgqO46Xp/I/GtsLaBMsY5cbI=;
        b=pHAgV2s7QwdkOMsegyiY4qtQk2qr6OdmFLsFUTVUWuK2JK/GTiryI7J18xGLlbbkwY
         B7tLxSQDsCy8J0LUHUnHJ6tg7aFwmUEF5aAxDlDigyTqibaFx5NgAWfDGnKIFsehGJK/
         iN3fPccFFsBlugGlft172WuoKxZ0ifzD3nJXhFrFdORiqioSIxx+3BQTJO1euvKps6bL
         w72y2HiwI0SSJKCER8y7PmGXijvBnYURUmuyCj4Y6JQzWT4mTLGsboIo4q2ahs7lb+E9
         JcskoY7zwRZGceeZIOKuw4SkKPzJ7phpXpPCMzwJetMIA0stlSfNV19DkoMbR5mpFPb/
         AHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860611; x=1701465411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYhutocak3//Pg1G4wFBgqO46Xp/I/GtsLaBMsY5cbI=;
        b=a771r3OhB2kUz3XUBZ52q+QBP6PodoaRVXH96shQptfnC+AjjLLR+dLx+1NgUFRP7K
         QPyHCf5EfYszPlM+uD8XeVwTKYP/tcht+2ARZ/91DM/NoKwBwQqvWC2zPC/SLjLzS5zo
         NRy6trEf36FvW4M6mHsiS65RswWIejwGTs0QKNy6B1iB0EmDOUrOuBglhzOKKxWr1Gui
         YS5oo3asWi9SOkGjy2N6qYpCcyU0IaPBVW3K1BvKcUeSZ+Pyo/WtCda4mVHJ5I34+R7m
         EyLfJ8W1bPPtNRrSATapyVtNaCnYAPBHWiFQDARQwE/RHpP55/7TBXfzzhq56H0gQwql
         Uc5Q==
X-Gm-Message-State: AOJu0YwE4HHksLaLnJ9Cg9Vws6A5d7mOVNLCOHx3dSTdPtLABWzexQnw
	8gQBi6cHpnhYalTUFKg8ZooWOFczJouiQ/qX2URjcQ==
X-Google-Smtp-Source: AGHT+IF2A3Iq2AAFxfronJOCca98BKBeT5s7n0a5WHJualZvZxGxHwHx82rWmZW8bPxqThk+VKsVk295YKFfOCeHzoI=
X-Received: by 2002:a1f:4845:0:b0:49a:9855:2fbb with SMTP id
 v66-20020a1f4845000000b0049a98552fbbmr5087862vka.5.1700860611429; Fri, 24 Nov
 2023 13:16:51 -0800 (PST)
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
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com> <ZWCTtPVkTUQNLVoa@orome.fritz.box>
In-Reply-To: <ZWCTtPVkTUQNLVoa@orome.fritz.box>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Nov 2023 22:16:40 +0100
Message-ID: <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 1:14=E2=80=AFPM Thierry Reding <thierry.reding@gmai=
l.com> wrote:
>
> On Wed, Nov 22, 2023 at 11:36:19AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 22, 2023 at 10:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello Bart,
> > >
> > > On Tue, Nov 21, 2023 at 05:11:11PM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wrote=
:
> > > > > Eh... I had a talk at LPC where I explained why I really dislike =
this
> > > > > approach but I guess this ship has sailed now and it's not a subs=
ystem
> > > > > where I have any say anyway.
> > > >
> > > > Is there a record of your talk? I'm open to hear your arguments.
> > >
> > > I found your slides at
> > > https://lpc.events/event/17/contributions/1627/attachments/1258/2725/=
Linux%20Plumbers%20Conference%202023.pdf
> > >
> >
> > My talk is here: https://www.youtube.com/watch?v=3DVxaAorwL89c&t=3D2931=
0s
>
> I've been watching this along with Laurent's talk from last year (and I
> guess I should probably also go through Wolfram's patch from earlier
> this year) and I really like what you presented. It also sounds like
> there was a lot of support across various audience members, so I think
> it'd be good to rally around such a common pattern so we can start to
> improve things on a more wide basis.
>
> Given that this wasn't very long ago, I wouldn't expect that much work
> has happened yet on the resmgr library. However, I think it would fit
> very well both with how PWM works today and with what Uwe has in mind
> for the character device support.
>
> Thierry

Hi Thierry,

Thanks for the kind words. No work has been done so far other than
thinking about the possible API. I'm currently in the process of
trying to fix the object life-time and concurrent access in GPIO -
mostly improving the dire locking situation. My goal is to implement
all I spoke about in GPIO first and then try to generalize it to some
other subsystem like what Greg KH suggested.

I've already got support from Wolfram on that and we of course could
use any help we can get.

I admit I've been quite busy but I do plan on going through Uwe's
series next week and maybe running tests similar to what I have for
GPIO on it. I'm quite certain (correct me if I'm wrong) that this
series doesn't improve the locking (specifically hot-unplug events
during API calls). I think that my proposal has the advantage of
having the pointer to the implementation in the "wrapper" which can be
easily protected with RCU.

Uwe: do you have a solution for device removal concurrent with API
calls when using your approach?

Bart

