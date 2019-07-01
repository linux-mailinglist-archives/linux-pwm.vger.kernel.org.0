Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086445B2C5
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2019 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGABnc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Jun 2019 21:43:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18008 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727254AbfGABnc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Jun 2019 21:43:32 -0400
X-UUID: 97e9298511544f678217b87340050466-20190701
X-UUID: 97e9298511544f678217b87340050466-20190701
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1285107656; Mon, 01 Jul 2019 09:43:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Jul 2019 09:43:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Jul 2019 09:43:07 +0800
Message-ID: <1561945387.17120.4.camel@mtksdaap41>
Subject: Re: [v5 6/7] drm/mediatek: change the dsi phytiming calculate method
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
        <stonea168@163.com>, "Ryan Case" <ryandcase@chromium.org>
Date:   Mon, 1 Jul 2019 09:43:07 +0800
In-Reply-To: <20190627080116.40264-7-jitao.shi@mediatek.com>
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
         <20190627080116.40264-7-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 7D73A884143A183CC5055765D067BC0CCD0AF259C8AD423183E83DE5433058D82000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Thu, 2019-06-27 at 16:01 +0800, Jitao Shi wrote:
> Change the method of frame rate calc which can get more accurate
> frame rate.
> 
> data rate = pixel_clock * bit_per_pixel / lanes
> Adjust hfp_wc to adapt the additional phy_data
> 
> if MIPI_DSI_MODE_VIDEO_BURST
> 	hfp_wc = hfp * bpp - data_phy_cycles * lanes - 12 - 6;
> else
> 	hfp_wc = hfp * bpp - data_phy_cycles * lanes - 12;
> 
> Note:
> //(2: 1 for sync, 1 for phy idle)
> data_phy_cycles = T_hs_exit + T_lpx + T_hs_prepare + T_hs_zero + 2;
> 
> bpp: bit per pixel
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Tested-by: Ryan Case <ryandcase@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

This version is different than previous version, so you should remove
Reviewed-by tag. For this version, I still give you a

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 117 ++++++++++++++++++++---------
>  1 file changed, 80 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 1621e8cdacc2..cefdcb1509cb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -144,12 +144,6 @@
>  #define DATA_0				(0xff << 16)
>  #define DATA_1				(0xff << 24)
>  
> -#define T_LPX		5
> -#define T_HS_PREP	6
> -#define T_HS_TRAIL	8
> -#define T_HS_EXIT	7
> -#define T_HS_ZERO	10
> -
>  #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
>  
>  #define MTK_DSI_HOST_IS_READ(type) \
> @@ -158,6 +152,25 @@
>  	(type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
>  	(type == MIPI_DSI_DCS_READ))
>  
> +struct mtk_phy_timing {
> +	u32 lpx;
> +	u32 da_hs_prepare;
> +	u32 da_hs_zero;
> +	u32 da_hs_trail;
> +
> +	u32 ta_go;
> +	u32 ta_sure;
> +	u32 ta_get;
> +	u32 da_hs_exit;
> +
> +	u32 clk_hs_zero;
> +	u32 clk_hs_trail;
> +
> +	u32 clk_hs_prepare;
> +	u32 clk_hs_post;
> +	u32 clk_hs_exit;
> +};
> +
>  struct phy;
>  
>  struct mtk_dsi_driver_data {
> @@ -188,6 +201,7 @@ struct mtk_dsi {
>  	enum mipi_dsi_pixel_format format;
>  	unsigned int lanes;
>  	struct videomode vm;
> +	struct mtk_phy_timing phy_timing;
>  	int refcount;
>  	bool enabled;
>  	u32 irq_data;
> @@ -221,17 +235,36 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
>  {
>  	u32 timcon0, timcon1, timcon2, timcon3;
>  	u32 ui, cycle_time;
> +	struct mtk_phy_timing *timing = &dsi->phy_timing;
> +
> +	ui = 1000000000 / dsi->data_rate;
> +	cycle_time = div_u64(8000000000ULL, dsi->data_rate);
> +
> +	timing->lpx = NS_TO_CYCLE(60, cycle_time);
> +	timing->da_hs_prepare = NS_TO_CYCLE(40 + 5 * ui, cycle_time);
> +	timing->da_hs_zero = NS_TO_CYCLE(110 + 6 * ui, cycle_time);
> +	timing->da_hs_trail = NS_TO_CYCLE(80 + 4 * ui, cycle_time);
>  
> -	ui = 1000 / dsi->data_rate + 0x01;
> -	cycle_time = 8000 / dsi->data_rate + 0x01;
> +	timing->ta_go = 4 * timing->lpx;
> +	timing->ta_sure = 3 * timing->lpx / 2;
> +	timing->ta_get = 5 * timing->lpx;
> +	timing->da_hs_exit = 2 * timing->lpx;
>  
> -	timcon0 = T_LPX | T_HS_PREP << 8 | T_HS_ZERO << 16 | T_HS_TRAIL << 24;
> -	timcon1 = 4 * T_LPX | (3 * T_LPX / 2) << 8 | 5 * T_LPX << 16 |
> -		  T_HS_EXIT << 24;
> -	timcon2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
> -		  (NS_TO_CYCLE(0x150, cycle_time) << 16);
> -	timcon3 = NS_TO_CYCLE(0x40, cycle_time) | (2 * T_LPX) << 16 |
> -		  NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8;
> +	timing->clk_hs_zero = NS_TO_CYCLE(336, cycle_time);
> +	timing->clk_hs_trail = NS_TO_CYCLE(100, cycle_time) + 10;
> +
> +	timing->clk_hs_prepare = NS_TO_CYCLE(64, cycle_time);
> +	timing->clk_hs_post = NS_TO_CYCLE(80 + 52 * ui, cycle_time);
> +	timing->clk_hs_exit = 2 * timing->lpx;
> +
> +	timcon0 = timing->lpx | timing->da_hs_prepare << 8 |
> +		  timing->da_hs_zero << 16 | timing->da_hs_trail << 24;
> +	timcon1 = timing->ta_go | timing->ta_sure << 8 |
> +		  timing->ta_get << 16 | timing->da_hs_exit << 24;
> +	timcon2 = 1 << 8 | timing->clk_hs_zero << 16 |
> +		  timing->clk_hs_trail << 24;
> +	timcon3 = timing->clk_hs_prepare | timing->clk_hs_post << 8 |
> +		  timing->clk_hs_exit << 16;
>  
>  	writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
>  	writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
> @@ -418,7 +451,8 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>  	u32 horizontal_sync_active_byte;
>  	u32 horizontal_backporch_byte;
>  	u32 horizontal_frontporch_byte;
> -	u32 dsi_tmp_buf_bpp;
> +	u32 dsi_tmp_buf_bpp, data_phy_cycles;
> +	struct mtk_phy_timing *timing = &dsi->phy_timing;
>  
>  	struct videomode *vm = &dsi->vm;
>  
> @@ -445,7 +479,34 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>  		horizontal_backporch_byte = ((vm->hback_porch + vm->hsync_len) *
>  			dsi_tmp_buf_bpp - 10);
>  
> -	horizontal_frontporch_byte = (vm->hfront_porch * dsi_tmp_buf_bpp - 12);
> +	data_phy_cycles = timing->lpx + timing->da_hs_prepare +
> +				  timing->da_hs_zero + timing->da_hs_exit + 2;
> +
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +		if (vm->hfront_porch * dsi_tmp_buf_bpp >
> +		    data_phy_cycles * dsi->lanes + 18) {
> +			horizontal_frontporch_byte = vm->hfront_porch *
> +						     dsi_tmp_buf_bpp -
> +						     data_phy_cycles *
> +						     dsi->lanes - 18;
> +		} else {
> +			DRM_WARN("HFP less than d-phy, FPS will under 60Hz\n");
> +			horizontal_frontporch_byte = vm->hfront_porch *
> +						     dsi_tmp_buf_bpp;
> +		}
> +	} else {
> +		if (vm->hfront_porch * dsi_tmp_buf_bpp >
> +		    data_phy_cycles * dsi->lanes + 12) {
> +			horizontal_frontporch_byte = vm->hfront_porch *
> +						     dsi_tmp_buf_bpp -
> +						     data_phy_cycles *
> +						     dsi->lanes - 12;
> +		} else {
> +			DRM_WARN("HFP less than d-phy, FPS will under 60Hz\n");
> +			horizontal_frontporch_byte = vm->hfront_porch *
> +						     dsi_tmp_buf_bpp;
> +		}
> +	}
>  
>  	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>  	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
> @@ -545,8 +606,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  {
>  	struct device *dev = dsi->->host.dev;
>  	int ret;
> -	u64 pixel_clock, total_bits;
> -	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
> +	u32 bit_per_pixel;
>  
>  	if (++dsi->refcount != 1)
>  		return 0;
> @@ -565,24 +625,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  		break;
>  	}
>  
> -	/**
> -	 * htotal_time = htotal * byte_per_pixel / num_lanes
> -	 * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
> -	 * mipi_ratio = (htotal_time + overhead_time) / htotal_time
> -	 * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
> -	 */
> -	pixel_clock = dsi->vm.pixelclock;
> -	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
> -			dsi->vm.hsync_len;
> -	htotal_bits = htotal * bit_per_pixel;
> -
> -	overhead_cycles = T_LPX + T_HS_PREP + T_HS_ZERO + T_HS_TRAIL +
> -			T_HS_EXIT;
> -	overhead_bits = overhead_cycles * dsi->lanes * 8;
> -	total_bits = htotal_bits + overhead_bits;
> -
> -	dsi->data_rate = DIV_ROUND_UP_ULL(pixel_clock * total_bits,
> -					  htotal * dsi->lanes);
> +	dsi->data_rate = DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_pixel, dsi->lanes);
>  
>  	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
>  	if (ret < 0) {


