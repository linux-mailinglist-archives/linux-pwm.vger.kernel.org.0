Return-Path: <linux-pwm+bounces-4209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0339E28E6
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325E116974F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5831FA251;
	Tue,  3 Dec 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NV1ep21B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA81F8F16
	for <linux-pwm@vger.kernel.org>; Tue,  3 Dec 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246196; cv=none; b=HA757rIcp5bwoIUqYbbuOkC83XdQGKAI4w4VcnBdXPGRVZw1Ah6d/uW2mKiVGRuyQOfgBZ66Env7FhuE38VbkM14vLXvSAulj0AWwdzd+sK7IYJwHjQXaMw6gDVhTByCDh1zduNMh5vZs5+7W1bbRXYAoOW4uRraSYU32f+lyUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246196; c=relaxed/simple;
	bh=2uNM5E79VqxO+4hWUeY8pC50c4tRPQ6CI6tgNwDKkk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g00XxKd0ocByooAAWXIBNNG7dziJ/bDwCGoOWRsFDzGpOUEaW2MrUiPc0c8fJ/02rBluyxCnfojouz1AvRvyH9XFyQhx+478ehBymGd1YTvywLB/NlsxO6E+mSfJ55E8pzMG21VllMapsAPkrKzlcASQWX4MbQwNHFFHCyPiVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NV1ep21B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2030607f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 03 Dec 2024 09:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733246191; x=1733850991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0uKqW9vvWRGO5PxCSBAB7Ojpuf7zy1ETNyv1ImS+4k=;
        b=NV1ep21BpNacHxFMpf9WGWzWPxYqlR/ltnKnMZFNF9+uCxUo4eP947/79/Pjzqz1id
         NH4Hk6+To5RIipxdlmRhDFt7S4lL1s+5qJ3Y9cSLIT7E62KaS2TYPTLTJKHLgjaoxAq5
         nBTwaOuwGTFvdAR/a/o8H5l+OXJIyOVnlq39xnbmKEFA6rc5KUZ/fSY/6fDiY5E7Y0rK
         9ETC48OmkMSerEwZElprc4UseHEAdF66HxRMLB3xn8l1HoBWuN0BzPjWgct2zIlpKZcO
         s6lnd2t+Q09g/QPAjC2qhdfLImCgxdhFjjqV/SKbbQ0UULFxgbnDR4rfy4vRKH5hfr47
         F8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246191; x=1733850991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0uKqW9vvWRGO5PxCSBAB7Ojpuf7zy1ETNyv1ImS+4k=;
        b=Z/cNZxKyhISV9r4XNA9lvjVDLgTmUn998HevTFUvhY5Km8ZGv5ePAgaBhybY8bXP//
         iubMhjbfrP+nCXVMRjHlbLNM3nLsisG0iWbe3TVdDiRMBKbKtJtFxbr6XfIw/nviFi7D
         LjE3irP8OyA3WPbJ83EibHIiOeW+lRYOKfPtZ5KM7O9qi6j3jlypqkuMJizyXV9E5+HQ
         xRPdOiNnXK6TZQ/V4TDPyfGkMDCAK1weEoy1yu3gHGK04qFDZHCifkNSDWSKYtttpGgm
         bj3a/JtetObnt00C3KHIVbP5QyPgLCSaxdpONJxbQw7fSJiNzwWIFijP4QYNrR13Nu2J
         874Q==
X-Gm-Message-State: AOJu0YyQPXM7OCih+0eVhnWzEiaQO5gGsXSHK96qgnoGtt9qWwwGe+lb
	ud+WMjqG1AxSEuYZq240plSVGsrGwvpD2tioqKo8cjDcRK/Rpz4l8YHh1ZGoTY1qloRiBVHz8bn
	rKjA=
X-Gm-Gg: ASbGncu7xteI1xTX4pP646WvFHsEIt/OfsWb1ElGalB/aJ7mElsHSVDWEoUdwUgsOUg
	esgJnG58UleFyHj7E2tt6epmg2ZspUnHr/O7+j2eZchzrASdtobU5FQRHoK7QRyylnvZSL03Dra
	SakyYqKm0dtd2rNGWQk4lsnUxcCwpNYIWlYfWZSNCj1Bm4GDpggalp73a9OjN72pGAfEeg2criI
	8V+/XVYZYvz9irx8T+90dsBoS1muNhmF4rU/H2A7jVmX6h32WonaT7i7DW/koZ/7XlQjWFhQD+9
	b81X
X-Google-Smtp-Source: AGHT+IFw3vi5gBv/+PBzElsQLFBW8gwbgc04WQ/TBWmy09BS1Trc/+BXbDqi3tSXKRTkK7KTyJorug==
X-Received: by 2002:a05:6000:1885:b0:382:5010:c8de with SMTP id ffacd0b85a97d-38607c164f8mr1074793f8f.46.1733246190826;
        Tue, 03 Dec 2024 09:16:30 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a56fsm15903085f8f.62.2024.12.03.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:16:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] pwm: lpss: Move namespace import into a header
Date: Tue,  3 Dec 2024 18:16:14 +0100
Message-ID:  <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733245406.git.ukleinek@kernel.org>
References: <cover.1733245406.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2uNM5E79VqxO+4hWUeY8pC50c4tRPQ6CI6tgNwDKkk4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnTzzhhbwznRnHJ5gKYcuhn7fYxxBWZBHiXgPJb cl1DuWrimGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0884QAKCRCPgPtYfRL+ TiknB/4jRyiWRDxkq5fCwPAgnXM3JxY4Neg/HTlIp9XiCARliVwvrg3pyDItMmDKwM7dN0eSaHJ Pa+JsdGwMEykPW1V0MfxOKe2i0y+3FmXJ1mZZUwezjCAzH47bTyHuzV9XIoQcK633xy4Uyr9wCO BhBMkUae4uh4z7nL5fbaR/BX3e00eoNahJP7KzQrXM4FCf1AZWLVPirqK33/9mK0sNBR6zYGwtO DK51mkVF09gU4TS6q8j8KYL7vBMq9w+FSJRZZnyBWu7bB8vom5U2KTCKjIbqeYZ7AsPbOti7Djn C/SB6uDAg+gqqYB+zRGX3Y1xapfc3Er2UvYqai5VgfNSMSCh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Each user of the exported symbols related to the pwm-lpss driver needs
to import the matching namespace. So this can just be done in the header
together with the prototypes.

This fixes drivers/pinctrl/intel/pinctrl-intel.c which failed to import
that namespace before. (However this didn't hurt because the pwm-lpss
module namespace isn't used; see the next commit.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpss-pci.c                 | 2 --
 drivers/pwm/pwm-lpss-platform.c            | 2 --
 include/linux/platform_data/x86/pwm-lpss.h | 7 +++++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index f7ece2809e6b..8615c44c1034 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 
@@ -70,4 +69,3 @@ module_pci_driver(pwm_lpss_driver_pci);
 
 MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS(PWM_LPSS);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 5130238a4567..3de1ab2cff54 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -9,7 +9,6 @@
 
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -78,5 +77,4 @@ module_platform_driver(pwm_lpss_driver_platform);
 
 MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS(PWM_LPSS);
 MODULE_ALIAS("platform:pwm-lpss");
diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
index 752c06b47cc8..0a1025f6cd58 100644
--- a/include/linux/platform_data/x86/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -4,6 +4,7 @@
 #ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
 #define __PLATFORM_DATA_X86_PWM_LPSS_H
 
+#include <linux/module.h>
 #include <linux/types.h>
 
 struct device;
@@ -30,4 +31,10 @@ struct pwm_lpss_boardinfo {
 struct pwm_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
+/*
+ * The above function and the pwm_lpss_boardinfo variables in
+ * drivers/pwm/pwm-lpss.h are defined in the PWM_LPSS namespace.
+ */
+MODULE_IMPORT_NS(PWM_LPSS);
+
 #endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.45.2


