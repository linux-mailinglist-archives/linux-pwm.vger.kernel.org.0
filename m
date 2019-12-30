Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83312D01B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Dec 2019 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfL3MzB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Dec 2019 07:55:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40461 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3MzB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Dec 2019 07:55:01 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iluZU-0001GO-4J; Mon, 30 Dec 2019 13:54:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iluZS-0005OH-BM; Mon, 30 Dec 2019 13:54:54 +0100
Date:   Mon, 30 Dec 2019 13:54:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] pwm: imx27: Eliminate error message for defer probe
Message-ID: <20191230125454.7i4dahdc3wclpkgz@pengutronix.de>
References: <1577674960-12011-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1577674960-12011-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 30, 2019 at 11:02:40AM +0800, Anson Huang wrote:
> For defer probe error, no need to output error message which
> will cause confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 59d8b12..35a7ac42 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -319,9 +319,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>  
>  	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> -				PTR_ERR(imx->clk_ipg));
> -		return PTR_ERR(imx->clk_ipg);
> +		int ret = PTR_ERR(imx->clk_ipg);
> +
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"getting ipg clock failed with %d\n",
> +				ret);

While you touch this part, you could convert to %pe to get a more
expressive error message.

But even independent of this the patch is fine, so

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
