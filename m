Return-Path: <linux-pwm+bounces-6111-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29DAC2E54
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 11:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E2E9E0FC4
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29E14A0B7;
	Sat, 24 May 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO8yyZew"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BD72600;
	Sat, 24 May 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748077664; cv=none; b=u8GkMOZyC0ILehVmDOWrtkTN2Seo/4I7y0rBb952q/+I1UqFE2aJrQtPWq0ZRSyKRQ91rLtNxMuLNx3pHm9hihTeFpOz3GmpH0V0qloWM3O+a/vIE2xVccKyKSBPunlJwCcAuxa09M9qlZpUGlxjymRuN8tBuT8V2cXfl/anqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748077664; c=relaxed/simple;
	bh=iILbmLEEW1bsfkqbuwW87id1HdWlI/ABH8FcNKj2YOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/l1UQOP0HuleoEGFg4RRaCc8AOexAE8yEfZobYwkGHx93UUrD2cRobz88khIxvk+qk0R/xjXBuLMnVj6hm7ftpXXg+P2tYol/vf5GM3SJBe19pxNdS7b1tavqYmq25CkM1Fdw0ylnQ/TcOTahGgX8uEnWXoTKZ+91m3ruv5yDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO8yyZew; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30ea559c18aso754886a91.2;
        Sat, 24 May 2025 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748077660; x=1748682460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i119ZdqwylxvePknDu5537sPYx102Z8LOFfFRv1zkeU=;
        b=SO8yyZewNityY4+ovXOZ/9Ry+eJRZV0RtUJeteFwr132KjYoHzZSukkXksV4Z3ypdp
         aYrfIV4B7FSQ72cx+Pgg1UrDBrWHyEgAgx5H+hGLQj/3JwRc9/hdt0gRJLvyIaqaQPtU
         YUNrkMFPycjufkfVgXvQOGBNEOrOxxt+T54tAwLCczw+MNcbVJkN+gMO7VUdQPE5fdAf
         SyP/OzsySqVkFw5j39FEkad6RaCu+2vIPX9R3XQv8DV+4v88cOeB5OaY30zXQhC8btsf
         ZsRdjEmAhA3HLsWHggtFTv69JWlRwREYg1J9U0odJtEz/rqRGwUa1Gx+0OWi0SILY0HF
         nmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748077660; x=1748682460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i119ZdqwylxvePknDu5537sPYx102Z8LOFfFRv1zkeU=;
        b=Dp0vEqHKWWzvO3RVl7MwsVRobR3fF8brxm4elxJpJgSwzC57+cceIta5WJX0Xpl5yd
         1WX9mtw0dYC3cm8qAtz5y5T/Y4Q+YkgxGiXRSCv07nwnhXA3Oqknuy4bshRqWp0GfuOj
         EQ3mRqlPfvSkl/R0OmEWW8QXLfjefoHElRXPY6A5GpcxTQ48uSKKBrYWiY8SSwH5UlZ5
         kwOahbdG+NeBHMzp8Nq83qDE65La7x7o6WDbnGvzoOiuq0i5eSop+05GRL5OI6u6JZ1E
         ZRrmLed3KohpAZstJUA1zAwC0rFexDUyWukaykjYGlJgC7LvzC8vOe4Hg5zvDLubAo/Y
         KEAA==
X-Forwarded-Encrypted: i=1; AJvYcCVdy92ZDJfnN6kSWx+jtAOK+ko/bFG6kSmB2m84z6Vm8y45AkGEuyHCpUb9eXX46/MsZczwMM2g9M/O@vger.kernel.org, AJvYcCWczQD/7xPczr53juLwqxYa7ifZ8rS2YDqlmHZs16sxs3MRTQgTZeHwFg29FjfqpKoHRAkyX5l5OL69@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FpXCVBszNat8Mvy/T+FdDr7y46xxz7jS1UUyNTij5fWvxiDy
	8FzI21FLn3iNUl3XuzeB7regrBzytdz3mqIIYxzHpY7oEg3MSW43KnQX4ULPZ45JB6kf14BIQQ+
	sJwE/0RcWr521bZy/tcytJf2udT3g7g==
X-Gm-Gg: ASbGncserTe2LKT0dxMJ6gP9DO7F6Sl6ZZzPPsFuFnjneA85L8X7W1FpGCrcvuHmxTb
	UTOjkPSz8E6C4rjUTXDRqDV738hAnFQypiz+2Sj2F8xfDK15CRDqDdLDxA3rKt2TzzhlSQZxocM
	DmtMg9eh7Z0IZwceyFT5RU1w8e7DuavbV5HQ==
X-Google-Smtp-Source: AGHT+IGfsbnlWYm6ryyIXKu8l0wD9Gl6ILgkcO5qxSGI2lVZ2vqgjszrrAVP7/jX1dtijf8SEpwsba6wlQat7Hz1jDk=
X-Received: by 2002:a17:90b:3e4c:b0:30c:540b:99e with SMTP id
 98e67ed59e1d1-3111089ce3amr3296232a91.13.1748077659990; Sat, 24 May 2025
 02:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427142500.151925-1-privatesub2@gmail.com>
 <20250427142500.151925-3-privatesub2@gmail.com> <20250512233944.06bc1cb7@minigeek.lan>
In-Reply-To: <20250512233944.06bc1cb7@minigeek.lan>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= <privatesub2@gmail.com>
Date: Sat, 24 May 2025 12:07:28 +0300
X-Gm-Features: AX0GCFtjOigl8LB6aOujvwpOl4IGq5zeA6Zw_ZeAOGCYHb0mFy42IcyvaTHExJA
Message-ID: <CAF4idN=Kwp8bDYVyjM52eUwVEEZcPM9YyK9KiqUzyf8Dm=cXTQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-kernel@vger.kernel.org, Brandon Cheo Fusi <fusibrandon13@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

Thanks for the thorough review and the great questions!

=D0=B2=D1=82, 13 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 01:39, Andr=
e Przywara <andre.przywara@arm.com>:
>
> On Sun, 27 Apr 2025 17:24:54 +0300
> Aleksandr Shubin <privatesub2@gmail.com> wrote:
>
> Hi Aleksandr,
>
> thanks for your patience and persistence with this series! It seems
> like some people have some motivation now for getting mainline, so
> hopefully we can use this momentum now. Also the "new" Allwinner A523
> uses the same IP as the D1, just with all 16 channels.
>
> > Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> > controllers with ones supported by pwm-sun4i driver.
> >
> > This patch adds a PWM controller driver for Allwinner's D1,
> > T113-S3 and R329 SoCs. The main difference between these SoCs
> > is the number of channels defined by the DT property.
> >
> > Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sun20i.c | 379 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 390 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sun20i.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4731d5b90d7e..230a5561385b 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -662,6 +662,16 @@ config PWM_SUN4I
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-sun4i.
> >
> > +config PWM_SUN20I
> > +     tristate "Allwinner D1/T113s/R329 PWM support"
> > +     depends on ARCH_SUNXI || COMPILE_TEST
> > +     depends on COMMON_CLK
> > +     help
> > +       Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sun20i.
> > +
> >  config PWM_SUNPLUS
> >       tristate "Sunplus PWM support"
> >       depends on ARCH_SUNPLUS || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 539e0def3f82..ef7515d2f974 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -61,6 +61,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUN20I)     +=3D pwm-sun20i.o
> >  obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> > diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> > new file mode 100644
> > index 000000000000..22486617f1ef
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sun20i.c
> > @@ -0,0 +1,379 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> > + *
> > + * Limitations:
> > + * - When the parameters change, the current running period is not com=
pleted
> > + *   and new settings are applied immediately.
> > + * - The PWM output goes to a HIGH-Z state when the channel is disable=
d.
> > + * - Changing the clock configuration (SUN20I_PWM_CLK_CFG)
> > + *   may cause a brief output glitch.
> > + *
> > + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +
> > +#define SUN20I_PWM_CLK_CFG(pair)             (0x20 + ((pair) * 0x4))
> > +#define SUN20I_PWM_CLK_CFG_SRC                       GENMASK(8, 7)
> > +#define SUN20I_PWM_CLK_CFG_DIV_M             GENMASK(3, 0)
> > +#define SUN20I_PWM_CLK_DIV_M_MAX             8
> > +
> > +#define SUN20I_PWM_CLK_GATE                  0x40
> > +#define SUN20I_PWM_CLK_GATE_BYPASS(chan)     BIT((chan) + 16)
> > +#define SUN20I_PWM_CLK_GATE_GATING(chan)     BIT(chan)
> > +
> > +#define SUN20I_PWM_ENABLE                    0x80
> > +#define SUN20I_PWM_ENABLE_EN(chan)           BIT(chan)
> > +
> > +#define SUN20I_PWM_CTL(chan)                 (0x100 + (chan) * 0x20)
> > +#define SUN20I_PWM_CTL_ACT_STA                       BIT(8)
> > +#define SUN20I_PWM_CTL_PRESCAL_K             GENMASK(7, 0)
> > +#define SUN20I_PWM_CTL_PRESCAL_K_MAX         field_max(SUN20I_PWM_CTL_=
PRESCAL_K)
> > +
> > +#define SUN20I_PWM_PERIOD(chan)                      (0x104 + (chan) *=
 0x20)
> > +#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE               GENMASK(31, 16)
> > +#define SUN20I_PWM_PERIOD_ACT_CYCLE          GENMASK(15, 0)
> > +
> > +#define SUN20I_PWM_PCNTR_SIZE                        BIT(16)
> > +
> > +/*
> > + * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock=
 dividers
> > + * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESC=
AL_K)
> > + * without using a loop. These dividers limit the # of cycles in a per=
iod
> > + * to SUN20I_PWM_PCNTR_SIZE (65536) by applying a scaling factor of
> > + * 1/(div_m * (prescale_k + 1)) to the clock source.
> > + *
> > + * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
> > + * such that for a given requested period,
> > + *
> > + * i) div_m is minimized for any prescale_k =E2=89=A4 SUN20I_PWM_CTL_P=
RESCAL_K_MAX,
> > + * ii) prescale_k is minimized.
> > + *
> > + * The derivation proceeds as follows, with val =3D # of cycles for re=
quested
> > + * period:
> > + *
> > + * for a given value of div_m we want the smallest prescale_k such tha=
t
> > + *
> > + * (val >> div_m) // (prescale_k + 1) =E2=89=A4 65536 (=3D SUN20I_PWM_=
PCNTR_SIZE)
> > + *
> > + * This is equivalent to:
> > + *
> > + * (val >> div_m) =E2=89=A4 65536 * (prescale_k + 1) + prescale_k
> > + * =E2=9F=BA (val >> div_m) =E2=89=A4 65537 * prescale_k + 65536
> > + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 65537 * prescale_k
> > + * =E2=9F=BA ((val >> div_m) - 65536) / 65537 =E2=89=A4 prescale_k
> > + *
> > + * As prescale_k is integer, this becomes
> > + *
> > + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 prescale_k
> > + *
> > + * And is minimized at
> > + *
> > + * ((val >> div_m) - 65536) // 65537
> > + *
> > + * Now we pick the smallest div_m that satifies prescale_k =E2=89=A4 2=
55
> > + * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
> > + *
> > + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 255
> > + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 255 * 65537 + 65536
> > + * =E2=9F=BA val >> div_m =E2=89=A4 255 * 65537 + 2 * 65536
> > + * =E2=9F=BA val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> > + * =E2=9F=BA div_m =3D fls((val) / (255 * 65537 + 2 * 65536 + 1))
> > + *
> > + * Suggested by Uwe Kleine-K=C3=B6nig
> > + */
> > +#define SUN20I_PWM_MAGIC                     (255 * 65537 + 2 * 65536 =
+ 1)
> > +#define SUN20I_PWM_DIV_CONST                 65537
> > +
> > +struct sun20i_pwm_chip {
> > +     struct clk *clk_hosc, *clk_apb;
> > +     void __iomem *base;
> > +};
> > +
> > +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_ch=
ip *chip)
> > +{
> > +     return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> > +                                unsigned long offset)
> > +{
> > +     return readl(chip->base + offset);
> > +}
> > +
> > +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> > +                                  u32 val, unsigned long offset)
> > +{
> > +     writel(val, chip->base + offset);
> > +}
> > +
> > +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> > +                             struct pwm_device *pwm,
> > +                             struct pwm_state *state)
> > +{
> > +     struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> > +     u16 ent_cycle, act_cycle, prescale_k;
> > +     u64 clk_rate, tmp;
> > +     u8 div_m;
> > +     u32 val;
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwp=
wm / 2));
> > +     div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
> > +     if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> > +             div_m =3D SUN20I_PWM_CLK_DIV_M_MAX;
> > +
> > +     /*
> > +      * If CLK_CFG_SRC is 0, use the hosc clock;
> > +      * otherwise (any nonzero value) use the APB clock.
> > +      */
> > +     if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) =3D=3D 0)
> > +             clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> > +     else
> > +             clk_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm))=
;
> > +     state->polarity =3D (SUN20I_PWM_CTL_ACT_STA & val) ?
> > +                        PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> > +
> > +     prescale_k =3D FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> > +     state->enabled =3D (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? tru=
e : false;
> > +
> > +     val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpw=
m));
> > +     act_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> > +
> > +     ent_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
> > +
> > +     /*
> > +      * The duration of the active phase should not be longer
> > +      * than the duration of the period
> > +      */
> > +     if (act_cycle > ent_cycle)
> > +             act_cycle =3D ent_cycle;
> > +
> > +     /*
> > +      * We have act_cycle <=3D ent_cycle <=3D 0xffff, prescale_k <=3D =
0x100,
> > +      * div_m <=3D 8. So the multiplication fits into an u64 without
> > +      * overflow.
> > +      */
> > +     tmp =3D ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> > +     state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> > +     tmp =3D ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> > +     state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +     struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> > +     u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
> > +     u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
> > +     u32 prescale_k, div_m;
> > +     bool use_bus_clk;
> > +
> > +     pwm_en =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> > +     clk_gate =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_GATE);
> > +
> > +     if (!state->enabled) {
> > +             if (state->enabled !=3D pwm->state.enabled) {
> > +                     clk_gate &=3D ~SUN20I_PWM_CLK_GATE_GATING(pwm->hw=
pwm);
> > +                     pwm_en &=3D ~SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> > +                     sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM=
_ENABLE);
> > +                     sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_P=
WM_CLK_GATE);
> > +             }
> > +             return 0;
> > +     }
> > +
> > +     ctl =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm))=
;
> > +     clk_cfg =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm-=
>hwpwm / 2));
> > +     hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> > +     bus_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> > +     if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> > +             /* If the neighbor channel is enabled, use the current cl=
ock settings */
> > +             use_bus_clk =3D FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg=
) !=3D 0;
> > +             val =3D mul_u64_u64_div_u64(state->period,
> > +                                       (use_bus_clk ? bus_rate : hosc_=
rate),
> > +                                       NSEC_PER_SEC);
> > +
> > +             div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
> > +     } else {
> > +             /*
> > +              * Select the clock source based on the period.
> > +              * Since bus_rate > hosc_rate, which means bus_rate
> > +              * can provide a higher frequency than hosc_rate.
>
> What does that mean, exactly? That we should prefer the faster clock?
> Because that's not what the code does, is it?
>
> > +              */
> > +             use_bus_clk =3D false;
> > +             val =3D mul_u64_u64_div_u64(state->period, hosc_rate, NSE=
C_PER_SEC);
> > +             /*
> > +              * If the calculated value is =E2=89=A4 1, the period is =
too short
> > +              * for proper PWM operation
> > +              */
> > +             if (val <=3D 1) {
>
> So if I get the code correctly, it prefers HOSC over APB? Is that
> really the best way? Shouldn't it be the other way around: we use the
> faster clock, since this will not limit the sibling channel?
>
> And another thing to consider are rounding errors due to integer
> division: certain period rates might be better achievable with one or
> the other source clock: 3 MHz works best as 24MHz/8, 3.125MHz as
> 100MHz/32.
> So shall we calculate the values and compare the errors instead?
> Oh, and also we need to consider bypassing, I feel like this should be
> checked first.
>
> In any case I think there should be a comment describing the strategy
> and give some rationale, I think.

I like the idea of comparing the quantization error for each clock source
(i.e. computing the actual period for both APB and HOSC and choosing
whichever is closer to the requested period).
I can try to implement that error-minimization approach in the next
series of patches and add a comment explaining the strategy.
>
> > +                     use_bus_clk =3D true;
> > +                     val =3D mul_u64_u64_div_u64(state->period, bus_ra=
te, NSEC_PER_SEC);
> > +                     if (val <=3D 1)
> > +                             return -EINVAL;
> > +             }
> > +             div_m =3D fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
> > +             if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> > +                     return -EINVAL;
> > +
> > +             /* Set up the CLK_DIV_M and clock CLK_SRC */
> > +             clk_cfg =3D FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
> > +             clk_cfg |=3D FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_c=
lk);
> > +
> > +             sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CF=
G(pwm->hwpwm / 2));
> > +     }
> > +
> > +     /* Calculate prescale_k and determine the number of cycles for a =
full PWM period */
> > +     ent_cycle =3D val >> div_m;
> > +     prescale_k =3D DIV_ROUND_DOWN_ULL(ent_cycle, SUN20I_PWM_DIV_CONST=
);
> > +     if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
> > +             prescale_k =3D SUN20I_PWM_CTL_PRESCAL_K_MAX;
> > +
> > +     do_div(ent_cycle, prescale_k + 1);
> > +
> > +     /* ent_cycle must not be zero */
> > +     if (ent_cycle =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     /* For N cycles, PPRx.PWM_ENTIRE_CYCLE =3D (N-1) */
> > +     reg_period =3D FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cyc=
le - 1);
> > +
> > +     /* Calculate the active cycles (duty cycle) */
> > +     val =3D mul_u64_u64_div_u64(state->duty_cycle,
> > +                               (use_bus_clk ? bus_rate : hosc_rate),
> > +                               NSEC_PER_SEC);
> > +     act_cycle =3D val >> div_m;
> > +     do_div(act_cycle, prescale_k + 1);
> > +
> > +     /*
> > +      * The formula of the output period and the duty-cycle for PWM ar=
e as follows.
> > +      * T period =3D PWM0_PRESCALE_K / PWM01_CLK * (PPR0.PWM_ENTIRE_CY=
CLE + 1)
> > +      * T high-level =3D PWM0_PRESCALE_K / PWM01_CLK * PPR0.PWM_ACT_CY=
CLE
> > +      * Duty-cycle =3D T high-level / T period
> > +      */
> > +     reg_period |=3D FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle=
);
> > +     sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm-=
>hwpwm));
> > +
> > +     ctl =3D FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
> > +     if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> > +             ctl |=3D SUN20I_PWM_CTL_ACT_STA;
> > +
> > +     sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
> > +
> > +     if (state->enabled !=3D pwm->state.enabled) {
> > +             clk_gate &=3D ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
> > +             clk_gate |=3D SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> > +             pwm_en |=3D SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> > +             sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE)=
;
> > +             sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_G=
ATE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct pwm_ops sun20i_pwm_ops =3D {
> > +     .apply =3D sun20i_pwm_apply,
> > +     .get_state =3D sun20i_pwm_get_state,
> > +};
> > +
> > +static const struct of_device_id sun20i_pwm_dt_ids[] =3D {
> > +     { .compatible =3D "allwinner,sun20i-d1-pwm" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
> > +
> > +static int sun20i_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct pwm_chip *chip;
> > +     struct sun20i_pwm_chip *sun20i_chip;
> > +     struct clk *clk_bus;
> > +     struct reset_control *rst;
> > +     u32 npwm;
> > +     int ret;
> > +
> > +     ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,npwms"=
, &npwm);
> > +     if (ret < 0)
> > +             npwm =3D 8; /* Default value */
> > +
> > +     if (npwm > 16) {
> > +             dev_info(&pdev->dev, "Limiting number of PWM lines from %=
u to 16", npwm);
>
> I don't think we should proceed if the firmware information is clearly
> wrong. Just bail out with -EINVAL or so here, so that gets fixed in the
> DT.
>
> > +             npwm =3D 16;
> > +     }
> > +
> > +     chip =3D devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*sun20i_chip=
));
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +     sun20i_chip =3D to_sun20i_pwm_chip(chip);
> > +
> > +     sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(sun20i_chip->base))
> > +             return PTR_ERR(sun20i_chip->base);
> > +
> > +     clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> > +     if (IS_ERR(clk_bus))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(clk_bus),
> > +                                  "Failed to get bus clock\n");
> > +
> > +     sun20i_chip->clk_hosc =3D devm_clk_get_enabled(&pdev->dev, "hosc"=
);
> > +     if (IS_ERR(sun20i_chip->clk_hosc))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk=
_hosc),
> > +                                  "Failed to get hosc clock\n");
> > +
> > +     ret =3D devm_clk_rate_exclusive_get(&pdev->dev, sun20i_chip->clk_=
hosc);
>
> Just ignoring for a bit that the 24 MHz oscillator is a fixed clock
> anyway, but why would we want exclusivity already at probe time? Isn't
> that too limiting, as no one might ever use any PWM channels, but it
> would still "belong to us"?
>
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "Failed to get hosc exclusive rate\n=
");
> > +
> > +     sun20i_chip->clk_apb =3D devm_clk_get_enabled(&pdev->dev, "apb");
> > +     if (IS_ERR(sun20i_chip->clk_apb))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk=
_apb),
> > +                                  "Failed to get apb clock\n");
> > +
> > +     ret =3D devm_clk_rate_exclusive_get(&pdev->dev, sun20i_chip->clk_=
apb);
>
> Just for the records: APB is practically also a fixed clock, set up
> once in firmware and never changed, since it drives a lot of other
> peripherals.
> But same question as above, why do we lock its rate already here?

That step was actually recommended by Uwe Kleine-K=C3=B6nig,
so the decision on whether to keep or drop exclusive reservation
is really a question for him=E2=80=94please coordinate with Uwe
to agree on how best to proceed here.
>
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "Failed to get apb exclusive rate\n"=
);
> > +
> > +     if (clk_get_rate(sun20i_chip->clk_apb) <=3D clk_get_rate(sun20i_c=
hip->clk_hosc))
> > +             dev_info(&pdev->dev, "APB clock must be greater than hosc=
 clock");
>
> Why this check? Does the code make any assumptions about this relation?
> If yes, we must surely deny this and bail out.
> If not (and I feel we should handle it this way), we can just ignore
> this and not print anything.
>
> Cheers,
> Andre
>
> > +
> > +     rst =3D devm_reset_control_get_exclusive_deasserted(&pdev->dev, N=
ULL);
> > +     if (IS_ERR(rst))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rst),
> > +                                  "Failed to get reset control\n");
> > +
> > +     chip->ops =3D &sun20i_pwm_ops;
> > +
> > +     ret =3D devm_pwmchip_add(&pdev->dev, chip);
> > +     if (ret < 0)
> > +             return dev_err_probe(&pdev->dev, ret, "Failed to add PWM =
chip\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver sun20i_pwm_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "sun20i-pwm",
> > +             .of_match_table =3D sun20i_pwm_dt_ids,
> > +     },
> > +     .probe =3D sun20i_pwm_probe,
> > +};
> > +module_platform_driver(sun20i_pwm_driver);
> > +
> > +MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
> > +MODULE_DESCRIPTION("Allwinner sun20i PWM driver");
> > +MODULE_LICENSE("GPL");
>

Cheers,
Aleksandr

