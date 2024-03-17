Return-Path: <linux-pwm+bounces-1789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915087E089
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EB5B216E0
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D46208C3;
	Sun, 17 Mar 2024 21:52:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE8208B0
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712360; cv=none; b=qDPvAlWrnK8LajWOQWI6BsJ3HlHtE1pwzBmF62AXDlSOOPzE2k3+krcKacngFOODO12vWfpQ3iAYnNC5+iEkNjtIrm0BFY76nVhmdhjP2LlyY7zGrB+g/3M9hj6XCNKJh/KLNbZAzWUvtpscZYbwvHZMDwV8wk/0kSybpD8pCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712360; c=relaxed/simple;
	bh=PBFTj54rIAkX9wEsGaAGKdtJlRaJeRIbI8HQTYWi8t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mu2vRa57FkJE2wSaZlJlo1krpq6UQJyDDj68o6N70mR4l1DHRmaQP7vYz6AC1rDqnalN315SgJ+6DNq0LWbojlzy2+1a3VlJ6Fhnhv35WAhO5QuGe1SwGHKWrETy9Z2LY8qLH0OCdYUtARV5rxvnD0O0yaueS6+SAhRZ3rnIFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQk-0002km-4u; Sun, 17 Mar 2024 22:52:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQi-006xGn-S7; Sun, 17 Mar 2024 22:52:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQi-007fnv-2W;
	Sun, 17 Mar 2024 22:52:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 0/3] pwm: stm32: Some improvements
Date: Sun, 17 Mar 2024 22:52:13 +0100
Message-ID: <cover.1710711976.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=PBFTj54rIAkX9wEsGaAGKdtJlRaJeRIbI8HQTYWi8t4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl92YOlpfRRDDkAHEMVgHkRqSly0zgbSvEy52Ra Gj8Ae9rXX2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfdmDgAKCRCPgPtYfRL+ TlKOCACpt5vgcFrmRNkITC5B2J2dMxu54054EpwrMv4U3GAtnNrRXHyk95m/+hxj9It7aE9FNym nqChmJe5Y8S5wHKccH3fMuKmaa0LjcTzQ6UhlSHqWQVz6fZ4rk1GPca4q4HX529PdKmDh0mL7De /b2Ddk5x5+jhx9OALGvbZQNSnhyW7sTLEScuDWN1UTcq+++zM8+k6N1FvleCcxtZTHnn+zpS/TM FNGAuEHEk+4Gr2wuqH4wVGe3YmZRyOvLOmVPA/sHCYPHSuUJKWg7POVeRAifWegwfbzv2sfjUnX S41A6SfJhqSGVl+AiUpA6cO4CYbUVYcoV10eBHstSjqGUWm3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

while working on the character device support on an stm32mp157 I
identified a few bugs / shortcomings in the stm32 pwm driver. These are
fixed here.

I based this series on top of pwm/for-next
+ https://lore.kernel.org/linux-pwm/20240315145443.982807-2-u.kleine-koenig@pengutronix.de
+ a cherry-pick of commit b0cde62e4c54 ("clk: Add a devm variant of clk_rate_exclusive_get()")

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: stm32: Improve precision of calculation in .apply()
  pwm: stm32: Fix for settings using period > UINT32_MAX
  pwm: stm32: Calculate prescaler with a division instead of a loop

 drivers/pwm/pwm-stm32.c | 51 +++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

base-commit: dd6c6d57ab61d496f6ff7d6ca38611062af142a1
prerequisite-patch-id: 91e339ba6f6870e208f5d7beef4cfd59e81e7c95
prerequisite-patch-id: 733e7061c2d9b5ba2202fed4ecee4b070d423368
-- 
2.43.0


