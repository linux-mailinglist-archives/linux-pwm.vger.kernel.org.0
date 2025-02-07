Return-Path: <linux-pwm+bounces-4828-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9EA2CFC2
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 22:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEE1884074
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3F188CB1;
	Fri,  7 Feb 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3sRilJw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E141624F6;
	Fri,  7 Feb 2025 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964093; cv=none; b=e7gOU5GfQcpt7ktVXRxLDgFN905KGIFlAk6Pw3ZdD25cDDmhDRXufivOfKkX3pH7bBn1jTpBd65HgBgmUTfRNSlTTySeM9WrEKHtWSt5kDbIDVVbxbU+VfiGZMoHivjzlIcdgXxDGKdj9LALH4kDYl0WG7+oP2VADkT++dAp+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964093; c=relaxed/simple;
	bh=oHqIAxLLmUR3pEzy/2FnGaRx286gjbFJrfZW4tLqDvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L9z7HxdpdfkK4lmOYOM97IFk1+O+8gfDQhaNGgL0qzdGXTRy+ng8R1/TSffJ6z1HmenF3mDR4AaDJrrBg5I4c9OBr2r8S6y9j9A0VkoVQaT46B2sIv0oR7nVQQO/HG1MaE1uYBWox5Awh4hk+1O0/XCvseNKuiaZgOIWTilamy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3sRilJw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so489227a91.0;
        Fri, 07 Feb 2025 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738964091; x=1739568891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhpHUagE52EKnmKOxCiQactoQqNbzbldiRwiK/u0V2Y=;
        b=W3sRilJwblEU8ytT4jDq58FwimtxLeZBvIviso3MsAY6Iyx8qoSE8GZwplgUoKvg/V
         XJoqGl3FgvPWB6Rmh1TnS31OEUxlBMQlRFCTzQtChAVZdbVRiLWpiQ//9+3xdMlxH+t/
         NlZxJaPPoVq8ByYNb30EWShwf6PZDD3RsjuqZf5KnNuEcMJ2F668S125Hn7ZRje7cZfQ
         In5UHJcYyEhWGPuCQoC39HnIagv4I8UqifRK21vKLGJ1pZRPHE9icm84bAxUCgdIhAda
         w1F002/8wRelEHN1UH8mATUk8HwLg9HTC9iR4mCQWoWDoxIuoGlmHueYB5rHMql8x3pJ
         gmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964091; x=1739568891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhpHUagE52EKnmKOxCiQactoQqNbzbldiRwiK/u0V2Y=;
        b=EZOr0UE+idsFRWWCVpC21Ljjdrkb4IMqPkMgFOh+FEeduMIWilixUW7CdZLrM6etc7
         sFEgyJWJqYu/C8t3yqndugmLM1paPkk5BDRNUFUhjUArXc8kSNFKlNUCstHe08ezqxrp
         iGNo3X2qzDDrz9v/+2KM+RNBtS34LFOqo9/oLk9gX70pdNFDoPoXBQLfI+RqWqei8fUs
         jLSMHauOiN/DR4VIyq8R2CE66hREP83Ig5lLM0RNuCYeBPZuXJkAOZ4WvK/6QvFk77ya
         fAlBfFGzCZ6TPXlZ7aY0HS1FUk/c61hcJuNJ1qw31pllV0JhMzwhEUK9gffUUXEeX+y9
         NcHw==
X-Forwarded-Encrypted: i=1; AJvYcCWdL+z4wsF5EZzMnJ5MeWdqyxBV42p5rv/wbxB52q+JYJl5gBW5/DGR0mEYXToVpEOECnnhytIuC/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7lvzEYtlkWxCEAXjrBiyJITTOFQQmWTcvgeu1reNO3fez3xq
	Y3K7UvmFWevxx6ii0iVXcwPVMsr5mwdLqupMRIMkmBs0WQYp7SLn
X-Gm-Gg: ASbGncsyNc/qw4PN/IPblgyk6ltGdBT1Gfal5etx8+9h7SevYwpfotnqhJQtmPP7rKg
	7kmkEzIqJSlrs10R/84R2Ox/zoTTwEWed9YEJQk+Kf+x6GoxAjD2TdQ5qxBqS82v4C1sxZaHEyE
	LtOpEvS+dmWfQY6IQHCp5ygJ2kEFEiyZ8JwuJGaLTnXp+xJrIcPjIZ521n6Nw/E76s7xBJTWvIp
	7MbosWWE/aBzwrMfI3DJnGZl924fk0er4TKPnA5wNxMlMQQe3De9YA+DJB0GJVpm4DPXSJZDkys
	ISGQGHxdV1etJ8gozwwgk1TDvTAD1xH9KGZK
X-Google-Smtp-Source: AGHT+IH29EBWiWhi59MN0hnX4gY7pFIziiMBMzTBvlNXyVzS0s7itND3mR8+5aMD7lXG0nEpeYPZDg==
X-Received: by 2002:a17:90b:3e8a:b0:2ee:d797:40a4 with SMTP id 98e67ed59e1d1-2fa2406925bmr7358951a91.8.1738964090784;
        Fri, 07 Feb 2025 13:34:50 -0800 (PST)
Received: from localhost.localdomain ([181.192.80.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa442524f7sm154535a91.21.2025.02.07.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:34:50 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v3 3/3] pwm: ehrpwm: ensure clock and runtime PM are enabled if hardware is active
Date: Fri,  7 Feb 2025 18:34:24 -0300
Message-Id: <20250207213424.1117-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207213234.1026-1-rafael.v.volkmer@gmail.com>
References: <20250207213234.1026-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During probe, if the hardware is already active, it is not guaranteed
that the clock is enabled. To address this, ehrpwm_pwm_probe() now
checks whether the PWM is enabled and ensures that the necessary
resources are initialized.

Changes:
- Call ehrpwm_get_state() during probe to check if the PWM is active.
- If the PWM is enabled, call clk_prepare_enable() to ensure the clock
is active.
- If the clock is successfully enabled, call pm_runtime_get_sync() to
manage power state.
- Handle failure cases by properly disabling and unpreparing the clock.

This ensures that the driver correctly handles cases where the hardware
is already in use at the time of initialization, preventing potential
failures due to uninitialized resources.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 52527136c507..30beaf7d1721 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -633,8 +633,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
+	struct pwm_state state;
 	struct pwm_chip *chip;
 	struct clk *clk;
+	bool tbclk_enabled;
 	int ret;
 
 	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
@@ -676,6 +678,18 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ehrpwm_get_state(chip, &chip->pwms[0], &state);
+
+	if (state.enabled == true) {
+		ret = clk_prepare_enable(pc->tbclk);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
+			goto err_pwmchip_remove;
+		}
+
+		tbclk_enabled = true;
+	}
+
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
@@ -685,10 +699,22 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
+	if (state.enabled == true) {
+		ret = pm_runtime_get_sync(&pdev->dev);
+		if (ret < 0) {
+			dev_err_probe(&pdev->dev, ret, "pm_runtime_get_sync() failed");
+			clk_disable_unprepare(pc->tbclk);
+			goto err_pwmchip_remove;
+		}
+	}
+
 	return 0;
 
+err_pwmchip_remove:
+	pwmchip_remove(chip);
 err_clk_unprepare:
-	clk_unprepare(pc->tbclk);
+	if (tbclk_enabled)
+		clk_unprepare(pc->tbclk);
 
 	return ret;
 }
-- 
2.25.1


