Return-Path: <linux-pwm+bounces-6290-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49083AD50A6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C471886D59
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9801B25EF9F;
	Wed, 11 Jun 2025 09:55:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942725E448;
	Wed, 11 Jun 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635725; cv=none; b=KoQb5nJJZkfVRnQMQlyQpUECq4cQsc6Z9mvdzqoo3TBvrEof8+uHU6+TSQbrNDhikgMX+tX0P382eBbByw7pM+bQX2lhwyMZjOTmEh5NudattbWMPQrUZyspOVsOSFf4CYCGUPViNqbdP5WUMUXHwwF3AawCoa2AnFee9vK0N7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635725; c=relaxed/simple;
	bh=caoqhIO74fEue9jwSECt2E/CRId7nrzha3/CFRitmz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/mJKrpNAilkSn/QfeYxaJMFVnx0HVIlv/OXfYex7MzxUClsLU48J6kyaoSHj9VAJjIeGJf7iV3Myam7BJageSLoN3Yi/AzQbIYMpVxnQ7YEzdmp0Htmm/WrU2zvB+1HQ8M+SOzGioZtFiogYyVDu1i1RrrwP4uH3CnVJXuATrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-87ecd70679cso2374233241.0;
        Wed, 11 Jun 2025 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749635721; x=1750240521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KU9XIo3pE6yrQp415HLbJ5RslRTOsLxW1sCDEyQ/CuQ=;
        b=GtLSM4p2PoQdRROLDfS9Up9ZE3JWl89YHsjrctf2pu/lMsCmOi/5laV8llck666XwR
         GxhLJ0vDOYN6de9Atv4IoPUIBsLipi/H3gidvWoDH67l4bUMJeStw981RHuNXBRFw2ED
         5c5tColR8UzTvn0Mki1+2R43njHEzgpQ7EVZr6PbtrK4+GdK+NFwPid9CSTtS/MORXPn
         rCeWRcXyUrhBvRC/cXHaJCUu4WnjaC1yB1ih3JCDVznrQrqL1MK6O92NtuHq/5R+XTwT
         Y/8fTEVu03rKahMznD6O6wxXXzyW2tLJISfb4jGVccR16G8B8HYelkgahQG9jUb1/EjL
         V/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ/cKO24poOMUhei6yvcYwr+nwFN02phA24C6FlGCMMZoakaDEsr+DXhzkviP5WXVxOYHtmYy8UNu@vger.kernel.org, AJvYcCVQo6CmP5AprAYBC7OwnGH8UyiQnIAMgtbUO7ncXhPR9AiB4ZzXxwWS7vtfqJDl0BPR2hU7+8UbvQ1s@vger.kernel.org, AJvYcCXFN7G/Zdafaq0bX0oeSZ2NnhKtpK3TytSBM/ins8+XHZaks+oFsjpfhdMKCVhrHMulvmWcf64jkSbTn4HW5s6hAmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYVZTiI/s/zDuP3lWTXAmlHZjmtbCGyFQf87qY6uchNRQDUa+
	ElbFMalfpT3cVf/290QLmdsl6UXZSYyLq7tyBx4af4AsmnutMY/HG5kWL6TV0m3q
X-Gm-Gg: ASbGncvKA64Tr5JPjY5+WN9VRo+t13ScOR2/9rG08XjvRWd2tcVJ9PsPPO3zXq4Cm21
	7pu8vfwi+ouPuiaaLsY9xOocNsaYAn94kXDZKRXoDEzEs7dqYHeuYLpcksxzMtKrmWl2G3Dq91+
	IkPXEO4kvExz+o42Eq1fsXSBtcTFauIcF4Biywj9cyDrbepAl+yRuIHIPiKlZmrEmM4+X+D7gHx
	JjYhtaOtjOEiPyWYwwB3cDnDxFRPxCuH9jT+C684rsuxbbvc3GJHB80aEopXpMigT/y5t7+UFgw
	HNTQmVFGuZNXyDfYAyxsuyL4Ng490laUCIoVf0mQMxTk1PPzi9hubGUZ61MwaEAFFaVmiVY+NcS
	wsHbZRYWa6oBfwbp8bBgcMhbb
X-Google-Smtp-Source: AGHT+IGSZoZFcs2OSP/xyyvFkVCD3HhxtLYmmx4IzoPZP0vNnT0ZNT3UySzSQ172eapa4QsQFXIxew==
X-Received: by 2002:a05:6102:4409:b0:4e5:fe5e:2be4 with SMTP id ada2fe7eead31-4e7baf7ca1bmr1992007137.22.1749635721172;
        Wed, 11 Jun 2025 02:55:21 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeaf3b7c6sm2433146241.21.2025.06.11.02.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 02:55:20 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87ecd70679cso2374216241.0;
        Wed, 11 Jun 2025 02:55:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqQWyRQchjWQpr8870Cyg27AytCuCYijeeq+qtzntlS54e3fonmdasEfnlbi1Ksx0A0G5VX3T3Qjr9l6naBRA7FD0=@vger.kernel.org, AJvYcCWxFXjapN1RMT9U62UdqENimJyMBtW1EUnj3ircUNnvfSeayygwvyvmRi20QhXSCIh67ee/6DnNq161@vger.kernel.org, AJvYcCWykPF061eBtqjMXla/cee1IjsfSdr/xxFhNiZawfyFCtu0vN5ewK9dK9pieu2PRTFC3NWShWLd3+yO@vger.kernel.org
X-Received: by 2002:a05:6102:c52:b0:4db:e01:f2db with SMTP id
 ada2fe7eead31-4e7bac51164mr2305941137.0.1749635720444; Wed, 11 Jun 2025
 02:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609000748.1665219-1-marek.vasut+renesas@mailbox.org> <20250609000748.1665219-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609000748.1665219-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jun 2025 11:55:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXwPHvuGdWYFEhOHeT9J67igd6kWNpRgUAbhAGVMKPMcw@mail.gmail.com>
X-Gm-Features: AX0GCFsGW1Nt-ZuPkSAbdZllHwaYUgTYpVvtkmvsxqCyNzTWo3jjsyTMzzglaiU
Message-ID: <CAMuHMdXwPHvuGdWYFEhOHeT9J67igd6kWNpRgUAbhAGVMKPMcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rpi-panel-v2: Add regulator for 7"
 Raspberry Pi 720x1280
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

CC pwm

On Wed, 11 Jun 2025 at 10:19, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>
> Add regulator for the 7" Raspberry Pi 720x1280 DSI panel based on ili9881.
> This is the Raspberry Pi DSI Panel V2. The newer Raspberry Pi 5" and 7"
> panels have a slightly different register map to the original one. Add a
> new driver for this "regulator" chip, this time by exposing two GPIOs and
> one PWM controller, both of which can be consumed by panel driver and
> pwm-backlight respectively.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Loosely based on:
> https://github.com/raspberrypi/linux 3c07b87e877e ("regulator: Add a regulator for the new LCD panels")]
> https://github.com/raspberrypi/linux 68c59b9e6275 ("regulator: rpi_panel_v2: Add remove and shutdown hooks")]
> ---
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> ---
>  drivers/regulator/Kconfig                  |  10 ++
>  drivers/regulator/Makefile                 |   1 +
>  drivers/regulator/rpi-panel-v2-regulator.c | 114 +++++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 drivers/regulator/rpi-panel-v2-regulator.c
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 6d8988387da4..21ad6d938e4d 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1153,6 +1153,16 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
>           touchscreen unit. The regulator is used to enable power to the
>           TC358762, display and to control backlight.
>
> +config REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2
> +       tristate "Raspberry Pi 7-inch touchscreen panel V2 regulator"
> +       depends on I2C
> +       select GPIO_REGMAP
> +       select REGMAP_I2C
> +       help
> +         This driver supports regulator on the V2 Raspberry Pi touchscreen
> +         unit. The regulator is used to enable power to the display and to
> +         control backlight PWM.
> +
>  config REGULATOR_RC5T583
>         tristate "RICOH RC5T583 Power regulators"
>         depends on MFD_RC5T583
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index c0bc7a0f4e67..be98b29d6675 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -136,6 +136,7 @@ obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
>  obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
>  obj-$(CONFIG_REGULATOR_RAA215300) += raa215300.o
>  obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY)  += rpi-panel-attiny-regulator.o
> +obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2)  += rpi-panel-v2-regulator.o
>  obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
>  obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
>  obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
> diff --git a/drivers/regulator/rpi-panel-v2-regulator.c b/drivers/regulator/rpi-panel-v2-regulator.c
> new file mode 100644
> index 000000000000..b77383584a3a
> --- /dev/null
> +++ b/drivers/regulator/rpi-panel-v2-regulator.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Raspberry Pi Ltd.
> + * Copyright (C) 2025 Marek Vasut
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/* I2C registers of the microcontroller. */
> +#define REG_ID         0x01
> +#define REG_POWERON    0x02
> +#define REG_PWM                0x03
> +
> +/* Bits for poweron register */
> +#define LCD_RESET_BIT  BIT(0)
> +#define CTP_RESET_BIT  BIT(1)
> +
> +/* Bits for the PWM register */
> +#define PWM_BL_ENABLE  BIT(7)
> +#define PWM_BL_MASK    GENMASK(4, 0)
> +
> +/* Treat LCD_RESET and CTP_RESET as GPIOs */
> +#define NUM_GPIO       2
> +
> +static const struct regmap_config rpi_panel_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = REG_PWM,
> +       .can_sleep = true,
> +};
> +
> +static int rpi_panel_v2_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +                                 const struct pwm_state *state)
> +{
> +       struct regmap *regmap = pwmchip_get_drvdata(chip);
> +       unsigned int duty;
> +
> +       if (state->polarity != PWM_POLARITY_NORMAL)
> +               return -EINVAL;
> +
> +       if (!state->enabled)
> +               return regmap_write(regmap, REG_PWM, 0);
> +
> +       duty = pwm_get_relative_duty_cycle(state, PWM_BL_MASK);
> +       return regmap_write(regmap, REG_PWM, duty | PWM_BL_ENABLE);
> +}
> +
> +static const struct pwm_ops rpi_panel_v2_pwm_ops = {
> +       .apply = rpi_panel_v2_pwm_apply,
> +};
> +
> +/*
> + * I2C driver interface functions
> + */
> +static int rpi_panel_v2_i2c_probe(struct i2c_client *i2c)
> +{
> +       struct gpio_regmap_config gconfig = {
> +               .ngpio          = NUM_GPIO,
> +               .ngpio_per_reg  = NUM_GPIO,
> +               .parent         = &i2c->dev,
> +               .reg_set_base   = REG_POWERON,
> +       };
> +       struct regmap *regmap;
> +       struct pwm_chip *pc;
> +       int ret;
> +
> +       pc = devm_pwmchip_alloc(&i2c->dev, 1, 0);
> +       if (IS_ERR(pc))
> +               return PTR_ERR(pc);
> +
> +       pc->ops = &rpi_panel_v2_pwm_ops;
> +
> +       regmap = devm_regmap_init_i2c(i2c, &rpi_panel_regmap_config);
> +       if (IS_ERR(regmap))
> +               return dev_err_probe(&i2c->dev, PTR_ERR(regmap), "Failed to allocate regmap\n");
> +
> +       pwmchip_set_drvdata(pc, regmap);
> +
> +       regmap_write(regmap, REG_POWERON, 0);
> +
> +       gconfig.regmap = regmap;
> +       ret = PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&i2c->dev, &gconfig));
> +       if (ret)
> +               return dev_err_probe(&i2c->dev, ret, "Failed to create gpiochip\n");
> +
> +       return devm_pwmchip_add(&i2c->dev, pc);
> +}
> +
> +static const struct of_device_id rpi_panel_v2_dt_ids[] = {
> +       { .compatible = "raspberrypi,touchscreen-panel-regulator-v2" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, rpi_panel_v2_dt_ids);
> +
> +static struct i2c_driver rpi_panel_v2_regulator_driver = {
> +       .driver = {
> +               .name = "rpi_touchscreen_v2",
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +               .of_match_table = of_match_ptr(rpi_panel_v2_dt_ids),
> +       },
> +       .probe = rpi_panel_v2_i2c_probe,
> +};
> +
> +module_i2c_driver(rpi_panel_v2_regulator_driver);
> +
> +MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com>");
> +MODULE_DESCRIPTION("Regulator device driver for Raspberry Pi 7-inch V2 touchscreen");
> +MODULE_LICENSE("GPL");
> --
> 2.47.2

