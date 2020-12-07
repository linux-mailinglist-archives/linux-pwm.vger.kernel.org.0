Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF6D2D19DB
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgLGTjJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 14:39:09 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:35246 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgLGTjJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 14:39:09 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 15614C89267;
        Mon,  7 Dec 2020 20:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607369907;
        bh=Xyh8Wni+Ue0ny3rZRboSXRdZfKHzl+fSzSIiwkbye9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qcqki5qCyt/3MvhYyz2CoN0t4Sxs6mIMbI1swceOl7TACVxFV+udkmffJrjLck0wj
         szTX29sumpitTmRvjMXD2bbvcMz9pTiICpeK2Wg+25brVaB0eix34sN5zTyhnCPprH
         qvwkG7EzCd7bKv2GuUt0yv2jvoHSj+NO7a727JHU=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v4 4/4] dt-bindings: pwm: pca9685: Add nxp,staggered-outputs property
Date:   Mon,  7 Dec 2020 20:38:10 +0100
Message-Id: <20201207193810.493299-1-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pca9685 driver supports a new nxp,staggered-outputs property for
reduced current surges and EMI. This adds documentation for the new DT
property.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v1:
- Added vendor prefix

 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f21b55c95738..fafe954369dc 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -12,6 +12,8 @@ Optional properties:
   - invert (bool): boolean to enable inverted logic
   - open-drain (bool): boolean to configure outputs with open-drain structure;
 		       if omitted use totem-pole structure
+  - nxp,staggered-outputs (bool): boolean to enable staggered output ON times to
+				  minimize current surges and EMI
 
 Example:
 
-- 
2.29.2

