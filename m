Return-Path: <linux-pwm+bounces-282-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF08040FC
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 22:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B75281204
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7EF364D4;
	Mon,  4 Dec 2023 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="svqrHsHj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615ABCE
	for <linux-pwm@vger.kernel.org>; Mon,  4 Dec 2023 13:28:27 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7c4adc5dcdaso1704786241.2
        for <linux-pwm@vger.kernel.org>; Mon, 04 Dec 2023 13:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701725306; x=1702330106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfptafwSrqN68gssEleMjIEcZ95dS5LQeLcFr7AJvrk=;
        b=svqrHsHjfHB3zcNv7/CDOZoBa9qFyQccsM5kUZaBLQtFMCrE4vH3BsprOQKO1trruT
         W1dEUTo2vPSkCRV3dIU7SRSSJgrCrplojuE657vZX7gBNnprRcfYgq3F95/0gMWz9r0M
         h0oJWt/MwduEUonJQI10QPUfv+a7pN/1Kon37Wo4B63YX1HJvVvJLYbjK69zfEaGjxuf
         ohZz0fh/ZLG1Z8tggoQsYv2PBG8yLJe6Uie/HlwylelNmTjfN0Sgz/trwbblpOZ77H+e
         BXKvuZje0lA3ZMEISdgszeLz2OIo2Ovki8B8mZbtn/2znCXPOFFKWzbguaNbicrJwJCD
         decg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701725306; x=1702330106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfptafwSrqN68gssEleMjIEcZ95dS5LQeLcFr7AJvrk=;
        b=b1VpfWLkvgjHjmD0mNo4u6fj59fwqh0gtiEQjJ4MX9vg3Ao2+mz3u6a/P/rFIa9H2y
         ZoBnokxG6KSEXg/W61PKOvJV599PYbh3i1+vZILjJXmeXtMz+ak9Y4OMV0CDQromiS4q
         23o51wVhrFeak5wMvi5KkZstm0ydcjwOFDm71QyC101GVqSu5UneWIFsHU2tcBn8DEEx
         3xL+q8qNliqtk659PEtrkue5xcM+G1YgIAiDgQEFbdbPwyTu3NAL240upbBPuG+Ecz7q
         SVRUWmkhzQbVQM7SmoQ5H0JZyc0nJlBzhH4zr+vuQKvakBNDSFhfPhLG3XNjX6EyWfQR
         rUxw==
X-Gm-Message-State: AOJu0YwTCuyK3XA8zJR2dyk/S3I9oSGKRBCeQ1x9k6Yrf6+BqOCbWGwx
	3LDMG24c1ONkOD0d8BhBXL93cVYhOjpdQEf6ARfn7c42sE86IbD6
X-Google-Smtp-Source: AGHT+IHDGpRj97nPa6xh+I+LOLTtqp4r10kIdJxDwzgAn2zHtkfsFa2EhibpSacM1m2O6ugtxmETyJCSbdt5g1a3dpY=
X-Received: by 2002:a05:6102:3592:b0:464:99c2:5c5a with SMTP id
 h18-20020a056102359200b0046499c25c5amr1729120vsu.17.1701725306419; Mon, 04
 Dec 2023 13:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de> <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box> <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
 <20231127105844.kpu5ori6o6umfynh@pengutronix.de> <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
 <20231128090732.54xm72pnnjmbsjqb@pengutronix.de> <CAMRc=McAYSpCY=E1Ze7xKuBom8xOzQ4+5f7vYm33ihVU90xM1w@mail.gmail.com>
 <20231202004316.mxhrfsgcitupc6cc@pengutronix.de> <CAMRc=Md9bRdk5ZaCVu5gmZ4r5JR7eVZDriap32FMrN05PyTENQ@mail.gmail.com>
In-Reply-To: <CAMRc=Md9bRdk5ZaCVu5gmZ4r5JR7eVZDriap32FMrN05PyTENQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 4 Dec 2023 22:28:15 +0100
Message-ID: <CAMRc=MeiL7omJhe_gb_UiL_bbJGoujp3Js4=Fe=qXKHv8TjM-Q@mail.gmail.com>
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:27=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Sat, Dec 2, 2023 at 1:43=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Fri, Dec 01, 2023 at 11:14:32AM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Nov 28, 2023 at 10:07=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > >
> > > [snip]
> > >
> > > >
> > > > > I see the
> > > > > chip->operational field that is set to false on release. In my
> > > > > version, we just use a NULL-pointer to carry the same information=
.
> > > >
> > > > Yup, sounds obvious. Your usage of "just" sounds as if your variant=
 was
> > > > better. To give the alternative view where the suggested approach s=
ounds
> > > > better would be:
> > > >
> > > > You need a pointer and I "just" a bool that even has a name implyin=
g its
> > > > function. You need to dereference the pointer in several places as =
the
> > > > needed information is distributed over two structures while it's al=
l
> > > > together in a single struct for the usual foo_alloc() + foo_registe=
r()
> > > > approach.
> > > >
> > >
> > > There's another reason we do that. I'm no longer sure if I mentioned
> > > it in my talk (I meant to anyway).
> > >
> > > In GPIO we have API functions that may be called from any context -
> > > thus needing spinlocks for locking - but also driver callbacks that
> > > may use mutexes internally or otherwise sleep. I don't know if this i=
s
> > > the case for PWM too but in GPIO we may end up in a situation where i=
f
> > > we used a spinlock to protect some kind of an "is_operational" field,
> > > we'd end up sleeping with a spinlock taken and if we used a mutex, we
> > > couldn't use API function from atomic contexts.
> > >
> > > This is the reason behind locking being so broken in GPIO at the
> > > moment and why I'm trying to fix it this release cycle.
> > >
> > > Splitting the implementation into two structures and protecting the
> > > pointer to the provider structure with SRCU has the benefit of not
> > > limiting us in what locks we use underneath.
> > >
> > > Every subsystem has its own issues and we need to find something
> > > generic enough to cover them all (or most of them anyway). I don't
> > > think having a single structure cuts it.
> >
> > I'm convinced it works. I introduced a wrapper pwmchip_lock() that for
> > now uses a mutex and once we have fast pwm_chips it uses a mutex for
> > sleeping pwm_chips and a spinlock for the fast ones.
> >
> > That's similar to how struct irq_chip::irq_bus_lock works. For sleeping
> > chips that callback uses a mutex, for fast chips a spinlock.
> >
>
> Fair enough. I'd love to see a benchmark of what's faster one day
> though: two structures with dereferencing and SRCU or one structure
> with mutex/spinlock.
>

Actually there is one thing that - while not technically wrong - makes
the split solution better. In case of your abstracted lock, you find
yourself in a very all-or-nothing locking situation, where all of the
structure is locked or none is. With SRCU protecting just the pointer
to implementation, we can easily factor that part out and leave
whatever fine-grained locking is required to the subsystem.

Additionally: the pointer to implementation has many readers but only
one writer. I believe this to be the same for your "operational"
field. I don't know the PWM code very well but I can only guess that
the situation is similar, where subsystem data structures are read
more often than they are modified and multiple readers could access
the structure at the same time lowering latencies.

Just another 2 cents.

Bart

> By "fair enough" I mean: I still don't like it for the reasons I
> mentioned before but I cannot point out anything technically wrong.
>
> Bart
>
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |

