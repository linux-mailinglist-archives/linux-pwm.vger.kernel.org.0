Return-Path: <linux-pwm+bounces-7912-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57870D25DA4
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEE823026F35
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0225228D;
	Thu, 15 Jan 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ8fTsSX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304842049;
	Thu, 15 Jan 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495866; cv=none; b=e4wERA70EVamupSgV94wzFp2MUjTiY0PDKqBq12IspXyp83jMTMLThPiiw93TSG3j+k9rz25MGu6phRhbyjO7ufEudFiCeCpS+q5DsXLEM5GVuM6EA18JoFC2lAo6jxX6Sd5awYWmHSVf3Vk5WoFZ0GQrJuCmxwhtHsZUEiA0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495866; c=relaxed/simple;
	bh=B1wUz/mpBe/fg4rNrP8IB1N8p3wpTvtskTTQXOf2//8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SoDZU7BCS3SkC5C2PHu7jZmpide2FdZr8rj2Xn9LXcc8fvb5wg5BzbSTIrin2UiKrthmzsMcrgkICs76KupCHvtwW6pbo0QORMU2w1Sat1xNUH6OGY1UleiP7xliilTfnCPGn5JtROIETMNsp5SFwGXb2qpOfaG1QiYQCF7HtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ8fTsSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A90C116D0;
	Thu, 15 Jan 2026 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768495865;
	bh=B1wUz/mpBe/fg4rNrP8IB1N8p3wpTvtskTTQXOf2//8=;
	h=From:To:Cc:Subject:Date:From;
	b=XZ8fTsSXvGrF92ldzigs8Ve5cL39TSNveTwpqOBSZHN4hFWtJdaRg2+3TnkL16EGd
	 t9CXMotN26Ydg04EehPM1clq1zH545LhDngNA+pKlRWU+CdY/RDdufo5A/zmFFZ3nl
	 GNlkMWbExOeviRLfzSGZaY+AlFj+VD1X4BVD9Jy+qXjYIhmFvUOtXUleJ/Ngcuc8Ae
	 tsfx9nQmWrX2X6VcqsH4gffB1TbD1hrIO1vZCHHk6cYvoU1F88k/9gFZemjT3FYBda
	 YwYj5GoeixbklXHTd70DNbZw9s4mAruB8MP+k7nusIwGoGiCut70t+TJcN3DTKqq6B
	 fWzJzoX3wvZ3g==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] pwm: Update MAINTAINER entry
Date: Thu, 15 Jan 2026 17:50:54 +0100
Message-ID: <20260115165055.1739004-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=ukleinek@kernel.org; h=from:subject; bh=B1wUz/mpBe/fg4rNrP8IB1N8p3wpTvtskTTQXOf2//8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhsxMqffFyz6ULRA9PNPKb15W4ZeuiamRzolPjPOtTXeWR DquOObUyWjEwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEDHawfzOLT7ZICXygyGJq w/7QpGy+w6F5idov7uhvlhO+VPyfbduBh84rFv/9omXedZFpV0Lxb+6GsF2nMpVPbm1luXl94f7 +ZzKNx294lIqo/bF+a/hbmefjYp+VUaLN67e2hHyVK2LdLlpzteL88Y0l09cd4qz7YJNatVgh2f 7kG+lmZ1HeUJ9lFxXN9dpmufOWZTzQ2n/571lRr6sP7xcJHHP6uih0iuv1Gss9s5VT7qx7Jl3Pq ajIz/Iu3NjV3rDW9mAse4DF1bwJ/Y3F23qzFVKfrW/nZlJqOmQ75/SOIj9VHY+ac75LXAolrewc a1bcN5tn+C40IkMmPU23//nnBz+0bbjYPz1RE/0b/QsA
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is little sense in having gpio-mvebu and pwm-backlight explicitly
listed in the PWM entry. Drop these and add the keywords that actually
identify a driver as PWM related.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..1ab3b6a2c29b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21070,16 +21070,14 @@ L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
-F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
 F:	Documentation/devicetree/bindings/pwm/
 F:	Documentation/driver-api/pwm.rst
-F:	drivers/gpio/gpio-mvebu.c
 F:	drivers/pwm/
-F:	drivers/video/backlight/pwm_bl.c
 F:	include/dt-bindings/pwm/
 F:	include/linux/pwm.h
-F:	include/linux/pwm_backlight.h
 K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
+K:	(devm_)?pwmchip_(add|alloc|remove)
+K:	pwm_(round|get|set)_waveform
 
 PWM SUBSYSTEM BINDINGS [RUST]
 M:	Michal Wilczynski <m.wilczynski@samsung.com>

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3


