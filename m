Return-Path: <linux-pwm+bounces-4243-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D379E4C3C
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 03:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D168316A318
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 02:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0C1714CF;
	Thu,  5 Dec 2024 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTLYtCMA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23B16F0E8;
	Thu,  5 Dec 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365617; cv=none; b=DsGPwq4nqpUXjltTxwkwshobYllDKq/6fKxvjqocBjeS2VFNn20BHCpD5W38RJ6l8tT5tJnAHN7DQk+C7CTk3vdEDQXK4NqdbtRnGkyTaWiTtTUz905PXLozM7gVY16zlw4PVi7OJwZEV/DnDL8ThGHqxUFXpcO5Lf15SpD5R1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365617; c=relaxed/simple;
	bh=/QzkaXjnNAuCXR+3SepzaczHQflhasKwMPe02hmu5sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzE7f1c/us6vCy79l6acVh7YgdLLIcB0rBOblVaHUFFn0y+ye38LZtqup2Ni/leNtMg557Sm9qm1QkPXqos210SsrRmQwWST1KGZo9lUKcPyO3gHQvRRIXzX9gasH73hrlzbkxmVtsiHQ8dFwt9bH3GapGd4Be1//64KPUYCGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTLYtCMA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a68480164so45514166b.3;
        Wed, 04 Dec 2024 18:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733365614; x=1733970414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+G2qxz81+vGONqqQt+lZptdIaqKW06vhnryTC/0fsM=;
        b=DTLYtCMA6oUhgpYUPhqr7j9O4ml0aYX2xEJTtpKK8+mCq29jEcTXpHsHWEdYJehbxD
         zKNULlwwcdAAAjgV+OydWOAGZ2FIkzkhoKO2c0FLCESovLTzWVbk5YHesYTqwgkWFe3/
         1sew5IaOnj9eE0tI94JMSMT3m90GFNp4iRb98e35uGcAR+Z9Uwjdb/5kLXDY8bPpR9eG
         7Pg0oXt4ar99dnvWRJO5agU9ErW4cKXKtL/xIL4XMraVEAja6VEGsLoh2KZGXd5MqDCn
         KYEJY3db73xtBwX4n/DQ/maGQ2ALz+G2XaoR2NblTv0zMX3OtSNAoPZ3pzCquAQ0iLWZ
         OoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733365614; x=1733970414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+G2qxz81+vGONqqQt+lZptdIaqKW06vhnryTC/0fsM=;
        b=Mc5eriXhcY/Z2ijRP2IyXaQRQbctPkL+gHox8p/jOPYLTtjh2SDhRVzz7D/h4wl567
         LaoMwxqBIa1mej7tSefsAlNOWqlWyftpc1Mwg/xYl7V047pkUkqWfWEHu4wEOsTUT32y
         OfM4cyUA/DewpD3pifJkq6gJLhkUKgQqZTQgb0NRpy3og14gnc1NY/Dj1Q8EjFlAHQfR
         shZB7hX6CKuUa8ExEopN3FLOs7Rik2g8uhtxHsNtCgRq3trLLSr9ETgFslNyPvNoQclr
         HtE00X3VlV9FfW5gvAv7MGdlWo2UiE7IbXSh8zy+pfpo4GVMxXHBRDhLaS8Z0bGDf+F/
         yRNA==
X-Forwarded-Encrypted: i=1; AJvYcCVXj2UARL4yqB7xRDQNJ9uQjxTOUfRC8aLujpGTDchW1lDpo8dv9oopircoNtQva+d41t52RAah7AOh@vger.kernel.org, AJvYcCVhBcFEHqAhUeIzLEH2vTOXmTYVLiqrL6LoRtxEuBLhv4Fww8lf19J/CB6oh9SSsPl1lSJaLkSo17iy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Zhlbfk+PmVs4JOWa8akrmEejNLnTY73JUP0ZNM20INv41A9o
	NMYn+6smLL92lTIq7B2Uj5EMPHsTtT6QSaybZymv1JpZAXvibwwoG5jl2xBmviFiOm6a3iHIgZX
	28w9BBjV+xNhyu1RP4B6TR39+y4k=
X-Gm-Gg: ASbGncsnGDJLBx+O+gn8nlqVRsWiiqUmcnCM9+rDhQio2O6IFOe4tQdNYh8Ue4OhjSP
	9mdexu5op/nhIiiGU+EF8J81zWW+C
X-Google-Smtp-Source: AGHT+IHgex+Kl6UVVQQtVsLsCVYcCWS2z5cnjj3O2I+F+AGgCmkJQfs9Vep7iajLv/YhKzBNWVdJReI+/9oe9r7Yhqw=
X-Received: by 2002:a17:907:7847:b0:aa6:2a5c:fee2 with SMTP id
 a640c23a62f3a-aa62a5d4b52mr10031766b.31.1733365613815; Wed, 04 Dec 2024
 18:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729583747.git.zhoubinbin@loongson.cn> <66bcb210478df5215e4e31e4f25c25194d6163ca.1729583747.git.zhoubinbin@loongson.cn>
 <6hqpifyfbr5ignvtvsz6p7hkje44xlvbdqwgq5t3ef64kufy3p@2tmp4ftiv42c>
In-Reply-To: <6hqpifyfbr5ignvtvsz6p7hkje44xlvbdqwgq5t3ef64kufy3p@2tmp4ftiv42c>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 5 Dec 2024 10:26:41 +0800
Message-ID: <CAMpQs4JZpzSbM3Ac=vXTO28vXkqEDC=8L2j9kNAHbTMX6yttrA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

Thanks for your detailed reply.

On Sat, Nov 23, 2024 at 1:19=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> I now finally comne around to review your patch. Thanks for your
> patience.
>
> On Tue, Oct 22, 2024 at 05:04:15PM +0800, Binbin Zhou wrote:
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > new file mode 100644
> > index 000000000000..4c9b14efadc3
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -0,0 +1,288 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> > + *
> > + * Loongson PWM driver
> > + *
> > + * For Loongson's PWM IP block documentation please refer Chapter 11 o=
f
> > + * Reference Manual: https://loongson.github.io/LoongArch-Documentatio=
n/Loongson-7A1000-usermanual-EN.pdf
> > + *
> > + * Author: Juxin Gao <gaojuxin@loongson.cn>
> > + * Further cleanup and restructuring by:
> > + *         Binbin Zhou <zhoubinbin@loongson.cn>
> > + *
> > + * Limitations:
> > + * - The buffer register value should be written before the CTRL regis=
ter.
>
> This isn't an interesting point for the high level description. I'd hope
> the driver cares for this implementation detail.
>
> > + * - When disabled the output is driven to 0 independent of the config=
ured
> > + *   polarity.
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
> > +#define LOONGSON_PWM_REG_DUTY                0x4 /* Low Pulse Buffer R=
egister */
> > +#define LOONGSON_PWM_REG_PERIOD              0x8 /* Pulse Period Buffe=
r Register */
> > +#define LOONGSON_PWM_REG_CTRL                0xc /* Control Register *=
/
> > +
> > +/* Control register bits */
> > +#define LOONGSON_PWM_CTRL_EN         BIT(0)  /* Counter Enable Bit */
> > +#define LOONGSON_PWM_CTRL_OE         BIT(3)  /* Pulse Output Enable Co=
ntrol Bit, Valid Low */
> > +#define LOONGSON_PWM_CTRL_SINGLE     BIT(4)  /* Single Pulse Control B=
it */
> > +#define LOONGSON_PWM_CTRL_INTE               BIT(5)  /* Interrupt Enab=
le Bit */
> > +#define LOONGSON_PWM_CTRL_INT                BIT(6)  /* Interrupt Bit =
*/
> > +#define LOONGSON_PWM_CTRL_RST                BIT(7)  /* Counter Reset =
Bit */
> > +#define LOONGSON_PWM_CTRL_CAPTE              BIT(8)  /* Measurement Pu=
lse Enable Bit */
> > +#define LOONGSON_PWM_CTRL_INVERT     BIT(9)  /* Output flip-flop Enabl=
e Bit */
> > +#define LOONGSON_PWM_CTRL_DZONE              BIT(10) /* Anti-dead Zone=
 Enable Bit */
>
> Most of these are unused. And you only ever access the CTRL register
> using read-modify-write. So I guess the behaviour of the hardware
> depends on how the bootloader (or boot rom) initialized these bits. I
> would prefer if you could this more deterministic.

Emm, I would explicitly initialize the CTRL register value to 0 in probe().
>
> > +#define LOONGSON_PWM_FREQ_STD                (50 * HZ_PER_KHZ)
>
> Maybe it's just me, but I think the HZ_PER_KHZ doesn't add readability
> and I would have just done:
>
>         /* default input clk frequency for the ACPI case */
>         #define LOONGSON_PWM_FREQ_DEFAULT       50000 /* Hz */

OK....
>
> > [...]
> > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                           const struct pwm_state *state)
> > +{
> > +     int ret;
> > +     u64 period, duty_cycle;
> > +     bool enabled =3D pwm->state.enabled;
> > +
> > +     if (!state->enabled) {
> > +             if (enabled)
> > +                     pwm_loongson_disable(chip, pwm);
> > +             return 0;
> > +     }
> > +
> > +     ret =3D pwm_loongson_set_polarity(chip, pwm, state->polarity);
> > +     if (ret)
> > +             return ret;
>
> Is setting the polarity shadowed in hardware or does it take effect
> immediately? If the latter please mention that the output might glitch
> on reconfiguration in the Limitations section above.. Another
> "opportunity" to glitch is in pwm_loongson_config() above when
> LOONGSON_PWM_REG_DUTY is written but LOONGSON_PWM_REG_PERIOD isn't yet.

The setting of the polarity is shadowed in hardware, maybe we don't
need to worry.
>
> > +     period =3D min(state->period, NANOHZ_PER_HZ);
> > +     duty_cycle =3D min(state->duty_cycle, NANOHZ_PER_HZ);
>
> period and duty_cycle are measured in nanoseconds. So NSEC_PER_SEC is
> more natural to them than NANOHZ_PER_HZ.

OK...
>
> > +     ret =3D pwm_loongson_config(chip, pwm, duty_cycle, period);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!enabled && state->enabled)
> > +             ret =3D pwm_loongson_enable(chip, pwm);
> > +
> > +     return ret;
> > +}
> > [...]
> > +static int pwm_loongson_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct pwm_chip *chip;
> > +     struct pwm_loongson_ddata *ddata;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +     ddata =3D to_pwm_loongson_ddata(chip);
> > +
> > +     ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(ddata->base))
> > +             return PTR_ERR(ddata->base);
> > +
> > +     if (!has_acpi_companion(dev)) {
> > +             ddata->clk =3D devm_clk_get_enabled(dev, NULL);
> > +             if (IS_ERR(ddata->clk))
> > +                     return dev_err_probe(dev, PTR_ERR(ddata->clk),
> > +                                          "failed to get pwm clock\n")=
;
> > +             ddata->clk_rate =3D clk_get_rate(ddata->clk);
>
> I guess you rely on the clockrate to not change. So please add a call to
> devm_clk_rate_exclusive_get().
>
> > +     } else {
> > +             ddata->clk_rate =3D LOONGSON_PWM_FREQ_STD;
>
> I thought that clk_get() also works for devices described by ACPI?
>
> Maybe something like this gives more flexibility:
>
>         ddata->clk =3D devm_clk_get_optional_enabled(dev, NULL);
>         if (IS_ERR(ddata->clk))
>                 return dev_err_probe(...);
>
>         if (ddata->clk) {
>                 ret =3D devm_clk_rate_exclusive_get(...);
>                 if (ret)
>                         return ret;
>
>                 ddata->clk_rate =3D clk_get_rate(ddata->clk);
>         } else {
>                 ddata->clk_rate =3D LOONGSON_PWM_FREQ_STD;
>         }
>
> and it's conceptually easier given that it doesn't have to care about
> the device being described in ACPI or dt.
>
> Just a suggestion.

OK, I will try to do it.
>
> > +     }
> > +
> > +     chip->ops =3D &pwm_loongson_ops;
> > +     chip->atomic =3D true;
> > +     dev_set_drvdata(dev, chip);
> > +
> > +     ret =3D devm_pwmchip_add(dev, chip);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "failed to add PWM chip\n"=
);
> > +
> > +     return 0;
> > +}
--
Thanks.
Binbin

