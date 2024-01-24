Return-Path: <linux-pwm+bounces-903-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE583A3CC
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C0DB2725A
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E017558;
	Wed, 24 Jan 2024 08:12:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DF171D8
	for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083960; cv=none; b=Q99UlxQkR1BbM1sOqcV0LTcghmL5bUEbiJGPSc1l7f2iE6buyVZFLx2XQ1MH+Um/ob2jKHdiRKjcOmR9p4WBfdvyfZlQ3h2mJkS4L7V68RkyHNN0ubSCLsFtMV2alcw19NWU/hR82AWIV6OdpNjdDbigpBJmcJH/ip44GGsHv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083960; c=relaxed/simple;
	bh=eNX43Pap1hSbAUzJATs1yUA12MXNhvR0/0xbdhgMt2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7U5dgrXmMmfHzbdMsTljp46YkQglvS1pbcV2yndCAfCK/2h01w3szj36C3Gf8WrdJmlpqD217LDeAjGxpYGYQrrduoxDAuBO9d18fb1ASv/tNTqt6Z9135nTfddVqQyMS0zYHDzwLmAbTtLZ2xZrYLS1VQCPIIhcTqnPKgBseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYN2-0005Lw-2P; Wed, 24 Jan 2024 09:12:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYN1-0020vM-FC; Wed, 24 Jan 2024 09:12:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYN1-006z9m-1E;
	Wed, 24 Jan 2024 09:12:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH v3 0/2] bus: ts-nbus: Two improvements
Date: Wed, 24 Jan 2024 09:12:03 +0100
Message-ID: <cover.1706083174.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=eNX43Pap1hSbAUzJATs1yUA12MXNhvR0/0xbdhgMt2o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsMZV/CbvpuiI2/S5A4/KVQKAZJ3GfMR0WCHBE xyHs1623smJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbDGVQAKCRCPgPtYfRL+ TjmUCACca4zl5MBotHm5H6kyGgPtmEUo7OQ1ogUUXxhDjk4jH7LpsYHxfRzsjVT1fSFgHp9n0l/ H0cX9Dbi/B0whOy+lvK/sR4JNdxkfaCVs45j0AAHP9m1Lmvkm933V7LuhILKNnA9WiMfvY4JG20 uZaPyN6e1qP8LVT3WUX5DOklW92a75/gW4079Ohc43OG1xe2nIXWLaPtrzX/BfnYzE+tODpBwl/ tZAATeNSq9uEgyVzPD95CoD8Z5PYAnAngh03MvmaF21Zxq5Nko4Ohoz4yyrmHeACiyeXVXW7ppU 2wnABQFYRWxzInKZcHuKVQzwuE28K4esj12wnwUrICNaRTDi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

these patches were sent already before, the submission can be found at
https://lore.kernel.org/linux-kernel/cover.1703527372.git.u.kleine-koenig@pengutronix.de.

No relevant changes since v2, I just rebased to v6.8-rc1.

Arnd asked to resend the patches to soc@kernel.org after v6.8-rc1 for
merging via the soc tree. So here they come.

Best regards
Uwe

Uwe Kleine-König (2):
  bus: ts-nbus: Convert to atomic pwm API
  bus: ts-nbus: Improve error reporting

 drivers/bus/ts-nbus.c | 81 ++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


