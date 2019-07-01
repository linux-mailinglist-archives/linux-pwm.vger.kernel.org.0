Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50045B2BA
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2019 03:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGAB3u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Jun 2019 21:29:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:57351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727159AbfGAB3t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Jun 2019 21:29:49 -0400
X-UUID: d29bdff237594c7c81a1686025d435ae-20190701
X-UUID: d29bdff237594c7c81a1686025d435ae-20190701
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 872957804; Mon, 01 Jul 2019 09:29:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Jul 2019 09:29:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Jul 2019 09:29:23 +0800
Message-ID: <1561944562.17120.1.camel@mtksdaap41>
Subject: Re: [v5 4/7] drm/mediatek: add frame size control
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
Date:   Mon, 1 Jul 2019 09:29:22 +0800
In-Reply-To: <20190627080116.40264-5-jitao.shi@mediatek.com>
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
         <20190627080116.40264-5-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24732.000
X-TM-AS-Result: No-12.337600-8.000000-10
X-TMASE-MatchedRID: zGP2F0O7j/vmLzc6AOD8DfHkpkyUphL9xXRDKEyu2zF+SLLtNOiBhmmd
        1p2wVSdNRw3fpQHgw3t0pmQclXiHl4UJf3YQjB6CiJwEp8weVXwxXH/dlhvLv2q646qiEnRz7yL
        x17DX9aet2gtuWr1Lmt52diAVzqN2Z/mERv8EXlX754IB1tyKcqg3Fm19nZrJ0u/U/L+rNlES99
        dUV0LYkjvFiNq8G3M5EiVVgKqFXk5Nfs8n85Te8oMbH85DUZXyseWplitmp0j6C0ePs7A07RRAJ
        C2k3BZ6qjisAJ9xR93/FHz8N5NA/ciiN6rHv+xKGCY6L4Z1ACk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.337600-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24732.000
X-TM-SNTS-SMTP: A90BCEAADDCB8D640566EAD2CCD718AC8B8A63ED6C117C0EF66499DE0C7667252000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Thu, 2019-06-27 at 16:01 +0800, Jitao Shi wrote:
> Our new DSI chip has frame size control.
> So add the driver data to control for different chips.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

This version is different than previous version, so you should remove
the reviewed-by tag. For this version, I still give you a

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 6b6550926db6..45e331055842 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -78,6 +78,7 @@
>  #define DSI_VBP_NL		0x24
>  #define DSI_VFP_NL		0x28
>  #define DSI_VACT_NL		0x2C
> +#define DSI_SIZE_CON		0x38
>  #define DSI_HSA_WC		0x50
>  #define DSI_HBP_WC		0x54
>  #define DSI_HFP_WC		0x58
> @@ -162,6 +163,7 @@ struct phy;
>  struct mtk_dsi_driver_data {
>  	const u32 reg_cmdq_off;
>  	bool has_shadow_ctl;
> +	bool has_size_ctl;
>  };
>  
>  struct mtk_dsi {
> @@ -430,6 +432,10 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>  	writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
>  	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>  
> +	if (dsi->driver_data->has_size_ctl)
> +		writel(vm->vactive << 16 | vm->hactive,
> +		       dsi->regs + DSI_SIZE_CON);
> +
>  	horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
>  
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)


