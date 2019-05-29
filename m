Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2C2D6FD
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE2Hwy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 03:52:54 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:7651 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbfE2Hwy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 03:52:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,526,1549897200"; 
   d="scan'208";a="17060847"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 May 2019 16:52:52 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 536B24009418;
        Wed, 29 May 2019 16:52:52 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/4] pwm: Add power management descriptions
Date:   Wed, 29 May 2019 16:47:59 +0900
Message-Id: <1559116082-9851-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds power management descriptions that consumers should
implement it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/pwm.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa..996e5ea 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -65,6 +65,10 @@ period). struct pwm_args contains 2 fields (period and polarity) and should
 be used to set the initial PWM config (usually done in the probe function
 of the PWM user). PWM arguments are retrieved with pwm_get_args().
 
+All consumers should really be reconfiguring the PWM upon resume as
+appropriate. This is the only way to ensure that everything is resumed in
+the proper order.
+
 Using PWMs with the sysfs interface
 -----------------------------------
 
@@ -141,6 +145,9 @@ The implementation of ->get_state() (a method used to retrieve initial PWM
 state) is also encouraged for the same reason: letting the PWM user know
 about the current PWM state would allow him to avoid glitches.
 
+Drivers should not implement any power management. In other words,
+consumers should implement it as described as the "Using PWMs" section.
+
 Locking
 -------
 
-- 
2.7.4

