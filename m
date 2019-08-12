Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A49898D6
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 10:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHLIlJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 04:41:09 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40042 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbfHLIlJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 04:41:09 -0400
X-UUID: bb1fdf773bde477f920666978733070e-20190812
X-UUID: bb1fdf773bde477f920666978733070e-20190812
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1888449034; Mon, 12 Aug 2019 16:40:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 12 Aug 2019 16:40:39 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 12 Aug 2019 16:40:39 +0800
Message-ID: <1565599241.3510.0.camel@mtksdaap41>
Subject: Re: [PATCH v6 2/7] drm/mediatek: fixes CMDQ reg address of mt8173
 is different with mt2701
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
Date:   Mon, 12 Aug 2019 16:40:41 +0800
In-Reply-To: <20190811104008.53372-3-jitao.shi@mediatek.com>
References: <20190811104008.53372-1-jitao.shi@mediatek.com>
         <20190811104008.53372-3-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24842.000
X-TM-AS-Result: No-13.018600-8.000000-10
X-TMASE-MatchedRID: L8tZF6zWW2rmLzc6AOD8DfHkpkyUphL9SWg+u4ir2NNquuOqohJ0c+8i
        8dew1/WnrdoLblq9S5olCvqYcPZDx7VdhtJxXnUI8pRHzcG+oi1vV3/OnMClWlVkJxysad/Iu/0
        GhfXBucU9osQh+w/oGQ81SqsdNAtCQSWnAG0egjGiAZ3zAhQYgn607foZgOWyf2dEskHXJhBRLT
        ERhRg1g3YZvR6JDTidiNK3wKXSWGL+651tSm/JkUeDzzDviY0OGEfoClqBl86bKItl61J/ycnjL
        TA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sSGDwQigllyZJi14HLH6kDpCPr2awuHdZ/xhI
        NXxE7nbxWl/hXOyjTA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.018600-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24842.000
X-TM-SNTS-SMTP: C14B02D73BB3E63EA400F57743FC20A46C0A1B48032BFB28AC7C29B36717EC8C2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Sun, 2019-08-11 at 18:40 +0800, Jitao Shi wrote:
> Config the different CMDQ reg address in driver data.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 52b49daeed9f..ac8e80e379f7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -123,7 +123,6 @@
>  #define VM_CMD_EN			BIT(0)
>  #define TS_VFP_EN			BIT(5)
>  
> -#define DSI_CMDQ0		0x180
>  #define CONFIG				(0xff << 0)
>  #define SHORT_PACKET			0
>  #define LONG_PACKET			2
> @@ -148,6 +147,10 @@
>  
>  struct phy;
>  
> +struct mtk_dsi_driver_data {
> +	const u32 reg_cmdq_off;
> +};
> +
>  struct mtk_dsi {
>  	struct mtk_ddp_comp ddp_comp;
>  	struct device *dev;
> @@ -174,6 +177,7 @@ struct mtk_dsi {
>  	bool enabled;
>  	u32 irq_data;
>  	wait_queue_head_t irq_wait_queue;
> +	const struct mtk_dsi_driver_data *driver_data;
>  };
>  
>  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> @@ -936,6 +940,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>  	const char *tx_buf = msg->tx_buf;
>  	u8 config, cmdq_size, cmdq_off, type = msg->type;
>  	u32 reg_val, cmdq_mask, i;
> +	u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
>  
>  	if (MTK_DSI_HOST_IS_READ(type))
>  		config = BTA;
> @@ -955,9 +960,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>  	}
>  
>  	for (i = 0; i < msg->tx_len; i++)
> -		writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> +		mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> +			     (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> +			     tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));

If writeb() has the same problem in MT2701, I think we need a patch that
just change writeb() to mtk_dsi_mask(), and then a patch to fix CMDQ reg
address of MT8173. So break this patch into two patches.

Regards,
CK

>  
> -	mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> +	mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
>  	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
>  }
>  
> @@ -1101,6 +1108,8 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_host;
>  
> +	dsi->driver_data = of_device_get_match_data(dev);
> +
>  	dsi->engine_clk = devm_clk_get(dev, "engine");
>  	if (IS_ERR(dsi->engine_clk)) {
>  		ret = PTR_ERR(dsi->engine_clk);
> @@ -1194,9 +1203,19 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> +	.reg_cmdq_off = 0x200,
> +};
> +
> +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> +	.reg_cmdq_off = 0x180,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
> -	{ .compatible = "mediatek,mt2701-dsi" },
> -	{ .compatible = "mediatek,mt8173-dsi" },
> +	{ .compatible = "mediatek,mt2701-dsi",
> +	  .data = &mt2701_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8173-dsi",
> +	  .data = &mt8173_dsi_driver_data },
>  	{ },
>  };
>  


