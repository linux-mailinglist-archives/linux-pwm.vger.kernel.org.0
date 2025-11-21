Return-Path: <linux-pwm+bounces-7655-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21CC7AC03
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EE95367088
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F67350A19;
	Fri, 21 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fShMtjHr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DA33A6E9
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741337; cv=none; b=T0L31O3iKYYiN5Rt2OC3D7UnJeuWBkL/4NA/8fGV7EPbbU25cqgs+IaPWwBWnXn0iRqjOfUsEQtKqAzfDqU6okLlxiddPpgPooREGwnRm49/S67LGC67AFeE8Tv2uM1JrF1bPaC7SZUgUbnxPJnRvCtdLRVUar+G6HdDX+XO2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741337; c=relaxed/simple;
	bh=SAs0PZaWPeFBSk4KcIri4avonMMoZK50murb/7C0qcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2knR8ahXn6K4ovEajm63ofYyvIkeUXjuFJ7DPxKpfk48w/mwCUuko/cLAtkgfevCbk+0h6tyTMdgoZs8E6slLaQ19ZeIIgTDN+F3tKuiHRi4XqMSwmfOAwZiYssrGka9calsgAmTLp0QsP83v1ZNhInnhh4C6d5xBKYl7JM44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fShMtjHr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47789cd2083so13689495e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741332; x=1764346132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9C+Ue8cMcG+njUQyZUQmHV/igv+sYiQ8hcgoRvKYA4=;
        b=fShMtjHrfXjYqGlQ0l4rhnQdzjLDBKi3che+sZ84/eAXcdXSehHk+fopV7YwAv7CwC
         90Z0+yU7fZVIULSBvyCQe9nINzY8mJ7prjNOBqx24/vQe5LzYJ9RjqgvReiPpWzkdeno
         4gMsy5VaNTZ3lUVzpiDxp6r60Yc1Z/f3Yf+6+fBAUfpqe1iXv4QHhPSNJ5YG/0DO4hCW
         F/3M1Vt1qUQVX/nMQCxDPd5DPXYWUsFOTjO2gZiQ/fMn1vLERSmsHGmkIbI30+tqhMNa
         EFWiZIzB4K4V//LuBZkd0ve3QtPFWffl1naeHzFtcnUVJ4n3Q4LwEOvuKH2m/ppgVQVX
         7p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741332; x=1764346132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9C+Ue8cMcG+njUQyZUQmHV/igv+sYiQ8hcgoRvKYA4=;
        b=pyJT4ByZgO4dtm9bNlidrTZPYkTNlDa+wzoAZfibRhaxS7VE/cGd/vqNF2Y7SeTwdg
         tq/pstRwvTQS6b7xftQt+cq519p3WwFVDGe1oCE2AEuqIQiUINl+rfAleYh1IYCRRsS2
         VelMAxU7C5H7/LNf57JYgwopuw5UYXQlYgghBflvjDz7aRoyP45+f5OZK6uA4fkHHMPr
         QftV/z9EVVAKLC1EZBVpmRfdAXj31CxOOfiDwGj1VM9o6FdKnZ/uZemksBSpUUEPt16z
         hxNav1lGPlZEP/8LyirXD+8eudgG0AZd6W9+SHMN83f1e+duMxMqnpByhK5KHMd5Md58
         luzw==
X-Forwarded-Encrypted: i=1; AJvYcCVEguh1aZTwfwYJ+7vdPrPv4AA/mIMRjPVgL9Jqwlx6qamoNK8hRcEoDDrYUD5mFe4VaHFYYGE02pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/q69SH39oZVdDCH8XBbDD26FtTBBWh7mLiL5iAZKxhwTSNMBP
	UPDZPcLytkRYkVqLtmUR/dqZZ96IxKm4x8glb6Af8+G/4jSNY79XW8oc
X-Gm-Gg: ASbGnct/Kgn/R8k4NeAyGuFPYQ88YWa86V77GxHcJxPq/zCtCm85B/cUzRLPPyy4LOD
	XXkTpHtm37dGBDHoXajfXuLtiyTnWZHAarT8IkxxLllmPoa/PaGkyRssRIDIdR5lZD1Q55hJwri
	cHBkMYsCqBsFO0540vwcz6jNgI6t4/2OlGM05n19Z6vwznNBty0up0j2tgTlZSVx/Rrw2j3YmbD
	ZykmY/FRtprjfhWrj0baS9i7bJ+Ttx3sUy8CPwKPWy3zyZfEAYrtLwrklwWdqm0sBbSC7HsBOma
	DMat2R6o3HeUScij35H12QnHJLjHSxYOMctFAqNRQES2ycsHgaWV1uMnP8aicOAQZ6RVItA9GPq
	+B4+9A8OiXvv0/eALGg2K3bTIn4Elg7KdgKUhaLPQaxtwt3GNGRdpuvh7BeI3Kt5iHMQQXU6Qj0
	SaAQlrrgKEsGkpRJGLlg3/NHMYG3yblhJ9CvppQgRRT7Bikbjet6WiOAGPMVVwPvacV13MArg=
X-Google-Smtp-Source: AGHT+IH4jxNoAr2KGBsMthVy7F6coCsto3BqmhfkVqtdBgcmZbZrjs/t5yrDang5WvrNZ5Prs+SrBg==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr28244585e9.2.1763741332216;
        Fri, 21 Nov 2025 08:08:52 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:52 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [DO NOT APPLY PATCH v8 10/15] pwm: rzg2l-gpt: Add support for output disable when both output low
Date: Fri, 21 Nov 2025 16:08:17 +0000
Message-ID: <20251121160842.371922-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch adds support for output disable request from gpt,
when same time output level is low.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c   | 9 +++++++++
 include/linux/pwm/rzg2l-gpt.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 8006c62068b6..a0100e1b948d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -85,6 +85,7 @@
 
 #define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
 #define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH	BIT(29)
+#define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_LOW	BIT(30)
 
 #define RZG2L_GTST_OABHF			BIT(29)
 #define RZG2L_GTST_OABLF			BIT(30)
@@ -493,6 +494,14 @@ int rzg2l_gpt_poeg_disable_req_both_high(void *dev, u8 grp, bool on)
 }
 EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_high);
 
+int rzg2l_gpt_poeg_disable_req_both_low(void *dev, u8 grp, bool on)
+{
+	int id = RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_LOW;
+
+	return rzg2l_gpt_poeg_disable_req_endisable(dev, grp, id, on);
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_low);
+
 /*
  * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
  * configure the pin for output disable.
diff --git a/include/linux/pwm/rzg2l-gpt.h b/include/linux/pwm/rzg2l-gpt.h
index 718aaeca39f2..adb5b9cfc8b3 100644
--- a/include/linux/pwm/rzg2l-gpt.h
+++ b/include/linux/pwm/rzg2l-gpt.h
@@ -7,6 +7,7 @@ u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp);
 int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp);
 int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp);
 int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on);
+int rzg2l_gpt_poeg_disable_req_both_low(void *gpt_device, u8 grp, bool on);
 #else
 static inline u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
 {
@@ -28,6 +29,11 @@ static inline int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp,
 	return -ENODEV;
 }
 
+static inline int rzg2l_gpt_poeg_disable_req_both_low(void *gpt_device, u8 grp, bool on)
+{
+	return -ENODEV;
+}
+
 #endif
 
 #endif /* __LINUX_PWM_RENESAS_RZG2L_GPT_H__ */
-- 
2.43.0


