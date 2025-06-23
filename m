Return-Path: <linux-pwm+bounces-6479-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B43AE3F35
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 14:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA33BC103
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCC25BF03;
	Mon, 23 Jun 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hz+rDVLF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32918248F56;
	Mon, 23 Jun 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680088; cv=none; b=u2sqMnNIY8FuGkLc2Twst1yjnGOCdGbT5QRh3TE5Obed10aHBHUuDZJ5NGeW+sXp2D/mGZKEK2gJojJkPwFQwTo0mqa0Op1dwfyPnSiYwYXO7Vkhy8ZOx3rOa9VmsQvG7xWFJAHeG9T1zgZj5IF39aphnzJ0HssMWqoYPRElNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680088; c=relaxed/simple;
	bh=jSa1CeNENoFw2VoytQdb/vKwJWtYXw3LRI1EfB29zsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU94inUH3Jh7D6sVqfyjPOyq83kQgNA/UPJAQNmPyJN1qZ077IyGG8Tw6I437+YKuqO7k9DvQbY3TnPd//pzPvZFWLpX4kBbv+VDWg742pcikvWl7FvsQb2dK5fiXtXipA8Myr85+2CK4UbKD8rh7hnscrh9eLscsn2MXJq0f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hz+rDVLF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680084;
	bh=jSa1CeNENoFw2VoytQdb/vKwJWtYXw3LRI1EfB29zsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hz+rDVLFYVk9aesmFoK7AUvOnSCgSNGelPgUL8KirXBzeGKQK7/JpbImOKHbqeWYo
	 Qq4/+fNuG46SUyxlpO8zc0obuD6adi2PIdw3kNLsEojIVs/jowOIUANu6vAvX3/16/
	 VEH1KxQ0Z2Iq0vzIqEXCDLoVSjV+0gTCNlwbGSnhTQrY3p5YO2IUeQACD69olNEwtX
	 Hlyib3bfzTt185zoixW9BnDXDSAOKX2C6Cp8mFrWOKgRzTMnhyZLHAWaoL00jJvVZI
	 SmUjkSpS3kJ8Tc2PSZwKm3JQ0QmQmJTCogdeZTceX+efIdKjEKWXyRNfDWJMjU3rGB
	 wQHn3WINjsOEA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 10E8717E090E;
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
Subject: [PATCH v1 2/3] pwm: pwm-mediatek: Pass PWM_CK_26M_SEL from platform data
Date: Mon, 23 Jun 2025 14:01:17 +0200
Message-ID: <20250623120118.109170-3-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for new SoCs, remove variable
has_ck_26m_sel from pwm_mediatek_of_data and replace it with a
u16 pwm_ck_26m_sel_reg, meant to hold the register offset for
PWM_CK_26M_SEL.

Also, since the reg offset is guaranteed to never be zero, the
logic to check for "has_ck_26m_sel" is changed to check if the
register offset in pwm_ck_26m_sel_reg is more than zero.

Analogously, when writing, use the register offset from platform
data instead of using the PWM_CK_26M_SEL definition.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 7eaab5831499..38e9e9dc91c6 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -36,7 +36,7 @@
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
-	bool has_ck_26m_sel;
+	u16 pwm_ck_26m_sel_reg;
 	const unsigned int *reg_offset;
 };
 
@@ -134,8 +134,8 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
-	if (pc->soc->has_ck_26m_sel)
-		writel(0, pc->regs + PWM_CK_26M_SEL);
+	if (pc->soc->pwm_ck_26m_sel_reg)
+		writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
@@ -291,84 +291,78 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = false,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt6795_pwm_data = {
 	.num_pwms = 7,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = false,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = true,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
-	.has_ck_26m_sel = false,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = true,
-	.has_ck_26m_sel = false,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 	.num_pwms = 1,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = false,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt7981_pwm_data = {
 	.num_pwms = 3,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = true,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.reg_offset = mtk_pwm_reg_offset_v2,
 };
 
 static const struct pwm_mediatek_of_data mt7986_pwm_data = {
 	.num_pwms = 2,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = true,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt7988_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = false,
 	.reg_offset = mtk_pwm_reg_offset_v2,
 };
 
 static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = true,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt8365_pwm_data = {
 	.num_pwms = 3,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = true,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
-	.has_ck_26m_sel = true,
+	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
 	.reg_offset = mtk_pwm_reg_offset_v1,
 };
 
-- 
2.49.0


