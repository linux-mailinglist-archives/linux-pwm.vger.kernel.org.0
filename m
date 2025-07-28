Return-Path: <linux-pwm+bounces-6900-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155C5B14291
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 21:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5831C189EB17
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AD277CA3;
	Mon, 28 Jul 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIbGRM+L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEE1FBE80;
	Mon, 28 Jul 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731908; cv=none; b=BVKlfriHpnIyAObsLc67ib7QrgIloW4OUTgY0EDjE/NBiAlUo7x56E2k6Se1jCdPul8kPCrP/7++07KgULnit330ZzQMjBzJnIqOUCK///CoaDUt969gXXyiLg9wanMlkqlMZ2qgYMTpk+xAITpGB1LjHTWzCIwQItGBuDt663g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731908; c=relaxed/simple;
	bh=iSnMayTNAdVLOEv9GHe6rkFBQgdCPQFk6qNpzYFxc/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjF19zRxjE5XJ4J/574/7aZVfwJym01YdlRTtV1ibZRmL1DZ1jRorXBQHJEC4NzqynHQ1OfJEZkxXuDm2sXtZceKyYzmfneng4Vi38cl3iNFs/6yNZdFs6qMpj2dR7eQ4lyO1Q/9mrmbGlpNn/6hX6Lzcm2SeElZ20WxGoho6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIbGRM+L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b77b8750acso189179f8f.0;
        Mon, 28 Jul 2025 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753731905; x=1754336705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItkzBZe1xNWTDxJw3YTXp/blm8WuT8V/aqN+K06Qllw=;
        b=WIbGRM+LYYgHXfyfjvXWEe8ozqqwDGIoU+7kuogRqrVHjNa0+MpfWzUvtdMFS7eCzy
         HAoFjkoDp0hzSUUKzwYS5Yj53rTfzEkrZ+LQ85SYryTrD6ssQLpgVcNt96qCX7L7eDZG
         f7eQyg315OfSfo2UkF5fl8PWAtoVY7qAFeZyEsdpdApdKlwmg/M5TREWaLykZ+0WFAD8
         0zXTvJqxUe51qrQV3VHR0kccLdfv3SbAh3sEPBVQ6J64Cq/WWmG6zyD0t6BDuO7ZGxOt
         9eHnxDdR/Ys6RWtJn+lUVMQJWd7pGBbA73jfXDRHSmvnF5Z2YBCbT6dPN0XvXDMImHjK
         +PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753731905; x=1754336705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItkzBZe1xNWTDxJw3YTXp/blm8WuT8V/aqN+K06Qllw=;
        b=V71HBcfNnQn6AfMfi7rCby3+8067PPfa63mL8h6uCHFioz0Rd7jeJ31/CLx6IXmEkj
         PJrSmISl0lgUxygFcNUvhslMQGTEKxBPpFypzrQiZkNrfWdFCynfrz1CL0bSZZiGpbi0
         PscXw84go+jnf7reNPfNEutbCaB6XOVM/fMoxjU7y3dQGznHrExs4f/CYBhGqbM0VDAQ
         /UZ/cb5NqHqdQsNm7eiVIjZYeZ1WINECj5yFmy18ceq0IawON2VJx7Yp/VROzyS0kjfL
         WEuChHdb6PCEjitX4DNLzDjM0D8MBUTcEAcswG14R/sZo1XX3GfA6q/9/gW+3+ccsHA0
         RL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdNhD2ZzUHurSXrwHkyTUiopV+HxbpMQSM48oOHMn9YVCD2S8ZUIv2Is+aZ6PuiJHui5vfYRZSjFjMeB0=@vger.kernel.org, AJvYcCWU22BwrG5oeVWkdwR0+L1rdux6ghNppoAvO3THqhRvARf8t0QfLrkYkOHGpuhe7WDSJ6GK6t/SAARL@vger.kernel.org
X-Gm-Message-State: AOJu0YxXW0/vc5ynYbqAEE60LUjx+qCW1qmC8KZlJ8W4QGtRjkmS0SvV
	2IijTMo0lybzU3zfSsLvj4Mp3ysLJ4l5SZtc5HsvYUe/rCNxqiZjBhTHXhaYqw==
X-Gm-Gg: ASbGncswoyd86vOGlV9xPbIqJN8H/mtkKrPKW+GVwcIr0gnlyjy3SS4/KGWqzKhNhL0
	UzYwKS0AI/6NuLw86s6iZYiSuilyhXJRXjg5A+BTc3NT8TowKPNnc7XgrHDhaqtD8b5JtAYIz2O
	m4Rn7/pZU0VBwdjeWnMX6QqpKikGlerr8L4+28c+OT9GnQsGs8TSlPydDVuJy0iec1WEWBbmi8e
	5ikJXrO5LyOM/7NQ+VPieM+zUNuxKDcUEvF15hILT9s9jMK1PeN3QCpjl+VgvMFyDujkKS/4eVU
	dziMWlba+kGdgBEC/UzUnfDg8eaUb2gz8OKs1OmPUKK5HN4eWjSwyV2FZzUUtk/duCoD/hX5/QJ
	BcBRzd64rjLwHG4o0DIr2xGOSONuWA6TQfbAk8ItLDwJhJULsLS7BBge25bmD7KP0iTqPyw==
X-Google-Smtp-Source: AGHT+IHY8hLa8p8y5iQ7pp/OFOj7bim/OIX1NELu4CwTPhxkimsWDOt02B6vAdwiG9TIVZN04Lvssg==
X-Received: by 2002:a05:6000:2a08:b0:3a5:3993:3427 with SMTP id ffacd0b85a97d-3b78e60fbf0mr426846f8f.26.1753731905198;
        Mon, 28 Jul 2025 12:45:05 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c477sm9547837f8f.58.2025.07.28.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:45:04 -0700 (PDT)
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
Subject: [PATCH v3] pwm: imx-tpm: reset counter if CMOD is 0
Date: Mon, 28 Jul 2025 15:41:44 -0400
Message-Id: <20250728194144.22884-1-laurentiumihalcea111@gmail.com>
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

Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
Changes in v3:
  - added Fixes and Cc tags
  - rephrased the newly introduced comment such that the bit is understandable
  w/o having to check the TRM.
  - Link to v2: https://lore.kernel.org/lkml/20250714123634.6442-1-laurentiumihalcea111@gmail.com/

Changes in v2:
  - dropped the "VERY IMPORTANT" bit as per Uwe's suggestion.
  - Link to v1: https://lore.kernel.org/lkml/20250701220147.1007786-1-laurentiumihalcea111@gmail.com/

 drivers/pwm/pwm-imx-tpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 7ee7b65b9b90..5b399de16d60 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -204,6 +204,15 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 
+		/*
+		 * if the counter is disabled (CMOD == 0), programming the new
+		 * period length (MOD) will not reset the counter (CNT). If
+		 * CNT.COUNT happens to be bigger than the new MOD value then
+		 * the counter will end up being reset way too late. Therefore,
+		 * manually reset it to 0.
+		 */
+		if (!cmod)
+			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
 		/*
 		 * set period count:
 		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
-- 
2.34.1


