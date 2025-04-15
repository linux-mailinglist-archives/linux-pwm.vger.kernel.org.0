Return-Path: <linux-pwm+bounces-5505-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B586A8A1C3
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECE9441B2F
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F047D29E068;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ+2r6tC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53329DB80;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=lnbrVxWkajl0ljXBcMdO7lyJmp33IH0m0cig1RD0C8/hwCf4CTI+QJglIo+YvHHvlgVwArWQEaWlgb8hTKzwePCT4lHwAjT2HZomF504ahd/XTY/0m4j4jWVwe2sWCuW8CgTLz4pm+qgM8SnxxNZG1KsfKIs3d2Otbk4XkD80cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=m52txbV845I26abToavpRxXAGj6iKqZnKmxudw++b60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ocpj27CR1hirlxssfk0P+EheevUi5FIsDhh1InYZKLwj7R8KWIcDMunFYJ42pdXjgSquFQBkt/a1DEvCBiYwUqLk7qbHinFQUKmIxNfJmzNUewGlK84GIMjfr/5Um2uM7YrgBEe86WFCQ6Tk2WWD/kP90By7tBoVzR7jR3/GdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ+2r6tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09BEFC2BCB0;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728560;
	bh=m52txbV845I26abToavpRxXAGj6iKqZnKmxudw++b60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RJ+2r6tCJEZy9IngLYw8MAuCbTxWClrkq6IPCTZ6E4XxbYPrnZpsHYzIQWJK1ykHJ
	 bpZuRy4HxPSbd22SoYkgXIeOQZenGYYBD6UOEqdN5Ms/9X47P7o/EiSiew1SQkQRPy
	 FPNuabx9gjpIitEDNp64SAbCGlNOzCZTRBiBUg2f5oDR8WAAwmNQ+adASEJgaI4UZU
	 BmK4dYxU+8+0XSHoSRw5lA7L3hKGHjU181TU3wx3VEB/eIUvHsX8ch6Qgs34d0arO3
	 eBOKBESRPXj6SjRZFpI69UxyUKfCK/y7oySKYfmHO6utJY/UQGg3cf0PPNtR+knR2D
	 tf9GRHNKURLZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D8BC369BD;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:30 +0100
Subject: [PATCH v2 14/17] mfd: adp5585: support getting vdd regulator
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-14-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=1028;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=PMNgdya0dxZ43x5DB45Njbna7Ac70vPeST9gjKhIiIY=;
 b=cXirkJFBAXlczFnI9vdLwWMcetge5QyFstRgH1DI1QK0wN5klqFLjSeewAAhlfO+uNG4WiN4Q
 8c39Pj4pQV0DXz/TIiAWpQWq1C1PYpsO7uVHyGPRC1eqBjwMg65Ujuu
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure we get and enable the VDD supply (if available).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index c1d51d50dca6c9367d4a1b98a4f8bbec12dbf90b..667cc5bd0745f64eec60837ec3c00057af0cddeb 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -18,6 +18,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 static const struct mfd_cell adp5585_devs[] = {
@@ -849,6 +850,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	adp5585->dev = &i2c->dev;
 	adp5585->irq = i2c->irq;
 
+	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
+	if (ret)
+		return ret;
+
 	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
 	if (IS_ERR(adp5585->regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
2.49.0



