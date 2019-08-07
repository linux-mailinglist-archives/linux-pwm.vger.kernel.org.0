Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CE847FB
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfHGIrQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 04:47:16 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54677 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728726AbfHGIrP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Aug 2019 04:47:15 -0400
X-UUID: 641bf1ff151045afb9b53c008c4837f9-20190807
X-UUID: 641bf1ff151045afb9b53c008c4837f9-20190807
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1689623142; Wed, 07 Aug 2019 16:46:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 7 Aug
 2019 16:46:48 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 7 Aug 2019 16:46:46 +0800
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
Subject: [PATCH v6 0/3] Support mipitx for mt8183
Date:   Wed, 7 Aug 2019 16:46:42 +0800
Message-ID: <20190807084645.63738-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24828.001
X-TM-AS-Result: No-6.934100-8.000000-10
X-TMASE-MatchedRID: angWuI+ZklDHO8eAxCOj9iAI8aJmq0jwEypq3q87aEEL9Tj77wy87Pib
        PPdYWnRM+F2zlPAdpe6A45NLifUOpj3qUaC7D/bC/1dEgwtQ6NBcaNB/u5yQq8z/SxKo9mJ4NHw
        BAGIh28uVta6x57a42xw8w8GZWTrwoqClLVAxl2VDiyuN5FvFNj+k5IvvZ1N/mvnco5r4a3OjxY
        yRBa/qJcFwgTvxipFajoczmuoPCq1guV9FslmIPhw7K8UtBQeEp3IVzZN0+VdcN1xZFcfLHXIs9
        fkcQeBP
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.934100-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24828.001
X-TM-SNTS-SMTP: 64327E99D620C0FC25FBF80F2165C701713A62B3F7AA8C8E730E2B111128E7202000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Change since v5:
 - remove mipi_tx->ref_clk
 - remove mt8183 pll prepare unprepare

Change since v4:
 - fine tune the mipi_tx->ref_clk and mipi_tx->pll sequence
   1. Prepare mipi_tx->ref_clk
   2. Prepare mipi_tx->pll
   3. Enable mipi_tx->ref_clk
   4. Enable mipi_tx->pll

Changes since v3:
 - turn off PLL before setting PLL parameters.

Changes since v2:
 - update Acked-by: Rob Herring <robh@kernel.org>
 - update mt8183 max bit rate support

Changes since v1:
 - update dt-bindings document for mt8183 mipitx.
 - remove mtk_mipitx_clk_get_ops and assign clk_ops in probe.
 - fix the lincence
 - remove txdiv1 from mtk_mipi_tx_pll_prepare

Jitao Shi (3):
  dt-bindings: display: mediatek: update dsi supported chips
  drm/mediatek: separate mipi_tx to different file
  drm/mediatek: add mipi_tx driver for mt8183

 .../display/mediatek/mediatek,dsi.txt         |   4 +-
 drivers/gpu/drm/mediatek/Makefile             |   2 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 338 ++----------------
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  49 +++
 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 289 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 150 ++++++++
 6 files changed, 515 insertions(+), 317 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c

-- 
2.21.0

