Return-Path: <linux-pwm+bounces-2350-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF98FCF8D
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D391C226B4
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FB319308B;
	Wed,  5 Jun 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L353sSRX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCF19D887;
	Wed,  5 Jun 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593362; cv=none; b=RdcW3NVBl5dv0iZyjeibGhtVDqoURWEc0SRDJMhcqZj7C/BS1+E4FHr3gNpgiRiH1DxoLnFV1v2CrKSq9QvVKY344KF84p8HmYj2tfZ3rQ+5jnj6G69F3DvGLFtzwJMWhnoX/m1o5zi5AXVRhU/0MfFLGeUkdQSkaQqooer3c+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593362; c=relaxed/simple;
	bh=aO0M+GBN/jf5DZcWxP1iiJ1SPiO5YkAL4IsAvtFiOvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3GbV2SaS9HFcljf7bKuH7Ozk1ctxcpk37w+4SetQA6fMRBC+jIjKa+yg2wsXdZ4lW7ye6LkKnnx0PPttzcUF8/AhZhku27pZQhogTeUY/OaE0FKSRvlr0EEWCgGhiKMNDri0Ka35bpr+JrtzSfowvULV/R3AG3k0IY9YtbZRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L353sSRX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717593361; x=1749129361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aO0M+GBN/jf5DZcWxP1iiJ1SPiO5YkAL4IsAvtFiOvY=;
  b=L353sSRXJtULfgwSO50LCm/cMaxsrP5OpJoHpRvPl+Ayjv0dOqlqG9V7
   tCQ6moBB4ZTb2lxIq4GH9v1YVEHyeebMmv5cfpFGega2Y3ixZUGrWRoy9
   ZsOAsfrb9Uu69/gkvTSYvnBme307eJP4hVe7sjATxoBjTwQos9kbPV0PC
   Dx9sb4cB6nr/bRys+X7i+Zi0zBcSmsbZ/Ar60hLNJl8JffWgjVYNahwUn
   8ZIwZetTRslRs6A0U0hpCT+7jxEKKBHVAZKGNrhGYMp+Umhuw0+pY9hgG
   xB6cEojS0oKr6S76K8HV3F+zhk5Sbj/Sf8sYfs+J9FG1tKI3wg8kj/hHA
   w==;
X-CSE-ConnectionGUID: IWrUbzPaT8SKLnodQ2LrKw==
X-CSE-MsgGUID: jM14v58jQMWCX9tZUiNeVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="18048161"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="18048161"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 06:15:51 -0700
X-CSE-ConnectionGUID: vyWzxxeSQ0GYiLhx9CkZJQ==
X-CSE-MsgGUID: 34chdvglTrucTXpOMbo3LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42549304"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2024 06:15:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 6573619AFD;
	Wed,  5 Jun 2024 18:45:48 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 611D61600108; Wed,  5 Jun 2024 18:45:48 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: ukleinek@kernel.org,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/2] pwm: lpss: use devm_pm_runtime_enable() helper
Date: Wed,  5 Jun 2024 18:45:32 +0530
Message-Id: <20240605131533.20037-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240605131533.20037-1-raag.jadav@intel.com>
References: <20240605131533.20037-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_pm_runtime_enable() helper to enable runtime PM and drop redundant
platform ->remove() callback.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-platform.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index dbc9f5b17bdc..5130238a4567 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -55,14 +55,7 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 						    DPM_FLAG_SMART_SUSPEND);
 
 	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
-	return 0;
-}
-
-static void pwm_lpss_remove_platform(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
+	return devm_pm_runtime_enable(&pdev->dev);
 }
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
@@ -80,7 +73,6 @@ static struct platform_driver pwm_lpss_driver_platform = {
 		.acpi_match_table = pwm_lpss_acpi_match,
 	},
 	.probe = pwm_lpss_probe_platform,
-	.remove_new = pwm_lpss_remove_platform,
 };
 module_platform_driver(pwm_lpss_driver_platform);
 
-- 
2.35.3


