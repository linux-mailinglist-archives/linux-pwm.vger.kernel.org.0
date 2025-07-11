Return-Path: <linux-pwm+bounces-6838-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37FCB017E2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 11:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B515A20FC
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548928033E;
	Fri, 11 Jul 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g17GWOvo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDE27E7DA;
	Fri, 11 Jul 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226242; cv=none; b=iNHgXrowk3FLvzr8k0nEisPg85us0tiIoKZjCdZce5AOd+kbh37bxc3Xv+SSHZQHQcdYkmUf6qlU+VNzQxdvzP3u1DOHf9ZLAY54jk1Ychr/J9TzRc2i7dKiFvPzFj9ZtPDKdKi4fENRHVkl/r17go23jk5o1pEgFvfaUloqUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226242; c=relaxed/simple;
	bh=jlaQE+mBCVIwqEguA1eCJbvaVXOs/PTbp4pNB9rSZPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN26NsLK6M/AzrWPHOKqaGniDFgq8KGo3OiYp14x3Dot1LttWJkgXqsYQNj864ItWEifR7xwe6nDQcpUvIEHD1phJSd87Vrc+MiXbdR2oXMjK3OHZnxG5987UzJgYy7/fjWQopQhs01DqjlqLxCE7p82ynlVgvRYYI18/CWs40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g17GWOvo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D014743A23;
	Fri, 11 Jul 2025 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752226234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YX1y/TAYW9gFFD0bPjtqpqJsDxZpj/LtkE9fuNee9O4=;
	b=g17GWOvob+l+fMiYzsflIPvis2t9E3uAFZjYSD+PyfSr2O3VRI5jLUCf6iCS0GEdNc1wbE
	OioT8ScpQWW6wCql42FcOygHcQUPqiozhaLdR8TLRjKIBRGbUyy8HVvoPh9smC0tdp1Y2M
	VIhI6ryxU57PA5OSd6M+1wWlBHI6ClcFXUr3j4xwH+YOwSbEB95vkAXafGgHZNT+gp9sd5
	nYK430FawaG63hStQquDsUs58KD/0nfz+QlF4F3XJTZE+h2ugj3H31DdtuK5izROVfH8YG
	zbsjdMPVp9qWSf+Hn0wZEmZnvTRnFCGFiTRJuBLCyymLHOVIZrUGLo5QDyKStA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 11 Jul 2025 11:29:50 +0200
Subject: [PATCH v11 10/10] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mdb-max7360-support-v11-10-cf1dee2a7d4c@bootlin.com>
References: <20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com>
In-Reply-To: <20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752226224; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=jlaQE+mBCVIwqEguA1eCJbvaVXOs/PTbp4pNB9rSZPg=;
 b=xkAWR+f0YXCFa50KQg3Nk/PGiSNumgMki5xODJj6nQGqhVoLYou6LWCqArUOrAvc7W8cWQcjM
 m5LiI84ZM8FCB+TwFh4VMKr28WMAwycRDTRS9ZT+MV53YzzrINy7681
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..81423ac75720 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14806,6 +14806,19 @@ L:	linux-iio@vger.kernel.org
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


