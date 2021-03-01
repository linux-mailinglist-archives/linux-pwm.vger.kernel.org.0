Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E80327FFF
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhCANvk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 08:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbhCANvj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 08:51:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99240C061788
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 05:50:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGiwq-0002BA-JV; Mon, 01 Mar 2021 14:50:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGiwq-0004vL-7G; Mon, 01 Mar 2021 14:50:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] clk: provide new devm helpers for prepared and enabled clocks
Date:   Mon,  1 Mar 2021 14:50:50 +0100
Message-Id: <20210301135053.1462168-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this is a brown paper bag version (aka v3) of my series adding
devm_clk_get_enabled() et al.

Changes since v2 (sent with Message-Id:
20210301110821.1445756-1-uwe@kleine-koenig.org):

 - send it from the right email account to have the sender matching the
   SoB line
 - make __devm_clk_get static
 - fix EXPORT_SYMBOL usage

The last two were found by the kernel test robot.

Range-diff can be found below.

Best regards
Uwe

Uwe Kleine-König (3):
  clk: generalize devm_clk_get() a bit
  clk: Provide new devm_clk_helpers for prepared and enabled clocks
  pwm: atmel: Simplify using devm_clk_get_prepared()

 drivers/clk/clk-devres.c | 96 +++++++++++++++++++++++++++++++++-------
 drivers/pwm/pwm-atmel.c  | 15 +------
 include/linux/clk.h      | 87 +++++++++++++++++++++++++++++++++++-
 3 files changed, 168 insertions(+), 30 deletions(-)

Range-diff against v2:
1:  7203dc0837af ! 1:  3faadae49fed clk: generalize devm_clk_get a bit
    @@ drivers/clk/clk-devres.c
      }
      
     -struct clk *devm_clk_get(struct device *dev, const char *id)
    -+struct clk *__devm_clk_get(struct device *dev, const char *id,
    -+			   struct clk *(*get)(struct device *dev, const char *id),
    -+			   int (*init)(struct clk *clk),
    -+			   void (*exit)(struct clk *clk))
    ++static struct clk *__devm_clk_get(struct device *dev, const char *id,
    ++				  struct clk *(*get)(struct device *dev, const char *id),
    ++				  int (*init)(struct clk *clk),
    ++				  void (*exit)(struct clk *clk))
      {
     -	struct clk **ptr, *clk;
     +	struct devm_clk_state *state;
2:  4d2107992b8c ! 2:  82005b4a9ea1 clk: Provide new devm_clk_helpers for prepared and enabled clocks
    @@ drivers/clk/clk-devres.c: struct clk *devm_clk_get(struct device *dev, const cha
     +			      clk_prepare_enable, clk_disable_unprepare);
     +
     +}
    -+EXPORT_SYMBOL(devm_clk_get_prepared);
    ++EXPORT_SYMBOL(devm_clk_get_enabled);
     +
      struct clk *devm_clk_get_optional(struct device *dev, const char *id)
      {
    @@ drivers/clk/clk-devres.c: struct clk *devm_clk_get(struct device *dev, const cha
     +			      clk_prepare_enable, clk_disable_unprepare);
     +
     +}
    -+EXPORT_SYMBOL(devm_clk_get_optional_prepared);
    ++EXPORT_SYMBOL(devm_clk_get_optional_enabled);
     +
      struct clk_bulk_devres {
      	struct clk_bulk_data *clks;
3:  63f799a4ff32 = 3:  1f73d17d4da7 pwm: atmel: Simplify using devm_clk_get_prepared()

base-commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
-- 
2.30.0

