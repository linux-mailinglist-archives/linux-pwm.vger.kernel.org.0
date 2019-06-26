Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE955F40
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 04:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFZCyZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 22:54:25 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34440 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726594AbfFZCyZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 22:54:25 -0400
X-UUID: c314c310790c4050a28b21a154fa5df4-20190626
X-UUID: c314c310790c4050a28b21a154fa5df4-20190626
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1409259465; Wed, 26 Jun 2019 10:54:18 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Jun
 2019 10:54:15 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Jun 2019 10:54:12 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        "Rahul Sharma" <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Vincent Palatin" <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        "Sam Ravnborg" <sam@ravnborg.org>
Subject: [v3 3/4] dt-bindings: display: panel: add auo kd101n80-45na panel bindings
Date:   Wed, 26 Jun 2019 10:53:59 +0800
Message-ID: <20190626025400.109567-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626025400.109567-1-jitao.shi@mediatek.com>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24712.003
X-TM-AS-Result: No-3.890900-8.000000-10
X-TMASE-MatchedRID: icpV8lao858ib7FbSDtRQ+w8wbnnSw8bPz+fM/byAtnfUZT83lbkEEZU
        qiaZ+o8nezYFSWzv4Aj++vFBYLLFFSJrrIAyia6MRORIkLq4xDQ5iooXtStiHoRYHyK7IaoJi9w
        qKeXPJfWPlkcXn2IeyAaIRpZxOPntHRgRCLcbWrgvPGk0keCcJR+qR83NNEVKVptCZRwLvQFKj9
        RzqMBfu9CoiCTf1ntP2SPEr0GBThVv+U6cgdvK9b+Kd/geEyt7fS0Ip2eEHnz3IzXlXlpamPoLR
        4+zsDTtwwUcWQpWasHCjEEV8dP9kwdSqpzbvhxJNghLbJiHVS4z9ebHGXBhcootcdXNgXAjPnQ8
        b0xvxlP6LRYnQF1QeO7uNWa0VYc/XdZYiiD7nm41URakDnXQmkktfpZ7dIYnT2FJac+dZhxC1db
        lKiPrE8C+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.890900-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24712.003
X-TM-SNTS-SMTP: 513CA5F3815985883FFD06FB1B91990A3B9575F2853E73C9022D53324A99EC532000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for auo kd101n80-45na panel.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/auo,kd101n80-45na.txt       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt

diff --git a/Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt b/Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt
new file mode 100644
index 000000000000..994c2a13f942
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt
@@ -0,0 +1,34 @@
+AUO Corporation 10.1" WUXGA TFT LCD panel
+
+Required properties:
+- compatible: should be "auo,kd101n80-45na"
+- reg: the virtual channel number of a DSI peripheral
+- enable-gpios: a GPIO spec for the enable pin
+- pp1800-supply: core voltage supply
+- avdd-supply: phandle of the regulator that provides positive voltage
+- avee-supply: phandle of the regulator that provides negative voltage
+- backlight: phandle of the backlight device attached to the panel
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in
+media/video-interfaces.txt. This node should describe panel's video bus.
+
+Example:
+&dsi {
+	...
+	panel@0 {
+		compatible = "auo,kd101n80-45na";
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		avdd-supply = <&ppvarn_lcd>;
+		avee-supply = <&ppvarp_lcd>;
+		pp1800-supply = <&pp1800_lcd>;
+		backlight = <&backlight_lcd0>;
+		status = "okay";
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
-- 
2.21.0

