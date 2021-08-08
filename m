Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256E23E3A64
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Aug 2021 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhHHNZE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Aug 2021 09:25:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:17761 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229608AbhHHNZD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Aug 2021 09:25:03 -0400
X-UUID: 9c0f9437c54a425ab2432bfb0bb6d092-20210808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=k5h7Sp8+45ALsDZpvc+6t/C4ZwJ9c1vZDukf7Ox1N3U=;
        b=DFTUxZp5dEEHBgbHjZOYuZDB5HU6cpHw+sxhOzuzB2I6MEsjcgThlnICI2APfwRWFUfaIHesB5ZMUlzQmLnycP6mkOMKl3w1ntt3LWa141PZ2n3z7iZF8kFeGeObAzK71zSM/3dCfKgk5TZOdtIpOr89dOofVsjgkf9lBtoke1Y=;
X-UUID: 9c0f9437c54a425ab2432bfb0bb6d092-20210808
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 188608094; Sun, 08 Aug 2021 21:24:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 21:24:38 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 8 Aug 2021 21:24:37 +0800
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
Subject: [PATCH v7 2/5] pwm: mtk_disp: fix force reg to working reg.
Date:   Sun, 8 Aug 2021 21:24:30 +0800
Message-ID: <20210808132433.66037-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210808132433.66037-1-jitao.shi@mediatek.com>
References: <20210808132433.66037-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 18A5B4891099B2B45D34D74785DF50D17A01A8B23391E78F5AC7DDA4353EAA952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhlIHJlZyBjYW4ndCBhY2Nlc3Mgd2hlbiB0aGUgY2xvY2sgaXMgb2ZmLg0KQmVjYXVzZSB0aGUg
Y2xvY2tzICJtbSIgYW5kICJtYWluIiBwcmVwYXJlKCkgYW5kIGVuYWJlbCgpIG1vdmUgdG8NCm10
a19kaXNwX3B3bV9jb25maWcoKSBmcm9tIHByb2JlKCkuIFNvIG1vdmUgdGhlIHJlZyBhY2NyZXNz
IG9mDQoicmVnIGRvdWJsZSBidWZmZXIiIHRvIG10a19kaXNwX3B3bV9jb25maWcoKSB0by4NCg0K
U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdtL3B3bS1t
dGstZGlzcC5jDQppbmRleCAzYWRlNTI1YWRjYzMuLjEwNzBkNzhkNDk0MCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbXRrLWRp
c3AuYw0KQEAgLTEyOCw2ICsxMjgsMTcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fY29uZmln
KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJCW10a19k
aXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+Y29tbWl0LA0KIAkJCQkJIG1kcC0+
ZGF0YS0+Y29tbWl0X21hc2ssDQogCQkJCQkgMHgwKTsNCisJfSBlbHNlIHsNCisJLyoNCisJICog
Rm9yIE1UMjcwMSwgZGlzYWJsZSBkb3VibGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVy
DQorCSAqIGFuZCBzZWxlY3QgbWFudWFsIG1vZGUgYW5kIHVzZSBQV01fUEVSSU9EL1BXTV9ISUdI
X1dJRFRILg0KKwkgKi8NCisJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0
YS0+YmxzX2RlYnVnLA0KKwkJCQkJIG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21hc2ssDQorCQkJCQkg
bWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7DQorCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMo
bWRwLCBtZHAtPmRhdGEtPmNvbjAsDQorCQkJCQkgbWRwLT5kYXRhLT5jb24wX3NlbCwNCisJCQkJ
CSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCiAJfQ0KIA0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUo
bWRwLT5jbGtfbW0pOw0KQEAgLTIxMywxOSArMjI0LDYgQEAgc3RhdGljIGludCBtdGtfZGlzcF9w
d21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJcGxhdGZvcm1fc2V0
X2RydmRhdGEocGRldiwgbWRwKTsNCiANCi0JLyoNCi0JICogRm9yIE1UMjcwMSwgZGlzYWJsZSBk
b3VibGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVyDQotCSAqIGFuZCBzZWxlY3QgbWFu
dWFsIG1vZGUgYW5kIHVzZSBQV01fUEVSSU9EL1BXTV9ISUdIX1dJRFRILg0KLQkgKi8NCi0JaWYg
KCFtZHAtPmRhdGEtPmhhc19jb21taXQpIHsNCi0JCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyht
ZHAsIG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0KLQkJCQkJIG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21h
c2ssDQotCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7DQotCQltdGtfZGlzcF9wd21f
dXBkYXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAsDQotCQkJCQkgbWRwLT5kYXRhLT5jb24w
X3NlbCwNCi0JCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCi0JfQ0KLQ0KIAlyZXR1cm4gMDsN
CiB9DQogDQotLSANCjIuMjUuMQ0K

