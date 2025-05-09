Return-Path: <linux-pwm+bounces-5864-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA20AB0EA9
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B263CA01A69
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADB428003F;
	Fri,  9 May 2025 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JZWCusfr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B9274FE6;
	Fri,  9 May 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782099; cv=none; b=oQxa1oF1akq6v4+bV3RQigRIEC5pETsDzXnaBtDW3z/HzWVCOHGvQxuL4LK3CiDDyVW0KCrj1NtCXAy3YiiQMJ1Pi+hQvyaTWi9AMC4pTCUx4qY6/xE6tOMMObHmGERWN6dxNCFPsdv+cKmxWvH6WMudRdt46NMzn79LEzuOVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782099; c=relaxed/simple;
	bh=TKtExURtBBoXKlQbeQ8pWXApgKHf6ZVWdlros+uARmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHPHmPz/rYicdD5baglDJA1EIW56C4yW1FLI9ex1L+UhLTYKCD7OjleaMSJDz0NsilVwlS0NOp0W6dnvV9iY384pqCnMoTmlN/kQsrHN5QjnEl5u/vKGv2oHA0NZCCH9aRPA0Cmxo6BIkQhjlRr3Hcu8CSVMnFSxeMlT1pzJaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JZWCusfr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BEAF1FCF5;
	Fri,  9 May 2025 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746782094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gde4hNbGxjPKI0oyqAoqLRnO/q5Opqk9gHiDD4/OSps=;
	b=JZWCusfrlYLCg6m+fsMYQMhT81Q4zpF5XWxl2BqYHgCuIFQBJaGHVRUCUZAkjT2yjtxK7W
	C7VXs1Bs+36nVN0RSFDXSXxSV7kwAM6kd587wS4vr0Ewsp4YwDaxQIxTvav3FVN/rZmX/g
	LiNDK9qen7DtUFMzlil3va3+nLCtFUB6C0sYwV0SGsVR7whRebivwrskJAjNs3IzeOdQ3v
	rPcycdaI1+cWEk94XLNqYWqpYNT7KnRdiWSW5WeZJ3yzz4YC5x2+080NWdB8PHhKV5odae
	qqWu/aJkv6bZ+UxEZ4nMjuLvVixENisUQEsHBghd1gTJEyeqjMOKuhwEBEFtMA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 09 May 2025 11:14:45 +0200
Subject: [PATCH v8 11/11] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-mdb-max7360-support-v8-11-bbe486f6bcb7@bootlin.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
In-Reply-To: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746782082; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=TKtExURtBBoXKlQbeQ8pWXApgKHf6ZVWdlros+uARmM=;
 b=CMDG8YSlAlGrqlxkCid3SuWH7o0bAwM/CEVJqPj3z8HcWSgv4CR5lEPkoizJm+E7fE0safH4u
 gieoskHK3BbD0I2dRZ7fkanEynMO6YZL2IEHFwVOEMFIpGQ5Qgydt9Z
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqs
 ghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
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


