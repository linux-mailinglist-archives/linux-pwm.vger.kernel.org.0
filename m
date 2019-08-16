Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A153E8FC03
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHPHVw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 03:21:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56637 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726482AbfHPHVw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 03:21:52 -0400
X-UUID: 1e028c8a659e49798b004c194500d1f4-20190816
X-UUID: 1e028c8a659e49798b004c194500d1f4-20190816
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 338180287; Fri, 16 Aug 2019 15:21:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 16 Aug 2019 15:21:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 16 Aug 2019 15:21:45 +0800
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
Subject: [PATCH v3 0/10] Add mt7629 and fix mt7628 pwm
Date:   Fri, 16 Aug 2019 15:21:18 +0800
Message-ID: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

Changes since v2:
- use num-pwms instead of mediatek,num-pwms.
- rename the member from num_pwms to fallback_num_pwms to make it 
  more obvious that it doesn't represent the actually used value.
- add a dev_warn and a expressive comment to help other developers 
  to not start adding num_pwms in the compatible_data.

Changes since v1:
- add some checks for backwards compatibility.

Sam Shih (3):
  pwm: mediatek: add new property and fix mt7628 pwm
  dt-bindings: pwm: update bindings for MT7628 SoC
  arm: dts: mediatek: add mt7629 pwm support

 .../devicetree/bindings/pwm/pwm-mediatek.txt      |  3 +++
 arch/arm/boot/dts/mt7629.dtsi                     | 14 ++++++++++++++
 drivers/pwm/pwm-mediatek.c                        | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

Ryder Lee (7):
  pwm: mediatek: add a property "num-pwms"
  pwm: mediatek: allocate the clks array dynamically
  pwm: mediatek: use pwm_mediatek as common prefix
  dt-bindings: pwm: add a property "num-pwms"
  arm64: dts: mt7622: add a property "num-pwms" for PWM node
  arm: dts: mt7623: add a property "num-pwms" for PWM node
  dt-bindings: pwm: update bindings for MT7629 SoC

 .../devicetree/bindings/pwm/pwm-mediatek.txt  |   8 +-
 arch/arm/boot/dts/mt7623.dtsi                 |   1 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   1 +
 drivers/pwm/pwm-mediatek.c                    | 226 +++++++++---------
 4 files changed, 126 insertions(+), 110 deletions(-)
-- 
2.17.1

