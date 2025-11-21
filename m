Return-Path: <linux-pwm+bounces-7658-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4EC7ABB5
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594303A12ED
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852D351FBE;
	Fri, 21 Nov 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlkNNUK9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23334C802
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741340; cv=none; b=aOLBs97Wv89Q7rog3LFYWBboBc/ic49Os7+RbCEzm5pV3HeLLzYwXEnNQxZQMOG/EC2CKpddh9Zkh4q2eGHBgrXENnFqkTddTDLPN52bus5M6wMB2760iXQYgyyETPTONnyKUlDs4uBqf/+qNBJxPKh86iojncVCd+FxRuveArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741340; c=relaxed/simple;
	bh=6d3UawdJbIGNpQ1r+t0ClfBpoFcfP4pXx/49sOBT1uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yy1cmpmq9mT0yZo92Kw8bz8WorcAqmAMstG3PuqYfnu9736YEBb/WsvnYZUtwhjucV/LGAACPbYVDC50nlj5Ua4fZQx2OAjnbuJMMm9JuvaNuwGp1DhDCc1n3+b0y3XxONLKFRgHe98EIEmXxn+zhLroL4e1eMuDpVqD2ATkGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlkNNUK9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so14793855e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741333; x=1764346133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrSuBxCexGS87tmWsDBU0gBjhQ4SwSQ7srqw0RC4gYg=;
        b=LlkNNUK9VhuyQ8JHMYcDKCXpPybTzHs5PyofT7YOvnPGUH4WeT2UOawGElNjY+x9rW
         VWZdi6LIOixX10VFyJwkZAPDd+boNxavCi4aOEKQUAP1cZM0nVI56B+oKJr+xI75ft+y
         dGP5phaX2lF+43TzI9LE1V2U0/xPxXI11dOKpJA7YLPC4HIEhGjK5PAAdDXn6AEOVyoD
         B1JVg1h67obq9Icz0MU1KOQkzjHAkNj1817N6InA80pFnRNl28achBePtUD4kISnQmjv
         1gsbEOuvGOwozm+cy78pExm7ZF1PB7rB3gfQSQvGXIgZZCt9q2houzcIEvTXQ+Qyq0hq
         5H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741333; x=1764346133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hrSuBxCexGS87tmWsDBU0gBjhQ4SwSQ7srqw0RC4gYg=;
        b=bzqEvKNp8yGw52iA7pKt6FoSRhPkGmvCDhcIjHi7AzW02DF+IWJ8hp70DF6inepNRp
         05v7FvaN7x4Gh1egf0Ki55a/rqK8cWif2Nhn9qPAfTN5N+qT4BZogs4EZzNYXm50S4Sp
         J7Bh3rQqCBu9A8VWc8xq+b7qbuevPEoGGRzCbNnxW1RZyPKrlnLnqmaVxwWg9s7GFScO
         8wJ0jL3wR6ahAhyYWtoM5H+83Cwx44tEAC31iZNuci+ojUMxWMidQ5X/tnSzRoCH9cNa
         F2p+DVFqXvqItHsHTKj1dJ0ILUvOo2HgSh/qXLJauD9sNriSQe3g7q8mDI2MEQ8RJv5u
         S8ng==
X-Forwarded-Encrypted: i=1; AJvYcCXS6QJdNB8P4TnIDpzqiN/XtzHKt9APya1jMRKFkE6l8bq4g9Mmybz5zpOz3j/YbgDBiHoeoAlZXps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEg/+85FwxAr/YE0MgAXZv/9+9ZKLaPQbS1nc1bl3AAE79atS5
	XAipWTATiSyt2KJAF3uUjw9BeGAsMkIpa3a9Cs0AU4yD5bWLhcIDXM6K
X-Gm-Gg: ASbGncvprU2Qy2nGPt7ZMWHt8waz7/ZEb1PAapwJ5G6emU6NCxMFUEBV1BEvU2QVp+i
	SUcP1sjsHvHTviY8lRB0Wlz53OY1soCq1MT23BUKzZlpNV2Dt0Djt5VDE9RWnlfKR1cRaa8Hiah
	xwqvkzx19WpoQ6fgTXx2tRTXmXGNqkaQTQBDTZZu+6vtOLFj/akUBkakulE0G03bUUxgN2YEiSX
	GuskW6hKofCfrIDnhsYnJZiCO4iGactiSaX3SVJal6MngXPQvBWEJgZ+jjkc/X1XRBZ4JJwwexZ
	KBq9kbaeW6RXQjMyEoQfQTl5VDA6t18j3ODp6ow1zv4FkuitUuFAdW7G6OcLZmU4YExsXE/k1Ju
	RUcIvIjBDwMLovU6TI+o/FJWvqPJreoW+pts9PSCZORSdkLfT7gndq5nFpc6Be8hq8Lc2CXGQWU
	I0u3aiiJGoRu2F1mRjpHJaTuZm0YUhHWdjIOmAovkNyB+/7uOQcqKRQiw28d6A/7T/CBnBtvk=
X-Google-Smtp-Source: AGHT+IEsDBPrjJf1KURwoq8uXlilefcsQLW4264GczEDAFI2hLFsKc/qZ1a0TXfu+QIo/tHMJdFj3w==
X-Received: by 2002:a05:600c:4f88:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-477c01c0c9cmr28504395e9.26.1763741332734;
        Fri, 21 Nov 2025 08:08:52 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.52
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
Subject: [DO NOT APPLY PATCH v8 11/15] pwm: rzg2l-gpt: Add support for output disable on dead time error
Date: Fri, 21 Nov 2025 16:08:18 +0000
Message-ID: <20251121160842.371922-12-biju.das.jz@bp.renesas.com>
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
when dead time error occurred.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c   | 9 +++++++++
 include/linux/pwm/rzg2l-gpt.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index a0100e1b948d..0e158f677f01 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -84,6 +84,7 @@
 	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
 
 #define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
+#define RZG2L_GTINTAD_OUTPUT_DISABLE_DEADTIME_ERROR	BIT(28)
 #define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH	BIT(29)
 #define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_LOW	BIT(30)
 
@@ -502,6 +503,14 @@ int rzg2l_gpt_poeg_disable_req_both_low(void *dev, u8 grp, bool on)
 }
 EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_low);
 
+int rzg2l_gpt_poeg_disable_req_deadtime_error(void *dev, u8 grp, bool on)
+{
+	int id = RZG2L_GTINTAD_OUTPUT_DISABLE_DEADTIME_ERROR;
+
+	return rzg2l_gpt_poeg_disable_req_endisable(dev, grp, id, on);
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_deadtime_error);
+
 /*
  * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
  * configure the pin for output disable.
diff --git a/include/linux/pwm/rzg2l-gpt.h b/include/linux/pwm/rzg2l-gpt.h
index adb5b9cfc8b3..f9365bbca57c 100644
--- a/include/linux/pwm/rzg2l-gpt.h
+++ b/include/linux/pwm/rzg2l-gpt.h
@@ -8,6 +8,7 @@ int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp);
 int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp);
 int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on);
 int rzg2l_gpt_poeg_disable_req_both_low(void *gpt_device, u8 grp, bool on);
+int rzg2l_gpt_poeg_disable_req_deadtime_error(void *gpt_device, u8 grp, bool on);
 #else
 static inline u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
 {
@@ -34,6 +35,10 @@ static inline int rzg2l_gpt_poeg_disable_req_both_low(void *gpt_device, u8 grp,
 	return -ENODEV;
 }
 
+static inline int rzg2l_gpt_poeg_disable_req_deadtime_err(void *gpt_device, u8 grp, bool on)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __LINUX_PWM_RENESAS_RZG2L_GPT_H__ */
-- 
2.43.0


