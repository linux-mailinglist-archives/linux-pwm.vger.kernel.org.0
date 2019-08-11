Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2183889147
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2019 12:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKKkn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Aug 2019 06:40:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46132 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725810AbfHKKkn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Aug 2019 06:40:43 -0400
X-UUID: 9504157131724bf1871e2df9da07d3bb-20190811
X-UUID: 9504157131724bf1871e2df9da07d3bb-20190811
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 308937542; Sun, 11 Aug 2019 18:40:28 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 11 Aug
 2019 18:40:22 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 11 Aug 2019 18:40:21 +0800
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
Subject: [PATCH v6 0/7] Support dsi for mt8183
Date:   Sun, 11 Aug 2019 18:40:01 +0800
Message-ID: <20190811104008.53372-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24840.000
X-TM-AS-Result: No-5.718800-8.000000-10
X-TMASE-MatchedRID: PCFkxA7eE66hZP7w7B20aBIRh9wkXSlFNV9S7O+u3KadzjX37VUcWqEG
        Khm9baaNNopdIl2CpsDdUKRFRakaQnimQCA94R1WLbjXqdzdtCX3/H7adAffkmu9/l5WAy7sO9Z
        u2UZqoB4haUDpkJbehghuCIQJ30DP0Gz/Cfu4aZIaLqFbxdotGfG6GRFYrbYYHWtVZN0asTiBE9
        XLgD84RgQiZjW65EMBAdXPD0156qGvvxILmKK/HBRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7pXkZ
        x4nnABf5ZwGcBkyiq7xZlyRTC5yty9XGqRRih6PS4W/MRhJ1X4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.718800-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24840.000
X-TM-SNTS-SMTP: F80B6B3FC6BAC26A8837D7BF87385F3155E757CEC496A3054F68F3063D8FE6672000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Change since v5:
 - fine tune dphy timing.

Change since v4:
 - move mipi_dsi_host_unregiter() to .remove()
 - fine tune add frame size control coding style
 - change the data type of data_rate as u32, and add DIV_ROUND_UP_ULL
 - use div_u64 when 8000000000ULL / dsi->data_rate.

Changes since v3
 - add one more 'tab' for bitwise define.
 - add Tested-by: Ryan Case <ryandcase@chromium.org>
	and Reviewed-by: CK Hu <ck.hu@mediatek.com>.
 - remove compare da_hs_zero to da_hs_prepare.

Changes since v2:
 - change the video timing calc method
 - fine the dsi and mipitx init sequence
 - fine tune commit msg

Changes since v1:
 - separate frame size and reg commit control independent patches.
 - fix some return values in probe
 - remove DSI_CMDW0 in "CMDQ reg address of mt8173 is different with mt2701" 

Jitao Shi (7):
  drm/mediatek: move mipi_dsi_host_register to probe
  drm/mediatek: fixes CMDQ reg address of mt8173 is different with
    mt2701
  drm/mediatek: add dsi reg commit disable control
  drm/mediatek: add frame size control
  drm/mediatek: add mt8183 dsi driver support
  drm/mediatek: change the dsi phytiming calculate method
  drm: mediatek: adjust dsi and mipi_tx probe sequence

 drivers/gpu/drm/mediatek/mtk_drm_drv.c |   2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c     | 224 ++++++++++++++++++-------
 2 files changed, 161 insertions(+), 65 deletions(-)

-- 
2.21.0

