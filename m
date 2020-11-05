Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95372A8308
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgKEQHp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 11:07:45 -0500
Received: from netrider.rowland.org ([192.131.102.5]:39523 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726179AbgKEQHo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 11:07:44 -0500
Received: (qmail 1615519 invoked by uid 1000); 5 Nov 2020 11:07:43 -0500
Date:   Thu, 5 Nov 2020 11:07:43 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 21/30] usb: host: ehci-tegra: Support OPP and SoC core
 voltage scaling
Message-ID: <20201105160743.GA1613614@rowland.harvard.edu>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-22-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-22-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 05, 2020 at 02:44:18AM +0300, Dmitry Osipenko wrote:
> Add initial OPP and SoC core voltage scaling support to the Tegra EHCI
> driver. This is required for enabling system-wide DVFS on older Tegra
> SoCs.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

I'm no expert on OPP stuff, but some of what you have done here looks 
peculiar.

> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index 869d9c4de5fc..0976577f54b4 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> @@ -364,6 +365,79 @@ static void tegra_ehci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
>  	free_dma_aligned_buffer(urb);
>  }
>  
> +static void tegra_ehci_deinit_opp_table(void *data)
> +{
> +	struct device *dev = data;
> +	struct opp_table *opp_table;
> +
> +	opp_table = dev_pm_opp_get_opp_table(dev);
> +	dev_pm_opp_of_remove_table(dev);
> +	dev_pm_opp_put_regulators(opp_table);
> +	dev_pm_opp_put_opp_table(opp_table);
> +}
> +
> +static int devm_tegra_ehci_init_opp_table(struct device *dev)
> +{
> +	unsigned long rate = ULONG_MAX;
> +	struct opp_table *opp_table;
> +	const char *rname = "core";
> +	struct dev_pm_opp *opp;
> +	int err;
> +
> +	/* legacy device-trees don't have OPP table */
> +	if (!device_property_present(dev, "operating-points-v2"))
> +		return 0;
> +
> +	/* voltage scaling is optional */
> +	if (device_property_present(dev, "core-supply"))
> +		opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
> +	else
> +		opp_table = dev_pm_opp_get_opp_table(dev);
> +
> +	if (IS_ERR(opp_table))
> +		return dev_err_probe(dev, PTR_ERR(opp_table),
> +				     "failed to prepare OPP table\n");
> +
> +	err = dev_pm_opp_of_add_table(dev);
> +	if (err) {
> +		dev_err(dev, "failed to add OPP table: %d\n", err);
> +		goto put_table;
> +	}
> +
> +	/* find suitable OPP for the maximum clock rate */
> +	opp = dev_pm_opp_find_freq_floor(dev, &rate);
> +	err = PTR_ERR_OR_ZERO(opp);
> +	if (err) {
> +		dev_err(dev, "failed to get OPP: %d\n", err);
> +		goto remove_table;
> +	}
> +
> +	dev_pm_opp_put(opp);
> +
> +	/*
> +	 * First dummy rate-set initializes voltage vote by setting voltage
> +	 * in accordance to the clock rate.
> +	 */
> +	err = dev_pm_opp_set_rate(dev, rate);
> +	if (err) {
> +		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
> +		goto remove_table;
> +	}
> +
> +	err = devm_add_action(dev, tegra_ehci_deinit_opp_table, dev);
> +	if (err)
> +		goto remove_table;
> +
> +	return 0;
> +
> +remove_table:
> +	dev_pm_opp_of_remove_table(dev);
> +put_table:
> +	dev_pm_opp_put_regulators(opp_table);

Do you really want to use the same error unwinding for opp_table values 
obtained from dev_pm_opp_set_regulators() as from 
dev_pm_opp_get_opp_table()?

> +
> +	return err;
> +}
> +
>  static const struct tegra_ehci_soc_config tegra30_soc_config = {
>  	.has_hostpc = true,
>  };
> @@ -431,6 +505,11 @@ static int tegra_ehci_probe(struct platform_device *pdev)
>  		goto cleanup_hcd_create;
>  	}
>  
> +	err = devm_tegra_ehci_init_opp_table(&pdev->dev);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "Failed to initialize OPP\n");

Why log a second error message?  Just return err.

Alan Stern
