Return-Path: <linux-pwm+bounces-655-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C128228CD
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jan 2024 08:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC981F22C7E
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jan 2024 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89AE179AF;
	Wed,  3 Jan 2024 07:16:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EF18021;
	Wed,  3 Jan 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 7F5F224E276;
	Wed,  3 Jan 2024 15:15:33 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 3 Jan
 2024 15:15:33 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 3 Jan
 2024 15:15:32 +0800
Message-ID: <b1a44192-4e7d-46c2-b9cf-969795208839@starfivetech.com>
Date: Wed, 3 Jan 2024 15:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] pwm: opencores: Add PWM driver support
Content-Language: en-US
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Hal Feng
	<hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-3-william.qiu@starfivetech.com>
From: William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20231222094548.54103-3-william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag



On 2023/12/22 17:45, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
> 
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 233 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 253 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9104430e148e..6a6c355150e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16145,6 +16145,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
> 
> +OPENCORES PWM DRIVER
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d87e1bb350ba 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
> 
> +config PWM_OCORES
> +	tristate "OpenCores PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ocores.
> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..517c4f643058 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
> +obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..dfb5a186da71
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only do inverted polarity.
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency) ns.
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency) ns.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* OCPWM_CTRL register bits*/
> +#define REG_OCPWM_EN      BIT(0)
> +#define REG_OCPWM_ECLK    BIT(1)
> +#define REG_OCPWM_NEC     BIT(2)
> +#define REG_OCPWM_OE      BIT(3)
> +#define REG_OCPWM_SIGNLE  BIT(4)
> +#define REG_OCPWM_INTE    BIT(5)
> +#define REG_OCPWM_INT     BIT(6)
> +#define REG_OCPWM_CNTRRST BIT(7)
> +#define REG_OCPWM_CAPTE   BIT(8)
> +
> +struct ocores_pwm_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	const struct ocores_pwm_data *data;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +struct ocores_pwm_data {
> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
> +};
> +
> +static inline u32 ocores_readl(struct ocores_pwm_device *ddata,
> +			       unsigned int channel,
> +			       unsigned int offset)
> +{
> +	void __iomem *base = ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
> +
> +	return readl(base + offset);
> +}
> +
> +static inline void ocores_writel(struct ocores_pwm_device *ddata,
> +				 unsigned int channel,
> +				 unsigned int offset, u32 val)
> +{
> +	void __iomem *base = ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
> +
> +	writel(val, base + offset);
> +}
> +
> +static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ocores_pwm_device, chip);
> +}
> +
> +static void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
> +						 unsigned int channel)
> +{
> +	unsigned int offset = (channel > 3 ? 1 << 15 : 0) + (channel & 3) * 0x10;
> +
> +	return base + offset;
> +}
> +
> +static int ocores_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data = ocores_readl(ddata, pwm->hwpwm, 0x8);
> +	duty_data = ocores_readl(ddata, pwm->hwpwm, 0x4);
> +	ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
> +
> +	state->period = DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, ddata->clk_rate);
> +	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, ddata->clk_rate);
> +	state->polarity = PWM_POLARITY_INVERSED;
> +	state->enabled = (ctrl_data & REG_OCPWM_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
> +	u32 ctrl_data = 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
> +	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
> +
> +	period_data = DIV_ROUND_DOWN_ULL(state->period * ddata->clk_rate, NSEC_PER_SEC);
> +	if (period_data <= U32_MAX)
> +		ocores_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
> +	else
> +		return -EINVAL;
> +
> +	duty_data = DIV_ROUND_DOWN_ULL(state->duty_cycle * ddata->clk_rate, NSEC_PER_SEC);
> +	if (duty_data <= U32_MAX)
> +		ocores_writel(ddata, pwm->hwpwm, 0x4, (u32)duty_data);
> +	else
> +		return -EINVAL;
> +
> +	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
> +
> +	if (state->enabled) {
> +		ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
> +		ocores_writel(ddata, pwm->hwpwm, 0xC, ctrl_data | REG_OCPWM_EN | REG_OCPWM_OE);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ocores_pwm_ops = {
> +	.get_state	= ocores_pwm_get_state,
> +	.apply		= ocores_pwm_apply,
> +};
> +
> +static const struct ocores_pwm_data jh7100_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct ocores_pwm_data jh7110_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct of_device_id ocores_pwm_of_match[] = {
> +	{ .compatible = "opencores,pwm-v1" },
> +	{ .compatible = "starfive,jh7100-pwm", .data = &jh7100_pwm_data},
> +	{ .compatible = "starfive,jh7110-pwm", .data = &jh7110_pwm_data},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
> +
> +static void ocores_reset_control_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev = &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	id = of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->data = id->data;
> +	chip = &ddata->chip;
> +	chip->dev = dev;
> +	chip->ops = &ocores_pwm_ops;
> +	chip->npwm = 8;
> +	chip->of_pwm_n_cells = 3;
> +
> +	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	ddata->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ddata->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(ddata->rst))
> +		return dev_err_probe(dev, PTR_ERR(ddata->rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	reset_control_deassert(ddata->rst);
> +
> +	ret = devm_add_action_or_reset(dev, ocores_reset_control_assert, ddata->rst);
> +	if (ret)
> +		return ret;
> +
> +	ddata->clk_rate = clk_get_rate(ddata->clk);
> +	if (ddata->clk_rate <= 0)
> +		return dev_err_probe(dev, ddata->clk_rate,
> +				     "Unable to get clock's rate\n");
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver ocores_pwm_driver = {
> +	.probe = ocores_pwm_probe,
> +	.driver = {
> +		.name = "ocores-pwm",
> +		.of_match_table = ocores_pwm_of_match,
> +	},
> +};
> +module_platform_driver(ocores_pwm_driver);
> +
> +MODULE_AUTHOR("Jieqin Chen");
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("OpenCores PWM PTC driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
> 


Hi Thierry Reding,

Could you please help me review this patch series to see if there is
anything that needs to be modified? If not, could you help me integrate
this patch into the main line? Thanks.
Thanks for taking time to review this patch series.
 
Best Regards,
William

