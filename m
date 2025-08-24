Return-Path: <linux-pwm+bounces-7161-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B568B32FDB
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA9E240D33
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93E2DE70D;
	Sun, 24 Aug 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ITXGv3iQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DB2DE6FC;
	Sun, 24 Aug 2025 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036715; cv=none; b=S3e3jFFqTpOICBNtOIZV3UH8b+oXvDrfw4USMTZkimQN0lXqcH8n8RcVmXzH6Y9CQvFG8peWmMTqOXcZMeA4E2/So8Jei74BAgABL3ufPpKA3pZKG/1oYk+SmILhNOGgTP8Avk4/sD5x1Lp1MygMq9DiG5hux0pKbLpJKX0+Q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036715; c=relaxed/simple;
	bh=ixAd5fgH02XrNA6FlGuQzJcZJ1xvB//XoeEe4mROJI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QusezKAJC61n6Nv2yeOru4IbIrwLP3Kt+YJzc4gQ5qm5waM5UWXRm6vk+bRFoY07yWH9GWbHxdZEogSlg4+C5ZukAqI1F8SjH81dzNRxpTV7bpgmd/cJMk+R1EIYMnhsp0bvm2OcOSnxw4O0QJwSBbKWuNt4YdBqlqdngjgNf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ITXGv3iQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B4A4A1A0DA2;
	Sun, 24 Aug 2025 11:58:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EA9E605F1;
	Sun, 24 Aug 2025 11:58:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE9831C22D26C;
	Sun, 24 Aug 2025 13:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756036710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5BQKLzxHcSP+Ym2rvRUevZmK0xetSeZp3Dz06CAnblU=;
	b=ITXGv3iQ0lZ7cnzN5bnJT7JjINj3mXBTJEdmdNK3eGu/zUeqAncna/X05CuSdONAVEx1X0
	HFhElJDjaF29DvsD7bA64rfDbLGP/K7M2+BZ0aKmS7C0ARTv7jYWhF47sXyAOOjKh8hWPQ
	y88XbBWItCRVsNVof5LsP5h8uR3GWG7LkMf9QpRa2HnQMVq4N5kAj9yFVi0j99Vw4BobEs
	Y/SWGcB2mEfMziCToNvBt61qw11POpsEr+xnuQu6diX7Rl+wIu+8EL0LJAvwFgnG+CeyO6
	mOnWIUB+VHvU5+7xb0tiirytJHn/K4iRJaWwHylhj4RC/9O5ftCEVrllSctIQQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 24 Aug 2025 13:57:29 +0200
Subject: [PATCH v14 10/10] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-mdb-max7360-support-v14-10-435cfda2b1ea@bootlin.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756036647; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ixAd5fgH02XrNA6FlGuQzJcZJ1xvB//XoeEe4mROJI8=;
 b=EMe+5Koun6LkM5+1HplBWQgqwTSzKWVcD7KZ0t7cawgQ2PSv2d9NF/1ZlOS2mKLu0E3KujXB/
 i1VaP+fOG4JBeKfxXAxmXeO9wM3lKt2XPdC8HKEA6dv1MMYU4iHg6OA
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..6ac78b0ccc1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15011,6 +15011,19 @@ L:	linux-iio@vger.kernel.org
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
+F:	drivers/pinctrl/pinctrl-max7360.c
+F:	drivers/pwm/pwm-max7360.c
+F:	include/linux/mfd/max7360.h
+
 MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-kernel@vger.kernel.org

-- 
2.39.5


