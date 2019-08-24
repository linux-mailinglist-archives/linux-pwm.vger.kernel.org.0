Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4871E9BE8E
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfHXPh0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:26 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45364 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfHXPh0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:26 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id E152377EAE2; Sat, 24 Aug 2019 17:37:24 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/6] pwm: ensure pwm_apply_state() doesn't modify the state argument
Date:   Sat, 24 Aug 2019 17:37:01 +0200
Message-Id: <20190824153707.13746-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this series eventually changes the prototype of pwm_apply_state to take
a const struct pwm_state *, see the last patch for a rationale.

Changes since v2 apart from rebasing and so covering a few more drivers
is mainly addressing the concern that after state was rounded and
applied at least pwm_get_state should return the rounded values. See
patch 2.

Uwe Kleine-König (6):
  pwm: introduce local struct pwm_chip in pwm_apply_state()
  pwm: let pwm_get_state() return the last implemented state
  pwm: rockchip: Don't update the state for the caller of
    pwm_apply_state()
  pwm: sun4i: Don't update the state for the caller of pwm_apply_state()
  pwm: fsl-ftm: Don't update the state for the caller of
    pwm_apply_state()
  pwm: ensure pwm_apply_state() doesn't modify the state argument

 drivers/pwm/core.c            | 39 +++++++++++++++++++++--------------
 drivers/pwm/pwm-atmel-hlcdc.c |  2 +-
 drivers/pwm/pwm-atmel.c       |  2 +-
 drivers/pwm/pwm-bcm-iproc.c   |  2 +-
 drivers/pwm/pwm-cros-ec.c     |  2 +-
 drivers/pwm/pwm-fsl-ftm.c     |  8 ++-----
 drivers/pwm/pwm-hibvt.c       |  2 +-
 drivers/pwm/pwm-imx-tpm.c     |  4 ++--
 drivers/pwm/pwm-imx27.c       |  2 +-
 drivers/pwm/pwm-jz4740.c      |  2 +-
 drivers/pwm/pwm-lpss.c        |  2 +-
 drivers/pwm/pwm-meson.c       |  4 ++--
 drivers/pwm/pwm-rcar.c        |  2 +-
 drivers/pwm/pwm-rockchip.c    | 10 ++-------
 drivers/pwm/pwm-sifive.c      |  2 +-
 drivers/pwm/pwm-stm32-lp.c    |  2 +-
 drivers/pwm/pwm-stm32.c       |  4 ++--
 drivers/pwm/pwm-sun4i.c       | 10 ++-------
 drivers/pwm/pwm-zx.c          |  2 +-
 include/linux/pwm.h           |  4 ++--
 20 files changed, 49 insertions(+), 58 deletions(-)

-- 
2.20.1

