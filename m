Return-Path: <linux-pwm+bounces-4403-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C909F7F5A
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DEB18808F8
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C6C227B80;
	Thu, 19 Dec 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IYvEwIrr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7A22616F;
	Thu, 19 Dec 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625318; cv=none; b=F2VpgwI8UOSd18JXHjNKawkdlYWKhxB6F05fmZimGZ4HeC9iUBdGdmIMjvznrTYh3EZCK6TomJWz1Db4NSekjsb/HVzYuzgkNM+Kz88IWl4zKSBtHkTok9up2rVFehQMv+x9OI9goe34qBBHSykz05uJ3X40SAdrkt07eE5D2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625318; c=relaxed/simple;
	bh=MMa1aWrpC+Hhbb5vbJvmx5OLBFFy4Ju1nNEWOoDy1s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvPZPQ7VIDbW6jN1dsDl1ximME9NFZ5qHGXjukoybUCBpO4vVW22cOcCktk6LKlVHK3d0zX2N0pWFjdQGnpQ0LyeRmIVaeVspxwfDNQSoN9vo1Z1/jR/nvAvBuJggPIEXVfOqsAXonbmBZBizQXcXkBmBVO4YR0mcguMKUN8TW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IYvEwIrr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21D5760012;
	Thu, 19 Dec 2024 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5ZGJQUU63vFd9YFgXUTncUS1ermsqmNadQRrooj508=;
	b=IYvEwIrr1nm8nr0nts6jaOChHC8gDWyyW8FNiEJ6EXYxNBVqwxRMLryLTC2SThG4LFjw/R
	/PQizCekvhUcIDfCo8TZ//7H1IzV7CIy1dAzNgeuw73DEJpZ769gD8NcUFI6Ov0Q0oIkY4
	rXxB0/TMu7S+gSJs6O5PsHKWgCfwmw3yeo1JLprCbZeRcOasBTqJ9/nf+mW0+tyZeFdUC8
	3pJ4QhjnhjhnjJVn1UEFt356Kyg5rzA1H4U7nV0CKVt2R8mFs5XuY4ythJtvpwz7GY2lDf
	miDtaKgWa4jZ3uPGOS9HIIRmJ8gwQGj2vwftmEp6uJKqVk1/XtfRZFHIVdnl2A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Dec 2024 17:21:25 +0100
Subject: [PATCH 8/8] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-mdb-max7360-support-v1-8-8e8317584121@bootlin.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
In-Reply-To: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=1024;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=MMa1aWrpC+Hhbb5vbJvmx5OLBFFy4Ju1nNEWOoDy1s0=;
 b=gJY9TqsxOErNI5KgRO1RC6t1fWCzwGBuuTSDUM7w5JJ+7zQdNKlWEvEBaOdF6oNgYAA9/2gjA
 Z5c0nJDYA8DDVL6elxigwvZ2oULzCD8E85p8oXOcv/QiR/BhSxW8ZQH
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..6e9b8caebb38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14132,6 +14132,18 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/temperature/max30208.c
 
+MAXIM MAX7360 KEYPAD LED MFD DRIVER
+M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/max7360-*.yaml
+F:	Documentation/devicetree/bindings/mfd/max7360.yaml
+F:	drivers/gpio/gpio-max7360.c
+F:	drivers/input/keyboard/max7360-keypad.c
+F:	drivers/input/misc/max7360-rotary.c
+F:	drivers/mfd/max7360.c
+F:	drivers/pwm/pwm-max7360.c
+F:	include/linux/mfd/max7360.h
+
 MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-kernel@vger.kernel.org

-- 
2.39.5


