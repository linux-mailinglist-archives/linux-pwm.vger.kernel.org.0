Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9722220
	for <lists+linux-pwm@lfdr.de>; Sat, 18 May 2019 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfERHvr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 May 2019 03:51:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725268AbfERHvq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 May 2019 03:51:46 -0400
X-UUID: 00c64ad0c4ba40d7b189bc49fad75e26-20190518
X-UUID: 00c64ad0c4ba40d7b189bc49fad75e26-20190518
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1821289005; Sat, 18 May 2019 15:51:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 18 May
 2019 15:51:36 +0800
Received: from [10.16.6.141] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 18 May 2019 15:51:33 +0800
Message-ID: <1558165892.7681.8.camel@mszsdaap41>
Subject: Re: [v2 3/3] drm/mediatek: add mipi_tx driver for mt8183
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
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
Date:   Sat, 18 May 2019 15:51:32 +0800
In-Reply-To: <1557134258.5345.5.camel@mtksdaap41>
References: <20190416054217.75387-1-jitao.shi@mediatek.com>
         <20190416054217.75387-4-jitao.shi@mediatek.com>
         <1557134258.5345.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 2019-05-06 at 17:17 +0800, CK Hu wrote:
> Hi, Jitao:
> 
> On Tue, 2019-04-16 at 13:42 +0800, Jitao Shi wrote:
> > This patch add mt8183 mipi_tx driver.
> > And also support other chips that use the same binding and driver.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/Makefile             |   1 +
> >  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        |   2 +
> >  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |   1 +
> >  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 154 ++++++++++++++++++
> >  4 files changed, 158 insertions(+)
> >  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> > 
> 
> [snip]
> 
> > +
> > +static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> > +{
> > +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> > +	unsigned int txdiv, txdiv0;
> > +	u64 pcw;
> > +	int ret;
> > +
> > +	dev_dbg(mipi_tx->dev, "prepare: %u bps\n", mipi_tx->data_rate);
> > +
> > +	if (mipi_tx->data_rate >= 2000000000) {
> > +		txdiv = 1;
> > +		txdiv0 = 0;
> > +	} else if (mipi_tx->data_rate >= 1000000000) {
> > +		txdiv = 2;
> > +		txdiv0 = 1;
> > +	} else if (mipi_tx->data_rate >= 500000000) {
> > +		txdiv = 4;
> > +		txdiv0 = 2;
> > +	} else if (mipi_tx->data_rate > 250000000) {
> > +		txdiv = 8;
> > +		txdiv0 = 3;
> > +	} else if (mipi_tx->data_rate >= 125000000) {
> > +		txdiv = 16;
> > +		txdiv0 = 4;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = clk_prepare_enable(mipi_tx->ref_clk);
> > +	if (ret < 0) {
> > +		dev_err(mipi_tx->dev,
> > +			"can't prepare and enable mipi_tx ref_clk %d\n", ret);
> > +		return ret;
> > +	}
> 
> You enable the parent clock when prepare this clock here, this behavior
> looks strange. I think the flow should be:
> 
> 1. Parent clock prepare
> 2. This clock prepare
> 3. Parent clock enable
> 4. This clock enable
> 
> Maybe you should implement 'enable callback' so that parent clock would
> be already enabled.
> 
> One question is, mipi_tx_pll is used by dsi driver, but I does not see
> dsi prepare_enable() mipi_tx_pll, how does this work?
> 
> Regards,
> CK
> 

The mipi_tx can be accessed after clk_prepare_enable(mipi_tx->ref_clk);

So place the clk_prepare_enable(mipi_tx->ref_clk) before accessing
mipitx.

mipi_tx_pll is enable by mtk_mipi_tx_power_on() in mtk_mip_tx.c.
clk_prepare_enable(mipi_tx->pll) will enable mipi_tx_pll.

Beset Regards
Jitao

> > +
> > +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
> > +
> > +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> > +	usleep_range(30, 100);
> > +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> > +	pcw = div_u64(((u64)mipi_tx->data_rate * txdiv) << 24, 26000000);
> > +	writel(pcw, mipi_tx->regs + MIPITX_PLL_CON0);
> > +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV,
> > +				txdiv0 << 8);
> > +	usleep_range(1000, 2000);
> > +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
> > +{
> > +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> > +
> > +	dev_dbg(mipi_tx->dev, "unprepare\n");
> > +
> > +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> > +
> > +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> > +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> > +	clk_disable_unprepare(mipi_tx->ref_clk);
> > +}
> > +
> 
> 


