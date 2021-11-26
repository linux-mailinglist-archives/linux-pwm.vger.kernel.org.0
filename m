Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3145EB3A
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Nov 2021 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhKZKZW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 26 Nov 2021 05:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhKZKXW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Nov 2021 05:23:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0478BC06179B
        for <linux-pwm@vger.kernel.org>; Fri, 26 Nov 2021 02:11:12 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mqYBz-000796-FL; Fri, 26 Nov 2021 11:10:55 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mqYBw-0005NW-IR; Fri, 26 Nov 2021 11:10:52 +0100
Message-ID: <727777874f925c0d862887589a868859a95d3649.camel@pengutronix.de>
Subject: Re: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
Date:   Fri, 26 Nov 2021 11:10:52 +0100
In-Reply-To: <20210906024339.21124-3-billy_tsai@aspeedtech.com>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
         <20210906024339.21124-3-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Billy,

On Mon, 2021-09-06 at 10:43 +0800, Billy Tsai wrote:
[...]
> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +	struct device_node *np;
> +	struct platform_device *parent_dev;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported pwm device binding\n");
> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +
> +	parent_dev = of_find_device_by_node(np);
> +	priv->clk = devm_clk_get(&parent_dev->dev, 0);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->reset)) {
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +	}

I'd remove these curly braces for consistency with the code above.

regards
Philipp
