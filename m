Return-Path: <linux-pwm+bounces-3892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A39B05C2
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB825284CEB
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345231FB8A9;
	Fri, 25 Oct 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBicwHlm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE854673;
	Fri, 25 Oct 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866431; cv=none; b=cIx7sqR0knzCqP+nppBRkNcMkJq8n/K8HYxkav5xruboetkthTzSTpDjwXJqSgR6ydl0N8PfQ8iNG0htg1EplVMA3IzCbUfe+O6sQK29Z+sNgMNzjpFIZTkzS9C4fU3yztwSAXuMr6Y9QQZHoEQAL4+GTnuw3iKB1sD3EZcqpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866431; c=relaxed/simple;
	bh=y/ESaW7hqBHSRxXTCjJE5nYVptS9dhH9deT14G4i2as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCPhuDglYwUi7VP4XiXRgIevB9HeXkuN8qL7chV5slVrXub7+cNtJE8BtQjsji68KiQw9ZeEIxguVHIpOBH9PzBLVitGp51p4f9d6n9gNbOhKZ1mxpSO9D85uGT2ZkBQH++BzwMd9Mmd+TPARgt/aLGsIz9JNtSMFeQniIXNkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBicwHlm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729866429; x=1761402429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y/ESaW7hqBHSRxXTCjJE5nYVptS9dhH9deT14G4i2as=;
  b=LBicwHlm5aPvrjX0t4y8oJ8T5oSW+n7MZdmH/12jLNIiCQ9ekxQiTBIZ
   gSO025+mArrzQanb+spdRELr0OKe85vaQR+us2VMPczJhIDJBVFpVn4cA
   AVc3Gif+MSwnn7iGl8ynJv9vvg2sG3VIPZSfpOLe9yYZzL0mbqDm6vbRv
   jAy42vyhAzbD487oEvdVLfqxP1s6lihZ+3phQ3nChoMChFgcN4xgxGIdC
   RLyd73dI5AwCa/+ZDkf3diTPdsahF4EFPEIc31O7/JpcB7nEoVOc6NoN+
   iG05d6Ad3VNePts/Gcgogcw7j56RZQJXMW52Ex/GgheOv5Po1w+A0cs51
   A==;
X-CSE-ConnectionGUID: QznHNRu5SayVF6+p+YQm9A==
X-CSE-MsgGUID: RzINz88SSWiveyRawcyDwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29668260"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29668260"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:27:08 -0700
X-CSE-ConnectionGUID: 3P6omm70RiqDyR0w0y8w/w==
X-CSE-MsgGUID: 1/KMsAPqT8OkxGUGCRaUCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80575755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Oct 2024 07:27:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DCF4F251; Fri, 25 Oct 2024 17:27:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] pwm: core: use device_match_name() instead of strcmp(dev_name(...
Date: Fri, 25 Oct 2024 17:26:34 +0300
Message-ID: <20241025142704.405340-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the dedicated helper for comparing device names against strings.

Note, the current code has a check for the dev_name() against NULL.
With the current implementations of the device_add() and dev_set_name()
it most likely a theoretical assumption that that might happen, while
I don't see how. Hence, that check has simply been removed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: elaborated a dead code elimination in the commit message (Uwe)
 drivers/pwm/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 634be56e204b..4399e793efaf 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -852,9 +852,7 @@ static struct pwm_chip *pwmchip_find_by_name(const char *name)
 	guard(mutex)(&pwm_lock);
 
 	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
-		const char *chip_name = dev_name(pwmchip_parent(chip));
-
-		if (chip_name && strcmp(chip_name, name) == 0)
+		if (device_match_name(pwmchip_parent(chip), name))
 			return chip;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


