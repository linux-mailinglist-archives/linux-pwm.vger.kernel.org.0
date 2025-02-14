Return-Path: <linux-pwm+bounces-4909-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A607A361F9
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5F83AFF07
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61105266F05;
	Fri, 14 Feb 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd7MNJnF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84305266EED;
	Fri, 14 Feb 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547638; cv=none; b=ujVvEKw/VpLJn+cEDxPk+dvun71hO34TLn9nbM1lsXVFADTxy8KoWzsnjC2njsaVFTqmff8WI0/l7bEa3QplXbJTfBURcvrb+oaUDO1vLni1JZoNmmFqlFQf46E+T6hroVIhxHV2AVQ3VtseuH76tQJ9W9YDzE99oEtek7T5Hd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547638; c=relaxed/simple;
	bh=BfxWDMZ+3PQFNY45rR2UOSnyG3iY7QO0DumD2ESx0vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGmhJl0JiJLkMExwIRKRQfvgaVPLjNenBRuv6NTFOx5e1U1ywWj8Psj5tuSi5i2i3Il7ejRc/gKdXiN/8xIP838CXLaOZyWVVlu452G6pfVCS2vDmJbLZY9WbdZ2+9cX0i+lEkd1D3xTKtqxyXl9RWIsPeUDB9aruZ3XBe0LoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd7MNJnF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739547637; x=1771083637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BfxWDMZ+3PQFNY45rR2UOSnyG3iY7QO0DumD2ESx0vE=;
  b=Jd7MNJnFIu4Twj5GoURGoaIAGQV9/dV1xxdvOIA46wyGp9OCUEJk7H4A
   9HLKXVLUszyXAldhIDvejBVZQbUvjQTibggr55Q1UvUQbHGzEO2Xfz+wB
   JlyBGNJH8fgARW4RvA0Tryj3f5wyqh3Pq8yAa1akosqm/LoZuW6Q6WgiF
   UHGvYY/JWiBXz9Kg8F7+5ieZEfL6Q0t1ZFqFdDtSjb++UoJrqOAkk5BJe
   qvvLI++rUMAsddlcUb/fi6oE4LX05X2GoexoAZkCaKRKOiZGZroKRa+dw
   Hzmi33GvZDIcvrFJDSHWdcxXWInTVfNCKrCefz4+y3Z6/cinOYGUw77rY
   Q==;
X-CSE-ConnectionGUID: +dCFaLe3Tf6e6WsHT0vJ1w==
X-CSE-MsgGUID: JXL00FyURgOoS5LjHBxeTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="51276028"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="51276028"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:40:36 -0800
X-CSE-ConnectionGUID: AdGNWwt4QKaZoTw5eXDE2Q==
X-CSE-MsgGUID: d2rd0yN0SYOvS6yLqGjOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118689016"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2025 07:40:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 94812123; Fri, 14 Feb 2025 17:40:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pwm: pca9685: Drop ACPI_PTR() and of_match_ptr()
Date: Fri, 14 Feb 2025 17:40:31 +0200
Message-ID: <20250214154031.3395014-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop rather useless use of ACPI_PTR() and of_match_ptr().
It also removes the necessity to be dependent acpi.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-pca9685.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 1298b29183e5..5162f3991644 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -8,7 +8,6 @@
  * based on the pwm-twl-led.c driver
  */
 
-#include <linux/acpi.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -639,21 +638,17 @@ static const struct i2c_device_id pca9685_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pca9685_id);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id pca9685_acpi_ids[] = {
 	{ "INT3492", 0 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
-#endif
 
-#ifdef CONFIG_OF
 static const struct of_device_id pca9685_dt_ids[] = {
 	{ .compatible = "nxp,pca9685-pwm", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
-#endif
 
 static const struct dev_pm_ops pca9685_pwm_pm = {
 	SET_RUNTIME_PM_OPS(pca9685_pwm_runtime_suspend,
@@ -663,8 +658,8 @@ static const struct dev_pm_ops pca9685_pwm_pm = {
 static struct i2c_driver pca9685_i2c_driver = {
 	.driver = {
 		.name = "pca9685-pwm",
-		.acpi_match_table = ACPI_PTR(pca9685_acpi_ids),
-		.of_match_table = of_match_ptr(pca9685_dt_ids),
+		.acpi_match_table = pca9685_acpi_ids,
+		.of_match_table = pca9685_dt_ids,
 		.pm = &pca9685_pwm_pm,
 	},
 	.probe = pca9685_pwm_probe,
-- 
2.45.1.3035.g276e886db78b


