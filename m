Return-Path: <linux-pwm+bounces-7712-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9CC9071A
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CB23AADAC
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5422AE7F;
	Fri, 28 Nov 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az36a0rc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715C227E95
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290342; cv=none; b=gK26GWAyHPhmdqqlrOJLL9qBz6AbkEmq65ak/MIh+UD58eGsZNiimD8CQr/tP8q6jOXSJ4aHGAhvVRxA3SIoz7EQvnF/q2bS9iWvUjjJM26vwZPfz2FzOvDb37baSZPBRd2zJt9aIxdxxSiKSc/aMekifVMJUmXOPJkIyY7Yo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290342; c=relaxed/simple;
	bh=bHKg8688KxIbIu3scsuk8kYDaEqkgSWMViJ2vaTFUT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UitNKyDOyyVBeLvmfDjVOy8SGvYVXI1WatA2SkR9bGvaD9+eDQ7JdIDBdy0w3cx51tJe+18jrOufEwZEAsh1c16nohUBx70MTwa269p0Je73i1oVpqvVuPzjnm1tAoGMkxCN7MvBqFn4BdYRWouYoRy92WuKHyuke/GmnHS2O7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az36a0rc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29845b06dd2so17848035ad.2
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290338; x=1764895138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtuDHKEV5UkQRRA9Aqhc0gyimLn41C2SrbraOXqSNvo=;
        b=Az36a0rci1of/3yt2kQNOdSnNSjwaHxcLHrbz0kMXF4L8l7yU3UkgWDSrhTNYJT9vW
         e92GcmAtxPbZlMDQt5EwyBPzJAb3rQLME15/7sWozOJpSmz3/xqrmO0wvkieISpBPVta
         MNUilHGlsuPHYIuDaTyltWl48g/4wjEKgfoiVRdC8n5ZIBnvt2y9Pj9UXhi2ir3qjSap
         lZynDASfxbOe3YyuwLAYWsvKMYzaA/7Ln1hT5B1zyQKP5ucqT8aEwX2/Twi1+o5pRssp
         8rcDljoEUsMEQedqrwCIfzRh/b9dpzCPkvonznBDWOWC6KQzUVgQ8E8oeYtWoNHENQ+2
         IzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290338; x=1764895138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtuDHKEV5UkQRRA9Aqhc0gyimLn41C2SrbraOXqSNvo=;
        b=lK44QBKrLKBMuXOT8ITDn3LUrLSks9P8n5PohifOmC/4rNZVA98mLUBgtN6DyX4ygx
         tpY9bMR0pek2RDBsEz6h/57dbcOwfJqCWsKjNCJMoNZ3GqFRDChjbSAAVtdaU1+8qtVy
         nHG/hAv4w9KaKpF5gmg6+lMjQTmmvHNyY1AJmVcj8tVavLPAlHwD2WvG2vFGE26U4nq3
         QgfEcOkjhoxTCk+0sQFTNY6gM4Q2lKUFcTXZoF8JALfQQ3PgSB+5koioy4SU9TAZgZOx
         9vOtEQptJL8kqqSJS9jxtc6vq+VStiC4FYSSiA9/UXDrdVPw/plu9dhUbXciVSYLFk/5
         dk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/lW/JjujecMy3rcod6ChRBrM14+lAx6xKCReGbD1hdREB/wXWX6DHOz270i0n5IBU6DkfozxPn1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8F+UBVjbWO2Q3lVxc9zTHIeYkZYTPNgrRjKHGnFOG3LO2rdZ
	d5xqWxtlPHSB0RDFk3/H8kwb+50EOUl+TBde0aLWg0jdIm4FyL8h+AGM
X-Gm-Gg: ASbGncshe1I3WC7tmh8gJ35w7e3eda3/kU91DrO+J5XXgbxLzovlAyFKfgRIeWbg8tw
	BnieGbWHWbtPuRY2A8JBSWNxLQSFniIIljK8+D84UVE2b02b9GJUfqOqu0V6atPH+fYtZNI//Mo
	Ovkpfb0hPwVOc4ZRnhDzr+WOGnVkJ8sCEf0Cp56ZvVJv2KkpkWU54vlYSq6f5OUo43Vloy+Jela
	gCJUXuT0gbj21xojGKB+XMln3kbgHCAhFhrWuJWjKwvv8/4GmZvKTpzFuNu+qUcV7Q8ObbXIb1G
	PJgV2CnCNyTxYdlwrwJTbVESa0yTrGtJzrVH5Dl76klY88rZiy9Jn4SJBY3SZkcQktk/ctB7b7l
	JvlKfQ1KKIDKFmdVw/BbclgNsck9a5mChmnq1FrCN0zdEkKt3AfVEz08qpYFurIUAvtkf6QBSBk
	MTfcgDq8hylOiLu0KU4H4ExB9gfLnHRCXlWZ2ofF86O9Q=
X-Google-Smtp-Source: AGHT+IHW+tPiN6CDXpO3aHyqH6Qyx9O/PsctZJUF41D9BYde7hvpZJ7PwzIliFHdrWa9qV7RDFbo2w==
X-Received: by 2002:a05:7022:a92:b0:11b:1cae:a0fa with SMTP id a92af1059eb24-11c9d55469dmr21786825c88.0.1764290337952;
        Thu, 27 Nov 2025 16:38:57 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:38:57 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 3/9] pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for register fields
Date: Thu, 27 Nov 2025 21:36:28 -0300
Message-ID: <20251128003634.247529-4-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the TIEHRPWM TBCTL, AQCTL, AQSFRC and AQCSFRC field definitions
to use GENMASK() and FIELD_PREP() instead of open-coded bit masks and
shifted literals.

This makes the eHRPWM register layout more explicit, reduces hand-rolled
bit arithmetic and aligns the driver with common kernel bitfield
patterns.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 88 ++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index f8625394c056..0802f0553587 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /* EHRPWM registers and bits definitions */
 
@@ -21,15 +22,16 @@
 #define TIEHRPWM_TBPRD				0x0A
 
 #define TIEHRPWM_TBCTL_PRDLD			BIT(3)
-#define TIEHRPWM_TBCTL_PRDLD_SHDW		0
-#define TIEHRPWM_TBCTL_PRDLD_IMDT		BIT(3)
-#define TIEHRPWM_TBCTL_CLKDIV_MASK		(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
-						BIT(8) | BIT(7))
-#define TIEHRPWM_TBCTL_CTRMODE_MASK		(BIT(1) | BIT(0))
-#define TIEHRPWM_TBCTL_CTRMODE_UP		0
-#define TIEHRPWM_TBCTL_CTRMODE_DOWN		BIT(0)
-#define TIEHRPWM_TBCTL_CTRMODE_UPDOWN		BIT(1)
-#define TIEHRPWM_TBCTL_CTRMODE_FREEZE		(BIT(1) | BIT(0))
+#define TIEHRPWM_TBCTL_PRDLD_SHDW		FIELD_PREP(TIEHRPWM_TBCTL_PRDLD, 0)
+#define TIEHRPWM_TBCTL_PRDLD_IMDT		FIELD_PREP(TIEHRPWM_TBCTL_PRDLD, 1)
+
+#define TIEHRPWM_TBCTL_CLKDIV_MASK		GENMASK(12, 7)
+
+#define TIEHRPWM_TBCTL_CTRMODE_MASK		GENMASK(1, 0)
+#define TIEHRPWM_TBCTL_CTRMODE_UP		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 0)
+#define TIEHRPWM_TBCTL_CTRMODE_DOWN		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 1)
+#define TIEHRPWM_TBCTL_CTRMODE_UPDOWN		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 2)
+#define TIEHRPWM_TBCTL_CTRMODE_FREEZE		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 3)
 
 #define TIEHRPWM_TBCTL_HSPCLKDIV_SHIFT		7
 #define TIEHRPWM_TBCTL_CLKDIV_SHIFT		10
@@ -48,22 +50,25 @@
 #define TIEHRPWM_AQSFRC				0x1A
 #define TIEHRPWM_AQCSFRC			0x1C
 
-#define TIEHRPWM_AQCTL_CBU_MASK			(BIT(9) | BIT(8))
-#define TIEHRPWM_AQCTL_CBU_FRCLOW		BIT(8)
-#define TIEHRPWM_AQCTL_CBU_FRCHIGH		BIT(9)
-#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		(BIT(9) | BIT(8))
-#define TIEHRPWM_AQCTL_CAU_MASK			(BIT(5) | BIT(4))
-#define TIEHRPWM_AQCTL_CAU_FRCLOW		BIT(4)
-#define TIEHRPWM_AQCTL_CAU_FRCHIGH		BIT(5)
-#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		(BIT(5) | BIT(4))
-#define TIEHRPWM_AQCTL_PRD_MASK			(BIT(3) | BIT(2))
-#define TIEHRPWM_AQCTL_PRD_FRCLOW		BIT(2)
-#define TIEHRPWM_AQCTL_PRD_FRCHIGH		BIT(3)
-#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		(BIT(3) | BIT(2))
-#define TIEHRPWM_AQCTL_ZRO_MASK			(BIT(1) | BIT(0))
-#define TIEHRPWM_AQCTL_ZRO_FRCLOW		BIT(0)
-#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		BIT(1)
-#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		(BIT(1) | BIT(0))
+#define TIEHRPWM_AQCTL_CBU_MASK			GENMASK(9, 8)
+#define TIEHRPWM_AQCTL_CBU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 1)
+#define TIEHRPWM_AQCTL_CBU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 2)
+#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 3)
+
+#define TIEHRPWM_AQCTL_CAU_MASK			GENMASK(5, 4)
+#define TIEHRPWM_AQCTL_CAU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 1)
+#define TIEHRPWM_AQCTL_CAU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 2)
+#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 3)
+
+#define TIEHRPWM_AQCTL_PRD_MASK			GENMASK(3, 2)
+#define TIEHRPWM_AQCTL_PRD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 1)
+#define TIEHRPWM_AQCTL_PRD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 2)
+#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 3)
+
+#define TIEHRPWM_AQCTL_ZRO_MASK			GENMASK(1, 0)
+#define TIEHRPWM_AQCTL_ZRO_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 1)
+#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 2)
+#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 3)
 
 #define TIEHRPWM_AQCTL_CHANA_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
 						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
@@ -74,22 +79,23 @@
 #define TIEHRPWM_AQCTL_CHANB_POLINVERSED	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
 						TIEHRPWM_AQCTL_ZRO_FRCLOW)
 
-#define TIEHRPWM_AQSFRC_RLDCSF_MASK		(BIT(7) | BIT(6))
-#define TIEHRPWM_AQSFRC_RLDCSF_ZRO		0
-#define TIEHRPWM_AQSFRC_RLDCSF_PRD		BIT(6)
-#define TIEHRPWM_AQSFRC_RLDCSF_ZROPRD		BIT(7)
-#define TIEHRPWM_AQSFRC_RLDCSF_IMDT		(BIT(7) | BIT(6))
-
-#define TIEHRPWM_AQCSFRC_CSFB_MASK		(BIT(3) | BIT(2))
-#define TIEHRPWM_AQCSFRC_CSFB_FRCDIS		0
-#define TIEHRPWM_AQCSFRC_CSFB_FRCLOW		BIT(2)
-#define TIEHRPWM_AQCSFRC_CSFB_FRCHIGH		BIT(3)
-#define TIEHRPWM_AQCSFRC_CSFB_DISSWFRC		(BIT(3) | BIT(2))
-#define TIEHRPWM_AQCSFRC_CSFA_MASK		(BIT(1) | BIT(0))
-#define TIEHRPWM_AQCSFRC_CSFA_FRCDIS		0
-#define TIEHRPWM_AQCSFRC_CSFA_FRCLOW		BIT(0)
-#define TIEHRPWM_AQCSFRC_CSFA_FRCHIGH		BIT(1)
-#define TIEHRPWM_AQCSFRC_CSFA_DISSWFRC		(BIT(1) | BIT(0))
+#define TIEHRPWM_AQSFRC_RLDCSF_MASK		GENMASK(7, 6)
+#define TIEHRPWM_AQSFRC_RLDCSF_ZRO		FIELD_PREP(TIEHRPWM_AQSFRC_RLDCSF_MASK, 0)
+#define TIEHRPWM_AQSFRC_RLDCSF_PRD		FIELD_PREP(TIEHRPWM_AQSFRC_RLDCSF_MASK, 1)
+#define TIEHRPWM_AQSFRC_RLDCSF_ZROPRD		FIELD_PREP(TIEHRPWM_AQSFRC_RLDCSF_MASK, 2)
+#define TIEHRPWM_AQSFRC_RLDCSF_IMDT		FIELD_PREP(TIEHRPWM_AQSFRC_RLDCSF_MASK, 3)
+
+#define TIEHRPWM_AQCSFRC_CSFB_MASK		GENMASK(3, 2)
+#define TIEHRPWM_AQCSFRC_CSFB_FRCDIS		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFB_MASK, 0)
+#define TIEHRPWM_AQCSFRC_CSFB_FRCLOW		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFB_MASK, 1)
+#define TIEHRPWM_AQCSFRC_CSFB_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFB_MASK, 2)
+#define TIEHRPWM_AQCSFRC_CSFB_DISSWFRC		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFB_MASK, 3)
+
+#define TIEHRPWM_AQCSFRC_CSFA_MASK		GENMASK(1, 0)
+#define TIEHRPWM_AQCSFRC_CSFA_FRCDIS		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFA_MASK, 0)
+#define TIEHRPWM_AQCSFRC_CSFA_FRCLOW		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFA_MASK, 1)
+#define TIEHRPWM_AQCSFRC_CSFA_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFA_MASK, 2)
+#define TIEHRPWM_AQCSFRC_CSFA_DISSWFRC		FIELD_PREP(TIEHRPWM_AQCSFRC_CSFA_MASK, 3)
 
 #define TIEHRPWM_NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
-- 
2.43.0


