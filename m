Return-Path: <linux-pwm+bounces-4460-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C139FB325
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A48D1882F5C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC721B85DF;
	Mon, 23 Dec 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CvN9o40E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA11B4145;
	Mon, 23 Dec 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972229; cv=none; b=hFjd/7kklofwbZoPHf5/2pp3EdfBwpIcOEvOK0OUMCORTJ5sZJ3iVJfyQKZ2bArDvX0+P/64/DUikDND6mSuGG910Jt5O4e2lfSX8eozW9+KgkcfwxmgL6wUAU/JJkUR3xPyNCUQDn454o73YQUMNaFAdHHBvBfUpQj+aG17wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972229; c=relaxed/simple;
	bh=Zm3hNlIJK4Ghndaqp+86HMZP8tXSaWZb3j50onuWCKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b841MjOTfqCxkdePBtZlc+BVywQonSHPdheeaXqJOIRPwH9XQZoAQA3srNP2tQhYd8EJSQPX7Wf3A4euocVXcQFtjGRCLDTYrNqu3PtWl/AODQeOj6XxgRWw1sXIPVpmVf0a+KJriP6C81dFwlG1yVbM0KphjOj4d1jo2IU0PKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CvN9o40E; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 943726000C;
	Mon, 23 Dec 2024 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734972225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T34nWd9yFdkrXkigkffAdGJP10kcUe8wrA4kltse+QE=;
	b=CvN9o40E/6qetl3OobonFU3qf1d5gfKMMEImS3BkJQwdtk7phmQwn2puy1T6vmGEBU1t0I
	ZKRB4IBWRqQGxh49EO+zVNpn4xnKeEhlJ7Lw9YAZjxOBWzIjd1ByL+m3QCdY+RSgz+hjj2
	E8VixxaqyrDfb+ai1O9biIeA9W7q+SAhVQFS/nAPS4DHOAMQJjcRrhjT0Hp3lMwzOrfT7O
	i75kVhnUie+hvg20oEPvyn8zpyBSDk+eZnTfv85Zv6hzSJqW3mWpSs5FReaPUXL16STsfe
	V8m8yn11vLSIGC0P4xcgyVFhF0VlvcTVsGBZUnQ/ujj7VaG4kVmHblhJYkDUXw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 23 Dec 2024 17:42:39 +0100
Subject: [PATCH v2 7/7] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-mdb-max7360-support-v2-7-37a8d22c36ed@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
In-Reply-To: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734972218; l=1042;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Zm3hNlIJK4Ghndaqp+86HMZP8tXSaWZb3j50onuWCKQ=;
 b=+LSADrwRkM+hMdwxcGG7KCKkMC1J1a6/9ICI+Yqhmou2gnka0fsbxULlh7vgX70++W6S9oVDs
 CWIxnBtpQ3qDk2al6fymYxlpzhF/gX1EgQzw8FgO4xRxmVOE9oR7rkF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..18a7b7cf0b60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14132,6 +14132,18 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/temperature/max30208.c
 
+MAXIM MAX7360 KEYPAD LED MFD DRIVER
+M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
+F:	Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
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


