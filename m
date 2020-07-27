Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D425F22FB31
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgG0VRh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0VRg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 17:17:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639EFC061794;
        Mon, 27 Jul 2020 14:17:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w9so18489463ejc.8;
        Mon, 27 Jul 2020 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F48t/LRgf7433YglCJjN+aanMPuIv57dhf/2gqIRrT0=;
        b=IUrU9CNh3GRSe82lQVB8ICVfpXYGLB0gHHVKeEUaETwM7vJFVGys6pmSEe9QhYx3Kq
         Gp4I4Mt0IXMmYkB4FwoLjpPAU4O7mkr4HUVe+O5wlf9v1E80ZPVSThGcvX0K2u6wwe1k
         KDJ6IP8V4zWV5Ty1YjpyI3fsHI5PPaNSItYim7rYPWzzjVnKkuvWMOwRE9nqJBWb1nCD
         v2sI1c/AYO6VwvzIkdymXOrRoQoItcUmYSk8M/GdAjyErjf66xAY2+8WI3lkqEFVAEBa
         TYcnKYfCLSTLKQbw6iEVWve/KDusaMsioLYIBAiLadbxnVNKFrpiMvGGlDtzYIZRg9P3
         t/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F48t/LRgf7433YglCJjN+aanMPuIv57dhf/2gqIRrT0=;
        b=MeEUptNhNm7gm/dE3xrsApXbLZVlRaJxOS0bPpRMyajISrRtFez4IJEkBP1Tw519oV
         FvJmfhyDuokLUa19XtY+eYHecGr80w0XYgw/+PF9RJCkLSQzUopGr2QlqD5oRse6mSiJ
         zYfP6avrzdR19IA7YOWKrGh1PKNZv4CNNYoXQ7dpOT4aCUo836xBh1oS4SH2J38UA+xM
         coO75rdoQYnimJYlImqpq5YrRJyFASJDGaB5ozn+o83px0i4Ei1aEeErH6lr4wZF05A8
         dlFLV7INPXQOalWDQtkwRIvJx6kz/t805flAvoaFt8iLCrHYuAZuTIQ63GQCUEPCQUgU
         to8g==
X-Gm-Message-State: AOAM5324B/iLWx2qYn2fnRnvvRASmBgHP3tAgmX/wmR+v9sERWWiRrVm
        9d2wBHK8n6Nw8L8/wr6vg2QSOjp38Os4aP+FwXo=
X-Google-Smtp-Source: ABdhPJwK2hZ0yXbXvn7rApvdcCaRWlFwOtmili5bm9fqipDLFcnLb8wpQgNw6C60oMlXU8DIMyqtlBLkoscZHVBiVYA=
X-Received: by 2002:a17:906:6b87:: with SMTP id l7mr3215660ejr.198.1595884654957;
 Mon, 27 Jul 2020 14:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-4-martin.botka1@gmail.com> <20200727200954.pzw6swdboa65474i@pengutronix.de>
In-Reply-To: <20200727200954.pzw6swdboa65474i@pengutronix.de>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 27 Jul 2020 23:16:57 +0200
Message-ID: <CADQ2G_EMUdf2BEwjDOCyz_ccMTsjMBM3GmpRe+n6V9-DJGr-Kg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/6] pwm: pwm-qti-lpg: Add PWM driver for QTI LPG module
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

Mo 27. 7. 2020 at 22:10 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.=
de> wrote:
>
> On Fri, Jul 24, 2020 at 11:36:53PM +0200, Martin Botka wrote:
> > From: Fenglin Wu <fenglinw@codeaurora.org>
> >
> > Add pwm_chip to support QTI LPG module and export LPG channels as
> > PWM devices for consumer drivers' usage.
> >
> > Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> > [martin.botka1@gmail.com: Fast-forward the driver from kernel 4.14 to 5=
.8]
> > Signed-off-by: Martin Botka <martin.botka1@gmail.com>
> > ---
> >  drivers/pwm/Kconfig       |   10 +
> >  drivers/pwm/Makefile      |    1 +
> >  drivers/pwm/pwm-qti-lpg.c | 1284 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1295 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-qti-lpg.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index cb8d739067d2..8a52d6884a9a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -399,6 +399,16 @@ config PWM_RCAR
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-rcar.
> >
> > +config PWM_QTI_LPG
> > +     tristate "Qualcomm Technologies, Inc. LPG driver"
> > +     depends on  MFD_SPMI_PMIC && OF
> > +     help
> > +       This driver supports the LPG (Light Pulse Generator) module fou=
nd in
> > +       Qualcomm Technologies, Inc. PMIC chips. Each LPG channel can be
> > +       configured to operate in PWM mode to output a fixed amplitude w=
ith
> > +       variable duty cycle or in LUT (Look up table) mode to output PW=
M
> > +       signal with a modulated amplitude.
> > +
> >  config PWM_RENESAS_TPU
> >       tristate "Renesas TPU PWM support"
> >       depends on ARCH_RENESAS || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index a59c710e98c7..3555a6aa3f33 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_PCA9685)   +=3D pwm-pca9685.o
> >  obj-$(CONFIG_PWM_PUV3)               +=3D pwm-puv3.o
> >  obj-$(CONFIG_PWM_PXA)                +=3D pwm-pxa.o
> >  obj-$(CONFIG_PWM_RCAR)               +=3D pwm-rcar.o
> > +obj-$(CONFIG_PWM_QTI_LPG)    +=3D pwm-qti-lpg.o
>
> Please keep this list alphabetically sorted.

OK

>
> >  obj-$(CONFIG_PWM_RENESAS_TPU)        +=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)   +=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > diff --git a/drivers/pwm/pwm-qti-lpg.c b/drivers/pwm/pwm-qti-lpg.c
> > new file mode 100644
> > index 000000000000..d24c3b3a3d8c
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-qti-lpg.c
> > @@ -0,0 +1,1284 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#define pr_fmt(fmt) "%s: " fmt, __func__
>
> This smells like debug stuff. Please drop this.

What do you mean ?
The #define pr_fmt(fmt) or the tons of REG definitions ?

>
> > +#include <linux/bitops.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#define REG_SIZE_PER_LPG 0x100
> > +#define LPG_BASE "lpg-base"
> > +#define LUT_BASE "lut-base"
> > +
> > +/* LPG module registers */
> > +#define REG_LPG_PERPH_SUBTYPE 0x05
> > +#define REG_LPG_PATTERN_CONFIG 0x40
> > +#define REG_LPG_PWM_SIZE_CLK 0x41
> > +#define REG_LPG_PWM_FREQ_PREDIV_CLK 0x42
> > +#define REG_LPG_PWM_TYPE_CONFIG 0x43
> > +#define REG_LPG_PWM_VALUE_LSB 0x44
> > +#define REG_LPG_PWM_VALUE_MSB 0x45
> > +#define REG_LPG_ENABLE_CONTROL 0x46
> > +#define REG_LPG_PWM_SYNC 0x47
> > +#define REG_LPG_RAMP_STEP_DURATION_LSB 0x50
> > +#define REG_LPG_RAMP_STEP_DURATION_MSB 0x51
> > +#define REG_LPG_PAUSE_HI_MULTIPLIER 0x52
> > +#define REG_LPG_PAUSE_LO_MULTIPLIER 0x54
> > +#define REG_LPG_HI_INDEX 0x56
> > +#define REG_LPG_LO_INDEX 0x57
> > +
> > +/* REG_LPG_PATTERN_CONFIG */
> > +#define LPG_PATTERN_EN_PAUSE_LO BIT(0)
> > +#define LPG_PATTERN_EN_PAUSE_HI BIT(1)
> > +#define LPG_PATTERN_RAMP_TOGGLE BIT(2)
> > +#define LPG_PATTERN_REPEAT BIT(3)
> > +#define LPG_PATTERN_RAMP_LO_TO_HI BIT(4)
> > +
> > +/* REG_LPG_PERPH_SUBTYPE */
> > +#define SUBTYPE_PWM 0x0b
> > +#define SUBTYPE_LPG_LITE 0x11
> > +
> > +/* REG_LPG_PWM_SIZE_CLK */
> > +#define LPG_PWM_SIZE_LPG_MASK BIT(4)
> > +#define LPG_PWM_SIZE_PWM_MASK BIT(2)
> > +#define LPG_PWM_SIZE_LPG_SHIFT 4
> > +#define LPG_PWM_SIZE_PWM_SHIFT 2
> > +#define LPG_PWM_CLK_FREQ_SEL_MASK GENMASK(1, 0)
> > +
> > +/* REG_LPG_PWM_FREQ_PREDIV_CLK */
> > +#define LPG_PWM_FREQ_PREDIV_MASK GENMASK(6, 5)
> > +#define LPG_PWM_FREQ_PREDIV_SHIFT 5
> > +#define LPG_PWM_FREQ_EXPONENT_MASK GENMASK(2, 0)
> > +
> > +/* REG_LPG_PWM_TYPE_CONFIG */
> > +#define LPG_PWM_EN_GLITCH_REMOVAL_MASK BIT(5)
> > +
> > +/* REG_LPG_PWM_VALUE_LSB */
> > +#define LPG_PWM_VALUE_LSB_MASK GENMASK(7, 0)
> > +
> > +/* REG_LPG_PWM_VALUE_MSB */
> > +#define LPG_PWM_VALUE_MSB_MASK BIT(0)
> > +
> > +/* REG_LPG_ENABLE_CONTROL */
> > +#define LPG_EN_LPG_OUT_BIT BIT(7)
> > +#define LPG_EN_LPG_OUT_SHIFT 7
> > +#define LPG_PWM_SRC_SELECT_MASK BIT(2)
> > +#define LPG_PWM_SRC_SELECT_SHIFT 2
> > +#define LPG_EN_RAMP_GEN_MASK BIT(1)
> > +#define LPG_EN_RAMP_GEN_SHIFT 1
> > +
> > +/* REG_LPG_PWM_SYNC */
> > +#define LPG_PWM_VALUE_SYNC BIT(0)
> > +
> > +#define NUM_PWM_SIZE 2
> > +#define NUM_PWM_CLK 3
> > +#define NUM_CLK_PREDIV 4
> > +#define NUM_PWM_EXP 8
> > +
> > +#define LPG_HI_LO_IDX_MASK GENMASK(5, 0)
> > +
> > +/* LUT module registers */
> > +#define REG_LPG_LUT_1_LSB 0x42
> > +#define REG_LPG_LUT_RAMP_CONTROL 0xc8
> > +
> > +#define LPG_LUT_VALUE_MSB_MASK BIT(0)
> > +#define LPG_LUT_COUNT_MAX 47
> > +
> > +enum lpg_src {
> > +     LUT_PATTERN =3D 0,
> > +     PWM_VALUE,
> > +};
> > +
> > +static const int pwm_size[NUM_PWM_SIZE] =3D { 6, 9 };
> > +static const int clk_freq_hz[NUM_PWM_CLK] =3D { 1024, 32768, 19200000 =
};
> > +static const int clk_prediv[NUM_CLK_PREDIV] =3D { 1, 3, 5, 6 };
> > +static const int pwm_exponent[NUM_PWM_EXP] =3D { 0, 1, 2, 3, 4, 5, 6, =
7 };
>
> I don't know what the compiler makes of these arrays, but the last one
> at least can be replaces by some simple math.

Yup.

>
> > +static int qpnp_lut_masked_write(struct qpnp_lpg_lut *lut, u16 addr, u=
8 mask,
> > +                              u8 val)
> > +{
> > +     int rc;
> > +
> > +     mutex_lock(&lut->chip->bus_lock);
> > +     rc =3D regmap_update_bits(lut->chip->regmap, lut->reg_base + addr=
, mask,
> > +                             val);
> > +     if (rc < 0)
> > +             dev_err(lut->chip->dev,
> > +                     "Update addr 0x%x to val 0x%x with mask 0x%x fail=
ed, rc=3D%d\n",
> > +                     lut->reg_base + addr, val, mask, rc);
> > +     mutex_unlock(&lut->chip->bus_lock);
>
> The error logging can be moved out of the lock.

Will do.

>
> > +
> > +     return rc;
> > +}
> > +
> > +static struct qpnp_lpg_channel *pwm_dev_to_qpnp_lpg(struct pwm_chip *p=
wm_chip,
> > +                                                 struct pwm_device *pw=
m)
> > +{
> > +     struct qpnp_lpg_chip *chip =3D
> > +             container_of(pwm_chip, struct qpnp_lpg_chip, pwm_chip);
> > +     u32 hw_idx =3D pwm->hwpwm;
> > +
> > +     if (hw_idx >=3D chip->num_lpgs) {
> > +             dev_err(chip->dev, "hw index %d out of range [0-%d]\n", h=
w_idx,
> > +                     chip->num_lpgs - 1);
> > +             return NULL;
> > +     }
> > +
> > +     return &chip->lpgs[hw_idx];
> > +}
> > +
> > +static int __find_index_in_array(int member, const int array[], int le=
ngth)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < length; i++) {
> > +             if (member =3D=3D array[i])
> > +                     return i;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int qpnp_lpg_set_glitch_removal(struct qpnp_lpg_channel *lpg, b=
ool en)
> > +{
> > +     int rc;
> > +     u8 mask, val;
> > +
> > +     val =3D en ? LPG_PWM_EN_GLITCH_REMOVAL_MASK : 0;
> > +     mask =3D LPG_PWM_EN_GLITCH_REMOVAL_MASK;
> > +     rc =3D qpnp_lpg_masked_write(lpg, REG_LPG_PWM_TYPE_CONFIG, mask, =
val);
> > +     if (rc < 0)
> > +             dev_err(lpg->chip->dev,
> > +                     "Write LPG_PWM_TYPE_CONFIG failed, rc=3D%d\n", rc=
);
>
> qpnp_lpg_masked_write already issues a warning.
>
> > +     return rc;
> > +}
> > +
> > [...]
> > +static const struct pwm_ops qpnp_lpg_pwm_ops =3D {
> > +     .config =3D qpnp_lpg_pwm_config,
> > +     .config_extend =3D qpnp_lpg_pwm_config_extend,
> > +     .get_output_type_supported =3D qpnp_lpg_pwm_output_types_supporte=
d,
> > +     .set_output_type =3D qpnp_lpg_pwm_set_output_type,
> > +     .set_output_pattern =3D qpnp_lpg_pwm_set_output_pattern,
> > +     .enable =3D qpnp_lpg_pwm_enable,
> > +     .disable =3D qpnp_lpg_pwm_disable,
>
> As already noted in the former patch: Please implement .apply() and
> .get_state().

So drop:
    .get_output_type_supported =3D qpnp_lpg_pwm_output_types_supported,
    .set_output_type =3D qpnp_lpg_pwm_set_output_type,
    .set_output_pattern =3D qpnp_lpg_pwm_set_output_pattern,

Ad implement implement .apply and .get_state if i understood you correctly.
Right ?
>
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int qpnp_lpg_parse_dt(struct qpnp_lpg_chip *chip)
> > +{
> > +     struct device_node *child;
> > +     struct qpnp_lpg_channel *lpg;
> > +     struct lpg_ramp_config *ramp;
> > +     int rc =3D 0, i;
> > +     u32 base, length, lpg_chan_id, tmp;
> > +     const __be32 *addr;
> > +
> > +     addr =3D of_get_address(chip->dev->of_node, 0, NULL, NULL);
> > +     if (!addr) {
> > +             dev_err(chip->dev, "Get %s address failed\n", LPG_BASE);
> > +             return -EINVAL;
> > +     }
> > +
> > +     base =3D be32_to_cpu(addr[0]);
> > +     rc =3D of_property_read_u32(chip->dev->of_node, "qcom,num-lpg-cha=
nnels",
> > +                               &chip->num_lpgs);
> > +     if (rc < 0) {
> > +             dev_err(chip->dev,
> > +                     "Failed to get qcom,num-lpg-channels, rc=3D%d\n",=
 rc);
> > +             return rc;
> > +     }
> > +
> > +     if (chip->num_lpgs =3D=3D 0) {
> > +             dev_err(chip->dev, "No LPG channels specified\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     chip->lpgs =3D devm_kcalloc(chip->dev, chip->num_lpgs,
> > +                               sizeof(*chip->lpgs), GFP_KERNEL);
>
> Would be great to lower the number of allocations - ideally to one at
> probe time.

Hmmmm. Okay.

>
> > +     if (!chip->lpgs)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < chip->num_lpgs; i++) {
> > +             chip->lpgs[i].chip =3D chip;
> > +             chip->lpgs[i].lpg_idx =3D i;
> > +             chip->lpgs[i].reg_base =3D base + i * REG_SIZE_PER_LPG;
> > +             chip->lpgs[i].src_sel =3D PWM_VALUE;
> > +             rc =3D qpnp_lpg_read(&chip->lpgs[i], REG_LPG_PERPH_SUBTYP=
E,
> > +                                &chip->lpgs[i].subtype);
> > +             if (rc < 0) {
> > +                     dev_err(chip->dev, "Read subtype failed, rc=3D%d\=
n", rc);
> > +                     return rc;
> > +             }
> > +     }
> > +
> > +     addr =3D of_get_address(chip->dev->of_node, 1, NULL, NULL);
> > +     if (!addr) {
> > +             pr_debug("NO LUT address assigned\n");
> > +             return 0;
> > +     }
> > +
> > +     chip->lut =3D devm_kmalloc(chip->dev, sizeof(*chip->lut), GFP_KER=
NEL);
> > +     if (!chip->lut)
> > +             return -ENOMEM;
> > +
> > +     chip->lut->chip =3D chip;
> > +     chip->lut->reg_base =3D be32_to_cpu(*addr);
> > +     mutex_init(&chip->lut->lock);
> > +
> > +     rc =3D of_property_count_elems_of_size(chip->dev->of_node,
> > +                                          "qcom,lut-patterns", sizeof(=
u32));
> > +     if (rc < 0) {
> > +             dev_err(chip->dev, "Read qcom,lut-patterns failed, rc=3D%=
d\n",
> > +                     rc);
> > +             return rc;
> > +     }
> > +
> > +     length =3D rc;
> > +     if (length > LPG_LUT_COUNT_MAX) {
> > +             dev_err(chip->dev,
> > +                     "qcom,lut-patterns length %d exceed max %d\n", le=
ngth,
> > +                     LPG_LUT_COUNT_MAX);
> > +             return -EINVAL;
> > +     }
> > +
> > +     chip->lut->pattern =3D
> > +             devm_kcalloc(chip->dev, LPG_LUT_COUNT_MAX,
> > +                          sizeof(*chip->lut->pattern), GFP_KERNEL);
> > +     if (!chip->lut->pattern)
> > +             return -ENOMEM;
> > +
> > +     rc =3D of_property_read_u32_array(chip->dev->of_node, "qcom,lut-p=
atterns",
> > +                                     chip->lut->pattern, length);
> > +     if (rc < 0) {
> > +             dev_err(chip->dev, "Get qcom,lut-patterns failed, rc=3D%d=
\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     if (of_get_available_child_count(chip->dev->of_node) =3D=3D 0) {
> > +             dev_err(chip->dev, "No ramp configuration for any LPG\n")=
;
> > +             return -EINVAL;
> > +     }
> > +
> > +     for_each_available_child_of_node (chip->dev->of_node, child) {
> > +             rc =3D of_property_read_u32(child, "qcom,lpg-chan-id",
> > +                                       &lpg_chan_id);
> > +             if (rc < 0) {
> > +                     dev_err(chip->dev,
> > +                             "Get qcom,lpg-chan-id failed for node %s,=
 rc=3D%d\n",
> > +                             child->name, rc);
> > +                     return rc;
> > +             }
> > +
> > +             if (lpg_chan_id > chip->num_lpgs) {
> > +                     dev_err(chip->dev,
> > +                             "lpg-chann-id %d is out of range 1~%d\n",
> > +                             lpg_chan_id, chip->num_lpgs);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /* lpg channel id is indexed from 1 in hardware */
> > +             lpg =3D &chip->lpgs[lpg_chan_id - 1];
> > +             ramp =3D &lpg->ramp_config;
> > +
> > +             rc =3D of_property_read_u32(child, "qcom,ramp-step-ms", &=
tmp);
> > +             if (rc < 0) {
> > +                     dev_err(chip->dev,
> > +                             "get qcom,ramp-step-ms failed for lpg%d, =
rc=3D%d\n",
> > +                             lpg_chan_id, rc);
> > +                     return rc;
> > +             }
> > +             ramp->step_ms =3D (u16)tmp;
> > +
> > +             rc =3D of_property_read_u32(child, "qcom,ramp-low-index",=
 &tmp);
> > +             if (rc < 0) {
> > +                     dev_err(chip->dev,
> > +                             "get qcom,ramp-low-index failed for lpg%d=
, rc=3D%d\n",
> > +                             lpg_chan_id, rc);
> > +                     return rc;
> > +             }
> > +             ramp->lo_idx =3D (u8)tmp;
> > +             if (ramp->lo_idx >=3D LPG_LUT_COUNT_MAX) {
> > +                     dev_err(chip->dev,
> > +                             "qcom,ramp-low-index should less than max=
 %d\n",
> > +                             LPG_LUT_COUNT_MAX);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             rc =3D of_property_read_u32(child, "qcom,ramp-high-index"=
, &tmp);
> > +             if (rc < 0) {
> > +                     dev_err(chip->dev,
> > +                             "get qcom,ramp-high-index failed for lpg%=
d, rc=3D%d\n",
> > +                             lpg_chan_id, rc);
> > +                     return rc;
> > +             }
> > +             ramp->hi_idx =3D (u8)tmp;
> > +
> > +             if (ramp->hi_idx > LPG_LUT_COUNT_MAX) {
> > +                     dev_err(chip->dev,
> > +                             "qcom,ramp-high-index shouldn't exceed ma=
x %d\n",
> > +                             LPG_LUT_COUNT_MAX);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (ramp->hi_idx <=3D ramp->lo_idx) {
> > +                     dev_err(chip->dev,
> > +                             "high-index(%d) should be larger than low=
-index(%d)\n",
> > +                             ramp->hi_idx, ramp->lo_idx);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ramp->pattern_length =3D ramp->hi_idx - ramp->lo_idx + 1;
> > +             ramp->pattern =3D &chip->lut->pattern[ramp->lo_idx];
> > +             lpg->max_pattern_length =3D ramp->pattern_length;
> > +
> > +             rc =3D of_property_read_u32(child, "qcom,ramp-pause-hi-co=
unt",
> > +                                       &tmp);
> > +             if (rc < 0)
> > +                     ramp->pause_hi_count =3D 0;
> > +             else
> > +                     ramp->pause_hi_count =3D (u8)tmp;
> > +
> > +             rc =3D of_property_read_u32(child, "qcom,ramp-pause-lo-co=
unt",
> > +                                       &tmp);
> > +             if (rc < 0)
> > +                     ramp->pause_lo_count =3D 0;
> > +             else
> > +                     ramp->pause_lo_count =3D (u8)tmp;
> > +
> > +             ramp->ramp_dir_low_to_hi =3D of_property_read_bool(
> > +                     child, "qcom,ramp-from-low-to-high");
> > +
> > +             ramp->pattern_repeat =3D of_property_read_bool(
> > +                     child, "qcom,ramp-pattern-repeat");
> > +
> > +             ramp->toggle =3D of_property_read_bool(child, "qcom,ramp-=
toggle");
> > +     }
> > +
> > +     rc =3D of_property_count_elems_of_size(
> > +             chip->dev->of_node, "qcom,sync-channel-ids", sizeof(u32))=
;
> > +     if (rc < 0)
> > +             return 0;
> > +
> > +     length =3D rc;
> > +     if (length > chip->num_lpgs) {
> > +             dev_err(chip->dev,
> > +                     "qcom,sync-channel-ids has too many channels: %d\=
n",
> > +                     length);
> > +             return -EINVAL;
> > +     }
> > +
> > +     chip->lpg_group =3D devm_kcalloc(chip->dev, chip->num_lpgs, sizeo=
f(u32),
> > +                                    GFP_KERNEL);
> > +     if (!chip->lpg_group)
> > +             return -ENOMEM;
> > +
> > +     rc =3D of_property_read_u32_array(chip->dev->of_node,
> > +                                     "qcom,sync-channel-ids",
> > +                                     chip->lpg_group, length);
> > +     if (rc < 0) {
> > +             dev_err(chip->dev, "Get qcom,sync-channel-ids failed, rc=
=3D%d\n",
> > +                     rc);
> > +             return rc;
> > +     }
> > +
> > +     for (i =3D 0; i < length; i++) {
> > +             if (chip->lpg_group[i] <=3D 0 ||
> > +                 chip->lpg_group[i] > chip->num_lpgs) {
> > +                     dev_err(chip->dev,
> > +                             "lpg_group[%d]: %d is not a valid channel=
\n", i,
> > +                             chip->lpg_group[i]);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * The LPG channel in the same group should have the same ramping
> > +      * configuration, so force to use the ramping configuration of th=
e
> > +      * 1st LPG channel in the group for sychronization.
> > +      */
> > +     lpg =3D &chip->lpgs[chip->lpg_group[0] - 1];
> > +     ramp =3D &lpg->ramp_config;
> > +
> > +     for (i =3D 1; i < length; i++) {
> > +             lpg =3D &chip->lpgs[chip->lpg_group[i] - 1];
> > +             memcpy(&lpg->ramp_config, ramp, sizeof(struct lpg_ramp_co=
nfig));
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int qpnp_lpg_probe(struct platform_device *pdev)
> > +{
> > +     int rc;
> > +     struct qpnp_lpg_chip *chip;
> > +
> > +     chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > +     if (!chip)
> > +             return -ENOMEM;
> > +
> > +     chip->dev =3D &pdev->dev;
> > +     chip->regmap =3D dev_get_regmap(chip->dev->parent, NULL);
> > +     if (!chip->regmap) {
> > +             dev_err(chip->dev, "Getting regmap failed\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     mutex_init(&chip->bus_lock);
> > +     rc =3D qpnp_lpg_parse_dt(chip);
> > +     if (rc < 0) {
> > +             dev_err(chip->dev,
> > +                     "Devicetree properties parsing failed, rc=3D%d\n"=
, rc);
> > +             goto err_out;
> > +     }
> > +
> > +     dev_set_drvdata(chip->dev, chip);
> > +     chip->pwm_chip.dev =3D chip->dev;
> > +     chip->pwm_chip.base =3D -1;
> > +     chip->pwm_chip.npwm =3D chip->num_lpgs;
> > +     chip->pwm_chip.ops =3D &qpnp_lpg_pwm_ops;
> > +
> > +     rc =3D pwmchip_add(&chip->pwm_chip);
> > +     if (rc < 0) {
> > +             dev_err(chip->dev, "Add pwmchip failed, rc=3D%d\n", rc);
> > +             goto err_out;
> > +     }
> > +
> > +     return 0;
> > +err_out:
> > +     mutex_destroy(&chip->bus_lock);
> > +     return rc;
> > +}
> > +
> > +static int qpnp_lpg_remove(struct platform_device *pdev)
> > +{
> > +     struct qpnp_lpg_chip *chip =3D dev_get_drvdata(&pdev->dev);
> > +     int rc =3D 0;
> > +
> > +     rc =3D pwmchip_remove(&chip->pwm_chip);
> > +     if (rc < 0)
> > +             dev_err(chip->dev, "Remove pwmchip failed, rc=3D%d\n", rc=
);
>
> Please use %pe instead of %d for error codes.

OK.

>
> > +
> > +     mutex_destroy(&chip->bus_lock);
> > +     dev_set_drvdata(chip->dev, NULL);
>
> dev_set_drvdata(..., NULL) is not needed.

Okay.

>
> > +
> > +     return rc;
> > +}
> > +
> > +static const struct of_device_id qpnp_lpg_of_match[] =3D {
> > +     {
> > +             .compatible =3D "qcom,pwm-lpg",
> > +     },
> > +     {},
> > +};
> > +
> > +static struct platform_driver qpnp_lpg_driver =3D {
> > +     .driver         =3D {
> > +             .name           =3D "qcom,pwm-lpg",
> > +             .of_match_table =3D qpnp_lpg_of_match,
> > +     },
> > +     .probe          =3D qpnp_lpg_probe,
> > +     .remove         =3D qpnp_lpg_remove,
> > +};
> > +module_platform_driver(qpnp_lpg_driver);
> > +
> > +MODULE_DESCRIPTION("QTI LPG driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.27.0


Thank you.

Best Regards,
Martin
