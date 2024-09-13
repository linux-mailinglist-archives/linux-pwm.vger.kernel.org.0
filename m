Return-Path: <linux-pwm+bounces-3248-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0229783FF
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC80B27C44
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C431494D4;
	Fri, 13 Sep 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c78HargU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC391487C5;
	Fri, 13 Sep 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240137; cv=none; b=dmu2h9SdbEIeiUMMmV1ADU54+DCetEZxCZqjAgGDho7v2+rgMIDbQIvh1f88cyPudfeaJ1D5VFoL8w0k2PWju4FksWu0kDgCAkHTvB8MjZ3L07WkeHmeunEZFWki52jNoQP9ILS5/Ygd0D06CUHGP6J+7AU1fzTvRuJ2abxW6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240137; c=relaxed/simple;
	bh=gf6ZfAOFwzhYiHvZhzXOirp3dlH6f9UkWyv1s06LoVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBf2foNe7G9F9d2JTrDmJdYF9w5OnRC5wp4ltNS9FgZin7u1HpI+xRTkzd+c8JatiAVqimub76Wwqw6ta7IDzY/JH2xlm//cEdc/lw6dAKq6zNgXXbZ71+tXg0iTs3VtTeOgGijIDNr9Gzn7E/GKntpIPyKaCx2r5BytkpOghqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c78HargU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c412cab25cso1285060a12.2;
        Fri, 13 Sep 2024 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240133; x=1726844933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbbHD3pBQCrXX/cc6mXLHkXHRMGzQ7tUN2s603wyUA4=;
        b=c78HargUAOYQJ+uIZpSP+sX2xI1egivAJ0Owq7EXVHwtmYzQ2wn/Sk1vh1jxa3436/
         6m5KSv98HlPpM6diKKAv4/y6uE1zr4/1k8dPmVlAT5rDpncnYRsZoIFpNAddSfvvXct1
         xIe7OVebb0VIbvOR9SlOOJXxBU+w6ovwoMugCT3mjVqLJCzjmY2YNEWTCbVtyV8v1Z+j
         BRUNzf3CLjrbDIiBN4rT9U8sygfKhoihMrISsGdqTNXYGoJP1n5ix63aoAoYpiHl/Lgg
         ZqB69bxqy/PLaZTEiOecs9m4+5neqHgOORoN1DJjHyI1CvMfbd2yIeDqNF9xGqoiD7QU
         1k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240133; x=1726844933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbbHD3pBQCrXX/cc6mXLHkXHRMGzQ7tUN2s603wyUA4=;
        b=xArN18wCp++r3zAvWMXSM6qAE46rUf8F1Y50hmh48ozwuD9c6dDpJTw7rFgJ5hG/Kv
         RsiuSnCsCv+YNBFipaaZtKJ7UEcPOG5zmFtqoMe8Hgme0EG4kfoZnbUjz8xITifnEx6z
         hpmnV+NVGqIXGH8Mv7H7+mEGu/zzU11EiPUoEv4z0aOIr+SQNIwTds2m4ej0ndYwplg5
         5lkukLMjeEPZVX/TTG0PYis3YpZxS2uMuLxtKinEFy9h+SyDuNyygIOCaGv8iHO42Q/z
         rlgySx0ZxxKjY4BvzP2VB3o2+PI8XVA7GC7hg8vLYQ0LZcM+7XLdvCw0Rnsq7ukpxbvE
         2REg==
X-Forwarded-Encrypted: i=1; AJvYcCV+bkM7jA55413dBXkvVjqMDnzzEtlqaorC8U8keqotj3Vf9Ao/pilORkNWMfn10Qiz6IJLUz6+VQB1@vger.kernel.org, AJvYcCVZkfnGBN9iDqTsu8EF31Q3hWpTEMShKipMRLO9foXwRJUY/c2gEVMoPu2OZhbP/KcHRslZLwDsUJQGSto7BQ==@vger.kernel.org, AJvYcCVfCGoTYxV6dN8xFI0IOIs9XR1uxFwkVgN+2gqve7wxOLyUAWaTuqNeIFAaL/knWvIyhp29CqrMwJT9VA==@vger.kernel.org, AJvYcCVixN99ShJgJPNjHIpz0MEoER20t07L4uyEb4aFtEKcpceORsfoWeHEO3do20BSKwBMle3pil5n6Qbs@vger.kernel.org, AJvYcCWEi7kex6asg5xcqA+vtrvaIbr2MO0V9YuyqasZFI0or+pw6d9Upc/iJ4VQiT4Jz1+UQhbuljRTYAO97LY=@vger.kernel.org, AJvYcCWm9/Vej+MJvRnAyOSyI9kBFYtC1toJMiRcVC1zgoRk4N3/ZrG/y/kndmqZLMwYezSI0yqC6NAYqk/qwfHr@vger.kernel.org, AJvYcCXGQdKvG3UkTynthyVjFWo3xQJcqBG1otdLZN8NLGJXiqvG99qWGNmdj6kaNdzEHRx/wlQC2UQebcopX5YkoQvcNfM=@vger.kernel.org, AJvYcCXI6y0iwM7IkcyzGke49XzphIF0aPPQxa4vI7h5E7t5YXy5fw93AAbjsX6Dcb7RU1cgT1gEqiDUkfOe@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDX3GbNSCHoYR973yIlFh1QZStxcnk+Xurzae0Tcv67gn8FJm
	DmoVDllzFNluRl+feMTxe1u6Qb7XNF6wBKWjQCsSwm0rPgUl5m7maDKfqQ==
X-Google-Smtp-Source: AGHT+IFrmIcqq1MIf8LJhgEBVPH8le+KZ8m6oAVmRkOcVVRBGVEXkH8BWNxmWG6j86+uLzYaXOGxyA==
X-Received: by 2002:a05:6402:d08:b0:5c3:cb1d:8176 with SMTP id 4fb4d7f45d1cf-5c41e2ad471mr2096600a12.30.1726240132760;
        Fri, 13 Sep 2024 08:08:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:51 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:58 +0300
Subject: [PATCH v4 15/27] regulator: add s2dos05 regulator support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-15-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=10690;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=gf6ZfAOFwzhYiHvZhzXOirp3dlH6f9UkWyv1s06LoVQ=;
 b=WhfjlLx+ght7ekqiofm8OEYevYj8ZRvBqndBLYsoIsW26vQk2a0wLl3m5Qq5t3Mjk/v+L8HeS
 P19gyMylJekBZPxK2iHiVdZuVGtIM/JJY6lnKdZSCeV8v88PgSTpNFm
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

S2dos05 has 1 buck and 4 LDO regulators, used for powering
panel/touchscreen.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v4:
- remove excessive linux/module.h import
- use generic regulator helpers
- use of_match
- use devm_* for mem allocations
- use // style comment
- drop all junk Samsung code
- adjust to depend on sec-core
---
 MAINTAINERS                           |   1 +
 drivers/regulator/Kconfig             |   8 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/s2dos05-regulator.c | 176 ++++++++++++++++++++++++++++++++++
 include/linux/regulator/s2dos05.h     |  73 ++++++++++++++
 5 files changed, 259 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 444cc855a01e..25dcce07180a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20476,6 +20476,7 @@ F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/regulator/samsung,s5m*.yaml
 F:	drivers/clk/clk-s2mps11.c
 F:	drivers/mfd/sec*.c
+F:	drivers/regulator/s2dos*.c
 F:	drivers/regulator/s2m*.c
 F:	drivers/regulator/s5m*.c
 F:	drivers/rtc/rtc-s5m.c
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4b411a09c1a6..63085d73cf74 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1322,6 +1322,14 @@ config REGULATOR_RTQ2208
 	  and two ldos. It features wide output voltage range from 0.4V to 2.05V
 	  and the capability to configure the corresponding power stages.
 
+config REGULATOR_S2DOS05
+	tristate "SLSI S2DOS05 regulator"
+	depends on MFD_SEC_CORE || COMPILE_TEST
+	help
+	  This driver provides support for the voltage regulators of the S2DOS05.
+	  The S2DOS05 is a companion power management IC for the smart phones.
+	  The S2DOS05 has 4 LDOs and 1 BUCK outputs.
+
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index a61fa42b13c4..d26e0db7c825 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ2134) += rtq2134-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ6752)	+= rtq6752-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ2208) += rtq2208-regulator.o
+obj-$(CONFIG_REGULATOR_S2DOS05) += s2dos05-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/regulator/s2dos05-regulator.c b/drivers/regulator/s2dos05-regulator.c
new file mode 100644
index 000000000000..1325c8311b08
--- /dev/null
+++ b/drivers/regulator/s2dos05-regulator.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// s2dos05.c - Regulator driver for the Samsung s2dos05
+//
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/regulator/s2dos05.h>
+#include <linux/i2c.h>
+
+struct s2dos05_data {
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static const struct regulator_ops s2dos05_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+#define _BUCK(macro)	S2DOS05_BUCK##macro
+#define _buck_ops(num)	s2dos05_ops##num
+
+#define _LDO(macro)	S2DOS05_LDO##macro
+#define _REG(ctrl)	S2DOS05_REG##ctrl
+#define _ldo_ops(num)	s2dos05_ops##num
+#define _MASK(macro)	S2DOS05_ENABLE_MASK##macro
+#define _TIME(macro)	S2DOS05_ENABLE_TIME##macro
+
+#define BUCK_DESC(_name, _id, _ops, m, s, v, e, em, t, a) {	\
+	.name		= _name,				\
+	.id		= _id,					\
+	.ops		= _ops,					\
+	.of_match = of_match_ptr(_name),	\
+	.regulators_node = of_match_ptr("regulators"),	\
+	.type		= REGULATOR_VOLTAGE,			\
+	.owner		= THIS_MODULE,				\
+	.min_uV		= m,					\
+	.uV_step	= s,					\
+	.n_voltages	= S2DOS05_BUCK_N_VOLTAGES,		\
+	.vsel_reg	= v,					\
+	.vsel_mask	= S2DOS05_BUCK_VSEL_MASK,		\
+	.enable_reg	= e,					\
+	.enable_mask	= em,					\
+	.enable_time	= t,					\
+	.active_discharge_off = 0,				\
+	.active_discharge_on = S2DOS05_BUCK_FD_MASK,		\
+	.active_discharge_reg	= a,				\
+	.active_discharge_mask	= S2DOS05_BUCK_FD_MASK		\
+}
+
+#define LDO_DESC(_name, _id, _ops, m, s, v, e, em, t, a) {	\
+	.name		= _name,				\
+	.id		= _id,					\
+	.ops		= _ops,					\
+	.of_match = of_match_ptr(_name),	\
+	.regulators_node = of_match_ptr("regulators"),	\
+	.type		= REGULATOR_VOLTAGE,			\
+	.owner		= THIS_MODULE,				\
+	.min_uV		= m,					\
+	.uV_step	= s,					\
+	.n_voltages	= S2DOS05_LDO_N_VOLTAGES,		\
+	.vsel_reg	= v,					\
+	.vsel_mask	= S2DOS05_LDO_VSEL_MASK,		\
+	.enable_reg	= e,					\
+	.enable_mask	= em,					\
+	.enable_time	= t,					\
+	.active_discharge_off = 0,				\
+	.active_discharge_on = S2DOS05_LDO_FD_MASK,		\
+	.active_discharge_reg	= a,				\
+	.active_discharge_mask	= S2DOS05_LDO_FD_MASK		\
+}
+
+static struct regulator_desc regulators[S2DOS05_REGULATOR_MAX] = {
+		// name, id, ops, min_uv, uV_step, vsel_reg, enable_reg
+		LDO_DESC("ldo1", _LDO(1), &_ldo_ops(), _LDO(_MIN1),
+			_LDO(_STEP1), _REG(_LDO1_CFG),
+			_REG(_EN), _MASK(_L1), _TIME(_LDO), _REG(_LDO1_CFG)),
+		LDO_DESC("ldo2", _LDO(2), &_ldo_ops(), _LDO(_MIN1),
+			_LDO(_STEP1), _REG(_LDO2_CFG),
+			_REG(_EN), _MASK(_L2), _TIME(_LDO), _REG(_LDO2_CFG)),
+		LDO_DESC("ldo3", _LDO(3), &_ldo_ops(), _LDO(_MIN2),
+			_LDO(_STEP1), _REG(_LDO3_CFG),
+			_REG(_EN), _MASK(_L3), _TIME(_LDO), _REG(_LDO3_CFG)),
+		LDO_DESC("ldo4", _LDO(4), &_ldo_ops(), _LDO(_MIN2),
+			_LDO(_STEP1), _REG(_LDO4_CFG),
+			_REG(_EN), _MASK(_L4), _TIME(_LDO), _REG(_LDO4_CFG)),
+		BUCK_DESC("buck1", _BUCK(1), &_buck_ops(), _BUCK(_MIN1),
+			_BUCK(_STEP1), _REG(_BUCK_VOUT),
+			_REG(_EN), _MASK(_B1), _TIME(_BUCK), _REG(_BUCK_CFG)),
+};
+
+static int s2dos05_pmic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sec_pmic_dev *iodev = dev_get_drvdata(pdev->dev.parent);
+	struct of_regulator_match *rdata = NULL;
+	struct s2dos05_data *s2dos05;
+	struct regulator_config config = { };
+	unsigned int rdev_num = ARRAY_SIZE(regulators);
+	int i, ret;
+
+	s2dos05 = devm_kzalloc(dev, sizeof(struct s2dos05_data),
+				GFP_KERNEL);
+	if (!s2dos05)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, s2dos05);
+
+	rdata = devm_kcalloc(dev, rdev_num, sizeof(*rdata), GFP_KERNEL);
+	if (!rdata)
+		return -ENOMEM;
+
+	for (i = 0; i < rdev_num; i++)
+		rdata[i].name = regulators[i].name;
+
+	s2dos05->regmap = iodev->regmap_pmic;
+	s2dos05->dev = dev;
+	if (!dev->of_node)
+		dev->of_node = dev->parent->of_node;
+
+	for (i = 0; i < rdev_num; i++) {
+		struct regulator_dev *regulator;
+
+		config.init_data = rdata[i].init_data;
+		config.of_node = rdata[i].of_node;
+		config.dev = dev;
+		config.driver_data = s2dos05;
+		regulator = devm_regulator_register(&pdev->dev,
+						&regulators[i], &config);
+		if (IS_ERR(regulator)) {
+			ret = PTR_ERR(regulator);
+			dev_err(&pdev->dev, "regulator init failed for %d\n",
+				i);
+		}
+	}
+
+	return ret;
+}
+
+static const struct platform_device_id s2dos05_pmic_id[] = {
+	{ "s2dos05-regulator" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, s2dos05_pmic_id);
+
+static struct platform_driver s2dos05_platform_driver = {
+	.driver = {
+		.name = "s2dos05",
+	},
+	.probe = s2dos05_pmic_probe,
+	.id_table = s2dos05_pmic_id,
+};
+module_platform_driver(s2dos05_platform_driver);
+
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_DESCRIPTION("SAMSUNG s2dos05 Regulator Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/s2dos05.h b/include/linux/regulator/s2dos05.h
new file mode 100644
index 000000000000..2e89fcbce769
--- /dev/null
+++ b/include/linux/regulator/s2dos05.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+// s2dos05.h
+//
+// Copyright (c) 2016 Samsung Electronics Co., Ltd
+//              http://www.samsung.com
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+
+#ifndef __LINUX_S2DOS05_H
+#define __LINUX_S2DOS05_H
+
+// S2DOS05 registers
+// Slave Addr : 0xC0
+enum S2DOS05_reg {
+	S2DOS05_REG_DEV_ID,
+	S2DOS05_REG_TOPSYS_STAT,
+	S2DOS05_REG_STAT,
+	S2DOS05_REG_EN,
+	S2DOS05_REG_LDO1_CFG,
+	S2DOS05_REG_LDO2_CFG,
+	S2DOS05_REG_LDO3_CFG,
+	S2DOS05_REG_LDO4_CFG,
+	S2DOS05_REG_BUCK_CFG,
+	S2DOS05_REG_BUCK_VOUT,
+	S2DOS05_REG_IRQ_MASK = 0x0D,
+	S2DOS05_REG_SSD_TSD = 0x0E,
+	S2DOS05_REG_OCL = 0x10,
+	S2DOS05_REG_IRQ = 0x11
+};
+
+// S2DOS05 regulator ids
+enum S2DOS05_regulators {
+	S2DOS05_LDO1,
+	S2DOS05_LDO2,
+	S2DOS05_LDO3,
+	S2DOS05_LDO4,
+	S2DOS05_BUCK1,
+	S2DOS05_REG_MAX,
+};
+
+#define S2DOS05_IRQ_PWRMT_MASK	BIT(5)
+#define S2DOS05_IRQ_TSD_MASK	BIT(4)
+#define S2DOS05_IRQ_SSD_MASK	BIT(3)
+#define S2DOS05_IRQ_SCP_MASK	BIT(2)
+#define S2DOS05_IRQ_UVLO_MASK	BIT(1)
+#define S2DOS05_IRQ_OCD_MASK	BIT(0)
+
+#define S2DOS05_BUCK_MIN1	506250
+#define S2DOS05_LDO_MIN1	1500000
+#define S2DOS05_LDO_MIN2	2700000
+#define S2DOS05_BUCK_STEP1	6250
+#define S2DOS05_LDO_STEP1	25000
+#define S2DOS05_LDO_VSEL_MASK	0x7F
+#define S2DOS05_LDO_FD_MASK	0x80
+#define S2DOS05_BUCK_VSEL_MASK	0xFF
+#define S2DOS05_BUCK_FD_MASK	0x08
+
+#define S2DOS05_ENABLE_MASK_L1	BIT(0)
+#define S2DOS05_ENABLE_MASK_L2	BIT(1)
+#define S2DOS05_ENABLE_MASK_L3	BIT(2)
+#define S2DOS05_ENABLE_MASK_L4	BIT(3)
+#define S2DOS05_ENABLE_MASK_B1	BIT(4)
+
+#define S2DOS05_RAMP_DELAY	12000
+
+#define S2DOS05_ENABLE_TIME_LDO		50
+#define S2DOS05_ENABLE_TIME_BUCK	350
+
+#define S2DOS05_LDO_N_VOLTAGES	(S2DOS05_LDO_VSEL_MASK + 1)
+#define S2DOS05_BUCK_N_VOLTAGES (S2DOS05_BUCK_VSEL_MASK + 1)
+
+#define S2DOS05_REGULATOR_MAX	(S2DOS05_REG_MAX)
+
+#endif // __LINUX_S2DOS05_H

-- 
2.39.2


