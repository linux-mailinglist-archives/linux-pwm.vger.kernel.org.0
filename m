Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BDA986A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2019 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfIECic (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Sep 2019 22:38:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39694 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728008AbfIECic (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Sep 2019 22:38:32 -0400
X-UUID: 85662b706e4842e9829949980f2aa41f-20190905
X-UUID: 85662b706e4842e9829949980f2aa41f-20190905
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1277019290; Thu, 05 Sep 2019 10:38:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 10:38:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 10:38:19 +0800
Message-ID: <1567651100.13330.1.camel@mtksdaap41>
Subject: Re: [PATCH v6 0/3] Support mipitx for mt8183
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
Date:   Thu, 5 Sep 2019 10:38:20 +0800
In-Reply-To: <20190807084645.63738-1-jitao.shi@mediatek.com>
References: <20190807084645.63738-1-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 6FC0B6C8ACCBF84F2E1844C1B7B45B0403D54D0812C4D28F17CDBF053DE0F48D2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

For this series, applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

On Wed, 2019-08-07 at 16:46 +0800, Jitao Shi wrote:
> Change since v5:
>  - remove mipi_tx->ref_clk
>  - remove mt8183 pll prepare unprepare
> 
> Change since v4:
>  - fine tune the mipi_tx->ref_clk and mipi_tx->pll sequence
>    1. Prepare mipi_tx->ref_clk
>    2. Prepare mipi_tx->pll
>    3. Enable mipi_tx->ref_clk
>    4. Enable mipi_tx->pll
> 
> Changes since v3:
>  - turn off PLL before setting PLL parameters.
> 
> Changes since v2:
>  - update Acked-by: Rob Herring <robh@kernel.org>
>  - update mt8183 max bit rate support
> 
> Changes since v1:
>  - update dt-bindings document for mt8183 mipitx.
>  - remove mtk_mipitx_clk_get_ops and assign clk_ops in probe.
>  - fix the lincence
>  - remove txdiv1 from mtk_mipi_tx_pll_prepare
> 
> Jitao Shi (3):
>   dt-bindings: display: mediatek: update dsi supported chips
>   drm/mediatek: separate mipi_tx to different file
>   drm/mediatek: add mipi_tx driver for mt8183
> 
>  .../display/mediatek/mediatek,dsi.txt         |   4 +-
>  drivers/gpu/drm/mediatek/Makefile             |   2 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 338 ++----------------
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  49 +++
>  drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 289 +++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 150 ++++++++
>  6 files changed, 515 insertions(+), 317 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> 


