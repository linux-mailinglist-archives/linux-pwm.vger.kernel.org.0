Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2C16F53
	for <lists+linux-pwm@lfdr.de>; Wed,  8 May 2019 04:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfEHC4y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 May 2019 22:56:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16116 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbfEHC4y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 May 2019 22:56:54 -0400
X-UUID: 32694377cbc74a0cb64b2150d0736679-20190508
X-UUID: 32694377cbc74a0cb64b2150d0736679-20190508
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1513612528; Wed, 08 May 2019 10:56:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 May 2019 10:56:40 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 May 2019 10:56:40 +0800
Message-ID: <1557284200.31731.8.camel@mtksdaap41>
Subject: Re: [v2 3/5] drm/mediatek: add dsi reg commit control
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
Date:   Wed, 8 May 2019 10:56:40 +0800
In-Reply-To: <20190416060501.76276-4-jitao.shi@mediatek.com>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
         <20190416060501.76276-4-jitao.shi@mediatek.com>
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

On Tue, 2019-04-16 at 14:04 +0800, Jitao Shi wrote:
> New DSI IP has shadow register and working reg. The register
> values are writen to shadow register. And then trigger with
> commit reg, the register values will be moved working register.

This patch looks good, but the message is not complete. The message make
us believe you use shadow register to work, but actually, shadow
register is default turn on in new DSI IP and you want to turn off it.

Regards,
CK

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 573e6bec6d36..be42405a0a78 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -131,6 +131,10 @@
>  #define VM_CMD_EN			BIT(0)
>  #define TS_VFP_EN			BIT(5)
>  
> +#define DSI_SHADOW_DEBUG	0x190U
> +#define FORCE_COMMIT		BIT(0)
> +#define BYPASS_SHADOW		BIT(1)
> +
>  #define CONFIG				(0xff << 0)
>  #define SHORT_PACKET			0
>  #define LONG_PACKET			2
> @@ -157,6 +161,7 @@ struct phy;
>  
>  struct mtk_dsi_driver_data {
>  	const u32 reg_cmdq_off;
> +	bool has_shadow_ctl;
>  };
>  
>  struct mtk_dsi {
> @@ -594,6 +599,11 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	}
>  
>  	mtk_dsi_enable(dsi);
> +
> +	if (dsi->driver_data->has_shadow_ctl)
> +		writel(FORCE_COMMIT | BYPASS_SHADOW,
> +		       dsi->regs + DSI_SHADOW_DEBUG);
> +
>  	mtk_dsi_reset_engine(dsi);
>  	mtk_dsi_phy_timconfig(dsi);
>  


