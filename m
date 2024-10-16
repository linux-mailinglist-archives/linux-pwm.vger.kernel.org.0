Return-Path: <linux-pwm+bounces-3680-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BF9A0753
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3011F23BF7
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDCE209660;
	Wed, 16 Oct 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VgzhBGog"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44839208D97;
	Wed, 16 Oct 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074350; cv=none; b=L1dvKBe4XEpVR6/OCHm7sgTtgg4/cayp9byNf7B8FimUVxtKS3cpIbeAU9oIJKYgINADGYu7zgO3DJhoBd56HXZpg5RIWB7+EIafGWksTyrLpCwPgxflqFwRZPgp/GvW6dMhgaG8+hJa6/YA9DNPJubO88fzJGKRHit2jdHBx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074350; c=relaxed/simple;
	bh=d4QQXY9+i/N5A/05rvfJkOToMj4Y7fZnpg+8B0LFCC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVYfdL3UhqxGlrCbPuODhjsQrX7vMM2RntdDWOaydI10/vHzVQZ9O+xJWeIyXazsrVjgbo0j74raP3082BzG2fHpzEOn2ASxV3B1aRA/IcHtEJf/voQ5UboGOSJl86rPTC+sCjC+sOIjSJO4/SPGr9W9XDsiZDHVKChtAVAxyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VgzhBGog; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729074346;
	bh=d4QQXY9+i/N5A/05rvfJkOToMj4Y7fZnpg+8B0LFCC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VgzhBGog6sO0tmdin/odGN0Sfakf1AXy5K2mG85CK1jzreMLErffdQcUv3CVIxVrd
	 kiK1XYdb7T5D6nsh6T/T5XdH2UKJHPStmsqTBt8MTRU0ummThXV5RTO0Qel8QXwfoa
	 4HMawR5SlaTsLdDTgFzh7jKw+jzteFV1mnm2J81eJkLT5TOgjqINiyILpv1iQx+g0G
	 +Me0nkd16Sv4iVQ+OugWDuUw0Wvxj5Iujmmmx/UzeuqtLWtNRbGvqbIq4Lxr3cWTrE
	 a4imXSVJ6kf+rxw1BM+BlSZRMB0PvXw2eXwvKRWJBugoBjB+PoELJomjheVeEmErPL
	 5RHtFn5rDk47g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4BA917E120F;
	Wed, 16 Oct 2024 12:25:45 +0200 (CEST)
Message-ID: <069d220c-b682-40ba-a254-9f60167c56dd@collabora.com>
Date: Wed, 16 Oct 2024 12:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] pwm: airoha: Add support for EN7581 SoC
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com,
 linux-pwm@vger.kernel.org
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
 <20241016-en7581-pinctrl-v7-6-4ff611f263a7@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241016-en7581-pinctrl-v7-6-4ff611f263a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/24 12:07, Lorenzo Bianconi ha scritto:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> Introduce driver for PWM module available on EN7581 SoC.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pwm/Kconfig      |  11 ++
>   drivers/pwm/Makefile     |   1 +
>   drivers/pwm/pwm-airoha.c | 408 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 420 insertions(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16d451e987dcc5f10e0b57edc32ee1..99aa87136c272555c10102590fcf9f911161c3d3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -54,6 +54,17 @@ config PWM_ADP5585
>   	  This option enables support for the PWM function found in the Analog
>   	  Devices ADP5585.
>   
> +config PWM_AIROHA
> +	tristate "Airoha PWM support"
> +	depends on ARCH_AIROHA || COMPILE_TEST
> +	depends on OF
> +	select REGMAP_MMIO
> +	help
> +	  Generic PWM framework driver for Airoha SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-airoha.
> +
>   config PWM_APPLE
>   	tristate "Apple SoC PWM support"
>   	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e09713fe05479c257eebe5f02b91e9..fbf7723d845807fd1e2893c6ea4f736785841b0d 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>   obj-$(CONFIG_PWM)		+= core.o
>   obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
>   obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
> +obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
>   obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
>   obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>   obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
> diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f1587ebf5adf1950cdf953600a2772b2c9ab6e73
> --- /dev/null
> +++ b/drivers/pwm/pwm-airoha.c
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> + *
> + *  Limitations:
> + *  - No disable bit, so a disabled PWM is simulated by setting duty_cycle to 0
> + *  - Only 8 concurrent waveform generators are available for 8 combinations of
> + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
> + *    pins and 17 SIPO GPIO pins.
> + *  - Supports only normal polarity.
> + *  - On configuration the currently running period is completed.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/gpio.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <asm/div64.h>
> +
> +#define REG_SGPIO_LED_DATA		0x0024
> +#define SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
> +#define SGPIO_LED_DATA_DATA		GENMASK(16, 0)
> +
> +#define REG_SGPIO_CLK_DIVR		0x0028
> +#define REG_SGPIO_CLK_DLY		0x002c
> +
> +#define REG_SIPO_FLASH_MODE_CFG		0x0030
> +#define SERIAL_GPIO_FLASH_MODE		BIT(1)
> +#define SERIAL_GPIO_MODE		BIT(0)
> +
> +#define REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + ((_n) << 2))
> +#define GPIO_FLASH_PRD_MASK(_n)		GENMASK(15 + ((_n) << 4), ((_n) << 4))
> +
> +#define REG_GPIO_FLASH_MAP(_n)		(0x004c + ((_n) << 2))
> +#define GPIO_FLASH_SETID_MASK(_n)	GENMASK(2 + ((_n) << 2), ((_n) << 2))
> +#define GPIO_FLASH_EN(_n)		BIT(3 + ((_n) << 2))
> +
> +#define REG_SIPO_FLASH_MAP(_n)		(0x0054 + ((_n) << 2))
> +
> +#define REG_CYCLE_CFG_VALUE(_n)		(0x0098 + ((_n) << 2))
> +#define WAVE_GEN_CYCLE_MASK(_n)		GENMASK(7 + ((_n) << 3), ((_n) << 3))
> +

Probably boils down to personal opinion, but I would do:

struct airoha_pwm_bucket {
	....stuff...
}

> +struct airoha_pwm {
> +	struct regmap *regmap;
> +
> +	struct device_node *np;
> +	u64 initialized;
> +

	struct airoha_pwm_bucket bucket[EN7581_NUM_BUCKETS];

> +	struct {
> +		/* Bitmask of PWM channels using this bucket */
> +		u64 used;
> +		u64 period_ns;
> +		u64 duty_ns;
> +	} bucket[8];
> +};
> +
> +/*
> + * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
> + * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
> + * However, we've only got 8 concurrent waveform generators and can therefore
> + * only use up to 8 different combinations of duty cycle and period at a time.
> + */
> +#define PWM_NUM_GPIO	16
> +#define PWM_NUM_SIPO	17
> +
> +/* The PWM hardware supports periods between 4 ms and 1 s */
> +#define PERIOD_MIN_NS	(4 * NSEC_PER_MSEC)
> +#define PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
> +/* It is represented internally as 1/250 s between 1 and 250 */
> +#define PERIOD_MIN	1
> +#define PERIOD_MAX	250
> +/* Duty cycle is relative with 255 corresponding to 100% */
> +#define DUTY_FULL	255
> +

..snip..

> +
> +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> +{
> +	u32 clk_divr_val = 3, sipo_clock_delay = 1;
> +	u32 val, sipo_clock_divisor = 32;

u32 clk_divr_val, sipo_clock_delay, sipo_clock_divisor, val;
int ret;

> +
> +	if (!(pc->initialized >> PWM_NUM_GPIO))
> +		return 0;
> +
> +	/* Select the right shift register chip */
> +	if (of_property_read_bool(pc->np, "hc74595"))

"airoha,serial-gpio-mode"

> +		regmap_set_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +				SERIAL_GPIO_MODE);
> +	else
> +		regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +				  SERIAL_GPIO_MODE);
> +
> +	if (!of_property_read_u32(pc->np, "sipo-clock-divisor",
> +				  &sipo_clock_divisor)) {

ret = of_property_read_u32(pc->np, "airoha,sipo-clock-divisor", &sipo_clock_divisor);
if (ret)
	sipo_clock_divisor = 32;

switch (sipo_clock_divisor) {
......
}

> +		switch (sipo_clock_divisor) {
> +		case 4:
> +			clk_divr_val = 0;
> +			break;
> +		case 8:
> +			clk_divr_val = 1;
> +			break;
> +		case 16:
> +			clk_divr_val = 2;
> +			break;
> +		case 32:
> +			clk_divr_val = 3;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	/* Configure shift register timings */
> +	regmap_write(pc->regmap, REG_SGPIO_CLK_DIVR, clk_divr_val);
> +
> +	of_property_read_u32(pc->np, "sipo-clock-delay", &sipo_clock_delay);

"airoha,sipo-clock-delay"

ret = ...
if (ret)
	sipo_clock_delay = 1;

> +	if (sipo_clock_delay < 1 || sipo_clock_delay > sipo_clock_divisor / 2)
> +		return -EINVAL;
> +
Everything else looks good to me.

Cheers,
Angelo

