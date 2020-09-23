Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E042756DE
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWLJs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 07:09:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46376 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWLJq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 23 Sep 2020 07:09:46 -0400
X-Greylist: delayed 1238 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 07:09:45 EDT
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kL2Kc-0006VD-3y; Wed, 23 Sep 2020 12:49:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Simon South <simon@simonsouth.net>
Cc:     Simon South <simon@simonsouth.net>
Subject: Re: [PATCH v2] pwm: rockchip: Keep enabled PWMs running while probing
Date:   Wed, 23 Sep 2020 12:49:01 +0200
Message-ID: <8127994.CrzmY9MQ1E@diego>
In-Reply-To: <20200919193306.1023-1-simon@simonsouth.net>
References: <20200919193306.1023-1-simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am Samstag, 19. September 2020, 21:33:06 CEST schrieb Simon South:
> Following commit cfc4c189bc70 ("pwm: Read initial hardware state at
> request time") the Rockchip PWM driver can no longer assume a device's
> pwm_state structure has been populated after a call to pwmchip_add().
> Consequently, the test in rockchip_pwm_probe() intended to prevent the
> driver from stopping PWM devices already enabled by the bootloader no
> longer functions reliably and this can lead to the kernel hanging
> during startup, particularly on devices like the Pinebook Pro that use
> a PWM-controlled backlight for their display.
> 
> Avoid this by querying the device directly at probe time to determine
> whether or not it is enabled.
> 
> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
> Signed-off-by: Simon South <simon@simonsouth.net>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/pwm/pwm-rockchip.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index eb8c9cb645a6..098e94335cb5 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -288,6 +288,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  	const struct of_device_id *id;
>  	struct rockchip_pwm_chip *pc;
>  	struct resource *r;
> +	u32 enable_conf, ctrl;
>  	int ret, count;
>  
>  	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
> @@ -362,7 +363,9 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
> -	if (!pwm_is_enabled(pc->chip.pwms))
> +	enable_conf = pc->data->enable_conf;
> +	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	if ((ctrl & enable_conf) != enable_conf)
>  		clk_disable(pc->clk);
>  
>  	return 0;
> 




