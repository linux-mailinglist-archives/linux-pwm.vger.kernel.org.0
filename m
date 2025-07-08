Return-Path: <linux-pwm+bounces-6780-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB86AFD525
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716A87A6F19
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C42DD5EF;
	Tue,  8 Jul 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZUzRnLTX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46DF9E8
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995147; cv=none; b=F/EM4TlA86WcbmKqd5KfYTRCquuKwxdP2tgw7Kzi/wg1uurck4O/b5qVio10tn2cZJespkrODzy2ctmXCvP32UFg6c7Qjhq38n7YmJIeLx1R8gtSoBvS3YHd/iK4kOJtz+HphvwAe/SHoew7Qd2yImZyqGoCLTffqp9P73tsYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995147; c=relaxed/simple;
	bh=z5L3CHH25GbwGRFMLktIjhgOzZBzKjmxrP0Cl1JGUM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ798wiwkvQBkgW49psM4tg1vwI+BaIMCmQ7Gb/ng6dz0Ujjtf+a6qPCxK7sy/JB/1AusuR+Xu0rDYhNVrzYu3L58lSyUpRSSe3gBzGTg9wOugiZTvYpV/2gCAV5z2ridgmC2H5p/nIo0PILAWS3sXWBEXFwMU3ZdS6htU5W/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZUzRnLTX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so818652066b.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995143; x=1752599943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YCcBWqb/14OVf5aTxzQNZow44RZO+5hy/WyrTI6Mqw=;
        b=ZUzRnLTX8RheecOG46p0SBwiEPRsUJbhb/tH2EhFwpvf4Wmph0544JqoJYWwq1QUvf
         aiO//VuOTm7fHXFvqv4E35IRaY+kTxFxl7Qe9tLID0rtS3WJ3LGCsV67q0jWLuGw148S
         rNyO2CBoCAGdwQReYVmrKzx0oSk0cHeNeX4QDt0M7M7ITT7SX64OdcN2Dmi161Ji1hw9
         j8fedxjjJcsi78rcn5uGYZXvK+ssZwAZIffRfg9dQ90gOTza735wO7+U0YNMUJzG6twa
         h3uIMVRwSUGdZHp1ynvvqsC9jjHiH2kzCpM2YNEMAm1dYyIqGV+2Hj2NGBN7+bzEW8gu
         cbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995143; x=1752599943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YCcBWqb/14OVf5aTxzQNZow44RZO+5hy/WyrTI6Mqw=;
        b=vLPhXG315TyqP3pzuXa5JsgWTduZ8PqEiCTBPmriqRrSRGt3bYrl0mLXkMAxDHgcjg
         7Wz+RPjHqpjBY6yLvPWfGHB9fG8uIp/1hqIS3rEkrtV5hltAVIStVvLQ1goE2h7iutex
         q8idI4goZxWUbh6FsawtoP7btWddEpQhSXxu/yYBL0VS/DsTAQgtuxBDRAXa4OFP/yGp
         y9F5nh951GgkTwdUSijdv1YekecnJl6QC2qKbxcjATVTMPVoy4GXH2DXPjZuV+BdAjKY
         2d52S5PjVWO35LVCTP3uunhqfn1t9nTH6OF+LAjkQLzpQu361AfR3Wl14ep2bvgWeQyO
         vvrg==
X-Gm-Message-State: AOJu0YyJ/CU5jPDbdGVEABCIpa5jhHxfR8oWJS3LRYhycOKzkP+tSjpJ
	TP2HX7RzLrCYXTwixAj26lgFiiK+DhGVeCZNNQDd8u0GXVhA1slVrdBOEqdDPLx3Ad02AbhsFk9
	uTkLZ
X-Gm-Gg: ASbGnctv2nXNZAz0PxUB6DmCtQhud5Uf9bor/DSj0kar0/9OQC7wMyJXaslD8NxT8u7
	bACosuue3WAzSG2YuGv6wevhmCp8Ei9pVg5FP/NOKluw8f523gu8/0A3BlygERc4m+LoVhLEvn5
	fD7xGpIUt7aJpxQXlR9vTr2xDyI7Nl0tplmFxrSdsJel2uXlnQT/Mv9LDQAFjp7A1G8BbkLjVGB
	nip79klG0iXcptij+KCf8PW8Nd3Nb5rA1fNWVlUBWajo9F9N2DWRs/56y0Esi/u2RhMzfIEQ0sD
	+3ytJO8L9cKyKIDqWEZGnYwiE2bSx/fEZtKURDoS6nYwrw/0BzzUKhOVM729xz4Upi9zlrkwPx9
	C8Z681MYywgZ8wG1eJXVKXxY1Mm3N
X-Google-Smtp-Source: AGHT+IF8kfHJKejLeK1j6H1zcywDZ8Xdr2xWppCGautnggpU9vBR2EhDTLoKC/i+i65Bb+rH5MsXng==
X-Received: by 2002:a17:907:2d8c:b0:ad8:ae51:d16 with SMTP id a640c23a62f3a-ae3fe82cdeamr1461476766b.55.1751995143150;
        Tue, 08 Jul 2025 10:19:03 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6949fa6sm938612466b.68.2025.07.08.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/8] pwm: mediatek: Simplify representation of channel offsets
Date: Tue,  8 Jul 2025 19:18:31 +0200
Message-ID:  <94aa8b7d52040f3a8dcefa7bfc634b3b747a26fa.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5739; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=z5L3CHH25GbwGRFMLktIjhgOzZBzKjmxrP0Cl1JGUM8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLq2AvNIQgz0PLl1pxrGIZfz+DVJY8qDCHHM wDr+RYhjhiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S6gAKCRCPgPtYfRL+ Tu6rB/9p4O1XZjIbDPc+vjcQU19EDxQe/BSCihxRRBdMxsMWowCwgoaYwPNSUSn5iBl4xCOW5rO bQ/hp5Q0Ef5zbg93tsqLEuTnR9T+jOX73GWuhB9XlUVuOBDRDJPwXCJyXw/oBACjJXSqIYeOpmJ wfwQmkghSSiQGiAC6/vEJQroAxsibBG0tkVeVvthZ47oyvGEZWyR7bjlyUzh/PWUxegEGmup0CH E/pd1HmG8gt7WYRyc1GUjZRHT7kxw4eS1BS7f24FYHbJr+AGOj/EMTJFLCh9mttnyUG3LvsBYtJ 6yJOAQvuZdIz8i5zTHj52ExXITzCPHJd3sJs5jpp2lxLqnZ2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The general register layout contains some per-chip registers starting at
offset 0 and then at a higher address there are n nearly identical and
equidistant blocks for the registers of the n channels.

This allows to represent the offsets of per-channel registers as $base +
i * $width instead of listing all (or too many) offsets explicitly in an
array. So for a small additional effort in pwm_mediatek_writel() the
three arrays with the channel offsets can be dropped.

The size changes according to bloat-o-meter are:

	add/remove: 0/3 grow/shrink: 1/0 up/down: 12/-96 (-84)
	Function                                     old     new   delta
	pwm_mediatek_apply                           696     708     +12
	mtk_pwm_reg_offset_v3                         32       -     -32
	mtk_pwm_reg_offset_v2                         32       -     -32
	mtk_pwm_reg_offset_v1                         32       -     -32
	Total: Before=5347, After=5263, chg -1.57%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 58 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6777c511622a..a816f136f39d 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -38,7 +38,8 @@ struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
 	u16 pwm_ck_26m_sel_reg;
-	const unsigned int *reg_offset;
+	unsigned int chanreg_base;
+	unsigned int chanreg_width;
 };
 
 /**
@@ -57,19 +58,6 @@ struct pwm_mediatek_chip {
 	const struct pwm_mediatek_of_data *soc;
 };
 
-static const unsigned int mtk_pwm_reg_offset_v1[] = {
-	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
-};
-
-static const unsigned int mtk_pwm_reg_offset_v2[] = {
-	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x01c0, 0x0200, 0x0240
-};
-
-/* PWM IP Version 3.0.2 */
-static const unsigned int mtk_pwm_reg_offset_v3[] = {
-	0x0100, 0x0200, 0x0300, 0x0400, 0x0500, 0x0600, 0x0700, 0x0800
-};
-
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
@@ -118,7 +106,8 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 				       unsigned int num, unsigned int offset,
 				       u32 value)
 {
-	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
+	writel(value, chip->regs + chip->soc->chanreg_base +
+	       num * chip->soc->chanreg_width + offset);
 }
 
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -300,86 +289,99 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt6795_pwm_data = {
 	.num_pwms = 7,
 	.pwm45_fixup = false,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = true,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 	.num_pwms = 1,
 	.pwm45_fixup = false,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7981_pwm_data = {
 	.num_pwms = 3,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
-	.reg_offset = mtk_pwm_reg_offset_v2,
+	.chanreg_base = 0x80,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7986_pwm_data = {
 	.num_pwms = 2,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt7988_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
-	.reg_offset = mtk_pwm_reg_offset_v2,
+	.chanreg_base = 0x80,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt8365_pwm_data = {
 	.num_pwms = 3,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
-	.reg_offset = mtk_pwm_reg_offset_v1,
+	.chanreg_base = 0x10,
+	.chanreg_width = 0x40,
 };
 
 static const struct pwm_mediatek_of_data mt6991_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = false,
 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL_V3,
-	.reg_offset = mtk_pwm_reg_offset_v3,
+	.chanreg_base = 0x100,
+	.chanreg_width = 0x100,
 };
 
 static const struct of_device_id pwm_mediatek_of_match[] = {
-- 
2.49.0


