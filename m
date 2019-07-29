Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250F1784E6
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 08:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfG2GZ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 02:25:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60355 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2GZ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 02:25:56 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrz6V-0005fQ-Of; Mon, 29 Jul 2019 08:25:51 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrz6S-0002ca-VW; Mon, 29 Jul 2019 08:25:48 +0200
Date:   Mon, 29 Jul 2019 08:25:48 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wang Xiayang <xywang.sjtu@sjtu.edu.cn>,
        Yash Shah <yash.shah@sifive.com>
Cc:     thierry.reding@gmail.com, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] pwm: avoid disabling clk twice
Message-ID: <20190729062548.4pio5sfuxfwwxecr@pengutronix.de>
References: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Sat, Jul 27, 2019 at 03:09:16PM +0800, Wang Xiayang wrote:
> Similar to commit 63fd4b94b948 ("serial: imx: fix error handling
> in console_setup"), as ddata->clk has been explicitly disabled two
> lines above, it should avoid being disabled for the second time.
> clk_unprepare() suits here better.
> 
> Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
> ---
>  drivers/pwm/pwm-sifive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index a7c107f19e66..00f6fab5bd3b 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -312,7 +312,7 @@ static int pwm_sifive_remove(struct platform_device *dev)
>  	if (is_enabled)
>  		clk_disable(ddata->clk);
>  
> -	clk_disable_unprepare(ddata->clk);
> +	clk_unprepare(ddata->clk);
>  	ret = pwmchip_remove(&ddata->chip);
>  	clk_notifier_unregister(ddata->clk, &ddata->notifier);

I think this patch is wrong.

After a successfull call to .probe the clock is left prepared and
enabled. This is undone in the unconditional call to
clk_disable_unprepare that you removed.

There is however still a problem: If Linux is started with the pwm
enabled (such that .get_state returns state->enabled = true) then
disabling the pwm has one clk_disable too much.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
