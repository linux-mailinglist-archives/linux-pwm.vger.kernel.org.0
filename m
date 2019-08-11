Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7A89158
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2019 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHKKk7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Aug 2019 06:40:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42109 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726502AbfHKKkz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Aug 2019 06:40:55 -0400
X-UUID: 01ce1aa9166a4c46b2583896824e64f2-20190811
X-UUID: 01ce1aa9166a4c46b2583896824e64f2-20190811
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2070566583; Sun, 11 Aug 2019 18:40:49 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 11 Aug
 2019 18:40:42 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 11 Aug 2019 18:40:40 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        "Rahul Sharma" <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Vincent Palatin" <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [PATCH v6 3/7] drm/mediatek: add dsi reg commit disable control
Date:   Sun, 11 Aug 2019 18:40:04 +0800
Message-ID: <20190811104008.53372-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811104008.53372-1-jitao.shi@mediatek.com>
References: <20190811104008.53372-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24840.000
X-TM-AS-Result: No-2.463500-8.000000-10
X-TMASE-MatchedRID: oPR0E2xDvMj83RazFYjhB26yfYFZzrGdZ9PKbshf5c4da1Vk3RqxONeu
        l29/x8ODkREoYNKTmnm1bKejN6nC5P1PYuSZ5yXpqJSK+HSPY++eEP0DdJrulgdkFovAReUovqn
        FtM6Nq/JrfJNHzOv42smzFW0zy93H2e1cwoB4RlggCPGiZqtI8LtubiieweWumyiLZetSf8mfop
        0ytGwvXiq2rl3dzGQ1F16aXoi8Z1nsRNjyF6mdIvibNsxjIyOzZ1+mV30ImeB7xZt7nWevYp7T7
        ZmkgQ/6rQnglSC76Hi7PnY3br2onAjrF1fOOaVbU6d6SdlHFEb4hUcAI3yp/uK9rB3JzW5/EdpX
        6vXt2EbHJ1PhMfPBow==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.463500-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24840.000
X-TM-SNTS-SMTP: EDBE0AC4A9314A126DA0109F93C21AC6DABF309848B6EC1F8A5625B92627F2452000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

New DSI IP has shadow register and working reg. The register
values are writen to shadow register. And then trigger with
commit reg, the register values will be moved working register.

This fucntion is defualt on. But this driver doesn't use this
function. So add the disable control.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ac8e80e379f7..314bfb1c827b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -123,6 +123,10 @@
 #define VM_CMD_EN			BIT(0)
 #define TS_VFP_EN			BIT(5)
 
+#define DSI_SHADOW_DEBUG	0x190U
+#define FORCE_COMMIT			BIT(0)
+#define BYPASS_SHADOW			BIT(1)
+
 #define CONFIG				(0xff << 0)
 #define SHORT_PACKET			0
 #define LONG_PACKET			2
@@ -149,6 +153,7 @@ struct phy;
 
 struct mtk_dsi_driver_data {
 	const u32 reg_cmdq_off;
+	bool has_shadow_ctl;
 };
 
 struct mtk_dsi {
@@ -586,6 +591,11 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	}
 
 	mtk_dsi_enable(dsi);
+
+	if (dsi->driver_data->has_shadow_ctl)
+		writel(FORCE_COMMIT | BYPASS_SHADOW,
+		       dsi->regs + DSI_SHADOW_DEBUG);
+
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_phy_timconfig(dsi);
 
-- 
2.21.0

