Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517CF59022
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2019 04:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfF1CDC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jun 2019 22:03:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36781 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725770AbfF1CDC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jun 2019 22:03:02 -0400
X-UUID: c2ece93bab67479591380ff8da29426a-20190628
X-UUID: c2ece93bab67479591380ff8da29426a-20190628
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1235482751; Fri, 28 Jun 2019 10:02:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Jun 2019 10:02:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 10:02:51 +0800
Message-ID: <1561687371.29330.11.camel@mtksdaap41>
Subject: Re: [v5 2/3] drm/mediatek: separate mipi_tx to different file
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
Date:   Fri, 28 Jun 2019 10:02:51 +0800
In-Reply-To: <20190627025901.28418-3-jitao.shi@mediatek.com>
References: <20190627025901.28418-1-jitao.shi@mediatek.com>
         <20190627025901.28418-3-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24722.000
X-TM-AS-Result: No-10.247700-8.000000-10
X-TMASE-MatchedRID: L8tZF6zWW2rmLzc6AOD8DfHkpkyUphL9APiR4btCEeZJK2eJhY02w+Z5
        Gn23AeDZBCJmNbrkQwEB1c8PTXnqofI1YbpS1+avgmAd4Attpn/YuVu0X/rOkBpX1zEL4nq3zod
        Om+zp8Klvb8FTrUVVI7tTg4w4u0QPVdgv/fqHkl7obINHZkH5xqgmQ5FI9tvDDlLOAk1ICsupTt
        npKpQyOnuvCtBi52L250DWRAwkrYTtmWsUlPYSbZXIRfiL5JZTGEfoClqBl86bKItl61J/ycnjL
        TA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sHFf9y5qyR15CjO3g32i4QW3xAkDtY0KKM0RM
        yIBWAJybBCcU0pWFpQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.247700-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24722.000
X-TM-SNTS-SMTP: 5329DA286C4A6660442E20F3A9F915E02E66B2517D31A07EE8877C820797CA0F2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Thu, 2019-06-27 at 10:59 +0800, Jitao Shi wrote:
> Different IC has different mipi_tx setting of dsi.
> This patch separates the mipi_tx hardware relate part for mt8173.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile             |   1 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 343 ++----------------
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  49 +++
>  drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 289 +++++++++++++++
>  4 files changed, 363 insertions(+), 319 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> 

[snip]

> @@ -391,10 +101,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mipi_tx *mipi_tx;
>  	struct resource *mem;
> -	struct clk *ref_clk;
>  	const char *ref_clk_name;
>  	struct clk_init_data clk_init = {
> -		.ops = &mtk_mipi_tx_pll_ops,
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
>  		.flags = CLK_SET_RATE_GATE,
> @@ -408,6 +116,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mipi_tx->driver_data = of_device_get_match_data(dev);
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mipi_tx->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(mipi_tx->regs)) {
> @@ -416,13 +125,14 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ref_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ref_clk)) {
> -		ret = PTR_ERR(ref_clk);
> +	mipi_tx->ref_clk = devm_clk_get(dev, NULL);

I think you need not to keep ref_clk in driver private data because you
would not use it any more.

Regards,
CK

> +	if (IS_ERR(mipi_tx->ref_clk)) {
> +		ret = PTR_ERR(mipi_tx->ref_clk);
>  		dev_err(dev, "Failed to get reference clock: %d\n", ret);
>  		return ret;
>  	}
> -	ref_clk_name = __clk_get_name(ref_clk);
> +
> +	ref_clk_name = __clk_get_name(mipi_tx->ref_clk);
>  
>  	ret = of_property_read_string(dev->of_node, "clock-output-names",
>  				      &clk_init.name);
> @@ -431,6 +141,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	clk_init.ops = mipi_tx->driver_data->mipi_tx_clk_ops;
> +
>  	mipi_tx->pll_hw.init = &clk_init;
>  	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
>  	if (IS_ERR(mipi_tx->pll)) {
> @@ -465,20 +177,12 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  




