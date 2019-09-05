Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD6A987A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2019 04:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfIEClu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Sep 2019 22:41:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36641 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730451AbfIEClu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Sep 2019 22:41:50 -0400
X-UUID: ee9c975d9c9f4a36948ac9b4ed035b23-20190905
X-UUID: ee9c975d9c9f4a36948ac9b4ed035b23-20190905
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 291277882; Thu, 05 Sep 2019 10:41:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 10:41:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 10:41:37 +0800
Message-ID: <1567651299.13330.4.camel@mtksdaap41>
Subject: Re: [PATCH v6 0/7] Support dsi for mt8183
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
Date:   Thu, 5 Sep 2019 10:41:39 +0800
In-Reply-To: <20190811104008.53372-1-jitao.shi@mediatek.com>
References: <20190811104008.53372-1-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24890.000
X-TM-AS-Result: No-10.241600-8.000000-10
X-TMASE-MatchedRID: 6otD/cJAac2EFkjzuXHNt+LdprnA5EQRJih/yo+OvlVSAxvL+nqAnW4+
        gA+i9D2DqMlm1+4tGhQfHS8wUUuW9T4Pcn5OGAtGMpVOsYwN78M0YG6kQ2QiFFSOymiJfTYXrr5
        TE4GLzk06n5U+9hWy0GYwRleGHW3t0/GyN5MpGlOqNnzrkU+2mgKflB9+9kWVcJHSK1bfF9XGcw
        gtERMbmd99l6mYw28dfPU3ZRMebCuKiQbKW6KJeAlpVkdtt3WuOHhqIXe4IzZIyDY579vwTFYvW
        mlP6FyeEu6Hmd7GM5PTDbyTDLiYnVGEd5OSBmbmngIgpj8eDcC063Wh9WVqgmWCfbzydb0g2EuZ
        q9zngaeNo+PRbWqfRDsAVzN+Ov/sXEXPO/6fybNBoFITciebPaiz/Co2CGruef8GeKgmo5snmxJ
        8YZpSdw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.241600-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24890.000
X-TM-SNTS-SMTP: 75FAA2A7B910283301DE15DCDB5DB7A8A744F4C0B4B7E434DF4A678FAB936AED2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

For this series, applied to mediatek-drm-next-5.5 [1], and I break
"[v6,2/7] drm/mediatek: fixes CMDQ reg address of mt8173 is different
with mt2701" into two patches, thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK


On Sun, 2019-08-11 at 18:40 +0800, Jitao Shi wrote:
> Change since v5:
>  - fine tune dphy timing.
> 
> Change since v4:
>  - move mipi_dsi_host_unregiter() to .remove()
>  - fine tune add frame size control coding style
>  - change the data type of data_rate as u32, and add DIV_ROUND_UP_ULL
>  - use div_u64 when 8000000000ULL / dsi->data_rate.
> 
> Changes since v3
>  - add one more 'tab' for bitwise define.
>  - add Tested-by: Ryan Case <ryandcase@chromium.org>
> 	and Reviewed-by: CK Hu <ck.hu@mediatek.com>.
>  - remove compare da_hs_zero to da_hs_prepare.
> 
> Changes since v2:
>  - change the video timing calc method
>  - fine the dsi and mipitx init sequence
>  - fine tune commit msg
> 
> Changes since v1:
>  - separate frame size and reg commit control independent patches.
>  - fix some return values in probe
>  - remove DSI_CMDW0 in "CMDQ reg address of mt8173 is different with mt2701" 
> 
> Jitao Shi (7):
>   drm/mediatek: move mipi_dsi_host_register to probe
>   drm/mediatek: fixes CMDQ reg address of mt8173 is different with
>     mt2701
>   drm/mediatek: add dsi reg commit disable control
>   drm/mediatek: add frame size control
>   drm/mediatek: add mt8183 dsi driver support
>   drm/mediatek: change the dsi phytiming calculate method
>   drm: mediatek: adjust dsi and mipi_tx probe sequence
> 
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 224 ++++++++++++++++++-------
>  2 files changed, 161 insertions(+), 65 deletions(-)
> 


