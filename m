Return-Path: <linux-pwm+bounces-5168-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42502A5F7BD
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA1117EB25
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CEA42077;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StMiNiQs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DEA268FF6;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=EH5Hbk/ugMVuUKUIZqp+FSJ8cCIqXLpLi28d/uZRdOfVmakYKjN7BwNbodvz9N5lUhEd1I85Xlm6nqQZQ895onz73Tvtgt6rPQbUrX54f3rK6iByUjzIIgsuzNyeMLaFaKSdLsXIuyTkGWycDDHI6nWE0AovcyrMUqUYm9YU+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=uYXjR3iB4JAIRXA3YSj8ha9P/j2R0WJud1vpenZ2YtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uw3J4iwU9JYHytVQiYt/RMFWtDWShUBZhmkZjCZ+OhrOlWEqkPFW4BBReBxEdHi8yADxcTukL9q5MoVOJwdlaoCSX95EP1K0mI1fcLQs3fN018aS4yl7k8sprHeAUeGL2kqr3wk39SSqfNC/BK3EfmBTJ6jMcj4tiybjXUOcyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StMiNiQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A223C4DDE0;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=uYXjR3iB4JAIRXA3YSj8ha9P/j2R0WJud1vpenZ2YtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=StMiNiQszfQr+DjELk6VmXOlasloeNWLCy2iHGTTS8l3A7/P9BzVI9uoGNdEclHgJ
	 ESeFguWCAlO/qmWE7Ufdwx/BIvCNzM513R8WeZ5sX+7/93g3J/lxDOTDpbMUKvTsCO
	 DFQ9zOjukIxTLPFXvEUYTezvc4p3yp5YBw4SM8y9zrOAXRA+z3n3Z33iMKVwDAsfct
	 +J1xiIhRq4w+2oekt+TZRN0V6j5F23/f2u/3AULwDGwy1qZMY/J37EQWIkkJxPfKKS
	 jIzhce1I0j2562S56cIc/WIUEQw1MqUdcGEMoWBKk3ulCoI6z/BlNCMyyf5kEnpX87
	 COzPpzTY9xDCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E82CC282EC;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:34 +0000
Subject: [PATCH 17/18] pwm: adp5585: make sure to include mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-17-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875562; l=672;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tqFurroQfEZIIAKBp0UvBVXq9bErS1HNimmEhHkQKV0=;
 b=hfpdLUVm6u/hFamM0DfVIZ4hdcQUAfz3yq26VEMBtbydRqYE8myLuJ5SvqlaRxXxKjvU0KHV+
 bbhXliKvK+0Cwhh4nE1fXqvUwLEn0i2NxZQQLFNdEciZnWpxRD6QBE2
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Explicitly include mod_devicetable.h for struct platform_device_id.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/pwm/pwm-adp5585.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index cc8ac8f9e5669b4ffca06d4117a29f030393f48f..85308257724a338da4d2416c8d01e48e08bd0856 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/adp5585.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>

-- 
2.48.1



