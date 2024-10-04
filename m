Return-Path: <linux-pwm+bounces-3451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA97990019
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4881F245F3
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D18155751;
	Fri,  4 Oct 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4R44i+m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA291494B0
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034902; cv=none; b=KQJCaIjLcISqXgraVkPpqkrbmIqutBm9wleJZfLMewcNS+7bidKPc3eO464qv6AyDBqUT9gsVB3NitHgQ/k6a5mSHCw5531CcHOWEsqygOeofEkGCRJa9SaJYdzfSJtICUvirFlX84I5XIi1ODTudWaI3BmQb1ZlSaOqXHNhVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034902; c=relaxed/simple;
	bh=acmUFC8xq9P0f9D/T7r8dQgcxBiW8EjCX1QgpmGNPwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXaGG/09xQ92SG9mNYsZLc1Y06L4twdr48hsMDtuy1ZxGVDYwdk4cyrhOcbY27g0d5ZaceIbJyPdLdqLpU8gYCT9Evmc/ty61ETbZ0Pxf48Hx0YhFkHGVjLbCQgyQ8IxntDvo5bS9Q69KN4II5rqtFcQ6isrZYxa5+g7aKgSW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4R44i+m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034901; x=1759570901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acmUFC8xq9P0f9D/T7r8dQgcxBiW8EjCX1QgpmGNPwU=;
  b=n4R44i+mMv6rq9Ts9nnSymB2zPAUKheVpt62lBXPpAU8QGgk3abp+lbZ
   LGDbwtXayLnlLcB/SD+D8LvfktuqgChjMzfKNK+dJlgNSX6nGBK2yGroI
   hKezmwiasPvCq1VSB7d+Hp1Xu+sDMC82symSSNDxMAgsYJv6lwhpPHwfi
   s3oId4vqUlbUOkDsXmQSLnjT9mq+nMHdA6d3CDuRrHFY7yRp3LXHeY14B
   Bc723WGIreTEo3ryK+xGpGtOYI9OuYJcclUfZsZ7OMCZMTgIXt0knDu6s
   6zheMITup3kDeJTZ0riF+K3N4I4LUU0Z6lBvSKlR+/IF3+XI0BA5aE/z4
   A==;
X-CSE-ConnectionGUID: xoRVx03KTiC8IJPLE8Twag==
X-CSE-MsgGUID: Y3tqaMo/Qb+BS17ZiqsIPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656265"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656265"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:40 -0700
X-CSE-ConnectionGUID: UVleBs0HRcqrq7AvkoA3UQ==
X-CSE-MsgGUID: o4oB4TbtRTmenI/cXLBjNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975104"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:39 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7281C120F46;
	Fri,  4 Oct 2024 12:41:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoY-000TeL-1T;
	Fri, 04 Oct 2024 12:41:34 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org
Subject: [PATCH 36/51] pwm: img: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:34 +0300
Message-Id: <20241004094134.113963-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/pwm/pwm-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 71542956feca..9bd177ebad0d 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -140,7 +140,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
 
 	pm_runtime_mark_last_busy(pwmchip_parent(chip));
-	pm_runtime_put_autosuspend(pwmchip_parent(chip));
+	__pm_runtime_put_autosuspend(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -176,7 +176,7 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
 	pm_runtime_mark_last_busy(pwmchip_parent(chip));
-	pm_runtime_put_autosuspend(pwmchip_parent(chip));
+	__pm_runtime_put_autosuspend(pwmchip_parent(chip));
 }
 
 static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.39.5


