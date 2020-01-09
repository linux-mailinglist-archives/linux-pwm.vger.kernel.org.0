Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47C81353CF
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2020 08:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgAIHpA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 02:45:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59667 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgAIHpA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jan 2020 02:45:00 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipSUr-0002GW-6r; Thu, 09 Jan 2020 08:44:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ipSUn-0006QY-Cm; Thu, 09 Jan 2020 08:44:45 +0100
Date:   Thu, 9 Jan 2020 08:44:45 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
References: <20200109072735.GA22886@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109072735.GA22886@embeddedor>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Gustavo,

On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> 
> The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
> Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1afd41ebd3fd..a805c347ee84 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	 */
>  	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
>  	if (IS_ERR(pwm->clk)) {
> -		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)

How embarrassing that I didn't notice these. Thanks for catching.

Reviewed-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
