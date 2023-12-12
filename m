Return-Path: <linux-pwm+bounces-541-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35A80F543
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3515B1F216F5
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF37E782;
	Tue, 12 Dec 2023 18:10:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02ECE
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 10:09:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CY-00018b-62; Tue, 12 Dec 2023 19:09:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CX-00FOY0-9i; Tue, 12 Dec 2023 19:09:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CX-001opH-09; Tue, 12 Dec 2023 19:09:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Anderson <sean.anderson@seco.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 0/2] clk: Add a devm variant of clk_rate_exclusive_get()
Date: Tue, 12 Dec 2023 19:09:41 +0100
Message-ID: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fSIBxfQRnF716sj+kWc1Bpd5EavDQYK0nov+457/BrI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSKhU/VOm3b5BQyFv742uLkt01ZehPLg+K/SZytOfmBU WYpGx07GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZgIixcHw7y4SSrMbtcmp2l9 bD7e3H1buvzHgdDvSimylu7dN15cu5ksOrPsbNpma6lMzoqnnoLTecX80vo50mwYfr/hM1W+ojd d6dmP2WxiKU92fNjbXjj97ROL/XN7q2+2ajis3dmZccDz+J6tLC+VzghO77lZpBIsI6ax2I3LUe BB0pa/W923eSR6n3MzsH202WKpc9XHwLbLXEz3Lf4wtuwtcOJ+xdSkuWtXsaL4MkOuFnG2HPYA4 +7TVQFXW2e2mh9IMJsebDWbX3fdvAhJrtWRWd5fPglMfe9jdNZCQqvY8+/tK5KMbketHXd4Vfxq DYr6u4kvKu3L682r+CN1A/YecJlSs1s5Vdv4/eGPXmUA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

patch #1 adds a new function devm_clk_rate_exclusive_get() that
simplifies usage of clk_rate_exclusive_get() in probe functions.

One downside is that a caller of clk_rate_exclusive_get() doesn't need
to check the return value, devm_clk_rate_exclusive_get() can fail
however. So to benefit from the new function you usually need to add a
check for devm_clk_rate_exclusive_get() failing in return to simplifying
error paths in .probe() and .remove().

Patch #2 shows an example conversion. Note that without
devm_clk_rate_exclusive_get() the pwm-xilinx driver cannot benefit from
devm_pwmchip_add().

This series bases on
https://lore.kernel.org/linux-clk/cover.1702400947.git.u.kleine-koenig@pengutronix.de/T/#t
. That's not a "hard" dependency, it can easily be rebased to next.
There is only a trivial context conflict in include/linux/clk.h.

Regarding how to merge this: I suggest to take patch #1 via clk. When
this is merged I will take care for the pwm-xilinx driver (and others
that might benefit).

Best regards
Uwe

Uwe Kleine-König (2):
  clk: Add a devm variant of clk_rate_exclusive_get()
  pwm: xilinx: Simplify using devm functions

 drivers/clk/clk.c        | 15 +++++++++++++++
 drivers/pwm/pwm-xilinx.c | 25 ++++++-------------------
 include/linux/clk.h      | 12 ++++++++++++
 3 files changed, 33 insertions(+), 19 deletions(-)


base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
prerequisite-patch-id: 5a986d744a054000998ce06e3dbaaedede71c8ac
prerequisite-patch-id: cdb26f72d1fbd7fef4a9ef4476e0218dd3fcba22
prerequisite-patch-id: 838e3cb639cf13c7b571d77c1dea3d4ec479465d
prerequisite-patch-id: d5059c23f752a4861e5bbfe70b8ab771727bf68d
prerequisite-patch-id: c7ca9e00334dabe41f39e006ceb2b7d1afddcaa5
-- 
2.42.0


