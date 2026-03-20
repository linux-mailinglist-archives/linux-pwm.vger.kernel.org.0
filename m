Return-Path: <linux-pwm+bounces-8318-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHs9LULFvWkrBgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8318-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 23:08:02 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE802E198C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 23:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7991301DDC0
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527C317159;
	Fri, 20 Mar 2026 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcxER9bZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B1317145;
	Fri, 20 Mar 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044480; cv=none; b=s/ovBcyAV1JAnd3rr/RhA4valdzMOpJbjaOLb6wjJWJPy0kV+irp8n3WX88USdNM7u0Ma/IZyQSQiUUmfrjtSQNXqaJJl3sTXkuLZiEjI1f5K2KMXg2C6MHHUCqTvdRXGRMu0IgtS5eNefW6fQH5wTmJyuiZGuXwOSQFqOS4NS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044480; c=relaxed/simple;
	bh=U75vAcPZ9LDL5k8ulJBj/C/nUmverCCdfucWmD1WBCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVfAC2R6SnL9bOdMKS/rmv4E5SxrNll6L1T9CPWMxCHpFiujlOcvYV3NgvElhrRpz+ZH9sTpFO08i5cYe69i6gWPMzk/COcXJE1RuirOl6RmLjHWY9QUfW0118G2/ad6lB3alKUI/AxO80noZIj5250VUuizR6/zoXZYetDWrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcxER9bZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774044479; x=1805580479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U75vAcPZ9LDL5k8ulJBj/C/nUmverCCdfucWmD1WBCo=;
  b=YcxER9bZVvJFqsYH0h/chhGiorO/zjgIig+YH2sbMq9xVHMuwvwS5E6G
   59TmqN+B9Fil4QZELssUSQutp3VuVpCQj5qmtaMpPlsxvIsJI/xkn4RJI
   FJHdyk7OfY9pIzditcuxDnKL5jJdb3Q3Grm30PTCakbbLWCLUHPNB8Y7S
   CJ0b7ZciDanlA/JxZ59Olsisc0t75diPce4xIQFBAXImJHeLfQPUyJEuC
   4jGZxhJhWK063S9h9xFoDK1nMxPlsYM+UHLgcfVxGxAdG8wUWTkZvtJnK
   qBh75EEV1FS8CopUvLQxQe+4usx+QbBrIwpO2WLno+Gc5IrhqWsSgxc9f
   A==;
X-CSE-ConnectionGUID: zmB7tjnXR3qPrassR80qhg==
X-CSE-MsgGUID: FK7RvR2xSoid3kOhITRLIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="77745636"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="77745636"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:07:59 -0700
X-CSE-ConnectionGUID: MSwHRevfRECHrEDWX2upKw==
X-CSE-MsgGUID: xcyN+DQBQh+h21qeoaaIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="228142457"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 20 Mar 2026 15:07:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7A08E95; Fri, 20 Mar 2026 23:07:56 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Date: Fri, 20 Mar 2026 23:07:55 +0100
Message-ID: <20260320220755.3237369-1-andriy.shevchenko@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8318-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: 5BE802E198C
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


