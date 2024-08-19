Return-Path: <linux-pwm+bounces-3041-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF895652E
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAAF1F23A9D
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DEE14C582;
	Mon, 19 Aug 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhIPaXf2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2BA41;
	Mon, 19 Aug 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054735; cv=none; b=WNkKBoZqeqAIPdFug2/ZxeYh5VX/Ejb5+B2zgTmoCugQRw4cEdhqYjRxjkaktAs2oepwLHIyF30FsZX/QUnSZ87ocK50/j7E4w4rhJRpZmwBKwWISt93XE1sW66Ptldk74EMZg4JxKHNWjUTLvZ011zf2YQB1nGDNVYMIEMw6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054735; c=relaxed/simple;
	bh=qTLlMvCknfzYIXgomDhar1yRYupQHhiL/5bujdbobYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9DbGuaGNmiFoN1bSL2O2jLxSZzUF0m3WbFvI/DLyWp/lLF3P+YVaVn+hFVGg70KdzkLQL+TeRlydWgV6HQGmoz5fFu5vO5Dq+vDUHoI6G2+Ha15QSL9jxyiJ4VoJkQhNn1MccaRQKnTc95z+9/FBOP8hEUqKwc4dtrfyyywS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhIPaXf2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724054734; x=1755590734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qTLlMvCknfzYIXgomDhar1yRYupQHhiL/5bujdbobYU=;
  b=WhIPaXf2vPaiyt4yLVu5tJ6rS37RXHX0HWHbKaMoH80dg3k8ki6Y8pC5
   drRmEhMVBcikMsBe+o9tih2RVHpf2ag5k5EUZ460IFBppMAvT0hJBKoGT
   TwEWFYhEea62UZeyOTewAooUs3lzr8jKJ1OsooVT421FiSn8mj0On1ZyO
   +BCZ64/+fQ7e/8WXAkRi6iMrQyOC4NjgK4xztNi/vn2ZsvWFiEm7cZh6i
   DN039F8PrPRxRTwiKVpP820QpqjHSCjxUwsgJPyX/pchFbPc2LJFwGj1u
   x8uPuKM+6uMZZ6aDF5QE3A5t6ww4XfecpZjNnl+AftMq6rB1daNAN8wkW
   Q==;
X-CSE-ConnectionGUID: qKQ7fFjPSAuRHw7myF6GjA==
X-CSE-MsgGUID: P35+yd8MS+ae9SlucZe7yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32860711"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32860711"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:05:33 -0700
X-CSE-ConnectionGUID: 4suJzyIyQW6Xwew2GYdv0g==
X-CSE-MsgGUID: fRHHfVNJQYOl9BiBhQvdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91066892"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 01:05:31 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 3F74B15B51;
	Mon, 19 Aug 2024 13:35:30 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 3A21C1600101; Mon, 19 Aug 2024 13:35:30 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: ukleinek@kernel.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jarkko.nikula@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pwm: lpss: wait_for_update() before configuring pwm
Date: Mon, 19 Aug 2024 13:34:12 +0530
Message-Id: <20240819080412.15115-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait for SW_UPDATE bit to clear before configuring pwm channel instead of
failing right away, which will reduce failure rates on early access.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-lpss.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 867e2bc8c601..4a634a43b133 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -111,16 +111,6 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 	return err;
 }
 
-static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
-{
-	if (pwm_lpss_read(pwm) & PWM_SW_UPDATE) {
-		dev_err(pwmchip_parent(pwm->chip), "PWM_SW_UPDATE is still set, skipping update\n");
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
 static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 			     int duty_ns, int period_ns)
 {
@@ -168,7 +158,7 @@ static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
 {
 	int ret;
 
-	ret = pwm_lpss_is_updating(pwm);
+	ret = pwm_lpss_wait_for_update(pwm);
 	if (ret)
 		return ret;
 
-- 
2.35.3


