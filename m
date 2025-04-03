Return-Path: <linux-pwm+bounces-5324-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D5A7A3A2
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D8C3B7D33
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C324E4AA;
	Thu,  3 Apr 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKfYbp5A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D089D529;
	Thu,  3 Apr 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686652; cv=none; b=czZpwSHMBfhuhg+uyn2dlxybvapbUfod+comfLkEDVLohPk8xBetbcQDcO9vQvQrakmqF5vcIJ6HGNvJCnOZFoMLMo2UU1iosOJp/43Iw3Pca30gV9hQLgIAysOAMBFpjJJMR+VKgIS8DuIOO/HrE60IKXEjRvbM4AkdPUjyx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686652; c=relaxed/simple;
	bh=ljhJUxaQ+kRthX1ACKvZsuHQzUEf3+7S5pIFKkgnHnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SG30uYVDTSJGrR9aTI3rdx/MXioZ7qokrhvR1sh6ogChze5rJoRJSUWIDnADVJPTRMehtzcepVn/VKDM1ftCc8CT813KvwAZfVUz8F7nVsN9Vl7YmJm9vQ0vCWzC1toF1mxLv1BhptFyfAhIk7ImbiUnkPkI4Ii4v+2mIUknp9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKfYbp5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD94EC4CEE3;
	Thu,  3 Apr 2025 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743686651;
	bh=ljhJUxaQ+kRthX1ACKvZsuHQzUEf3+7S5pIFKkgnHnE=;
	h=From:To:Cc:Subject:Date:From;
	b=LKfYbp5AZ7EEVDgrvfuXX+w3fOODvz7Ffzh2f0err8ea8+Geq0MeR3IkYy2ZR5JR6
	 yCVrFFJhk0dkbQwzo1K3UkjrYPpdDa5j27HC7WdQOElbbZMv6zeOqRysBLOiGc+3ne
	 PEcFs4b4kM/huNg6WQQqDRyfo7DPPdWJ6EgwKpDw4Ffzww231flE3QyEMXiSOXpUJk
	 k0rdBJvKn6kRlHGFgiG/LGsTSC1+S1fKD+UKc93zjJcn9wOk6avb3iBY8+06ks73MK
	 6QGHqU1eE09Sg0miPGQ02fs3zZyOBiT6eaTq7pwvnLwkePBkF4qc6FClLxOYyO9v7i
	 w167tc6Wn376A==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: rcar: include linux/bitfield.h
Date: Thu,  3 Apr 2025 15:23:59 +0200
Message-Id: <20250403132406.81003-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The use of FIELD_MAX() breaks in some configurations because of
a missing header:

drivers/pwm/pwm-rcar.c:114:12: error: call to undeclared function 'FIELD_MAX'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  114 |         if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
      |                   ^

Fixes: edd549f4956b ("pwm: rcar: Improve register calculation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/pwm-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 19e5d0b849a6..578dbdd2d5a7 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -8,6 +8,7 @@
  * - The hardware cannot generate a 0% duty cycle.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
-- 
2.39.5


