Return-Path: <linux-pwm+bounces-2471-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B396908F43
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB251F29BFA
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1016D4D5;
	Fri, 14 Jun 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMP75Ftt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B916C878;
	Fri, 14 Jun 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379974; cv=none; b=LVRveq+Pm4ahFZ2ed2Rr/6gJow6XIPpdWSf1L5kZ+C6ZEKI8QRoU0p5HMbHN0XAdrBsaoO7fo4L1KWlP2bPor2/tjVinqTQOPpBLyKGudLaZVYlCFDohYtP0xSRINCWKbygqfd9wzGMuTJSo1o4IGsoLt3k4J64VXqlUV9WPe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379974; c=relaxed/simple;
	bh=Z6g1BYX8L60xI0ndaIE5U6XB1JZQMw7PdN+V+G9CosE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLIRPF1v8XFwGznYtNzUthvi2Fa922JgVpbYbq/vsPhorkDW+S6Gf1wZB7d+vfoZTZFB3q2P5j2+xqjBFlNjH6pDfUjKgnYL40FL/I1HbwRwM7taXrzPDgq1hfCS4NTGglT2/lubtWIMmOprkVDCdVfpiIuweD+VIJmVeEHCcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMP75Ftt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A2EC4AF1A;
	Fri, 14 Jun 2024 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379974;
	bh=Z6g1BYX8L60xI0ndaIE5U6XB1JZQMw7PdN+V+G9CosE=;
	h=From:To:Cc:Subject:Date:From;
	b=KMP75FtteaGZ46C996OXqSGmqE8rWWkj1b09SMD1m7ZkuO+h+D9jFg3FzgpqRMBey
	 HkpEFBQC4TEBD32vbqGt4lh5UB2RQat0ogmEy+he9JH5tEnOyKub8ZBxNoxRXksbtx
	 J3we+RxnWNyrzDYh1PmqUZOijLVeGmmvYxwn+ZVIoI5Gdj/dDESavn4EZ7vMgfCn1Z
	 +NDhG7qOp/3PRGxVS8NEvgmned3x+Ov0As130rdvKUoAXXva/MoiHZlqYwwTY1rl70
	 mrwEvxQXe+2elBeW2NL/yMjVfW64yXBndY8ex+UpKRTXP3A9qK/hBPknsKf0x3oGu7
	 6f+tz1lGsi/zw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sean Young <sean@mess.org>
Subject: [PATCH] pwm: Drop pwm_apply_state()
Date: Fri, 14 Jun 2024 17:46:02 +0200
Message-ID: <20240614154603.689727-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=ukleinek@kernel.org; h=from:subject; bh=Z6g1BYX8L60xI0ndaIE5U6XB1JZQMw7PdN+V+G9CosE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmbGW7KFhB2Q7K6dl9fzXu5zx+pBZf8bDUzkSMX OwwDuUdYVCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmxluwAKCRCPgPtYfRL+ ThJZB/wPEdpuBE33pkjryetp2yEAreWO2n1W+2RNBdfHjUy91IOZlfClP+FWvYkQCGsby3xdh68 bGItAR4Vgo0Gj4PURZUQHOKN8mqze78WlEaVx3ygvw3YzMkMBVbnkGnYB4pa9MY5YEE7sxQrZJ1 PlLOjyiOoA6sPQsBah6vDaNvGBA+sY8nS8/kZeCejgweh3HNgcQCpWIVMH6T6ZRrKRQhx4n97Uc VbyrI882j9OEGCMnPdjN3tTVedkulQGDRF47b806S3ueK6KjYFYyV90MP0QFX4e01K/DqLOQdtC gsage3RfW/NGkOuOfy9174TanWsmWixWP4rEcYL53TGLMrWK
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This function is not supposed to be used any more since commit
c748a6d77c06 ("pwm: Rename pwm_apply_state() to
pwm_apply_might_sleep()") that is included in v6.8-rc1. Two kernel
releases should be enough for everyone to adapt, so drop the old
function that was introduced as a compatibility stub for the transition.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
Hello,

with Sean patch fixing ts-nbus[1], the last user of pwm_apply_state() is
gone, so pwm_apply_state() can be dropped now.

Thanks for reminding me of this task.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20240614090829.560605-1-sean@mess.org
 include/linux/pwm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 75ad0d2fd949..f8c2dc12dbd3 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -563,13 +563,6 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	pwm_apply_might_sleep(pwm, &state);
 }
 
-/* only for backwards-compatibility, new code should not use this */
-static inline int pwm_apply_state(struct pwm_device *pwm,
-				  const struct pwm_state *state)
-{
-	return pwm_apply_might_sleep(pwm, state);
-}
-
 struct pwm_lookup {
 	struct list_head list;
 	const char *provider;

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
prerequisite-patch-id: 51738c9613a88df12ce0963aa6bdb92fa15262e1
-- 
2.43.0


