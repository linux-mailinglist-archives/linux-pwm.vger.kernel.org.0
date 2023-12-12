Return-Path: <linux-pwm+bounces-524-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D180E637
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 09:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C201F1F21B4B
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07EF20DC6;
	Tue, 12 Dec 2023 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="kyqBLI/O";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="V7HBSbPR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8DF4;
	Tue, 12 Dec 2023 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370077; bh=zLSyEthe/4DdR0aMOzSw83eC3jPiBmnxF3nl//8MZOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyqBLI/OkkMdG6cucpZJFmVXKgh5VPYfOk21KK0u9B6fUAKfQXegJsAUdTmf4gqlj
	 yOQhi7iFqqaYdbrJtYDXgxTjaD8C8mLR9s77oorZPMGa+P5qE81veVyuxIyedTyKDB
	 wuEFj3q/M0XjC+fHizVAIUYIE749XV7ce5SxOdPbINMj64QoC+JDtBLSBnVLuK4l0I
	 ZXz55vYWH1CYLDGyK2CbGuSyDX5NRWPiiGMP8HWb0DVJ7hNxQn+Hs55py7jFZoMzow
	 2r3qWklXrDK05o1RfMlBCTww2P0ObxTz1X3Rd2TvUKpSqupCsk4wy9/aaCds2hJr6o
	 hyJ6hlfIV4u7w==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 14317100A0A; Tue, 12 Dec 2023 08:34:37 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370062; bh=zLSyEthe/4DdR0aMOzSw83eC3jPiBmnxF3nl//8MZOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7HBSbPRNlgNEn/WY/PFOS1JEExoS8AETzZ7hNtdRp7LLT/w9/xlkdK4y7NLWJQ2k
	 Zsv36ias08FSMct0CpsubAIfFg/n3XzW3vczfBAgiBjoMGp2KzL0uJXYo3tSQtHYaE
	 +jbzf4Gd9LhXr9jgidPeciI90Q+q206fS5DgmZu9S2F7Lp1NvrDIWfXJj6yPmdF/Ji
	 v61xT4EfXvLrRKYHJiT7BFxwyuOHlHrmp7uZRYznA28V7sv3AE64VO5JjogzBf7mVq
	 riHgJKENAUunnS9GUvnM/avtFghNxAsVRNiOyMyKCjgtGyZafJobM7miIIo82BXB+S
	 /ATUaiKvk8E6w==
Received: from localhost.localdomain (bigcore-58.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 332A610006D;
	Tue, 12 Dec 2023 08:34:22 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/6] pwm: renesas: Remove unused include
Date: Tue, 12 Dec 2023 08:34:02 +0000
Message-ID: <4c135f9cd23592b1646a4151e86ef4ea0321d4ef.1702369869.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702369869.git.sean@mess.org>
References: <cover.1702369869.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No mutex is used in this driver.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-renesas-tpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index ce92db1f85113..28265fdfc92a9 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0


