Return-Path: <linux-pwm+bounces-281-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9E803F47
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 21:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37B61C20862
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59634197;
	Mon,  4 Dec 2023 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fdI/5JBQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9144BD2
	for <linux-pwm@vger.kernel.org>; Mon,  4 Dec 2023 12:27:25 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7c55625fb66so909990241.3
        for <linux-pwm@vger.kernel.org>; Mon, 04 Dec 2023 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701721644; x=1702326444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3mwK7FJ5mHZ2pgsOxA5s1T1Diz1IqXeIkDRs9iL8yQ=;
        b=fdI/5JBQvrdW3Ko5Rl0lEnGZsOR/92ZeEdUadkbfQFP1+jIr6V8vDY02ZTE6sMaQvp
         cYvhKl2NOyOtCiFbTSdRTpVXuR79BAbx0gS7a77C0Y75QiFYCxZY+D0U412ilg9jUjq+
         duA8gDZG4ap7MZ8GNcbMlMfV8qSOsD0f1WoxR6wPDOff2ZfXdHNwW7VG++a7QKHjWOST
         crOOfEThPIL3wViN2VKZJyTyBHmSxqmGs2Zim5RT+pOMNYAmn9qev9zmbSNr6F9nv02W
         WcwTy/uP2CM+VR2rS3pHuH/83eYllc4JcelC3GkHMLKGCmlMCy1jkQksfaF3gnRHnf5C
         sVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721644; x=1702326444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3mwK7FJ5mHZ2pgsOxA5s1T1Diz1IqXeIkDRs9iL8yQ=;
        b=qDncpKzKnUUzaS6rBVP4dciYwO+d6LPZsPlEIqBRIq6ShHhOvTmWXfQUSMba6LjEu4
         4kEyl1wNUDXmcGou37FS3mH7RwbyzknDfBq30ttlTRt8OiOW76/NqC8bwtaiIY9XS5Gr
         7gZy2+GbGTqbjdaa9X70wz/p2IMaH5ZJJg15K3k2gq5cyUHdVKpbP9alaIYrNi6KneMq
         c/XadW+QrcRhCakRY/uUwWEp3EqWLvg9/ip05rMTiWLF+9JswlFzX1B1Qc29pKoQ08vT
         B6lQOa1+Q4CD0YiwKlcEAUqzb18seZlQQD+VdphRaHHWawF/7sVcZh6R/bRX9Mh5tlqP
         +SWQ==
X-Gm-Message-State: AOJu0Yxcr0FFbvJA33WcMls88qQnqinrtbnFCeQLf4GLdB0k7lS6GZmm
	TSus2+L0xcqasjJq9Rch9adL1zNjCk5Gcv8NIK5m5w==
X-Google-Smtp-Source: AGHT+IG8wYSSYmJ3XHYG+bOGnsNq+kMhNJkrFy1rkiqzK5ncwA6Oq5Urj3TCp2z+JqxUg7ubGWAznz0qvMfo3y9denc=
X-Received: by 2002:a05:6102:12c7:b0:464:7f21:17d6 with SMTP id
 jd7-20020a05610212c700b004647f2117d6mr1198972vsb.15.1701721644689; Mon, 04
 Dec 2023 12:27:24 -0800 (PST)
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
 <20231202004316.mxhrfsgcitupc6cc@pengutronix.de>
In-Reply-To: <20231202004316.mxhrfsgcitupc6cc@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 4 Dec 2023 21:27:13 +0100
Message-ID: <CAMRc=Md9bRdk5ZaCVu5gmZ4r5JR7eVZDriap32FMrN05PyTENQ@mail.gmail.com>
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 1:43=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Dec 01, 2023 at 11:14:32AM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 28, 2023 at 10:07=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> >
> > [snip]
> >
> > >
> > > > I see the
> > > > chip->operational field that is set to false on release. In my
> > > > version, we just use a NULL-pointer to carry the same information.
> > >
> > > Yup, sounds obvious. Your usage of "just" sounds as if your variant w=
as
> > > better. To give the alternative view where the suggested approach sou=
nds
> > > better would be:
> > >
> > > You need a pointer and I "just" a bool that even has a name implying =
its
> > > function. You need to dereference the pointer in several places as th=
e
> > > needed information is distributed over two structures while it's all
> > > together in a single struct for the usual foo_alloc() + foo_register(=
)
> > > approach.
> > >
> >
> > There's another reason we do that. I'm no longer sure if I mentioned
> > it in my talk (I meant to anyway).
> >
> > In GPIO we have API functions that may be called from any context -
> > thus needing spinlocks for locking - but also driver callbacks that
> > may use mutexes internally or otherwise sleep. I don't know if this is
> > the case for PWM too but in GPIO we may end up in a situation where if
> > we used a spinlock to protect some kind of an "is_operational" field,
> > we'd end up sleeping with a spinlock taken and if we used a mutex, we
> > couldn't use API function from atomic contexts.
> >
> > This is the reason behind locking being so broken in GPIO at the
> > moment and why I'm trying to fix it this release cycle.
> >
> > Splitting the implementation into two structures and protecting the
> > pointer to the provider structure with SRCU has the benefit of not
> > limiting us in what locks we use underneath.
> >
> > Every subsystem has its own issues and we need to find something
> > generic enough to cover them all (or most of them anyway). I don't
> > think having a single structure cuts it.
>
> I'm convinced it works. I introduced a wrapper pwmchip_lock() that for
> now uses a mutex and once we have fast pwm_chips it uses a mutex for
> sleeping pwm_chips and a spinlock for the fast ones.
>
> That's similar to how struct irq_chip::irq_bus_lock works. For sleeping
> chips that callback uses a mutex, for fast chips a spinlock.
>

Fair enough. I'd love to see a benchmark of what's faster one day
though: two structures with dereferencing and SRCU or one structure
with mutex/spinlock.

By "fair enough" I mean: I still don't like it for the reasons I
mentioned before but I cannot point out anything technically wrong.

Bart

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

