Return-Path: <linux-pwm+bounces-5413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B694A82995
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF7C1C01166
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584CD270ED3;
	Wed,  9 Apr 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/UJCNDr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CD26FA77;
	Wed,  9 Apr 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210617; cv=none; b=Beo6gKzZkHHdbVLPuQHTpphWULPB3mckCxw2zuTuCYBuAA9p5YqCCITP47ftsyaxy1RJt8koI3MIPgqjgK2OZBw98f54p4fBRN7Hpm925wucu8ojHzBjB1EbIupf8dF2kLkOarcHprSanTi1K5uw4017Zq6rnbaNi4R/2jyU3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210617; c=relaxed/simple;
	bh=ujbrfAuU1zKdwr5Rw8sKUz/PSsEcuRiBC+aiIUpZZ/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZ4Q+90/fyuq3LVSGNxFE7VMsMI81y7QRsbu9Zkw3fl86MvbNSrj0jMYmHXksH2L0ylmHR4K8eBC/2T56z2WHas+W/ZqqbTbUjb2U6I/Lb5CTCr90jhlntFEw35bM3GMEr3G6wgtBCxL/pgu64yncv/nH7UmR37cL1MIjcO9Gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/UJCNDr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7F2320485;
	Wed,  9 Apr 2025 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744210612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1rTe2Fts4AcW9pI/PJXuH3N++IjKrJP5kBuSEpK1gE=;
	b=L/UJCNDr9eD96NKvVg2JDbYqC1Q8yMbtvCqDNkDvuUQ4tNumae3aRU/PFz+QMMWMjr+qgT
	5WUVN5pswVGmeb5l4mz2gouTQ1h17X3/TpcHP/hfCUdQ6x4JOyGrer+FnqNMsU9+jrq41q
	6+8LZ3j8GOScfL7XVZyij/amFRiTriFF0f+SJkbMT6O0mk4mz9yvl96iv3xSvGggMp173b
	2MRxElsPAMv6wsU4Pw6mvq2MkykeHRFvPBoPE+XLW/psP02vavXo7E9dL4xJdyd2Aqdm5T
	umy6Sl/j7ad3YMvUjhMfURwh3amMhyo8/qRnmcaryJn1lxEBlI43pLmqo+W7EA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 09 Apr 2025 16:55:59 +0200
Subject: [PATCH v6 12/12] MAINTAINERS: Add entry on MAX7360 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-mdb-max7360-support-v6-12-7a2535876e39@bootlin.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744210599; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ujbrfAuU1zKdwr5Rw8sKUz/PSsEcuRiBC+aiIUpZZ/Y=;
 b=D8BuH7Sii+uy0a+EoZ5WjwRuEd+ugSVK8+aFammXWvJVKbWvuRYUW52uSu9ciCM+fr9vHTsd2
 X2mXMcSdi5+Aj3FBvFiCFYLx0IJMLVaWAtWO4fnZAVIbn3MSuEdJ8Qn
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeivdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvs
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add myself as maintainer of Maxim MAX7360 driver and device-tree bindings.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..0c4988ec7052 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14554,6 +14554,19 @@ L:	linux-iio@vger.kernel.org
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


