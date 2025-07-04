Return-Path: <linux-pwm+bounces-6718-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C727BAF8BAA
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 10:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3326656815E
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820752F1FC5;
	Fri,  4 Jul 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDY5/DoT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F22F0022;
	Fri,  4 Jul 2025 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615698; cv=none; b=cSzBRfgl+OoeYPcUdBCmHpQ49o6vP/NgALNa99XnjF1rWn323QWxA4zWGNBcmu6whfPGSy60jd4ANaUn4p7+O2mUY29vbnPI0dxI+HeyS8tDuOMieOMZGFIQGIf0ZtUkfk7g+y6AbXhdTplFZ75P4DVF0Qankae1H7erTkjCLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615698; c=relaxed/simple;
	bh=r1Gsmx9kfkhpUyKheatqOMNMQ+hakjSERBDtaMYrqa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdmQmdjBA4LsOPU0Bs42BIMgNaWecVKAunLKlZXt/v7Uhwf103nEgDurkkgDWWoStC0ttg/SkaeBhIAWOp3n+G/9qCRQBFBx8+PeiaMK/yEnXR8p2OF6RUA/OYWgj3j6hUyDXNxiYfHo0Sf9CjZSHNLzOchd81gIabe3owcnD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDY5/DoT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615695; x=1783151695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1Gsmx9kfkhpUyKheatqOMNMQ+hakjSERBDtaMYrqa4=;
  b=fDY5/DoTarFMFqglSXFhBtxGndFH/JAJ/ueyfw6AbAunA325QIamBWjS
   mRcM9bEAqwi7gRDwFsPD8N0KmwNtuIYv+i+47gM4mBD/v4w2KIai20uP/
   Wg3ZMbRHvDsLN3NvqWoexCXUViTm0NEVivrFMV4WQEfn9H8nqJMV7bOXc
   VAVP2D+oVSa3xjgXGcWRbqIRwMzkxtwg74jmp3qBDqqvpou7ZMpX6xNzx
   iexfJkNCIfLj4O+Cy2/k3XTarOkZ2MPda91FnjDguKDgvTdh2l5e2seeD
   GqjfqrLgf56nQIQO5X1B27gQmsQ/17LUudZzv3f76WJOdYixSJ/sJGiDI
   Q==;
X-CSE-ConnectionGUID: y6+w1is4TCWd/w+l5Yz6KA==
X-CSE-MsgGUID: G6hjKhYNTr+vMXYZ74wpWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194228"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:47 -0700
X-CSE-ConnectionGUID: 21+9UfiPQw2lAJ4azmc15g==
X-CSE-MsgGUID: tSgevDUzRKuB9BqmPwGLjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616618"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:46 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 0452D44424;
	Fri,  4 Jul 2025 10:54:44 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 56/80] pwm: img: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:43 +0300
Message-Id: <20250704075443.3221370-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/pwm/pwm-img.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 71542956feca..91e0b19f0c08 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -139,7 +139,6 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	      (timebase << PWM_CH_CFG_TMBASE_SHIFT);
 	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
 
-	pm_runtime_mark_last_busy(pwmchip_parent(chip));
 	pm_runtime_put_autosuspend(pwmchip_parent(chip));
 
 	return 0;
@@ -175,7 +174,6 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~BIT(pwm->hwpwm);
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
-	pm_runtime_mark_last_busy(pwmchip_parent(chip));
 	pm_runtime_put_autosuspend(pwmchip_parent(chip));
 }
 
-- 
2.39.5


