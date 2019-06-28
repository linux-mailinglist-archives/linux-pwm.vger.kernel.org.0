Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4959420
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2019 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfF1GU4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jun 2019 02:20:56 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19295 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726553AbfF1GU4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jun 2019 02:20:56 -0400
X-UUID: 13fb9bf17b8f491988d8b93c1557e9ee-20190628
X-UUID: 13fb9bf17b8f491988d8b93c1557e9ee-20190628
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 478309057; Fri, 28 Jun 2019 14:20:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Jun 2019 14:20:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 14:20:38 +0800
Message-ID: <1561702838.18399.10.camel@mtksdaap41>
Subject: Re: [v5 1/3] dt-bindings: display: mediatek: update dsi supported
 chips
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>, Rob Herring <robh@kernel.org>
CC:     arPawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Vincent Palatin" <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
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
        <stonea168@163.com>, "Rob Herring" <robh@kernel.org>
Date:   Fri, 28 Jun 2019 14:20:38 +0800
In-Reply-To: <20190627025901.28418-2-jitao.shi@mediatek.com>
References: <20190627025901.28418-1-jitao.shi@mediatek.com>
         <20190627025901.28418-2-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: F5593DFD1B0197145068EEEC130C459B1EEAED2C72C02013EB643222CBB8C0B72000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Jitao:

On Thu, 2019-06-27 at 10:58 +0800, Jitao Shi wrote:
> Update device tree binding documentation for the dsi for
> Mediatek MT8183 SoCs.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

This version is different than previous version, so I think you should
remove the Acked-by tag. Or Rob could give a tag again on this patch.

Regards,
CK

> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> index fadf327c7cdf..a19a6cc375ed 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -7,7 +7,7 @@ channel output.
>  
>  Required properties:
>  - compatible: "mediatek,<chip>-dsi"
> -  the supported chips are mt2701 and mt8173.
> +  the supported chips are mt2701, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> @@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PHY.
>  
>  Required properties:
>  - compatible: "mediatek,<chip>-mipi-tx"
> -  the supported chips are mt2701 and mt8173.
> +  the supported chips are mt2701, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - clocks: PLL reference clock
>  - clock-output-names: name of the output clock line to the DSI encoder


