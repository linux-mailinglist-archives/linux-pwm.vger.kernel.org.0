Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF34C9D5B
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Mar 2022 06:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiCBFct (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Mar 2022 00:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbiCBFcs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2022 00:32:48 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDC513F22;
        Tue,  1 Mar 2022 21:32:01 -0800 (PST)
X-UUID: 3b06e1d4dd644a80a922b3b25913bf20-20220302
X-UUID: 3b06e1d4dd644a80a922b3b25913bf20-20220302
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1003730640; Wed, 02 Mar 2022 13:31:56 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 2 Mar 2022 13:31:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Mar
 2022 13:31:50 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 2 Mar 2022 13:31:49 +0800
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
Subject: [PATCH v3,0/6] Convert pwm-mtk-disp.txt to
Date:   Wed, 2 Mar 2022 13:31:40 +0800
Message-ID: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Changes since v2:
1. Modify the PWM name to DISP_PWM.
2. Include pwm.yaml.
3. Separate conversion files and add/remove operations.

Changes since v1:
1. Fixed formatting issues mentioned in the v1.
2. Delete pwm-mtk-disp.txt.
3. Add mtk_pwm dt_maintainers.
4. Add "#pwm-cells" & power-domains properties.
5. Make dt_checking successful.

Xinlei Lee (6):
  dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
    format
  dt-bindings: pwm: Remove compatible for MediaTek MT8167
  dt-bindings: pwm: Add compatible for MediaTek MT8183
  dt-bindings: pwm: Add compatible for MediaTek MT8192
  dt-bindings: pwm: Add compatible for MediaTek MT8195
  dt-bindings: pwm: Add compatible for MediaTek MT8186

 .../bindings/pwm/mediatek,pwm-disp.yaml       | 72 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ------------
 2 files changed, 72 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

-- 
2.18.0

