Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914DB35C792
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbhDLN3f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbhDLN3d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 09:29:33 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22196C06138C;
        Mon, 12 Apr 2021 06:29:14 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 297C0C725CF;
        Mon, 12 Apr 2021 15:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618234153;
        bh=GlsSSVic5H44j5iEOaImBYJ/UJ6bO5xkDJrawlhvIZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvN0970p8X3QwcZRsq60A0d7TyjVYXHHjg+FbcqnLdRl43iH0AdkPH5390JC4z2q0
         a6+Ng4ZgH7M3ln8f4fd9I4Z6EUnVqj3PHXfp5jsd8BTFmCpF0ujkwWjbtI1vVEEMDh
         GRhDKkkUJUpnOYz76ZokTbmu1z86FJCQwhG8PkJA=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Date:   Mon, 12 Apr 2021 15:27:41 +0200
Message-Id: <20210412132745.76609-4-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the flag and corresponding documentation for PWM_USAGE_POWER.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
 include/dt-bindings/pwm/pwm.h                 | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 084886bd721e..fe3a28f887c0 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -46,6 +46,9 @@ period in nanoseconds.
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
 - PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_USAGE_POWER: Only care about the power output of the signal. This
+  allows drivers (if supported) to optimize the signals, for example to
+  improve EMI and reduce current spikes.
 
 Example with optional PWM specifier for inverse polarity
 
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..0d5a8f0c0035 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -11,5 +11,6 @@
 #define _DT_BINDINGS_PWM_PWM_H
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
+#define PWM_USAGE_POWER				(1 << 1)
 
 #endif
-- 
2.31.1

