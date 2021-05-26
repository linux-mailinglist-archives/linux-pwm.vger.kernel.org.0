Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7871390E73
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhEZCua (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 22:50:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:20563 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230312AbhEZCu3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 22:50:29 -0400
X-UUID: 7ba10a5fe6684be6a8decf6fffcd13a5-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=S458bFdCrt2QE1SUK006+v380LaC2a7otA4+r/WIpms=;
        b=Sp2Vl/xqFSVW4YdZCS9KyYxm9XqLfL65RATvekjNNOFysJOa3XhTnSsi7F+4WOWgAUJXTMS+DyT6SSlUNTHA+3D1oS0DQKSdFG6rO+Uck4j83SHZdN/rbi6NfwQFlQzC3q1IX/ejEVWgO2BAPomzrenAORuBSfWqMk/LrZPE+MY=;
X-UUID: 7ba10a5fe6684be6a8decf6fffcd13a5-20210526
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1820372095; Wed, 26 May 2021 10:48:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 10:48:49 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 26 May 2021 10:48:48 +0800
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
Subject: [PATCH v3 1/3] pwm: mtk_disp: remove the clock operations for atomic APIs.
Date:   Wed, 26 May 2021 10:48:44 +0800
Message-ID: <20210526024846.120838-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210526024846.120838-1-jitao.shi@mediatek.com>
References: <20210526024846.120838-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 27C78D67539E231FD6068E16D8933DE078811C7E6B199FD3E9E2BEFF4A92E1C42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

V2UgaGF2ZSBhIGlzc3VlIHRoYXQgY2xvY2tzIGFyZW4ndCBkaXNhYmxlZCB3aGVuIHN5c3RlbSBp
cyBzdGFuZGJ5Lg0KVGhlIGRyaXZlciB1c2VzIHRoZSBsZWdhY3kgQVBJcywgYW5kIHdlIHdhbnQg
dG8gY292ZXJ0IHRoZW0gdG8NCmF0b21pY2FsbHkgQVBJcy4gQW5kIHNvbHZlIHRoZSBpc3N1ZSBh
dCB0aGUgc2FtZXRpbWUuDQoNCkNoYW5nZS1JZDogSWZmY2Y3NGE0ODhlNGU2YzA4NjVmZWMxN2Q4
ODA1Y2M4YjJlNThiNTQNClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwgMjMgKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyMSBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIGIvZHJp
dmVycy9wd20vcHdtLW10ay1kaXNwLmMNCmluZGV4IDliM2JhNDAxYTNkYi4uYmMyZmRiZTg1M2Jh
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMNCisrKyBiL2RyaXZlcnMv
cHdtL3B3bS1tdGstZGlzcC5jDQpAQCAtMTkyLDE0ICsxOTIsNiBAQCBzdGF0aWMgaW50IG10a19k
aXNwX3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoSVNfRVJS
KG1kcC0+Y2xrX21tKSkNCiAJCXJldHVybiBQVFJfRVJSKG1kcC0+Y2xrX21tKTsNCiANCi0JcmV0
ID0gY2xrX3ByZXBhcmUobWRwLT5jbGtfbWFpbik7DQotCWlmIChyZXQgPCAwKQ0KLQkJcmV0dXJu
IHJldDsNCi0NCi0JcmV0ID0gY2xrX3ByZXBhcmUobWRwLT5jbGtfbW0pOw0KLQlpZiAocmV0IDwg
MCkNCi0JCWdvdG8gZGlzYWJsZV9jbGtfbWFpbjsNCi0NCiAJbWRwLT5jaGlwLmRldiA9ICZwZGV2
LT5kZXY7DQogCW1kcC0+Y2hpcC5vcHMgPSAmbXRrX2Rpc3BfcHdtX29wczsNCiAJbWRwLT5jaGlw
Lm5wd20gPSAxOw0KQEAgLTIwNyw3ICsxOTksNyBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlyZXQgPSBwd21jaGlwX2FkZCgm
bWRwLT5jaGlwKTsNCiAJaWYgKHJldCA8IDApIHsNCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgInB3
bWNoaXBfYWRkKCkgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCi0JCWdvdG8gZGlzYWJsZV9jbGtfbW07
DQorCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1k
cCk7DQpAQCAtMjI2LDI0ICsyMTgsMTMgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJfQ0KIA0KIAlyZXR1cm4gMDsNCi0NCi1k
aXNhYmxlX2Nsa19tbToNCi0JY2xrX3VucHJlcGFyZShtZHAtPmNsa19tbSk7DQotZGlzYWJsZV9j
bGtfbWFpbjoNCi0JY2xrX3VucHJlcGFyZShtZHAtPmNsa19tYWluKTsNCi0JcmV0dXJuIHJldDsN
CiB9DQogDQogc3RhdGljIGludCBtdGtfZGlzcF9wd21fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgbXRrX2Rpc3BfcHdtICptZHAgPSBwbGF0Zm9ybV9n
ZXRfZHJ2ZGF0YShwZGV2KTsNCi0JaW50IHJldDsNCi0NCi0JcmV0ID0gcHdtY2hpcF9yZW1vdmUo
Jm1kcC0+Y2hpcCk7DQotCWNsa191bnByZXBhcmUobWRwLT5jbGtfbW0pOw0KLQljbGtfdW5wcmVw
YXJlKG1kcC0+Y2xrX21haW4pOw0KIA0KLQlyZXR1cm4gcmV0Ow0KKwlyZXR1cm4gcHdtY2hpcF9y
ZW1vdmUoJm1kcC0+Y2hpcCk7DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3B3bV9k
YXRhIG10MjcwMV9wd21fZGF0YSA9IHsNCi0tIA0KMi4yNS4xDQo=

