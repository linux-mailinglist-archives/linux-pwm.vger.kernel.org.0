Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47431B22
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2019 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfFAJwu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Jun 2019 05:52:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:60855 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfFAJwu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Jun 2019 05:52:50 -0400
X-UUID: 8202367f81544584ba94eed0d7c71e82-20190601
X-UUID: 8202367f81544584ba94eed0d7c71e82-20190601
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1421988198; Sat, 01 Jun 2019 17:52:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 1 Jun
 2019 17:52:40 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 1 Jun 2019 17:52:39 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
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
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [v4 1/3] dt-bindings: display: mediatek: update dsi supported chips
Date:   Sat, 1 Jun 2019 17:52:33 +0800
Message-ID: <20190601095235.9194-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20190601095235.9194-1-jitao.shi@mediatek.com>
References: <20190601095235.9194-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update device tree binding documentation for the dsi for
Mediatek MT8183 SoCs.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
index fadf327c7cdf..bb3dcd2d8571 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
@@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PHY.
 
 Required properties:
 - compatible: "mediatek,<chip>-mipi-tx"
-  the supported chips are mt2701 and mt8173.
+  the supported chips are mt2701, mt8173 and mt8183.
 - reg: Physical base address and length of the controller's registers
 - clocks: PLL reference clock
 - clock-output-names: name of the output clock line to the DSI encoder
-- 
2.12.5

