Return-Path: <linux-pwm+bounces-7680-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DFC7E98B
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C097E4E04FF
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AD225775;
	Sun, 23 Nov 2025 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4+9ZmHT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212621D3F2
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940477; cv=none; b=omX+8LvBn37LobPcLx70r538Vu0gNxmjbTD8JJPI++A+TcTu82/NORYnbnFO1d5p163QYtPsLkKG1trAToiIHwEPt/hDd/vycnEslPMRFsjtEthUHbcnTCGR3BlbWMovTvpZAxiB7azvJIFrQ/FkFdA4w5CZu3wwwb7XYcTqLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940477; c=relaxed/simple;
	bh=EOSXwrXqxz4AQJcr5iNQaieu6SWxZVvaWPEFEYoX2YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBEXQCx1qJTKWhY7bhLq4jjpYG9t3Wq74Hsog/ymIJfa53eB0wuv2g4s8cs+r74Qvp4KIyeUX1EmWujlmzlaN6UMHh3z70jnIuCdNq7B3aKfnGV5cTHZnnimqSVxU7/a9AkGH5C4SeHRW7juo9OHy79MRwN8XltzU4Kyv9D0Iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4+9ZmHT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2955623e6faso43322555ad.1
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940475; x=1764545275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G087ODqxLvrjvjcH9PildYCj45Ipu3DXnsEsd5uIdAY=;
        b=k4+9ZmHTmBtNqeaytBX/lYFVJhJs24XZrX3YjftRZKJDq0/FjZ2a2XCvsGJNOvcd7r
         FXMJ5mbpGVFtPF83S8cbXi4WSJkxCNEMkdgDHl1PKtS0okqGXMdLvmaiyI4hG5UdSTc1
         A/PK7EN94B4cEF+ae7eKuPYQM1Pi6R+IrKSWFNrPwP5S6qwD0t/fpp7khmvi5iJMDgCW
         l0ZhqseaqTfuYoqEx5IlOm7yLSk5i9g+hKJwFNx401DUgs13BfD+n19JvSKnUMrL5uD/
         yjcOQKn6nRBlieWZmLlnLsaI6Tj8CJ1TZgv81SHtxYTqXZXvmPCMBSGdrWFciPoT5trS
         4mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940475; x=1764545275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G087ODqxLvrjvjcH9PildYCj45Ipu3DXnsEsd5uIdAY=;
        b=KDEl3xwWZpj/PLmLjHYNYmcAdNulpuqLklU0c04rmKkquvnkysxRSsxXdHkwHIgwtc
         6GwBT619vOopOpP8O8xTaZ+DLyvTaQO06zvJ9hIiBLRiv5ulxoKUanGg0qxFaej/1vOB
         stwV09hHaVk4J2hosmhOincSzaSaCytjUzkz1esXFe/R8EquhZ0yVaShDG5Gv9vdCE0A
         LvKrcrRhyxNM/TrtqIjuiPjpvTkvyNV6riXOGIKOi78K7212ZV7Yjai3YTgF+8csze+7
         sCcSYxDU/7PLd/tEHP6eKw2OfnCa5xfMzn5ZsRAe6+3lhkXqjrSsyrDYyh48TeyrZ4hl
         OkzA==
X-Forwarded-Encrypted: i=1; AJvYcCWDWz45x40APICprutjDQ9/030yIkMqg/IlymzeGmu2Zskl9Wj940bsjUjGrkDF2HjDrzwDBjaHGA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RVmtUurkaytv8N225sZuXnhYtWEVAIMJV1v4kH2qR9IRWKFj
	/hiAJ2ht9njbOo27pawQzuUlB6bT+zWa1UpQpop9hC8ujounDRlo5r6al0rLSw==
X-Gm-Gg: ASbGnctJclX0Plpz5deqnVjUkQQvNVRBVpu8X9SuvUu/pT6mIK8LMxQXjmKYh/pcrI+
	7GqhU9zcHPRHCV9oe/PLKbQnnc4BAb+Lrxj1LTQUDl3VqmOtqiCqivCJp6sjs2cjhNGyKiqhtBp
	AJLs7XBEp5TPB5WCmjWZyhXFWRwAv95gmOz/9jSiLS5ct5E1wmQ+9XlTWAMMyAVG7l4nFsMnqmP
	RD045FuRbuDl3GF7S6h3x8iuEyz/ZKDwD4KEoxv8q83wlKaFjyuhtdJCjtjH6Q/sVLLAx/HMNU6
	QG3gZe7LyYaA/LXTRoE3mpzRTo6TRmn89mnT+HkjQlzm2kRbWOP+/ZbYPoCvwtBeMt5n4S07rCB
	Jb3jFgmq+UK9vVZlJBD1oMg2rIq6cOiDuTFGRXeLTM6hhCya0mJ4k/fgqCgb5gtsFWK3MxiNWnx
	2O4fLPZKbfGBlgnPefqUGNzjZIFsbUrhPd/8n1v8h0k6QVMGFAluAneg==
X-Google-Smtp-Source: AGHT+IGQRCFpgwDt2sOHAPZfhrK4YhVBPWL8eFfPLGUdsJUAad+VDOVWI1Mic5E/mhPSzeV2/543og==
X-Received: by 2002:a05:7022:6609:b0:11b:a73b:2327 with SMTP id a92af1059eb24-11c9d854336mr5229577c88.30.1763940475478;
        Sun, 23 Nov 2025 15:27:55 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm65742919c88.7.2025.11.23.15.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:27:55 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v6 2/6] pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for prescalers
Date: Sun, 23 Nov 2025 20:27:48 -0300
Message-ID: <20251123232748.2057-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123232521.2039-1-rafael.v.volkmer@gmail.com>
References: <20251123232521.2039-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual handling of CLKDIV and HSPCLKDIV with GENMASK() and
FIELD_PREP(). Introduce TBCTL_PRESCALE_MASK so both fields can be
updated in a single ehrpwm_modify() call, and drop the now-unused
TBCTL_*_SHIFT macros.

This improves readability and reduces the chance of off-by-shift errors.

No functional change.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index d2151065083b..1ad8577139be 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -25,7 +25,9 @@
 #define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)
 #define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)
 
-#define TBCTL_CLKDIV_MASK	GENMASK(12, 7)
+#define TBCTL_CLKDIV_MASK	GENMASK(12, 10)
+#define TBCTL_HSPCLKDIV_MASK	GENMASK(9, 7)
+#define TBCTL_PRESCALE_MASK	(TBCTL_CLKDIV_MASK | TBCTL_HSPCLKDIV_MASK)
 
 #define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
 #define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
@@ -33,9 +35,6 @@
 #define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
 #define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
 
-#define TBCTL_HSPCLKDIV_SHIFT	7
-#define TBCTL_CLKDIV_SHIFT	10
-
 #define CLKDIV_MAX		7
 #define HSPCLKDIV_MAX		7
 #define TBPRD_BITS		16
@@ -169,8 +168,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
 			if (*prescale_div >= rqst_prescaler) {
-				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
-					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
+				*tb_clk_div = FIELD_PREP(TBCTL_CLKDIV_MASK, clkdiv) |
+					FIELD_PREP(TBCTL_HSPCLKDIV_MASK, hspclkdiv);
 				return 0;
 			}
 		}
@@ -247,7 +246,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRESCALE_MASK, tb_divval);
 
 	if (pwm->hwpwm == 1) {
 		/* Channel 1 configured with compare B register */
-- 
2.43.0


