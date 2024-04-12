Return-Path: <linux-pwm+bounces-1911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A68A2808
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B60BB2443E
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9B4D9FD;
	Fri, 12 Apr 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx63actl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A9482DA;
	Fri, 12 Apr 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907030; cv=none; b=JmeKQrRYZxOvVpEIgEPMRTjmJdS+fLtXEQmAmhqAExdcAnsRv1U4XJLiP3gexIZl5u8mK8Iy2pNiP5eZHlbMk57z+lL57+HbDKMgo9sq508EC/jGBqdmZRssKxGMOWWKahecJ+kTihVRyJZ4o16OzBYdTGiLwpL9UPL1ap8GD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907030; c=relaxed/simple;
	bh=1f/jBaXx7+HlJ+PFyqQhG0GlFursg6LA+qFqvZWG8xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM+1LON55MoarRnX6sezPenmsQpENAlaWjb//3qz22n5TdJWtXsMk07gQq/RiVepmMWQ1Z6EU1vreV0lHLCzOLnJZlKVIal5oPFFzsu5W92GZ3MExhyKkLuCgNg3Oz++3nGZUcPI5xj2FiUbuOyCduHUOZtcxUbuUMULFjv1xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx63actl; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61428e80f0cso4486977b3.2;
        Fri, 12 Apr 2024 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907026; x=1713511826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvO4MgsXb7IUdQ8o6P1OkLdBlha6EXGs5Gso4mIVYGw=;
        b=hx63actl6TzUGr/Ab3gUKjbaMYMz4yb93JcOKjgaxOh1gOoriqpYGimIiMM2abVpbT
         3wRTZXT6TuNkJKDH/nNMHV65nwwvmg8zVP/TA2i0sgtESEKA4Jr7LgEh/ympGvYJx1bA
         KZ2n7h2AQZt9+Q/yE+nBROYKFeoSzqK7udDXG6Jh8ND9I0soaMiDR+JTIFvlhbKIQLqx
         Ce2SItYkH1oXVIkwNzohc4xf3er6i0qD8IS4mcehGA54EzdnC8QPMhCWQeZMmTVXh7jr
         hlVuo1TI7sQxiJD8m9SjuBe49T4/pUkR6I4z+fDyh5eHB2wrQTV/3D6lO2LU4H5EXHsS
         f2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907026; x=1713511826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvO4MgsXb7IUdQ8o6P1OkLdBlha6EXGs5Gso4mIVYGw=;
        b=sfLTIPfkjj91wz866KEFPVKyKA7dmvmT/aFehdYk1EzY9TIR1VxmICfR86/3KI8qoW
         VxJStrr7BjIUVRHvGLCZuGYZZ8U+ehxGxsVx7brBH06A1i8q6j5yyTdWjqwyp2zJ5YTZ
         P6Y9LzIBqZEtDD0A/qK6Jl1FOm3v5iqUuvzSKTpS0a6sUecsNwzPPgvF41KJhsBt8wy7
         V4ti7UXcpe7bwnUCMvXBgjN8xgxrpK/EgKbXHko3czKaQiHG04olgLwT1wBwdYMUlGG4
         dYq3K4fPrfY87C2m/GApfEkVmEXvQQeU1j4gDT7Kd55uuLa3/3Y5OhgrDJw5dw0i3YkR
         PYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+xeemRKMyUwGMCEYdLFn6Ihp8U5QLTXRdiVGQo/rGi5TH2mriCqEQ+B1FAq7Jmrgt49ODZ8+hPW72NfGmLKTkee7ighxD1fQHaauLBdW3l7yqAuhwQ4To7Xvk3vuh6flm6QRmVw==
X-Gm-Message-State: AOJu0YwrJxUb9rRun9SViBcO0cRaswjFGMbQ7QXq2v85BURy25jStofx
	/NRFHR5xyhl8B59wxa0hDnBhzubyhpfQ0QMsDkcoWmZ778R0BPmyUoNnGAkxnSmWBIY958EDyvh
	l1dhYdD5QCSh/9z1yZZk+4J0tY9U5E7DFC5g=
X-Google-Smtp-Source: AGHT+IG7/4ARAqsKxTr0jarBf9X/tTG74VViDnUU7p2K7pIb38lcdfPwNgQKeySthQG6cseX3v7rWK9ZJq7hZRrKKwA=
X-Received: by 2002:a0d:e2d5:0:b0:611:1cfa:334 with SMTP id
 l204-20020a0de2d5000000b006111cfa0334mr1880755ywe.42.1712907026297; Fri, 12
 Apr 2024 00:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712732719.git.zhoubinbin@loongson.cn> <6a37f0eda2880d9a763c89a7b1929b908d8fc4fe.1712732719.git.zhoubinbin@loongson.cn>
 <CAAhV-H5Smw_pj6T=O=_EeSNib9LWcy1QVvRNdyBULLEsdjXB5w@mail.gmail.com>
In-Reply-To: <CAAhV-H5Smw_pj6T=O=_EeSNib9LWcy1QVvRNdyBULLEsdjXB5w@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 12 Apr 2024 13:30:13 +0600
Message-ID: <CAMpQs4JkVEtStCwd07QzDSdBcQ1+JKCMyduoSbni-zBiFW8h2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: Add Loongson PWM controller support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:47=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Binbin,
>
> On Thu, Apr 11, 2024 at 5:16=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.=
cn> wrote:
> >
> > This commit adds a generic PWM framework driver for the PWM controller
> > found on Loongson family chips.
> >
> > Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
> > Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  MAINTAINERS                |   1 +
> >  drivers/pwm/Kconfig        |  10 ++
> >  drivers/pwm/Makefile       |   1 +
> >  drivers/pwm/pwm-loongson.c | 300 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 312 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-loongson.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd0d4e2d02ff..fef232ae8cca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12762,6 +12762,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:     linux-pwm@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> > +F:     drivers/pwm/pwm-loongson.c
> >
> >  LOONGSON-2 SOC SERIES CLOCK DRIVER
> >  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4b956d661755..bb163c65e5ae 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -324,6 +324,16 @@ config PWM_KEEMBAY
> >           To compile this driver as a module, choose M here: the module
> >           will be called pwm-keembay.
> >
> > +config PWM_LOONGSON
> > +       tristate "Loongson PWM support"
> > +       depends on MACH_LOONGSON64
> > +       help
> > +         Generic PWM framework driver for Loongson family.
> > +         It can be found on Loongson-2K series cpu and Loongson LS7A b=
ridge chips.
> > +
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called pwm-loongson.
> > +
> >  config PWM_LP3943
> >         tristate "TI/National Semiconductor LP3943 PWM support"
> >         depends on MFD_LP3943
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index c5ec9e168ee7..bffa49500277 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_INTEL_LGM)   +=3D pwm-intel-lgm.o
> >  obj-$(CONFIG_PWM_IQS620A)      +=3D pwm-iqs620a.o
> >  obj-$(CONFIG_PWM_JZ4740)       +=3D pwm-jz4740.o
> >  obj-$(CONFIG_PWM_KEEMBAY)      +=3D pwm-keembay.o
> > +obj-$(CONFIG_PWM_LOONGSON)     +=3D pwm-loongson.o
> >  obj-$(CONFIG_PWM_LP3943)       +=3D pwm-lp3943.o
> >  obj-$(CONFIG_PWM_LPC18XX_SCT)  +=3D pwm-lpc18xx-sct.o
> >  obj-$(CONFIG_PWM_LPC32XX)      +=3D pwm-lpc32xx.o
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > new file mode 100644
> > index 000000000000..0afae42113a5
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -0,0 +1,300 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Loongson PWM driver
> > + *
> > + * Author: Juxin Gao <gaojuxin@loongson.cn>
> > + * Further cleanup and restructuring by:
> > + *         Binbin Zhou <zhoubinbin@loongson.cn>
> > + *
> > + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/units.h>
> > +
> > +/* Loongson PWM registers */
> > +#define PWM_DUTY       0x4 /* Low Pulse Buffer Register */
> > +#define PWM_PERIOD     0x8 /* Pulse Period Buffer Register */
> > +#define PWM_CTRL       0xc /* Control Register */
> > +
> > +/* Control register bits */
> > +#define PWM_CTRL_EN    BIT(0)  /* Counter Enable Bit */
> > +#define PWM_CTRL_OE    BIT(3)  /* Pulse Output Enable Control Bit, Val=
id Low */
> > +#define PWM_CTRL_SINGLE        BIT(4)  /* Single Pulse Control Bit */
> > +#define PWM_CTRL_INTE  BIT(5)  /* Interrupt Enable Bit */
> > +#define PWM_CTRL_INT   BIT(6)  /* Interrupt Bit */
> > +#define PWM_CTRL_RST   BIT(7)  /* Counter Reset Bit */
> > +#define PWM_CTRL_CAPTE BIT(8)  /* Measurement Pulse Enable Bit */
> > +#define PWM_CTRL_INVERT        BIT(9)  /* Output flip-flop Enable Bit =
*/
> > +#define PWM_CTRL_DZONE BIT(10) /* Anti-dead Zone Enable Bit */
> > +
> > +#define PWM_FREQ_STD       (50 * HZ_PER_KHZ)
> > +
> > +struct pwm_loongson_ddata {
> > +       struct pwm_chip chip;
> > +       struct clk      *clk;
> > +       void __iomem    *base;
> > +       /* The following for PM */
> > +       u32             ctrl;
> > +       u32             duty;
> > +       u32             period;
> > +};
> > +
> > +static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct =
pwm_chip *chip)
> > +{
> > +       return container_of(chip, struct pwm_loongson_ddata, chip);
> > +}
> > +
> > +static inline u32 pwm_loongson_readl(struct pwm_loongson_ddata *ddata,=
 u64 offset)
> > +{
> > +       return readl(ddata->base + offset);
> > +}
> > +
> > +static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddat=
a,
> > +                                      u32 val, u64 offset)
> > +{
> > +       writel(val, ddata->base + offset);
> > +}
> > +
> > +static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm=
_device *pwm,
> > +                                    enum pwm_polarity polarity)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > +       u16 val;
> > +
> > +       val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +
> > +       if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > +               /* Duty cycle defines LOW period of PWM */
> > +               val |=3D PWM_CTRL_INVERT;
> > +       else
> > +               /* Duty cycle defines HIGH period of PWM */
> > +               val &=3D ~PWM_CTRL_INVERT;
> > +
> > +       pwm_loongson_writel(ddata, val, PWM_CTRL);
> A new line is needed here.
>
OK...

> > +       return 0;
> > +}
> > +
> > +static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > +       u32 val;
> > +
> > +       if (pwm->state.polarity =3D=3D PWM_POLARITY_NORMAL)
> > +               pwm_loongson_writel(ddata, ddata->period, PWM_DUTY);
> > +       else if (pwm->state.polarity =3D=3D PWM_POLARITY_INVERSED)
> > +               pwm_loongson_writel(ddata, 0, PWM_DUTY);
> > +
> > +       val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +       val &=3D ~PWM_CTRL_EN;
> > +       pwm_loongson_writel(ddata, val, PWM_CTRL);
> > +}
> > +
> > +static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > +       u32 val;
> > +
> > +       pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
> > +       pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
> > +
> > +       val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +       val |=3D PWM_CTRL_EN;
> > +       pwm_loongson_writel(ddata, val, PWM_CTRL);
> > +
> > +       return 0;
> > +}
> > +
> > +static u32 pwm_loongson_set_config(struct pwm_loongson_ddata *ddata, i=
nt ns,
> > +                                  u64 clk_rate, u64 offset)
> > +{
> > +       u32 val;
> > +       u64 c;
> > +
> > +       c =3D clk_rate * ns;
> > +       do_div(c, NSEC_PER_SEC);
> > +       val =3D c < 1 ? 1 : c;
> > +
> > +       pwm_loongson_writel(ddata, val, offset);
> > +
> > +       return val;
> > +}
> > +
> > +static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +                              int duty_ns, int period_ns)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > +       struct device *dev =3D chip->dev;
> > +       u64 clk_rate;
> > +
> > +       if (period_ns > NANOHZ_PER_HZ || duty_ns > NANOHZ_PER_HZ)
> > +               return -ERANGE;
> > +
> > +       clk_rate =3D has_acpi_companion(dev) ? PWM_FREQ_STD
> > +                : clk_get_rate(ddata->clk);
> Long lines are acceptable because there is no 80 columns restriction now.
>
> > +
> > +       ddata->period =3D pwm_loongson_set_config(ddata, period_ns,
> > +                                               clk_rate, PWM_PERIOD);
> The same here. And moving the "period" sentence after "duty" is a
> little better because the order will be the same as in
> pwm_loongson_ddata.
>
OK, I would check the entire code again.

> > +       ddata->duty =3D pwm_loongson_set_config(ddata, duty_ns, clk_rat=
e, PWM_DUTY);
> > +
> > +       return 0;
> > +}
> > +
> > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                             const struct pwm_state *state)
> > +{
> > +       int err;
> > +       bool enabled =3D pwm->state.enabled;
> > +
> > +       if (state->polarity !=3D pwm->state.polarity) {
> > +               if (enabled) {
> > +                       pwm_loongson_disable(chip, pwm);
> > +                       enabled =3D false;
> > +               }
> > +
> > +               err =3D pwm_loongson_set_polarity(chip, pwm, state->pol=
arity);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       if (!state->enabled) {
> > +               if (enabled)
> > +                       pwm_loongson_disable(chip, pwm);
> > +               return 0;
> > +       }
> > +
> > +       err =3D pwm_loongson_config(chip, pwm, state->duty_cycle, state=
->period);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!enabled)
> > +               err =3D pwm_loongson_enable(chip, pwm);
> > +
> > +       return err;
> > +}
> > +
> > +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +                                 struct pwm_state *state)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > +       u32 period, duty, ctrl;
> > +       u64 ns;
> > +
> > +       period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> > +       ns =3D period * NSEC_PER_SEC;
> > +       state->period =3D do_div(ns, period);
> > +
> > +       duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> > +       ns =3D duty * NSEC_PER_SEC;
> > +       state->duty_cycle =3D do_div(ns, duty);
> > +
> > +       ctrl =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +       state->polarity =3D (ctrl & PWM_CTRL_INVERT) ? PWM_POLARITY_INV=
ERSED
> > +                       : PWM_POLARITY_NORMAL;
> > +       state->enabled =3D (ctrl & PWM_CTRL_EN) ? true : false;
> > +
> > +       ddata->ctrl =3D ctrl;
> > +       ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> > +       ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct pwm_ops pwm_loongson_ops =3D {
> > +       .apply =3D pwm_loongson_apply,
> > +       .get_state =3D pwm_loongson_get_state,
> > +};
> > +
> > +static int pwm_loongson_probe(struct platform_device *pdev)
> > +{
> > +       struct pwm_loongson_ddata *ddata;
> > +       struct device *dev =3D &pdev->dev;
> > +
> > +       ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +       if (!ddata)
> > +               return -ENOMEM;
> > +
> > +       ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(ddata->base))
> > +               return PTR_ERR(ddata->base);
> > +
> > +       if (!has_acpi_companion(dev)) {
> > +               ddata->clk =3D devm_clk_get_enabled(dev, NULL);
> > +               if (IS_ERR(ddata->clk))
> > +                       return PTR_ERR(ddata->clk);
> > +       }
> > +
> > +       ddata->chip.dev =3D dev;
> > +       ddata->chip.ops =3D &pwm_loongson_ops;
> > +       ddata->chip.npwm =3D 1;
> > +       platform_set_drvdata(pdev, ddata);
> > +
> > +       return devm_pwmchip_add(dev, &ddata->chip);
> > +}
> > +
> > +static int pwm_loongson_suspend(struct device *dev)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D dev_get_drvdata(dev);
> > +
> > +       ddata->ctrl =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +       ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> > +       ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> > +
> > +       clk_disable_unprepare(ddata->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int pwm_loongson_resume(struct device *dev)
> > +{
> > +       struct pwm_loongson_ddata *ddata =3D dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret =3D clk_prepare_enable(ddata->clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pwm_loongson_writel(ddata, ddata->ctrl, PWM_CTRL);
> > +       pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
> > +       pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
> > +
> > +       return 0;
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(pwm_loongson_pm_ops, pwm_loongson_susp=
end,
> > +                               pwm_loongson_resume);
> > +
> > +static const struct acpi_device_id pwm_loongson_acpi_ids[] =3D {
> > +       { "LOON0006" },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, pwm_loongson_acpi_ids);
> Moving the acpi table after the dt table is a little better because
> the order will be the same as in pwm_loongson_driver.
>

OK, I will adjust the order in the next version.

Thanks.
Binbin

> And others look good to me.
>
> Huacai
>
> > +
> > +static const struct of_device_id pwm_loongson_of_ids[] =3D {
> > +       { .compatible =3D "loongson,ls7a-pwm" },
> > +       { /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, pwm_loongson_of_ids);
> > +
> > +static struct platform_driver pwm_loongson_driver =3D {
> > +       .probe  =3D pwm_loongson_probe,
> > +       .driver =3D {
> > +               .name   =3D "loongson-pwm",
> > +               .pm     =3D pm_ptr(&pwm_loongson_pm_ops),
> > +               .of_match_table   =3D pwm_loongson_of_ids,
> > +               .acpi_match_table =3D pwm_loongson_acpi_ids,
> > +       },
> > +};
> > +module_platform_driver(pwm_loongson_driver);
> > +
> > +MODULE_DESCRIPTION("Loongson PWM driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited.");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.0
> >
> >

