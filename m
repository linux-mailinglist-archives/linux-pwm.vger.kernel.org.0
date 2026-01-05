Return-Path: <linux-pwm+bounces-7842-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D83CF2B81
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 10:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C04C3003488
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160D32F744;
	Mon,  5 Jan 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz4BMO9d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7591D54FA;
	Mon,  5 Jan 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604800; cv=none; b=dfHoYHavobIY/e63jMcEXJFeZVkY7EE49Y4NWxCU1A6s9KpS7zemmcfWB49QZHAlQrpT+w7uYmGo9fmCcxohkdeubtfBxseb2egbV4jI0CV7pN2w9JSuv9FM+RAqN1VQM039wU4UezAHHUBYDm6a0pMviOgo6G8/KptzNSrySAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604800; c=relaxed/simple;
	bh=tSh9NjPp2tWudi50LOyw7dZ6SKWuQsY11tTcz9sxYvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5h2BM8vfAAnm0guBA6ENS/8AV0mm/fF/c6+lp+9l8J39pyPdgK3fJfdsG1aj/DTJflxLgkvtBzPSIcYlLz3Tl30SgkE8z8ubvBGtgKnUVhnf1f2923AbyPAM5shCldolpfvVgsg0M9N7xlbIokMMRJ2+cEg/xLhK+MpeaoCWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz4BMO9d; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767604798; x=1799140798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tSh9NjPp2tWudi50LOyw7dZ6SKWuQsY11tTcz9sxYvs=;
  b=gz4BMO9dYGIdgM1GUFiJAVoOWn3IcW5oLMSi7LsjuqpQOVsDEXpLDgKD
   MjuPLKT0emgByFsevd97ccPJAxBwHwEtOtU6SR660R2oRFpdf2PuKMIUW
   NHJCuGeLltVN7PkA+MTEktSDxkDhh4NQEsP0u66axlXGk1U2sZZFHfDrv
   y4eHok9z9rfkKstPugb/0KOOZtXq2fcO77gCx9A0qttznvHec9h1cqmSB
   ptlv7Objzaqt1x4wcxzT+3XErD4ixqgHrroXgwmBj2YuE95h4PKehwU+F
   HTGQ7RH1tQmH7STo6WTZiqhKgXjL2S5gYjbrLqDl8pGjeDuAHnAPfbKz8
   w==;
X-CSE-ConnectionGUID: 269liTMVTgSRJheU3/mDTA==
X-CSE-MsgGUID: En48IkIMQKG/QPsJiyqYCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="68163344"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="68163344"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 01:19:57 -0800
X-CSE-ConnectionGUID: p/tc/az3SdCpwTjneBmnrg==
X-CSE-MsgGUID: yVfmgJcPScWbx6UfaD+XUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="203319645"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa010.fm.intel.com with ESMTP; 05 Jan 2026 01:19:56 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: ukleinek@kernel.org,
	andriy.shevchenko@linux.intel.com,
	heikki.krogerus@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pwm: dwc: Use size macro
Date: Mon,  5 Jan 2026 14:47:37 +0530
Message-ID: <20260105091737.17280-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SZ_4K from size.h instead of hardcoding constant.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index b6c16139ce4a..86b72db58741 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -22,13 +22,14 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
+#include <linux/sizes.h>
 
 #include "pwm-dwc.h"
 
 /* Elkhart Lake */
 static const struct dwc_pwm_info ehl_pwm_info = {
 	.nr = 2,
-	.size = 0x1000,
+	.size = SZ_4K,
 };
 
 static int dwc_pwm_init_one(struct device *dev, struct dwc_pwm_drvdata *ddata, unsigned int idx)
-- 
2.43.0


