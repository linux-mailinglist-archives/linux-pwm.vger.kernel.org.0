Return-Path: <linux-pwm+bounces-4183-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE87A9E0BED
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A693B2D573
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8181D90BE;
	Mon,  2 Dec 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fMZUqAQB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D31D79BE;
	Mon,  2 Dec 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157906; cv=none; b=Bnuiqw9ScVJFF+aehVnfzVZqeTsWlKg45fphRFEJU9aAOtxm8vF04W3Hkc1wHat3dpbS6/je1xe1yAVDHxG6V8N5k/7BslU+MndGap17pNbbJrACviGs0QJGfSlRwWa5bzGzar4nAYCLrmsuXcQE3nlal+sB5kDmMciCGOZNq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157906; c=relaxed/simple;
	bh=I4VHummiJrKsJbIUwMd52De56NeUEhWbPfaStA1+8kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/Mh3wWBZTnXAH0PXc13p+9gj56HFj4blj/EeVfEZ0oqCLhuX2YAlCgPGtM6xJDpy6PdM/99Fcjbrgbgo+RsZ8QUa1g1ymKUb0G4177yPCMyZI0X50vrP3i/cmWOQ3F6WCi7jBzcp0NdQspARXitMtgKtkAonBD/JXCxvYpvPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fMZUqAQB; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AF488C0008;
	Mon,  2 Dec 2024 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733157902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=imbv659LCzWmKKL5WFDY3dC6juoBFr1RJzTd9558NvU=;
	b=fMZUqAQBK2vAl+1QGbORAF7xexnH/uspJ3FXPTTF8FrYeqx/dJ0MPkPbx2q9njcmhQZ0Au
	Fp4Gas+n/6lTdWk43wD7n8AzwwUjbZz/1tysffdQrtslgUUvbjK4RuwbhHCrtCUb2/DLrx
	viPmNiCEEKTJfphmer4z5TDBCQ2OnQOAczvylh/8McRz5dNT1gOEShcG9hkCcyfYeukQFB
	VHcOxwJPMWIqYWjUFhfnkDMwUVRKeyu2/iiFKrI5mI2seKQCN3Skgb41+k2GbYjM7s7o9m
	Er0Fy21+EEqVmoMaLi+Z/XZNjprapuhc5G52TzYhT/HI3RuLVUdhKGGTJet5oQ==
From: Herve Codina <herve.codina@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/1] pwm: Add support for pwm nexus dt bindings
Date: Mon,  2 Dec 2024 17:44:59 +0100
Message-ID: <20241202164459.157672-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Platforms can have a standardized connector/expansion slot that exposes
signals like PWMs to expansion boards in an SoC agnostic way.

The support for nexus node [1] has been added to handle those cases in
commit bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through
a nexus node") and the gpio subsystem adopted the support in commit
c11e6f0f04db ("gpio: Support gpio nexus dt bindings")

Add support for nexus node dt binding in the pwm subsystem.

[1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9c733877e98e..4a7454841cef 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1707,8 +1707,7 @@ static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 			return ERR_PTR(index);
 	}
 
-	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
-					 &args);
+	err = of_parse_phandle_with_args_map(np, "pwms", "pwm", index, &args);
 	if (err) {
 		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
-- 
2.47.0


