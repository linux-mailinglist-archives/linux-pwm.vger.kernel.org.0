Return-Path: <linux-pwm+bounces-4151-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7EE9DAF3C
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Nov 2024 23:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9DB165FFD
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Nov 2024 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225F4193081;
	Wed, 27 Nov 2024 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyGJW5bf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF87145B38;
	Wed, 27 Nov 2024 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732746464; cv=none; b=RCnAMlcpMta0M7Qx7+JF7HI/IMpkbPVvmEmDbB8eZmDSTOZAfrCs/oATdI6sqbQqA56k+W0glQOrEOToXNMwTNvbIlPFFMrRj6Elt4b2XCOkw0O77kQWi0LvwQIVPiV+DRBUyEAukxd4ZSuuDIsA1JlTL/Az5CE8hlBI1NkkH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732746464; c=relaxed/simple;
	bh=Td3sgkZ6+Ck5uFrMirL1lKd6UafJ+7h2HnViN+l7fG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlufAevLWmm+g507Pb7kyj/GUsVBm1bISvlW7IbC1urQjsq4bragerzD+Jwbi5sZrpeLItITH+2f/e2vi6eJyKXgDfAQROCX78qdIIQMMljebooLtfOqISaXpZc6MJgyens3speW4qikODWI8rlXmzGK42iKZsqp+EDSnRniL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyGJW5bf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-212008b0d6eso1302895ad.3;
        Wed, 27 Nov 2024 14:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732746462; x=1733351262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o1XnOWhQLAiIgeIp3RNKNLcKOvXKtzxAz+AeJhZsw4=;
        b=YyGJW5bf7+nL3qMsXw04e3jnpbK0JEhT9THq54fov6RIHc9WRVvRwhMxkC1RlmuYWU
         +YPc5P4hf4fp25zFr/Ct1v5FgrdBkzmAPYcW5XDjkzrlE5QF83aZySea5yQ+phnislpD
         qSjoIJGgXQiw+P/suQ961M1Tx6vtyWsYGIEUisKQytZ2SBebx1OGytpqb2YzYPjeevEJ
         FWEtpb4exjZk7coCNtt1ru/5JLtuX0upJEkOoOJaOaKy/zrpyRaEdosOtfoyhVEtAbyJ
         CUwzFUzAMgk5apGvz6ftJ8P5+W4iP+mWprZqBDPn5KhA+RdM6Ezblpd7Ma8JoiBfVBay
         fWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732746462; x=1733351262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o1XnOWhQLAiIgeIp3RNKNLcKOvXKtzxAz+AeJhZsw4=;
        b=k0FGiPNbYNl15Eva74BaJuiHE1mgwK1HyQstaApeyYXRHNUzwEbzvpCE1zYGvHBkOL
         3CYRjQOxfNom06uN2uF7txNs2esB9qDTRkMX4OcalLKsCAtQa85TFUgY/xMc2WrYGW7g
         bTWHiZ73oWaxINQ82cOa1Xoo17yAYkC5isxsoTRz4UAssguJn8DTc/uTtzcNlnGz8O52
         LWIL9+q2gWTrsLWDijoGMA9W+a+hEawggDXFgHpcLrKSXUjDFRW52LCwas+553ShRUxP
         wBpN1CjbLnxYWlnRjZv29zKxTlYB7OEjwanofg+TsYzFGzTs7LjK3DjmOXhUNtWaWe8a
         X7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVzB9LCOFTT96laAq+aVFI51UIl2V0D2pnEEcBDthGC5+ndgRSrgOSExWyyo2U0i+FHLNSsm771P5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCfT4hSly3dDU5h5fhZsch1dfbrulfZF6T5w0nkAkSqxMwgyL
	+Off+EekClYBP6bg0f0X8PuYQpBybLG0gOUTs5wd/wqNECCZlNXN
X-Gm-Gg: ASbGnctCNhML3pURtEY0GRa9QVLdu9UYm8sW05D5I/KYx2THMLPMF5wWjoSsMLbus+l
	pda3ppfAPOQJfhEIeNxJYc1onNHAqlItOSkW2ssyABXJ+gXX29B42x0YbRawY1+npXcQVnJGRSc
	TG0DlABfufe0Xz5a5D4Z45PsIw/nrnZx+654D83CPa3eaoPbZ37R66Wirt+7JmYIT8TPBbe0SEk
	dpOKrcNVl/EH9e0T7Rr4XtHDR2YUIgqavpUR4ussOiMB38xBlaNuaLmGEU1fbTQT20yk58=
X-Google-Smtp-Source: AGHT+IFQgwHVWmEB7zGNoSSfoQOr6X/PLEdqwOLSCrvCFGIxDsfLQNTb/0zVJQb8NsUkUAtHMy5KTg==
X-Received: by 2002:a17:902:ecce:b0:20b:51b0:4b22 with SMTP id d9443c01a7336-21501e6c3e6mr52968415ad.47.1732746461795;
        Wed, 27 Nov 2024 14:27:41 -0800 (PST)
Received: from localhost.localdomain ([177.10.10.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176119asm77763b3a.21.2024.11.27.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:27:41 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v2] pwm: improve state handling in ehrpwm driver
Date: Wed, 27 Nov 2024 19:26:49 -0300
Message-Id: <20241127222649.6394-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <pujikyjijvcn3mmlayqmdkh5zyjqdrfmmz3jafxyhdhuo5ekam@ntttaqiw7iow>
References: <pujikyjijvcn3mmlayqmdkh5zyjqdrfmmz3jafxyhdhuo5ekam@ntttaqiw7iow>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce ehrpwm_is_enabled() to verify the module's enable/disable state
by checking the AQCSFRC and AQCTLA registers, instead of relying solely
on pwm->state.enabled. This ensures a more accurate representation of
the ePWM state in the kernel.

Previously, when performing fops operations directly in kernel space
after retrieving the platform device (pdev)—bypassing the sysfs interface—
pwm->state.enabled could incorrectly signal transitions between active
and inactive states, leading to inconsistent behavior.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
Hello Uwe,

Thank you very much for the feedback.

I understand your concern about the kernel layer structure, so I took 
a new approach that also fixes my problem, but this time without directly 
manipulating `pwm->state`, but rather through a double check of the registers
within `apply`.

I hope you can see the implementation and tell me, again, what you think.

Best regards

Changes in v2:
- Implemented `ehrpwm_is_enabled()` to check hardware registers instead of relying on `pwm->state.enabled`.
- Removed direct manipulation of `pwm->state` in `ehrpwm_pwm_apply()`.
- Addressed your feedback regarding kernel layer structure.

 drivers/pwm/pwm-tiehrpwm.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 9f939d535440..fdcda0ffc9db 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -387,6 +387,25 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
+static bool ehrpwm_is_enabled(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	bool ret;
+	u16 aqcsfrc_reg;
+	u16 aqctla_reg;
+	u8 csfa_bits;
+	
+	aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+	csfa_bits = (u8)(aqcsfrc_reg & AQCSFRC_CSFA_MASK);
+
+	aqctla_reg= readw(pc->mmio_base + AQCTLA);
+
+	ret = (csfa_bits != 0u) ? false :
+			(aqctla_reg == 0u) ? false : true;
+
+	return ret;
+}
+
 static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
@@ -404,7 +423,9 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	int err;
-	bool enabled = pwm->state.enabled;
+	bool enabled;
+
+	enabled = (ehrpwm_is_enabled(chip) | pwm->state.enabled);
 
 	if (state->polarity != pwm->state.polarity) {
 		if (enabled) {
@@ -417,10 +438,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return err;
 	}
 
-	if (!state->enabled) {
-		if (enabled)
-			ehrpwm_pwm_disable(chip, pwm);
+	if ((state->enabled != enabled) && (state->enabled == false)) {
+		ehrpwm_pwm_disable(chip, pwm);
 		return 0;
 	}
 
@@ -428,9 +447,10 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
-	if (!enabled)
+	if ((state->enabled != enabled) && (state->enabled == true)) {
 		err = ehrpwm_pwm_enable(chip, pwm);
+		return err;
+	}
 
 	return err;
 }
-- 
2.25.1


