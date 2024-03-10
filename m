Return-Path: <linux-pwm+bounces-1734-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7830877628
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252D228177D
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027001EB44;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4A1EA7D
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068474; cv=none; b=sxbvLLYYe6llsP9tNKfoi8j5BdXx/iyOF42YZxUg4bSmdzWMkZRH1kNNo1aZG5A8WmSukm7PtNrcsrT07NsqYKJf5VjWKaNzYa3BpybyT55oMHFq/090d15wNsrUdm+IQ+PzRW/eUSWP1S7ti2s4X+HQNRxhdw88yeRDPo4mPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068474; c=relaxed/simple;
	bh=jpFAC9M6suDOe0JTxwu+Jx6pAD5hCKmE+ebahv5oMZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BPfa0kPqO4P1gbTX0IxfFaqpZ/1wB/jsIRmbURHa+5qqBbbg5ER9KCz4/V0mV/QuWgvXKTYt9swQhkp8ojO43JvxBQ7LakVVDu258JM/gSX6b6kqf9Afu23eudQl6v8VzcGP4w6QmWj5AhPUEPcFXw9VrMa0Re4m03WSJLUkzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-0000pP-E8; Sun, 10 Mar 2024 12:01:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvU-005V0g-Uz; Sun, 10 Mar 2024 12:01:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvU-003OFS-2p;
	Sun, 10 Mar 2024 12:01:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 0/6] pwm: sti: Several improvements
Date: Sun, 10 Mar 2024 12:00:53 +0100
Message-ID: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jpFAC9M6suDOe0JTxwu+Jx6pAD5hCKmE+ebahv5oMZ8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLnG3q3bSZ/gcmcPLtLzh3YrUWhY4YbMKw2d 0u6+rLqruKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S5wAKCRCPgPtYfRL+ TuSaCACaRYpGrI9UhvJLoP8XXiXgKEk1ohxutSVsWhHFCPwWxF67VdIc8P6BKxBIn7Vep+wBfYu Agbahc1+faAE+8blCAb1SgihwjCc1x37gIvCKhamq2VphBPVrwr4dEcw1iHDoCCx8bmuA1Q7XE5 7ONqjuSY8MkwrPuXdds4lMSYKdajGO+t5ZUKkOpyE7Wror47yId5ogkfw/iXvfZeQwe1bWvbtjI SkFo+lkMNullfTcrWqhQZqvGZd80hY+aBjMbBXuK76IM9cypswRx3ReUmeoK8PJyEsx2siOqEDJ LatCey001sxWBO6Y1H8YzJFTRmZBIAQStSr/wyzGdfT8nRoi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

while cleaning up my mailbox I stumbled over an old patch touching the
sti pwm driver that didn't make it into the mainline. While forward
porting it to todays kernel I noticed a few more patch opportunities.
This series is the result.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: sti: Simplify probe function using devm functions
  pwm: sti: Improve error reporting using dev_err_probe()
  pwm: sti: Drop member from driver data that only carries a constant
  pwm: sti: Maintain all per-chip driver data in a single struct
  pwm: sti: Use devm_kcalloc() instead of calculating the size for
    devm_kzalloc()
  pwm: sti: Prefer local variable over pointer dereference

 drivers/pwm/pwm-sti.c | 161 ++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 107 deletions(-)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


