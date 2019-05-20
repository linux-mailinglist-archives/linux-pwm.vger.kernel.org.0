Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23ACB22C8F
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2019 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfETHGf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 May 2019 03:06:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2597 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730488AbfETHGf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 May 2019 03:06:35 -0400
X-UUID: 545b483f887e4af1bf9374d578975ef1-20190520
X-UUID: 545b483f887e4af1bf9374d578975ef1-20190520
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 804019200; Mon, 20 May 2019 15:06:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 15:06:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 15:06:28 +0800
Message-ID: <1558335988.7311.34.camel@mtksdaap41>
Subject: Re: [v2 1/5] drm/mediatek: move mipi_dsi_host_register to probe
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
Date:   Mon, 20 May 2019 15:06:28 +0800
In-Reply-To: <1558258588.367.5.camel@mszsdaap41>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
         <20190416060501.76276-2-jitao.shi@mediatek.com>
         <1557222735.3498.11.camel@mtksdaap41> <1558258588.367.5.camel@mszsdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 2019-05-19 at 17:36 +0800, Jitao Shi wrote:
> On Tue, 2019-05-07 at 17:52 +0800, CK Hu wrote:
> > Hi, Jitao:
> > 
> > On Tue, 2019-04-16 at 14:04 +0800, Jitao Shi wrote:
> > > DSI panel driver need attach function which is inculde in
> > > mipi_dsi_host_ops.
> > > 
> > > If mipi_dsi_host_register is not in probe, dsi panel will
> > > probe fail or more delay.
> > 
> > I think this patch just prevent delay, not to prevent dsi panel probe
> > fail. In [1], you mention mipi_dsi_attach() is called in
> > panel_simple_dsi_probe(), but panel_simple_dsi_probe() is trigger by
> > mipi_dsi_host_register(), so the probe would success.
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-simple.c?h=v5.0-rc6#n2987
> > 
> > 
> 
> Yes, this just prevent delay.
> 
> > > 
> > > So move the mipi_dsi_host_register to probe from bind.
> > > 
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 50 ++++++++++++++++++------------
> > >  1 file changed, 30 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > index b00eb2d2e086..6c4ac37f983d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> > >  		return ret;
> > >  	}
> > >  
> > > -	ret = mipi_dsi_host_register(&dsi->host);
> > > -	if (ret < 0) {
> > > -		dev_err(dev, "failed to register DSI host: %d\n", ret);
> > > -		goto err_ddp_comp_unregister;
> > > -	}
> > > -
> > >  	ret = mtk_dsi_create_conn_enc(drm, dsi);
> > >  	if (ret) {
> > >  		DRM_ERROR("Encoder create failed with %d\n", ret);
> > > @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> > >  	return 0;
> > >  
> > >  err_unregister:
> > > -	mipi_dsi_host_unregister(&dsi->host);
> > > -err_ddp_comp_unregister:
> > >  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
> > >  	return ret;
> > >  }
> > > @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> > >  
> > >  	dsi->host.ops = &mtk_dsi_ops;
> > >  	dsi->host.dev = dev;
> > > +	dsi->dev = dev;
> > 
> > Why do this?
> > 
> > Regards,
> > CK
> > 
> 
> There are some error message require this poweron().

So this should not be in this patch. This patch is related to the timing
of mipi_dsi_host_register().

Regards,
CK

> 
> > > +	ret = mipi_dsi_host_register(&dsi->host);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to register DSI host: %d\n", ret);
> > > +		return ret;
> > > +	}
> > >  
> > >  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> > >  					  &dsi->panel, &dsi->bridge);
> > >  	if (ret)
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  
> > >  	dsi->engine_clk = devm_clk_get(dev, "engine");
> > >  	if (IS_ERR(dsi->engine_clk)) {
> > >  		ret = PTR_ERR(dsi->engine_clk);
> > >  		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  	}
> > >  
> > >  	dsi->digital_clk = devm_clk_get(dev, "digital");
> > >  	if (IS_ERR(dsi->digital_clk)) {
> > >  		ret = PTR_ERR(dsi->digital_clk);
> > >  		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  	}
> > >  
> > >  	dsi->hs_clk = devm_clk_get(dev, "hs");
> > >  	if (IS_ERR(dsi->hs_clk)) {
> > >  		ret = PTR_ERR(dsi->hs_clk);
> > >  		dev_err(dev, "Failed to get hs clock: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unregister_host;
> > >  	}
> > >  
> > >  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > 
> > 
> > 
> 
> 


