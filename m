Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5179A13F07
	for <lists+linux-pwm@lfdr.de>; Sun,  5 May 2019 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEELFe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 May 2019 07:05:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:60131 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727507AbfEELFe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 5 May 2019 07:05:34 -0400
X-UUID: de3c011c907f4acf891405518ae8bad3-20190505
X-UUID: de3c011c907f4acf891405518ae8bad3-20190505
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 172973483; Sun, 05 May 2019 19:05:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 5 May
 2019 19:05:24 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 5 May 2019 19:05:22 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [PATCH v2 0/2] add dsi pwm0 node for mt8183
Date:   Sun, 5 May 2019 19:05:15 +0800
Message-ID: <20190505110517.965-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Changes since v1:
 - remove "mediatek,mt8173-dsi" from dsi node.

This patch is based on v5.1-rc1 and these patches:
http://lists.infradead.org/pipermail/linux-mediatek/2019-March/017963.html
https://patchwork.kernel.org/patch/10856987/
https://patchwork.kernel.org/cover/10879001/
https://patchwork.kernel.org/cover/10846677/
https://patchwork.kernel.org/patch/10893519/

Jitao Shi (2):
  arm64: dts: mt8183: add dsi node
  arm64: dts: mt8183: add pwm0 node

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.21.0

