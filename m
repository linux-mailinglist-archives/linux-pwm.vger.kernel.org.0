Return-Path: <linux-pwm+bounces-7800-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D57CCBD641
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Dec 2025 11:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 885DA30122F1
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Dec 2025 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5CD3164B1;
	Mon, 15 Dec 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YOh8OG18"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7E3164D8;
	Mon, 15 Dec 2025 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795250; cv=none; b=CBlw9sWN5CFHUw+eMMSdkpyAc+CtdlhyrFQeR+Op0UULF5t3qSsuRLOMb7s97zh18/i7DcARce3TMQ8RwoDRhKzaqa0r5cGbeJfyCi89TJbQltLMNJLLmRY4fSZKcglRsKlp+yfRFX1z8wJjp3bFyJROWcyPSQrsvOZy1UuqEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795250; c=relaxed/simple;
	bh=Vt2JfkmO0mYcFcvjJqqVNwNLlfwaH65yrX0bhgj6nTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzlQwYGEbPIQFkFM/k52afeD6+HD59+o/ZHfjH4vK3iC11wyp/Vz2RCH0KjkZ5tXQhxWPFO20uobGn3dFl0XN0ljIobruJXEKvlckTOsTdfizj6A8/LF5Q6dvkiRS8iVGWMSWameeORCFHJjME8MQlT5Js0Svuh8BoMLgPyq0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YOh8OG18; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 808f692cd9a211f0b2bf0b349165d6e0-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7XaRLbBJhSEUDHmd2FnN+oJUsUUjUDK/6biwWL7Eots=;
	b=YOh8OG180mQqNn711cCwGSW2he6zeeJQ0WgW/6vrJZ9IbB4gsW76KXv4FVbiBUUVOfNe/JvfickaJPtj8tB4GSVVTc9xOXhguavb2qj4DmtZXhIUrvqqdwDcHq0NbucNOT37ra/09/At9ye9ZBzSkoyL3/26KAL6NkvIZ9uqJuE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9be1a6b8-bc19-47a6-974d-5e67a286a323,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:b8708928-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 808f692cd9a211f0b2bf0b349165d6e0-20251215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <payne.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 446217423; Mon, 15 Dec 2025 18:40:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 18:40:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 18:40:39 +0800
From: 20190311120055 created <payne.lin@mediatek.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, Payne Lin <payne.lin@mediatek.com>
Subject: [PATCH] pwm: mediatek: Add error handling for zero rate in PWM state
Date: Mon, 15 Dec 2025 18:40:32 +0800
Message-ID: <20251215104037.3100485-1-payne.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Payne Lin <payne.lin@mediatek.com>

Added a check to handle cases where the rate is zero in the
mtk_disp_pwm_get_state function. This prevents division by zero errors
when calculating the period.
- Added error message for zero rate scenario

Signed-off-by: Payne Lin <payne.lin@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index bafd6b6195f6..dd0ae041af70 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -176,19 +176,18 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
 	u64 rate, period, high_width;
 	u32 clk_div, pwm_en, con0, con1;
-	int err;
+	int ret;
 
-	err = clk_prepare_enable(mdp->clk_main);
-	if (err < 0) {
-		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
-		return err;
+	ret = clk_prepare_enable(mdp->clk_main);
+	if (ret < 0) {
+		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n", ERR_PTR(ret));
+		goto err_handle;
 	}
 
-	err = clk_prepare_enable(mdp->clk_mm);
-	if (err < 0) {
-		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
-		clk_disable_unprepare(mdp->clk_main);
-		return err;
+	ret = clk_prepare_enable(mdp->clk_mm);
+	if (ret < 0) {
+		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(ret));
+		goto err_disable_clk_main;
 	}
 
 	/*
@@ -212,15 +211,23 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 	 * period has 12 bits, clk_div 11 and NSEC_PER_SEC has 30,
 	 * so period * (clk_div + 1) * NSEC_PER_SEC doesn't overflow.
 	 */
+	if (rate == 0) {
+		dev_err(pwmchip_parent(chip), "rate is zero, cannot calculate period\n");
+		ret = -EINVAL;
+		goto err_disable_clk_mm;
+	}
 	state->period = DIV64_U64_ROUND_UP(period * (clk_div + 1) * NSEC_PER_SEC, rate);
 	high_width = FIELD_GET(PWM_HIGH_WIDTH_MASK, con1);
 	state->duty_cycle = DIV64_U64_ROUND_UP(high_width * (clk_div + 1) * NSEC_PER_SEC,
 					       rate);
 	state->polarity = PWM_POLARITY_NORMAL;
+
+err_disable_clk_mm:
 	clk_disable_unprepare(mdp->clk_mm);
+err_disable_clk_main:
 	clk_disable_unprepare(mdp->clk_main);
-
-	return 0;
+err_handle:
+	return ret;
 }
 
 static const struct pwm_ops mtk_disp_pwm_ops = {
-- 
2.45.2


