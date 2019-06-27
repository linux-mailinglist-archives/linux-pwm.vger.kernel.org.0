Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4857DA9
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2019 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF0IBm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jun 2019 04:01:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5635 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726544AbfF0IBl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jun 2019 04:01:41 -0400
X-UUID: af4a2c27b60c4198b5025a5939c6f097-20190627
X-UUID: af4a2c27b60c4198b5025a5939c6f097-20190627
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1262622998; Thu, 27 Jun 2019 16:01:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Jun
 2019 16:01:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 27 Jun 2019 16:01:23 +0800
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
Subject: [v5 4/7] drm/mediatek: add frame size control
Date:   Thu, 27 Jun 2019 16:01:12 +0800
Message-ID: <20190627080116.40264-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627080116.40264-1-jitao.shi@mediatek.com>
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24720.003
X-TM-AS-Result: No-7.797800-8.000000-10
X-TMASE-MatchedRID: 4fIxLVRlVoz935chln091FZ85UImhNta+eBf9ovw8I2RoQLwUmtov7BZ
        szSz1qei2XHJ0L4jOITTDbyTDLiYnZxBJWVIsdLqA9lly13c/gE5B3KUNlRt51VkJxysad/IJTn
        jWSezJPZBXFYsxXKTlvssoJBke0RlqZWpk+GKRVNIUlKkz3wfmX0tCKdnhB589yM15V5aWpj6C0
        ePs7A07RQEL0GGu6SDsXWDONKz/s5QaPnzkRZpYjy4hCRTklRkE6fTC+T7uQ4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.797800-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24720.003
X-TM-SNTS-SMTP: C8B5EEBD7AA18A239CFB080C5B9AB92E1996F13A41DB17C5AA1328425E81A0FC2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Our new DSI chip has frame size control.
So add the driver data to control for different chips.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 6b6550926db6..45e331055842 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -78,6 +78,7 @@
 #define DSI_VBP_NL		0x24
 #define DSI_VFP_NL		0x28
 #define DSI_VACT_NL		0x2C
+#define DSI_SIZE_CON		0x38
 #define DSI_HSA_WC		0x50
 #define DSI_HBP_WC		0x54
 #define DSI_HFP_WC		0x58
@@ -162,6 +163,7 @@ struct phy;
 struct mtk_dsi_driver_data {
 	const u32 reg_cmdq_off;
 	bool has_shadow_ctl;
+	bool has_size_ctl;
 };
 
 struct mtk_dsi {
@@ -430,6 +432,10 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
 	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
 
+	if (dsi->driver_data->has_size_ctl)
+		writel(vm->vactive << 16 | vm->hactive,
+		       dsi->regs + DSI_SIZE_CON);
+
 	horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
-- 
2.21.0

