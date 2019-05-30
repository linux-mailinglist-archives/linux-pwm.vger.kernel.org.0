Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A113030378
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2019 22:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE3Upf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 16:45:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40567 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfE3Upf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 16:45:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so6625413qtn.7
        for <linux-pwm@vger.kernel.org>; Thu, 30 May 2019 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWieCtH2yIUBG5LWs9OEX59nD7DlvSQy6nQ6THrqLpQ=;
        b=MVfYyapCMJ3LatqnyKDs+2vpLg9MtdQ6eIUIapTUApTID2TcLQ0zGLd1PRJdlGCyX1
         bNDECPJiTcFJ6RgaNyW5qC1fFq+gd310kusmYNxUucmmRT1PxF0j1vQLmo33XvWLYl9/
         k21lyFySdRC9fu5ciEyARhp5fKwuXC0/YaC/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWieCtH2yIUBG5LWs9OEX59nD7DlvSQy6nQ6THrqLpQ=;
        b=uGSwhUE6uPZ0WpLg/wD3NJRoFHBVCkcEjhb7JOBd2nhvOPCwykCuZcSPCNFg4sm1A2
         qTkCdetpJ5PjU4MQeF3MCpAPYug1f2R0Y6LGsda76uej+qgWzoiJAJPXP9IFeCoyCvu9
         eQg89wFslpbhh/OWiCTKd9Cybl4xtTijOAdMrq8wpt/0ntjwqGNRQuakvewDR9l+VbUD
         5B/RtLPbzGa0U5mKaWeFGBY1HihUXGBBGHmZVfDz0i+A7a6fTPh9GS443eWTYlhdtvEA
         LQ5yVL80cv9Z1t/WwaZn4ZnxvbZI5VkZ6PUczjqboNKII09qrjc8vtofI3rCgT7N1+uO
         8yFg==
X-Gm-Message-State: APjAAAXAt+KWb+0sePF+SR6v3KHfdSP6G+hR94kN32SzAqqEMLzzJp+J
        X3pZoV4+nQHx3QquJQbO3pyZdwKyLxLCMEFjOo1Ldg==
X-Google-Smtp-Source: APXvYqwNLwP00A8U2czycL+eEwL5OUMXo5jNJuA8YWPXcRQvTPdJRTYAmeu3ErcrzQbw0KQSEmCrt5YH4A64vrPlTC8=
X-Received: by 2002:ac8:2fce:: with SMTP id m14mr5717317qta.22.1559249133671;
 Thu, 30 May 2019 13:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190519092537.69053-1-jitao.shi@mediatek.com> <20190519092537.69053-7-jitao.shi@mediatek.com>
In-Reply-To: <20190519092537.69053-7-jitao.shi@mediatek.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Thu, 30 May 2019 13:45:23 -0700
Message-ID: <CACjz--m7X13XShZ4ST+54jF_K6=Cfzj1DNBduyVdVsVd2dpULw@mail.gmail.com>
Subject: Re: [v3 6/7] drm/mediatek: change the dsi phytiming calculate method
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jitao,

On Sun, May 19, 2019 at 2:27 AM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Change the method of frame rate calc which can get more accurate
> frame rate.
>
> data rate = pixel_clock * bit_per_pixel / lanes
> Adjust hfp_wc to adapt the additional phy_data
>
> if MIPI_DSI_MODE_VIDEO_BURST
>         hfp_wc = hfp * bpp - data_phy_cycles * lanes - 12 - 6;
> else
>         hfp_wc = hfp * bpp - data_phy_cycles * lanes - 12;
>
> Note:
> //(2: 1 for sync, 1 for phy idle)
> data_phy_cycles = T_hs_exit + T_lpx + T_hs_prepare + T_hs_zero + 2;
>
> bpp: bit per pixel
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 119 +++++++++++++++++++++--------
>  1 file changed, 86 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 1165ff944889..3f51b2000c68 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -158,6 +158,25 @@
>         (type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
>         (type == MIPI_DSI_DCS_READ))
>
> +struct mtk_phy_timing {
> +       u32 lpx;
> +       u32 da_hs_prepare;
> +       u32 da_hs_zero;
> +       u32 da_hs_trail;
> +
> +       u32 ta_go;
> +       u32 ta_sure;
> +       u32 ta_get;
> +       u32 da_hs_exit;
> +
> +       u32 clk_hs_zero;
> +       u32 clk_hs_trail;
> +
> +       u32 clk_hs_prepare;
> +       u32 clk_hs_post;
> +       u32 clk_hs_exit;
> +};
> +
>  struct phy;
>
>  struct mtk_dsi_driver_data {
> @@ -182,12 +201,13 @@ struct mtk_dsi {
>         struct clk *digital_clk;
>         struct clk *hs_clk;
>
> -       u32 data_rate;
> +       u64 data_rate;
>
>         unsigned long mode_flags;
>         enum mipi_dsi_pixel_format format;
>         unsigned int lanes;
>         struct videomode vm;
> +       struct mtk_phy_timing phy_timing;
>         int refcount;
>         bool enabled;
>         u32 irq_data;
> @@ -221,17 +241,39 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
>  {
>         u32 timcon0, timcon1, timcon2, timcon3;
>         u32 ui, cycle_time;
> +       struct mtk_phy_timing *timing = &dsi->phy_timing;
> +
> +       ui = 1000000000 / dsi->data_rate;
> +       cycle_time = 8000000000 / dsi->data_rate;
> +
> +       timing->lpx = NS_TO_CYCLE(60, cycle_time);
> +       timing->da_hs_prepare = NS_TO_CYCLE((40 + 5 * ui), cycle_time);
> +       timing->da_hs_zero = NS_TO_CYCLE((110 + 6 * ui), cycle_time);
> +       timing->da_hs_trail = NS_TO_CYCLE(((0x4 * ui) + 80), cycle_time);
> +
> +       if (timing->da_hs_zero > timing->da_hs_prepare)
> +               timing->da_hs_zero -= timing->da_hs_prepare;

I don't follow why the above comparison and subtraction is necessary
when the values are being explicitly set immediately prior and it
seems to introduce a bug. Leftover from an early revision?

It looks like you've tuned the values such that hs_prepare+hs_zero are
just above the minimum requirements for that sum, however due to this
comparison and subtraction we wind up with a value of
hs_prepare+hs_zero-hs_prepare and fall below spec. Either boosting the
initial value set for hs_zero or removing the comparison makes display
happy again. Since I don't see any reason for the compare and subtract
I'd just drop that.

> +
> +       timing->ta_go = 4 * timing->lpx;
> +       timing->ta_sure = 3 * timing->lpx / 2;
> +       timing->ta_get = 5 * timing->lpx;
> +       timing->da_hs_exit = 2 * timing->lpx;
> +
> +       timing->clk_hs_zero = NS_TO_CYCLE(0x150, cycle_time);
> +       timing->clk_hs_trail = NS_TO_CYCLE(0x64, cycle_time) + 0xa;
>
> -       ui = 1000 / dsi->data_rate + 0x01;
> -       cycle_time = 8000 / dsi->data_rate + 0x01;
> +       timing->clk_hs_prepare = NS_TO_CYCLE(0x40, cycle_time);
> +       timing->clk_hs_post = NS_TO_CYCLE(80 + 52 * ui, cycle_time);
> +       timing->clk_hs_exit = 2 * timing->lpx;

There is a lot of alternating between hex and decimal values in this
function which makes it a little hard to follow. Would be nice to
stick to one or the other.

>
> -       timcon0 = T_LPX | T_HS_PREP << 8 | T_HS_ZERO << 16 | T_HS_TRAIL << 24;
> -       timcon1 = 4 * T_LPX | (3 * T_LPX / 2) << 8 | 5 * T_LPX << 16 |
> -                 T_HS_EXIT << 24;
> -       timcon2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
> -                 (NS_TO_CYCLE(0x150, cycle_time) << 16);
> -       timcon3 = NS_TO_CYCLE(0x40, cycle_time) | (2 * T_LPX) << 16 |
> -                 NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8;
> +       timcon0 = timing->lpx | timing->da_hs_prepare << 8 |
> +                 timing->da_hs_zero << 16 | timing->da_hs_trail << 24;
> +       timcon1 = timing->ta_go | timing->ta_sure << 8 |
> +                 timing->ta_get << 16 | timing->da_hs_exit << 24;
> +       timcon2 = 1 << 8 | timing->clk_hs_zero << 16 |
> +                 timing->clk_hs_trail << 24;
> +       timcon3 = timing->clk_hs_prepare | timing->clk_hs_post << 8 |
> +                 timing->clk_hs_exit << 16;
>
>         writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
>         writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
> @@ -418,7 +460,8 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>         u32 horizontal_sync_active_byte;
>         u32 horizontal_backporch_byte;
>         u32 horizontal_frontporch_byte;
> -       u32 dsi_tmp_buf_bpp;
> +       u32 dsi_tmp_buf_bpp, data_phy_cycles;
> +       struct mtk_phy_timing *timing = &dsi->phy_timing;
>
>         struct videomode *vm = &dsi->vm;
>
> @@ -433,7 +476,8 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>         writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>
>         if (dsi->driver_data->has_size_ctl)
> -               writel(vm->vactive << 16 | vm->hactive, dsi->regs + DSI_SIZE_CON);
> +               writel(vm->vactive << 16 | vm->hactive,
> +                      dsi->regs + DSI_SIZE_CON);
>
>         horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
>
> @@ -444,7 +488,34 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>                 horizontal_backporch_byte = ((vm->hback_porch + vm->hsync_len) *
>                         dsi_tmp_buf_bpp - 10);
>
> -       horizontal_frontporch_byte = (vm->hfront_porch * dsi_tmp_buf_bpp - 12);
> +       data_phy_cycles = timing->lpx + timing->da_hs_prepare +
> +                                 timing->da_hs_zero + timing->da_hs_exit + 2;
> +
> +       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +               if (vm->hfront_porch * dsi_tmp_buf_bpp >
> +                   data_phy_cycles * dsi->lanes + 18) {
> +                       horizontal_frontporch_byte = vm->hfront_porch *
> +                                                    dsi_tmp_buf_bpp -
> +                                                    data_phy_cycles *
> +                                                    dsi->lanes - 18;
> +               } else {
> +                       DRM_WARN("HFP less than d-phy, FPS will under 60Hz\n");
> +                       horizontal_frontporch_byte = vm->hfront_porch *
> +                                                    dsi_tmp_buf_bpp;
> +               }
> +       } else {
> +               if (vm->hfront_porch * dsi_tmp_buf_bpp >
> +                   data_phy_cycles * dsi->lanes + 12) {
> +                       horizontal_frontporch_byte = vm->hfront_porch *
> +                                                    dsi_tmp_buf_bpp -
> +                                                    data_phy_cycles *
> +                                                    dsi->lanes - 12;
> +               } else {
> +                       DRM_WARN("HFP less than d-phy, FPS will under 60Hz\n");
> +                       horizontal_frontporch_byte = vm->hfront_porch *
> +                                                    dsi_tmp_buf_bpp;
> +               }
> +       }
>
>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>         writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
> @@ -544,8 +615,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  {
>         struct device *dev = dsi->dev;
>         int ret;
> -       u64 pixel_clock, total_bits;
> -       u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
> +       u32 bit_per_pixel;
>
>         if (++dsi->refcount != 1)
>                 return 0;
> @@ -564,24 +634,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>                 break;
>         }
>
> -       /**
> -        * htotal_time = htotal * byte_per_pixel / num_lanes
> -        * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
> -        * mipi_ratio = (htotal_time + overhead_time) / htotal_time
> -        * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
> -        */
> -       pixel_clock = dsi->vm.pixelclock;
> -       htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
> -                       dsi->vm.hsync_len;
> -       htotal_bits = htotal * bit_per_pixel;
> -
> -       overhead_cycles = T_LPX + T_HS_PREP + T_HS_ZERO + T_HS_TRAIL +
> -                       T_HS_EXIT;
> -       overhead_bits = overhead_cycles * dsi->lanes * 8;
> -       total_bits = htotal_bits + overhead_bits;
> -
> -       dsi->data_rate = DIV_ROUND_UP_ULL(pixel_clock * total_bits,
> -                                         htotal * dsi->lanes);
> +       dsi->data_rate = dsi->vm.pixelclock * bit_per_pixel / dsi->lanes;
>
>         ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
>         if (ret < 0) {


With the earlier fix feel free to add to the next revision
Tested-by: Ryan Case <ryandcase@chromium.org>
