Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3332F35506D
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbhDFJ7J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 05:59:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40628 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241262AbhDFJ7G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 05:59:06 -0400
X-UUID: a433c042379b4056a3ca568004468f46-20210406
X-UUID: a433c042379b4056a3ca568004468f46-20210406
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1787102030; Tue, 06 Apr 2021 17:58:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 17:58:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 17:58:52 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3,PATCH 3/3] pwm: mtk_disp: implement .get_state()
Date:   Tue, 6 Apr 2021 17:57:42 +0800
Message-ID: <1617703062-4251-4-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

implement get_state function for pwm-mtk-disp

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 502228adf718..166e0a8ca703 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -179,8 +179,54 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return mtk_disp_pwm_enable(chip, state);
 }
 
+static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
+	u32 clk_div, period, high_width, con0, con1;
+	u64 rate;
+	int err;
+
+	err = clk_prepare_enable(mdp->clk_main);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_main: %d\n", err);
+		return;
+	}
+	err = clk_prepare_enable(mdp->clk_mm);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_mm: %d\n", err);
+		clk_disable_unprepare(mdp->clk_main);
+		return;
+	}
+
+	rate = clk_get_rate(mdp->clk_main);
+
+	con0 = readl(mdp->base + mdp->data->con0);
+	con1 = readl(mdp->base + mdp->data->con1);
+
+	state->polarity = con0 & PWM_POLARITY ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	state->enabled = !!(con0 & BIT(0));
+
+	clk_div = (con0 & PWM_CLKDIV_MASK) >> PWM_CLKDIV_SHIFT;
+	period = con1 & PWM_PERIOD_MASK;
+	state->period = div_u64(period * (clk_div + 1) * NSEC_PER_SEC, rate);
+	high_width = (con1 & PWM_HIGH_WIDTH_MASK) >> PWM_HIGH_WIDTH_SHIFT;
+	state->duty_cycle = div_u64(high_width * (clk_div + 1) * NSEC_PER_SEC,
+				    rate);
+
+	if (!state->enabled) {
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
+	}
+
+	mdp->enabled = state->enabled;
+}
+
 static const struct pwm_ops mtk_disp_pwm_ops = {
 	.apply = mtk_disp_pwm_apply,
+	.get_state = mtk_disp_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.18.0

