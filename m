Return-Path: <linux-pwm+bounces-5745-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DAA9F008
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 13:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A651649B1
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540326981B;
	Mon, 28 Apr 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RdQAQH0H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE54267B1D;
	Mon, 28 Apr 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841472; cv=none; b=HlKzcIsKwFgB7ZVpgfJBwZ23+8IJABmpDs91QpNAUmvWA+aCmlL0v2mCRhI4ER+6H7U94KYNyVrniNX8kZ3uP+4vnm+84NxzA7kU9sr1ZuiLqTtBRU5q6BzOiM2NdgvU4JSoD9a+LYFW4vamPLBUzv7vqZ3KW+qp2gHnJNQsdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841472; c=relaxed/simple;
	bh=I2IGpxO4NgZXl0L9/MiKk9oiYXyeKXn3CCspfz4IRaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcpqYDAG03FNrrk788lao+/NEavjEG6UlEHGxAmuyfU9s97uEnM8ms85BSnH0pWNB01PoOOSlnbv/9nsr7rPiUBQJGWu3YlqUWOdKp4uf4MQ3iTNXah4Jiao4K5p7wl+g2WKtA1zSriWntQqAgiu2HVEEbIpFnGCoBobTxB8Ipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RdQAQH0H; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B10CA43A1C;
	Mon, 28 Apr 2025 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745841468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjYgqfQk6Hv0GvUwtR8/B8fufceEeOL7XN50xFEMFlY=;
	b=RdQAQH0H9gmiKbVIR8b4mta0+7NFOBBJdAsLaCby5C1o0/KJaMGq2183yJx8NRhRZE0nuk
	APWzR3+UOaUXE03tgUpcKxSrOvOOMWiEEQdInUCjEoJlM/JAj7VqJymaxcKboeAkoXkiuw
	1mVl6+f0RWzlO2yuqUAkldN3JG5eh1bhbZHrZrB11xcHuiAXf8bwsy5kqEK4IqOP0QBpOe
	DTXhzd+Wv/mPNp9Sp2y8pK829py6FLzAiA4Un3EsN2WM+TkBDDxvGCVWk7NejOG0QpsCbs
	2pDrsgGxLB1IEvoAGM5ZKqiXHw2bA7qgircEcigAOsVDZ/RHTgam25nTw8BxaA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 28 Apr 2025 13:57:29 +0200
Subject: [PATCH v7 11/11] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-mdb-max7360-support-v7-11-4e0608d0a7ff@bootlin.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
In-Reply-To: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745841456; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=I2IGpxO4NgZXl0L9/MiKk9oiYXyeKXn3CCspfz4IRaE=;
 b=yllQ9Rpln2gM7JVCLhlqoA6n3/eX7A0a2MKjXnPySIpV3LtOFOKUhcwYums55rbwCgRFtI91q
 9l4UtnzF1JPDQS2XVR3kyyHY7M/62H9dka3S9yeCDohWLgq7sqYEYIc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbf9ac0d83f..e08d531494e4 100644
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


