Return-Path: <linux-pwm+bounces-7098-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA47B2C290
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B53A01A33
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E032C304;
	Tue, 19 Aug 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2XdRGUK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD3212B2B;
	Tue, 19 Aug 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604778; cv=none; b=g0XpWA7JMQMdANle+O1ZyqYG1RCi5Usof3I6bXmuJX1KAQOBRdXZt1XEfoFCQEvNY7lniaJmx4mQt+huxJYI/UTXlEmCYjOc5RhdraW+AB+Bwx9ZDWnCHI5ZYfWWPK38a9T4comkwZmbE/ySJvfQD+f+zCFYXGzPKBEPuV9H4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604778; c=relaxed/simple;
	bh=0v9lG0844Hqm5JldEE8GkjmMjZaUc7QoWpGSORsbXCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciJO3PovEsEde4zn/h6uhRT63SLBkqtYiJ0FSkkb54dT/+8HNbZ7PeuKB+tHq4yb8BXyxhphX19EOu5UltMKCsQo1OF+991CFR/uO8YHWz/XyQ2aVEtlAFKITji6MH3eyCuNhpnB+hdonNxWXGq6vSLGgNuWntkcv8hikt/gn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2XdRGUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C8C4CEF1;
	Tue, 19 Aug 2025 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755604776;
	bh=0v9lG0844Hqm5JldEE8GkjmMjZaUc7QoWpGSORsbXCI=;
	h=From:To:Cc:Subject:Date:From;
	b=e2XdRGUK/NKN3Qt47/MnnaYiLHtu089s13F9av5LZMJbPZ0JGeuquoodZEIEfL2Se
	 KPgrfcvozNdjDkOwgbYdRoskmkMBY9g0PRkki1SLdf2Q6V/w1PfOhrANdzp1aIP3kA
	 RmyRxvkN1fFs6UMxcuPEIfnTE1cLZnuyjTHpWHPzPvQ5Xd7a52765auzi6lFM31SYn
	 HP6eN86QA1eN5FpixXJS5s8KLFqx/k0NG0aYH1vJVmk2vDBvN1kZW8uo0y5aaxYhjB
	 d6NTb7DUg4KIdCO0AIzFgmVZ1MKgdwMsoQMQob61iSukMjqZ8XFMynrNS7Wl8HSiJ1
	 3kaw3TAbMvksA==
From: Jisheng Zhang <jszhang@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: berlin: Fix wrong register in suspend/resume
Date: Tue, 19 Aug 2025 19:42:24 +0800
Message-ID: <20250819114224.31825-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'enable' register should be BERLIN_PWM_EN rather than
BERLIN_PWM_ENABLE, otherwise, the driver accesses wrong address, there
will be cpu exception then kernel panic during suspend/resume.

Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
since v1:
 - update commit log to mention cpu exception then kernel panic w/o
   the patch

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


