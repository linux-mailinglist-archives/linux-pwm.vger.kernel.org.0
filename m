Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9457F3C142
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbfFKChR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Jun 2019 22:37:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:53189 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390280AbfFKChR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Jun 2019 22:37:17 -0400
X-UUID: 2c1d25838fb1433284a40b1bbfb111c5-20190611
X-UUID: 2c1d25838fb1433284a40b1bbfb111c5-20190611
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 141375310; Tue, 11 Jun 2019 10:37:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Jun 2019 10:37:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Jun 2019 10:37:07 +0800
Message-ID: <1560220627.32395.1.camel@mtksdaap41>
Subject: Re: [v4 5/7] drm/mediatek: add mt8183 dsi driver support
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
Date:   Tue, 11 Jun 2019 10:37:07 +0800
In-Reply-To: <20190601092615.67917-6-jitao.shi@mediatek.com>
References: <20190601092615.67917-1-jitao.shi@mediatek.com>
         <20190601092615.67917-6-jitao.shi@mediatek.com>
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

On Sat, 2019-06-01 at 17:26 +0800, Jitao Shi wrote:
> Add mt8183 dsi driver data. Enable size control and
> reg commit control.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 18a192656a89..abf6ddec5db6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1225,11 +1225,19 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
>  	.reg_cmdq_off = 0x180,
>  };
>  
> +static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
> +	.reg_cmdq_off = 0x200,
> +	.has_shadow_ctl = true,
> +	.has_size_ctl = true,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-dsi",
>  	  .data = &mt2701_dsi_driver_data },
>  	{ .compatible = "mediatek,mt8173-dsi",
>  	  .data = &mt8173_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8183-dsi",

I does not find "mediatek,mt8183-dsi" in binding document, so please
send a patch to add this in binding document.

Regards,
CK

> +	  .data = &mt8183_dsi_driver_data },
>  	{ },
>  };
>  


