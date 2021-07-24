Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0653D464A
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jul 2021 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhGXHia (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Jul 2021 03:38:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:18422 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234772AbhGXHi3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Jul 2021 03:38:29 -0400
X-UUID: cc46317b093d4033b99c0da6cb7cafcc-20210724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FqIjmHCwaupnBJmDHNq0CA3qx0xdA5LsYBCK0CPOTPY=;
        b=u1/bbjuom/N//cZgwgGzlKFnhqcGB7VXMcGU6ldupKgVUVYyyvRFYDnjPMdiO0+5D79zmo491GA363dkZyr57+GCpKUdQYPngPii8I5On/ByIEgzrStEnbalxEe2g2OZVaRJaKNotKZA43YBKfa2W9qXrMIWk79rW6FU3U4jfik=;
X-UUID: cc46317b093d4033b99c0da6cb7cafcc-20210724
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1468019768; Sat, 24 Jul 2021 16:18:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 24 Jul
 2021 16:18:53 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 24 Jul 2021 16:18:52 +0800
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
Subject: [PATCH v6 2/5] pwm: mtk_disp: fix force reg to working reg.
Date:   Sat, 24 Jul 2021 16:18:46 +0800
Message-ID: <20210724081849.182108-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724081849.182108-1-jitao.shi@mediatek.com>
References: <20210724081849.182108-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 67574F026B928C06B03282D42610A74070D813AB8F993D86C11FD52D507114AF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RGlzYWJsZSByZWcgZG91YmxlIGJ1ZmZlciBiZWZvcmUgd3JpdGluZyByZWdpc3Rlci4NCg0KU2ln
bmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdtL3B3bS1tdGst
ZGlzcC5jDQppbmRleCAzYWRlNTI1YWRjYzMuLjEwNzBkNzhkNDk0MCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3Au
Yw0KQEAgLTEyOCw2ICsxMjgsMTcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fY29uZmlnKHN0
cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJCW10a19kaXNw
X3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+Y29tbWl0LA0KIAkJCQkJIG1kcC0+ZGF0
YS0+Y29tbWl0X21hc2ssDQogCQkJCQkgMHgwKTsNCisJfSBlbHNlIHsNCisJLyoNCisJICogRm9y
IE1UMjcwMSwgZGlzYWJsZSBkb3VibGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVyDQor
CSAqIGFuZCBzZWxlY3QgbWFudWFsIG1vZGUgYW5kIHVzZSBQV01fUEVSSU9EL1BXTV9ISUdIX1dJ
RFRILg0KKwkgKi8NCisJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+
YmxzX2RlYnVnLA0KKwkJCQkJIG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21hc2ssDQorCQkJCQkgbWRw
LT5kYXRhLT5ibHNfZGVidWdfbWFzayk7DQorCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRw
LCBtZHAtPmRhdGEtPmNvbjAsDQorCQkJCQkgbWRwLT5kYXRhLT5jb24wX3NlbCwNCisJCQkJCSBt
ZHAtPmRhdGEtPmNvbjBfc2VsKTsNCiAJfQ0KIA0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUobWRw
LT5jbGtfbW0pOw0KQEAgLTIxMywxOSArMjI0LDYgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJcGxhdGZvcm1fc2V0X2Ry
dmRhdGEocGRldiwgbWRwKTsNCiANCi0JLyoNCi0JICogRm9yIE1UMjcwMSwgZGlzYWJsZSBkb3Vi
bGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVyDQotCSAqIGFuZCBzZWxlY3QgbWFudWFs
IG1vZGUgYW5kIHVzZSBQV01fUEVSSU9EL1BXTV9ISUdIX1dJRFRILg0KLQkgKi8NCi0JaWYgKCFt
ZHAtPmRhdGEtPmhhc19jb21taXQpIHsNCi0JCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAs
IG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0KLQkJCQkJIG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21hc2ss
DQotCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7DQotCQltdGtfZGlzcF9wd21fdXBk
YXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAsDQotCQkJCQkgbWRwLT5kYXRhLT5jb24wX3Nl
bCwNCi0JCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCi0JfQ0KLQ0KIAlyZXR1cm4gMDsNCiB9
DQogDQotLSANCjIuMjUuMQ0K

