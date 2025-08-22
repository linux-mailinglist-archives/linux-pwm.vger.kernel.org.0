Return-Path: <linux-pwm+bounces-7137-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9EB30DAB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A91CC39EF
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371B718DF80;
	Fri, 22 Aug 2025 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJXnKGxx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8FD2FF;
	Fri, 22 Aug 2025 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755837996; cv=none; b=ny02EX20Bb2j14wtFoxYnK4Mkbnyx99eJYf+TWqKUX4O97Fz1eUZ4mXtVkrIOyw7NsnBVKMvsYWWR8qleCda1FgR3lM5DnrXbN8OBwFGcbMhPmiOhObeVNr1zjkuX2UWiU5WUf0SB9+WmXCxeSwQZXvhCIsHS86XU/Awf9hwTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755837996; c=relaxed/simple;
	bh=b9aMMPvmLQgbuq2JNGmttvZjR5dExpAdv/o6SvPOiwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBkHn7RMZ8p0NAP0OfexUGaf5nvhIGmh8xt0pS0D8tI/vkOXhjAB9D/eZxQ+DN/J+L4hwhaKu/qAWPcDS1YQrtIbwb8qMgjkbqJNFdjL2VxslbJaH2d8acLOm/vZpZZHAlGn+o7FuLzaHLemVHXrAA9d2ARY2qqpmC2+c5/LVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJXnKGxx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-244580523a0so15987135ad.1;
        Thu, 21 Aug 2025 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755837994; x=1756442794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGXZfqlqEnL4T4johyx1cAlB7h/K7CteJFlN6AoR984=;
        b=cJXnKGxxkXAeALeUOqMotPSo2/eDWe0/pMAr9pggk2rBXN+6RqJsztMjQ2cmyHIpNu
         Ghg+w0u9+va1hxADCOuV27v3QkIDwGvqG3/V/nblnbxBogryOeXGHSXMbDA/WE+eduwO
         32KLmPKCEBgQlqMY+TpOm1YCIbQUUXxsiT3U1qf8yXmOfzxc8Jr5l8wipFFYL5hXJG27
         DPcTe7DTagI2HqZSFbTXibsj06DVIf8yIDAxW4vb8ZuRWPQDHVAk+N8BgLMb5dly9U7r
         XXBy5LeNJ3mnQHZq++lAR3EBysmXDqzzOAyXhUN+A2WcswaHbjREy1IfAQErd2PKMQ/k
         Jc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755837994; x=1756442794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGXZfqlqEnL4T4johyx1cAlB7h/K7CteJFlN6AoR984=;
        b=AffEebQCYAVy2IrcwFHSsbif0FaekiCA1ij9oZYuGzSSGffYWy40v+vlOuRdYoiSdB
         B/hHYoiDsvmMokS5N1imyJOk1SixpC9wV7/gsEKssS6F3BzkWEbDyQaxjFexFDPc/zKy
         vUHASBRDDJASDmAiibL1MuWqKnRAE1z+aP4SdYipLlgluVTsXiQSbaG+CqyTpGQcQbSu
         qeqLoLyTLOvYduBRvn3LvntC2sPRjNtK1fIKsjRK/XxWFQvF84twUGh0Vtbwmw5jmI4u
         JNmhtNseY8dpZQijBj4brr1e7hX+FuAdRd3Je3ETjyNIhbraihWseTwQ2z1m7uwjw0FF
         BUDw==
X-Forwarded-Encrypted: i=1; AJvYcCWEP4dHIoPGKPRCFVOQhD489pDOf5E5pTpSkfcfJQ/0tQ0/tR9z6CWJ6m81mxbw9h3hYKdWhWPHAmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwocfrmDaRCbfybmLKoP9zoWPYEKLzZUxh6bNelKJYTAFwiFSQs
	icrY4wNSlMcHL1AIGAW6ZRg6QYAH2s7NMaK5WAPoKXYnfsSDF7dJKhtf
X-Gm-Gg: ASbGncvZf2bsresTH6gCQJFuFJEHTZPseqJwBatzaMuQoEwb23kdEJyeRtQlaNps+AX
	nhCD1HRSmjJgzdkmONlE4uqbZ/UR9AcWIPZJ2dxwfDGrPv0FILmB+pZZmGY5bIDu3Ifm5Lnf0QR
	m2l9jb7G2qLqthvo+g5dkI2/6g33TMLAR6RECxr6PgypGBgQhfKP57WRG2srbgXALry07TxYUGN
	/XeCUP33soapZ3daTeeNCYWyaFthofznyr5f9dluMNxksApDlWFYZDhrcu8Vi/gvxfvV87f/6lg
	LSDidDMkOBoVvFHAKFNZupOrQeeZI2CXZXCl6ybqphYdC88JHgWzHIfpCgCM+4fM6cB/G5p42Ep
	9oc8iYCO84kHLPdrj4xyY2lbmuAAXN6+89W92m0JBl9GJXos=
X-Google-Smtp-Source: AGHT+IE3iqrFCuTf+dKhRTc9zvOIttK5/vzVJ+NyVsd7k9AyaTnX3cMNgJZmLOrtNVouu6SY6j6e7w==
X-Received: by 2002:a17:902:f652:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-2462edc4493mr28888855ad.6.1755837993775;
        Thu, 21 Aug 2025 21:46:33 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed339c57sm70970605ad.33.2025.08.21.21.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:46:33 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v5 3/6] pwm: tiehrpwm: refactor AQCTL macros
Date: Fri, 22 Aug 2025 01:45:45 -0300
Message-ID: <20250822044545.4080-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822044308.4052-1-rafael.v.volkmer@gmail.com>
References: <20250822044308.4052-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor AQCTL polarity/action macros to make channel and count
direction explicit. Keep existing up-count names and add consistent
down-count variants for CAD/CBD events. Centralize action values
(LOW/HIGH/TOGGLE) and reuse them for both channels and directions.

This reduces duplication and makes action selection self-documenting.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 63 ++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index d140814a1..b2a55e59b 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -49,33 +49,56 @@
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
+#define AQCTL_CHA_UP_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
+				AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHA_UP_POLINVERSE	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
+				AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHB_UP_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
+				AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHB_UP_POLINVERSE	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
+				AQCTL_ZRO_FRCLOW)
 
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
+#define AQCTL_CHA_DN_POLNORMAL	(AQCTL_CAD_FRCLOW | AQCTL_PRD_FRCHIGH | \
 				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
+#define AQCTL_CHA_DN_POLINVERSE	(AQCTL_CAD_FRCHIGH | AQCTL_PRD_FRCLOW | \
 				AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
+#define AQCTL_CHB_DN_POLNORMAL	(AQCTL_CBD_FRCLOW | AQCTL_PRD_FRCHIGH | \
 				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
+#define AQCTL_CHB_DN_POLINVERSE	(AQCTL_CBD_FRCHIGH | AQCTL_PRD_FRCLOW | \
 				AQCTL_ZRO_FRCLOW)
 
 #define AQSFRC_RLDCSF_MASK	GENMASK(7, 6)
@@ -198,17 +221,17 @@ static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
 		aqctl_mask = AQCTL_CBU_MASK;
 
 		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANB_POLINVERSED;
+			aqctl_val = AQCTL_CHB_UP_POLINVERSE;
 		else
-			aqctl_val = AQCTL_CHANB_POLNORMAL;
+			aqctl_val = AQCTL_CHB_UP_POLNORMAL;
 	} else {
 		aqctl_reg = AQCTLA;
 		aqctl_mask = AQCTL_CAU_MASK;
 
 		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANA_POLINVERSED;
+			aqctl_val = AQCTL_CHA_UP_POLINVERSE;
 		else
-			aqctl_val = AQCTL_CHANA_POLNORMAL;
+			aqctl_val = AQCTL_CHA_UP_POLNORMAL;
 	}
 
 	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
-- 
2.43.0


