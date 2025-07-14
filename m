Return-Path: <linux-pwm+bounces-6842-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7AB03ED9
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Jul 2025 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0EA7A06A9
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Jul 2025 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C289248879;
	Mon, 14 Jul 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8jsgD2A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6E20AF67;
	Mon, 14 Jul 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496694; cv=none; b=RSMDdslEge2iJQm3+w9N3UkL/j7jEEE5ppKUKSA29rwLnGpd2qrapi3qO/z6d9Q7dcjo7bw1qpOqW7aUmL7RtzyXWQ3uMZ1p+uUUCT9C/NIrG5U0g7m1hbjv9tuCimO6rV+V+L/oBT9ZxO/xl+IBSE0nU29dXfWUJWWygYswLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496694; c=relaxed/simple;
	bh=ZXxvfm5ACdHaOgBMK2E/ks9Mq0FoiGqE0kZ5+r0itYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G1PggvhBQCGuWDuIRi8lO8gnZJRJXPCIGfVErEWNnhnEvOwu4iWFPqEm+DPF234nQFKx5YLlNZBe6IAPdZLU5F7crX1DzDAPur37N5P9BsDDK6/k85p4lXly4H1QXEDWZY+bf0/XNQX3FtkMzKQz0nVhpDbAbzpRgnYGFWHyUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8jsgD2A; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0c4945c76so709473766b.3;
        Mon, 14 Jul 2025 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752496691; x=1753101491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EY/NG2nHnV92BHijz9klsk+toPjE4xsvjwjRWHy7y+0=;
        b=e8jsgD2Ar58LKYlK61ooeCYZB0Y/T7NfyMzvlhI3V8veZotQLyyDDAAGvhcVoVh3p5
         bHBu5X0j8wswi4eEOPIJRscyu3vIqHyBZfvGXn3GEOJ+dCkBNl4XdK4iGgqEe1TjtaJD
         sgRTbEb+Fy3VusHiiHVYm/FRVhX4Rk7Y7oKfTJZ7UtZJmoscZj38ZnGuI+7RuEaRiPIu
         H564A5G306Y45WnRKWHo/SlJmWrWLEbLC3Jnncvxj5YIU+ntC/QFIUKD336hWUFW0w+q
         1727RJLCHoNYStKYprwVsSfSLMfIVwuObe9HPrQJL/9Ejc9dDmcnFtEYmHeQhQP+wld4
         AH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496691; x=1753101491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY/NG2nHnV92BHijz9klsk+toPjE4xsvjwjRWHy7y+0=;
        b=YJ2GfZIfk1C8Mf9sDAfDzfsouZkY7HYTG/BGHfiYd4QoJktQREWtCUzMc7zgWpsaHV
         qQGQnWkLnExYJ6ZcszX9unEMwfvUmtY5rbT9AxE5Mfcr5nWC1w+POEwJlnUt3nm4hIsY
         KBwUxEibjMBMk/gI752ngoLrNrI1AUxgb1WXsL9kllAT3MyzIXOpLvwb+LrP1KyERbO4
         b3DChgZfl/GSJu2qpkE98nGxbtQijq3gyGzIfotRqdDJYyaSrikjCN7b28ZJSVjOm64b
         7FgL+o679t10ej14OBRhcMu+HGo1DEAdmoFbDC0VMtYPZv68cqRM1cBxnIzF96dbOQqG
         A04g==
X-Forwarded-Encrypted: i=1; AJvYcCU5reVzB0pn2TLPIEWt2iV4tCQ7w1fQZYrTAyVpw7/1Pw9+x+0X0GBTAgpC1eeWUcAinsGSzq34mUFJ@vger.kernel.org, AJvYcCUhEumVgSeEvMKkO2DjQ57kuvD2wk0fbBdwnAJdod/L0oNA4j02cgxV7EI+pTrnI8N/3F2LuJNTzZ1tuA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBr5LBSDCAb0A5KAwHyemDx/PFdhB9yesPtitkbuYXqunoPow
	AalOtwe+2M6aJkRnQyPjnWcQMJ3bLve0jtd6zCKJbalcpH3NHXIz8zIE
X-Gm-Gg: ASbGncuYRl0Ajm6XpWFmxN2B4VvGcfuJ5kogsr86MrTdXr8f3SFgDzTdjCBMTs7GAHD
	vIEumW6NvZefUS6Mo92eIufJtgmYaEjmACh4i/+ShUWhFMv7HkxMWy58ftLhBoIUfvpTWVq85Q/
	CoQt48TDF28uYsKvsrglZC04XaRqOhGb64VOgigbcbTYXp8raZxRoctyPDciPBRzYmsu1WFoL+w
	1MAxncIxqKAgypBb+XXdHOXqaIjVJr8xpeQXDmEaogyx2br16TaFscO9mekZMsEmq6Z/jtj+85P
	oFf7WDp42gyWBGNXI7KLZdwZKNj3ediHx4GHDAviHalb0dBgZ0kTehquLC1+1lPaH8euwa+bD6V
	TDOrpK5SV/VOqR0M6VQJu5mMF4raYaJvw55pZ05UYv5d7uI2OjilOwRus
X-Google-Smtp-Source: AGHT+IFJP4cB80pxWE0x40njp9Ls1ssVpAFwjW00zYJz8lfNZnZohc3hO+AUezRssWB3NbpYRZaVBQ==
X-Received: by 2002:a17:907:930c:b0:ae6:a8c1:c633 with SMTP id a640c23a62f3a-ae6fc1fae79mr1276473766b.34.1752496691220;
        Mon, 14 Jul 2025 05:38:11 -0700 (PDT)
Received: from playground.localdomain ([92.120.5.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829402asm805005266b.121.2025.07.14.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:38:10 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: imx-tpm: reset counter if CMOD is 0
Date: Mon, 14 Jul 2025 08:36:34 -0400
Message-Id: <20250714123634.6442-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

As per the i.MX93 TRM, section 67.3.2.1 "MOD register update", the value
of the TPM counter does NOT get updated when writing MOD.MOD unless
SC.CMOD != 0. Therefore, with the current code, assuming the following
sequence:

	1) pwm_disable()
	2) pwm_apply_might_sleep() /* period is changed here */
	3) pwm_enable()

and assuming only one channel is active, if CNT.COUNT is higher than the
MOD.MOD value written during the pwm_apply_might_sleep() call then, when
re-enabling the PWM during pwm_enable(), the counter will end up resetting
after UINT32_MAX - CNT.COUNT + MOD.MOD cycles instead of MOD.MOD cycles as
normally expected.

Fix this problem by forcing a reset of the TPM counter before MOD.MOD is
written.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
Changes in v2:
  - dropped the "VERY IMPORTANT" bit as per Uwe's suggestion.
  - Link to v1: https://lore.kernel.org/lkml/20250701220147.1007786-1-laurentiumihalcea111@gmail.com/

 drivers/pwm/pwm-imx-tpm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 7ee7b65b9b90..b15c22796ba9 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -204,6 +204,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 
+		/*
+		 * if CMOD is set to 0 then writing MOD will NOT reset the
+		 * value of the TPM counter.
+		 *
+		 * Therefore, if CNT.COUNT > MOD.MOD, the counter will reset
+		 * after UINT32_MAX - CNT.COUNT + MOD.MOD cycles, which is
+		 * incorrect.
+		 *
+		 * To avoid this, we need to force a reset of the
+		 * counter before writing the new MOD value.
+		 */
+		if (!cmod)
+			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
 		/*
 		 * set period count:
 		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
-- 
2.34.1


