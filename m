Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7805399E73
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jun 2021 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCKHZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Jun 2021 06:07:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40944 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229789AbhFCKHY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Jun 2021 06:07:24 -0400
X-UUID: 63a1aa9b14684da080441495dea5dee1-20210603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L75spOTlvZqmrkmdca+z60GCtC1z1RwEtUymYBIXVJU=;
        b=n/Dmt/Q4aLhASlB3eJm2MDq1ck2dO+uKV9lPSVnuMpWgqzbYr2LNJpT2XOZeHqNJmHXf/j8vFh/xvR2UGU3sRPU7HrR+v0GkfvKP/KiSVJG+NZJXYUuPxGWG+p1DzcWsl3x4cbxHuweEwZWi5EgZoo0EvvXeuso7VKolYYqC/9c=;
X-UUID: 63a1aa9b14684da080441495dea5dee1-20210603
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1036515460; Thu, 03 Jun 2021 18:05:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 18:05:35 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 3 Jun 2021 18:05:33 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 0/3] fix the clock on/off mismatch and switch pwm api to atomic API
Date:   Thu, 3 Jun 2021 18:05:28 +0800
Message-ID: <20210603100531.161901-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 22F37F3A8C28D6193C7C5BF83EA9545E74F51CA51945BC54C8BC7DD6ABDDF0672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlIHNpbmNlIHYzOg0KIC0gU2VwZXJhdGUgdGhlIGNsb2NrIHNlcXVlbmNlIGFzIHNpbmds
ZSBwYXRjaC4NCiAtIGZpeHVwIHRoZSByZWcgY29tbWl0IHdoZW4gY2xvY2tzIHNlcXVlbmNlIGNo
YW5nZWQNCiAtIE1lcmVnZSB0aGUgYXBwbHkgYW5kIGdldF9zdGF0ZSBhcyBzaW5nbGUgcGF0Y2gN
Cg0KQ2hhbmdlIHNpbmNlIHYyOg0KIC0gQ2hhbmdlIGNvbW1pdCBtZXNzYWdlcyB0byByZW1vdmUg
dGhlIGNsb2NrIG9wZXJhdGlvbnMgZm9yIGF0b21pYyBBUElzLg0KIC0gUmViYXNlIHRvIHY1LjEz
IHJjMQ0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KIC0gU2VwZXJhdGUgY2xvY2sgb3BlcmF0aW9uIGFz
IHNpbmdsZSBwYXRjaC4NCiAtIFNlcGVyYXRlIGFwcGx5KCkgYXMgc2luZ2xlIHBhdGNoLg0KIC0g
U2VwZXJhdGUgZ2V0X3N0YXRlKCkgb3BlcmF0aW9uIGFzIHNpbmdsZSBwYXRjaC4NCg0KSml0YW8g
U2hpICgzKToNCiAgcHdtOiBtdGstZGlzcDogYWRqdXN0IHRoZSBjbG9ja3MgdG8gYXZvaWQgdGhl
bSBtaXNtYXRjaA0KICBwd206IG10ay1kaXNwOiBtb3ZlIHRoZSBjb21taXQgdG8gY2xvY2sgZW5h
YmxlZA0KICBwd206IG10ay1kaXNwOiBTd2l0Y2ggdG8gYXRvbWljIEFQSQ0KDQogZHJpdmVycy9w
d20vcHdtLW10ay1kaXNwLmMgfCAxNjcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCA3NCBkZWxldGlvbnMoLSkN
Cg0KLS0gDQoyLjI1LjENCg==

