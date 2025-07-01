Return-Path: <linux-pwm+bounces-6682-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35D1AF0629
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 00:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F11667B7
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 22:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18704265CC8;
	Tue,  1 Jul 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHlaW8L8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CAD19995E;
	Tue,  1 Jul 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407387; cv=none; b=Nz6e77lQLEtEPmqb3LgV5Qow+1OqskjN5pSRUL8urkRjsNXrlyWKV4oMXaXWy2dg6MLR5QBx0UHwUI/tVjKLimcAcsTDi9eAlFApFZh3sk7LEJdx4eeQN0R0RFBMo8iepGRC+vbQL9yyIAXVu6vGmuqwaSfXa2s0bO2oQ5vEAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407387; c=relaxed/simple;
	bh=6u6DYp8XHiqMAtZhMlgpyQ1cp2/ZUdYKWCN5VTWJ8x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E4NKIqEd8K8vDjOzRr+t1v2u+3mplHWoF2/9jRyYYFsJhdmxbYCxdM8xGUGvBdPisd1R1faVHini3XnrxgcZsPrPgEyEDgmuLQvlyT8ChdAR5wUo3DWnDxc0uWtKRs3JvaHhgrbqg9W73xYBOTY9WThn6I77RcorYEiSVdNyaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHlaW8L8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so15533790a12.1;
        Tue, 01 Jul 2025 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751407384; x=1752012184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCH6UWaWdMtSV5w3YLUgKyRDkxeGFe8bXumroDH0Y/Y=;
        b=AHlaW8L8poAYNfhMAgrnvz8shBpO+4+lbBWtR+hkTeZV5oZ+jKmY5cKbtdfWZ6DzaP
         wJGE03BXi78yXgJAx3pLK02YHbBF3HbM2mYAwJ0FyK/S44O1gviC61IVn7zWIAXcJq3/
         S11k5lvOQq6wGZaVXT91tXM8gsdRNOuBk0Xpmu4m+EIxKcTS9Oyshx7/l6i1c3409XxC
         sXA0UQ8ctt33EO1dlt6IJVMGwpledBntDYiYdxus9UAocs4RsOBs67ga9mOAgScnF+uI
         ZR/O8ofhNCjcVYhG3Cpo3FT4+q/TmWWebaTbRS4uQ4h2SpPe+qh5d1gSqws4tG/weKMO
         f7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407384; x=1752012184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCH6UWaWdMtSV5w3YLUgKyRDkxeGFe8bXumroDH0Y/Y=;
        b=p+1UTQ0U/m9qZO5HEbhrJpVJtPGqqtn7hxm457zc+cFgHEzjrueFUZtci8BU5RSJY0
         yNsKh76UO8l6ZNjrBOoBEmSJtlL4vVgdpZ/JxnJ+ER0nMBDShF3CKni6VEZ52n9uj7Mw
         6LjJYABolv5TFr+6piVfOH4Ry8K9pQDHaaqBSJQ6pVRCtK3/by2WGTyuR1Osf3MAXoca
         88Wor6dK3XeCwERDecWmIxIekvFgYfTpfTXoFbzYOyeyFgD/Rn58+mnWUDGbTnKHzsIS
         bYPfJaH6+t11TV4NxD0h7BH1huZrPBm16xwMocceb7Wu4KwbETlBZB/z4mW859tCPYWV
         nasA==
X-Forwarded-Encrypted: i=1; AJvYcCV2rKvPPV+Fb7wM/XATbzBK3KXUXOs0FykU9b146dSC3PM3rr8YHjiYc2W4umWaVN1fpM1RzQokXUE+WR8=@vger.kernel.org, AJvYcCVNYVJz1IoTIBYerwDJ/y+LNRp0DtnzqwEQ7C3OF8wjmK6szzH4UKFiD5AUVSvXyMwmHuiH7ArnjOFG@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9LySHQZxbNN0m6HJLIOzz3NlSh8+GOA8KaGC5ngGm+b27jBh
	TY0EClxwj/R0Mi67tTGehhEK9Zrm2XHeZOxwIdEYYcPF2TtK0QMSYO8AJ1Eceg==
X-Gm-Gg: ASbGnctpjn4H4ZEa//0RVI6Wy+BrUp66Pp3WWMwqH3GSQrw+5Rj8KIM8c4J/EKW1p1a
	HBFzGKol9ZYzBkfjqOnlu63FL/j/1pGXrI03X+KAHf1h/tJ4uaLZ8Vyx7nTpQD6P4xHJYT+HuTp
	nzn0tFBNL7278gaoy37h5vAF97Tq+3bs0IbpBkW//K/fYqh9QIPWyAZq7jlJab22KgcCVh4Im/y
	UHGIZ3T8pk9Qc6fVUGK1+v84QIpV05O1UiGSjMXOIcU7cGoNB3GvPcSUicdDE6yCCxt8AubzANd
	er43DvE5uz1QVlJ+29lsX9JrAuiM+LPfKvruBOzp1fYv4so08n3bHgyq97eXMN0r7+RN+nl6PEQ
	GrP3qqW2VgmqeHa2xbBVc138iaigSeiOBlg==
X-Google-Smtp-Source: AGHT+IGb0hSrbnoMf338DLIN4x8Shdh32qqzM9p3b8N6w2kChFiXV5nx4bbPUXJPHmioNc/LM3NIog==
X-Received: by 2002:a17:907:9448:b0:ae3:6dc7:1ac3 with SMTP id a640c23a62f3a-ae3c399eaf1mr20986466b.15.1751407383224;
        Tue, 01 Jul 2025 15:03:03 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a16asm959756266b.72.2025.07.01.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:03:02 -0700 (PDT)
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
Subject: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
Date: Tue,  1 Jul 2025 18:01:47 -0400
Message-Id: <20250701220147.1007786-1-laurentiumihalcea111@gmail.com>
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
 drivers/pwm/pwm-imx-tpm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 7ee7b65b9b90..30f271826aed 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -204,6 +204,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 
+		/*
+		 * VERY IMPORTANT: if CMOD is set to 0 then writing
+		 * MOD will NOT reset the value of the TPM counter.
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


