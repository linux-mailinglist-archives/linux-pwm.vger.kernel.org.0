Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4BB879B
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2019 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbfISWuA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 18:50:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35463 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389023AbfISWt7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 18:49:59 -0400
X-UUID: a7044866f2f1420e87633eef95e94b06-20190920
X-UUID: a7044866f2f1420e87633eef95e94b06-20190920
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1816646468; Fri, 20 Sep 2019 06:49:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Sep 2019 06:49:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Sep 2019 06:49:48 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v9 0/11] Add mt7629 and fix mt7628 pwm
Date:   Fri, 20 Sep 2019 06:49:00 +0800
Message-ID: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E18B8C972B43F1D1F32E001CB69C38189E2D0D039B9154FF9508845B5D1A95982000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Changes since v9:
  1. PATCH 03/11: Add an Acked-by tag

Changes since v8:
  1. Fix warning and build-error for patch 04/11

Changes since v7:
  1. PATCH v7 10/11: Add a missed Reviewed-by tag

Changes since v6:
  1. Due to we can use fixed-clock in DT
     We removed has_clks and fixed-clock properties 

Changes since v5:
- Follow reviewer's comments:
  1. the license stuff is a separate change
  2. split fix mt7628 pwm into a single patch
  3. to ensure to not use mtk_pwm_clk_name[10] 
     (After dynamic allocate clock array patch, 
      this is no need to check)
  4. Use clock-frequency property to replace 
     the use of has_clks

Changes since v4:
- Follow reviewer's comments (v3: pwm: mediatek: add a property "num-pwms")
  Move the changes of droping the check for of_device_get_match_data
  returning non-NULL to next patch
- Follow reviewers's comments 
  (v3: pwm: mediatek: allocate the clks array dynamically)
  1. use pc->soc->has_clks to check clocks exist or not.
  2. Add error message when probe() unable to get clks
- Fixes bug when SoC is old mips which has no complex clock tree.
if clocks not exist, use the new property from DT to apply period 
calculation; otherwise, use clk_get_rate to get clock frequency and 
apply period calculation.

Changes since v3:
- add a new property "clock-frequency" and fix mt7628 pwm
- add mt7629 pwm support

Changes since v2:
- use num-pwms instead of mediatek,num-pwms.
- rename the member from num_pwms to fallback_num_pwms to make it 
  more obvious that it doesn't represent the actually used value.
- add a dev_warn and a expressive comment to help other developers 
  to not start adding num_pwms in the compatible_data.

Changes since v1:
- add some checks for backwards compatibility.


Ryder Lee (5):
  pwm: mediatek: add a property "num-pwms"
  dt-bindings: pwm: add a property "num-pwms"
  arm64: dts: mt7622: add a property "num-pwms" for PWM
  arm: dts: mt7623: add a property "num-pwms" for PWM
  dt-bindings: pwm: update bindings for MT7629 SoC

Sam Shih (6):
  pwm: mediatek: droping the check for of_device_get_match_data
  pwm: mediatek: remove a property "has-clks"
  pwm: mediatek: allocate the clks array dynamically
  pwm: mediatek: use pwm_mediatek as common prefix
  pwm: mediatek: update license and switch to SPDX tag
  arm: dts: mediatek: add mt7629 pwm support

 .../devicetree/bindings/pwm/pwm-mediatek.txt  |   8 +-
 arch/arm/boot/dts/mt7623.dtsi                 |   1 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   1 +
 drivers/pwm/pwm-mediatek.c                    | 245 +++++++++---------
 arch/arm/boot/dts/mt7629.dtsi                 | 16 ++++++++++++++++
 5 files changed, 149 insertions(+), 122 deletions(-)

-- 
2.17.1

