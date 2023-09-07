Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA14797C02
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Sep 2023 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245180AbjIGSgX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Sep 2023 14:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbjIGSgW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Sep 2023 14:36:22 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765AA8;
        Thu,  7 Sep 2023 11:36:13 -0700 (PDT)
Received: from [134.238.52.102] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qeHcf-004U1R-Ea; Thu, 07 Sep 2023 17:12:49 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qeHcd-000HV9-2r;
        Thu, 07 Sep 2023 17:12:47 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: [PATCH v9 5/6] pwm: dwc: round rate divisions up
Date:   Thu,  7 Sep 2023 17:12:41 +0100
Message-Id: <20230907161242.67190-6-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As suggested, round up the counter variables to ensure we
always produce a longer period calculation.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/pwm/pwm-dwc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 3b856685029d..6358e3345210 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -50,13 +50,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * 2^32 periods.
 	 */
 	tmp = state->duty_cycle * dwc->clk_rate;
-	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	tmp = DIV_ROUND_UP_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = (state->period - state->duty_cycle) * dwc->clk_rate;
-	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	tmp = DIV_ROUND_UP_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
-- 
2.40.1

