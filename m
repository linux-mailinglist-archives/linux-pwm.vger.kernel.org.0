Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F330662
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 03:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaBvG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 21:51:06 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47661 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726372AbfEaBvG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 21:51:06 -0400
X-UUID: 536ab7e78a6a489b8e6edd02f9c9b29e-20190531
X-UUID: 536ab7e78a6a489b8e6edd02f9c9b29e-20190531
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 645292041; Fri, 31 May 2019 09:50:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 May 2019 09:50:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 31 May 2019 09:50:52 +0800
Message-ID: <1559267452.9102.0.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: add dsi module reset driver
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
Date:   Fri, 31 May 2019 09:50:52 +0800
In-Reply-To: <20190519111513.73919-1-jitao.shi@mediatek.com>
References: <20190519111513.73919-1-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Sun, 2019-05-19 at 19:15 +0800, Jitao Shi wrote:
> Reset dsi HW to default when power on. Prevent the setting differet
> between bootloader and kernel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 35 ++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b00eb2d2e086..39ccb34a7c7f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -21,10 +21,12 @@
>  #include <linux/component.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <video/mipi_display.h>
>  #include <video/videomode.h>
>  
> @@ -146,6 +148,8 @@
>  #define T_HS_EXIT	7
>  #define T_HS_ZERO	10
>  
> +#define MMSYS_SW_RST_DSI_B BIT(25)
> +
>  #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
>  
>  #define MTK_DSI_HOST_IS_READ(type) \
> @@ -165,6 +169,8 @@ struct mtk_dsi {
>  	struct drm_panel *panel;
>  	struct drm_bridge *bridge;
>  	struct phy *phy;
> +	struct regmap *mmsys_sw_rst_b;
> +	u32 sw_rst_b;
>  
>  	void __iomem *regs;
>  
> @@ -238,6 +244,16 @@ static void mtk_dsi_disable(struct mtk_dsi *dsi)
>  	mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_EN, 0);
>  }
>  
> +static void mtk_dsi_reset_all(struct mtk_dsi *dsi)
> +{
> +	regmap_update_bits(dsi->mmsys_sw_rst_b, dsi->sw_rst_b,
> +			   MMSYS_SW_RST_DSI_B, ~MMSYS_SW_RST_DSI_B);
> +	usleep_range(1000, 1100);
> +
> +	regmap_update_bits(dsi->mmsys_sw_rst_b, dsi->sw_rst_b,
> +			   MMSYS_SW_RST_DSI_B, MMSYS_SW_RST_DSI_B);
> +}
> +
>  static void mtk_dsi_reset_engine(struct mtk_dsi *dsi)
>  {
>  	mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_RESET, DSI_RESET);
> @@ -831,6 +847,8 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
>  			goto err_encoder_cleanup;
>  	}
>  
> +	mtk_dsi_reset_all(dsi);
> +
>  	return 0;
>  
>  err_encoder_cleanup:
> @@ -1087,6 +1105,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	struct mtk_dsi *dsi;
>  	struct device *dev = &pdev->dev;
>  	struct resource *regs;
> +	struct regmap *regmap;
>  	int irq_num;
>  	int comp_id;
>  	int ret;
> @@ -1139,6 +1158,22 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						 "mediatek,syscon-dsi");

Where is the binding document for "mediatek,syscon-dsi"?

Regards,
CK

> +	ret = of_property_read_u32_index(dev->of_node, "mediatek,syscon-dsi", 1,
> +					 &dsi->sw_rst_b);
> +
> +	if (IS_ERR(regmap))
> +		ret = PTR_ERR(regmap);
> +
> +	if (ret) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "Failed to get mmsys registers: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dsi->mmsys_sw_rst_b = regmap;
> +
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>  	if (comp_id < 0) {
>  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);


