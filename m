Return-Path: <linux-pwm+bounces-1907-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862658A26E8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D121F23550
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F040BE3;
	Fri, 12 Apr 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG9fet8f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDC4085A;
	Fri, 12 Apr 2024 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904435; cv=none; b=UiEqFlI9KnMScXI2BISjG+fSMJAV+vlsEsZXF90iSYxGAwkMnbduabEFwV8EPRB1MFquGH7bruW0XC/XIBwhoX2f7RlY9Yu1nytRGwgus7eREv6Y9TPniDylqWDYVNdrdlOH+fPVe3BbeMU6b87+VvYrdBDn7UcC0FLjXirrCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904435; c=relaxed/simple;
	bh=wKiLrCp6fCN4iaMwAjphuSytXreD+DWNdbD8TeZrp3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9VXxnNj5/ak8FqUfmVe7bJz5tfM85dofB430r0rJVvSGVYysYuhXvq7IdJGMNTLsQKRzWmgays8ZcAfGg7cdJBoJeLEhYsdWX3JijhK6HWWTs1Dx514MEurSYv0JyUca7J6PdWLYuf0p03FlMT5NIZsUJ78/2DdUoV09nK+BVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG9fet8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFCDC32786;
	Fri, 12 Apr 2024 06:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712904435;
	bh=wKiLrCp6fCN4iaMwAjphuSytXreD+DWNdbD8TeZrp3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vG9fet8fmsg9QWamFa05NESyCetzlr0qsZLhRIQoApXgFPLfOuk71h0/eXrRL2/sz
	 7OZFcet9BPHj9GYfRgtSJusFdus5AYtJjIv7CZ5WlO82IgyogB7huqzZhX/cW/ovo8
	 E0PnH34mEPZaSdAiW0zRmTUA9GgbUJ+39Lq7DzvJc6l9Tyr229lNuFKJSckPCQH6Y6
	 OKhCE3bBa79im26++h7NaByVB06fKO6QNgXW/HGwRoq+Nre5+5QP1iwg9C+ypKXXVv
	 V6cXP3D9Wg4qhrmrPQSInimh/m8d3jJTPCjgo5aDGhcKXdzjcTTGU4AdavN/Zk/c4d
	 evYS8LbyYpaCw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5224dfa9adso98137066b.0;
        Thu, 11 Apr 2024 23:47:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBGOL9DjmfSz9QBux/odMDgCnIo5huGqjW+WaJj7j4Qxp6NY+czDeNPcIJzgjbHqO0WZFntP9AgkNow1pVzmbQVf5HKX3rrdI4KOhDp0t6pWBm6I6Y0absWcVjWqkJEjUeqoNvEg==
X-Gm-Message-State: AOJu0YzrtWK1xjuIWC8P18Rn/O+cp77cD4NgJPsYtMySNNwbX5sAi7Bi
	E0+TNunR/aC2oag1YYkk0oIMclaqwyGyTPlD/DUE479OCMT17ugrOTFsfR2VXagLRp/2xKFrNd1
	w6BZlX6BKKUoJKGId7RL5/eHpJJ4=
X-Google-Smtp-Source: AGHT+IFKY4P0K7H+yKTtB94FvQDXNSbklhWXmAPB+g0tno+5YbAMun9CgeLDFaWe6sHHQZv6jbVT2uhZ94CHafmUAbI=
X-Received: by 2002:a17:907:720c:b0:a52:1e5a:3ec4 with SMTP id
 dr12-20020a170907720c00b00a521e5a3ec4mr4073408ejc.5.1712904433765; Thu, 11
 Apr 2024 23:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712732719.git.zhoubinbin@loongson.cn> <6a37f0eda2880d9a763c89a7b1929b908d8fc4fe.1712732719.git.zhoubinbin@loongson.cn>
In-Reply-To: <6a37f0eda2880d9a763c89a7b1929b908d8fc4fe.1712732719.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Apr 2024 14:47:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Smw_pj6T=O=_EeSNib9LWcy1QVvRNdyBULLEsdjXB5w@mail.gmail.com>
Message-ID: <CAAhV-H5Smw_pj6T=O=_EeSNib9LWcy1QVvRNdyBULLEsdjXB5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: Add Loongson PWM controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, loongson-kernel@lists.loongnix.cn, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Thu, Apr 11, 2024 at 5:16=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> This commit adds a generic PWM framework driver for the PWM controller
> found on Loongson family chips.
>
> Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                |   1 +
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-loongson.c | 300 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 312 insertions(+)
>  create mode 100644 drivers/pwm/pwm-loongson.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0d4e2d02ff..fef232ae8cca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12762,6 +12762,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
>  L:     linux-pwm@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> +F:     drivers/pwm/pwm-loongson.c
>
>  LOONGSON-2 SOC SERIES CLOCK DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..bb163c65e5ae 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -324,6 +324,16 @@ config PWM_KEEMBAY
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-keembay.
>
> +config PWM_LOONGSON
> +       tristate "Loongson PWM support"
> +       depends on MACH_LOONGSON64
> +       help
> +         Generic PWM framework driver for Loongson family.
> +         It can be found on Loongson-2K series cpu and Loongson LS7A bri=
dge chips.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-loongson.
> +
>  config PWM_LP3943
>         tristate "TI/National Semiconductor LP3943 PWM support"
>         depends on MFD_LP3943
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..bffa49500277 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_INTEL_LGM)   +=3D pwm-intel-lgm.o
>  obj-$(CONFIG_PWM_IQS620A)      +=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)       +=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)      +=3D pwm-keembay.o
> +obj-$(CONFIG_PWM_LOONGSON)     +=3D pwm-loongson.o
>  obj-$(CONFIG_PWM_LP3943)       +=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)  +=3D pwm-lpc18xx-sct.o
>  obj-$(CONFIG_PWM_LPC32XX)      +=3D pwm-lpc32xx.o
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> new file mode 100644
> index 000000000000..0afae42113a5
> --- /dev/null
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Loongson PWM driver
> + *
> + * Author: Juxin Gao <gaojuxin@loongson.cn>
> + * Further cleanup and restructuring by:
> + *         Binbin Zhou <zhoubinbin@loongson.cn>
> + *
> + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/units.h>
> +
> +/* Loongson PWM registers */
> +#define PWM_DUTY       0x4 /* Low Pulse Buffer Register */
> +#define PWM_PERIOD     0x8 /* Pulse Period Buffer Register */
> +#define PWM_CTRL       0xc /* Control Register */
> +
> +/* Control register bits */
> +#define PWM_CTRL_EN    BIT(0)  /* Counter Enable Bit */
> +#define PWM_CTRL_OE    BIT(3)  /* Pulse Output Enable Control Bit, Valid=
 Low */
> +#define PWM_CTRL_SINGLE        BIT(4)  /* Single Pulse Control Bit */
> +#define PWM_CTRL_INTE  BIT(5)  /* Interrupt Enable Bit */
> +#define PWM_CTRL_INT   BIT(6)  /* Interrupt Bit */
> +#define PWM_CTRL_RST   BIT(7)  /* Counter Reset Bit */
> +#define PWM_CTRL_CAPTE BIT(8)  /* Measurement Pulse Enable Bit */
> +#define PWM_CTRL_INVERT        BIT(9)  /* Output flip-flop Enable Bit */
> +#define PWM_CTRL_DZONE BIT(10) /* Anti-dead Zone Enable Bit */
> +
> +#define PWM_FREQ_STD       (50 * HZ_PER_KHZ)
> +
> +struct pwm_loongson_ddata {
> +       struct pwm_chip chip;
> +       struct clk      *clk;
> +       void __iomem    *base;
> +       /* The following for PM */
> +       u32             ctrl;
> +       u32             duty;
> +       u32             period;
> +};
> +
> +static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct pw=
m_chip *chip)
> +{
> +       return container_of(chip, struct pwm_loongson_ddata, chip);
> +}
> +
> +static inline u32 pwm_loongson_readl(struct pwm_loongson_ddata *ddata, u=
64 offset)
> +{
> +       return readl(ddata->base + offset);
> +}
> +
> +static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddata,
> +                                      u32 val, u64 offset)
> +{
> +       writel(val, ddata->base + offset);
> +}
> +
> +static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +                                    enum pwm_polarity polarity)
> +{
> +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +       u16 val;
> +
> +       val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +
> +       if (polarity =3D=3D PWM_POLARITY_INVERSED)
> +               /* Duty cycle defines LOW period of PWM */
> +               val |=3D PWM_CTRL_INVERT;
> +       else
> +               /* Duty cycle defines HIGH period of PWM */
> +               val &=3D ~PWM_CTRL_INVERT;
> +
> +       pwm_loongson_writel(ddata, val, PWM_CTRL);
A new line is needed here.

> +       return 0;
> +}
> +
> +static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +       u32 val;
> +
> +       if (pwm->state.polarity =3D=3D PWM_POLARITY_NORMAL)
> +               pwm_loongson_writel(ddata, ddata->period, PWM_DUTY);
> +       else if (pwm->state.polarity =3D=3D PWM_POLARITY_INVERSED)
> +               pwm_loongson_writel(ddata, 0, PWM_DUTY);
> +
> +       val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +       val &=3D ~PWM_CTRL_EN;
> +       pwm_loongson_writel(ddata, val, PWM_CTRL);
> +}
> +
> +static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +       u32 val;
> +
> +       pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
> +       pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
> +
> +       val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +       val |=3D PWM_CTRL_EN;
> +       pwm_loongson_writel(ddata, val, PWM_CTRL);
> +
> +       return 0;
> +}
> +
> +static u32 pwm_loongson_set_config(struct pwm_loongson_ddata *ddata, int=
 ns,
> +                                  u64 clk_rate, u64 offset)
> +{
> +       u32 val;
> +       u64 c;
> +
> +       c =3D clk_rate * ns;
> +       do_div(c, NSEC_PER_SEC);
> +       val =3D c < 1 ? 1 : c;
> +
> +       pwm_loongson_writel(ddata, val, offset);
> +
> +       return val;
> +}
> +
> +static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +                              int duty_ns, int period_ns)
> +{
> +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +       struct device *dev =3D chip->dev;
> +       u64 clk_rate;
> +
> +       if (period_ns > NANOHZ_PER_HZ || duty_ns > NANOHZ_PER_HZ)
> +               return -ERANGE;
> +
> +       clk_rate =3D has_acpi_companion(dev) ? PWM_FREQ_STD
> +                : clk_get_rate(ddata->clk);
Long lines are acceptable because there is no 80 columns restriction now.

> +
> +       ddata->period =3D pwm_loongson_set_config(ddata, period_ns,
> +                                               clk_rate, PWM_PERIOD);
The same here. And moving the "period" sentence after "duty" is a
little better because the order will be the same as in
pwm_loongson_ddata.

> +       ddata->duty =3D pwm_loongson_set_config(ddata, duty_ns, clk_rate,=
 PWM_DUTY);
> +
> +       return 0;
> +}
> +
> +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +                             const struct pwm_state *state)
> +{
> +       int err;
> +       bool enabled =3D pwm->state.enabled;
> +
> +       if (state->polarity !=3D pwm->state.polarity) {
> +               if (enabled) {
> +                       pwm_loongson_disable(chip, pwm);
> +                       enabled =3D false;
> +               }
> +
> +               err =3D pwm_loongson_set_polarity(chip, pwm, state->polar=
ity);
> +               if (err)
> +                       return err;
> +       }
> +
> +       if (!state->enabled) {
> +               if (enabled)
> +                       pwm_loongson_disable(chip, pwm);
> +               return 0;
> +       }
> +
> +       err =3D pwm_loongson_config(chip, pwm, state->duty_cycle, state->=
period);
> +       if (err)
> +               return err;
> +
> +       if (!enabled)
> +               err =3D pwm_loongson_enable(chip, pwm);
> +
> +       return err;
> +}
> +
> +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +                                 struct pwm_state *state)
> +{
> +       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +       u32 period, duty, ctrl;
> +       u64 ns;
> +
> +       period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> +       ns =3D period * NSEC_PER_SEC;
> +       state->period =3D do_div(ns, period);
> +
> +       duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> +       ns =3D duty * NSEC_PER_SEC;
> +       state->duty_cycle =3D do_div(ns, duty);
> +
> +       ctrl =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +       state->polarity =3D (ctrl & PWM_CTRL_INVERT) ? PWM_POLARITY_INVER=
SED
> +                       : PWM_POLARITY_NORMAL;
> +       state->enabled =3D (ctrl & PWM_CTRL_EN) ? true : false;
> +
> +       ddata->ctrl =3D ctrl;
> +       ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> +       ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> +
> +       return 0;
> +}
> +
> +static const struct pwm_ops pwm_loongson_ops =3D {
> +       .apply =3D pwm_loongson_apply,
> +       .get_state =3D pwm_loongson_get_state,
> +};
> +
> +static int pwm_loongson_probe(struct platform_device *pdev)
> +{
> +       struct pwm_loongson_ddata *ddata;
> +       struct device *dev =3D &pdev->dev;
> +
> +       ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +       if (!ddata)
> +               return -ENOMEM;
> +
> +       ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(ddata->base))
> +               return PTR_ERR(ddata->base);
> +
> +       if (!has_acpi_companion(dev)) {
> +               ddata->clk =3D devm_clk_get_enabled(dev, NULL);
> +               if (IS_ERR(ddata->clk))
> +                       return PTR_ERR(ddata->clk);
> +       }
> +
> +       ddata->chip.dev =3D dev;
> +       ddata->chip.ops =3D &pwm_loongson_ops;
> +       ddata->chip.npwm =3D 1;
> +       platform_set_drvdata(pdev, ddata);
> +
> +       return devm_pwmchip_add(dev, &ddata->chip);
> +}
> +
> +static int pwm_loongson_suspend(struct device *dev)
> +{
> +       struct pwm_loongson_ddata *ddata =3D dev_get_drvdata(dev);
> +
> +       ddata->ctrl =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +       ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> +       ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> +
> +       clk_disable_unprepare(ddata->clk);
> +
> +       return 0;
> +}
> +
> +static int pwm_loongson_resume(struct device *dev)
> +{
> +       struct pwm_loongson_ddata *ddata =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D clk_prepare_enable(ddata->clk);
> +       if (ret)
> +               return ret;
> +
> +       pwm_loongson_writel(ddata, ddata->ctrl, PWM_CTRL);
> +       pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
> +       pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
> +
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(pwm_loongson_pm_ops, pwm_loongson_suspen=
d,
> +                               pwm_loongson_resume);
> +
> +static const struct acpi_device_id pwm_loongson_acpi_ids[] =3D {
> +       { "LOON0006" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, pwm_loongson_acpi_ids);
Moving the acpi table after the dt table is a little better because
the order will be the same as in pwm_loongson_driver.

And others look good to me.

Huacai

> +
> +static const struct of_device_id pwm_loongson_of_ids[] =3D {
> +       { .compatible =3D "loongson,ls7a-pwm" },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, pwm_loongson_of_ids);
> +
> +static struct platform_driver pwm_loongson_driver =3D {
> +       .probe  =3D pwm_loongson_probe,
> +       .driver =3D {
> +               .name   =3D "loongson-pwm",
> +               .pm     =3D pm_ptr(&pwm_loongson_pm_ops),
> +               .of_match_table   =3D pwm_loongson_of_ids,
> +               .acpi_match_table =3D pwm_loongson_acpi_ids,
> +       },
> +};
> +module_platform_driver(pwm_loongson_driver);
> +
> +MODULE_DESCRIPTION("Loongson PWM driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited.");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>
>

