Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33F7956E2
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 07:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfHTFvt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 01:51:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36227 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTFvs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 01:51:48 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzx3T-0003cJ-E8; Tue, 20 Aug 2019 07:51:39 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzx3S-0001r4-A2; Tue, 20 Aug 2019 07:51:38 +0200
Date:   Tue, 20 Aug 2019 07:51:38 +0200
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
Subject: Re: [PATCH v4 3/10] pwm: mediatek: allocate the clks array
 dynamically and fix mt7628 pwm
Message-ID: <20190820055138.hvvwdsdswrmptvej@pengutronix.de>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-4-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566265225-27452-4-git-send-email-sam.shih@mediatek.com>
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

On Tue, Aug 20, 2019 at 09:40:18AM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Instead of using fixed size of arrays, allocate the memory for them
> based on the information we get from the chips.
> 
> Also fix mt7628 pwm during configure from userspace. The SoC
> is legacy MIPS and has no complex clock tree. This patch add property
> clock-frequency to the SoC specific data and legacy MIPS SoC need to
> configure it in DT. This property is use for period calculation.

This fix is worth a separate patch.

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
> Changes since v4:
> - Follow reviewers's comments
> 1. use pc->soc->has_clks to check clocks exist or not.
> 2. Add error message when probe() unable to get clks
> - Fixes bug when SoC is old mips which has no complex clock tree.
> if clocks not exist, use the new property from DT to apply period caculation;
> otherwise, use clk_get_rate to get clock frequency and apply period caculation.
> ---
>  drivers/pwm/pwm-mediatek.c | 94 +++++++++++++++++++++++---------------
>  1 file changed, 56 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index f9d67fb66adb..a70b69a975c1 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -35,25 +35,6 @@
>  
>  #define PWM_CLK_DIV_MAX		7
>  
> -enum {
> -	MTK_CLK_MAIN = 0,
> -	MTK_CLK_TOP,
> -	MTK_CLK_PWM1,
> -	MTK_CLK_PWM2,
> -	MTK_CLK_PWM3,
> -	MTK_CLK_PWM4,
> -	MTK_CLK_PWM5,
> -	MTK_CLK_PWM6,
> -	MTK_CLK_PWM7,
> -	MTK_CLK_PWM8,
> -	MTK_CLK_MAX,
> -};
> -
> -static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
> -	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6", "pwm7",
> -	"pwm8"
> -};
> -
>  struct mtk_pwm_platform_data {
>  	unsigned int fallback_npwms;
>  	bool pwm45_fixup;
> @@ -64,12 +45,17 @@ struct mtk_pwm_platform_data {
>   * struct mtk_pwm_chip - struct representing PWM chip
>   * @chip: linux PWM chip representation
>   * @regs: base address of PWM chip
> - * @clks: list of clocks
> + * @clk_top: the top clock generator
> + * @clk_main: the clock used by PWM core
> + * @clk_pwms: the clock used by each PWM channel
>   */
>  struct mtk_pwm_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
> -	struct clk *clks[MTK_CLK_MAX];
> +	struct clk *clk_top;
> +	struct clk *clk_main;
> +	struct clk **clk_pwms;
> +	unsigned int clk_freq;
>  	const struct mtk_pwm_platform_data *soc;
>  };
>  
> @@ -90,24 +76,24 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	if (!pc->soc->has_clks)
>  		return 0;
>  
> -	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
> +	ret = clk_prepare_enable(pc->clk_top);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = clk_prepare_enable(pc->clks[MTK_CLK_MAIN]);
> +	ret = clk_prepare_enable(pc->clk_main);
>  	if (ret < 0)
>  		goto disable_clk_top;
>  
> -	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> +	ret = clk_prepare_enable(pc->clk_pwms[pwm->hwpwm]);
>  	if (ret < 0)
>  		goto disable_clk_main;
>  
>  	return 0;
>  
>  disable_clk_main:
> -	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> +	clk_disable_unprepare(pc->clk_main);
>  disable_clk_top:
> -	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> +	clk_disable_unprepare(pc->clk_top);
>  
>  	return ret;
>  }
> @@ -119,9 +105,9 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
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
> @@ -141,19 +127,24 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  int duty_ns, int period_ns)
>  {
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
> -	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
> +	unsigned int clk_freq;
>  	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
>  	    reg_thres = PWMTHRES;
>  	u64 resolution;
>  	int ret;
>  
> +	if (pc->soc->has_clks)
> +		clk_freq = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
> +	else
> +		clk_freq = pc->clk_freq;
> +
>  	ret = mtk_pwm_clk_enable(chip, pwm);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* Using resolution in picosecond gets accuracy higher */
>  	resolution = (u64)NSEC_PER_SEC * 1000;
> -	do_div(resolution, clk_get_rate(clk));
> +	do_div(resolution, clk_freq);
>  
>  	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
>  	while (cnt_period > 8191) {
> @@ -229,7 +220,8 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i, npwms;
> +	unsigned int npwms;
> +	unsigned int clk_freq;
>  	int ret;
>  
>  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> @@ -255,13 +247,40 @@ static int mtk_pwm_probe(struct platform_device *pdev)
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

Instead of using pc->soc->has_clks you could try

	ret = of_property_read_u32(np, "clock-frequency", &clk_freq);

and depend on that in the above if. This might allow to drop the
.has_clks member.

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

You missed to add an error message for "top" and "main".

> +		for (i = 0; i < npwms; i++) {
> +			char name[8];
> +
> +			snprintf(name, sizeof(name), "pwm%d", i + 1);
> +			pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
> +			if (IS_ERR(pc->clk_pwms[i])) {
> +				dev_err(&pdev->dev, "failed to get %s\n", name);

I'd mention "clock" in the error string and the return code.

> +				return PTR_ERR(pc->clk_pwms[i]);
> +			}
> +		}
> +	} else {
> +		ret = of_property_read_u32(np, "clock-frequency",
> +						&clk_freq);

Please align follow up lines to the opening (.

> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to get clk_freq\n");
> +			return ret;
>  		}
> +		pc->clk_freq = clk_freq;
>  	}
>  
>  	platform_set_drvdata(pdev, pc);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
