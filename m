Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D127E8FE7D
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfHPIta (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 04:49:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38133 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHPIt3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 04:49:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyXvE-0003CT-N3; Fri, 16 Aug 2019 10:49:20 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyXvD-0002GK-0J; Fri, 16 Aug 2019 10:49:19 +0200
Date:   Fri, 16 Aug 2019 10:49:18 +0200
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
Subject: Re: [PATCH v3 2/10] pwm: mediatek: allocate the clks array
 dynamically
Message-ID: <20190816084918.gnpeosid2uqb6cgb@pengutronix.de>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
 <1565940088-845-3-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565940088-845-3-git-send-email-sam.shih@mediatek.com>
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

On Fri, Aug 16, 2019 at 03:21:20PM +0800, Sam Shih wrote:
> @@ -119,9 +104,9 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	if (!pc->soc->has_clks)
>  		return;
>  
> -	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> -	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> -	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> +	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
> +	clk_disable_unprepare(pc->clk_main);
> +	clk_disable_unprepare(pc->clk_top);
>  }
>  
>  static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
> @@ -141,7 +126,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  int duty_ns, int period_ns)
>  {
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
> -	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
> +	struct clk *clk = pc->soc->has_clks ? pc->clk_pwms[pwm->hwpwm] : NULL;

iff pc->soc->has_clks is false, pc->clk_pwms is NULL, right? Checking
the latter would be cheaper. (One pointer dereference that you then
reuse compared to two pointer dereferences.)

>  	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
>  	    reg_thres = PWMTHRES;
>  	u64 resolution;
> @@ -229,7 +214,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i, npwms;
> +	unsigned int npwms;
>  	int ret;
>  
>  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> @@ -255,12 +240,29 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
> -		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> -		if (IS_ERR(pc->clks[i])) {
> -			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> -				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
> -			return PTR_ERR(pc->clks[i]);
> +	if (pc->soc->has_clks) {
> +		int i;
> +
> +		pc->clk_pwms = devm_kcalloc(&pdev->dev, npwms,
> +					    sizeof(*pc->clk_pwms), GFP_KERNEL);
> +		if (!pc->clk_pwms)
> +			return -ENOMEM;
> +
> +		pc->clk_top = devm_clk_get(&pdev->dev, "top");
> +		if (IS_ERR(pc->clk_top))
> +			return PTR_ERR(pc->clk_top);
> +
> +		pc->clk_main = devm_clk_get(&pdev->dev, "main");
> +		if (IS_ERR(pc->clk_main))
> +			return PTR_ERR(pc->clk_main);
> +
> +		for (i = 0; i < npwms; i++) {
> +			char name[8];
> +
> +			snprintf(name, sizeof(name), "pwm%d", i + 1);
> +			pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
> +			if (IS_ERR(pc->clk_pwms[i]))
> +				return PTR_ERR(pc->clk_pwms[i]);

You dropped the error message here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
