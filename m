Return-Path: <linux-pwm+bounces-7660-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE4C7AC2A
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 716234EE25A
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6A35294B;
	Fri, 21 Nov 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYecGX1x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2234FF44
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741343; cv=none; b=UjfneMngfugFNtNKlHZ5SNtr2HOi3EgB4EptFMz3qNx4NTaAeWSf+COt5/fXsE/DFAdgTmlsooGKQGR2YfgqtiecWNBOt8aGWzWBdYEedvb7dXwFIUKNuX45ymIcrWh2dAgHwzBgmqFZAr/OibZmJcCpNiPgBxJ5KmXcrnO7C2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741343; c=relaxed/simple;
	bh=u1Y+j28vGrv/nUf5bQmYDxuLP8umo9b+fTawAt0kWDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZlmkeVVri80/lEczPKyQWbTsC1gwlcNWWeRmtKyMXq9/LV9Q+bjHTsCK3chMi3TVrKLo9O5HGzOK1dMYIMK/Dw2ewMxRIFCes9gCWgZbt+1IErD3lLpbug4OQ9cumQpTQgFtwEWjszfSGuQkOplm3YpRin1OGQFqb+9JsAxXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYecGX1x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so8203875e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741335; x=1764346135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X2AnPp8ZxXuacTaqkoxA0nNfMzhjfVhZceDnwCyffg=;
        b=NYecGX1xyMX0Qod6vEJUkJxxszL/OMous6VGrwOgx9aSihgg8wxdyG47hUVd9v6f3R
         0BztEVwmmn89AK54u2Dlq/sqR6ahcMsxEoHrCPZZKCV1XpvdP/oLiT18ZyQYgaPnMAlX
         VZ+KPpBcpI2Ga3ohyePODygrrZ78plwOPiurCNrVC20S1XgKzmqLlCllawaLCQwbW4mj
         7tarh6EyAPgn62u8uLB/+ZP9cEb4A1esKUFiln0OA71qjnQeebU25Dl1la3goc/PQc+t
         ck0jcJm6Htfvcr6FEVtwcC7AggsS2YWt9MPn7QwRvyf9dWrl4PZws+okdKxp1jRXGsMX
         Cqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741335; x=1764346135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9X2AnPp8ZxXuacTaqkoxA0nNfMzhjfVhZceDnwCyffg=;
        b=m6ZiQc48v6a8TLJ92u8CGoe5Pe4NkSUmg/4/dsiiuKEmgN9l0ldWaIP+evjUeglIu1
         nEJYJkx/w4zRcQfTVDGWelIsAH2QR/lLRDyhLNsTsbHgVKvqp+O/6P6Npw22x3nfe164
         EkbYn+zcw4DU0BLqdVejpMQ/DrFGu2e70bHMOn5Gh7B+m+X14FGfD680/QHw2VxqmDFk
         8St85RZqy//YJ9A4JvY1UZvkaWMXVQoRNSyoesTpu9g4JCxvJZ3lVvqcoM9U6wi4upRD
         XKUS8Yg0QM+tt/51hFPGFqpaYJOypKwZtKdl8dinUaX+nqOfF4xlQ7EcqZyjMxCkQViu
         4uug==
X-Forwarded-Encrypted: i=1; AJvYcCU743/RxMGr3yxKSDS87ZWLsA518rsHHwO6jW7e01MoGx9gXoSNwIvmG/jCJw5gGE1aZVXI0JvTjDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8HxSXY51Xn63n0rz3yHF8z9L53ArASkENgMdx3u5ELPfnNkb
	ac3JOLYWvWmoztnoW/QLQSsJV1+3hG33I37Uxo76TTnt7+upNMC/iDsH
X-Gm-Gg: ASbGnctv5mYMjr1P+U6S9HHwvb+qVF2Hqj32cid8RkoqFC3khc/9I3OsLh2Z5PHXPxl
	2Hs2TQb1P8rRNGl5/F023nV7DM12a3vDeDjwIgPJtuGaDuGTyxYP7Zj2mM8cd/4IlAVlLNLzCNz
	Uyp2eotiqa6woaA49F772fRPCoSDlF7g94R0PnMhMQiXeCom4ETAuVE3nz/O78eqew9T4u7fqII
	ODliVpXqdBMMktHt/LLLhyHdNSMzUFSA1JxR92YTZR4aSqnt4u6oXLq67XX01ut0wvHll+e+leb
	R2z/X70pSH1tbEcDdvPZoAmV8geG1pSxF6g8+xaUjsRLTa1hncEN05p57x/rtcfviJUhRWCX7/w
	sYbkExMMRoNycElC8zIJ4JYvc/2TQPK7xPIRXrcZHxjk2CtzYVPNxMV9e/vVBAm91UB8S6QPv9w
	XJN8lwOGb6bW1Z2zOCbYktSXvWs5qG5qvK1zNt7ZRl0y1zzPPjdXHqMGVROtw1EGGMRQTjtJU=
X-Google-Smtp-Source: AGHT+IFdUGDVUhzEKPiwAAiM3uKkMg/yNhgZucNvNM8JWBuzLF6Yj/qFVOOU3tdSxtoFNOsY6csCRA==
X-Received: by 2002:a05:600c:3553:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-477c016bfffmr30193435e9.1.1763741334552;
        Fri, 21 Nov 2025 08:08:54 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:54 -0800 (PST)
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
Subject: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg: output-disable request from GPT on dead time error
Date: Fri, 21 Nov 2025 16:08:21 +0000
Message-ID: <20251121160842.371922-15-biju.das.jz@bp.renesas.com>
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

Add support for output disable request from gpt, when dead time
error occurred.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 19 +++++++++++++++++++
 include/linux/pinctrl/rzg2l-poeg.h        |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index f66f69c5b1f7..d59e18832adf 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -92,6 +92,9 @@ static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
 
 	if (test_bit(RZG2L_GPT_OABLF, chip->gpt_irq))
 		rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index, true);
+
+	if (test_bit(RZG2L_GPT_DTEF, chip->gpt_irq))
+		rzg2l_gpt_poeg_disable_req_deadtime_error(chip->gpt_dev, chip->index, true);
 }
 
 static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
@@ -353,6 +356,9 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 	case POEG_GPT_BOTH_LOW:
 		assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
 		break;
+	case POEG_GPT_DEAD_TIME:
+		assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+		break;
 	case POEG_EXT_PIN_CTRL:
 		rzg2l_poeg_write(chip, POEGG_PIDE);
 		break;
@@ -360,6 +366,19 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
 		assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
 		break;
+	case POEG_GPT_BOTH_HIGH_DEAD_TIME:
+		assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+		assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+		break;
+	case POEG_GPT_BOTH_LOW_DEAD_TIME:
+		assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
+		assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+		break;
+	case POEG_GPT_ALL:
+		assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+		assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
+		assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+		break;
 	default:
 		ret = -EINVAL;
 		goto err_pm;
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
index ed3e08f10834..5edf719c155d 100644
--- a/include/linux/pinctrl/rzg2l-poeg.h
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -9,6 +9,7 @@
 #define RZG2L_POEG_GPT_CFG_IRQ_CMD			2
 #define RZG2L_POEG_GPT_FAULT_CLR_CMD			3
 
+#define RZG2L_GPT_DTEF	0
 #define RZG2L_GPT_OABHF	1
 #define RZG2L_GPT_OABLF	2
 
-- 
2.43.0


