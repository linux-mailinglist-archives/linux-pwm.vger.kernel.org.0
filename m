Return-Path: <linux-pwm+bounces-4072-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F509C5A07
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484501F233A0
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95401FCC50;
	Tue, 12 Nov 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="pNQQS/UA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F71FC7FF
	for <linux-pwm@vger.kernel.org>; Tue, 12 Nov 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420829; cv=none; b=jL1CHYp6ege0xn/Aaaz7ZwGaivpG7qM4tJIJ8XvSuqTEpHgn1o7bvckuN+XVJ9yPb9tjdlqqHlq3/q7F3QnlNkFaQaWNggCTqJqB9wntskHI2iXGE5tHKvxzg5lHuAeT8/wZB0kbvQ6abXUHxKUMHaC90/BOjz/KRL//Ico29Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420829; c=relaxed/simple;
	bh=Pb6cc8jsRHjjtmEf7fvws4f78kvIus2zTwDz80xDIbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcX61wpXvSjveWUFfOrU3pmNhWIqKgKGm8Slsk7H1mCTt68WK9cFWdaxHv56+O2nkzx1b0nNWfSjGE/m+lfFED8gtdLJra6CKqKYa8pKmdLid9RjVOLA/1jyEuP3LUr4gUp6lY9CFL4jtzwC1ARVjN90/cZLMuz0dm1PW0FJ9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=pNQQS/UA; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id AUaCtXh7HumtXAreHtu0fi; Tue, 12 Nov 2024 14:13:41 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id AreEt64iWi85LAreFt4B9W; Tue, 12 Nov 2024 14:13:40 +0000
X-Authority-Analysis: v=2.4 cv=N74vFX9B c=1 sm=1 tr=0 ts=67336294
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10 a=pGLkceISAAAA:8
 a=RtVzW9CK5-vqE484SyEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vuTw+7UNbSBoPbVdnn5KWiFbc/VXhOr0qw45W9oxOHo=; b=pNQQS/UAkGucTBZBwLe3noPJFc
	k/erCasGHe9/oULBPnwJjZTOhZfJUPM2sMjgVsj4TuTSZTQsafH1UYtZXqvFN9AooKvJ0skGTWVYI
	jDilQbekBxVrCsZYWraDFVcJS57PXgSB/OTy8HD009hF42gjOmhFTE6u5ioVqrXKmxx3zvjcF5o73
	orpeZHUjKjbDinAB9409tTtMJ6X4NjorKpESXorbw2X9wOJWkZ9p3bpEoA3moeD7XOB0PaSqn6J1p
	hiUJvZW+Bu6xdr5a8p6vTcKT2jTgpoMpREZ73QsHJt814kvs/u6qw1yxcBGrW4yRxY0NxXJXcPLJa
	FINhThrA==;
Received: from [122.165.245.213] (port=55248 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tAre7-002ixW-2f;
	Tue, 12 Nov 2024 19:43:31 +0530
Message-ID: <2f7ee626-8416-4a05-9add-26e100b16268@linumiz.com>
Date: Tue, 12 Nov 2024 19:43:27 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
To: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
 parthiban@linumiz.com
References: <20241011102751.153248-1-privatesub2@gmail.com>
 <20241011102751.153248-3-privatesub2@gmail.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241011102751.153248-3-privatesub2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tAre7-002ixW-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:55248
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 5
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDjqL61HT9wDzyEiV5HM5vvDM0Xo+QRoQlh/aSEMn9NZs3zQQFyH1QYPm41NsKB+mHkrLKLAdwitHwrWdOEtiTOJJ8Y7jLOxMVwnzpUlU/hOISmLrBvn
 fo4cw7x8x+fdf0pupLOuHWTenaX4z9Sm3Hxuuik7wPpM+szI4kgu/vKR38BXB8Xp5WaHPBPVDoHayqhfquBEcEdkGXsQ1dCHznE=

On 10/11/24 3:57 PM, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
> 
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.

Thanks for your efforts. A133 uses the same IP and tried using the pwm for
LVDS backlight with below diff,

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 2b4ecbf3e724..67a8d52fccf0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -204,6 +204,16 @@ watchdog@30090a0 {
                        clocks = <&dcxo24M>;
                };
 
+               pwm: pwm@300a000 {
+                       compatible = "allwinner,sun20i-d1-pwm";
+                       reg = <0x300a000 0x400>;
+                       clocks = <&ccu CLK_BUS_PWM>, <&dcxo24M>, <&ccu CLK_APB1>;
+                       clock-names = "bus", "hosc", "apb";
+                       resets = <&ccu RST_BUS_PWM>;
+                       #pwm-cells = <0x3>;
+                       status = "disabled";
+               };
+

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-helper-board.dts b/arch/arm64/boot/dts/allwinner/sun50i-a133-helper-board.dts
index aa82c1d2799f..3355df370812 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a133-helper-board.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-helper-board.dts
@@ -19,6 +19,14 @@ aliases {
                serial0 = &uart0;
        };
 
+       backlight: backlight {
+               compatible = "pwm-backlight";
+               pwms = <&pwm 0 50000 0>;
+               brightness-levels = <0 5 10 15 20 30 40 55 70 85 100>;
+               default-brightness-level = <2>;
+               enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
+       };
+

Although the backlight tunrned on and pwm probed fine, I couldn't really
control the backlight brightness levels.

root@helper-board-a133:~# dmesg  | grep -i pwm
[    0.969739] sun20i-pwm 300a000.pwm: apb clock must be greater than hosc clock
[    1.486000] sun20i-pwm 300a000.pwm: .apply is not idempotent (ena=1 pol=0 5000/49959) -> (ena=1 pol=0 5000/49917)
[  410.760633] sun20i-pwm 300a000.pwm: .apply is not idempotent (ena=1 pol=0 49959/49959) -> (ena=1 pol=0 49917/49917)
[  425.284650] sun20i-pwm 300a000.pwm: .apply is not idempotent (ena=1 pol=0 5000/49959) -> (ena=1 pol=0 5000/49917)
[  428.180657] sun20i-pwm 300a000.pwm: .apply is not idempotent (ena=1 pol=0 2500/49959) -> (ena=1 pol=0 2500/49917)
[  431.952648] sun20i-pwm 300a000.pwm: .apply is not idempotent (ena=1 pol=0 49959/49959) -> (ena=1 pol=0 49917/49917)

Did I miss something?

> 
> Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 379 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 390 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..778151aa3860 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -652,6 +652,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
>  
> +config PWM_SUN20I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun20i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..85ad1fe0dde1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN20I)	+= pwm-sun20i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..7d1b47843bb6
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Limitations:
> + * - When the parameters change, current running period will not be completed
> + *   and run new settings immediately.
> + * - It output HIGH-Z state when PWM channel disabled.
> + *
> + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define SUN20I_PWM_CLK_CFG(chan)		(0x20 + ((chan) * 0x4))
> +#define SUN20I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
> +#define SUN20I_PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
> +#define SUN20I_PWM_CLK_DIV_M_MAX		8
> +
> +#define SUN20I_PWM_CLK_GATE			0x40
> +#define SUN20I_PWM_CLK_GATE_BYPASS(chan)	BIT((chan) + 16)
> +#define SUN20I_PWM_CLK_GATE_GATING(chan)	BIT(chan)
> +
> +#define SUN20I_PWM_ENABLE			0x80
> +#define SUN20I_PWM_ENABLE_EN(chan)		BIT(chan)
> +
> +#define SUN20I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
> +#define SUN20I_PWM_CTL_ACT_STA			BIT(8)
> +#define SUN20I_PWM_CTL_PRESCAL_K		GENMASK(7, 0)
> +#define SUN20I_PWM_CTL_PRESCAL_K_MAX		field_max(SUN20I_PWM_CTL_PRESCAL_K)
> +
> +#define SUN20I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
> +#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define SUN20I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define SUN20I_PWM_PCNTR_SIZE			BIT(16)
> +
> +/*
> + * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock dividers
> + * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL_K)
> + * without using a loop. These dividers limit the # of cycles in a period
> + * to SUN20I_PWM_PCNTR_SIZE by applying a scaling factor of
> + * 1/(div_m * (prescale_k + 1)) to the clock source.
> + *
> + * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
> + * such that for a given requested period,
> + *
> + * i) div_m is minimized for any prescale_k ≤ SUN20I_PWM_CTL_PRESCAL_K_MAX,
> + * ii) prescale_k is minimized.
> + *
> + * The derivation proceeds as follows, with val = # of cycles for requested
> + * period:
> + *
> + * for a given value of div_m we want the smallest prescale_k such that
> + *
> + * (val >> div_m) // (prescale_k + 1) ≤ 65536 (SUN20I_PWM_PCNTR_SIZE)
> + *
> + * This is equivalent to:
> + *
> + * (val >> div_m) ≤ 65536 * (prescale_k + 1) + prescale_k
> + * ⟺ (val >> div_m) ≤ 65537 * prescale_k + 65536
> + * ⟺ (val >> div_m) - 65536 ≤ 65537 * prescale_k
> + * ⟺ ((val >> div_m) - 65536) / 65537 ≤ prescale_k
> + *
> + * As prescale_k is integer, this becomes
> + *
> + * ((val >> div_m) - 65536) // 65537 ≤ prescale_k
> + *
> + * And is minimized at
> + *
> + * ((val >> div_m) - 65536) // 65537
> + *
> + * Now we pick the smallest div_m that satifies prescale_k ≤ 255
> + * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
> + *
> + * ((val >> div_m) - 65536) // 65537 ≤ 255
> + * ⟺ (val >> div_m) - 65536 ≤ 255 * 65537 + 65536
> + * ⟺ val >> div_m ≤ 255 * 65537 + 2 * 65536
> + * ⟺ val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> + * ⟺ div_m = fls((val) / (255 * 65537 + 2 * 65536 + 1))
> + *
> + * Suggested by Uwe Kleine-König
> + */
> +#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
> +
> +struct sun20i_pwm_chip {
> +	struct clk *clk_bus, *clk_hosc, *clk_apb;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	struct mutex mutex; /* Protect PWM apply state */
> +};
> +
> +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
> +	u16 ent_cycle, act_cycle, prescale_k;
> +	u64 clk_rate, tmp;
> +	u8 div_m;
> +	u32 val;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2));
> +	div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
> +	if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +		div_m = SUN20I_PWM_CLK_DIV_M_MAX;
> +
> +	if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) == 0)
> +		clk_rate = clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate = clk_get_rate(sun20i_chip->clk_apb);
> +
> +	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	state->polarity = (SUN20I_PWM_CTL_ACT_STA & val) ?
> +			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> +
> +	prescale_k = FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
> +
> +	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +	state->enabled = (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : false;
> +
> +	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
> +
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	act_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> +	ent_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
> +
> +	/*
> +	 * The duration of the active phase should not be longer
> +	 * than the duration of the period
> +	 */
> +	if (act_cycle > ent_cycle)
> +		act_cycle = ent_cycle;
> +
> +	/*
> +	 * We have act_cycle <= ent_cycle <= 0xffff, prescale_k <= 0x100,
> +	 * div_m <= 8. So the multiplication fits into an u64 without
> +	 * overflow.
> +	 */
> +	tmp = ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp = ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);
> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
> +	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
> +	u32 prescale_k, div_m;
> +	bool use_bus_clk;
> +
> +	guard(mutex)(&sun20i_chip->mutex);
> +
> +	pwm_en = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +
> +	if (state->enabled != pwm->state.enabled) {
> +		clk_gate = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_GATE);
> +
> +		if (!state->enabled) {
> +			clk_gate &= ~SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +			pwm_en &= ~SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +			sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +			sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +
> +			return 0;
> +		}
> +	}
> +
> +	ctl = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	clk_cfg = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2));
> +	hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
> +	bus_rate = clk_get_rate(sun20i_chip->clk_apb);
> +	if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> +		/* if the neighbor channel is enabled, check period only */
> +		use_bus_clk = FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) != 0;
> +		val = mul_u64_u64_div_u64(state->period,
> +					  (use_bus_clk ? bus_rate : hosc_rate),
> +					  NSEC_PER_SEC);
> +
> +		div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
> +	} else {
> +		/*
> +		 * Select the clock source based on the period,
> +		 * since bus_rate > hosc_rate, which means bus_rate
> +		 * can provide a higher frequency than hosc_rate.
> +		 */
> +		use_bus_clk = false;
> +		val = mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
> +		if (val <= 1) {
> +			use_bus_clk = true;
> +			val = mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
> +			if (val <= 1)
> +				return -EINVAL;
> +		}
> +		div_m = fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
> +		if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +			return -EINVAL;
> +
> +		/* set up the CLK_DIV_M and clock CLK_SRC */
> +		clk_cfg = FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
> +		clk_cfg |= FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
> +
> +		sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2));
> +	}
> +
> +	/* calculate prescale_k, PWM entire cycle */
> +	ent_cycle = val >> div_m;
> +	prescale_k = DIV_ROUND_DOWN_ULL(ent_cycle, 65537);
> +	if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
> +		prescale_k = SUN20I_PWM_CTL_PRESCAL_K_MAX;
> +
> +	do_div(ent_cycle, prescale_k + 1);
> +
> +	/* for N cycles, PPRx.PWM_ENTIRE_CYCLE = (N-1) */
> +	reg_period = FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1);
> +
> +	/* set duty cycle */
> +	val = mul_u64_u64_div_u64(state->duty_cycle,
> +				  (use_bus_clk ? bus_rate : hosc_rate),
> +				  NSEC_PER_SEC);
> +	act_cycle = val >> div_m;
> +	do_div(act_cycle, prescale_k + 1);
> +
> +	/*
> +	 * The formula of the output period and the duty-cycle for PWM are as follows.
> +	 * T period = PWM0_PRESCALE_K / PWM01_CLK * (PPR0.PWM_ENTIRE_CYCLE + 1)
> +	 * T high-level = PWM0_PRESCALE_K / PWM01_CLK * PPR0.PWM_ACT_CYCLE
> +	 * Duty-cycle = T high-level / T period
> +	 */
> +	reg_period |= FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle);
> +	sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm->hwpwm));
> +
> +	ctl = FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
> +	if (state->polarity == PWM_POLARITY_NORMAL)
> +		ctl |= SUN20I_PWM_CTL_ACT_STA;
> +
> +	sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
> +
> +	if (state->enabled != pwm->state.enabled && state->enabled) {
> +		clk_gate &= ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
> +		clk_gate |= SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +		pwm_en |= SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops sun20i_pwm_ops = {
> +	.apply = sun20i_pwm_apply,
> +	.get_state = sun20i_pwm_get_state,
> +};
> +
> +static const struct of_device_id sun20i_pwm_dt_ids[] = {
> +	{ .compatible = "allwinner,sun20i-d1-pwm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
> +
> +static void sun20i_pwm_reset_ctrl_release(void *data)
> +{
> +	struct reset_control *rst = data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip;
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*sun20i_chip));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	sun20i_chip = to_sun20i_pwm_chip(chip);
> +
> +	sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
> +	if (IS_ERR(sun20i_chip->clk_bus))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
> +				     "failed to get bus clock\n");
> +
> +	sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");

A133 also have r_pwm,

+               r_pwm: pwm@7020c00 {
+                       compatible = "allwinner,sun20i-d1-pwm";
+                       reg = <0x7020c00 0x400>;
+                       clocks = <&ccu CLK_R_APB1_PWM>, <&ccu CLK_R_APB1_BUS_PWM>, <&ccu CLK_APB1>;
+                       clock-names = "bus", "mod", "apb";
+                       resets = <&r_ccu RST_R_APB1_BUS_PWM>;
+                       #pwm-cells = <0x3>;
+                       status = "disabled";
+               };
+

with "bus" clock and "mod" clock for gating it. Calling it as "hosc" doesn't
makes sense IMO. pwm-sun4i.c handles it already. Do we also need to handled "mod"?

> +	if (IS_ERR(sun20i_chip->clk_hosc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
> +				     "failed to get hosc clock\n");
> +
> +	sun20i_chip->clk_apb = devm_clk_get_enabled(&pdev->dev, "apb");
> +	if (IS_ERR(sun20i_chip->clk_apb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb),
> +				     "failed to get apb clock\n");
> +
> +	if (clk_get_rate(sun20i_chip->clk_apb) > clk_get_rate(sun20i_chip->clk_hosc))
> +		dev_info(&pdev->dev, "apb clock must be greater than hosc clock");

This is always the case if am not wrong. This condition check needed?

Thanks,
Parthiban

> +
> +	sun20i_chip->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(sun20i_chip->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
> +				     "failed to get bus reset\n");
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
> +				   &chip->npwm);
> +
> +	if (chip->npwm > 16) {
> +		dev_info(&pdev->dev, "limiting number of PWM lines from %u to 16",
> +			 chip->npwm);
> +		chip->npwm = 16;
> +	}
> +
> +	/* Deassert reset */
> +	ret = reset_control_deassert(sun20i_chip->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, sun20i_pwm_reset_ctrl_release, sun20i_chip->rst);
> +	if (ret)
> +		return ret;
> +
> +	chip->ops = &sun20i_pwm_ops;
> +
> +	mutex_init(&sun20i_chip->mutex);
> +
> +	ret = devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sun20i_pwm_driver = {
> +	.driver = {
> +		.name = "sun20i-pwm",
> +		.of_match_table = sun20i_pwm_dt_ids,
> +	},
> +	.probe = sun20i_pwm_probe,
> +};
> +module_platform_driver(sun20i_pwm_driver);
> +
> +MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
> +MODULE_DESCRIPTION("Allwinner sun20i PWM driver");
> +MODULE_LICENSE("GPL");


