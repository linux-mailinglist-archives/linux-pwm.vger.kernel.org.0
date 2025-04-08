Return-Path: <linux-pwm+bounces-5379-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8677A808CC
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E294C6C5F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378C26FA7D;
	Tue,  8 Apr 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Lz6zO/EA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797482686BC;
	Tue,  8 Apr 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115668; cv=pass; b=ZOjStA2bQh+5WAcLHrVWylpSrCL8tViRln+oLNScIFIy6nBNFHEJ7VIbNx6AM9NL1EYNI9E0BfejKFd8snZaxGeQ4zPp+G8QYt1Uu4xArng0vKS3cDjP4BV82k4q8XGLLfVGyLIC5Hn66ffhiNRq/VsSDBOwUc2Shxl0OiTBre8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115668; c=relaxed/simple;
	bh=g0d+A1Xa35+JJc9k3JtT4L9ruPX56d4fgs3DOwhMl5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdPxRxpGExhMvLz4ZAdnfvPhZh+J6z3AEybqAnFWu0BIcn9BJ9PKidKHrby0dBuhhhRuHlvX7BIlH9EM38RNczmdexS0KgO1D276R14bsrl0XffAhcqzcw7fTrxgWz8/FwMYBXm/DI1EE00E0wrBYOf6G/8sZJhp7sQmaHCbVs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Lz6zO/EA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744115633; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G2Q7s94IYvGc/rZjsgLuhe+cCDOLf3PJ3slZvXVTxsECxHzgMXg7YfdWa1ZBdopcTI9iT15ilhS4RpcY44g0OnekOYzAO+c2CKF2oYXe8YpW1AHwQYzay8qXwxQAl30oCBdnoApral/kbkTQirVbfioa3boIZcmVhekJ8OjeAMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744115633; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p29ZC+N5MNCvmmVB2BSVpm50cbVEH7Xlr6X0I1T2aVA=; 
	b=bvHlLW6AR76qyzVCZTPODBXED7R2+ffSCm59PkqrCucaX6x6kSXzaJoNsVrmEDZJ8NpG+8s4zmC2yf1g87sxvHhuHFeO8joXaWltWklUVKkl5UzZX0678uG/0Kry+YEUq5MQerez63oeiz+w01RhVrJSW05WtFzxpm62IEifyZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744115633;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=p29ZC+N5MNCvmmVB2BSVpm50cbVEH7Xlr6X0I1T2aVA=;
	b=Lz6zO/EAdAo1nNZMgKhQ+ZpMEcj/BiT6yNkAJC1sg3HQfBwxgUaGHe0f6DfUvs5G
	yD6FKvNEzdHuBJIsDEM/B+kHbdsrkFQF9LnHpYvwEA9ZojIRhjagQBlUg5XgPyX8lLf
	e9MFBEK8trDljsfnXT/uPo0dxqump073mA+yv1Lo=
Received: by mx.zohomail.com with SMTPS id 1744115632188591.1286847234378;
	Tue, 8 Apr 2025 05:33:52 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 08 Apr 2025 14:32:15 +0200
Subject: [PATCH 3/7] soc: rockchip: add utils header for things shared
 across drivers
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-rk3576-pwm-v1-3-a49286c2ca8e@collabora.com>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
In-Reply-To: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Rockchip hardware has some functionality that is shared across many
hardware IPs, and therefore many drivers for them.

Most notably is "HIWORD_UPDATE", a macro with slightly different
semantics replicated across many a rockchip driver. It currently can be
found defined in 19 files, of which 18 are Rockchip drivers.

Instead of continuing this tradition with yet another version of it in
my new drivers, add a rockchip soc header for utility macros and such.
In this header, we define a new set of macros: REG_UPDATE_WE and its
little brother REG_UPDATE_BIT_WE. These are purposefully named something
other than "HIWORD_UPDATE", to reduce the likelihood of macro
redefinitions and also reduce the potential to mislead any adopter into
thinking this HIWORD_UPDATE is just like their HIWORD_UPDATE.

Old drivers can be moved over to the new macros over the next while if
their maintainers think it makes sense for them, which it probably does.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/soc/rockchip/utils.h | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/soc/rockchip/utils.h b/include/soc/rockchip/utils.h
new file mode 100644
index 0000000000000000000000000000000000000000..3349069e75ff51ebd7a22089af796feafd227ffb
--- /dev/null
+++ b/include/soc/rockchip/utils.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *
+ * Utility types, inline functions, and macros that are used across several
+ * Rockchip-specific drivers.
+ *
+ * Authors:
+ *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+ */
+
+#ifndef __SOC_ROCKCHIP_UTILS_H__
+#define __SOC_ROCKCHIP_UTILS_H__
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/limits.h>
+
+/*
+ * Incoming macro basilisks, stare directly at them at your own peril.
+ * As a gentle reminder to help with code comprehension: BUILD_BUG_ON_ZERO
+ * is confusingly named; it's a version of BUILD_BUG_ON that evaluates to zero
+ * if it does not trigger, i.e. the assertion within the macro still checks
+ * for a truthy value, not zero.
+ */
+
+/**
+ * REG_UPDATE_WE - generate a register write value with a write-enable mask
+ * @_val: unshifted value we wish to update between @_low and @_high
+ * @_low: index of the low bit of the bit range we want to update
+ * @_high: index of the high bit of the bit range we want to update
+ *
+ * This macro statically generates a value consisting of @_val shifted to the
+ * left by @_low, and a write-enable mask in the upper 16 bits of the value
+ * that sets bit ``i << 16`` to ``1`` if bit ``i`` is within the @_low to @_high
+ * range. Only up to bit (@_high - @_low) of @_val is used for safety, i.e.
+ * trying to write a value that doesn't fit in the specified range will simply
+ * truncate it.
+ *
+ * This is useful for some hardware, like some of Rockchip's registers, where
+ * a 32-bit width register is divided into a value low half, and a write enable
+ * high half. Bits in the low half are only update if the corresponding bit in
+ * the high half is ``1``, allowing for lock-free atomic updates of a register.
+ *
+ * This macro replaces the venerable ``HIWORD_UPDATE``, which is copied and
+ * pasted in slightly different forms across many different Rockchip drivers.
+ * Before switching drivers to use it, familiarise yourself with the semantics
+ * of your specific ``HIWORD_UPDATE`` compared to this function-like macro's
+ * semantics.
+ *
+ * Return: the value, shifted into place, with the required write-enable bits
+ */
+#define REG_UPDATE_WE(_val, _low, _high) ( \
+	BUILD_BUG_ON_ZERO(const_true((_low) > (_high))) + \
+	BUILD_BUG_ON_ZERO(const_true((_high) > 15)) + \
+	BUILD_BUG_ON_ZERO(const_true((_low) < 0)) + \
+	BUILD_BUG_ON_ZERO(const_true((u64) (_val) > U16_MAX)) + \
+	((_val & GENMASK((_high) - (_low), 0)) << (_low) | \
+	(GENMASK((_high), (_low)) << 16)))
+
+/**
+ * REG_UPDATE_BIT_WE - update a bit with a write-enable mask
+ * @__val: new value of the bit, either ``0`` 0r ``1``
+ * @__bit: bit index to modify, 0 <= @__bit < 16.
+ *
+ * This is like REG_UPDATE_WE() but only modifies a single bit, thereby making
+ * invocation easier by avoiding having to pass a repeated value.
+ *
+ * Return: a value with bit @__bit set to @__val and @__bit << 16 set to ``1``
+ */
+#define REG_UPDATE_BIT_WE(__val, __bit) ( \
+	BUILD_BUG_ON_ZERO(const_true((__val) > 1)) + \
+	BUILD_BUG_ON_ZERO(const_true((__val) < 0)) + \
+	REG_UPDATE_WE((__val), (__bit), (__bit)))
+
+#endif /* __SOC_ROCKCHIP_UTILS_H__ */

-- 
2.49.0


