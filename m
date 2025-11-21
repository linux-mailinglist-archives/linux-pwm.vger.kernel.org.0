Return-Path: <linux-pwm+bounces-7656-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1AAC7ABF7
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507EE4ECEB3
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DF350D4D;
	Fri, 21 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRmzhu7g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B934DB4D
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741339; cv=none; b=q0+7AeaR59vG/b+ixXFGg5oD7ueyswVdddpcMCbGQiJlAFsKYTRsXaQFvLis2oB/IkzPldcLhPkFjfWbafwKuVyODdZufJbEMwiY4yfbEKHsa0FjypBpZvvMMpBquBHkcK/PD98VQjrgH7jYPBzet+zzna6SGCER0LzJQoQo6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741339; c=relaxed/simple;
	bh=8ZF3K5fZHfu8OJ0FjVbioizmnSP8gLtvioziN5zK+5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mr76PkWWx1jtJqPWwgafFJGq0YU3Mtr5oBjdCJUdWT9SxOhReOy8LQZBXZYq7yqLPPS1vquI93YPIFra42hfgPKBxnkhrUslgWLHi/VWaV/Nt1+R5nV1dsN0HJf0WRHAfaw7lLgdJYCPXsDWAkbFw5TdU5qKrvQZn8bSazZ4Ymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRmzhu7g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219db05so14514405e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741332; x=1764346132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBMzVmStt4iXY2kK48dRs2GNNttV+QfJh9K9JLJwKno=;
        b=JRmzhu7g7YMGh50Gra/SPfwvR7IHDsTDFrjTe1y5eJo+53JVCM76NClWwEuU9DCEeg
         g37k5F05t1z9eQMlsYgDbPASkuJcv2pYYBmHJBSE1B+EgbIgbELrmOTXfIQjfN44WoqM
         cme5c2hEvd0JaDBWe5ukft2dM7v7+UWang9zis9hpNhItDshzA0PX1HuSMK/7Xcu/bKq
         5kT7mToBVN4xwIO8JshTxhMxqkPuRajnxcVXDivWm3WaeJ6qnkkoDr0WnKIh+Tic7YS2
         z/vP8tAnnWgtMJRXayiF1K3Cxz/nAg0aH05XCbHXslH6dnoAUK05r34pMt439Nd3j9Vu
         bahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741332; x=1764346132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBMzVmStt4iXY2kK48dRs2GNNttV+QfJh9K9JLJwKno=;
        b=Tg8/kXbBu7ZKfnqaZYY+0eIli103yCCEk4Et/ORM7qRB2eOoKLF4QMl7ac3K2omLbZ
         IPYlCusmWtoE1qxEC6qdRsXteXYmruse6rx7+6cyQRNeOqBUbfOr1OqDip5XLYjB3EGN
         QEO+g4EloPp3x5x0E1TWL8WrRlTrjWy8x/aevjPcoVVzFMfYmVpDseuDEMtRBYXNirBj
         zoPsVj/bow4rylQIbTTA9TpAUJUGKY3rwAP9wCrr3ghyygiAiZsqg/PQNQzfr1yZxlbB
         56lcZOScPJMKV9tVm9edMGlhjg22d+skNCxhSPTSFY5SGE46COcKMNWnq9fTIV/BG/E0
         q/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUvzjJEVnOtm05qdmAjEtAnlWh25eDGiCnTkYMIPh01LZffjPGx/ziOSTfKrMyOnTBnuExnjE6ufTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3S0Ced7TFxU5dbnbMN34EqNfbfT8lhQJCOKDFl96hEtXPsGwN
	2JotGHc0Xr1p0tHvBl18NrSRZt7aYga9AGk5iCxFQyYNJE63XC0OsQUNxRLY+w==
X-Gm-Gg: ASbGncvCtHd+nrZRYhtEZpaOLX++CQ7qVLrOV5fPd6FKEaydWY+FSi6r0AgggpPhGCW
	GUf5InSiHOTLuchvGZUYXDI72tgFNci2n2mU4EPLcq1LdJbnpTk9HPSNY8trJTUG1Hqt+E5Hxjo
	sVwkpcTXFU6kT2IPlufhluqSEeyBjcGhsgrHRNwc0jzkejEk6t8c7/nsISVL7CxIBziUQm4FzRV
	wRB8UuRcQ4wKpw8Abm07FzE1gxfSVIatvc8hYkALSz8WTf+LsGNv+ZpfOldZ/w3IkB6Ix5R1IEQ
	1T8r86YQmYYM6x6qQT4g4iQp7TCFVrmGb2g0fPZimoLoD35kQNvkksW5AXwl90LqKheanbmmHH5
	21Rka1kNKpwPoJznLXQLDzMiYQbOOXBaqbUEsAf229NkT8NuNrsve4UDFMVOH0AhiNf1TJbCfiP
	vYB2iday4gK+fe+VRlIV1FAXqugWGjQh1Hbx+5b4Yd84IgcAHH8AwczhX9QWMxgpCgQ7hSXS1oz
	KxzBSZ36A==
X-Google-Smtp-Source: AGHT+IE+ZUdN+W37qG7IiBAeuKMl1Doki1B7HpdO5POm0Ccptffh0HTr4Xa5JOkE3W2dOvU9/wjFQQ==
X-Received: by 2002:a05:600c:4591:b0:477:7925:f7f3 with SMTP id 5b1f17b1804b1-477c10e1cacmr26405905e9.14.1763741331535;
        Fri, 21 Nov 2025 08:08:51 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:51 -0800 (PST)
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
Subject: [DO NOT APPLY v8 09/15] pwm: rzg2l-gpt: Add support for output disable request from gpt
Date: Fri, 21 Nov 2025 16:08:16 +0000
Message-ID: <20251121160842.371922-10-biju.das.jz@bp.renesas.com>
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

When dead time error occurs or the GTIOCA pin output value is
the same as the GTIOCB pin output value, output protection is
required. GPT detects this condition and generates output disable
requests to POEG based on the settings in the output disable request
permission bits, such as GTINTAD.GRPDTE, GTINTAD.GRPABH,
GTINTAD.GRPABL. After the POEG receives output disable requests from
each channel and calculates external input using an OR operation, the
POEG generates output disable requests to GPT.

Add support for output disable request from gpt, when output level is
high for both IOs at the same time.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c   | 99 +++++++++++++++++++++++++++++++++++
 include/linux/pwm/rzg2l-gpt.h | 33 ++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 include/linux/pwm/rzg2l-gpt.h

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index aabd2d576231..8006c62068b6 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/pwm/rzg2l-gpt.h>
 #include <linux/reset.h>
 #include <linux/time.h>
 #include <linux/units.h>
@@ -40,6 +41,7 @@
 #define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTINTAD(ch)	(0x38 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTST(ch)		(0x3c + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub_ch))
@@ -82,6 +84,12 @@
 	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
 
 #define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
+#define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH	BIT(29)
+
+#define RZG2L_GTST_OABHF			BIT(29)
+#define RZG2L_GTST_OABLF			BIT(30)
+
+#define RZG2L_GTST_POEG_IRQ_MASK		GENMASK(30, 28)
 
 #define RZG2L_MAX_HW_CHANNELS	8
 #define RZG2L_CHANNELS_PER_IO	2
@@ -395,6 +403,96 @@ static const struct pwm_ops rzg2l_gpt_ops = {
 	.apply = rzg2l_gpt_apply,
 };
 
+u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	unsigned int i;
+	u8 irq_bitpos;
+	u32 irq_bits;
+	u32 val = 0;
+	u32 reg;
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+		else
+			irq_bitpos = (3 * i);
+
+		reg = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTST(i));
+		irq_bits = FIELD_GET(RZG2L_GTST_POEG_IRQ_MASK, reg);
+		val |= (irq_bits << irq_bitpos);
+	}
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_irq_status);
+
+int rzg2l_gpt_poeg_disable_req_clr(void *dev, u8 grp)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	unsigned int i;
+	u32 reg;
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		reg = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTST(i));
+		if (reg & (RZG2L_GTST_OABHF | RZG2L_GTST_OABLF))
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(i),
+					 RZG2L_GTIOR_OBE, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_clr);
+
+int rzg2l_gpt_pin_reenable(void *dev, u8 grp)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	unsigned int i;
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(i),
+				 RZG2L_GTIOR_OBE, RZG2L_GTIOR_OBE);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_pin_reenable);
+
+static int rzg2l_gpt_poeg_disable_req_endisable(void *dev, u8 grp, int op, bool on)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	unsigned int i;
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		if (on)
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(i), op, op);
+		else
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(i), op, 0);
+	}
+
+	return 0;
+}
+
+int rzg2l_gpt_poeg_disable_req_both_high(void *dev, u8 grp, bool on)
+{
+	int id = RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH;
+
+	return rzg2l_gpt_poeg_disable_req_endisable(dev, grp, id, on);
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_high);
+
 /*
  * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
  * configure the pin for output disable.
@@ -526,6 +624,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to link gpt with poeg\n");
 
 	mutex_init(&rzg2l_gpt->lock);
+	platform_set_drvdata(pdev, rzg2l_gpt);
 
 	chip->ops = &rzg2l_gpt_ops;
 	ret = devm_pwmchip_add(dev, chip);
diff --git a/include/linux/pwm/rzg2l-gpt.h b/include/linux/pwm/rzg2l-gpt.h
new file mode 100644
index 000000000000..718aaeca39f2
--- /dev/null
+++ b/include/linux/pwm/rzg2l-gpt.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PWM_RENESAS_RZG2L_GPT_H__
+#define __LINUX_PWM_RENESAS_RZG2L_GPT_H__
+
+#if IS_ENABLED(CONFIG_PWM_RENESAS_RZG2L_GPT)
+u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp);
+int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp);
+int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp);
+int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on);
+#else
+static inline u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
+{
+	return -ENODEV;
+}
+
+static inline int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp)
+{
+	return -ENODEV;
+}
+
+static inline int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp)
+{
+	return -ENODEV;
+}
+
+static inline int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on)
+{
+	return -ENODEV;
+}
+
+#endif
+
+#endif /* __LINUX_PWM_RENESAS_RZG2L_GPT_H__ */
-- 
2.43.0


