Return-Path: <linux-pwm+bounces-7134-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C716BB30DA0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA004683B7B
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7D1DE4E0;
	Fri, 22 Aug 2025 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4s243KM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9B33D8;
	Fri, 22 Aug 2025 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755837492; cv=none; b=u4bX2EHw6lFAaQiyYGIv7bcmDFa54CZwjbkgiYLVEZ3bVlzXqe8pcwAtab7wbh/17LCInFWbr8Gq0CvwCMjc8M5l52nR9ojx/ErF481HhF3MpxE9kcD4aExdxJ6TtPk9ywoDGk/++SK12mHyYtFamtgVUVG9qqdEL+uAWLQtHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755837492; c=relaxed/simple;
	bh=YoNI14l4Pdh+YRSuyQWbVgI02qatT3/eqjY1FatTLoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UA/dSH0RW4sSYJpoJryILCQ+tz0/vrSxa7Psd4m5uJf01pkwjceaMQSYxexsfoIjQB4WNynUi1b/OZ3eqb7BAQ4CvdlB5b34kNxnHnnleVC+UBKVVj09+I4j87dtP1yVrJt8nDGdJuTod4mJxMzP3pKWFETF1RB3rBI/hFWlgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4s243KM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2461864f7f8so10595015ad.2;
        Thu, 21 Aug 2025 21:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755837490; x=1756442290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=My8Ks7gUTzOXnQc6ajINQ2+Ev12LbWYBE5VaS2JEDTg=;
        b=H4s243KMSuWk0ZwMx6bTWKp9vuUSfQQsIhfbQj/Ibk0wjrK7O36ubxBCu2cQtR3+MA
         xQ/8Lw7QAsQaeON2L0/UthRPKBFQ5dSBPEdf7lMjqgN8GKt2K7/H3bcVoM2N5octqNz/
         RcE4DhZfBQRGVQfo8hngpA1SI2f34SDssRD2hphIeAwNpGNXVO3Yh59jkqv8SGyFHW2F
         340CwhOT0JgYdTHfVfdPU4RICw+2O2Qdpv1ICYsFxl8URASHUG4ImVm3EDIN1ZrBnqRP
         74YXvO6k6g7gm6fjpXdjLj3e37MlUcR4pL9XO0a8pQDm0HYtWq3Ni4yVoMYVQcJ7YiZt
         LVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755837490; x=1756442290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My8Ks7gUTzOXnQc6ajINQ2+Ev12LbWYBE5VaS2JEDTg=;
        b=J48jLmW32gZYCkbJnIzW4jYrKZLYkMSMSvHqZ48S6INihag3tWs6DBgN9rka0bqYoo
         xA2mWcZ8bJfRMNuLhKBeki5W07KGoJTDI/pbRmMkwUJkkO5Uq7SA/srNv/GL9y4WGryo
         lzSSXkEwlsK2NGyqaymK5OMY8C5wUgdl88cGM8tLe37Di6OgiLUYXaO/w6CjJbBY5ZNx
         7BS1w3rAdTe8OgFi1E5nbSmPXcWoOYzrMEiJTycMkTrZMux+DC7P7OLBr3XwfDU21f6s
         dzqoPqYi51r+mdSVhy1v2TlN41Qv/x3rSIjqTsLZ4YGX6EDY0ErPTbxJfXBWW+4ki5JS
         7g2w==
X-Forwarded-Encrypted: i=1; AJvYcCVY8jjG9RdNzDFa7wWcrU3I6A10XRSKPKhziyaaISw2IV22p0d60RU4MQ+6oxcv9VmAo701RxhdznM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFq/DR95M6/Vnkb3ReyO5ULShxNYJUUjFrjf7Jy5ZK1uwasZdY
	6NiJ5wjX2ItF23u9w/Dgelid6pVocBV0U4q8vlWgDwPSm22MZYkK3PEiD7nafF//
X-Gm-Gg: ASbGncu8oK2mtvF+RJC6EwXg8NzVCOu+omi8MHozBvQQ+hXd4pcGjoFpiS9EKELnQ7g
	VjVitC1ewX8Qs012EhibpLD85WyTnK6BZYfigt3Ud/AkPNMk09mwVCBCmT3+D0LpV9rHk9IaBat
	gmnQzOYi2D1ioG6WLgrQsgLrYtWYZfGbhrhgSuAhgij3YsnVkbCjBLqVCTwOTTqzUsn94EyS2bW
	Sdujknt5rl1Pl0B1IQIe9A25zvoQfauvKCGQ1VjvERHxKKGSKaFnytpiwv97GZ6Gvf2nW06AWO5
	rPf2p8fLy1WhzP4BT0DMJENzK+wNHHbim5Gd8R7kJoqcluSYZy1fAnkR3fo+zf4y/liSLrkpMjD
	vEHRzVf8m2J+bGvzQikja1L8Xvw1qHst0pGTJagFX/l9ttq4=
X-Google-Smtp-Source: AGHT+IFS6aHNcP4X9L9xrCCql7uYnw0hTaHf5mEum0ri4eZuZVaJhhx9np6IjXldHrnSaom0M86P/g==
X-Received: by 2002:a17:903:2307:b0:242:c66f:9f80 with SMTP id d9443c01a7336-2462efaae27mr26868635ad.53.1755837490453;
        Thu, 21 Aug 2025 21:38:10 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed35d511sm70661445ad.50.2025.08.21.21.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:38:10 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for 
Date: Fri, 22 Aug 2025 01:37:20 -0300
Message-ID: <20250822043720.3972-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make register field definitions use GENMASK() and FIELD_PREP() across
AQCTL, AQCSFRC, and TBCTL. This clarifies bit layout, reduces hand-rolled
shift logic, and aligns the driver with common kernel patterns.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 88 ++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b9..8509dd587 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /* EHRPWM registers and bits definitions */
 
@@ -21,15 +22,16 @@
 #define TBPRD			0x0A
 
 #define TBCTL_PRDLD_MASK	BIT(3)
-#define TBCTL_PRDLD_SHDW	0
-#define TBCTL_PRDLD_IMDT	BIT(3)
-#define TBCTL_CLKDIV_MASK	(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
-				BIT(8) | BIT(7))
-#define TBCTL_CTRMODE_MASK	(BIT(1) | BIT(0))
-#define TBCTL_CTRMODE_UP	0
-#define TBCTL_CTRMODE_DOWN	BIT(0)
-#define TBCTL_CTRMODE_UPDOWN	BIT(1)
-#define TBCTL_CTRMODE_FREEZE	(BIT(1) | BIT(0))
+#define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)
+#define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)
+
+#define TBCTL_CLKDIV_MASK	GENMASK(12, 7)
+
+#define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
+#define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
+#define TBCTL_CTRMODE_DOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 1)
+#define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
+#define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
 
 #define TBCTL_HSPCLKDIV_SHIFT	7
 #define TBCTL_CLKDIV_SHIFT	10
@@ -48,22 +50,25 @@
 #define AQSFRC			0x1A
 #define AQCSFRC			0x1C
 
-#define AQCTL_CBU_MASK		(BIT(9) | BIT(8))
-#define AQCTL_CBU_FRCLOW	BIT(8)
-#define AQCTL_CBU_FRCHIGH	BIT(9)
-#define AQCTL_CBU_FRCTOGGLE	(BIT(9) | BIT(8))
-#define AQCTL_CAU_MASK		(BIT(5) | BIT(4))
-#define AQCTL_CAU_FRCLOW	BIT(4)
-#define AQCTL_CAU_FRCHIGH	BIT(5)
-#define AQCTL_CAU_FRCTOGGLE	(BIT(5) | BIT(4))
-#define AQCTL_PRD_MASK		(BIT(3) | BIT(2))
-#define AQCTL_PRD_FRCLOW	BIT(2)
-#define AQCTL_PRD_FRCHIGH	BIT(3)
-#define AQCTL_PRD_FRCTOGGLE	(BIT(3) | BIT(2))
-#define AQCTL_ZRO_MASK		(BIT(1) | BIT(0))
-#define AQCTL_ZRO_FRCLOW	BIT(0)
-#define AQCTL_ZRO_FRCHIGH	BIT(1)
-#define AQCTL_ZRO_FRCTOGGLE	(BIT(1) | BIT(0))
+#define AQCTL_CBU_MASK		GENMASK(9, 8)
+#define AQCTL_CBU_FRCLOW	FIELD_PREP(AQCTL_CBU_MASK, 1)
+#define AQCTL_CBU_FRCHIGH	FIELD_PREP(AQCTL_CBU_MASK, 2)
+#define AQCTL_CBU_FRCTOGGLE	FIELD_PREP(AQCTL_CBU_MASK, 3)
+
+#define AQCTL_CAU_MASK		GENMASK(5, 4)
+#define AQCTL_CAU_FRCLOW	FIELD_PREP(AQCTL_CAU_MASK, 1)
+#define AQCTL_CAU_FRCHIGH	FIELD_PREP(AQCTL_CAU_MASK, 2)
+#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, 3)
+
+#define AQCTL_PRD_MASK		GENMASK(3, 2)
+#define AQCTL_PRD_FRCLOW	FIELD_PREP(AQCTL_PRD_MASK, 1)
+#define AQCTL_PRD_FRCHIGH	FIELD_PREP(AQCTL_PRD_MASK, 2)
+#define AQCTL_PRD_FRCTOGGLE	FIELD_PREP(AQCTL_PRD_MASK, 3)
+
+#define AQCTL_ZRO_MASK		GENMASK(1, 0)
+#define AQCTL_ZRO_FRCLOW	FIELD_PREP(AQCTL_ZRO_MASK, 1)
+#define AQCTL_ZRO_FRCHIGH	FIELD_PREP(AQCTL_ZRO_MASK, 2)
+#define AQCTL_ZRO_FRCTOGGLE	FIELD_PREP(AQCTL_ZRO_MASK, 3)
 
 #define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
 				AQCTL_ZRO_FRCHIGH)
@@ -74,22 +79,23 @@
 #define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
 				AQCTL_ZRO_FRCLOW)
 
-#define AQSFRC_RLDCSF_MASK	(BIT(7) | BIT(6))
-#define AQSFRC_RLDCSF_ZRO	0
-#define AQSFRC_RLDCSF_PRD	BIT(6)
-#define AQSFRC_RLDCSF_ZROPRD	BIT(7)
-#define AQSFRC_RLDCSF_IMDT	(BIT(7) | BIT(6))
-
-#define AQCSFRC_CSFB_MASK	(BIT(3) | BIT(2))
-#define AQCSFRC_CSFB_FRCDIS	0
-#define AQCSFRC_CSFB_FRCLOW	BIT(2)
-#define AQCSFRC_CSFB_FRCHIGH	BIT(3)
-#define AQCSFRC_CSFB_DISSWFRC	(BIT(3) | BIT(2))
-#define AQCSFRC_CSFA_MASK	(BIT(1) | BIT(0))
-#define AQCSFRC_CSFA_FRCDIS	0
-#define AQCSFRC_CSFA_FRCLOW	BIT(0)
-#define AQCSFRC_CSFA_FRCHIGH	BIT(1)
-#define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
+#define AQSFRC_RLDCSF_MASK	GENMASK(7, 6)
+#define AQSFRC_RLDCSF_ZRO	FIELD_PREP(AQSFRC_RLDCSF_MASK, 0)
+#define AQSFRC_RLDCSF_PRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 1)
+#define AQSFRC_RLDCSF_ZROPRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 2)
+#define AQSFRC_RLDCSF_IMDT	FIELD_PREP(AQSFRC_RLDCSF_MASK, 3)
+
+#define AQCSFRC_CSFB_MASK	GENMASK(3, 2)
+#define AQCSFRC_CSFB_FRCDIS	FIELD_PREP(AQCSFRC_CSFB_MASK, 0)
+#define AQCSFRC_CSFB_FRCLOW	FIELD_PREP(AQCSFRC_CSFB_MASK, 1)
+#define AQCSFRC_CSFB_FRCHIGH	FIELD_PREP(AQCSFRC_CSFB_MASK, 2)
+#define AQCSFRC_CSFB_DISSWFRC	FIELD_PREP(AQCSFRC_CSFB_MASK, 3)
+
+#define AQCSFRC_CSFA_MASK	GENMASK(1, 0)
+#define AQCSFRC_CSFA_FRCDIS	FIELD_PREP(AQCSFRC_CSFA_MASK, 0)
+#define AQCSFRC_CSFA_FRCLOW	FIELD_PREP(AQCSFRC_CSFA_MASK, 1)
+#define AQCSFRC_CSFA_FRCHIGH	FIELD_PREP(AQCSFRC_CSFA_MASK, 2)
+#define AQCSFRC_CSFA_DISSWFRC	FIELD_PREP(AQCSFRC_CSFA_MASK, 3)
 
 #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
-- 
2.43.0


