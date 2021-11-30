Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E848146304D
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Nov 2021 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbhK3J4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 30 Nov 2021 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbhK3Jz7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 04:55:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E255C061746
        for <linux-pwm@vger.kernel.org>; Tue, 30 Nov 2021 01:52:40 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mrzoB-0003kK-0n; Tue, 30 Nov 2021 10:52:19 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mrzo9-0003oR-5R; Tue, 30 Nov 2021 10:52:17 +0100
Message-ID: <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
Subject: Re: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, lee.jones@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com
Date:   Tue, 30 Nov 2021 10:52:17 +0100
In-Reply-To: <20211129064329.27006-3-billy_tsai@aspeedtech.com>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
         <20211129064329.27006-3-billy_tsai@aspeedtech.com>
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

On Mon, 2021-11-29 at 14:43 +0800, Billy Tsai wrote:
[...]
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Couldn't deassert reset control\n");
> +		goto err_disable_clk;
> +	}

Is there any reason to keep the clocks running and the controller out of
reset while the PWM outputs are disabled?

regards
Philipp
