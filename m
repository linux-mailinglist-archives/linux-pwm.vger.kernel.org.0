Return-Path: <linux-pwm+bounces-5314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60429A778CE
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 12:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A973AAEA5
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF81E9B00;
	Tue,  1 Apr 2025 10:29:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1C1E0E0B
	for <linux-pwm@vger.kernel.org>; Tue,  1 Apr 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503364; cv=none; b=YaxonPILpm/5Yci7TFKs+bhC0f+2uLGdsL+GISdNCD9bimQWBfbACO8hHVBbsHFp5xQyfLhXFiwBcaI4+bykM3hT0EbCASk9Nr4MMQm8eNpFSKdh7Om36qTo1rZ6gCeoNDTJfTgw6BXSvCrjGHiQyisIqOeYYuJo+Uo46Maqc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503364; c=relaxed/simple;
	bh=/t6obRtFVamo8daBzkjO6dUfMjQD34FAwAw7iHsB5p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGDIgkLeHkd0EybikPAYejJfxR6/o+sv9yRqlTIGs9eUUjeaVEpXb+Q8pxHujcdnHmFuUm0f4L8QCbjtBXUhk6yaneRy/tnfrmFP+rnyVLcNFaq10mJJW5kBacec2QReRmMensATqU9+UsvWdf/0wQ5QRC8v9adSRpXQLzxVMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098EAC4CEE8;
	Tue,  1 Apr 2025 10:29:23 +0000 (UTC)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
Date: Tue,  1 Apr 2025 12:28:59 +0200
Message-ID:  <9e78a0796acba3435553ed7db1c7965dcffa6215.1743501688.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
References: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JMgQzUTJoig5ETPeVtsMb4NN/zcNu8J+hWAXWzGaoAA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn67/tJsvKleO7aIXPu4rFG6eq/4n71gXwAUEjo noLJES5ToOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ+u/7QAKCRCPgPtYfRL+ TpKSCACl4E2BSZGgDXNnVYRUVexNWf/pzLfzsOsHEsC6on4hlKTQcylbLwpqPnfagMeus5mvR3D jJqX3V7Ym2fUjlKwQljG+jNHCz+rjvn771hutv6tLm/GQgUAxaRE/YXoZMfKKHSdgkg/sWpY1IS BrCVIpH9WgCqIgVTafaibYdINF1feP6c5yRyn+sW1Xgcy4RruZN3AI0qV7ntHeQZy7HKSeDvKOV ATdmR5KvK86+17wBwWU/L1lYGmeXDo1y0OM4j8pgqSWKig5i1P1NUn6N7p0F8rqz6lVvl9tBaJX ldQuwb+cQeog9gUWuKSYpyYCk1bdI+o/hG6bZkybkXbc9nN0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

With CONFIG_COMPILE_TEST && !CONFIG_HAVE_CLK, pwm_mediatek_config() has a
divide-by-zero in the following line:

	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));

due to the fact that the !CONFIG_HAVE_CLK version of clk_get_rate()
returns zero.

This is presumably just a theoretical problem: COMPILE_TEST overrides
the dependency on RALINK which would select COMMON_CLK.  Regardless it's
a good idea to check for the error explicitly to avoid divide-by-zero.

Fixes the following warning:

  drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org
[ukleinek: s/CONFIG_CLK/CONFIG_HAVE_CLK/]
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 01dfa0fab80a..7eaab5831499 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -121,21 +121,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
 
+	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
 		writel(0, pc->regs + PWM_CK_26M_SEL);
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
-- 
2.47.2


