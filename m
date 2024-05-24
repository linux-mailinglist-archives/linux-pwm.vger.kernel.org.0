Return-Path: <linux-pwm+bounces-2234-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248F8CE265
	for <lists+linux-pwm@lfdr.de>; Fri, 24 May 2024 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B20C1C2131F
	for <lists+linux-pwm@lfdr.de>; Fri, 24 May 2024 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6401292DD;
	Fri, 24 May 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOTLgVmb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD81292C3;
	Fri, 24 May 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539391; cv=none; b=YqgC/bFYpSMzCY0ZFqRjEGqGNx9g8B1qARdUqE1toL2PgSB+2c5fSDtqqJM4r+eW6JxTfFW12n3JKADmhtf8vzsBBhDggx6Ks1yN1vC8BkG5mZC6izIV9clkbqwZfPffII6DjSUzKzyTHpJC8mPCqHHnGIMnP1e8Larf4yidG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539391; c=relaxed/simple;
	bh=4hA31vtpsaNvcfAhS+q95vc1AsSGRuyl0izOM9TkIqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBopeDZvuAgoI3pUVHpvBns38PgSw6Ybkh67CUVCAFkzhigaXeTNcMxyzjJOcdRVKdr7Z9gpQaJ+/nh2Q7D7SS1QA2+m+yzxgW9URc2bDysyhzsGjPVkAzXURJ1eS55WUKUwUUi/mXOzQPMtgGVqQVh4yNeEC2ekgBY4u1ph7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOTLgVmb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a083d7ee9so5445957b3.2;
        Fri, 24 May 2024 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716539389; x=1717144189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH3Fys/j3aklEmn45PjuAQUjyf4/TFQKqnoFYRFAo0k=;
        b=iOTLgVmbOo5fLCnAOUWAmXt9DNgN8J48QwrsQc10OE23OyA+CMTYF80RIQ67qfY1Td
         WAq3ZM9/muAJTqTnuN0wnuP/Ew7udLlXF65w+Bs/JEFqay+4nrYc1dOj31VIt/GKx7ff
         KVgq7P7Z1AO20sOmmTZt1kgjVnJOyKWUlig3iV7MKm6TwoKpTfF152F42mC2P5wBZdka
         +xzmgduJ9PjnEhwRv2ezox983qEy+q7MybVg6bd6lc6ND9q+FmMlMwsoaVRpo19Dn3YB
         /ugJYR1hzRgWvTlc51UX+V2k4ZT9dYkDhoTj8T7V22OcW7yoEkTx60uy5De+iO9aosVO
         PB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716539389; x=1717144189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH3Fys/j3aklEmn45PjuAQUjyf4/TFQKqnoFYRFAo0k=;
        b=UzHbPlqUAtMfmTsJ6bDYagXGYkKgl1KC2memRJNLR3gJRppweiWceZ+U3juZrbpgpe
         Xjsh8J984I1lCi4pYA/RLR1T68rRe7AZ+bhXAI+lzTgb8YT+xeGorXTW6o5ooE+Iram0
         /JBOmj4/NioFdbd8BRKei4mJN104aAGYds7WMH0HRWx9Y3tWi6zgCKnwVNomYmWW+Mge
         fPjSPV1Hk+RgO4+P+ynX7+nunCgNrsm9+bNko51P+NT4+lslty8ZzijU6Xq1PdggaE7G
         Fq9qO4rS82ljarzGmJtmgYE3xendTq5jAA9c/Lc3nJ8BCGx3W/PWiMgPmyu7C4gc2hxi
         wAuw==
X-Forwarded-Encrypted: i=1; AJvYcCXngSxLSVMTLTflsE5PNoLbtlqS5kxcc7oURJph3HQhjoXMWCExTrrZmB2X2cBMlEC7IsbspJV5MWNiCoSGuL8EFiYjiJYeKex8aexElKno7rWmcaa87mx9WhgEmTMm8I79ArrQ1Q==
X-Gm-Message-State: AOJu0Yx8Mdt45sUsXal8yOfqhIlKXgLOl6gd34WxbyNnDBxC2SSgsXNJ
	PsOnnsCtYhLzVM4H+i7Rga2Jcuv8E/dEKnWtn8x7Ks1+UTbNreDmzg+NKEYfe/YNNbltyPfppn4
	KXWwL1+d2t9Q6izt0dEdSUQknUB0=
X-Google-Smtp-Source: AGHT+IGheiRqB6HWj77luLhirWJyawY2o8T2dTrGT8ZU7I/j9Z7RflsykCkKsK4ZvYx8zBWo3R7pn2i7vQIJXeho6xY=
X-Received: by 2002:a0d:ea47:0:b0:620:2753:96b8 with SMTP id
 00721157ae682-62a08df7f15mr19585687b3.12.1716539388653; Fri, 24 May 2024
 01:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713164810.git.zhoubinbin@loongson.cn> <c89917023b49fff70bc89ddb66be7da4e0fe67ef.1713164810.git.zhoubinbin@loongson.cn>
 <t3efvxh4d2xvjh4pfrdnho6mwonwm6spjer72ww3wiqx2v3a2x@52ufzsdhc44i>
In-Reply-To: <t3efvxh4d2xvjh4pfrdnho6mwonwm6spjer72ww3wiqx2v3a2x@52ufzsdhc44i>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 24 May 2024 14:29:35 +0600
Message-ID: <CAMpQs4KyX3A-Bxyp7+evBT5Umb03OvpV0VtqrNjAnZPYZ_dNQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

Thanks for your detailed review.

On Thu, May 23, 2024 at 10:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> sorry for taking so long to get back to your patch. reviewing new
> drivers is quite time consuming which makes me often fail to review in a
> timely manner.
>
> On Tue, Apr 16, 2024 at 09:55:15AM +0800, Binbin Zhou wrote:
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
> >  drivers/pwm/pwm-loongson.c | 298 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 310 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-loongson.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ecef2744726d..d32da7c77f0e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12756,6 +12756,7 @@ M:    Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:   linux-pwm@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> > +F:   drivers/pwm/pwm-loongson.c
> >
> >  LOONGSON-2 SOC SERIES CLOCK DRIVER
> >  M:   Yinbo Zhu <zhuyinbo@loongson.cn>
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4b956d661755..bb163c65e5ae 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -324,6 +324,16 @@ config PWM_KEEMBAY
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-keembay.
> >
> > +config PWM_LOONGSON
> > +     tristate "Loongson PWM support"
> > +     depends on MACH_LOONGSON64
>
> Something with || COMPILE_TEST would be nice.

OK..
>
> > +     help
> > +       Generic PWM framework driver for Loongson family.
> > +       It can be found on Loongson-2K series cpu and Loongson LS7A bri=
dge chips.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-loongson.
> > +
> >  config PWM_LP3943
> >       tristate "TI/National Semiconductor LP3943 PWM support"
> >       depends on MFD_LP3943
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index c5ec9e168ee7..bffa49500277 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_INTEL_LGM) +=3D pwm-intel-lgm.o
> >  obj-$(CONFIG_PWM_IQS620A)    +=3D pwm-iqs620a.o
> >  obj-$(CONFIG_PWM_JZ4740)     +=3D pwm-jz4740.o
> >  obj-$(CONFIG_PWM_KEEMBAY)    +=3D pwm-keembay.o
> > +obj-$(CONFIG_PWM_LOONGSON)   +=3D pwm-loongson.o
> >  obj-$(CONFIG_PWM_LP3943)     +=3D pwm-lp3943.o
> >  obj-$(CONFIG_PWM_LPC18XX_SCT)        +=3D pwm-lpc18xx-sct.o
> >  obj-$(CONFIG_PWM_LPC32XX)    +=3D pwm-lpc32xx.o
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > new file mode 100644
> > index 000000000000..5ac79a69acd3
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -0,0 +1,298 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Loongson PWM driver
> > + *
> > + * Author: Juxin Gao <gaojuxin@loongson.cn>
> > + * Further cleanup and restructuring by:
> > + *         Binbin Zhou <zhoubinbin@loongson.cn>
> > + *
> > + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
>
> A paragraph about the hardware capabilities here please. Please answer
> the following questions:
>
>  - How does the hardware behave on disable? (Does it complete the
>    currently running period? Is the output still driven then? If yes,
>    which level?)
>
>  - How does the hardware behave on configuration changes? (Does it
>    complete the currently running period? Are there some glitches
>    expected (like driving an output corresponding to the old period
>    length but the new duty_cycle or similar).
>
>  - Are there any restrictions like: Cannot do 100% relative duty (or
>    0%)?
>
> Stick to the format used in most other drivers such that
>
>         sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/pwm-loongson.c
>
> emits the requested info.
>

OK, I will add it.
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
> > +#define PWM_DUTY     0x4 /* Low Pulse Buffer Register */
> > +#define PWM_PERIOD   0x8 /* Pulse Period Buffer Register */
> > +#define PWM_CTRL     0xc /* Control Register */
>
> Please use a driver specific prefix for these defines. PWM_DUTY is quite
> generic otherwise.

OK, I will rename these defines as LOONGSON_*.
>
> > +
> > +/* Control register bits */
> > +#define PWM_CTRL_EN  BIT(0)  /* Counter Enable Bit */
> > +#define PWM_CTRL_OE  BIT(3)  /* Pulse Output Enable Control Bit, Valid=
 Low */
> > +#define PWM_CTRL_SINGLE      BIT(4)  /* Single Pulse Control Bit */
> > +#define PWM_CTRL_INTE        BIT(5)  /* Interrupt Enable Bit */
> > +#define PWM_CTRL_INT BIT(6)  /* Interrupt Bit */
> > +#define PWM_CTRL_RST BIT(7)  /* Counter Reset Bit */
> > +#define PWM_CTRL_CAPTE       BIT(8)  /* Measurement Pulse Enable Bit *=
/
> > +#define PWM_CTRL_INVERT      BIT(9)  /* Output flip-flop Enable Bit */
> > +#define PWM_CTRL_DZONE       BIT(10) /* Anti-dead Zone Enable Bit */
> > +
> > +#define PWM_FREQ_STD       (50 * HZ_PER_KHZ)
> > +
> > +struct pwm_loongson_ddata {
> > +     struct pwm_chip chip;
> > +     struct clk      *clk;
> > +     void __iomem    *base;
> > +     /* The following for PM */
> > +     u32             ctrl;
> > +     u32             duty;
> > +     u32             period;
>
> This needs updating to cope for commit 05947224ff46 ("pwm: Ensure that
> pwm_chips are allocated using pwmchip_alloc()")
>
> Also I'm not a fan of aligning the member names. If you feel strong
> about it, keep it as is, however.
>

Yes, I have refactored this part based on commit 05947224ff46 ("pwm:
Ensure that pwm_chips are allocated using pwmchip_alloc()").
> > +};
> > +
> > +static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct =
pwm_chip *chip)
> > +{
> > +     return container_of(chip, struct pwm_loongson_ddata, chip);
> > +}
> > +
> > +static inline u32 pwm_loongson_readl(struct pwm_loongson_ddata *ddata,=
 u64 offset)
>
> I don't know about the calling convention on loongson, but I'd expect
> offset to be an unsigned int only, given that (I guess) only PWM_CTRL
> and friends are passed here.
>

Emm...
Actually, unsigned int should be enough.
> > +{
> > +     return readl(ddata->base + offset);
> > +}
> > +
> > +static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddat=
a,
> > +                                    u32 val, u64 offset)
> > +{
> > +     writel(val, ddata->base + offset);
> > +}
> > +
> > +static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm=
_device *pwm,
> > +                                  enum pwm_polarity polarity)
> > +{
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +     u16 val;
> > +
> > +     val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +
> > +     if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > +             /* Duty cycle defines LOW period of PWM */
> > +             val |=3D PWM_CTRL_INVERT;
> > +     else
> > +             /* Duty cycle defines HIGH period of PWM */
> > +             val &=3D ~PWM_CTRL_INVERT;
> > +
> > +     pwm_loongson_writel(ddata, val, PWM_CTRL);
> > +
> > +     return 0;
> > +}
> > +
> > +static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
> > +{
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +     u32 val;
> > +
> > +     if (pwm->state.polarity =3D=3D PWM_POLARITY_NORMAL)
> > +             pwm_loongson_writel(ddata, ddata->period, PWM_DUTY);
> > +     else if (pwm->state.polarity =3D=3D PWM_POLARITY_INVERSED)
> > +             pwm_loongson_writel(ddata, 0, PWM_DUTY);
> > +
> > +     val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +     val &=3D ~PWM_CTRL_EN;
> > +     pwm_loongson_writel(ddata, val, PWM_CTRL);
>
> Technically it's not needed to configure the duty. A consumer who
> expects a certain behaviour is supposed to not disable the PWM.
>

Emm, this is really not necessary.
> > +}
> > +
> > +static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> > +{
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +     u32 val;
> > +
> > +     pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
> > +     pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
>
> pwm_loongson_enable() is called from pwm_loongson_apply() and PWM_DUTY an=
d
> PWM_PERIOD were already written there. So please either only write it
> once, or add a code comment about why writing twice is needed.
>

Sorry, it's my fault. I will keep these regs written only once.
> > +     val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +     val |=3D PWM_CTRL_EN;
> > +     pwm_loongson_writel(ddata, val, PWM_CTRL);
> > +
> > +     return 0;
> > +}
> > +
> > +static u32 pwm_loongson_set_config(struct pwm_loongson_ddata *ddata, i=
nt ns,
> > +                                u64 clk_rate, u64 offset)
> > +{
> > +     u32 val;
> > +     u64 c;
> > +
> > +     c =3D clk_rate * ns;
>
> That migth overflow?!
>
> > +     do_div(c, NSEC_PER_SEC);
> > +     val =3D c < 1 ? 1 : c;
>
> That smells fishy. If a period (or duty_cycle) is requested that is too
> small to be implemented, let .apply() return -EINVAL.
>

In fact, I'm going to rewrite this part, drop the
pwm_loongson_set_config(), and calulate the duty and period in
pwm_loongson_config(), something like:

        /* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
        ctx.duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER=
_SEC);
        pwm_loongson_writel(ddata, ctx.duty, LOONGSON_PWM_REG_DUTY);

        /* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
        ctx.period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate,
NSEC_PER_SEC);
        pwm_loongson_writel(ddata, ctx.period, LOONGSON_PWM_REG_PERIOD);


> > +     pwm_loongson_writel(ddata, val, offset);
> > +
> > +     return val;
> > +}
> > +
> > +static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +                            int duty_ns, int period_ns)
> > +{
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +     struct device *dev =3D chip->dev;
> > +     u64 clk_rate;
> > +
> > +     if (duty_ns > NANOHZ_PER_HZ || period_ns > NANOHZ_PER_HZ)
> > +             return -ERANGE;
>
> Nope, that's wrong. Please configure the biggest possible period not
> bigger than the requested period. So something like:
>
>         period_ns =3D min(period_ns, NANOHZ_PER_HZ);
>
> ; ditto for duty_cycle.

OK.. I will do it in .apply().
>
> > +     clk_rate =3D has_acpi_companion(dev) ? PWM_FREQ_STD : clk_get_rat=
e(ddata->clk);
> > +
> > +     ddata->duty =3D pwm_loongson_set_config(ddata, duty_ns, clk_rate,=
 PWM_DUTY);
> > +     ddata->period =3D pwm_loongson_set_config(ddata, period_ns, clk_r=
ate, PWM_PERIOD);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                           const struct pwm_state *state)
> > +{
> > +     int err;
> > +     bool enabled =3D pwm->state.enabled;
> > +
> > +     if (state->polarity !=3D pwm->state.polarity) {
> > +             if (enabled) {
> > +                     pwm_loongson_disable(chip, pwm);
> > +                     enabled =3D false;
> > +             }
> > +
> > +             err =3D pwm_loongson_set_polarity(chip, pwm, state->polar=
ity);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     if (!state->enabled) {
> > +             if (enabled)
> > +                     pwm_loongson_disable(chip, pwm);
> > +             return 0;
> > +     }
> > +
> > +     err =3D pwm_loongson_config(chip, pwm, state->duty_cycle, state->=
period);
>
> state->duty_cycle is an u64, however it's truncated to an int here.
>

OK, I will fix it.
> > +     if (err)
> > +             return err;
> > +
> > +     if (!enabled)
> > +             err =3D pwm_loongson_enable(chip, pwm);
> > +
> > +     return err;
> > +}
> > +
> > +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +                               struct pwm_state *state)
> > +{
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +     u32 period, duty, ctrl;
> > +     u64 ns;
> > +
> > +     ctrl =3D pwm_loongson_readl(ddata, PWM_CTRL);
> > +     state->polarity =3D (ctrl & PWM_CTRL_INVERT) ? PWM_POLARITY_INVER=
SED : PWM_POLARITY_NORMAL;
> > +     state->enabled =3D (ctrl & PWM_CTRL_EN) ? true : false;
> > +
> > +     duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> > +     ns =3D duty * NSEC_PER_SEC;
> > +     state->duty_cycle =3D do_div(ns, duty);
> > +
> > +     period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> > +     ns =3D period * NSEC_PER_SEC;
> > +     state->period =3D do_div(ns, period);
> > +
> > +     ddata->ctrl =3D ctrl;
> > +     ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> > +     ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
>
> The rounding looks wrong. Did you test with PWM_DEBUG enabled?
>
> I think the value assigned to ddata->period and the other members isn't
> used. Unless I'm mistaken, please drop the assignment.
>

The period, duty and ctrl are prepared for PM. I plan to put these
three parameters separately into the pwm_loongson_context structure. I
think it will look clearer:

struct pwm_loongson_context {
        u32 ctrl;
        u32 duty;
        u32 period;
};

> > +     return 0;
> > +}
> > +
> > +static const struct pwm_ops pwm_loongson_ops =3D {
> > +     .apply =3D pwm_loongson_apply,
> > +     .get_state =3D pwm_loongson_get_state,
> > +};
> > +
> > +static int pwm_loongson_probe(struct platform_device *pdev)
> > +{
> > +     struct pwm_loongson_ddata *ddata;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +     if (!ddata)
> > +             return -ENOMEM;
> > +
> > +     ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(ddata->base))
> > +             return PTR_ERR(ddata->base);
> > +
> > +     if (!has_acpi_companion(dev)) {
> > +             ddata->clk =3D devm_clk_get_enabled(dev, NULL);
> > +             if (IS_ERR(ddata->clk))
> > +                     return PTR_ERR(ddata->clk);
>
> error message with dev_err_probe() please.

OK, I will do it.
>
> > +     }
> > +
> > +     ddata->chip.dev =3D dev;
> > +     ddata->chip.ops =3D &pwm_loongson_ops;
> > +     ddata->chip.npwm =3D 1;
> > +     platform_set_drvdata(pdev, ddata);
>
> The effect of platform_set_drvdata is used in .suspend below, however
> there you use dev_get_drvdata on &pdev->dev. For symmetry I suggest to
> use dev_set_drvdata(dev, ddata) here.
>
> > +     return devm_pwmchip_add(dev, &ddata->chip);
>
> error message iwth dev_err_probe() please (if it fails).

OK, I will add it.
>
> > +}
> > +
> > [...]
> > +static struct platform_driver pwm_loongson_driver =3D {
> > +     .probe  =3D pwm_loongson_probe,
> > +     .driver =3D {
> > +             .name   =3D "loongson-pwm",
> > +             .pm     =3D pm_ptr(&pwm_loongson_pm_ops),
> > +             .of_match_table   =3D pwm_loongson_of_ids,
> > +             .acpi_match_table =3D pwm_loongson_acpi_ids,
>
> This alignment looks really ugly. Please use a single space before the
> =3D. (Or if you must, properly align the =3D.)
>
OK., I will keep  a single space before the =3D.

Thanks.
Binbin
> > +     },
> > +};
> > +module_platform_driver(pwm_loongson_driver);
> > +
> > +MODULE_DESCRIPTION("Loongson PWM driver");
> > +MODULE_AUTHOR("Loongson Technology Corporation Limited.");
> > +MODULE_LICENSE("GPL");
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

