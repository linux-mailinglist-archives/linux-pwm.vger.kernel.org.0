Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E6579C4
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2019 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfF0C7L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 22:59:11 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40235 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726658AbfF0C7L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 22:59:11 -0400
X-UUID: ffb4565af9e24d95817df2acd956c6be-20190627
X-UUID: ffb4565af9e24d95817df2acd956c6be-20190627
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 275571923; Thu, 27 Jun 2019 10:59:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Jun
 2019 10:59:04 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 27 Jun 2019 10:59:02 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
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
Subject: [v5 0/3] Support mipitx for mt8183
Date:   Thu, 27 Jun 2019 10:58:58 +0800
Message-ID: <20190627025901.28418-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 345 ++----------------
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  50 +++
 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 289 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 181 +++++++++
 6 files changed, 550 insertions(+), 321 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c

-- 
2.21.0

