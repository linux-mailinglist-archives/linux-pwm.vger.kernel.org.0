Return-Path: <linux-pwm+bounces-7069-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BFB276C4
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Aug 2025 05:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979BB1C26F5E
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Aug 2025 03:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564929D28A;
	Fri, 15 Aug 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWbOy3cN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A829D26C;
	Fri, 15 Aug 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228448; cv=none; b=b3EGtQaQfntAimNI7ctTmlBk/cIJqeBPZ/t404WXgmiDoJtUDKxtX+1dpYQMfPdHo8aOfKEzDbZZAFRsbySoQYsENb8wtTGVSMXwvZd5lRFrMLOVFd0wLsZWHm/7PCnasxGcJapM2HS9HYhpvdyfYW8xBBHcE/qrcuoRjkKabBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228448; c=relaxed/simple;
	bh=50Y13gswXvqynDSmLEISvpYLyX8qVSTFdfU8wyi+m8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z45vCGBJgoNN5Vl1zsMqY/k9y3VjBLJU3oTI1OBb72jy/qD33XFgH/Nh/ItcucL2/uQyHZTTliMT7iyZbmLFEfgV/ykR5eweV4dlYBr1OoINCkYy4acLVfeTE3acij+oR8ldywUnlvmib/82knvNM9EFLL1j9rFBrc7vfshRShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWbOy3cN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF83CC4CEED;
	Fri, 15 Aug 2025 03:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755228448;
	bh=50Y13gswXvqynDSmLEISvpYLyX8qVSTFdfU8wyi+m8U=;
	h=From:To:Cc:Subject:Date:From;
	b=sWbOy3cNwY+FsyxS1p/A0QgX8uaWkDnkn2zZNul6Zl16InRhK1e0/hV9d4LWjdU46
	 MEBr+KjmSbpM8xdmC0Oe/c2CnXLvIgqMd2+11EJBvPa8Nfxq2rQng3ZqTx4p2uJDcp
	 43aCcXqylukOuG30r4BcYhpcfeLRoL2h62/C2RiU3w11QbXKdiv8AayEji5tU6id3e
	 ZFgA3EHZsXGD/zhcAxDgBMpeM417vlo83UmXxuxgqQ5hS1DhmlCILnVrX5bDLZLSIU
	 V5+lNvoqb2EwV4QQD6LS1CKEIX6gklsUALtjXPwGqCLTAC6Dsdixm3yOa/I54rvlet
	 NE5TlFWv5IDng==
From: Jisheng Zhang <jszhang@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
Date: Fri, 15 Aug 2025 11:10:16 +0800
Message-ID: <20250815031016.31000-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'enable' register should be BERLIN_PWM_EN rather than
BERLIN_PWM_ENABLE.

Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/pwm/pwm-berlin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 831aed228caf..858d36991374 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -234,7 +234,7 @@ static int berlin_pwm_suspend(struct device *dev)
 	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
-		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
+		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);
 		channel->ctrl = berlin_pwm_readl(bpc, i, BERLIN_PWM_CONTROL);
 		channel->duty = berlin_pwm_readl(bpc, i, BERLIN_PWM_DUTY);
 		channel->tcnt = berlin_pwm_readl(bpc, i, BERLIN_PWM_TCNT);
@@ -262,7 +262,7 @@ static int berlin_pwm_resume(struct device *dev)
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
 		berlin_pwm_writel(bpc, i, channel->duty, BERLIN_PWM_DUTY);
 		berlin_pwm_writel(bpc, i, channel->tcnt, BERLIN_PWM_TCNT);
-		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_ENABLE);
+		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_EN);
 	}
 
 	return 0;
-- 
2.50.0


