Return-Path: <linux-pwm+bounces-7715-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84CC90720
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7091C34FA97
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D623D7FB;
	Fri, 28 Nov 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0bPtEwe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A211E1E04
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290353; cv=none; b=V9/Ndy1T1e6FxFFKe6GC1RxITup5aYB5WvGqTOwxP8uvtKnnJAtco0AWtI0YL0kS64xzDftSzsXcSqzdxOlzhZD9tSQkKoDfHQVViLRhYtIToA68OuBwglETDTFXBVcgx2OJBy0ItlmZsNsbFl9HM3BxthOf0CgrV0qVAGyP6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290353; c=relaxed/simple;
	bh=jMQWy/uoMi5gk0Fuuj5o1OZTmHNchVC5fkgfkjv6DRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp/Bh2VXxob5rsxDFcgArsD/KOI7msp6niqKjNK/idnpw1uPoKPBJLPawaBeS+V7xh6ajXxBfsi7/A2MSz0PrvrGUkF0POUyEzjtocZMtEsfZjFOSRwyYnnUUhPrGtVHBdOJavqk5TNSWhPUf2+Hyt6ukCn2w0SuAA0ZBUAtgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0bPtEwe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297dc3e299bso12489845ad.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290350; x=1764895150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U44lFnDmE4vFYbkkjAO/tncL6KLsRdfshc4d/agkXQ=;
        b=C0bPtEwe4THX+AER9vSLsbM5/Q2pcROs5ZTom2xx8MTK+zOG9WTkFqfiv0YHnBfndn
         Q0I1jm53NyNl7e5zmNPfGrqRtCgPtE56kczzgK9odmM//lzDq9AXqOEkvCU27brqfE1E
         HAMAd1bUmlME3qPzDHIaF4xFOMnSiHdbL9PBNxYftZdHtPvRMDG5WpkErEzXxkvKZFv1
         bixDpZxvFtXV6xj+bI2LxbqnDkepIEpACe9b/VeDGt45sIKi4jv84K6bSrgxqc/z5qRz
         dY9nRDwyXVEwZ654VrLi16NagQdH0j8nDLGQ5mIIqSz+ZDEYsTBcmw+Jd3EuCoFnjSnj
         4n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290350; x=1764895150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5U44lFnDmE4vFYbkkjAO/tncL6KLsRdfshc4d/agkXQ=;
        b=FGwf2bOuFqCBS6uZ34CIfqVzzlFaDk9qmmV2HlJDQA6D8OJ9gVruoArYcBza+Ih25z
         djA7epFftcqMviBp2+wvKDXuurUCVYHUYABzD5Cb0GkajIAL0Zf9jyP6VImK/XrWEQZ6
         b5tUZXemcNO8nMmcTgW1befBlR10FOLxZzqiHTPoauSmq71smyRURFaHvQBT25MPwmSt
         Ystig4bQhIs141R/1F7JSjeXjeSBcmZrvzdJkcCmaZVduyrrilEvtTKs/887GXDY6cwC
         EVvh5HBv9Xu0/xaaHtiNiWVQg7xbqaQT1xxhqKVVwdOEsbRwAOMk927ImWKlN3pfnVsG
         coUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hbD/GzLBK6mo2iTOvxq1PJF7QVXbMsJRxejasw8pKzvu/rA/H/EZ1FfEHumoxOpP+/fxWbCqPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHzRBpMEN5QqmMA04GNOhCRKx9N2GMqTgFWZDufPdFJnlyOWX
	9MXt2X9SJpkYq+rmd4Vxn2iAaNEhK5j2cGrX2kiyD1K/qCDd9jGz70bl
X-Gm-Gg: ASbGncshGljS5wmWOl6PNaav7LIQipOQV5CmVHiuHt5PR4mJoyjdRkkZwI559QvKTkf
	K2Nf8fwT7K1+QuyJFyMpEvxijtS4M8pr8PB6MNEdBiCkR+M3BhpokdMTKme+0vmKz2hUR0QAbA+
	n1rS1eKlhejbdPqqF4OC9hqniJrg1vCbkTgOF2i/4PmigLdJJW2lxIsdpbuTjvLg5sQfa8PpcdK
	HBdzVdJswO2E4NV+kbU85IzGoJUN6U4kcRqES+9puYAD2A4iPRsO9t2lXIFB+FUv5I8OmPgjl0b
	zsyy3kf6EpNrz9F13G3sS99rD+MNCItqxA77nCM3h425hkredDZJbBXVsR/uu2W24Xm2zTLHnmB
	2vmJeM0oJiSdwXYoLfe5zWoZJQSF1rH3nLx8XFop5l7LuQ0uNusCyhl+o7vobgBLj1F4gl0zOcp
	WxR3CME44wxUtfSodEMFADF1YlrM2/TLsu0/kJA5y6pHg=
X-Google-Smtp-Source: AGHT+IFJVpv4S+PHsUZO0fZd7u3RtQA0sRNwlQPG0GCPdVN8O/JDq9hwMIyv++I8qyB12qVOpU0ONA==
X-Received: by 2002:a05:7022:41a3:b0:119:e56b:98b3 with SMTP id a92af1059eb24-11cbba47b1dmr9942938c88.26.1764290349634;
        Thu, 27 Nov 2025 16:39:09 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:39:09 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 6/9] pwm: tiehrpwm: factor out AQ force codes and polarity presets
Date: Thu, 27 Nov 2025 21:36:31 -0300
Message-ID: <20251128003634.247529-7-rafael.v.volkmer@gmail.com>
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

Introduce named constants for the Action-Qualifier force action codes
and use them to build the CAU/CAD/CBU/CBD/PRD/ZRO bitfield helpers
instead of repeating hard-coded numeric values in each field.

While at it, split the channel polarity presets into explicit up-count
and down-count variants for both channels. This keeps the resulting
AQCTL programming unchanged but makes the configuration easier to read
and extend.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 85 +++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 41af1bf74cbb..e8bcf1ffa770 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -52,33 +52,78 @@
 #define TIEHRPWM_AQSFRC				0x1A
 #define TIEHRPWM_AQCSFRC			0x1C
 
+/* Action-Qualifier force action codes (per 2-bit field) */
+#define TIEHRPWM_AQCTL_FRCLOW			0x1
+#define TIEHRPWM_AQCTL_FRCHIGH			0x2
+#define TIEHRPWM_AQCTL_FRCTOGGLE		0x3
+
+/* Action-Qualifier bitfields for compare/period/zero events */
 #define TIEHRPWM_AQCTL_CBU_MASK			GENMASK(9, 8)
-#define TIEHRPWM_AQCTL_CBU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 1)
-#define TIEHRPWM_AQCTL_CBU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 2)
-#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, 3)
+#define TIEHRPWM_AQCTL_CBU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, \
+						TIEHRPWM_AQCTL_FRCLOW)
+#define TIEHRPWM_AQCTL_CBU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, \
+						TIEHRPWM_AQCTL_FRCHIGH)
+#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBU_MASK, \
+						TIEHRPWM_AQCTL_FRCTOGGLE)
+
+#define TIEHRPWM_AQCTL_CBD_MASK			GENMASK(11, 10)
+#define TIEHRPWM_AQCTL_CBD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CBD_MASK, \
+						TIEHRPWM_AQCTL_FRCLOW)
+#define TIEHRPWM_AQCTL_CBD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CBD_MASK, \
+						TIEHRPWM_AQCTL_FRCHIGH)
+#define TIEHRPWM_AQCTL_CBD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CBD_MASK, \
+						TIEHRPWM_AQCTL_FRCTOGGLE)
 
 #define TIEHRPWM_AQCTL_CAU_MASK			GENMASK(5, 4)
-#define TIEHRPWM_AQCTL_CAU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 1)
-#define TIEHRPWM_AQCTL_CAU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 2)
-#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, 3)
+#define TIEHRPWM_AQCTL_CAU_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, \
+						TIEHRPWM_AQCTL_FRCLOW)
+#define TIEHRPWM_AQCTL_CAU_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, \
+						TIEHRPWM_AQCTL_FRCHIGH)
+#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAU_MASK, \
+						TIEHRPWM_AQCTL_FRCTOGGLE)
+
+#define TIEHRPWM_AQCTL_CAD_MASK			GENMASK(7, 6)
+#define TIEHRPWM_AQCTL_CAD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_CAD_MASK, \
+						TIEHRPWM_AQCTL_FRCLOW)
+#define TIEHRPWM_AQCTL_CAD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_CAD_MASK, \
+						TIEHRPWM_AQCTL_FRCHIGH)
+#define TIEHRPWM_AQCTL_CAD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_CAD_MASK, \
+						TIEHRPWM_AQCTL_FRCTOGGLE)
 
 #define TIEHRPWM_AQCTL_PRD_MASK			GENMASK(3, 2)
-#define TIEHRPWM_AQCTL_PRD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 1)
-#define TIEHRPWM_AQCTL_PRD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 2)
-#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, 3)
+#define TIEHRPWM_AQCTL_PRD_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, \
+						TIEHRPWM_AQCTL_FRCLOW)
+#define TIEHRPWM_AQCTL_PRD_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, \
+						TIEHRPWM_AQCTL_FRCHIGH)
+#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_PRD_MASK, \
+						TIEHRPWM_AQCTL_FRCTOGGLE)
 
 #define TIEHRPWM_AQCTL_ZRO_MASK			GENMASK(1, 0)
-#define TIEHRPWM_AQCTL_ZRO_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 1)
-#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 2)
-#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, 3)
+#define TIEHRPWM_AQCTL_ZRO_FRCLOW		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, \
+						TIEHRPWM_AQCTL_FRCLOW)
+#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, \
+						TIEHRPWM_AQCTL_FRCHIGH)
+#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		FIELD_PREP(TIEHRPWM_AQCTL_ZRO_MASK, \
+						TIEHRPWM_AQCTL_FRCTOGGLE)
+
+/* Action-Qualifier polarity presets for up-count mode */
+#define TIEHRPWM_AQCTL_CHA_UP_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
+						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
+#define TIEHRPWM_AQCTL_CHA_UP_POLINVERSE	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
+						TIEHRPWM_AQCTL_ZRO_FRCLOW)
+#define TIEHRPWM_AQCTL_CHB_UP_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
+						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
+#define TIEHRPWM_AQCTL_CHB_UP_POLINVERSE	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
+						TIEHRPWM_AQCTL_ZRO_FRCLOW)
 
-#define TIEHRPWM_AQCTL_CHANA_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
+/* Action-Qualifier polarity presets for down-count mode */
+#define TIEHRPWM_AQCTL_CHA_DN_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
 						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
-#define TIEHRPWM_AQCTL_CHANA_POLINVERSED	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
+#define TIEHRPWM_AQCTL_CHA_DN_POLINVERSE	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
 						TIEHRPWM_AQCTL_ZRO_FRCLOW)
-#define TIEHRPWM_AQCTL_CHANB_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
+#define TIEHRPWM_AQCTL_CHB_DN_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
 						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
-#define TIEHRPWM_AQCTL_CHANB_POLINVERSED	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
+#define TIEHRPWM_AQCTL_CHB_DN_POLINVERSE	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
 						TIEHRPWM_AQCTL_ZRO_FRCLOW)
 
 #define TIEHRPWM_AQSFRC_RLDCSF_MASK		GENMASK(7, 6)
@@ -262,9 +307,9 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		aqctl_mask = TIEHRPWM_AQCTL_CBU_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = TIEHRPWM_AQCTL_CHANB_POLINVERSED;
+			aqctl_val = TIEHRPWM_AQCTL_CHB_UP_POLINVERSE;
 		else
-			aqctl_val = TIEHRPWM_AQCTL_CHANB_POLNORMAL;
+			aqctl_val = TIEHRPWM_AQCTL_CHB_UP_POLNORMAL;
 
 		/* if duty_cycle is big, don't toggle on CBU */
 		if (duty_cycles > period_cycles)
@@ -278,9 +323,9 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		aqctl_mask = TIEHRPWM_AQCTL_CAU_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = TIEHRPWM_AQCTL_CHANA_POLINVERSED;
+			aqctl_val = TIEHRPWM_AQCTL_CHA_UP_POLINVERSE;
 		else
-			aqctl_val = TIEHRPWM_AQCTL_CHANA_POLNORMAL;
+			aqctl_val = TIEHRPWM_AQCTL_CHA_UP_POLNORMAL;
 
 		/* if duty_cycle is big, don't toggle on CAU */
 		if (duty_cycles > period_cycles)
-- 
2.43.0


