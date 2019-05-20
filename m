Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1822C4A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2019 08:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfETGsp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 May 2019 02:48:45 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41107 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbfETGsp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 May 2019 02:48:45 -0400
X-UUID: df6bf8f9060a436fbbf524ddfc74a8a6-20190520
X-UUID: df6bf8f9060a436fbbf524ddfc74a8a6-20190520
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1552444152; Mon, 20 May 2019 14:48:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 14:48:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 14:48:28 +0800
Message-ID: <1558334909.7311.27.camel@mtksdaap41>
Subject: Re: [v4 4/5] drm/mediatek: control dpi pins dpi or gpio mode in on
 or off
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
Date:   Mon, 20 May 2019 14:48:29 +0800
In-Reply-To: <20190518095618.18454-5-jitao.shi@mediatek.com>
References: <20190518095618.18454-1-jitao.shi@mediatek.com>
         <20190518095618.18454-5-jitao.shi@mediatek.com>
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

On Sat, 2019-05-18 at 17:56 +0800, Jitao Shi wrote:
> Pull dpi pins low when dpi has nothing to display. Aovid leakage
> current from some dpi pins (Hsync Vsync DE ... ).
> 
> Some chips have dpi pins, but there are some chip don't have pins.
> So this function is controlled by chips driver data.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 35 +++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 77e6e0f99188..0c4ba0a2be27 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -17,10 +17,12 @@
>  #include <drm/drm_of.h>
>  #include <linux/kernel.h>
>  #include <linux/component.h>
> -#include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/types.h>
>  #include <linux/clk.h>
> @@ -79,6 +81,9 @@ struct mtk_dpi {
>  	enum mtk_dpi_out_yc_map yc_map;
>  	enum mtk_dpi_out_bit_num bit_num;
>  	enum mtk_dpi_out_channel_swap channel_swap;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_default;
> +	struct pinctrl_state *pins_dpi;
>  	int refcount;
>  };
>  
> @@ -118,6 +123,7 @@ struct mtk_dpi_conf {
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
>  	bool dual_edge;
> +	bool dpi_pin_ctrl;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -392,6 +398,9 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>  	if (--dpi->refcount != 0)
>  		return;
>  
> +	if (dpi->conf->dpi_pin_ctrl)
> +		pinctrl_select_state(dpi->pinctrl, dpi->pins_default);
> +
>  	mtk_dpi_disable(dpi);
>  	clk_disable_unprepare(dpi->pixel_clk);
>  	clk_disable_unprepare(dpi->engine_clk);
> @@ -416,6 +425,9 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  		goto err_pixel;
>  	}
>  
> +	if (dpi->conf->dpi_pin_ctrl)
> +		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
> +
>  	mtk_dpi_enable(dpi);
>  	return 0;
>  
> @@ -724,6 +736,27 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	dpi->dev = dev;
>  	dpi->conf = (struct mtk_dpi_conf *)of_device_get_match_data(dev);
>  
> +	if (dpi->conf->dpi_pin_ctrl) {
> +		dpi->pinctrl = devm_pinctrl_get(&pdev->dev);

Please describe this in binding document.

Regards,
CK

> +		if (IS_ERR(dpi->pinctrl)) {
> +			dev_err(&pdev->dev, "Cannot find pinctrl!\n");
> +			return PTR_ERR(dpi->pinctrl);
> +		}
> +
> +		dpi->pins_default = pinctrl_lookup_state(dpi->pinctrl,
> +							 "default");
> +		if (IS_ERR(dpi->pins_default)) {
> +			dev_err(&pdev->dev, "Cannot find pinctrl default!\n");
> +			return PTR_ERR(dpi->pins_default);
> +		}
> +
> +		dpi->pins_dpi = pinctrl_lookup_state(dpi->pinctrl, "dpimode");
> +		if (IS_ERR(dpi->pins_dpi)) {
> +			dev_err(&pdev->dev, "Cannot find pinctrl dpimode!\n");
> +			return PTR_ERR(dpi->pins_dpi);
> +		}
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dpi->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(dpi->regs)) {


