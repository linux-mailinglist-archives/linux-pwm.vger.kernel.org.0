Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9968C22F09
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2019 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfETIe0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 May 2019 04:34:26 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:21342 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729354AbfETIe0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 May 2019 04:34:26 -0400
X-UUID: b58bd22e58254f2384bdf69571e7c1ac-20190520
X-UUID: b58bd22e58254f2384bdf69571e7c1ac-20190520
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1035860400; Mon, 20 May 2019 16:34:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 16:34:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 16:34:09 +0800
Message-ID: <1558341248.7311.42.camel@mtksdaap41>
Subject: Re: [v2 2/5] drm/mediatek: CMDQ reg address of mt8173 is different
 with mt2701
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Ajay Kumar" <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        "Rahul Sharma" <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Russell King" <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <stonea168@163.com>
Date:   Mon, 20 May 2019 16:34:08 +0800
In-Reply-To: <1558258406.367.2.camel@mszsdaap41>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
         <20190416060501.76276-3-jitao.shi@mediatek.com>
         <1557283144.31731.4.camel@mtksdaap41> <1558258406.367.2.camel@mszsdaap41>
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

On Sun, 2019-05-19 at 17:33 +0800, Jitao Shi wrote:
> On Wed, 2019-05-08 at 10:39 +0800, CK Hu wrote:
> > On Tue, 2019-04-16 at 14:04 +0800, Jitao Shi wrote:
> > > Config the different CMDQ reg address in driver data.
> > > 
> > For MT8173, you change reg_cmd_off from 0x180 to 0x200, so this patch is
> > a bug fix. You should add a 'Fixes' tag.
> > 
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 39 +++++++++++++++++++++++-------
> > >  1 file changed, 30 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > index 6c4ac37f983d..573e6bec6d36 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -131,7 +131,6 @@
> > >  #define VM_CMD_EN			BIT(0)
> > >  #define TS_VFP_EN			BIT(5)
> > >  
> > > -#define DSI_CMDQ0		0x180
> > >  #define CONFIG				(0xff << 0)
> > >  #define SHORT_PACKET			0
> > >  #define LONG_PACKET			2
> > > @@ -156,6 +155,10 @@
> > >  
> > >  struct phy;
> > >  
> > > +struct mtk_dsi_driver_data {
> > > +	const u32 reg_cmdq_off;
> > > +};
> > > +
> > >  struct mtk_dsi {
> > >  	struct mtk_ddp_comp ddp_comp;
> > >  	struct device *dev;
> > > @@ -182,6 +185,7 @@ struct mtk_dsi {
> > >  	bool enabled;
> > >  	u32 irq_data;
> > >  	wait_queue_head_t irq_wait_queue;
> > > +	struct mtk_dsi_driver_data *driver_data;
> > >  };
> > >  
> > >  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> > > @@ -934,6 +938,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> > >  	const char *tx_buf = msg->tx_buf;
> > >  	u8 config, cmdq_size, cmdq_off, type = msg->type;
> > >  	u32 reg_val, cmdq_mask, i;
> > > +	u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
> > >  
> > >  	if (MTK_DSI_HOST_IS_READ(type))
> > >  		config = BTA;
> > > @@ -953,9 +958,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> > >  	}
> > >  
> > >  	for (i = 0; i < msg->tx_len; i++)
> > > -		writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> > > +		mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> > > +			     (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> > > +			     tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));
> > 
> > You say you would follow Nicolas' suggestion here.
> > 
> 
> If i replace mtk_dsi_mask with writeb, i can't get right value from
> registers. I don't know why this.

I remember that Shaoming has also meet some error about writeb(), but he
finally fix this bug. You may get some hint from him. If we can not use
writeb(), this modification should be two patches: one is changing
DSI_CMDQ0 to reg_cmdq_off, another one is changing writeb() to
mtk_dsi_mask().

Regards,
CK

> 
> > >  
> > > -	mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> > > +	mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
> > >  	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
> > >  }
> > >  
> > > @@ -1074,10 +1081,27 @@ static const struct component_ops mtk_dsi_component_ops = {
> > >  	.unbind = mtk_dsi_unbind,
> > >  };
> > >  
> > > +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> > > +	.reg_cmdq_off = 0x200,
> > > +};
> > > +
> > > +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> > > +	.reg_cmdq_off = 0x180,
> > > +};
> > > +
> > > +static const struct of_device_id mtk_dsi_of_match[] = {
> > > +	{ .compatible = "mediatek,mt2701-dsi",
> > > +	  .data = &mt2701_dsi_driver_data },
> > > +	{ .compatible = "mediatek,mt8173-dsi",
> > > +	  .data = &mt8173_dsi_driver_data },
> > > +	{ },
> > > +};
> > > +
> > >  static int mtk_dsi_probe(struct platform_device *pdev)
> > >  {
> > >  	struct mtk_dsi *dsi;
> > >  	struct device *dev = &pdev->dev;
> > > +	const struct of_device_id *of_id;
> > >  	struct resource *regs;
> > >  	int irq_num;
> > >  	int comp_id;
> > > @@ -1101,6 +1125,9 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		goto err_unregister_host;
> > >  
> > > +	of_id = of_match_device(mtk_dsi_of_match, &pdev->dev);
> > > +	dsi->driver_data = of_id->data;
> > 
> > Maybe use of_device_get_match_data() is a more simple way. You could
> > refer to [1].
> > 
> > [1]
> > https://elixir.bootlin.com/linux/v5.1/source/drivers/gpu/drm/mediatek/mtk_disp_ovl.c#L300
> > 
> > Regards,
> > CK
> > 
> 
> I'll fix it next version.
> 
> > > +
> > >  	dsi->engine_clk = devm_clk_get(dev, "engine");
> > >  	if (IS_ERR(dsi->engine_clk)) {
> > >  		ret = PTR_ERR(dsi->engine_clk);
> > > @@ -1193,12 +1220,6 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> > >  	return 0;
> > >  }
> > >  
> > > -static const struct of_device_id mtk_dsi_of_match[] = {
> > > -	{ .compatible = "mediatek,mt2701-dsi" },
> > > -	{ .compatible = "mediatek,mt8173-dsi" },
> > > -	{ },
> > > -};
> > > -
> > >  struct platform_driver mtk_dsi_driver = {
> > >  	.probe = mtk_dsi_probe,
> > >  	.remove = mtk_dsi_remove,
> > 
> > 
> 
> 


