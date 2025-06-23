Return-Path: <linux-pwm+bounces-6480-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E1AE3F37
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 14:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C80A3BA67D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256E25BF19;
	Mon, 23 Jun 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F6jlQNyh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F625BEE3;
	Mon, 23 Jun 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680088; cv=none; b=TCqYDQJeMlbtBH+LU4vRq7oi3kxvjbG9DdBcl2vIrkg7/ZEKMcJEvEdYOXHygVMRpBhJoD4pchiWsZqaHjyAeRnZwTrH00jcZvZgTOw8+RB3zJOLQSTGw0QKbYVs3HedlHk/0Dyz7V693ZKBLPk4iT2yJ9pEvr83FyqP692/pkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680088; c=relaxed/simple;
	bh=Wqto3p2O9ygvp/uRrLvFV9jgjx5W1SFttAJN2GmqEow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7A9g9xlNKB8SnIyAHme2D+499BpM+8RYwTU6Q5zBU1bU+yooCurItWVu8SOFMJPAAZ60DRF8QflRW6fofpikzAIyETtKx/OMWxMVUif6P5wTlBAwNsMPxX3CXkJ6r/yu9DCt8IOQc5DTwrNDcT7Rap8oCvWg8n7MBcZVlTvMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F6jlQNyh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680085;
	bh=Wqto3p2O9ygvp/uRrLvFV9jgjx5W1SFttAJN2GmqEow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6jlQNyhDgrrJI6CjJyW6sR77WpPIbp+QS/von5pm8IBLVOWeqzsdCXkk6XDEdfax
	 U4/BchVKrzWHdEqsT36Y1Wzi0ZUnnObvzUfLP3cBuonTvAx0y2dRBmUJqoN6khHKoK
	 UPyHxQcqiqyiwy+4gxfcks/a85Mw8NUISF0paI/AAqFcRm7MqpMaqspYazDYFSo1tb
	 y4nuINI7/cqgC8/G69Zkz3ObsefyOrHLbETPbRjyqJObQAWzLc/avsvlcTAQC9b7BJ
	 uQ5kV2knV+w1qi9ENxu/O0VOK/mnlWQMmAUCvkoS1Di9wiOvG5n1VufNWvAwfpq5a2
	 LSOs8kal7AifA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E38BA17E156D;
	Mon, 23 Jun 2025 14:01:24 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ukleinek@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	john@phrozen.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 3/3] pwm: pwm-mediatek: Add support for PWM IP V3.0.2 in MT6991/MT8196
Date: Mon, 23 Jun 2025 14:01:18 +0200
Message-ID: <20250623120118.109170-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>
References: <20250623120118.109170-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the PWM IP version 3.0.2, found in MediaTek's
Dimensity 9400 MT6991 and in the MT8196 Chromebook SoC: this
needs a new register offset array and also a different offset
for the PWM_CK_26M_SEL register.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 38e9e9dc91c6..1fbc84d47543 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -29,6 +29,7 @@
 #define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
 #define PWM45THRES_FIXUP	0x34
+#define PWM_CK_26M_SEL_V3	0x74
 #define PWM_CK_26M_SEL		0x210
 
 #define PWM_CLK_DIV_MAX		7
@@ -64,6 +65,11 @@ static const unsigned int mtk_pwm_reg_offset_v2[] = {
 	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x01c0, 0x0200, 0x0240
 };
 
+/* PWM IP Version 3.0.2 */
+static const unsigned int mtk_pwm_reg_offset_v3[] = {
+	0x0100, 0x0200, 0x0300, 0x0400, 0x0500, 0x0600, 0x0700, 0x0800
+};
+
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
@@ -366,9 +372,17 @@ static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
+static const struct pwm_mediatek_of_data mt6991_pwm_data = {
+	.num_pwms = 4,
+	.pwm45_fixup = false,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL_V3,
+	.reg_offset = mtk_pwm_reg_offset_v3,
+};
+
 static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt6795-pwm", .data = &mt6795_pwm_data },
+	{ .compatible = "mediatek,mt6991-pwm", .data = &mt6991_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
-- 
2.49.0


