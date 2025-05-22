Return-Path: <linux-pwm+bounces-6086-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE5EAC0B51
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 14:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C781BC73B0
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B128C2D9;
	Thu, 22 May 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lJ2zTeNo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6F28C017;
	Thu, 22 May 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915618; cv=none; b=mU3vL5twYdAX6abOPaUfUv/SqdiNgszKWLgaTg8OYZbRx5h2vP/gCgbw+fhrfCLqkGjWvbk2CNBf3NnKTbNZl8UXirBDR2RCw1XaYYJJ0lvAV2wqlRmvvo19IIYtrtp8+HMjIhVHVcl9im9xgqhUnFNdrwodP9iJ2k2HWRY+CjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915618; c=relaxed/simple;
	bh=TKtExURtBBoXKlQbeQ8pWXApgKHf6ZVWdlros+uARmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXHAaK7EUeaLhrUz0pq+1XWDPS8Zbdejz9WIvoDrSD3tnaaeCHPRG/MLBlYFsiGfMHXWt27qQxCSSg4E1sUGDnUibHNpWh+YmV/YEnwN/cRnkGy9dbCs/Fz7upEI5+8tBIhLvlY/IbxylmmZv6oBXCS7v4ZdtD9lySMTivqPLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lJ2zTeNo; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB7B41FD4B;
	Thu, 22 May 2025 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747915614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gde4hNbGxjPKI0oyqAoqLRnO/q5Opqk9gHiDD4/OSps=;
	b=lJ2zTeNo4ArOSvr2nz5jt5K/liUKh+YWwZxejIVPsK0sTpKdU8Kr2AVMgQbuGTDw6hYaU7
	O7iZh2cLJVdKLQjJHMOub9APF+XAukk9H5qkjka63dvozuVRm9dj7ZTGIxGz+zzVbFLfC2
	iE5vfieG9Y7eGXZ/WBhtjL6wVvikjk4jDwDChY4sZW/ObZQcXGuqq6AoXEMm17ZW+dSSyq
	nCUO++zG+DIiN/WGV+BJRuQ8N+Y1drfk4DE7/HowlSHXEBapif61+0c/qs5MwfeKU2N87t
	GXJtxW/3mVxXnL8gXGDA5KwBMtmQY1A/0CtO+8jIB4NXlexO5qhZOFGMJoPdFw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 22 May 2025 14:06:26 +0200
Subject: [PATCH v9 11/11] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-mdb-max7360-support-v9-11-74fc03517e41@bootlin.com>
References: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
In-Reply-To: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747915601; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=TKtExURtBBoXKlQbeQ8pWXApgKHf6ZVWdlros+uARmM=;
 b=bI5cST6pMne/Waha6dchjwdoLVKlx86LbpIG78Lj/OuTn1+i4RkUegP2u9FTefys413Vz3LdK
 e12hHUDjPqkBuybg1ZG54jffj0yjC3kMFzaLvK54gy0oh6MBnYAtO/X
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehleduucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheps
 ghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69511c3b2b76..7e6d95ee103c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14576,6 +14576,19 @@ L:	linux-iio@vger.kernel.org
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


