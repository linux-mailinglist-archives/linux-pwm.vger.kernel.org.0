Return-Path: <linux-pwm+bounces-2452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58F908717
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D51F232E8
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705519149D;
	Fri, 14 Jun 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="MXZx04ZT";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="MXZx04ZT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C968146A7A;
	Fri, 14 Jun 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356132; cv=none; b=HKJLJ+0Ww5HZ5RleMUI8TGjth482wbw6tbDuNgW2iovRsYXdF+ILj1huOUGSDJl2VXrleAHZYWqr9kpSrbFFxPcdVxu7+duRnr0mXmSNZB9XCzwJEMuNSJ5Mt3tXvPLuwS4abbH3WDRFKD+E5l5Ai1X2GI86+nInvGley/EHmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356132; c=relaxed/simple;
	bh=4RP4q9QG25QH+De1LOzDhXZta2ZeRrdDRTLsqg6NviQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIrZXYl/E8+gzfcoGDAidRCEu6b3Jzoj615NmxsSR6Er6wjIeyF9dxEv/EUIJ4dJ0j+VAFndSuNEt1QvHPiAHceML9m7N8Ui/ChkvY4/vVbPONKUB6P63o6a5okw9X2+JxYuKlb44y3Fzqw/z/hpEIUPj7Q1J/13ixZNaflR72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=MXZx04ZT; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=MXZx04ZT; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1718356122; bh=4RP4q9QG25QH+De1LOzDhXZta2ZeRrdDRTLsqg6NviQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MXZx04ZT9AN/P9rPEhdb4IzqE9vw6PolRAzCn9RBYYZQ7rklCBDnkxpE69XPsfsYz
	 f9aXNX/D7Nqts+sHoBiOuNYvSGu36dQQGJ9tSekm22IDc+w+KDTtY/FYLcSAl8gGea
	 +gUVACLvv849XtfBipBT+YT1bQkZ3NsW+Vb7gFT9/Jg/67lXlcZatOkAqiWc2FN+w6
	 CUYcvP/Tg60cqNqm8xozqhb8VPASqD6Og8DSSB1LByifj1idQ/ODHqgzKssbPtIfpq
	 wueVc0ZBPZ6XKnKEsCcJ8c9MpbhrZ6QHez5/u1QBHLipuB3acKyp5Qrs3xKii20Gsx
	 MUlgaacYc1V+g==
Received: by gofer.mess.org (Postfix, from userid 501)
	id CB8BE1007EE; Fri, 14 Jun 2024 10:08:42 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1718356122; bh=4RP4q9QG25QH+De1LOzDhXZta2ZeRrdDRTLsqg6NviQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MXZx04ZT9AN/P9rPEhdb4IzqE9vw6PolRAzCn9RBYYZQ7rklCBDnkxpE69XPsfsYz
	 f9aXNX/D7Nqts+sHoBiOuNYvSGu36dQQGJ9tSekm22IDc+w+KDTtY/FYLcSAl8gGea
	 +gUVACLvv849XtfBipBT+YT1bQkZ3NsW+Vb7gFT9/Jg/67lXlcZatOkAqiWc2FN+w6
	 CUYcvP/Tg60cqNqm8xozqhb8VPASqD6Og8DSSB1LByifj1idQ/ODHqgzKssbPtIfpq
	 wueVc0ZBPZ6XKnKEsCcJ8c9MpbhrZ6QHez5/u1QBHLipuB3acKyp5Qrs3xKii20Gsx
	 MUlgaacYc1V+g==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:bc3c:1b4a:a6fa:362f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id EEEC91000B8;
	Fri, 14 Jun 2024 10:08:41 +0100 (BST)
From: Sean Young <sean@mess.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH] bus: ts-nbus: Use pwm_apply_might_sleep()
Date: Fri, 14 Jun 2024 10:08:29 +0100
Message-ID: <20240614090829.560605-1-sean@mess.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
pwm_apply_state() to pwm_apply_might_sleep()").

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/bus/ts-nbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index baf22a82c47a7..b8af44c5cdbd0 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -294,7 +294,7 @@ static int ts_nbus_probe(struct platform_device *pdev)
 	state.duty_cycle = state.period;
 	state.enabled = true;
 
-	ret = pwm_apply_state(pwm, &state);
+	ret = pwm_apply_might_sleep(pwm, &state);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to configure PWM\n");
 
-- 
2.45.2


