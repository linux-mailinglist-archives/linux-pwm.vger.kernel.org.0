Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F631186EC0
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 16:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgCPPkO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 11:40:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38229 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgCPPkO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 11:40:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jDrqb-0002qO-Tg; Mon, 16 Mar 2020 16:40:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jDrqa-0000Wt-8O; Mon, 16 Mar 2020 16:40:08 +0100
Date:   Mon, 16 Mar 2020 16:40:08 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: rcar: Fix late Runtime PM enablement
Message-ID: <20200316154008.e4yfe2bdeuju5e4g@pengutronix.de>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316103216.29383-2-geert+renesas@glider.be>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 16, 2020 at 11:32:14AM +0100, Geert Uytterhoeven wrote:
> Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> can appear immediately after the PWM chip has been added.
> Likewise, Runtime PM should be disabled after the removal of the PWM
> chip.
> 
> Fixes: ed6c1476bf7f16d5 ("pwm: Add support for R-Car PWM Timer")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pwm/pwm-rcar.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 2685577b6dd45be7..7ab9eb6616d950cb 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -229,24 +229,28 @@ static int rcar_pwm_probe(struct platform_device *pdev)
>  	rcar_pwm->chip.base = -1;
>  	rcar_pwm->chip.npwm = 1;
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = pwmchip_add(&rcar_pwm->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
>  	}
>  
> -	pm_runtime_enable(&pdev->dev);
> -

Wouldn't it be wiser to do the pm_runtime_enable in .request, or even in
.apply when enabled=true?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
