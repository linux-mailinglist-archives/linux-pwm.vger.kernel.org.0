Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0FA22B79
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2019 07:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfETF47 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 May 2019 01:56:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58710 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbfETF47 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 May 2019 01:56:59 -0400
X-UUID: 05bdecd6d289420d988b3d3773fce335-20190520
X-UUID: 05bdecd6d289420d988b3d3773fce335-20190520
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1874507480; Mon, 20 May 2019 13:56:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 13:56:53 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 13:56:46 +0800
Message-ID: <1558331806.7311.26.camel@mtksdaap41>
Subject: Re: [v4 2/5] drm/mediatek: dpi dual edge support
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
Date:   Mon, 20 May 2019 13:56:46 +0800
In-Reply-To: <20190518095618.18454-3-jitao.shi@mediatek.com>
References: <20190518095618.18454-1-jitao.shi@mediatek.com>
         <20190518095618.18454-3-jitao.shi@mediatek.com>
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
> DPI sample the data both rising and falling edge.
> It can reduce half data io pins.

All the registers which you control in this patch exist in MT8173. So I
think this is not a SoC-level feature. This feature depends on how much
io pins you want to use in this platform. Could we get the io pins
information from device tree or calling any driver's api to get? If
there is no way to get this information, I could just temporarily apply
this patch and need plan to fix this temporary solution.

Regards,
CK

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 22e68a100e7b..ccef3ac1c560 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
> +	bool dual_edge;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
>  }
>  
> +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> +{
> +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> +		     DDR_EN | DDR_4PHASE);
> +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> +}
> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format format)
>  {
> @@ -444,7 +452,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	pll_rate = clk_get_rate(dpi->tvd_clk);
>  
>  	vm.pixelclock = pll_rate / factor;
> -	clk_set_rate(dpi->pixel_clk, vm.pixelclock);
> +	clk_set_rate(dpi->pixel_clk,
> +		     vm.pixelclock * (dpi->conf->dual_edge ? 2 : 1));
>  	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
>  
>  	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
> @@ -509,6 +518,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	mtk_dpi_config_color_format(dpi, dpi->color_format);
>  	mtk_dpi_config_2n_h_fre(dpi);
>  	mtk_dpi_config_disable_edge(dpi);
> +	if (dpi->conf->dual_edge)
> +		mtk_dpi_enable_dual_edge(dpi);
>  	mtk_dpi_sw_reset(dpi, false);
>  
>  	return 0;


