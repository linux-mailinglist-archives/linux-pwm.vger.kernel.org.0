Return-Path: <linux-pwm+bounces-5975-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E0AB6384
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 08:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D267A3A40EB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52871F3B8A;
	Wed, 14 May 2025 06:56:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5D1DF98F;
	Wed, 14 May 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205777; cv=none; b=cY2n7ry09ayOr8qL9YyC1K8PptrLUI+zkXn32ULPDyAgHeJFvdZbUqkqSm1DyO/ZSHdBNEC/s5WEvKK59zrFEPF+gTAdT+7lhacmTlpKBK+w2TolD9hayaXnEuw6bew1CiqV5Skvr5aHQR/Vl2/F0qteZLMH5fBDAWrT+VQyQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205777; c=relaxed/simple;
	bh=mymWJlddEKcqOa/5YBuCKi+dO4q9wdYhyUtxSJoUDZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usy96K+W1VBHM1AC7TqGotl/cAqrx1wPsNv/qVNf+pR5sKulgqqO/qjZeFAM5oI5ei3t9t6JHgNAwslDrEvhT0pWEWm5gFa0MsIRQerOzxlKCE2j5fmb9MvYwayhJyIu/wm9GSd/D0kUhWZDEWIH3MT8/CntbGC53p+ZGMO9iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4ddb7ddfb76so4286492137.1;
        Tue, 13 May 2025 23:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747205774; x=1747810574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDCAs29eI3uPrxwg5yMJ9RsIAXUJs7cR4owpHVla5c0=;
        b=bpFGch9DzO1Pmo9CLqheeE/by/r907jm+x+GS3f6sWXQxWvx5Kfmce26EOoZQqkSnU
         hhmMsQrPfyIWpjqdrnWgIL5o9cyPz05lgMXed6R9SSGXqFBALX+LfACmejKgnEOWAL4e
         Rmy8/6JG3lIilc1FW1clHAzxanP2+GFSEXDKdm6QFODukZlp5mEXFISVwru5zOga8WZC
         MhAUonIaSt3PgC6agEW0iAHdf63361GWxMywywsY1vueMvfZ/sq76lfQZ00aDAzh3as9
         RdEm3xzoWJx8gSooV60V/iB9JxiKn6MJAplscQ3elCV/c9lKg8FIEU6J94yglNBgxl1U
         vj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZa1ZiXkNnkRH6wKuVVlS+cTLhZ5EqRwvPGWK/J3nROFFT3QjZnvAUZxGvaNEZ7rT9fVKsfvFZcOtBd6cgelUMwBc=@vger.kernel.org, AJvYcCUwld8vqcch/T7SJam84rZJdcop64I5od1yKc1h7kqXIGSb0JSzNGmgEIrlujm5AsparQ2185LlyDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoql67qCXX64kR0QEdR47rDt3bhdko3sLMDmxrlTvTEs8+F24
	DC06OFObS0uvhsHW7tDtctNdj6T6DpEy1t3F8rykwQTd2KK2Cyfa0kIUYsYq
X-Gm-Gg: ASbGncvyc4DzGAETczEvncwifZ6UDC5KYlc9e0AS7pL5xVALep5s1s/p+xmzzLMlT+e
	2Zjs35xchHoniPVum8AHQOyLi8+HRN5xFhFOzvIYFPPcXf2poZpc7axqHGB9vpTDdM9flceDMV6
	Kv6rBrIw8s5xEwq+YZqgm6UesEPGVGIvFQa2OzICQvy2Bg9Ftx/KTvWzTD+IdQ9OFFOGS+PR/Zz
	9T3KexgSNdCrEOzjDO8m4ALC1zhqzpWYEyN+UdmL4OdTKH+fhowy7YdCCS/hIUt9BqsYXQh8Px2
	IOo+JCtivJVHrgjMJDGRBQNs5iMFOwh3Jsn+vkWwD7yM2D3Uyd/h84Rtxf8QYWOaAg9lWHgfq0Z
	b5EbHafO5oBo20g==
X-Google-Smtp-Source: AGHT+IEUdjVcVM6s/jmmLMRetrSEaZAanxVAyf36pNuw5aPmkVJzwUg7pbWBK5W51n5bu+EAIjNEpw==
X-Received: by 2002:a05:6102:150b:b0:4db:e32:8f3c with SMTP id ada2fe7eead31-4df7dc74423mr2122553137.1.1747205773710;
        Tue, 13 May 2025 23:56:13 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dea85d7c32sm7762010137.15.2025.05.13.23.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 23:56:13 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-879b7ea69d2so3704224241.0;
        Tue, 13 May 2025 23:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSvHjdpxi5l7lsYrPfI8tVs/iNmtLLIg6o6COYp+OLEua0uafIKRXP8NRcHdgUvZSHksZ8nph5xx4=@vger.kernel.org, AJvYcCWrGHXoGvy2YayPdXJ85CH7ghJuHZwfP9uC+rQPZSGx6grseuH2PvXxHmmoQn7/hKOPjH7lMftcwEVfItzheDW+Qis=@vger.kernel.org
X-Received: by 2002:a05:6102:3c90:b0:4c3:2803:61c1 with SMTP id
 ada2fe7eead31-4df7dd50aa4mr2031647137.18.1747205773033; Tue, 13 May 2025
 23:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com> <62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
In-Reply-To: <62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 May 2025 08:56:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>
X-Gm-Features: AX0GCFt0-dnvfA6LRkspcOFzcdDLX6s2FQi24zz_xXXmFVsXJyso2Ap3WCqqt9s
Message-ID: <CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, 13 May 2025 at 22:19, "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>=
 wrote:
> On Mon, May 12, 2025 at 06:33:12AM +0000, Kuninori Morimoto wrote:
> > Because current PWM Kconfig is sorting by symbol name,
> > it looks strange ordering in menuconfig.
> >
> > =3D>    [ ]   Renesas R-Car PWM support
> > =3D>    [ ]   Renesas TPU PWM support
> >       [ ]   Rockchip PWM support
> > =3D>    [ ]   Renesas RZ/G2L General PWM Timer support
> > =3D>    [ ]   Renesas RZ/G2L MTU3a PWM Timer support
> >
> > Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
> > and sort it.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v3 -> v4
> >       - Based on linux-next/master
> >
> >  arch/arm/configs/multi_v7_defconfig |  2 +-
> >  arch/arm/configs/shmobile_defconfig |  2 +-
> >  arch/arm64/configs/defconfig        |  6 ++--
> >  drivers/pwm/Kconfig                 | 44 ++++++++++++++---------------
> >  drivers/pwm/Makefile                |  6 ++--
> >  5 files changed, 30 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/mul=
ti_v7_defconfig
> > index dc4b722ad4b5..50c170b4619f 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -1184,7 +1184,7 @@ CONFIG_PWM_BCM2835=3Dy
> > [...]
> > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shm=
obile_defconfig
> > index 0ea34d5d797c..7c3d6a8f0038 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -203,7 +203,7 @@ CONFIG_RZ_DMAC=3Dy
> > [...]
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index d0768584647c..fe021cbb6393 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=3Dm
> >  CONFIG_PWM_MESON=3Dm
> >  CONFIG_PWM_MTK_DISP=3Dm
> >  CONFIG_PWM_MEDIATEK=3Dm
> > -CONFIG_PWM_RCAR=3Dm
> > +CONFIG_PWM_RENESAS_RCAR=3Dm
> > +CONFIG_PWM_RENESAS_RZG2L_GPT=3Dm
> > +CONFIG_PWM_RENESAS_RZ_MTU3=3Dm
> >  CONFIG_PWM_RENESAS_TPU=3Dm
> >  CONFIG_PWM_ROCKCHIP=3Dy
> > -CONFIG_PWM_RZG2L_GPT=3Dm
> > -CONFIG_PWM_RZ_MTU3=3Dm
> >  CONFIG_PWM_SAMSUNG=3Dy
> >  CONFIG_PWM_SL28CPLD=3Dm
> >  CONFIG_PWM_SUN4I=3Dm
>
> I was about to apply this patch, but here in
> arch/arm64/configs/defconfig is an not entirely trivial merge conflict.
> The problem is that CONFIG_PWM_RZG2L_GPT=3Dm is only added in commit
> 5ad7de623853 ("arm64: defconfig: Enable Renesas RZ/G2L GPT config")
> which isn't included in my tree yet but only in Geert's
> renesas-devel.git/next. So conceptually I'd need to do:
>
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=3Dm
>  CONFIG_PWM_MESON=3Dm
>  CONFIG_PWM_MTK_DISP=3Dm
>  CONFIG_PWM_MEDIATEK=3Dm
> -CONFIG_PWM_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RZ_MTU3=3Dm
>  CONFIG_PWM_RENESAS_TPU=3Dm
>  CONFIG_PWM_ROCKCHIP=3Dy
> -CONFIG_PWM_RZ_MTU3=3Dm
>  CONFIG_PWM_SAMSUNG=3Dy
>  CONFIG_PWM_SL28CPLD=3Dm
>  CONFIG_PWM_SUN4I=3Dm
>
> and the merge conflict resolution needs to add
> CONFIG_PWM_RENESAS_RZG2L_GPT=3Dm. This is too bad IMHO.
>
> The obvious options are (in order of my preference):
>
>  - Geert declares his renesas-arm-defconfig-for-v6.16 to be stable and I
>    merge it into my tree and then apply the patch
>  - I cherry pick 5ad7de623853 in my pwm tree and Geert drops it
>  - I delay applying the patch until after v6.16-rc1
>
> Geert: What is your preference? Let's discuss on irc?

My tag renesas-arm-defconfig-for-v6.16-tag2 is stable, as that is
already merged in the soc tree.

However, renaming config symbols always comes with its own set of
pains: users must notice and adapt when updating their own configs,
and I do have to manage the non-upstream renesas_defconfig, too.
What about dropping the rename part? The symbols that currently lack
a RENESAS-prefix do have fairly unique family prefixes.

Morimoto-san: Would that still be OK for you?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

