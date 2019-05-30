Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFE2FA2A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2019 12:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfE3KVB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 06:21:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:6884 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726738AbfE3KVB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 06:21:01 -0400
X-IronPort-AV: E=Sophos;i="5.60,530,1549897200"; 
   d="scan'208";a="17175265"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 May 2019 19:20:59 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2F6DA4235972;
        Thu, 30 May 2019 19:20:59 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/4] pwm: add power management on sysfs and switch to SPDX
Date:   Thu, 30 May 2019 19:16:03 +0900
Message-Id: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series is affected from the following email:
https://marc.info/?l=linux-renesas-soc&m=155896668906609&w=2

- The patch 1 adds descriptions into Documentation/pwm.txt.
- The patch 2 is not related to the topic though, switches to
  SPDX identifier of sysfs.c.
- The patch 3 adds suspend/resume support into sysfs.c.
- The patch 4 removes suspend/resume support from pwm-rcar.c.

I'll make for other PWM drivers to remove suspend/resume support
after this patch series is applied.

Changes from v1 [1]:
 - Save pwm_state of suspend instead of own bool value on the patch 3.
 - Separate functions for suspend and resume on the patch 3.
 - Remove unnecessary condition of child_to_pwm_export() on the patch 3.
 - Add helper functions for suspend/resume into sysfs.c on the patch 3.
 - Add comment about the "roll back" on the patch 3.

[1]
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=124235

Yoshihiro Shimoda (4):
  pwm: Add power management descriptions
  pwm: sysfs: Switch to SPDX identifier
  pwm: sysfs: Add suspend/resume support
  pwm: rcar: Remove suspend/resume support

 Documentation/pwm.txt  |   7 ++++
 drivers/pwm/pwm-rcar.c |  39 -----------------
 drivers/pwm/sysfs.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 108 insertions(+), 49 deletions(-)

-- 
2.7.4

