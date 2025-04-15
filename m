Return-Path: <linux-pwm+bounces-5508-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE420A8A1D0
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF57B441CA4
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FFC2BCF4F;
	Tue, 15 Apr 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSqfS8Nm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8CA29B790;
	Tue, 15 Apr 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728561; cv=none; b=PT1qb7dvsabD3AUFur+8dBA0WJocfdtrBpbWz+NOAW3RvlT7OIY/XBD+KM84P2wNjoRrfXIOc86FAAdd3TbL0ymr2GR/qwu0Ig+NMokIBGAwgXclaUneRjILj2Vdrb/oy3z5UwsuwBjixnDbdOLgs98x+j5U1OYxOVCmn720L88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728561; c=relaxed/simple;
	bh=jqGE0xVu8yWKFkliI8yVbSzznb3JK3p4yllxFur7jU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qp+riBP0AUkfSgiSU7rUdJChDvB1O2fopNWthINrsuQaECTY3QEn6IKLeE6OWimv7POTLt3GGpSOE1s4ZBpL8qiPxmLZDeGKPyJwzckSdKBAGUI88EpnZvQPb9uJVZxZal9xRJeZ0wyaDv3ZCh7nAPb1XUaSeDHXV9fTlzSedfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSqfS8Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48349C2BCC9;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728560;
	bh=jqGE0xVu8yWKFkliI8yVbSzznb3JK3p4yllxFur7jU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GSqfS8NmE9pkSUb5BD9VdrvsDOA342KHzo0j8CPPjuA7boatuzTCQS9JelfXiaScb
	 MRcMMpINsvSLHWfFZc5oii55Vgn1Tt6XvkGjr6NyulbL2cSeavq6ktOdbOeIIdnVdd
	 n/QKhYJ4/iSEeZ3D1JBlZpIxCnxqj+FzUIA6b9tR1zyivKoikrMF5zyaXncVKTYApm
	 ePDw6kfhkY3mTlraFtJu+9bslBF4RX/HBwzBRaCU8WbzhKQKEtFAkR0JDDQOiQMdCy
	 SCGzXhGZzgXEfTkEfq+ayo16vxNWR6fCZs27zZXxv13Ak+qtffuzQc3o1fEMEnDhxL
	 BSVrlXbjSDKuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3165DC369B8;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:33 +0100
Subject: [PATCH v2 17/17] pwm: adp5585: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-17-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=672;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=v3TMENAZmJN0myQWjbTc/kqchul9OyTcCJ5PkGOgx9M=;
 b=OjgEv0txZLX702otZ+LNkY9LUqm7zC6znXqY0Nwn0XHuWxDxlpDFu1UAY2W9H33MD6MD7/173
 DISti+oXRK0DheBq5ztqTVeuwfVdpb35Rg93oiYNHGywrjgwLRhkWGg
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
2.49.0



