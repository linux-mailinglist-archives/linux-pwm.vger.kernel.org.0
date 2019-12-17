Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68448122252
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2019 04:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfLQDEo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 22:04:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:30151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbfLQDEn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 22:04:43 -0500
X-UUID: b0a9a401e1bf4c8d8364ded8ad283eea-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NXAXywe6bG/ogKzjc7bR2k8BXtOTUM9mI6/1bMTQUeg=;
        b=is4N3uuAJASaDf1gCgtW7vi43UfACM35woO5378gO0ogFp8GH8G5PAl8bzthbzOxZw13ohymfVjqSEyvtoCKtdFH/3AYjgWnEAI9/ytjyZma+Ey57hBTK6L+XzflWK87UHv42PoYL3pi79sZi58eKrmnEydJ4PzIiIAnNmHFORY=;
X-UUID: b0a9a401e1bf4c8d8364ded8ad283eea-20191217
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 248242144; Tue, 17 Dec 2019 11:04:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Dec
 2019 11:03:42 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 17 Dec 2019 11:04:16 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 1/2] pwm: fix pwm clocks not poweroff when disable pwm
Date:   Tue, 17 Dec 2019 11:04:37 +0800
Message-ID: <20191217030438.26657-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217030438.26657-1-jitao.shi@mediatek.com>
References: <20191217030438.26657-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A48D6B2B5460CE96AC1D7495E1536D28FC3904D05A98F51561804B251FDF4A0E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhlIGNsb2NrcyBvZiBwd20gYXJlIHN0aWxsIGluIHByZXBhcmUgc3RhdGUgd2hlbiBkaXNhYmxl
IHB3bS4NCg0KQmVjYXVzZSB0aGUgY2xvY2tzIGlzIHByZXBhcmVkIGluIG10a19kaXNwX3B3bV9w
cm9iZSgpIGFuZCB1bnByZXBhcmVkDQppbiBtdGtfZGlzcF9wd21fcmVtb3ZlKCkuDQoNCmNsa19w
cmVwYXJlIGFuZCBjbGtfdW5wcmVwYXJlIGFyZW4ndCBjYWxsZWQgYnkgbXRrX2Rpc3BfcHdtX2Vu
YWJsZSgpDQphbmQgbXRrX2Rpc3BfcHdtX2Rpc2FibGUoKS4NCg0KTW9kaWZpZWQ6DQpTbyBjbGtf
ZW5hYmxlKCkgaXMgaW5zdHJlYWQgd2l0aCBjbGtfcHJlcGFyZV9lbmFibGUoKS4NCmNsa19kaXNh
YmxlKCkgaXMgaW5zdHJlYWQgd2l0aCBjbGtfZGlzYWJsZV91bnByZXBhcmUoKS4NCg0KQW5kIHJl
bW92ZSB0aGUgY2xrX3ByZXBhcmUoKSBmcm9tIG10a19kaXNwX3B3bV9wcm9iZSgpLA0KcmVtb3Zl
IHRoZSBjbGtfdW5wcmVwYXJlIGZyb20gbXRrX2Rpc3BfcHdtX3JlbW92ZSgpLg0KDQpTaWduZWQt
b2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L3B3bS9wd20tbXRrLWRpc3AuYyB8IDQzICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgYi9kcml2ZXJzL3B3
bS9wd20tbXRrLWRpc3AuYw0KaW5kZXggODNiOGJlMDIwOWI3Li5jN2IxNGFjYzkzMTYgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYw0KKysrIGIvZHJpdmVycy9wd20vcHdt
LW10ay1kaXNwLmMNCkBAIC05OCwxMyArOTgsMTMgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21f
Y29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJ
aGlnaF93aWR0aCA9IGRpdjY0X3U2NChyYXRlICogZHV0eV9ucywgZGl2KTsNCiAJdmFsdWUgPSBw
ZXJpb2QgfCAoaGlnaF93aWR0aCA8PCBQV01fSElHSF9XSURUSF9TSElGVCk7DQogDQotCWVyciA9
IGNsa19lbmFibGUobWRwLT5jbGtfbWFpbik7DQorCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZSht
ZHAtPmNsa19tYWluKTsNCiAJaWYgKGVyciA8IDApDQogCQlyZXR1cm4gZXJyOw0KIA0KLQllcnIg
PSBjbGtfZW5hYmxlKG1kcC0+Y2xrX21tKTsNCisJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKG1k
cC0+Y2xrX21tKTsNCiAJaWYgKGVyciA8IDApIHsNCi0JCWNsa19kaXNhYmxlKG1kcC0+Y2xrX21h
aW4pOw0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0KIAkJcmV0dXJu
IGVycjsNCiAJfQ0KIA0KQEAgLTEyNCw4ICsxMjQsOCBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3
bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0K
IAkJCQkJIDB4MCk7DQogCX0NCiANCi0JY2xrX2Rpc2FibGUobWRwLT5jbGtfbW0pOw0KLQljbGtf
ZGlzYWJsZShtZHAtPmNsa19tYWluKTsNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xr
X21tKTsNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0KIA0KIAlyZXR1
cm4gMDsNCiB9DQpAQCAtMTM1LDEzICsxMzUsMTMgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21f
ZW5hYmxlKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSkNCiAJ
c3RydWN0IG10a19kaXNwX3B3bSAqbWRwID0gdG9fbXRrX2Rpc3BfcHdtKGNoaXApOw0KIAlpbnQg
ZXJyOw0KIA0KLQllcnIgPSBjbGtfZW5hYmxlKG1kcC0+Y2xrX21haW4pOw0KKwllcnIgPSBjbGtf
cHJlcGFyZV9lbmFibGUobWRwLT5jbGtfbWFpbik7DQogCWlmIChlcnIgPCAwKQ0KIAkJcmV0dXJu
IGVycjsNCiANCi0JZXJyID0gY2xrX2VuYWJsZShtZHAtPmNsa19tbSk7DQorCWVyciA9IGNsa19w
cmVwYXJlX2VuYWJsZShtZHAtPmNsa19tbSk7DQogCWlmIChlcnIgPCAwKSB7DQotCQljbGtfZGlz
YWJsZShtZHAtPmNsa19tYWluKTsNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19t
YWluKTsNCiAJCXJldHVybiBlcnI7DQogCX0NCiANCkBAIC0xNTgsOCArMTU4LDggQEAgc3RhdGlj
IHZvaWQgbXRrX2Rpc3BfcHdtX2Rpc2FibGUoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3Qg
cHdtX2RldmljZSAqcHdtKQ0KIAltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBESVNQX1BX
TV9FTiwgbWRwLT5kYXRhLT5lbmFibGVfbWFzaywNCiAJCQkJIDB4MCk7DQogDQotCWNsa19kaXNh
YmxlKG1kcC0+Y2xrX21tKTsNCi0JY2xrX2Rpc2FibGUobWRwLT5jbGtfbWFpbik7DQorCWNsa19k
aXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19tbSk7DQorCWNsa19kaXNhYmxlX3VucHJlcGFyZSht
ZHAtPmNsa19tYWluKTsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBwd21fb3BzIG10a19k
aXNwX3B3bV9vcHMgPSB7DQpAQCAtMTk0LDE0ICsxOTQsNiBAQCBzdGF0aWMgaW50IG10a19kaXNw
X3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoSVNfRVJSKG1k
cC0+Y2xrX21tKSkNCiAJCXJldHVybiBQVFJfRVJSKG1kcC0+Y2xrX21tKTsNCiANCi0JcmV0ID0g
Y2xrX3ByZXBhcmUobWRwLT5jbGtfbWFpbik7DQotCWlmIChyZXQgPCAwKQ0KLQkJcmV0dXJuIHJl
dDsNCi0NCi0JcmV0ID0gY2xrX3ByZXBhcmUobWRwLT5jbGtfbW0pOw0KLQlpZiAocmV0IDwgMCkN
Ci0JCWdvdG8gZGlzYWJsZV9jbGtfbWFpbjsNCi0NCiAJbWRwLT5jaGlwLmRldiA9ICZwZGV2LT5k
ZXY7DQogCW1kcC0+Y2hpcC5vcHMgPSAmbXRrX2Rpc3BfcHdtX29wczsNCiAJbWRwLT5jaGlwLmJh
c2UgPSAtMTsNCkBAIC0yMTAsNyArMjAyLDcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmV0ID0gcHdtY2hpcF9hZGQoJm1k
cC0+Y2hpcCk7DQogCWlmIChyZXQgPCAwKSB7DQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJwd21j
aGlwX2FkZCgpIGZhaWxlZDogJWRcbiIsIHJldCk7DQotCQlnb3RvIGRpc2FibGVfY2xrX21tOw0K
KwkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBtZHAp
Ow0KQEAgLTIyOSwyNCArMjIxLDEzIEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCX0NCiANCiAJcmV0dXJuIDA7DQotDQotZGlz
YWJsZV9jbGtfbW06DQotCWNsa191bnByZXBhcmUobWRwLT5jbGtfbW0pOw0KLWRpc2FibGVfY2xr
X21haW46DQotCWNsa191bnByZXBhcmUobWRwLT5jbGtfbWFpbik7DQotCXJldHVybiByZXQ7DQog
fQ0KIA0KIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IG10a19kaXNwX3B3bSAqbWRwID0gcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldik7DQotCWludCByZXQ7DQotDQotCXJldCA9IHB3bWNoaXBfcmVtb3ZlKCZt
ZHAtPmNoaXApOw0KLQljbGtfdW5wcmVwYXJlKG1kcC0+Y2xrX21tKTsNCi0JY2xrX3VucHJlcGFy
ZShtZHAtPmNsa19tYWluKTsNCiANCi0JcmV0dXJuIHJldDsNCisJcmV0dXJuIHB3bWNoaXBfcmVt
b3ZlKCZtZHAtPmNoaXApOw0KIH0NCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19wd21fZGF0
YSBtdDI3MDFfcHdtX2RhdGEgPSB7DQotLSANCjIuMjEuMA0K

