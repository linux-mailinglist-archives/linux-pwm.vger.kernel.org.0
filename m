Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4C8D36A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfHNMqi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 08:46:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34613 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNMqh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 08:46:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so3012184pfp.1
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/Tqal4DPxUyG798nTPcd+FwAY4NlPgoJZ1fPKoHBaLM=;
        b=OEfzoBAXJBnlenOgnIcN8ObmapGd6oOPot2HHn8w7llFh28KD6us6MkjkNc0ASFRqW
         rzl9HZQsKOvImk9AcBnVBAx7qfqDsXeXfpKJnk1ZBu/iJCuqXOt8kNZxvsueMGF+f3Df
         M0GvGYxMRT87H2rdA3V9lQ0vlG8+dPLuxdl6MMjutpxG2Ogi8ecSJYuzzXIUpqrzN957
         t5rzWoFXBSv1uRt6I45S697CkHsE2J2vFVeS2IGyTKgRLZZaDdtCtppwstwzqmonZyP1
         brigO+/FywrRqkeVKQYrHngQYUwIMmRZd/rbjUhdQbuYEhkoeOf0utq/HxmGUHZRG9XW
         kaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Tqal4DPxUyG798nTPcd+FwAY4NlPgoJZ1fPKoHBaLM=;
        b=h+QtmzOlFZw4fkbWjVmMUDGuex8E3yCLnyZnJBWC79mpILpOmDesiERyRGCTjs7I9h
         WfyLE/oZDKZi7e9Y3EV9UA0fijDuQNikZBO8geB2Rq+UoiB5p8CRFbFVUKHtsmk2yHD5
         19vU9/rot7o0ODu4qQhSuIKFwleUdejoWU6QgLTxNisqqc/LQwpEvIzxdTDms8fhBQ0h
         la9XhY+RroSiTWsyAeegQAoU5qxu3chPous7/O/yEs4UPbqgVw7vFDPARh9sGxYdNRYq
         h3ITScEe87Zjxvz1vI3c0uAtpRaodtG1vPPa9FDg90L4MxuSiK272wyKFjv5cqGjytIz
         DMhA==
X-Gm-Message-State: APjAAAWPghEbov6IBd8zPJbHvXG8/VIg3uzMxaPbRmB/7D3hMkgzFt8z
        jksUZ9ihw29WWBTyzcMQwC5taA==
X-Google-Smtp-Source: APXvYqzL6b8vhXNvL0RHogtvtcYwvvjP+B6NIIxmH5sFu0RZbQLilxXQnvdUcLuKpK4kFQZs8fsYdA==
X-Received: by 2002:a63:f13:: with SMTP id e19mr38944881pgl.132.1565786797051;
        Wed, 14 Aug 2019 05:46:37 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e5sm40753099pgt.91.2019.08.14.05.46.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 05:46:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     thierry.reding@gmail.com, robh+dt@kernel.org
Cc:     u.kleine-koenig@pengutronix.de, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
Date:   Wed, 14 Aug 2019 20:46:10 +0800
Message-Id: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add Spreadtrum PWM controller documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Fix some typos.
 - Move assigned-clocks to be optional.

Changes from v1:
 - Use assigned-clock-parents and assigned-clocks to set PWM clock parent.
---
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
new file mode 100644
index 0000000..16fa5a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
@@ -0,0 +1,40 @@
+Spreadtrum PWM controller
+
+Spreadtrum SoCs PWM controller provides 4 PWM channels.
+
+Required properties:
+- compatible : Should be "sprd,ums512-pwm".
+- reg: Physical base address and length of the controller's registers.
+- clocks: The phandle and specifier referencing the controller's clocks.
+- clock-names: Should contain following entries:
+  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
+  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Optional properties:
+- assigned-clocks: Reference to the PWM clock entries.
+- assigned-clock-parents: The phandle of the parent clock of PWM clock.
+
+Example:
+	pwms: pwm@32260000 {
+		compatible = "sprd,ums512-pwm";
+		reg = <0 0x32260000 0 0x10000>;
+		clock-names = "pwm0", "enable0",
+			"pwm1", "enable1",
+			"pwm2", "enable2",
+			"pwm3", "enable3";
+		clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
+		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
+		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
+		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
+		assigned-clocks = <&aon_clk CLK_PWM0>,
+			<&aon_clk CLK_PWM1>,
+			<&aon_clk CLK_PWM2>,
+			<&aon_clk CLK_PWM3>;
+		assigned-clock-parents = <&ext_26m>,
+			<&ext_26m>,
+			<&ext_26m>,
+			<&ext_26m>;
+		#pwm-cells = <2>;
+	};
-- 
1.7.9.5

