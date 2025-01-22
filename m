Return-Path: <linux-pwm+bounces-4706-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B4A1944F
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445533AE5B5
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CC214232;
	Wed, 22 Jan 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMWmIjqA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED8214205;
	Wed, 22 Jan 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556988; cv=none; b=BJycw+hoDndUr201NBIW18n/9kCzDEwBUXTdwvpYN/vnt9Zqo+BD9PRfumdJijwqGs02c8om0l5FzOT8f8a1ZppsSFglPXj6YYtfyzifhykOHjm0o3RqBVbLJMrRETSdILtqSXgIUdfPvskz6mAf5d3Ug9cueJOPScf3ol1GNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556988; c=relaxed/simple;
	bh=TVGwxVO0xo3+rnxUovKfF7pi5C/YVzpJ6q00Yo/Sl/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=deP/PL65eFy9zWrO8h1GAFn40crgUMI71Emk1DTSHAci83/bRqgm56orXBbQw4pfumPuWdkGIZEbzuhCQtwD/KAeUtBQZDnlZoFEmXarGfLsVtE9ayCND98gg9i5t98LI2pcAtg9ValBRfehQFT1nIIDmG/NAL/O/2xEFOrHHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMWmIjqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA16C4CED2;
	Wed, 22 Jan 2025 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737556988;
	bh=TVGwxVO0xo3+rnxUovKfF7pi5C/YVzpJ6q00Yo/Sl/s=;
	h=From:To:Cc:Subject:Date:From;
	b=tMWmIjqAM50kqyx9x8ezias9Q8mc9I5ZW62KDHIAAYYM+z71GPHnKqg8ZCwDW5wjm
	 tooDO2w0wFkNE8U+HQkrStNVxlJ6ibFKkKTmtISEOQg3scY/GdaHyuvOEJVRE5bduL
	 PU2DuSRwrIZJf+4G2GolB6nv6v+jhklLPTgMrEpbDOJXChgk0njJagZ5MyvURxh+yl
	 aOOT7Z2DGf2AXLONvVyHyfL2BUg3TmaDPThOQyjlnpQhhiG8b6SF6llNrkZFuwlR1s
	 Y6ajzssoW6C/9C7lCtyoY7YbBReZqzVmGkPWbCXSELcNPkVJf2blPkWzHGD8BDbxro
	 TTjdqf0yR7zWA==
From: Conor Dooley <conor@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] pwm: microchip-core: fix incorrect comparison with max period
Date: Wed, 22 Jan 2025 14:42:56 +0000
Message-ID: <20250122-pastor-fancied-0b993da2d2d2@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IP8gdxD3c/+7SedNCJbFyJgVZrvNpro1QIADMns2ttI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkTmd+nyzruLhHZa30qnifycQfv8dTE19Oq+iccKY+cn 7dVcMLmjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExES4Thn6pso/z0OYfEOvPO pO9eu1bU8ZCB+quqG3JMEzecaXq46ynDXxnWhObFK1U/K4eq9FnonWy745kpkHTu1xMmG77/G27 a8wIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

In mchp_core_pwm_apply_locked(), if hw_period_steps is equal to its max,
an error is reported and .apply fails. The max value is actually a
permitted value however, and so this check can fail where multiple
channels are enabled.

For example, the first channel to be configured requests a period that
sets hw_period_steps to the maximum value, and when a second channel
is enabled the driver reads hw_period_steps back from the hardware and
finds it to be the maximum possible value, triggering the warning on a
permitted value. The value to be avoided is 255 (PERIOD_STEPS_MAX + 1),
as that will produce undesired behaviour, so test for greater than,
rather than equal to.

Fixes: 2bf7ecf7b4ff ("pwm: add microchip soft ip corePWM driver")
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Uwe Kleine-König <ukleinek@kernel.org>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: linux-riscv@lists.infradead.org
CC: linux-pwm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/pwm/pwm-microchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index c1f2287b8e97..12821b4bbf97 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -327,7 +327,7 @@ static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *
 		 * mchp_core_pwm_calc_period().
 		 * The period is locked and we cannot change this, so we abort.
 		 */
-		if (hw_period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX)
+		if (hw_period_steps > MCHPCOREPWM_PERIOD_STEPS_MAX)
 			return -EINVAL;
 
 		prescale = hw_prescale;
-- 
2.45.2


