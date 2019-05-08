Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87E516F5D
	for <lists+linux-pwm@lfdr.de>; Wed,  8 May 2019 05:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEHDAl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 May 2019 23:00:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbfEHDAl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 May 2019 23:00:41 -0400
X-UUID: 935e948acb024d52844b01742ed699d9-20190508
X-UUID: 935e948acb024d52844b01742ed699d9-20190508
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 669847177; Wed, 08 May 2019 11:00:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 May 2019 11:00:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 May 2019 11:00:34 +0800
Message-ID: <1557284434.31731.10.camel@mtksdaap41>
Subject: Re: [v2 5/5] drm/mediatek: add mt8183 dsi driver support
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
Date:   Wed, 8 May 2019 11:00:34 +0800
In-Reply-To: <20190416060501.76276-6-jitao.shi@mediatek.com>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
         <20190416060501.76276-6-jitao.shi@mediatek.com>
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

On Tue, 2019-04-16 at 14:05 +0800, Jitao Shi wrote:
> Add mt8183 dsi driver data. Enable size control and
> reg commit control.
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 458a700ce74c..f0b36ec38e4f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1104,11 +1104,19 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
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
> +	  .data = &mt8183_dsi_driver_data },
>  	{ },
>  };
>  


