Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78DE57DB9
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2019 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0IBi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jun 2019 04:01:38 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:13803 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbfF0IBh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jun 2019 04:01:37 -0400
X-UUID: e832c994c4974a4cabdf1e440b89444e-20190627
X-UUID: e832c994c4974a4cabdf1e440b89444e-20190627
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 393272168; Thu, 27 Jun 2019 16:01:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Jun
 2019 16:01:20 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 27 Jun 2019 16:01:19 +0800
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
Subject: [v5 1/7] drm/mediatek: move mipi_dsi_host_register to probe
Date:   Thu, 27 Jun 2019 16:01:09 +0800
Message-ID: <20190627080116.40264-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627080116.40264-1-jitao.shi@mediatek.com>
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24720.003
X-TM-AS-Result: No-7.110300-8.000000-10
X-TMASE-MatchedRID: usamOvt1jXSiXdgrlKZp5/3HILfxLV/93V4UShoTXad0FoS1aixTNT7s
        j+R9FMn6NBAJbldcKgW8sMFSGTsyAdpsFVyqUNwXQ4srjeRbxTZLXPA26IG0hN9RlPzeVuQQhqJ
        xi9IzezJKBVbsqgRiwDEua3P66jtsdpvo/nKASz4XK/dRaOWlvaDzzrtsjCZTTFmQ5D//V2mPKV
        zaGaT8FsmfTf3tAqfJu1ODjDi7RA9wWpD0snGz80LhYg/sa1gs3YSaHlnZL83mTInKzpSFSUjYb
        j4tH6TbMOHyrjcZo6KFhnNm59A/TOG1W8jesiDJfzgVmnL/olV9LQinZ4QefPcjNeVeWlqY+gtH
        j7OwNO0UQCQtpNwWelQr3pKYQmVmvbaUI5qOTyRMrQLzfNR1jflwnnsh3VrI
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.110300-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24720.003
X-TM-SNTS-SMTP: 09CA99ED57FD0182758A7D3C7F0FFF515B248FC850EDADDFAB1B90369B3BD8722000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DSI panel driver need attach function which is inculde in
mipi_dsi_host_ops.

If mipi_dsi_host_register is not in probe, dsi panel will
probe more delay.

So move the mipi_dsi_host_register to probe from bind.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 53 +++++++++++++++++-------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..595b3b047c7b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -528,7 +528,7 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
 
 static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 {
-	struct device *dev = dsi->dev;
+	struct device *dev = dsi->->host.dev;
 	int ret;
 	u64 pixel_clock, total_bits;
 	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
@@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	ret = mipi_dsi_host_register(&dsi->host);
-	if (ret < 0) {
-		dev_err(dev, "failed to register DSI host: %d\n", ret);
-		goto err_ddp_comp_unregister;
-	}
-
 	ret = mtk_dsi_create_conn_enc(drm, dsi);
 	if (ret) {
 		DRM_ERROR("Encoder create failed with %d\n", ret);
@@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_unregister:
-	mipi_dsi_host_unregister(&dsi->host);
-err_ddp_comp_unregister:
 	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
 	return ret;
 }
@@ -1073,7 +1065,6 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
 
 	mtk_dsi_destroy_conn_enc(dsi);
-	mipi_dsi_host_unregister(&dsi->host);
 	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
 }
 
@@ -1097,31 +1088,36 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 	dsi->host.ops = &mtk_dsi_ops;
 	dsi->host.dev = dev;
+	ret = mipi_dsi_host_register(&dsi->host);
+	if (ret < 0) {
+		dev_err(dev, "failed to register DSI host: %d\n", ret);
+		return ret;
+	}
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
 					  &dsi->panel, &dsi->bridge);
 	if (ret)
-		return ret;
+		goto err_unregister_host;
 
 	dsi->engine_clk = devm_clk_get(dev, "engine");
 	if (IS_ERR(dsi->engine_clk)) {
 		ret = PTR_ERR(dsi->engine_clk);
 		dev_err(dev, "Failed to get engine clock: %d\n", ret);
-		return ret;
+		goto err_unregister_host;
 	}
 
 	dsi->digital_clk = devm_clk_get(dev, "digital");
 	if (IS_ERR(dsi->digital_clk)) {
 		ret = PTR_ERR(dsi->digital_clk);
 		dev_err(dev, "Failed to get digital clock: %d\n", ret);
-		return ret;
+		goto err_unregister_host;
 	}
 
 	dsi->hs_clk = devm_clk_get(dev, "hs");
 	if (IS_ERR(dsi->hs_clk)) {
 		ret = PTR_ERR(dsi->hs_clk);
 		dev_err(dev, "Failed to get hs clock: %d\n", ret);
-		return ret;
+		goto err_unregister_host;
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1129,33 +1125,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->regs)) {
 		ret = PTR_ERR(dsi->regs);
 		dev_err(dev, "Failed to ioremap memory: %d\n", ret);
-		return ret;
+		goto err_unregister_host;
 	}
 
 	dsi->phy = devm_phy_get(dev, "dphy");
 	if (IS_ERR(dsi->phy)) {
 		ret = PTR_ERR(dsi->phy);
 		dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
-		return ret;
+		goto err_unregister_host;
 	}
 
 	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
 	if (comp_id < 0) {
 		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
-		return comp_id;
+		ret = comp_id;
+		goto err_unregister_host;
 	}
 
 	ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
 				&mtk_dsi_funcs);
 	if (ret) {
 		dev_err(dev, "Failed to initialize component: %d\n", ret);
-		return ret;
+		goto err_unregister_host;
 	}
 
 	irq_num = platform_get_irq(pdev, 0);
 	if (irq_num < 0) {
-		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
-		return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get dsi irq_num: %d\n", irq_num);
+		ret = irq_num;
+		goto err_unregister_host;
 	}
 
 	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
@@ -1163,14 +1161,24 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
-		return -EPROBE_DEFER;
+		goto err_unregister_host;
 	}
 
 	init_waitqueue_head(&dsi->irq_wait_queue);
 
 	platform_set_drvdata(pdev, dsi);
 
-	return component_add(&pdev->dev, &mtk_dsi_component_ops);
+	ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add component: %d\n", ret);
+		goto err_unregister_host;
+	}
+
+	return 0;
+
+err_unregister_host:
+	mipi_dsi_host_unregister(&dsi->host);
+	return ret;
 }
 
 static int mtk_dsi_remove(struct platform_device *pdev)
@@ -1179,6 +1187,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 
 	mtk_output_dsi_disable(dsi);
 	component_del(&pdev->dev, &mtk_dsi_component_ops);
+	mipi_dsi_host_unregister(&dsi->host);
 
 	return 0;
 }
-- 
2.21.0

