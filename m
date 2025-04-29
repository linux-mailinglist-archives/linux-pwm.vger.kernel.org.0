Return-Path: <linux-pwm+bounces-5756-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5535AA063D
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E9746104E
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E259B29C33B;
	Tue, 29 Apr 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="U6UvPs1p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338928934B
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916730; cv=none; b=BlpKF+ACoq6+S+W44r8pcBuUS12Jo8JqNh4XyLlRpjbd8SHIFu/kvwQMkA6zYQOez8GU5Fp+o1tXENi4F4VBoiWAdikKby1obp7FsgsBHTO8HV5EbhwrXf99I/oaHP9eCzAAEZKbsRLmAMfd3jBltBDFPMIC1VTkvM9b0iQIYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916730; c=relaxed/simple;
	bh=+TPnSjs8Rsq4uRl5xcYrXceVeJccwtQIFJM7/CmqG6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSobT+jUjk9M4YjXxKlQUN8UBvyGN0F7rReB82hxho/fSO64XTEEJ7wQGdoKXRrC2BJ9iEVrKDiMUgRG4e0tOccOk+bpuW7iEznaECzvP4y0FpAlrN7SITJHQ2yQ59PUWENhOQj4QQNdaMeqIcIu1QZ48YBesR+ejRX4BP5TzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=U6UvPs1p; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so5727292a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745916728; x=1746521528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSBQlgtaQud3VdsTPycKFsE/56jYgj1sJoxgbag7Muo=;
        b=U6UvPs1paTyar70Oik57kCSUIKIxlb+rpkLmOPF98ua6rPQ2edpzu6DiGhK9jonCWb
         wOyzrJ1FZTgb/oxDZMRyzGECzG7rdryt5V00ztOwW6617Dtoz6pReEqGhk2tibMXUHZj
         RDaoM2PsfMf+xoITQItuDRvNnTbjHFGFMUGtBxYPeejwYjtJrJLPGutmiPiVHbQ6Chuf
         7ycUhj/D09sI9Yep/wYYZFXiVCl0T0wIB7I6sANbm7xdetNB7woH+o4VPx6R5ncLFWcL
         3MXnWhVaL59NxczQKiRqh5JGnQDgasjmMr/9i0FS/K+QtmVul4or3C15jJoIjtzzgb4k
         DqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916728; x=1746521528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSBQlgtaQud3VdsTPycKFsE/56jYgj1sJoxgbag7Muo=;
        b=PuYQsm2mh3X9spuAIFBaUup3avNNCJl9prfrz1B+9bTTyi8NKxlmgrOdYWMvEuwjjC
         8uMe/xH0A8PlpDT7IHThHl16WC9O5RM1q9Jt703fQmjywFc5JW63eQT8AIUcwA/xNbpV
         4R6ExpTYbj2PUkFPIwuu8RbnkztG03R0oJkY+xgrzY8SKr0J6H0uB2/AeliM8EnCiWRR
         oxFchS8Y2aHe+SP58UCXRbB46kSF0ZskYoFgL4Z1C5u34iYkBmxxwAiTwaVlJ7qTeY1s
         mZ+0VK0ogTTMbFLouVlvWYpRIy8CjahIV9+4/gtGEyzAkQ8Jm/K+7mFPeK9UIr4mN+M0
         PF6A==
X-Forwarded-Encrypted: i=1; AJvYcCVrgZyJeiV9pHLChMzff/86A+rhdUiXRTg/Ucc2dNwggpSo5MY1qZ/OZV1kpZzqIgaTFpK/g9rcDTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSQct3d5GPZ8XYdowFO2/DAPZt0Jr/xjKyEgT0Zi5oQplVfjO
	JFPFHp3nzaW3L8BIntNowM54K0BqYFALLxQx3HuxkS1ni/hYlPmlL9fMDYEClcc=
X-Gm-Gg: ASbGncvfG4UMJC5Wz7EUC/mh9dWOYCuheN0XFR8A/PdUWqIt6+xvuV1sXnXcmancdS0
	w+pCTe5DPfetBiQxWNy8sCg8cTBtaETWhPcP+mZzNVoZ0uZlwWkOljwgXE9RfLpAkgewZ9Iih7s
	f3IZlSbhxLF+nXXj6mP5GpwSWX6dXjoTX+XTBOtx3uFxUwx2etZah9siqddZPwFhtBdCy+Qxnn9
	s9HUXlHKM5HygwmAxOjxCjk0UYyj12H6ux5ktkH+r7g6iGngUKvJkn1mYSZuyxncdVO0VSi7oSD
	FGkNHNCkG2pUk3Vk7UL2++ndKnDqkYWDgJUzhlHDt9SRIl0afPJgQNY3M51s4NSHSEpXrc++u5l
	WNX1pw5qRBEj+RvE=
X-Google-Smtp-Source: AGHT+IFKhORMMaDYdgpl/9rwoGwyfPRj2XbuzQCabPPPwxwDnPG2aYuvtb08xMFG1iEWZeP3qzi2Vw==
X-Received: by 2002:a05:6a21:3a44:b0:1f5:6e71:e55 with SMTP id adf61e73a8af0-2095907d1bamr3201920637.6.1745916728038;
        Tue, 29 Apr 2025 01:52:08 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm8550119a12.44.2025.04.29.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:52:07 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v3 5/6] pwm: Kconfig: add depends on ARCH_SPACEMIT to PWM_PXA
Date: Tue, 29 Apr 2025 16:50:47 +0800
Message-ID: <20250429085048.1310409-6-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
References: <20250429085048.1310409-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC uses PWM_PXA driver.

Update the Kconfig file for the PWM_PXA driver to allow
the SpacemiT K1 SoC to use it.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change
v2: No change

 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4731d5b90d7e..6731669e724e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -493,7 +493,7 @@ config PWM_PCA9685
 
 config PWM_PXA
 	tristate "PXA PWM support"
-	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
+	depends on ARCH_PXA || ARCH_MMP || ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for PXA.
-- 
2.43.0


