Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF42FBC3F
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbhASQSN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 11:18:13 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:36046 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391994AbhASQNX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 11:13:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 31B8E2507D;
        Tue, 19 Jan 2021 16:12:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jj9WNVIByI26; Tue, 19 Jan 2021 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id CE5382502E;
        Tue, 19 Jan 2021 16:12:18 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v4 0/5] pwm: rockchip: Eliminate potential race condition when probing
Date:   Tue, 19 Jan 2021 11:12:04 -0500
Message-Id: <cover.1610976129.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series eliminates the race condition Trent Piepho
identified[0] in the Rockchip PWM driver's rockchip_pwm_probe()
function, by moving code that checks whether a device is enabled ahead
of the code that registers it via pwmchip_add().

It includes several other small fixes and improvements to the driver
as well: It also

- Fixes a potential kernel hang introduced by my earlier commit
  457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
  probing") by ensuring a device's APB clock is enabled before its
  registers are accessed;

- Removes a superfluous call to clk_unprepare() that could produce
  warnings from the kernel;

- Clarifies error messages from the driver by replacing "bus clk" with
  "PWM clk"; and

- Ensures the driver enables a clock before querying its rate with
  clk_get_rate(), as stated as a requirement in that function's
  documentation.

This version of the series incorporates Uwe Kleine-König's feedback on
v3 and includes these changes:

- Patch 1's commit message has been edited slightly to improve
  readability, and the error message updated by the patch now reads
  "prepare enable" rather than just "enable" for consistency with the
  error message above it in the code.

- Patch 3's commit message now mentions consistency with the device
  tree.

- Patch 4 has been simplified and now just moves the device-enabled
  check ahead of the call to pwmchip_add(). It no longers changes any
  error-handling behaviour, and an extraneous pair of parentheses has
  been removed.

Patches 2 and 5 are unchanged from v3, while the remaining 2 patches
present in v3 (which removed goto targets from and reordered some
operations in rockchip_pwm_probe()) have been dropped.

I've tested these changes on my Pinebook Pro (RK3399 with a PWM-driven
backlight enabled by U-Boot) and ROCK64 (RK3328) and they appear to
work fine.

[0] https://www.spinics.net/lists/linux-pwm/msg14611.html

--
Simon South
simon@simonsouth.net


Simon South (5):
  pwm: rockchip: Enable APB clock during register access while probing
  pwm: rockchip: rockchip_pwm_probe(): Remove superfluous
    clk_unprepare()
  pwm: rockchip: Replace "bus clk" with "PWM clk"
  pwm: rockchip: Eliminate potential race condition when probing
  pwm: rockchip: Enable clock before calling clk_get_rate()

 drivers/pwm/pwm-rockchip.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

-- 
2.30.0

