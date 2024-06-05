Return-Path: <linux-pwm+bounces-2349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92808FCF8C
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA641C22904
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BB18FDBF;
	Wed,  5 Jun 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxkZGs/5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F019D881;
	Wed,  5 Jun 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593361; cv=none; b=X00ppwhq3Xxge/U8t7LB4qzRLh7qM3SxEONjNWlaCx/d7uNZ/ONDIieq+qexgiV5meOmZOFNNZzSkTW96BJCT7ghwGDXAEzZfwlXngbDbZTzsU18zF53AUGFOWrL/5ISoHhdMJiOWxlAlNrm/ywkXJWh6g4ir6YgLnssLiewIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593361; c=relaxed/simple;
	bh=g20FrGbDTGnz16POZhJm2IR0qbqxVdd8fkLY18CrcWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqKvjZXelyo4+B/R1VhfseYyKml9ulNiCtzZTeAGz9mAqNxFBsMubzLIv3zziBuyGYO/Flk0bgz6IA0Ot4dq0gjt7i1OsJUMCzMNmKZLcR0taVUTAxR2p7YFimVrkpm88YnPt1j1U5tkRwghV/rN2DI2FF1g3SWRTjgSy/Zj6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxkZGs/5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717593360; x=1749129360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g20FrGbDTGnz16POZhJm2IR0qbqxVdd8fkLY18CrcWI=;
  b=dxkZGs/5CpCGXyEWtCGbUH9DtWn21aPZ8i+ILdmncfJBY6kSbMf1U+X3
   70RCjEO7CadLQMwWne7WDTjW3/zJUzlkfGkD15ARSkc1QFcw1ha2UK3en
   S63tcxd9lu9BMk4xZyf8F/KOdWqrGuMl/qJoN9u7iUNplqdxq/TUDrNFx
   HznT+9B7zx+rOHxLLzyJEtGX9wmQJ/IszneyO0e/NAgA2dpPchtANVsZw
   yEp/pO4w6MgznODkTlwOoVV92eY7Y5EUpdxGUAOQa5H3Au6drF34nwdgZ
   5VucPDbX+TQypzTttwPRVY9ngE9gNx85Tsfyut1nC/RuTLuI+ju6XehQ5
   w==;
X-CSE-ConnectionGUID: IqbgSj0fRTiYHWedFRLidw==
X-CSE-MsgGUID: WgnMd6vBSw2aaTRXfCS/bA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="18048159"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="18048159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 06:15:51 -0700
X-CSE-ConnectionGUID: ccaxZxC0QXe0jSnmUw+xpw==
X-CSE-MsgGUID: tQprvkH7TO6ZBRd9agHn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42549302"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2024 06:15:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 666CB19B02;
	Wed,  5 Jun 2024 18:45:48 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 616491600109; Wed,  5 Jun 2024 18:45:48 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: ukleinek@kernel.org,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/2] pwm: lpss: drop redundant runtime PM handles
Date: Wed,  5 Jun 2024 18:45:33 +0530
Message-Id: <20240605131533.20037-3-raag.jadav@intel.com>
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

We no longer need empty runtime PM handles for PCI devices after
commits [1] and [2]. Drop them and let PCI core take care of power
state transitions.

[1] c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")
[2] fa885b06ec7e ("PCI/PM: Allow runtime PM with no PM callbacks at all")

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 25045c229520..f7ece2809e6b 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -46,25 +46,6 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 }
 
-static int pwm_lpss_runtime_suspend_pci(struct device *dev)
-{
-	/*
-	 * The PCI core will handle transition to D3 automatically. We only
-	 * need to provide runtime PM hooks for that to happen.
-	 */
-	return 0;
-}
-
-static int pwm_lpss_runtime_resume_pci(struct device *dev)
-{
-	return 0;
-}
-
-static DEFINE_RUNTIME_DEV_PM_OPS(pwm_lpss_pci_pm,
-				 pwm_lpss_runtime_suspend_pci,
-				 pwm_lpss_runtime_resume_pci,
-				 NULL);
-
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
@@ -84,9 +65,6 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.id_table = pwm_lpss_pci_ids,
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
-	.driver = {
-		.pm = pm_ptr(&pwm_lpss_pci_pm),
-	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
 
-- 
2.35.3


