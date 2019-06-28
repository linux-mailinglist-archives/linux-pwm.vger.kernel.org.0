Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C631A5940B
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2019 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfF1GLU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jun 2019 02:11:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:30498 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726553AbfF1GLU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jun 2019 02:11:20 -0400
X-UUID: edc76ffecb64420db929cd2b85374bec-20190628
X-UUID: edc76ffecb64420db929cd2b85374bec-20190628
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 16841167; Fri, 28 Jun 2019 14:11:04 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Jun 2019 14:11:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 14:10:59 +0800
Message-ID: <1561702259.18399.7.camel@mtksdaap41>
Subject: Re: [v5 1/7] drm/mediatek: move mipi_dsi_host_register to probe
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
Date:   Fri, 28 Jun 2019 14:10:59 +0800
In-Reply-To: <20190627080116.40264-2-jitao.shi@mediatek.com>
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
         <20190627080116.40264-2-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24724.003
X-TM-AS-Result: No-14.037400-8.000000-10
X-TMASE-MatchedRID: xcONGPdDH5qi6/VcDv9f0PZvT2zYoYOwC/ExpXrHizxUvqB5o/Lqc/OP
        Ra/sN+oGYBSAIERqajwv+9DfuTEff7Ui+RdXr/ZOtbv6jY5MxFxp4xorO9dSmaB7/OvuB9jpd28
        7y76rWl0+Qs+JOuQ+IlY7maOxI4yfSiFYFnhBX7pj2Mi9Aq5L042QIlTs17Vzp0b7LIq4ACtfTm
        YPGZ1ZXQQiZjW65EMBQ9LDjgaivlliWV0DQ85LUho8wYJxWb0Oa01mhnn7t6RXiLrvhpKLfJgM2
        5fIhnOfCHezjIJ0pLdIj6eJVvD1DFpf1fzvophNR4PPMO+JjQ78k99z1mnW8f/rgj9ncWz9xF/T
        +1U99xstA6/Mm2plyirq6U1+7Bo3Zq5LaqHIPFRxoP7A9oFi1mfTym7IX+XOQW6eCaGxKwK8qAh
        8pZVO7cW9Hv1VMZJ6kZOl7WKIImrvXOvQVlExsFZ0V5tYhzdWxEHRux+uk8h+ICquNi0WJE/4MB
        J0dRDUt3l2bABoIbpXxQxn/ClNvtIxpUgjBEIFftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.037400-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24724.003
X-TM-SNTS-SMTP: 4958778A01CFEBB7262B1AF145B46BFD43D375275B178C9456AA22C035062F192000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Thu, 2019-06-27 at 16:01 +0800, Jitao Shi wrote:
> DSI panel driver need attach function which is inculde in
> mipi_dsi_host_ops.
> 
> If mipi_dsi_host_register is not in probe, dsi panel will
> probe more delay.
> 
> So move the mipi_dsi_host_register to probe from bind.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

This version is different than v4, so please remove reviewed-by tag when
this patch change. When I see a reviewed-by tag of mine, I would just
skip review it again because I assume this patch is the same as previous
version.

For this version, I give still give it a

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 53 +++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b00eb2d2e086..595b3b047c7b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -528,7 +528,7 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
>  
>  static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  {
> -	struct device *dev = dsi->dev;
> +	struct device *dev = dsi->->host.dev;
>  	int ret;
>  	u64 pixel_clock, total_bits;
>  	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
> @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>  		return ret;
>  	}
>  
> -	ret = mipi_dsi_host_register(&dsi->host);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to register DSI host: %d\n", ret);
> -		goto err_ddp_comp_unregister;
> -	}
> -
>  	ret = mtk_dsi_create_conn_enc(drm, dsi);
>  	if (ret) {
>  		DRM_ERROR("Encoder create failed with %d\n", ret);
> @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>  	return 0;
>  
>  err_unregister:
> -	mipi_dsi_host_unregister(&dsi->host);
> -err_ddp_comp_unregister:
>  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>  	return ret;
>  }
> @@ -1073,7 +1065,6 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
>  	struct mtk_dsi *dsi = dev_get_drvdata(dev);
>  
>  	mtk_dsi_destroy_conn_enc(dsi);
> -	mipi_dsi_host_unregister(&dsi->host);
>  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>  }
>  
> @@ -1097,31 +1088,36 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  
>  	dsi->host.ops = &mtk_dsi_ops;
>  	dsi->host.dev = dev;
> +	ret = mipi_dsi_host_register(&dsi->host);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register DSI host: %d\n", ret);
> +		return ret;
> +	}
>  
>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>  					  &dsi->panel, &dsi->bridge);
>  	if (ret)
> -		return ret;
> +		goto err_unregister_host;
>  
>  	dsi->engine_clk = devm_clk_get(dev, "engine");
>  	if (IS_ERR(dsi->engine_clk)) {
>  		ret = PTR_ERR(dsi->engine_clk);
>  		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	dsi->digital_clk = devm_clk_get(dev, "digital");
>  	if (IS_ERR(dsi->digital_clk)) {
>  		ret = PTR_ERR(dsi->digital_clk);
>  		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	dsi->hs_clk = devm_clk_get(dev, "hs");
>  	if (IS_ERR(dsi->hs_clk)) {
>  		ret = PTR_ERR(dsi->hs_clk);
>  		dev_err(dev, "Failed to get hs clock: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1129,33 +1125,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	if (IS_ERR(dsi->regs)) {
>  		ret = PTR_ERR(dsi->regs);
>  		dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	dsi->phy = devm_phy_get(dev, "dphy");
>  	if (IS_ERR(dsi->phy)) {
>  		ret = PTR_ERR(dsi->phy);
>  		dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>  	if (comp_id < 0) {
>  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> -		return comp_id;
> +		ret = comp_id;
> +		goto err_unregister_host;
>  	}
>  
>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
>  				&mtk_dsi_funcs);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize component: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	irq_num = platform_get_irq(pdev, 0);
>  	if (irq_num < 0) {
> -		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> -		return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get dsi irq_num: %d\n", irq_num);
> +		ret = irq_num;
> +		goto err_unregister_host;
>  	}
>  
>  	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> @@ -1163,14 +1161,24 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> -		return -EPROBE_DEFER;
> +		goto err_unregister_host;
>  	}
>  
>  	init_waitqueue_head(&dsi->irq_wait_queue);
>  
>  	platform_set_drvdata(pdev, dsi);
>  
> -	return component_add(&pdev->dev, &mtk_dsi_component_ops);
> +	ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add component: %d\n", ret);
> +		goto err_unregister_host;
> +	}
> +
> +	return 0;
> +
> +err_unregister_host:
> +	mipi_dsi_host_unregister(&dsi->host);
> +	return ret;
>  }
>  
>  static int mtk_dsi_remove(struct platform_device *pdev)
> @@ -1179,6 +1187,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>  
>  	mtk_output_dsi_disable(dsi);
>  	component_del(&pdev->dev, &mtk_dsi_component_ops);
> +	mipi_dsi_host_unregister(&dsi->host);
>  
>  	return 0;
>  }


