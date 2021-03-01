Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6626327CDE
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 12:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhCALJY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 06:09:24 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:51084 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhCALJV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 06:09:21 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 4F7E9B1A294; Mon,  1 Mar 2021 12:08:35 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] clk: provide new devm helpers for prepared and enabled clocks
Date:   Mon,  1 Mar 2021 12:08:18 +0100
Message-Id: <20210301110821.1445756-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

compared to the (implicit) v1 sent with Message-Id:
20201013082132.661993-1-u.kleine-koenig@pengutronix.de) I rebased
(trivially) to v5.12-rc1, fixed a bug and split the first patch in two
to make the series easier to review.

I also stripped down the demo patch to a single driver.

Thanks for considering
Uwe

Uwe Kleine-König (3):
  clk: generalize devm_clk_get() a bit
  clk: Provide new devm_clk_helpers for prepared and enabled clocks
  pwm: atmel: Simplify using devm_clk_get_prepared()

 drivers/clk/clk-devres.c | 106 +++++++++++++++++++++++++++++++--------
 drivers/pwm/pwm-atmel.c  |  15 +-----
 include/linux/clk.h      |  87 +++++++++++++++++++++++++++++++-
 3 files changed, 173 insertions(+), 35 deletions(-)


base-commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
-- 
2.30.0

