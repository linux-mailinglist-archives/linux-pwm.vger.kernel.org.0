Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7E956A9
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 07:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfHTFcn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 01:32:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49651 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfHTFcm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 01:32:42 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzwky-0001r5-O7; Tue, 20 Aug 2019 07:32:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzwkw-0001MG-Jm; Tue, 20 Aug 2019 07:32:30 +0200
Date:   Tue, 20 Aug 2019 07:32:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/10] pwm: mediatek: add a property "num-pwms"
Message-ID: <20190820053230.veu5qseftw45laka@pengutronix.de>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-2-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566265225-27452-2-git-send-email-sam.shih@mediatek.com>
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

On Tue, Aug 20, 2019 at 09:40:16AM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This adds a property "num-pwms" to avoid having an endless
> list of compatibles with no differences for the same driver.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
> Used:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=68207
> 
> Changes since v4:
> Follow reviewer's comments:
> Move the changes of droping the check for of_device_get_match_data
> returning non-NULL to next patch
> ---
>  drivers/pwm/pwm-mediatek.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index eb6674ce995f..287fda3674ce 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -55,7 +55,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
>  };
>  
>  struct mtk_pwm_platform_data {
> -	unsigned int num_pwms;
> +	unsigned int fallback_npwms;
>  	bool pwm45_fixup;
>  	bool has_clks;
>  };
> @@ -226,10 +226,10 @@ static const struct pwm_ops mtk_pwm_ops = {
>  
>  static int mtk_pwm_probe(struct platform_device *pdev)
>  {
> -	const struct mtk_pwm_platform_data *data;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i;
> +	unsigned int i, npwms;
>  	int ret;
>  
>  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> @@ -246,7 +246,19 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->regs))
>  		return PTR_ERR(pc->regs);
>  
> -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> +	ret = of_property_read_u32(np, "num-pwms", &npwms);
> +	if (ret < 0) {
> +		/* It's deprecated, we should specify num_pwms via DT now. */
> +		if (pc->soc->fallback_npwms) {
> +			npwms = pc->soc->fallback_npwms;
> +			dev_warn(&pdev->dev, "DT is outdated, please update it\n");
> +		} else {
> +			dev_err(&pdev->dev, "failed to get number of PWMs\n");
> +			return ret;
> +		}
> +	}

I'd suggest to add here:

	if (npwms > ARRAY_SIZE(mtk_pwm_clk_name) + 2)
		npwms = ARRAY_SIZE(mtk_pwm_clk_name) + 2;

to ensure to not use mtk_pwm_clk_name[10].

Best regards
Uwe

> +
> +	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
>  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
>  		if (IS_ERR(pc->clks[i])) {
>  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> @@ -260,7 +272,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	pc->chip.dev = &pdev->dev;
>  	pc->chip.ops = &mtk_pwm_ops;
>  	pc->chip.base = -1;
> -	pc->chip.npwm = data->num_pwms;
> +	pc->chip.npwm = npwms;
>  
>  	ret = pwmchip_add(&pc->chip);
>  	if (ret < 0) {
> @@ -279,25 +291,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>  }
>  
>  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
> -	.num_pwms = 8,
> +	.fallback_npwms = 8,
>  	.pwm45_fixup = false,
>  	.has_clks = true,
>  };
>  
>  static const struct mtk_pwm_platform_data mt7622_pwm_data = {
> -	.num_pwms = 6,
> +	.fallback_npwms = 6,
>  	.pwm45_fixup = false,
>  	.has_clks = true,
>  };
>  
>  static const struct mtk_pwm_platform_data mt7623_pwm_data = {
> -	.num_pwms = 5,
> +	.fallback_npwms = 5,
>  	.pwm45_fixup = true,
>  	.has_clks = true,
>  };
>  
>  static const struct mtk_pwm_platform_data mt7628_pwm_data = {
> -	.num_pwms = 4,
> +	.fallback_npwms = 4,
>  	.pwm45_fixup = true,
>  	.has_clks = false,
>  };
> -- 
> 2.17.1
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
