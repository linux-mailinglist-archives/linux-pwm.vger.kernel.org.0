Return-Path: <linux-pwm+bounces-7681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF82C7E9A3
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22C694E069C
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C225F995;
	Sun, 23 Nov 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXabEfib"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BE22A4F1
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940612; cv=none; b=RiyksZeXjje1UKT13G4msgaT28ny8yOeaue7Dujmrg+YrM/oIsMTesCkSfIBz3WRgtZLglkhhphjAjJgH336MMuFrESktDdJtkvDUvjtCYA2zM5zRHBPtLXbYMiNIj4yHNd6cTYgb1Q22rdRVhbIhxT0T3LNLUuLReCAYKxj2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940612; c=relaxed/simple;
	bh=MipsAsTQzxJO6Ync3ipzwIn1eC0ugDdjmRNlTaB9e+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSF8icnSYWsfUC8BIjLybgzZGji8PcshVNqmRrL3cgh1Y46dQWOApaDaJKAdWNpeevrb6x7/FARK3vjbIyQBkUpr7EbbrZN18xovZQvo785eP3ZEAEVANMtGl+vm8CUOXjSfxqWN8wBDhegWSDHsy6L+R2dChczbPMIYan0Wb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXabEfib; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so2435144a12.2
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940611; x=1764545411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG81t4oIZprWG+Es5egfXdkwrsUqCfSFiFIMOVaDLxI=;
        b=OXabEfibT5ya1hLuRPb14+rFxM81gJHgpisIi/edSHy9xGh9sIkTr3JEYQhi673zAm
         iB7IEoUmZcfvLBvQWs4s+QuUUCWVciJ4COUUt7TSVtbD4JPGqrgZD2Xy1n8f9lGWsyqk
         XTRS7uVBJO1nGuveaBUVeYv4CBFO51/37rj8cpVIBMkeNGh0+lzja/aVnNQjRo77IkMb
         R9h0u/QmhIAruTEsQJq4hiNrpjp82Yd0xFPhjZ48taG9Dho5LgmeLxiWtCePzbJ7vz2V
         HA5FK5uz1pud46mo9NpZ7EopieVAi4Y+0EWexfQNJPa7NYOrMSrBYZPSZm1+AZ6zbXyw
         GbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940611; x=1764545411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG81t4oIZprWG+Es5egfXdkwrsUqCfSFiFIMOVaDLxI=;
        b=RzwX4M5SUV0RqfCIbUHSOeCN9MeBeEE75FPlPF9PlATRBDU7ud36fZF2PLAzTJYxYU
         YS+KzLg6AlPwEthvBS8HMQLuBPLe3NjUOfJgEOtWajoaSlgCt0uLeN2KnVniN6RBEN+E
         mxG/P83DRPiKKEV+xXdwCUEVym8a03b6TXvW6oz7HBgjlejJLX7dpTfm365+LefRa5Cv
         37214/D+enfx7AGBs7jPPk02vFHQa5nVDdTXxPMXEk3QFsThlShb6vzxbkJVpRmLeDEf
         Q9gq7Fc1RkTuYrZ17/2Bdr+wOSRa0S4Cln94v03fLFWhTXlv35zVM2NOkoe4gOOmYb5H
         Frjg==
X-Forwarded-Encrypted: i=1; AJvYcCX8RPWgKRC/sdg3aG4OJ9QHd1BBLGS7I6/y1OhRxOH+HljvIlaqJAomup4DVT30uD6jROMQtuINWhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka2mjJVmWPuTqYzgzLPxDsowmAcSP6fI3HOv5NChok+K1mD+4
	rXnB5qrRoilMBEBPcF4cH4J6O4FVnyR1I3Zc7Vwqwr8fE3cMnx/CloH5
X-Gm-Gg: ASbGncvE/ThrtnDtsTu7ajZbPQQfySdbKHIipMAhi5vn1VFHBJxBZPDj+PbJOvkjaDH
	2BIZxS4PXxUvCCPzO2tiicss8YQeJy7j+PXxDFlu0GPCa22os+PBuyOEq4cfrwOsHV4bDJ6flRU
	/m31nEZafWpPUcJj+BDVA9RNt7kT6acVk8Of8AqXXVIrj0A4BZpvu/nWfnxr4RqmTsR4qYNaLMf
	NWAn1Ler3eSMEFEWGaynw3idJaO/Ds7eevTA6NNC+6JI2/0KrS54tLhUhcPN149zNCp7ijgrMUv
	vg4ZH0YmfKdfzsVHoGhqQLZujt2QyeGjzpzafw6OTwYf+MWsecjL1Pm3Q93twb3ikEkp0BXo+Th
	aWeMV1Nmf0D5vs6R+OjMcVjq4Z2nIoWIUarQoAC48J6u2kPuYmpS44FE396bOpUCiq0U59ouLxQ
	iQLVU4Sdn1uECCmdHivfKeoOAlF5UljiYtD2h4NcR4mK8=
X-Google-Smtp-Source: AGHT+IFitZVQdlux2DhTALzZbVaimN8azhcT8GlsrriNQVIxtXWimsFQYCkI2AAu2BP32ad2wCBLQA==
X-Received: by 2002:a05:7300:cd97:b0:2a4:5005:7ee1 with SMTP id 5a478bee46e88-2a7192eb028mr5463312eec.37.1763940609686;
        Sun, 23 Nov 2025 15:30:09 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc4f6671sm59290336eec.3.2025.11.23.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:30:09 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v6 3/6] pwm: tiehrpwm: refactor AQCTL polarity macros
Date: Sun, 23 Nov 2025 20:29:47 -0300
Message-ID: <20251123232947.2085-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123232748.2057-1-rafael.v.volkmer@gmail.com>
References: <20251123232748.2057-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the AQCTL polarity macros so that the selected channel and
count direction are explicit in the name (CHA/CHB and UP/DN).  Keep the
existing up-count behaviour and introduce matching down-count variants
for the CAD/CBD events.

Centralize the action values (FRCLOW/FRCHIGH/FRCTOGGLE) as generic
AQCTL_* enums and use FIELD_PREP() with the corresponding *_MASK for all
events (CAU/CBU/CAD/CBD/ZRO).  This reduces duplication and makes the
AQCTL programming more self-documenting.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 59 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 1ad8577139be..9f1be35912d3 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -50,30 +50,49 @@
 #define AQSFRC			0x1A
 #define AQCSFRC			0x1C
 
+#define AQCTL_FRCLOW		1
+#define AQCTL_FRCHIGH		2
+#define AQCTL_FRCTOGGLE		3
+
+#define AQCTL_CBD_MASK		GENMASK(11, 10)
+#define AQCTL_CBD_FRCLOW	FIELD_PREP(AQCTL_CBD_MASK, AQCTL_FRCLOW)
+#define AQCTL_CBD_FRCHIGH	FIELD_PREP(AQCTL_CBD_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CBD_FRCTOGGLE	FIELD_PREP(AQCTL_CBD_MASK, AQCTL_FRCTOGGLE)
+
 #define AQCTL_CBU_MASK		GENMASK(9, 8)
-#define AQCTL_CBU_FRCLOW	FIELD_PREP(AQCTL_CBU_MASK, 1)
-#define AQCTL_CBU_FRCHIGH	FIELD_PREP(AQCTL_CBU_MASK, 2)
-#define AQCTL_CBU_FRCTOGGLE	FIELD_PREP(AQCTL_CBU_MASK, 3)
+#define AQCTL_CBU_FRCLOW	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCLOW)
+#define AQCTL_CBU_FRCHIGH	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CBU_FRCTOGGLE	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCTOGGLE)
+
+#define AQCTL_CAD_MASK		GENMASK(7, 6)
+#define AQCTL_CAD_FRCLOW	FIELD_PREP(AQCTL_CAD_MASK, AQCTL_FRCLOW)
+#define AQCTL_CAD_FRCHIGH	FIELD_PREP(AQCTL_CAD_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CAD_FRCTOGGLE	FIELD_PREP(AQCTL_CAD_MASK, AQCTL_FRCTOGGLE)
 
 #define AQCTL_CAU_MASK		GENMASK(5, 4)
-#define AQCTL_CAU_FRCLOW	FIELD_PREP(AQCTL_CAU_MASK, 1)
-#define AQCTL_CAU_FRCHIGH	FIELD_PREP(AQCTL_CAU_MASK, 2)
-#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, 3)
+#define AQCTL_CAU_FRCLOW	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCLOW)
+#define AQCTL_CAU_FRCHIGH	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCTOGGLE)
 
 #define AQCTL_PRD_MASK		GENMASK(3, 2)
-#define AQCTL_PRD_FRCLOW	FIELD_PREP(AQCTL_PRD_MASK, 1)
-#define AQCTL_PRD_FRCHIGH	FIELD_PREP(AQCTL_PRD_MASK, 2)
-#define AQCTL_PRD_FRCTOGGLE	FIELD_PREP(AQCTL_PRD_MASK, 3)
+#define AQCTL_PRD_FRCLOW	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCLOW)
+#define AQCTL_PRD_FRCHIGH	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCHIGH)
+#define AQCTL_PRD_FRCTOGGLE	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCTOGGLE)
 
 #define AQCTL_ZRO_MASK		GENMASK(1, 0)
-#define AQCTL_ZRO_FRCLOW	FIELD_PREP(AQCTL_ZRO_MASK, 1)
-#define AQCTL_ZRO_FRCHIGH	FIELD_PREP(AQCTL_ZRO_MASK, 2)
-#define AQCTL_ZRO_FRCTOGGLE	FIELD_PREP(AQCTL_ZRO_MASK, 3)
+#define AQCTL_ZRO_FRCLOW	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCLOW)
+#define AQCTL_ZRO_FRCHIGH	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCHIGH)
+#define AQCTL_ZRO_FRCTOGGLE	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCTOGGLE)
+
+#define AQCTL_CHA_UP_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHA_UP_POLINVERSE	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHB_UP_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHB_UP_POLINVERSE	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
 
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHA_DN_POLNORMAL     (AQCTL_CAD_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHA_DN_POLINVERSE    (AQCTL_CAD_FRCHIGH | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHB_DN_POLNORMAL     (AQCTL_CBD_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHB_DN_POLINVERSE    (AQCTL_CBD_FRCHIGH | AQCTL_ZRO_FRCLOW)
 
 #define AQSFRC_RLDCSF_MASK	GENMASK(7, 6)
 #define AQSFRC_RLDCSF_ZRO	FIELD_PREP(AQSFRC_RLDCSF_MASK, 0)
@@ -256,9 +275,9 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		aqctl_mask = AQCTL_CBU_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANB_POLINVERSED;
+			aqctl_val = AQCTL_CHB_UP_POLINVERSE;
 		else
-			aqctl_val = AQCTL_CHANB_POLNORMAL;
+			aqctl_val = AQCTL_CHB_UP_POLNORMAL;
 
 		/* if duty_cycle is big, don't toggle on CBU */
 		if (duty_cycles > period_cycles)
@@ -272,9 +291,9 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		aqctl_mask = AQCTL_CAU_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANA_POLINVERSED;
+			aqctl_val = AQCTL_CHA_UP_POLINVERSE;
 		else
-			aqctl_val = AQCTL_CHANA_POLNORMAL;
+			aqctl_val = AQCTL_CHA_UP_POLNORMAL;
 
 		/* if duty_cycle is big, don't toggle on CAU */
 		if (duty_cycles > period_cycles)
-- 
2.43.0


