Return-Path: <linux-pwm+bounces-7135-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E469EB30DA2
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A235720EEC
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE385202F65;
	Fri, 22 Aug 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB2sUdIa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D601632C8;
	Fri, 22 Aug 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755837665; cv=none; b=t70KrftW0bZlxwZkmXgJhyJoLhDtkQU6EhNMDOrby5xy5AhqaO07Ybx6hn/+i5QSjLxaFyQXj8cwXxMZRpG0c0xHXxAJXkP1lR3zUmPNOHlbBO3SglBPbSMaPRi92GjLiLAEkXEmfji42ncnSk09EAWLHifelwBUZ7CWGHeDhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755837665; c=relaxed/simple;
	bh=YoNI14l4Pdh+YRSuyQWbVgI02qatT3/eqjY1FatTLoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8Ya4PGf0YR/nUNgD6b4m2sTFFnNRGdh7r2/O2q4gyb47Io2kDdr/GPSpRYYeLxY0EPHl+vriP47o6TxyRENnEHs8+UIQnd8XiIdwguHPpPSxbCssXSajmZykkVbGoXo2ws2/ZHGXd4Os9IHgN88cFBUSZ3sFTabN0uxb7vCj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB2sUdIa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77033293ed8so154325b3a.0;
        Thu, 21 Aug 2025 21:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755837663; x=1756442463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=My8Ks7gUTzOXnQc6ajINQ2+Ev12LbWYBE5VaS2JEDTg=;
        b=XB2sUdIatTnuGwylF+7o9xzMSvTPGiPsnrPmp0UVf9fE9COj6LMDVXn5ntJoamCaUG
         jYuffUvbsv+8kc7dqK61NmO+f6UAvkyUGdzpiZTg8+xjLBWBYdCMWajS+omVmYIW28f2
         DFsUkA1uOI45O+A3yPTt0ePa9aakFIIX0uNZR7Bonh5SPKXHLyFxldJpCxdRwtUCWftH
         bS1rL48unT0v4vRmgjDw3sowJE43qj2XCPaSWUtck9d3ZqUIKL3lln2hKAYiSxzCX6/H
         ILJYBw6In/IHp8/5SrHF27y0JM7Sp8lr3pISSOfz7rjGKdpabZfxpB0SrxGSd5nB3fv+
         qH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755837663; x=1756442463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My8Ks7gUTzOXnQc6ajINQ2+Ev12LbWYBE5VaS2JEDTg=;
        b=GL7wvyL+4xxdQwq+Fpai0Lsa5ZIHlhJbgAbFGs9eZVLugISQ2KHwLNqxfWaAP03WyK
         vJkNbwJl51AXrSHKjO4j+b5Yl704Na5yN1LnHpUzY2v4qdAuPOd7fL3xLkvJs9POcdRz
         CZWIjzTWdtJn2Qirhc2FprK68iQI3JgZn5qt+K4DBQp3LZd+k1txSnkuyNGGjGHTogdH
         hKlzWEgNp9k3XwoOZ/MATg6lfJUkUhqxgXVzoAFLgYxhPmAgG+9lRjuPq9cIsKWwPu2G
         edvENfX2sQndF2G9iEaseS07xBaJIp8N2VW46Q9F8ek6zYnyDr5kuWPSTx8vzJmxkss4
         479w==
X-Forwarded-Encrypted: i=1; AJvYcCVRk166xc6ma1En2dpVkBh8G5uIf85IYRO51/VTjtVbgkq5jfgKjlLMmkbZ2ktFQbd1tv2oD7omEgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAG3nEBU2graeN37gP76L6J9cFmfg06+nYwvHUuI8HHOZBvcfy
	+mV9CPhxAJj4FwpcJX5h7B2kUI5CdC2ld78M3Wo/LGTCUHesITCmFdfXLkzDY7WZ
X-Gm-Gg: ASbGncugzZNYrY9P3ADpNLcT4TH0GK6HR1+fcbLoBwAWOpv6PQoOExffRC0SPzpla/E
	EX4lA4f19oaVqBoBX0eOSXziKuNni7O+LIZ7oWbXCt+Q/dOzQPlwCc/fblddP1Wwyt2VYLLJ43t
	0ZRXZH+XhB2A0A3ny+wwbdSDEzOGfRy1IcBWWe3vjOY9Zp9XB68IXjh38eJXzYbbRWq6JibNQwL
	18BLVqER3HgqFnHVTjsIhlVvebdXX+avtuo1fjwzDthp+lf1vwVkQ24lZMxMtf9hv5Jsz+vBHNT
	2kg+6CdoCaJh8gICxTXKM7YBq5rUZHOwkvTjTn7w2ZV9Unf6VdVI1KZHWL5NeykBOAos9GHXvRg
	OUSoe7POcYK9hc+B8YNqTEyQ1v808fXRKh8D5h4SPVOonJj0=
X-Google-Smtp-Source: AGHT+IFIcXTgeMtT+s2zeBPLrgh+h43qlKfvloKnc2ak7VVQIomAtG5rZ7k6GRTDcw1u3Q7kC/eoRw==
X-Received: by 2002:a05:6a20:914f:b0:23d:491b:76a6 with SMTP id adf61e73a8af0-24340bfc08dmr2662224637.20.1755837663193;
        Thu, 21 Aug 2025 21:41:03 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fba7fcsm6039513a12.10.2025.08.21.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:41:02 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for register fields
Date: Fri, 22 Aug 2025 01:40:24 -0300
Message-ID: <20250822044024.4015-1-rafael.v.volkmer@gmail.com>
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


