Return-Path: <linux-pwm+bounces-2944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5881943644
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131F71C22C06
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4D174EEB;
	Wed, 31 Jul 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKktUMx/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F31741CB;
	Wed, 31 Jul 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453264; cv=none; b=Vjd+a4Dodn/akKguUANGGAx5siyfbkHsElHrNLEu2BvsysaABovmSYIIQXiGCN49E/lj6Su/r7pI7rlew/FmAwLW818WMrLlbITQuyAbfEhRO1cTPU3dpVjUkAYXrtYpBq6Pw7Hqy7heJ2CDQPhe/r9FmqSX6LbWVXNY5sViogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453264; c=relaxed/simple;
	bh=s3QshrOh+QRxZHGuF0evvTbSZyLY9jl688LuBzX4Pcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPORtn2hklt6AQPWtwYIn/9s4IWz/X6FCVb0Jyoa2/+gwy1QzPWM/gmZ9ffCTFtvY1+nQZvW48WTKDdWsMioKJTvnWV2xgkwEceacKn3tyxYXJD7y2yxNTPi2scZMyLqPZuwbEPLChsQm0AlZgPnVYP+e7SRQnfHayBDYDcVDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKktUMx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E37FC4AF09;
	Wed, 31 Jul 2024 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453264;
	bh=s3QshrOh+QRxZHGuF0evvTbSZyLY9jl688LuBzX4Pcc=;
	h=From:To:Cc:Subject:Date:From;
	b=IKktUMx/oHlu/Yd64P5vbtuRQieaWDxR2f3Cy5zG0CrwfqJm/hlzBvueXpIRaaYm8
	 vEtWRcHTHoqjOCiXoa+8lSDxV1VxJAXJLJLdqbQpdHIzP+XZYEkkVz+1dgh6Px4SUz
	 g/LpRhEdLhhYAFproqe2EMGGomO31hkZM1RwDPZYpunijhW5cOfoT6xEMPNskyscIu
	 sZB7UtfcbCqB0lJKT4YYtmwi+FHfcb73gmnOxtcGb2nQBgkytXPq8FyuGZ51P8oBiQ
	 cn0MYIQKf5x04EMplPsejlX/f78XnHDLL1yX+47tlPW6xa+PN9g+mrNRtP+7wIX0Oq
	 5tF/Et8pSAdYA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: Use of_property_read_bool()
Date: Wed, 31 Jul 2024 13:13:03 -0600
Message-ID: <20240731191312.1710417-25-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_read_bool() to read boolean properties rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index cd51c4a938f5..e514f3614c43 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -355,7 +355,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		goto err_platdata;
 	}
 
-	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
+	if (!of_property_read_bool(timer, "ti,timer-pwm")) {
 		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
 		ret = -ENODEV;
 		goto err_timer_property;
-- 
2.43.0


