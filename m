Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A50186F83
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 17:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgCPQBN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 12:01:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38891 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbgCPQBM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:01:12 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jDsAv-0005XW-H4; Mon, 16 Mar 2020 17:01:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jDsAu-0001ai-OT; Mon, 16 Mar 2020 17:01:08 +0100
Date:   Mon, 16 Mar 2020 17:01:08 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: renesas-tpu: Fix late Runtime PM enablement
Message-ID: <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316103216.29383-3-geert+renesas@glider.be>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Geert,

On Mon, Mar 16, 2020 at 11:32:15AM +0100, Geert Uytterhoeven wrote:
> Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> can appear immediately after the PWM chip has been added.
> Likewise, Runtime PM should always be disabled after the removal of the
> PWM chip, even if the latter failed.
> 
> Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 4a855a21b782dea3..8032acc84161a9dd 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -415,16 +415,17 @@ static int tpu_probe(struct platform_device *pdev)
>  	tpu->chip.base = -1;
>  	tpu->chip.npwm = TPU_CHANNEL_MAX;
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = pwmchip_add(&tpu->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to register PWM chip\n");
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
>  	}
>  
>  	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
>  
> -	pm_runtime_enable(&pdev->dev);
> -
>  	return 0;
>  }
>  
> @@ -434,12 +435,10 @@ static int tpu_remove(struct platform_device *pdev)
>  	int ret;
>  
>  	ret = pwmchip_remove(&tpu->chip);
> -	if (ret)
> -		return ret;
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> -	return 0;
> +	return ret;
>  }

Maybe I was a bit quick with my reply to the previous patch. I wonder if
it is right to call pm_runtime_disable if pwmchip_remove failed?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
