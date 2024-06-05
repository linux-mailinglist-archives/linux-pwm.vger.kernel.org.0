Return-Path: <linux-pwm+bounces-2351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D98FCF90
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D691F223FF
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F136194AF1;
	Wed,  5 Jun 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mttoQBd0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A0194AC7;
	Wed,  5 Jun 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593364; cv=none; b=JfW2HJ5ukf4OOXYID7I9wNBHxqdSLcdEgjGe38511qJY9j5PCzCPjQsFNdlGaymxijQlVjaAmMjW4dT8QInlhPuUiMCrKlQR+Azt2Hu0p1Oc2Vd+wx/AflqP/xuzvuyFjzVn8iinskSvqilR8YZziZnipuU/MeuC6qkYPEdbKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593364; c=relaxed/simple;
	bh=wvZt6kF9E4Zi2ofY87AAmrFmQ/4Dipo37U8X3H8nyNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTN92OTGg1J9/78ZyxNpm1tveXOVMEGtQNqV8NeDMzruaBEPFACZn9uGxjsUN0LuloAaUp6X/ksEe+v0Dv24RjBv20qk1oNja+H1DMj9majC+bJim1NIgogjpmQFdr7PFGp9ilLl7xEhoHF4dDWwYOuogr4ZCEwEQM5PGpIl3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mttoQBd0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717593362; x=1749129362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wvZt6kF9E4Zi2ofY87AAmrFmQ/4Dipo37U8X3H8nyNs=;
  b=mttoQBd00AX4rQ81GiQ85Z1LCXvrORBh/4fOHiw8P2YPaqU0601SaHJN
   gaRKBFZ1tcL4IsEfiJSUgdZCqEcLyL6NgmY2tjgNqitrAErKlTEHCcOwf
   iba38G4fMf35g56eVfgqpkl68y/W4SSFxBOXh/G0UHkfiij8nSCjxLZ3i
   k+YB82TVnR6KVe6NoSqMjYVbnGmmkcpT+w/285z1mj7tLuZUsQ7soa/FD
   wfKrcGqKoLP0stsfG96ASEFmroi5DytL6DbSkP+LXGXKjNjFhmtzYyvws
   UO86CIvw/3mfYU03MD7KYXFQyVbV1NQkMKv2HJi/dVi4XmlqMHdVtfvjl
   w==;
X-CSE-ConnectionGUID: 4fTF3MhcQsCdJ8/qYMMIRA==
X-CSE-MsgGUID: 1Li51909QlSsewU8cvZ3FQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="18048164"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="18048164"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 06:15:52 -0700
X-CSE-ConnectionGUID: 9bINq45JTxWFir6fDvMQYA==
X-CSE-MsgGUID: Pg7hOZHUQgqOEW4MFE1YGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42549306"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2024 06:15:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 652BD19AFC;
	Wed,  5 Jun 2024 18:45:48 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 5FC501600107; Wed,  5 Jun 2024 18:45:48 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: ukleinek@kernel.org,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/2] LPSS PWM cleanups
Date: Wed,  5 Jun 2024 18:45:31 +0530
Message-Id: <20240605131533.20037-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements minor cleanups for LPSS PWM driver.

Changes since v1:
- Update commit message

Raag Jadav (2):
  pwm: lpss: use devm_pm_runtime_enable() helper
  pwm: lpss: drop redundant runtime PM handles

 drivers/pwm/pwm-lpss-pci.c      | 22 ----------------------
 drivers/pwm/pwm-lpss-platform.c | 10 +---------
 2 files changed, 1 insertion(+), 31 deletions(-)

-- 
2.35.3


