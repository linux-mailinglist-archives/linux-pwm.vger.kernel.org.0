Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B511FF1A3
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2020 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgFRM0v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 18 Jun 2020 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgFRMZ7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jun 2020 08:25:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82048C061794
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2020 05:25:59 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jltc8-0000Dc-C7; Thu, 18 Jun 2020 14:25:52 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jltc6-0001Th-NY; Thu, 18 Jun 2020 14:25:50 +0200
Message-ID: <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Date:   Thu, 18 Jun 2020 14:25:50 +0200
In-Reply-To: <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
         <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rahul,

On Thu, 2020-06-18 at 20:05 +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/pwm/Kconfig         |   9 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-intel-lgm.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 410 insertions(+)
>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
> 
[...]
> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
> new file mode 100644
> index 000000000000..3c7077acb161
> --- /dev/null
> +++ b/drivers/pwm/pwm-intel-lgm.c
> @@ -0,0 +1,400 @@
[...]
> +static int lgm_pwm_probe(struct platform_device *pdev)
> +{
> +	struct lgm_pwm_chip *pc;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *io_base;
> +	int ret;
> +
> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	io_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &pwm_regmap_config);
> +	if (IS_ERR(pc->regmap)) {
> +		ret = PTR_ERR(pc->regmap);
> +		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
> +		return ret;
> +	}
> +
> +	pc->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pc->clk)) {
> +		ret = PTR_ERR(pc->clk);
> +		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
> +		return ret;
> +	}
> +
> +	pc->rst = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(pc->rst)) {
> +		ret = PTR_ERR(pc->rst);
> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
> +		return ret;
> +	}

Please use devm_reset_control_get_exclusive() to make it explicit an
that exclusive reset control is requested. Given how the reset control
is used, I think this driver could also use
devm_reset_control_get_shared() to potentially allow sharing a reset
line with other devices.

regards
Philipp
