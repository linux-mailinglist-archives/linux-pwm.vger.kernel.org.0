Return-Path: <linux-pwm+bounces-7015-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2BB22074
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3B164780
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE532D839F;
	Tue, 12 Aug 2025 08:15:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC11D52B;
	Tue, 12 Aug 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986505; cv=none; b=hSXBOTQX4pNPMfVmVICq0vjEN7agM+tBLKcQDcvFcWkq6xFHX0Vlpv6HkGt57anJbnRpBDXVYMbh/ZPeUQNSzVrt/JqTZK84egGrZx40RNgLamsmi+yXRdNPgJTa6XeZ1E8HN9txY4jhXkgqCI1j5gjI3aEXWl74fOqqE+52CiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986505; c=relaxed/simple;
	bh=tw/jUzTCWkq7O8ZvtKmEa7WFdIpe71MKe0eyetBPL98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iLTfTZPk8nqe8MwcnyCfgJeXwg9GazSTCLvHISWE3I/DJTa3zM9QP53GQYEZsDXSiPGa/U25SReRog6c++FnZ1mPGJoyRZ2CfTruSwviqmlAl6csf/VrR8KgEoiBAeEFtXOVysYaQ0O4eCFnQ9G1yGYgpPF5Z5E/mnRgy9FKHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11766C4CEF6;
	Tue, 12 Aug 2025 08:15:02 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pwm: Rename GPIO set_rv callback back to its original name
Date: Tue, 12 Aug 2025 10:14:59 +0200
Message-ID: <5366fcd01c9f8b374914e6137f01d156033c8a9e.1754986373.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As of commit d9d87d90cc0b10cd ("treewide: rename GPIO set callbacks back
to their original names"), the .set_rv() callback no longer exists:

    drivers/pwm/core.c: In function ‘__pwmchip_add’:
    drivers/pwm/core.c:2514:26: error: ‘struct gpio_chip’ has no member named ‘set_rv’
     2514 |                         .set_rv = pwm_gpio_set,
	  |                          ^~~~~~
    drivers/pwm/core.c:2514:35: error: initialization of ‘int (*)(struct gpio_chip *, unsigned int)’ from incompatible pointer type ‘int (*)(struct gpio_chip *, unsigned int,  int)’ [-Werror=incompatible-pointer-types]
     2514 |                         .set_rv = pwm_gpio_set,
	  |                                   ^~~~~~~~~~~~
    drivers/pwm/core.c:2514:35: note: (near initialization for ‘(anonymous).direction_input’)

Fixes: 1c84bb7fc0ad5841 ("pwm: Provide a gpio device for waveform drivers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Probably to be folded into the original commit, when pwm/for-next is
rebased to v6.17-rc1.
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b05186b9569eba29..ec4112e6209a4c77 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2511,7 +2511,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 			.request = pwm_gpio_request,
 			.free = pwm_gpio_free,
 			.get_direction = pwm_gpio_get_direction,
-			.set_rv = pwm_gpio_set,
+			.set = pwm_gpio_set,
 			.base = -1,
 			.ngpio = chip->npwm,
 			.can_sleep = true,
-- 
2.43.0


