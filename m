Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793A7614790
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Nov 2022 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiKAKQ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Nov 2022 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKAKQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2022 06:16:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F118345
        for <linux-pwm@vger.kernel.org>; Tue,  1 Nov 2022 03:16:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id poK5o6hO9TyoupoK5oU5C1; Tue, 01 Nov 2022 11:16:53 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 11:16:53 +0100
X-ME-IP: 86.243.100.34
Message-ID: <4e7beec4-9b77-a125-6715-2699c453f5fe@wanadoo.fr>
Date:   Tue, 1 Nov 2022 11:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Content-Language: fr
To:     Billy Tsai <billy_tsai@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, lee.jones@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
In-Reply-To: <20221101095156.30591-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Le 01/11/2022 à 10:51, Billy Tsai a écrit :
> This patch add the support of Tachometer which can use to monitor the
> frequency of the input. The tach supports up to 16 channels and it's part
> function of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Hi,
a few nits below,

[...]

> +
> +	if (ret) {
> +		/* return 0 if we didn't get an answer because of timeout*/

Missing space at the end of the comment

> +		if (ret == -ETIMEDOUT)
> +			return 0;
> +		else
> +			return ret;

[...]

> +static int aspeed_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np, *child;
> +	struct aspeed_tach_data *priv;
> +	struct device *hwmon;
> +	struct platform_device *parent_dev;
> +	int ret;
> +
> +	np = dev->parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported tach device binding\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->tach_channel =
> +		devm_kzalloc(dev,
> +			     TACH_ASPEED_NR_TACHS * sizeof(*priv->tach_channel),
> +			     GFP_KERNEL);

use devm_kcalloc() instead of devm_kzalloc()?
Error handling?

> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(priv->dev, "Couldn't get regmap\n");

In order to be conistent with the other error handling paths:
return dev_err_probe()?

> +		return -ENODEV;
> +	}

[...]

