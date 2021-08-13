Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1563EB3C1
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Aug 2021 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhHMKDm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 13 Aug 2021 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbhHMKDQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Aug 2021 06:03:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF8C0613A4
        for <linux-pwm@vger.kernel.org>; Fri, 13 Aug 2021 03:02:36 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mEU14-0003CR-44; Fri, 13 Aug 2021 12:02:18 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mEU11-0003w2-Fx; Fri, 13 Aug 2021 12:02:15 +0200
Message-ID: <5da35c2030e57621fa56795cd193e727f53205fe.camel@pengutronix.de>
Subject: Re: [v11 2/2] pwm: Add Aspeed ast2600 PWM support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
Date:   Fri, 13 Aug 2021 12:02:15 +0200
In-Reply-To: <20210812040942.5365-3-billy_tsai@aspeedtech.com>
References: <20210812040942.5365-1-billy_tsai@aspeedtech.com>
         <20210812040942.5365-3-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Billy,

On Thu, 2021-08-12 at 12:09 +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
[...]
> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-ast2600.c
> new file mode 100644
> index 000000000000..f89ce1d4cd67
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-ast2600.c
> @@ -0,0 +1,327 @@
[...]
> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	priv->clk = devm_clk_get(&parent_dev->dev, 0);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->reset)) {
> +		ret = dev_err_probe(dev, PTR_ERR(priv->reset),
> +				    "Get reset failed\n");
> +		goto err_disable_clk;
> +	}

I suggest to request the reset control before enabling the clock. That
way you can simplify the error path and avoid enabling the clock in case
of reset_control_get failure.

regards
Philipp
