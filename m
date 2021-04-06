Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD31355068
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhDFJ6p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 05:58:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40420 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239515AbhDFJ6o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 05:58:44 -0400
X-UUID: b30e7621cd1f448286f948f21de1ef9f-20210406
X-UUID: b30e7621cd1f448286f948f21de1ef9f-20210406
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 128934601; Tue, 06 Apr 2021 17:58:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 17:58:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 17:58:33 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v3,PATCH 0/3] Convert the mtk_disp driver to aotmic API
Date:   Tue, 6 Apr 2021 17:57:39 +0800
Message-ID: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Changes since v3:
 - Modify commit message for PATCH 1/3 pwm: mtk_disp: clear the clock operations

Changes since v1:
 - Seperate clock operation as single patch.
 - Seperate apply() as single patch.
 - Seperate get_state() operation as single patch.

Rex-BC Chen (3):
  pwm: mtk_disp: clear the clock operations
  pwm: mtk_disp: convert the driver to atomic API
  pwm: mtk_disp: implement .get_state()

 drivers/pwm/pwm-mtk-disp.c | 179 +++++++++++++++++++++----------------
 1 file changed, 104 insertions(+), 75 deletions(-)

-- 
2.18.0

