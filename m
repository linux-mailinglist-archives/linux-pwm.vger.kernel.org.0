Return-Path: <linux-pwm+bounces-2945-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3352D9436F7
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653E41C2080D
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808B16D4CE;
	Wed, 31 Jul 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoWhjMA3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183316D4CC;
	Wed, 31 Jul 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456887; cv=none; b=A6E6S0qWpnaB94Yl1/R8UVpXrjCm+WF6MIBujNIXWO1NXsZGwHG6nkb4XPKyWIKcuE/NRIVysBbWq1X/1OvyFXE+L9hT5ZgoRg/ElQgG1R5+UrdP6bJf1RNpdEYH4dEH89Riw/HrENnn7eLT7QqwYLhpAEk0j7hinWBaVfqdVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456887; c=relaxed/simple;
	bh=AEdwWlvteHHQecBlSLo/JPooQPgXPrKgh0jWglAl+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/X8SQe+brAm8TWG8/U5h+V8aQAu2zMjdLwk2u85tLSzd4UuVb3CWbIAJUCfHEhZb06vdRwisSg+Y/CmN2L3lYDC4KKZuwXqCOsphEUJmpV1VNujaq4Ofwgx4UUDyU32KVOdSO8YqmQvrn31QK/36y2E9OmBu/LQNrE4e4WykzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoWhjMA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D114C4AF0C;
	Wed, 31 Jul 2024 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456887;
	bh=AEdwWlvteHHQecBlSLo/JPooQPgXPrKgh0jWglAl+7c=;
	h=From:To:Cc:Subject:Date:From;
	b=XoWhjMA3qcCZuHCCkJZIbmo9tsIAT28PDG9n4bad6KGSp9E78RTjf2vnNkorh1cJJ
	 YWhO1xwXnstRnh3ba61TT7WYLyM6e3xlkVR/sEmf3NhqMCpA60eyLIFr0MHKk0+rSa
	 EHRcBHtmATsQyuSUCF86WKjZu6T/ZXaZX4efNBkL0qKm/OTMvZIHbjr8+SeBFcL/aR
	 DwpY9bO7jXWfsnFprNmnLSblPD1gIoHOLyJDivwDs2Oh5qag/SwIXlZNXXtlXqysKp
	 L+sDMy0gv1m4V890DWSCxLE9TL8nreI1Hgj54H/+FDN5cNi9cK8lBsvqEwSZmV/74B
	 faW+HZ/uqiU7A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: lp3943: Use of_property_count_u32_elems() to get property length
Date: Wed, 31 Jul 2024 14:14:03 -0600
Message-ID: <20240731201407.1838385-8-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace of_get_property() with the type specific
of_property_count_u32_elems() to get the property length.

This is part of a larger effort to remove callers of of_get_property()
and similar functions. of_get_property() leaks the DT property data
pointer which is a problem for dynamically allocated nodes which may
be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pwm/pwm-lp3943.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 61189cea1046..f0e94c9e5956 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -218,7 +218,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 	struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map *pwm_map;
 	enum lp3943_pwm_output *output;
-	int i, err, proplen, count = 0;
+	int i, err, count = 0;
 	u32 num_outputs;
 
 	if (!node)
@@ -234,11 +234,8 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 	 */
 
 	for (i = 0; i < LP3943_NUM_PWMS; i++) {
-		if (!of_get_property(node, name[i], &proplen))
-			continue;
-
-		num_outputs = proplen / sizeof(u32);
-		if (num_outputs == 0)
+		num_outputs = of_property_count_u32_elems(node, name[i]);
+		if (num_outputs <= 0)
 			continue;
 
 		output = devm_kcalloc(dev, num_outputs, sizeof(*output),
-- 
2.43.0


