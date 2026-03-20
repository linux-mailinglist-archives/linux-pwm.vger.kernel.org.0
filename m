Return-Path: <linux-pwm+bounces-8317-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAUKCvzEvWkrBgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8317-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 23:06:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D572E1949
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 23:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9928301DDD7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1131714C;
	Fri, 20 Mar 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zxr4Nr6X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19302317159;
	Fri, 20 Mar 2026 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044409; cv=none; b=MhcEjW+mq96JBBqV9J4nKXAcLKhxbkkSbPvikZ33k+BxbLvWdlwf04llFYibmFkbxp7ZLINg76uTg49OdHvW7iVcAY/azA9CqIWvyJvDb7jgS+VFLu6ZG75rr5ahaR6u6xHGrAyCbUBjfaDmzuIyruUUye7o/AV7L6Q8jDQlUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044409; c=relaxed/simple;
	bh=U75vAcPZ9LDL5k8ulJBj/C/nUmverCCdfucWmD1WBCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGD4YTDJXs1kYsvHG3Xri0J/+cn3iKBB7s+F+QuKgqupdIiZmFWx4zfPoU9P2vGd/0hOL3rLEv/fy4ZlGdad0ZDOIvB0aPPr+JGpfZiJo1QVpNv0EfeWuHNkOv1oHn4xlflJ0gwDrFjLY40vzWzjWpYFSP824PvoIxeu8RjoJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zxr4Nr6X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774044408; x=1805580408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U75vAcPZ9LDL5k8ulJBj/C/nUmverCCdfucWmD1WBCo=;
  b=Zxr4Nr6XYfsYqj+UJQ+tkX961miBCvtYjl/3w2o9QqJQgE4tf8aOHa5/
   HdJXWELRZuGtwVU0ql6pL5QaTt97fTgYmvcoBh2wpiddqSSIxVM+y0uzX
   e0FO8Og0aB6wcrlDKfg/XZFuSaW/UUsewRhAc765ruWfap9gXO4D/tgc3
   WiIp2BQEWvNEUAjVqL1JQih0hy/DwD9oI/dabjPm6nh1NvEOyI03bWY49
   REGTb49Y+s25l3UWKs3hdd+5Mq4KIm+nETSp93rFTExjaGICiIY2B7CRV
   DRRs6uEdNRMyWhEPgWzvjnyPgRlSkg6AJ2Ly9rpZ8sYtn1lF6CefhdfON
   A==;
X-CSE-ConnectionGUID: FF+6lzmrQM6rBR8CpzeTcA==
X-CSE-MsgGUID: SJhyyrnMR0qQNFLvJanxHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79045051"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="79045051"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:06:47 -0700
X-CSE-ConnectionGUID: UWPeN4q5SkqwA8Tehb4dDA==
X-CSE-MsgGUID: XBXiiDWkTuepmFtNh7oYAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="247454426"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 20 Mar 2026 15:06:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 04BFB95; Fri, 20 Mar 2026 23:06:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Date: Fri, 20 Mar 2026 23:06:44 +0100
Message-ID: <20260320220644.3237290-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8317-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0D572E1949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver includes the legacy header <linux/gpio.h> but does
not use any symbols from it. Drop the inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-jz4740.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 6bdb01619380..e0b5966fc7fe 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -10,7 +10,6 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/mfd/ingenic-tcu.h>
 #include <linux/mfd/syscon.h>
-- 
2.50.1


