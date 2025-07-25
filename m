Return-Path: <linux-pwm+bounces-6885-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB4B1212D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367CA1CC5FF3
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683EC2EE998;
	Fri, 25 Jul 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fc2dqxdK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCA19F127
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458345; cv=none; b=q81RU9nmJYT9wWP9WpQRr0VfEO08gAzXbyItJ4cH0TqgCMOMEfdxMybWZra7fo9sE9mSmtaFLvAyDD6gJHmy/J6GXnDZFlwfHYFZfvlnk7Hfc0a15y+rDcRfRsUQqfHW/kZBXza2N0RNM7bUe2WGNN/ac6Gx/zqPzwkgswoXs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458345; c=relaxed/simple;
	bh=Vh5B9HqPrBhGUtVTYSV0ca1sCZJ/iXlXUjDWoHeJRpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adilN4e012RQDrpuF9hnw49VOf1DA+J4/VLzvJOQR1n5/KfSu5SVYmxybGiBTU3F+xpPLRmkDveNPF6PJidW2EPUg5h6Z6wehC2m6GEIRKfpjLcWS+Z/zaGBw34+P/3W7p/REi/NCwWeGLSeBbQBvxLO6usYTrb9sKchzKxvtaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fc2dqxdK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45629703011so18117045e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458340; x=1754063140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQhxUI8Fh9eyfgKmKjb+PifIaeiBh4I0FbzAiPRYf8Q=;
        b=Fc2dqxdK604FRibXsyqPaELEBExCUWq2fIflVE0+cboPJZpMWXHy6FttcbF7icm2Y7
         mFkqg0XlFY34CLs7ks7EhMORoRXGyfoaING0U/HOWQ+sPJca6Nvdr16P0vUfnY9j4586
         iwX04Cc82aaCwTKoxy6uK7j0LegRBwJPJEKlPjzPgVlq1mPygNq5dccXwHD5lIoFEUNe
         DkF4fTd5BqxrPwiNTrdQ5PGsXq/XrwL+91ewHLFcgdkm03DALA18tWR6s6EgolsGi/Rd
         HmUAKG1/rZ5lrNW4gSgjzX4taWybiPpzMPhxeGrx59wRmFHEkRXbYQP155nB7DdJxdh5
         UCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458340; x=1754063140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQhxUI8Fh9eyfgKmKjb+PifIaeiBh4I0FbzAiPRYf8Q=;
        b=s0ErLsdoWllr7qw0TY9P6jKUlCOhqzEM2/Ns14D5S2xrKIBiEsjeepaZJwndFogagl
         cjhEnk6qWyEkOD9FcF6RYbl+K/NceGrPhdd6kJVx/Xzrjzf7hunbR5qC99PF9NRs5tcq
         UprTvySq7BoYQzCz0FyQQtF39VxEn2O5g4GZZVyd0ZGJRHxTHcLgThuKtJm3QrjCRbtT
         VvnQNaFa22vR4UIEiUIJTf229fwV8Nyku0servcs5l7TPXHZC42t9oge07dCMQpUMZIa
         BwDMSdltjavcRyQs4pmJR2V/M8m65F5YP8kz3PRZ0SYxh01L11pLA2nK6QJYmOc25oO/
         gTog==
X-Gm-Message-State: AOJu0YyUT/alLi3VHxhy80PguaaqeUY3fLVzvyd/AQRTLyuZ+4kXa/Zo
	CcnIi1hsRF2GDkYMww9+4cgKCpkvonqeqJohhcPJKw3jHAx2viOwVLOWoabsjZ4cvnX20zWfL/F
	rRTIU
X-Gm-Gg: ASbGnctFXoKtWmFuCq1mwgOgAv+nT+C+h3uVZl7W79KfI1HJpMDlfLtw59fVqR1LL7h
	PuahmalOtJCtNHF9jG3KgT9xkQIW9sF/rajUSicka1EuhYqYtr92SR37maWMJqqc0sdPo+JA+wy
	5ZJLAbXe433tq0tBLqmNPbmfCi50j5vOZB1v6D4CKRe9RzU+eNXkCJxsuGh2otHtPluBZNuSR6F
	ZENJvpwenjdWUSuBLac8kD4lh9Edl3C2BlLdAGwCy1oTGtuVU+C+0c7bZCHGxoP90jlPcE7AI/3
	r21prmv2UQS6k9Uudz+110EKR2Gm3uCdl7APaFH1CSt+2wz8F6tzi7nfz+XuTiXI2O/eafuqSs8
	HpfIPCqaDS92kaQvDpdFdrC13e7drjhMgowal06Ti1bg6WukOvnvTaES8EUXK2iPY
X-Google-Smtp-Source: AGHT+IFvvuRO9E62crjoHjYDpYCmIkj1p8pP+WebWJSSnZvU75d1+OogkqpnJ1UX0x5ss6EP/V5dvQ==
X-Received: by 2002:a05:600c:1d09:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4587667ade9mr19761815e9.33.1753458340292;
        Fri, 25 Jul 2025 08:45:40 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705bcbfbsm60002095e9.16.2025.07.25.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel offsets
Date: Fri, 25 Jul 2025 17:45:05 +0200
Message-ID: <20250725154506.2610172-11-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5740; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Vh5B9HqPrBhGUtVTYSV0ca1sCZJ/iXlXUjDWoHeJRpM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aFx/HmfNW5zHZ9pAk6VHQWrh6vSIV//JANL AAboGD7UJ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmhQAKCRCPgPtYfRL+ TjouB/4hXsGYa61YVjD2g79g+p3dsacSCeoFj/4eZRcSqNVCH05EIO93oufe+Ag3PrqdpYtNSks RsqIY7QO5AHG62qn1/nIrFVDC6THaoxHdoLnTl1/LoA5kMoE9yZJnESBrtxYW1UtrUKD9SleUob hyPy47Kwo2GNf/NsVL8KwgaPPNmPpejr5zbt2kQPObbjz3wr3DYmuzO5sdFjUWUScfTF+oc0U4I gDzQZ9An+dNzKAti3e6OovpIWCHjbKPIjSdVVx1rfZLj6O4lM6eL5zlQ3KuVA7WTaAXSVfnfBPa 2xaFIo/cQ33tE81cATA8le4expd1I4ARHFzPrv56NCGhnTh7
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
index 4460bbca2582..4dfe657957bf 100644
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
 
 static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -306,86 +295,99 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
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
2.50.0


