Return-Path: <linux-pwm+bounces-2462-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4EF908E6F
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52EE1F27311
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041B15CD64;
	Fri, 14 Jun 2024 15:12:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2C1591F8;
	Fri, 14 Jun 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377968; cv=none; b=s4XBQZeG2ntxyxD3W7aYFO1RizfT+HgcUyYk8QfyfkIL6Pbd0gEhzEjwtxUGiZ2osS2SXiIEpd58i+YQfuI+pqMxfzqXzse/Rlzi1yAAugFKZFN4DnvrAa8ZhwXCiml1+QHOgp5Jlsn5H/0mGolr/VswuE04K2JlFVdP2N5lBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377968; c=relaxed/simple;
	bh=avEZ+q9GkCyZ8CRA8it+z6Wpyg/1LsKNszJVPpwkXi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IDFOJeAVdULlKc2SAJCT7uCDIZIu9mvU5Mmm8wxAF0/6xOgX/BYjDZMyXc06qjImB6ZyA6cOho4boSAhDfI5CUH5kD35oorllD6YYZ+3uJwS+qUKeSWuOFeGEFag6Xw7vuyMEx1Rx542Xjj+MD3RndgYWr737ulPMiaceT0trn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,238,1712588400"; 
   d="scan'208";a="207958146"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jun 2024 00:12:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E300B445EBA3;
	Sat, 15 Jun 2024 00:12:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] pwm: Fix namespace error
Date: Fri, 14 Jun 2024 16:12:33 +0100
Message-Id: <20240614151233.398463-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix namespace error due to typo by replacing USB_STORAGE->PWM.

Fixes: aeb9cedc87a2 ("pwm: Make use of a symbol namespace for the core")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/pwm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c68576067eca..75ad0d2fd949 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -8,7 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 
-MODULE_IMPORT_NS(USB_STORAGE);
+MODULE_IMPORT_NS(PWM);
 
 struct pwm_chip;
 
-- 
2.25.1


