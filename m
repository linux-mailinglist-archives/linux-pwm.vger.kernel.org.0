Return-Path: <linux-pwm+bounces-7716-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC219C9072F
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0408E3AC7C4
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352F23EABA;
	Fri, 28 Nov 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RejUQTOP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BE22576E
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290355; cv=none; b=QpAH5qtg5MtE2Pg6JxpV9m48M+w9cc5Ie9oAidStKQ+4gnvHTgUr/ugGXjt+0rsL+AyeAoIY8S3Vq9vAzezxkoriMwc77THPrZvTii8RJLN3UOzM5I93AKeQxQczIfhfteBAuHqypZNBrmVziJTJaHORNof8ZUl6g+gpGiROMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290355; c=relaxed/simple;
	bh=0934+bSiJ2Z4mXmDX3e0h4Pf0OOK+y99hv9QA/noWsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDmebth58d6a2U0LIb7m8MjdD1B678oTmqRrUvrCftkIjrnH8Uf4AdOE0EMVJJL10tfnNtpXxww+7QGKCaTumkJDcjKc7DyW/ZdP4055vtW0eqOGUkCVasZQ6dG/ysDTw4Wd+mT8eusHylV4BvIX3x1f+Vx9KkfmJbzOxZNExAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RejUQTOP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297f35be2ffso19963135ad.2
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290352; x=1764895152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aA/LsEslWvpzWKeQJ38j/1AaTOTXSkciWttBYTw580=;
        b=RejUQTOPl/T4ZKIMMro05OtkstTUJtGkFJOiwBxVsoQINxNvbNiAL+n8hTpCJHz+yG
         rR3Bf0W/DZqbpzTK0GSUrOAN8URVOrcycOTdBS3PjS7HM5s/wC3vRooglKtn0TNuqVEy
         V0pyxiPMVG6CFjXTYTmyhK92oDfkOkS6fBwI+buswOQ7DhpH9Gt769s2KwF9zdi1Eu1f
         F03dAaeccdz8VJ1JgKSFMRnpkP81exyqYdt+Jpr8Y/ZyGm3qNa1LhlhNzdT+in/9E789
         Te9BLKWKebHInO86kREeckWBuBYTq/pY4A4i5Q/7CCEFvFssJ3C3HPCl1rdkr/gFGn/R
         ACmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290352; x=1764895152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+aA/LsEslWvpzWKeQJ38j/1AaTOTXSkciWttBYTw580=;
        b=sFDibWxTgWWcMrQvcJpcZQXVejiJ9Rvk7zy+kmM1ln0oI1nx6EJSyvCrIlJ+7w9rrk
         Bzvy43wKay/NZS8aYPDCwuxpXU9zJ7N7P8VEmGMW5RR71Y7H9noOUNoYnrzPd86hRzSQ
         dTNTlPbnh/TjXZuOeW2URhrkOttJYv1s9J1SmoEFLgG9hgzoXBgYdmtYodiyYuIUaZLY
         uu7FJrY4Da6wUCBQybQySFFBUty9Mbbk5kHQQE55rsbev1nk1xgyQKwNLiCX6N5nGCR2
         9uQ4kcnorQPb53IoEngWKQLoPgnG4XfU1ShFGPE+qlh3FueYqkWAZiHSWTD3AshV4Rob
         9PAw==
X-Forwarded-Encrypted: i=1; AJvYcCV8RLP6T+S1mfVG+U1l7gXM6Nd//P/ce2e/1qwABUOK7KYc3qvrs2mG0PpmlVicuR3+O53Pcg0cRR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKaO9aXmQcK3ZchRbxQnhejLlqyEjqllaBW9W12Z7m3yYp9As
	uNcvLpul2p3lgZlLho9uAqM1FVkciefN08mOn89JIjJIzL7TLWZ6ucdNZXxY4w==
X-Gm-Gg: ASbGnctEqlTaW+IGp9hkw7AgEExfqTR2+sCbzz8v3+/TJwzCc/mr4jZtGpQ499ygrGC
	o8UTobmHN6bRCpaBKviRblNqXZcvUQgYvyOr7Y7H78jxMfQvpxgMAlXpiTPRIglfzjlQFkLASu0
	6KpttQvtg81LtpVjbTXA72y597GZZD3U380cARZzdW8XHTDKD3IrOnwodld/wzREUciEAd7bLtg
	hEBjTIUd+fY+SkVdjqNUNCjTY3jrTDSkV9aLZeXlmho7lxq2ogbfa+WcpDIB0dU/NuWgKXmOpDK
	uhi16yQr8TJ0IjiGwTZ7kzCK9Vicuk+IQKILJGgjsyUWld6IZW5JGm6UWryVSkMb4N4TOE8Frgm
	/rpzIxsmhBKo8SXkS3CtWEx+V4rwvwh6kjPFgwap/bojeZslBZ/k9zGJElib9wjb5sso50NP1LV
	1gZswZ0lvCSzA39JHP++f8oHDuvDQGmdN4JJgre06Ylrs=
X-Google-Smtp-Source: AGHT+IEjlnoNTocDociQAHaL+fpeL4UggyTSu4BsSzWnQSPn4DTOBaikAJJV5wm877D240rjdfSe4Q==
X-Received: by 2002:a05:7022:218:b0:11c:b3ae:c9f1 with SMTP id a92af1059eb24-11cb3aecb16mr9003587c88.1.1764290352343;
        Thu, 27 Nov 2025 16:39:12 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:39:11 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 7/9] pwm: tiehrpwm: unify AQ setup and cover compare-down events
Date: Thu, 27 Nov 2025 21:36:32 -0300
Message-ID: <20251128003634.247529-8-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor ehrpwm_pwm_config() to share the Action-Qualifier setup between
channels A and B. Select the channel-specific compare register, AQCTL
register and polarity presets (up/down, normal/inverse) once, then
derive the AQCTL value from the requested polarity.

While doing so, extend the AQCTL mask to include both up- and
down-compare fields (CAU/CAD for channel A, CBU/CBD for channel B) and
clear all compare actions when the duty cycle exceeds the period,
instead of only masking CAU/CBU.

For the currently used up-count mode this does not change the effective
output waveform, but it keeps the compare-down configuration consistent
with the compare-up presets and makes the logic easier to extend (e.g.
to up-down modes) in future changes.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 52 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index e8bcf1ffa770..6a792faa62ce 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -242,6 +242,8 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int i, cmp_reg;
 	unsigned long long c;
 	u16 aqctl_val, aqctl_mask;
+	u16 up_normal, up_inverse;
+	u16 dn_normal, dn_inverse;
 	unsigned int aqctl_reg;
 
 	if (period_ns > NSEC_PER_SEC)
@@ -299,39 +301,39 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL,  TIEHRPWM_TBCTL_PRESCALE_MASK, tb_divval);
 
+	/* Select channel-specific registers and presets once */
 	if (pwm->hwpwm == 1) {
-		/* Channel 1 configured with compare B register */
-		cmp_reg = TIEHRPWM_CMPB;
-
+		/* Channel B uses CMPB and AQCTLB */
+		cmp_reg   = TIEHRPWM_CMPB;
 		aqctl_reg = TIEHRPWM_AQCTLB;
-		aqctl_mask = TIEHRPWM_AQCTL_CBU_MASK;
-
-		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = TIEHRPWM_AQCTL_CHB_UP_POLINVERSE;
-		else
-			aqctl_val = TIEHRPWM_AQCTL_CHB_UP_POLNORMAL;
-
-		/* if duty_cycle is big, don't toggle on CBU */
-		if (duty_cycles > period_cycles)
-			aqctl_val &= ~TIEHRPWM_AQCTL_CBU_MASK;
+		aqctl_mask = TIEHRPWM_AQCTL_CBU_MASK | TIEHRPWM_AQCTL_CBD_MASK;
 
+		up_normal  = TIEHRPWM_AQCTL_CHB_UP_POLNORMAL;
+		up_inverse = TIEHRPWM_AQCTL_CHB_UP_POLINVERSE;
+		dn_normal  = TIEHRPWM_AQCTL_CHB_DN_POLNORMAL;
+		dn_inverse = TIEHRPWM_AQCTL_CHB_DN_POLINVERSE;
 	} else {
-		/* Channel 0 configured with compare A register */
-		cmp_reg = TIEHRPWM_CMPA;
-
+		/* Channel A uses CMPA and AQCTLA */
+		cmp_reg   = TIEHRPWM_CMPA;
 		aqctl_reg = TIEHRPWM_AQCTLA;
-		aqctl_mask = TIEHRPWM_AQCTL_CAU_MASK;
+		aqctl_mask = TIEHRPWM_AQCTL_CAU_MASK | TIEHRPWM_AQCTL_CAD_MASK;
 
-		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = TIEHRPWM_AQCTL_CHA_UP_POLINVERSE;
-		else
-			aqctl_val = TIEHRPWM_AQCTL_CHA_UP_POLNORMAL;
-
-		/* if duty_cycle is big, don't toggle on CAU */
-		if (duty_cycles > period_cycles)
-			aqctl_val &= ~TIEHRPWM_AQCTL_CAU_MASK;
+		up_normal  = TIEHRPWM_AQCTL_CHA_UP_POLNORMAL;
+		up_inverse = TIEHRPWM_AQCTL_CHA_UP_POLINVERSE;
+		dn_normal  = TIEHRPWM_AQCTL_CHA_DN_POLNORMAL;
+		dn_inverse = TIEHRPWM_AQCTL_CHA_DN_POLINVERSE;
 	}
 
+	/* Select polarity (up + down) */
+	if (polarity == PWM_POLARITY_INVERSED)
+		aqctl_val = up_inverse | dn_inverse;
+	else
+		aqctl_val = up_normal | dn_normal;
+
+	/* If duty is larger than period, don't toggle on compare events */
+	if (duty_cycles > period_cycles)
+		aqctl_val &= ~aqctl_mask;
+
 	aqctl_mask |= TIEHRPWM_AQCTL_PRD_MASK | TIEHRPWM_AQCTL_ZRO_MASK;
 	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
 
-- 
2.43.0


