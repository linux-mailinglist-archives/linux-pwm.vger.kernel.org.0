Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28A7783F
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfG0Kqd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 06:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfG0Kqd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 27 Jul 2019 06:46:33 -0400
Received: from localhost (lfbn-1-17239-195.w86-248.abo.wanadoo.fr [86.248.61.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCAD2081B;
        Sat, 27 Jul 2019 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564224392;
        bh=u64zJaHojBkDbTp0t96ojvihtDs1xf7xrWbz931/50Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqTef61oF6A8Qq8ZY3CYmHsNzAQ2jCkku6FceD6K/72NWyqsEB4UVVGhn0mIUGU3R
         ZAxQ8eo0fCkhjoCwUdSx9Boyng4mDIYwrpTCT8LiyHRJ2f9vivpE5dE+P/c8k8bqL5
         scBgxl4EKPkNXeyrd60WQZyqud4Cs5DZV6z9qV2Q=
Date:   Sat, 27 Jul 2019 12:46:28 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Message-ID: <20190727104628.jsdvpxvcpzru75v5@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-4-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> H6 PWM core needs bus clock to be enabled in order to work.
>
> Add a quirk for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1b7be8fbde86..7d3ac3f2dc3f 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
>  };
>
>  struct sun4i_pwm_data {
> +	bool has_bus_clock;
>  	bool has_prescaler_bypass;
>  	bool has_reset;
>  	unsigned int npwm;
> @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
>
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
> +	struct clk *bus_clk;
>  	struct clk *clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  		reset_control_deassert(pwm->rst);
>  	}
>
> +	if (pwm->data->has_bus_clock) {
> +		pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(pwm->bus_clk)) {
> +			ret = PTR_ERR(pwm->bus_clk);
> +			goto err_bus;
> +		}
> +
> +		clk_prepare_enable(pwm->bus_clk);
> +	}
> +

The patch itself looks fine, but you should clarify which clock is
being used by the old driver.

My guess is that the "new" clock is actually the mod one, while the
old one was both the clock of the register interface (bus) and the
clock of the PWM generation logic (mod).

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
