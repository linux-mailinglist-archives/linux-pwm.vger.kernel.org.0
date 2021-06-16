Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B363A9562
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jun 2021 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFPIy5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Jun 2021 04:54:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23954 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231335AbhFPIy5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Jun 2021 04:54:57 -0400
X-UUID: 5e1d59239ab94516bfadbe8a777be553-20210616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=89AJn0IAlV0QFt1muodvQr1LlsipCvmqgM8FfeSKFo4=;
        b=G5RX5ILgFIU4tnHEZv/NRdf1Vav//6PuDN2p/buTuMvNp1Jvc+eGv9R1LF5bvq/KecmFfh2sV0d7ec7qAZ68m8SQ3YamiYD6R2mSbG+WziTlCKmCjyJ/WnX51io/83Y+0sCjqKT6uOX5LNvM1xq7GKOAyo2UvTOw69MvyE2nkw8=;
X-UUID: 5e1d59239ab94516bfadbe8a777be553-20210616
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1515834494; Wed, 16 Jun 2021 16:52:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 16:52:28 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 16 Jun 2021 16:52:27 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v5 0/3] fix the clks on/off mismatch issue and switch pwm-mtk-disp to atomic APIs
Date:   Wed, 16 Jun 2021 16:52:21 +0800
Message-ID: <20210616085224.157318-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7ACAEB33A9F51A9BFEB13C9C1D213D03A7BF4FA0D1029D0D63114E51221AA3112000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlIHNpbmNlIHY0Og0KIC0gU3F1YXNoIHRoZSBjb21taXQgIm1vdmUgdGhlIGNvbW1pdCB0
byBjbG9jayBlbmFibGVkIiB0byAiYWRqdXN0IHRoZSBjbG9ja3MgdG8gYXZvaWQgdGhlbSBtaXNt
YXRjaCIuDQogLSBEcm9wIHRoZSB1c2VsZXNzIGNvbW1lbnQgYWJvdXQgTVQyNzAxLg0KIC0gUmVl
bmFibGUgdGhlIGNsa3MgIm1tIiBhbmQgIm1haW4iIGluIC5lbmFibGUoKS4NCiAtIEZpeCB0eXBv
Lg0KIC0gU2VwZXJhdGUgZ2V0X3N0YXRlKCkgb3BlcmF0aW9uIGFzIHNpbmdsZSBwYXRjaC4NCg0K
Q2hhbmdlIHNpbmNlIHYzOg0KIC0gU2VwZXJhdGUgdGhlIGNsb2NrIHNlcXVlbmNlIGFzIHNpbmds
ZSBwYXRjaC4NCiAtIEZpeHVwIHRoZSByZWcgY29tbWl0IHdoZW4gY2xvY2tzIHNlcXVlbmNlIGNo
YW5nZWQuDQogLSBNZXJnZSB0aGUgYXBwbHkgYW5kIGdldF9zdGF0ZSBhcyBzaW5nbGUgcGF0Y2gu
DQoNCkNoYW5nZSBzaW5jZSB2MjoNCiAtIENoYW5nZSBjb21taXQgbWVzc2FnZXMgdG8gcmVtb3Zl
IHRoZSBjbG9jayBvcGVyYXRpb25zIGZvciBhdG9taWMgQVBJcy4NCiAtIFJlYmFzZSB0byB2NS4x
MyByYzEuDQoNCkNoYW5nZXMgc2luY2UgdjE6DQogLSBTZXBlcmF0ZSBjbG9jayBvcGVyYXRpb24g
YXMgc2luZ2xlIHBhdGNoLg0KIC0gU2VwZXJhdGUgYXBwbHkoKSBhcyBzaW5nbGUgcGF0Y2guDQog
LSBTZXBlcmF0ZSBnZXRfc3RhdGUoKSBvcGVyYXRpb24gYXMgc2luZ2xlIHBhdGNoLg0KDQpKaXRh
byBTaGkgKDMpOg0KICBwd206IG10ay1kaXNwOiBhZGp1c3QgdGhlIGNsb2NrcyB0byBhdm9pZCB0
aGVtIG1pc21hdGNoDQogIHB3bTogbXRrX2Rpc3A6IGltcGxlbWVudCBhdG9taWMgQVBJIC5hcHBs
eSgpDQogIHB3bTogbXRrX2Rpc3A6IGltcGxlbWVudCBhdG9taWMgQVBJIC5nZXRfc3RhdGUoKQ0K
DQogZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCAxNjggKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspLCA4MyBk
ZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI1LjENCg==

