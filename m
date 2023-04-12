Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38626DF388
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjDLL27 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 07:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjDLL2a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 07:28:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EF7D9C;
        Wed, 12 Apr 2023 04:28:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F5AD66032C5;
        Wed, 12 Apr 2023 12:28:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298886;
        bh=BBxCdX7JRgbzd6szv2aaZHGd/h+zBG+alQaNlQmwKU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0U76jnxrbd9Zqzfdi/hHcMIIOOrtgeOX05hBmd+zqg0Q91aaIGFE08/p38/lGzvy
         MsuKE501VB243hN6L23R6La8HMzbbbUDPrSAhVsXKUX6xDeNOYSLjElseURvBFlYT/
         rzW3WCrHPkKc/M+3bB2i8Nkyd1wK+iJ9JLdUszrA5ICmmfSWADPwjbgOpjqHeXEvc7
         nxBTieSEO9BxQ5XQy9cDV6CTBxTHrkNcnyAtoqJXah6wy/561j8cWFPd0/B7djUgVc
         TIwH+pTcUoag0ZmLcVRhcC+ZnIqyK0QO6rg7EJOpBTQO6HGyVcMy7HjLKZ5V5Sslfs
         VDljdiOarX4Ag==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 15/27] dt-bindings: mailbox: mediatek,gce-mailbox: Add support for MT6795
Date:   Wed, 12 Apr 2023 13:27:27 +0200
Message-Id: <20230412112739.160376-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a compatible string for the MT6795 Helio X10 SoC using MT8173
binding and add a header for the MT6795's GCE mailbox.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../mailbox/mediatek,gce-mailbox.yaml         |  20 +--
 include/dt-bindings/gce/mediatek,mt6795-gce.h | 123 ++++++++++++++++++
 2 files changed, 135 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/gce/mediatek,mt6795-gce.h

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
index d383b2ab3ce8..cef9d7601398 100644
--- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
@@ -16,14 +16,18 @@ description:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt6779-gce
-      - mediatek,mt8173-gce
-      - mediatek,mt8183-gce
-      - mediatek,mt8186-gce
-      - mediatek,mt8188-gce
-      - mediatek,mt8192-gce
-      - mediatek,mt8195-gce
+    oneOf:
+      - enum:
+          - mediatek,mt6779-gce
+          - mediatek,mt8173-gce
+          - mediatek,mt8183-gce
+          - mediatek,mt8186-gce
+          - mediatek,mt8188-gce
+          - mediatek,mt8192-gce
+          - mediatek,mt8195-gce
+      - items:
+          - const: mediatek,mt6795-gce
+          - const: mediatek,mt8173-gce
 
   "#mbox-cells":
     const: 2
diff --git a/include/dt-bindings/gce/mediatek,mt6795-gce.h b/include/dt-bindings/gce/mediatek,mt6795-gce.h
new file mode 100644
index 000000000000..97d5ba2d2b44
--- /dev/null
+++ b/include/dt-bindings/gce/mediatek,mt6795-gce.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+#ifndef _DT_BINDINGS_GCE_MT6795_H
+#define _DT_BINDINGS_GCE_MT6795_H
+
+/* GCE HW thread priority */
+#define CMDQ_THR_PRIO_LOWEST			0
+#define CMDQ_THR_PRIO_NORMAL			1
+#define CMDQ_THR_PRIO_NORMAL_2			2
+#define CMDQ_THR_PRIO_MEDIUM			3
+#define CMDQ_THR_PRIO_MEDIUM_2			4
+#define CMDQ_THR_PRIO_HIGH			5
+#define CMDQ_THR_PRIO_HIGHER			6
+#define CMDQ_THR_PRIO_HIGHEST			7
+
+/* GCE SUBSYS */
+#define SUBSYS_1300XXXX				0
+#define SUBSYS_1400XXXX				1
+#define SUBSYS_1401XXXX				2
+#define SUBSYS_1402XXXX				3
+#define SUBSYS_1500XXXX				4
+#define SUBSYS_1600XXXX				5
+#define SUBSYS_1700XXXX				6
+#define SUBSYS_1800XXXX				7
+#define SUBSYS_1000XXXX				8
+#define SUBSYS_1001XXXX				9
+#define SUBSYS_1002XXXX				10
+#define SUBSYS_1003XXXX				11
+#define SUBSYS_1004XXXX				12
+#define SUBSYS_1005XXXX				13
+#define SUBSYS_1020XXXX				14
+#define SUBSYS_1021XXXX				15
+#define SUBSYS_1120XXXX				16
+#define SUBSYS_1121XXXX				17
+#define SUBSYS_1122XXXX				18
+#define SUBSYS_1123XXXX				19
+#define SUBSYS_1124XXXX				20
+#define SUBSYS_1125XXXX				21
+#define SUBSYS_1126XXXX				22
+
+/* GCE HW EVENT */
+#define CMDQ_EVENT_MDP_RDMA0_SOF		0
+#define CMDQ_EVENT_MDP_RDMA1_SOF		1
+#define CMDQ_EVENT_MDP_DSI0_TE_SOF		2
+#define CMDQ_EVENT_MDP_DSI1_TE_SOF		3
+#define CMDQ_EVENT_MDP_MVW_SOF			4
+#define CMDQ_EVENT_MDP_TDSHP0_SOF		5
+#define CMDQ_EVENT_MDP_TDSHP1_SOF		6
+#define CMDQ_EVENT_MDP_WDMA_SOF			7
+#define CMDQ_EVENT_MDP_WROT0_SOF		8
+#define CMDQ_EVENT_MDP_WROT1_SOF		9
+#define CMDQ_EVENT_MDP_CROP_SOF			10
+#define CMDQ_EVENT_DISP_OVL0_SOF		11
+#define CMDQ_EVENT_DISP_OVL1_SOF		12
+#define CMDQ_EVENT_DISP_RDMA0_SOF		13
+#define CMDQ_EVENT_DISP_RDMA1_SOF		14
+#define CMDQ_EVENT_DISP_RDMA2_SOF		15
+#define CMDQ_EVENT_DISP_WDMA0_SOF		16
+#define CMDQ_EVENT_DISP_WDMA1_SOF		17
+#define CMDQ_EVENT_DISP_COLOR0_SOF		18
+#define CMDQ_EVENT_DISP_COLOR1_SOF		19
+#define CMDQ_EVENT_DISP_AAL_SOF			20
+#define CMDQ_EVENT_DISP_GAMMA_SOF		21
+#define CMDQ_EVENT_DISP_UFOE_SOF		22
+#define CMDQ_EVENT_DISP_PWM0_SOF		23
+#define CMDQ_EVENT_DISP_PWM1_SOF		24
+#define CMDQ_EVENT_DISP_OD_SOF			25
+#define CMDQ_EVENT_MDP_RDMA0_EOF		26
+#define CMDQ_EVENT_MDP_RDMA1_EOF		27
+#define CMDQ_EVENT_MDP_RSZ0_EOF			28
+#define CMDQ_EVENT_MDP_RSZ1_EOF			29
+#define CMDQ_EVENT_MDP_RSZ2_EOF			30
+#define CMDQ_EVENT_MDP_TDSHP0_EOF		31
+#define CMDQ_EVENT_MDP_TDSHP1_EOF		32
+#define CMDQ_EVENT_MDP_WDMA_EOF			33
+#define CMDQ_EVENT_MDP_WROT0_WRITE_EOF		34
+#define CMDQ_EVENT_MDP_WROT0_READ_EOF		35
+#define CMDQ_EVENT_MDP_WROT1_WRITE_EOF		36
+#define CMDQ_EVENT_MDP_WROT1_READ_EOF		37
+#define CMDQ_EVENT_MDP_CROP_EOF			38
+#define CMDQ_EVENT_DISP_OVL0_EOF		39
+#define CMDQ_EVENT_DISP_OVL1_EOF		40
+#define CMDQ_EVENT_DISP_RDMA0_EOF		41
+#define CMDQ_EVENT_DISP_RDMA1_EOF		42
+#define CMDQ_EVENT_DISP_RDMA2_EOF		43
+#define CMDQ_EVENT_DISP_WDMA0_EOF		44
+#define CMDQ_EVENT_DISP_WDMA1_EOF		45
+#define CMDQ_EVENT_DISP_COLOR0_EOF		46
+#define CMDQ_EVENT_DISP_COLOR1_EOF		47
+#define CMDQ_EVENT_DISP_AAL_EOF			48
+#define CMDQ_EVENT_DISP_GAMMA_EOF		49
+#define CMDQ_EVENT_DISP_UFOE_EOF		50
+#define CMDQ_EVENT_DISP_DPI0_EOF		51
+#define CMDQ_EVENT_MUTEX0_STREAM_EOF		52
+#define CMDQ_EVENT_MUTEX1_STREAM_EOF		53
+#define CMDQ_EVENT_MUTEX2_STREAM_EOF		54
+#define CMDQ_EVENT_MUTEX3_STREAM_EOF		55
+#define CMDQ_EVENT_MUTEX4_STREAM_EOF		56
+#define CMDQ_EVENT_MUTEX5_STREAM_EOF		57
+#define CMDQ_EVENT_MUTEX6_STREAM_EOF		58
+#define CMDQ_EVENT_MUTEX7_STREAM_EOF		59
+#define CMDQ_EVENT_MUTEX8_STREAM_EOF		60
+#define CMDQ_EVENT_MUTEX9_STREAM_EOF		61
+#define CMDQ_EVENT_DISP_RDMA0_UNDERRUN		62
+#define CMDQ_EVENT_DISP_RDMA1_UNDERRUN		63
+#define CMDQ_EVENT_DISP_RDMA2_UNDERRUN		64
+#define CMDQ_EVENT_ISP_PASS2_2_EOF		129
+#define CMDQ_EVENT_ISP_PASS2_1_EOF		130
+#define CMDQ_EVENT_ISP_PASS2_0_EOF		131
+#define CMDQ_EVENT_ISP_PASS1_1_EOF		132
+#define CMDQ_EVENT_ISP_PASS1_0_EOF		133
+#define CMDQ_EVENT_CAMSV_2_PASS1_EOF		134
+#define CMDQ_EVENT_CAMSV_1_PASS1_EOF		135
+#define CMDQ_EVENT_SENINF_CAM1_2_3_FIFO_FULL	136
+#define CMDQ_EVENT_SENINF_CAM0_FIFO_FULL	137
+#define CMDQ_EVENT_JPGENC_PASS2_EOF		257
+#define CMDQ_EVENT_JPGENC_PASS1_EOF		258
+#define CMDQ_EVENT_JPGDEC_EOF			259
+
+#endif
-- 
2.40.0

