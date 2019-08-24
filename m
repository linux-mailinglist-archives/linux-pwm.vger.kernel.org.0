Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60A9BCCB
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfHXJag (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 05:30:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59977 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfHXJag (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 05:30:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1SNU-000304-GC; Sat, 24 Aug 2019 11:30:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1SNU-0000xV-2n; Sat, 24 Aug 2019 11:30:32 +0200
Date:   Sat, 24 Aug 2019 11:30:32 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] pwm: bcm2835: suppress error message during deferred
 probe
Message-ID: <20190824093032.cunkmukx73vl4hy3@pengutronix.de>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 24, 2019 at 09:07:25AM +0200, Stefan Wahren wrote:
> This suppresses error messages in case the PWM clock isn't ready yet.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/pwm/pwm-bcm2835.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 2c82386..ce362be 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -153,7 +153,10 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
> 
>  	pc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(pc->clk)) {
> -		dev_err(&pdev->dev, "clock not found: %ld\n", PTR_ERR(pc->clk));
> +		if (PTR_ERR(pc->clk) != -EPROBE_DEFER) {
> +			dev_err(&pdev->dev, "clock not found: %ld\n",
> +				PTR_ERR(pc->clk));
> +		}
>  		return PTR_ERR(pc->clk);
>  	}

I would have used:

	if (IS_ERR(pc->clk)) {
		int err = PTR_ERR(pc->clk);
		if (err != -EPROBE_DEFER)
			dev_err(&pdev->dev, "clock not found: %d\n", err);

		return err;
	}

This calculates the error code only once and make the dev_err line short
enough to not make it necessary to add a line break.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
