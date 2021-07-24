Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761A43D4649
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jul 2021 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhGXHia (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Jul 2021 03:38:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:45906 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234774AbhGXHi3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Jul 2021 03:38:29 -0400
X-UUID: b4fee2a433de458099db443222babec4-20210724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cXF42RrJw1ABsP86uX0FWJDg2YYpWsgUVihxQzX44zo=;
        b=WRpX60z83Hd7oe0+ZyomSLb7ofGc3HAUfzkG2SzzgEU8st9hHNVKbpkS6cEWeggmfRtDCQFVeMl4B2t/MdMDw8eXHB/LppWwjgxjyZ1mFnlflAk7ZjtakTj7OyHujjrR9ZpwPbc8Q2ZOA8IvtcYULJM5qv0sn9IdZQzg7HxdYwE=;
X-UUID: b4fee2a433de458099db443222babec4-20210724
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2101701451; Sat, 24 Jul 2021 16:18:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 24 Jul
 2021 16:18:51 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 24 Jul 2021 16:18:50 +0800
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
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 0/5] fix the clks on/off mismatch issue and switch pwm-mtk-disp to atomic APIs
Date:   Sat, 24 Jul 2021 16:18:44 +0800
Message-ID: <20210724081849.182108-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8631904548A5ADA78DF1745B7A3102CBCB1AF9C1E5A86DECAE8D376CF649AA202000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NToNCiAtIGZpeCBvdmVyZmxvdy4NCiAtIFNlcGVyYXRlIHRoZSByZWcg
c2hhZG93IGFzIGEgc2luZ2xlIHBhdGNoLg0KDQpDaGFuZ2VzIHNpbmNlIHY0Og0KIC0gU3F1YXNo
IHRoZSBjb21taXQgIm1vdmUgdGhlIGNvbW1pdCB0byBjbG9jayBlbmFibGVkIiB0byAiYWRqdXN0
IHRoZSBjbG9ja3MgdG8gYXZvaWQgdGhlbSBtaXNtYXRjaCIuDQogLSBEcm9wIHRoZSB1c2VsZXNz
IGNvbW1lbnQgYWJvdXQgTVQyNzAxLg0KIC0gUmVlbmFibGUgdGhlIGNsa3MgIm1tIiBhbmQgIm1h
aW4iIGluIC5lbmFibGUoKS4NCiAtIEZpeCB0eXBvLg0KIC0gU2VwZXJhdGUgZ2V0X3N0YXRlKCkg
b3BlcmF0aW9uIGFzIHNpbmdsZSBwYXRjaC4NCg0KQ2hhbmdlcyBzaW5jZSB2MzoNCiAtIFNlcGVy
YXRlIHRoZSBjbG9jayBzZXF1ZW5jZSBhcyBzaW5nbGUgcGF0Y2guDQogLSBGaXh1cCB0aGUgcmVn
IGNvbW1pdCB3aGVuIGNsb2NrcyBzZXF1ZW5jZSBjaGFuZ2VkLg0KIC0gTWVyZ2UgdGhlIGFwcGx5
IGFuZCBnZXRfc3RhdGUgYXMgc2luZ2xlIHBhdGNoLg0KDQpDaGFuZ2VzIHNpbmNlIHYyOg0KIC0g
Q2hhbmdlIGNvbW1pdCBtZXNzYWdlcyB0byByZW1vdmUgdGhlIGNsb2NrIG9wZXJhdGlvbnMgZm9y
IGF0b21pYyBBUElzLg0KIC0gUmViYXNlIHRvIHY1LjEzIHJjMS4NCg0KQ2hhbmdlcyBzaW5jZSB2
MToNCiAtIFNlcGVyYXRlIGNsb2NrIG9wZXJhdGlvbiBhcyBzaW5nbGUgcGF0Y2guDQogLSBTZXBl
cmF0ZSBhcHBseSgpIGFzIHNpbmdsZSBwYXRjaC4NCiAtIFNlcGVyYXRlIGdldF9zdGF0ZSgpIG9w
ZXJhdGlvbiBhcyBzaW5nbGUgcGF0Y2guDQoNCkppdGFvIFNoaSAoNSk6DQogIHB3bTogbXRrLWRp
c3A6IGFkanVzdCB0aGUgY2xvY2tzIHRvIGF2b2lkIHRoZW0gbWlzbWF0Y2gNCiAgcHdtOiBtdGtf
ZGlzcDogZml4IGZvcmNlIHJlZyB0byB3b3JraW5nIHJlZy4NCiAgcHdtOiBtdGtfZGlzcDogaW1w
bGVtZW50IGF0b21pYyBBUEkgLmFwcGx5KCkNCiAgcHdtOiBtdGtfZGlzcDogZml4IG92ZXJmbG93
IGluIHBlcmlvZCBhbmQgZHV0eSBjYWxjYWxhdGlvbg0KICBwd206IG10a19kaXNwOiBpbXBsZW1l
bnQgYXRvbWljIEFQSSAuZ2V0X3N0YXRlKCkNCg0KIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5j
IHwgMTcyICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwgODAgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4xDQo=

