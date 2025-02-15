Return-Path: <linux-pwm+bounces-4919-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ADCA36ED7
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412A27A2E9F
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Feb 2025 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EE1D79A9;
	Sat, 15 Feb 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qJnsPbIf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E021A2643
	for <linux-pwm@vger.kernel.org>; Sat, 15 Feb 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630265; cv=none; b=bIgF5BIpAdrjMwNh7XQOSMQHRHCVYJ0o5hw11ND/orhG3DSmRJ/C4JVOF7fcsHdjbaqpeK0SK2Oz/8BxzbatCmckPG7CotCVEnl3X5Dyb62QUhOetScX0HLIEHjbN/LhQ/YJKyfYz/2A05LE26DOZRk2tH23MbvEfgZrvR2RcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630265; c=relaxed/simple;
	bh=7EURNpoHSBP3WHFlLw0KLAnxXhoJ+QFpagdnWt5h0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gcs/FVpfCd+HXQ30xuZOP2tN56yJlecvPECetiQV3wJjdMsT2crDNnOrzB/aCKJMDm2x+hMtpGz+gr7/9vhXpSmZi2/8M5bJS8HnATF7a1PZjCuLB36YYPhbWuvUiV7sCNzvEap961xvoTuNz3Idsbg6crQ6FC7QsrSvrqYjClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qJnsPbIf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5deb0ea1129so4840769a12.3
        for <linux-pwm@vger.kernel.org>; Sat, 15 Feb 2025 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739630260; x=1740235060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSaNx8YQ2EWhxCnCr/97FLvnOt+570/h4vEIeiMge+k=;
        b=qJnsPbIf0uGnTrNR1olvhal7sC0fH3mZ+XosD9PGt+suyaefgvuaU7OibI6/mJ6X9w
         8fHBfeuwIrvakfn5kbHZdeUMOnzx+tGJAC+mHxXNnyaQHoOTtTKxjCKY57BHeritVvdJ
         dqjWs3e4pA/+VovcNYcstl//08Ps3AHQgRxjtdq4Snx2fkaGp12Hz6zrs0e1aNuVi5K9
         Be2OHmRmbRsLfGsteBYxojSA41dBQFl/sl2ZJLVUA/fJQFYG4xC4UJqpUyIPmabQcQsU
         dOOUqZeOtynMcyYouw3YqgzVywJJko6RRnaW+lTicWMWWTqCyMorw2gAqCJbD+nsonax
         Dihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739630260; x=1740235060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSaNx8YQ2EWhxCnCr/97FLvnOt+570/h4vEIeiMge+k=;
        b=kG7iU1Vuw3mQVVI6UxGnfEonWnTxog9TfMDcr6gNCc7kCkl2pN2dwWvMoqKp7XVEVE
         M4dH5Tc2jJhRGuIHwHSWeE3yfQRAeYFtK/QdUbW8ykqdtaZewfyz2vsXFkRKvuglkS6v
         HwCBPs9n6gwJz/PuDaTzHPXjAsxug9SUvgrDSWtnw+gDGvz7nOOMUKNottgcFdTeeZ5+
         q2tQHBNZ7NnGkEimIBNehZ0nDVQt3v7ASReVywNp9HchMJ94t+S8aYJt3OiVr3xazpyu
         uMMIRSdU2PdxfUmJZTltcb3AXwpBXTlNVYL0pod1uD7ih2hnSTjr9sCtb3O0/ERkNmyv
         nBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOaE+KUSdhTboVTY3+KklrCtNRcoqEupBFM+n2w0Ot5L/NnY7vUdc+gUXx6iMIBKu5TVyTOI2X/a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4WRNRfiWudCqm2WyIkh9REFSlQwZEZMgeelzNilmCKnSMvuC
	bko4RXrANlYSW9VWseVZwG8FDuwTSI1OQ5yMAiTnyEXFIxVxVf9tNDUr2GlievQ=
X-Gm-Gg: ASbGnctDeKgDfs5FkjSFOhMvN6mn0H7/qsB7FDcyn8xeHy5OYZ6mliM+jj4Y/iG2EdV
	cwwNNMsXLJt2QQ30uV2EjcZVH+nJ8hvCAVXK7KjdAvZxFad32LNkDMe7DuzLxmkXOb/Rff1Ywls
	7FrLcIr+d1GI+0J6bw4X3SCJQTru6emOLn3Rj4zKED+dMaX6Qo3Qn1vzolFRJZbINfYqaLGSwHI
	3V5x026vk6tkNMPb1sF3nbs0IdxFZyZ6eQLA7pOSwXoxJftL50+CX57KPLMofQcAizEYr96KwEf
	RU7X8+SNrE4dW8N+xwrJ
X-Google-Smtp-Source: AGHT+IFt+EQlS1yD/Pqn470UtSRXl2RwFv111R6YU8LvXgLUSAycfdItfiHCwgWYA+V/QSES0Rr1ew==
X-Received: by 2002:a17:906:30db:b0:ab6:f68c:746e with SMTP id a640c23a62f3a-abb70d7994bmr260292266b.41.1739630260245;
        Sat, 15 Feb 2025 06:37:40 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba569dd320sm508104466b.72.2025.02.15.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:37:39 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: stmpe: Allow to compile as a module
Date: Sat, 15 Feb 2025 15:37:22 +0100
Message-ID: <20250215143723.636591-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=7EURNpoHSBP3WHFlLw0KLAnxXhoJ+QFpagdnWt5h0qo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnsKajSFpSGYDQiIEQHcSvInMz9OmjgQlzntWWc Yw5UfZs1LaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7CmowAKCRCPgPtYfRL+ TnJ7B/wLIPZby+assjCEHqaTkuBWgWI4PjQyAydedxwVJ6OmtxlZm4lXOkuVb2m5Y7RFwydwZon uduuSGK539qG4tGVF/mcHOhcrRQxmgrWnJgFvaC0UivpfmPti0S5cbveo+ceIMYtHk9bNSHpI/T h/oyeSUcj+0NM5MoRLjf5qNpGfOFgfUuTIdDPtcEysOqS5IESFREXBp5xuYrrGzqDRDTbkHF+h6 6JNKF7pQ2wWw4KnltVBz+aZk6YCp1Cav8vSG1VBIDwBbfkb4W5UaGtD0MnBK4mQSsRL/pbdPyOg VglGaQanwAq3ajbxUGR7HoJqrvRrqK/6BYXbFVdgm/GFw7SJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

pwm-stmpe is the only driver that cannot be built as a module. Add the
necessary boilerplate to also make this driver modular.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/Kconfig     |  2 +-
 drivers/pwm/pwm-stmpe.c | 25 +++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ec85f3895936..35559b541f89 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -646,7 +646,7 @@ config PWM_STM32_LP
 	  will be called pwm-stm32-lp.
 
 config PWM_STMPE
-	bool "STMPE expander PWM export"
+	tristate "STMPE expander PWM export"
 	depends on MFD_STMPE
 	help
 	  This enables support for the PWMs found in the STMPE I/O
diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index bb91062d5f1d..73f12843999a 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -326,12 +326,33 @@ static int __init stmpe_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, chip);
+
 	return 0;
 }
 
+static void __exit stmpe_pwm_remove(struct platform_device *pdev)
+{
+	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+
+	pwmchip_remove(chip);
+	stmpe_disable(stmpe, STMPE_BLOCK_PWM);
+}
+
+/*
+ * stmpe_pwm_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
-static struct platform_driver stmpe_pwm_driver = {
+static struct platform_driver stmpe_pwm_driver __refdata = {
 	.driver = {
 		.name = "stmpe-pwm",
 	},
+	.remove = __exit_p(stmpe_pwm_remove),
 };
-builtin_platform_driver_probe(stmpe_pwm_driver, stmpe_pwm_probe);
+module_platform_driver_probe(stmpe_pwm_driver, stmpe_pwm_probe);
+
+MODULE_DESCRIPTION("STMPE expander PWM");
+MODULE_LICENSE("GPL");

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.47.1


