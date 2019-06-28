Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18E858FF9
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2019 03:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfF1Bwg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jun 2019 21:52:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23757 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725770AbfF1Bwg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jun 2019 21:52:36 -0400
X-UUID: 4e7295a59f6a4fe49a6fb68f6cabc20b-20190628
X-UUID: 4e7295a59f6a4fe49a6fb68f6cabc20b-20190628
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 519617362; Fri, 28 Jun 2019 09:52:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Jun 2019 09:52:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 09:52:17 +0800
Message-ID: <1561686737.29330.6.camel@mtksdaap41>
Subject: Re: [v5 3/3] drm/mediatek: add mipi_tx driver for mt8183
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Thierry Reding" <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        "Inki Dae" <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        "Sean Paul" <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        "Andy Yan" <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <stonea168@163.com>
Date:   Fri, 28 Jun 2019 09:52:17 +0800
In-Reply-To: <20190627025901.28418-4-jitao.shi@mediatek.com>
References: <20190627025901.28418-1-jitao.shi@mediatek.com>
         <20190627025901.28418-4-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: CA5F442E156FDDE3621346F41F60A5D93D885091CEC8BDF2ABC97A5840F65F712000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Thu, 2019-06-27 at 10:59 +0800, Jitao Shi wrote:
> This patch add mt8183 mipi_tx driver.
> And also support other chips that use the same binding and driver.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile             |   1 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        |   2 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |   1 +
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 181 ++++++++++++++++++
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 2c8de1f5a5ee..8067a4be8311 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -13,6 +13,7 @@ mediatek-drm-y := mtk_disp_color.o \
>  		  mtk_dsi.o \
>  		  mtk_mipi_tx.o \
>  		  mtk_mt8173_mipi_tx.o \
> +		  mtk_mt8183_mipi_tx.o \
>  		  mtk_dpi.o
>  
>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> index cdc68b88cefd..ab0fbfba5572 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -182,6 +182,8 @@ static const struct of_device_id mtk_mipi_tx_match[] = {
>  	  .data = &mt2701_mipitx_data },
>  	{ .compatible = "mediatek,mt8173-mipi-tx",
>  	  .data = &mt8173_mipitx_data },
> +	{ .compatible = "mediatek,mt8183-mipi-tx",
> +	  .data = &mt8183_mipitx_data },
>  	{ },
>  };
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> index 660726924992..3fd24563952e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> @@ -45,5 +45,6 @@ unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
>  
>  extern const struct mtk_mipitx_data mt2701_mipitx_data;
>  extern const struct mtk_mipitx_data mt8173_mipitx_data;
> +extern const struct mtk_mipitx_data mt8183_mipitx_data;
>  
>  #endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> new file mode 100644
> index 000000000000..7758bc95555c
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: jitao.shi <jitao.shi@mediatek.com>
> + */
> +
> +#include "mtk_mipi_tx.h"
> +
> +#define MIPITX_LANE_CON		0x000c
> +#define RG_DSI_CPHY_T1DRV_EN		BIT(0)
> +#define RG_DSI_ANA_CK_SEL		BIT(1)
> +#define RG_DSI_PHY_CK_SEL		BIT(2)
> +#define RG_DSI_CPHY_EN			BIT(3)
> +#define RG_DSI_PHYCK_INV_EN		BIT(4)
> +#define RG_DSI_PWR04_EN			BIT(5)
> +#define RG_DSI_BG_LPF_EN		BIT(6)
> +#define RG_DSI_BG_CORE_EN		BIT(7)
> +#define RG_DSI_PAD_TIEL_SEL		BIT(8)
> +
> +#define MIPITX_PLL_PWR	0x0028
> +#define MIPITX_PLL_CON0	0x002c
> +#define MIPITX_PLL_CON1	0x0030
> +#define MIPITX_PLL_CON2	0x0034
> +#define MIPITX_PLL_CON3	0x0038
> +#define MIPITX_PLL_CON4	0x003c
> +#define RG_DSI_PLL_IBIAS		(3 << 10)
> +
> +#define MIPITX_D2_SW_CTL_EN	0x0144
> +#define MIPITX_D0_SW_CTL_EN	0x0244
> +#define MIPITX_CK_CKMODE_EN	0x0328
> +#define DSI_CK_CKMODE_EN		BIT(0)
> +#define MIPITX_CK_SW_CTL_EN	0x0344
> +#define MIPITX_D1_SW_CTL_EN	0x0444
> +#define MIPITX_D3_SW_CTL_EN	0x0544
> +#define DSI_SW_CTL_EN			BIT(0)
> +#define AD_DSI_PLL_SDM_PWR_ON		BIT(0)
> +#define AD_DSI_PLL_SDM_ISO_EN		BIT(1)
> +
> +#define RG_DSI_PLL_EN			BIT(4)
> +#define RG_DSI_PLL_POSDIV		(0x7 << 8)
> +
> +static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +	int ret = 0;
> +
> +	ret = clk_prepare(mipi_tx->ref_clk);

In mtk_mipi_tx_power_on(), it calls

clk_prepare_enable(mipi_tx->pll);

This function break into

clk_prepare(mipi_tx->pll);

and

clk_enable(mipi_tx->pll);


In clk_prepare(), it would finally call into clk_core_prepare() [1], and
you could see

		ret = clk_core_prepare(core->parent);

		if (core->ops->prepare)
			ret = core->ops->prepare(core->hw);

This mean, before this clock is prepare, ccf would prepare its parent
clock, so you need not to prepare parent clock in this clock's prepare
callback function.

[1]
https://elixir.bootlin.com/linux/v5.2-rc6/source/drivers/clk/clk.c#L836

> +	if (ret < 0)
> +		dev_err(mipi_tx->dev,
> +			"can't prepare mipi_tx ref_clk %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +	unsigned int txdiv, txdiv0;
> +	u64 pcw;
> +	int ret;
> +
> +	dev_dbg(mipi_tx->dev, "enable: %u bps\n", mipi_tx->data_rate);
> +
> +	if (mipi_tx->data_rate >= 2000000000) {
> +		txdiv = 1;
> +		txdiv0 = 0;
> +	} else if (mipi_tx->data_rate >= 1000000000) {
> +		txdiv = 2;
> +		txdiv0 = 1;
> +	} else if (mipi_tx->data_rate >= 500000000) {
> +		txdiv = 4;
> +		txdiv0 = 2;
> +	} else if (mipi_tx->data_rate > 250000000) {
> +		txdiv = 8;
> +		txdiv0 = 3;
> +	} else if (mipi_tx->data_rate >= 125000000) {
> +		txdiv = 16;
> +		txdiv0 = 4;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_enable(mipi_tx->ref_clk);

Ditto.

Regards,
CK

> +	if (ret < 0) {
> +		dev_err(mipi_tx->dev,
> +			"can't enable mipi_tx ref_clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +	udelay(1);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> +	pcw = div_u64(((u64)mipi_tx->data_rate * txdiv) << 24, 26000000);
> +	writel(pcw, mipi_tx->regs + MIPITX_PLL_CON0);
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV,
> +				txdiv0 << 8);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +
> +	return 0;
> +}
> +
> +static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +
> +	clk_unprepare(mipi_tx->ref_clk);
> +}
> +
> +static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> +	clk_disable(mipi_tx->ref_clk);
> +}
> +
> +static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				       unsigned long *prate)
> +{
> +	return clamp_val(rate, 50000000, 1600000000);
> +}
> +
> +static const struct clk_ops mtk_mipi_tx_pll_ops = {
> +	.prepare = mtk_mipi_tx_pll_prepare,
> +	.enable = mtk_mipi_tx_pll_enable,
> +	.unprepare = mtk_mipi_tx_pll_unprepare,
> +	.disable = mtk_mipi_tx_pll_disable,
> +	.round_rate = mtk_mipi_tx_pll_round_rate,
> +	.set_rate = mtk_mipi_tx_pll_set_rate,
> +	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
> +};
> +
> +static void mtk_mipi_tx_power_on_signal(struct phy *phy)
> +{
> +	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> +
> +	/* BG_LPF_EN / BG_CORE_EN */
> +	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
> +	       mipi_tx->regs + MIPITX_LANE_CON);
> +	usleep_range(30, 100);
> +	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN,
> +	       mipi_tx->regs + MIPITX_LANE_CON);
> +
> +	/* Switch OFF each Lane */
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
> +}
> +
> +static void mtk_mipi_tx_power_off_signal(struct phy *phy)
> +{
> +	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> +
> +	/* Switch ON each Lane */
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
> +
> +	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
> +	       mipi_tx->regs + MIPITX_LANE_CON);
> +	writel(RG_DSI_PAD_TIEL_SEL, mipi_tx->regs + MIPITX_LANE_CON);
> +}
> +
> +const struct mtk_mipitx_data mt8183_mipitx_data = {
> +	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
> +	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
> +	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
> +};
> +


