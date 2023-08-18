Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65112780857
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Aug 2023 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359144AbjHRJbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Aug 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359126AbjHRJak (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2023 05:30:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936E3A88;
        Fri, 18 Aug 2023 02:30:36 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRxNk0sV0zFqlR;
        Fri, 18 Aug 2023 17:27:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:30:33 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <andy@kernel.org>,
        <j-keerthy@ti.com>, <vz@mleia.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <grygorii.strashko@ti.com>,
        <ssantosh@kernel.org>, <khilman@kernel.org>,
        <shubhrajyoti.datta@amd.com>, <srinivas.neeli@amd.com>,
        <michal.simek@amd.com>
CC:     <lizetao1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH -next 00/11] gpio: Use devm_clk_get_*() helper function to simplify the drivers.
Date:   Fri, 18 Aug 2023 17:30:07 +0800
Message-ID: <20230818093018.1051434-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks") provides a a series of new helper function for
prepared and enabled clocks when a driver keeps a clock prepared
(or enabled) during the whole lifetime of the driver. So where drivers
get clocks and enable them immediately, it can be combined into a single
function devm_clk_get_*(). Moreover, the unprepare and disable function
has been registered to devm_clk_state, and before devm_clk_state is
released, the clocks will be unprepareed and disable, so it is unnecessary
to unprepare and disable clock explicitly when remove drivers or in the
error handling path.

Li Zetao (11):
  gpio: cadence: Use helper function devm_clk_get_enabled()
  gpio: davinci: Use helper function devm_clk_get_enabled()
  gpio: ftgpio010: Use helper function devm_clk_get_enabled()
  gpio: lpc18xx: Use helper function devm_clk_get_enabled()
  gpio: mb86s7x: Use helper function devm_clk_get_optional_enabled()
  gpio: mvebu: Use helper function devm_clk_get_enabled()
  gpio: mxc: Use helper function devm_clk_get_optional_enabled()
  gpio: omap: Use helper function devm_clk_get_prepared()
  gpio: stp-xway: Use helper function devm_clk_get_enabled()
  gpio: xilinx: Use helper function devm_clk_get_optional_enabled()
  gpio: zynq: Use helper function devm_clk_get_enabled()

 drivers/gpio/gpio-cadence.c   | 20 +++++---------------
 drivers/gpio/gpio-davinci.c   | 13 ++-----------
 drivers/gpio/gpio-ftgpio010.c | 29 +++++++----------------------
 drivers/gpio/gpio-lpc18xx.c   | 14 +++-----------
 drivers/gpio/gpio-mb86s7x.c   |  8 +-------
 drivers/gpio/gpio-mvebu.c     |  4 +---
 drivers/gpio/gpio-mxc.c       |  9 +--------
 drivers/gpio/gpio-omap.c      |  8 +-------
 drivers/gpio/gpio-stp-xway.c  | 10 ++--------
 drivers/gpio/gpio-xilinx.c    | 14 +++-----------
 drivers/gpio/gpio-zynq.c      | 13 +++----------
 11 files changed, 29 insertions(+), 113 deletions(-)

-- 
2.34.1

