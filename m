Return-Path: <linux-pwm+bounces-3834-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642529AEA33
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 17:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065141F22AC9
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2815C128;
	Thu, 24 Oct 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDdEl4vg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCF15746E;
	Thu, 24 Oct 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783151; cv=none; b=s7Kppy2Anw7sLvN8FuVj/tLYgZKPiLgKFu0Pz9XEJzukA6sKJNm7rpJ1hCkS+m8+jz4sGTucGtWCGR5bMqh/W5TAtCg7bwCQN6zfEWgx4LGLpBx4Jvt/wbLRrpSUYERmJ/ujLdoj41msq1CxdUIR8nDxLB60MY5U3vLn+zEN3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783151; c=relaxed/simple;
	bh=6NXCAXziw9jg+m0i+s7MsbC3VIyr4FxK0v3h2iOhAZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJrUXBnE3KUqBpWZCAmxFOmOR0SkBcQcYGEuAgNw6Kbfz73hCIVtw7AkqUlgLBuKfJtXJ/vS06Pbx5DYhsujyCoZb9bREQAq7V1dGrQN2K1tsqSOwX3tieqLVzC2AR5bpDt9iQvwP1WwITpFSNDSePvR9O1Gis5TepB1RknHtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDdEl4vg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729783150; x=1761319150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6NXCAXziw9jg+m0i+s7MsbC3VIyr4FxK0v3h2iOhAZw=;
  b=jDdEl4vgWnKsraVPVrBSVq/ni3bkfm1OvZrX0T0MNjvoX/W41iYeM0fe
   tpTLGU9368bKbp/jIxF48+8ji/OdanIeYLZZarJDfWIVDqu5K+HbVLMXO
   BplMTUTldtihgI1iB0f8pz1GaDWqVMUkXMx5qZKG1FnPWlGlpv9/Vvl5I
   UOXGD12fq5h7A+ON7boqR346A7NPmEQPqCPNQ7RmvyE9PaGUn7RvhIpQj
   4taIAmI17rU9vrcgvz2WreqXgDR/et4Se59vGQaHY84C6hHnr8ZpusALi
   jpBOkqqApiQyTtQhrOB5IJEl4ZArmnQB6uwZS+r44SmxrrKOZ3hrfH/rn
   g==;
X-CSE-ConnectionGUID: nST19f6CTUS+TUN7OwKTkA==
X-CSE-MsgGUID: NQdRiCmyTgenBAa03PUB+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29524861"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29524861"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:19:09 -0700
X-CSE-ConnectionGUID: VSK/NfqxSrW4NwxGMQcLPA==
X-CSE-MsgGUID: BzJmxaxOQsa8bWcrxIc6iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80540817"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 24 Oct 2024 08:19:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8B23E252; Thu, 24 Oct 2024 18:19:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pwm: core: use device_match_name() instead of strcmp(dev_name(...
Date: Thu, 24 Oct 2024 18:19:05 +0300
Message-ID: <20241024151905.4038854-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the dedicated helper for comparing device names against strings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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


