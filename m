Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE255F31
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 04:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFZCyQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 22:54:16 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbfFZCyQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 22:54:16 -0400
X-UUID: 91b24f43722d466ebd4250b00f9cf19f-20190626
X-UUID: 91b24f43722d466ebd4250b00f9cf19f-20190626
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1962422911; Wed, 26 Jun 2019 10:54:08 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Jun
 2019 10:54:05 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Jun 2019 10:54:02 +0800
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
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [v3 0/4] Add drivers for auo,kd101n80-45na and boe,tv101wum-nl6 panels
Date:   Wed, 26 Jun 2019 10:53:56 +0800
Message-ID: <20190626025400.109567-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24712.003
X-TM-AS-Result: No-4.859500-8.000000-10
X-TMASE-MatchedRID: JnF/j4RbQ0Fu7xCoxCPC8hIRh9wkXSlFSWg+u4ir2NNTbQ95zRbWVhxC
        hMoIsTT1MqqNAwlLCF39K011C4bEh/I1YbpS1+av5venhychcY1MkOX0UoduuWq646qiEnRzcDY
        BtqUkx7xsyJ8A0M3MsXATsg8MODVIHxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUUFn54I1MIrlC6E
        qbEQibuD9Tqrncq1QsXNx4nPRgrzTasMMyBIaxyKGPwUaNZCakygr2f8iu4/h3q397Kle3JbVW6
        8qWjN+ZP3dLjnWr1vEPbJpLSCH/cqQVCHnxhZ/op8zfhMu4/LNfCOKFKuVYGg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.859500-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24712.003
X-TM-SNTS-SMTP: 4C1F9099359D9BA0D664A342062213656D6B4A1AA8DA41A10CE1E24C40B910DF2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Changes since v2:
 - correct the panel size
 - remove blank line in Kconfig
 - move auo,kd101n80-45na panel driver in this series.

Changes since v1:

 - update typo nl6 -> n16.
 - update new panel config and makefile are added in alphabetically order.
 - add the panel mode and panel info in driver data.
 - merge auo,kd101n80-45a and boe,tv101wum-nl6 in one driver

Jitao Shi (4):
  dt-bindngs: display: panel: Add BOE tv101wum-n16 panel bindings
  drm/panel: support for BOE tv101wum-nl6 wuxga dsi video mode panel
  dt-bindings: display: panel: add auo kd101n80-45na panel bindings
  drm/panel: support for auo,kd101n80-45na wuxga dsi video mode panel

 .../display/panel/auo,kd101n80-45na.txt       |  34 +
 .../display/panel/boe,tv101wum-nl6.txt        |  34 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 753 ++++++++++++++++++
 5 files changed, 831 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
 create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c

-- 
2.21.0

