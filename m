Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350189537F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHTBkz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 21:40:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8543 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728627AbfHTBkz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 21:40:55 -0400
X-UUID: b5b28cb1873b4c70bc178178f04a9a94-20190820
X-UUID: b5b28cb1873b4c70bc178178f04a9a94-20190820
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1464914703; Tue, 20 Aug 2019 09:40:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Aug 2019 09:40:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Aug 2019 09:40:44 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        sam shih <sam.shih@mediatek.com>
Subject: [PATCH v4 0/10] Add mt7629 and fix mt7628 pwm
Date:   Tue, 20 Aug 2019 09:40:15 +0800
Message-ID: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ED3387D8F7DE73AC5566392D3F826B33B8E936E381F4CE54C56FB2ECCDD154A12000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

Changes since v4:
- Follow reviewer's comments (v3: pwm: mediatek: add a property "num-pwms")
  Move the changes of droping the check for of_device_get_match_data
  returning non-NULL to next patch
- Follow reviewers's comments 
  (v3: pwm: mediatek: allocate the clks array dynamically)
  1. use pc->soc->has_clks to check clocks exist or not.
  2. Add error message when probe() unable to get clks
- Fixes bug when SoC is old mips which has no complex clock tree.
if clocks not exist, use the new property from DT to apply period caculation;
otherwise, use clk_get_rate to get clock frequency and apply period caculation.

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


Ryder Lee (6):
  pwm: mediatek: add a property "num-pwms"
  pwm: mediatek: allocate the clks array dynamically and fix mt7628 pwm
  dt-bindings: pwm: add a property "num-pwms"
  arm64: dts: mt7622: add a property "num-pwms" for PWM node
  arm: dts: mt7623: add a property "num-pwms" for PWM node
  dt-bindings: pwm: update bindings for MT7629 SoC

sam shih (4):
  pwm: mediatek: droping the check for of_device_get_match_data
  pwm: mediatek: use pwm_mediatek as common prefix
  dt-bindings: pwm: update bindings for MT7628 SoC
  arm: dts: mediatek: add mt7629 pwm support

 .../devicetree/bindings/pwm/pwm-mediatek.txt  |  11 +-
 arch/arm/boot/dts/mt7623.dtsi                 |   1 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   1 +
 drivers/pwm/pwm-mediatek.c                    | 242 ++++++++++--------
 arch/arm/boot/dts/mt7629.dtsi                 |  16 ++++++++++++++++
 5 files changed, 160 insertions(+), 111 deletions(-)
-- 
2.17.1

