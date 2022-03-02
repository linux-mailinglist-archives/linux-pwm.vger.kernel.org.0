Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311F4C9D66
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Mar 2022 06:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiCBFdA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Mar 2022 00:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbiCBFc4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2022 00:32:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62DB1538;
        Tue,  1 Mar 2022 21:32:12 -0800 (PST)
X-UUID: ad7a7b86cc1d4c2da224f08beceac12e-20220302
X-UUID: ad7a7b86cc1d4c2da224f08beceac12e-20220302
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 567894442; Wed, 02 Mar 2022 13:32:08 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Mar 2022 13:32:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Mar
 2022 13:32:06 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 2 Mar 2022 13:32:05 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, <allen-kh.cheng@mediatek.com>,
        <rex-bc.chen@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v3,6/6] dt-bindings: pwm: Add compatible for MediaTek MT8186
Date:   Wed, 2 Mar 2022 13:31:46 +0800
Message-ID: <1646199106-26879-7-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Add dt-binding documentation of pwm for MediaTek MT8186 SoC.

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index 3a5d1cfed94d..053805846cfe 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -21,6 +21,9 @@ properties:
           - mediatek,mt6595-disp-pwm
           - mediatek,mt8173-disp-pwm
           - mediatek,mt8183-disp-pwm
+      - items:
+          - const: mediatek,mt8186-disp-pwm
+          - const: mediatek,mt8183-disp-pwm
       - items:
           - const: mediatek,mt8192-disp-pwm
           - const: mediatek,mt8183-disp-pwm
-- 
2.18.0

