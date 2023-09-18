Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFB7A46DC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Sep 2023 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjIRKYU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Sep 2023 06:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbjIRKYN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Sep 2023 06:24:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C03D1
        for <linux-pwm@vger.kernel.org>; Mon, 18 Sep 2023 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695032647; x=1726568647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oxnn+JAZEE8hPmHrh9ukZdJa2snGqMK1HZnrC5y2JUI=;
  b=bwv6oIYwdzwamUu3TBCDUMzaNCAvIxRGmWv/uwLfHKwTIIDMSjxeRP0z
   jd47ghgugM5pVP99qMveyAvDVvlLYTjLMk161uhaznHT91dduzd/Fo2y/
   RYgBk5He1YF0fgEv25S/7MCmidnDSol4V0bmAb3LNtiPBom6FgVRENBar
   cXgua9igacU2gRtyoXz6UW29ECUp7QAC7HquPfCQKKaqtspSuAQ4IHxGQ
   dIHRr8n9FoPbYnplwwkqKKee5nfC+cPcLYiIAW5GG0+WDe03jYKvLa9nr
   +N66Vjo8P6LfoqonCTglIb0qoHSLlCpTohZwPAKKh97ZYDwaCeFEO7Sfh
   A==;
X-CSE-ConnectionGUID: MvVhTcQ8T0SDfTI7v0Zm4A==
X-CSE-MsgGUID: +jKSNMV+SLy5GUkiQmmYgg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="172195583"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 03:24:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 03:23:53 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 03:23:52 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-pwm@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1] pwm: microchip-core: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE
Date:   Mon, 18 Sep 2023 11:23:27 +0100
Message-ID: <20230918-finisher-eliminate-b9cacc9d86eb@wendy>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=oxnn+JAZEE8hPmHrh9ukZdJa2snGqMK1HZnrC5y2JUI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkcqrJGbH5GTg3bp8a7C63PEUiVzmgTOFJi7tlV1MJ93dL2 FWdHKQuDGAeDrJgiS+Ltvhap9X9cdjj3vIWZw8oEMoSBi1MAJnJWkuF//WR56TStmsB5097fiBb/PO 99iFN5klvxEZ/jlytj78iEMfzTrvALqbhkY7Cw4Vd9cM+pM/ynnp7ftXvD7bXM6hfqFggwAQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
use of such symbols on other architectures, convert the Microchip FPGA
PWM driver to use the new symbol.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
CC: linux-pwm@vger.kernel.org
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8ebcddf91f7b..502d041d4a11 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -407,7 +407,7 @@ config PWM_MEDIATEK
 
 config PWM_MICROCHIP_CORE
 	tristate "Microchip corePWM PWM support"
-	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
+	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	help
 	  PWM driver for Microchip FPGA soft IP core.
-- 
2.40.1

