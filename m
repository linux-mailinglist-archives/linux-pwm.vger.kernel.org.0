Return-Path: <linux-pwm+bounces-5169-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9671AA5F7A8
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F963BF185
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA018269806;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAgn0JYV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949602690D1;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=uPzPnGlMKy+yRWFoekOtwWNempIQGpZkXniDUFpK9o+6CNhbxOvgkPI4tJgWAv2/o4yIUzL+cfyZNU3xHO7MwG7Motw4L8kFCXAXvuzB1cWaFovNNcAqxpecwZK/8y86nh4GL7tbOR9k+i9s68tdfE4ZQqlBGKmqvk8atMmrgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=uXW7xk7RjFtwz9/eHiqWTp3uEA/z2hCFoeDIFF3e+Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQZrpW3MWAUYVTHe8RTtwlml/KhBgJh2ujrYt/E365W9YZibB67iycP6iraOjJ35JJbEq8LRYVovi6dfQVMKl+aHOlDJszdHENWp5XUmrVejFYEakWFQD6yb4QkIN1oKWmzdt86NNfNsQe5PvTVQTl2YVNToaBsvrkmZRtRo68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAgn0JYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD971C113D0;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=uXW7xk7RjFtwz9/eHiqWTp3uEA/z2hCFoeDIFF3e+Yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tAgn0JYVAKNiuSyQ0EupMSGNxfs32lsn4MybtsBdtn/PQ4MEMQFSSkfvG4LRkYcVH
	 Wb4uc/0U/O3/fME9VO5bZli7QrSIrBEpg5na7/V6FiA73FtUs8/8mNEw5bS/bJKZwz
	 sST9T41IajEVwul1W/7G93aK0C80GJFegg96dJbCzlcPe0sZ46pQXZG2mMBUepdOCg
	 5uCtfXrcuq/V8ziD7927KA13HsvIl5AaVzKGYaEbKm7pGsuqeMEVrJb/JFpN4sUTbe
	 g04oRYPrPbyEHXOfWGznqtWpvrQ3SczBbpIIRb3HCBMXrPcRHidI2N6JV4Qivia4KB
	 fNbHh/xW703gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E881C35FF3;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:35 +0000
Subject: [PATCH 18/18] gpio: adp5585: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-18-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875562; l=689;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=P0ZkoXH3VRNpqlqHd8qSMhJYSdP+cbx0zZzSEvnRg0w=;
 b=BtgG+iLMEWirXxzDnVoHGskZFy5DrxlCP7h8aBoe5Nne4DICyQH79iKwBOxKDUlFVDK7UHvny
 /mWDby33fYwBcWu3FuU/aDfzh8E+/0IsMuZ6rJxwVJTElDj/Vjov7q1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Explicitly include mod_devicetable.h for struct platform_device_id.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/gpio-adp5585.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index cfd0aab1f7414f76287714eda44184c615491194..faeb6243bfb40007517d4484621a137aa2f1bd55 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>

-- 
2.48.1



