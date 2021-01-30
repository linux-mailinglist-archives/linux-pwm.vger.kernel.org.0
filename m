Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5543095D3
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Jan 2021 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhA3OOr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Jan 2021 09:14:47 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62607 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231801AbhA3ONk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Jan 2021 09:13:40 -0500
X-UUID: 840ae44ff2504a20af1dcdd0b94d30ae-20210130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kakw+ExY4w3INOL6Gi+WiqHiFNwjMa2eKTFUAGbCIJY=;
        b=BjrCyn6PEQyixv3QYJxV7kLEoR2au4DqYHTNPTLGuMQnlQ7i1VyeuxatEjr8t/baZS35bYApsGFnHd25CTmxb5C49QXdaEedfnQV5PQyyXjW6l89rylBA/LHq00HnICbYr8tG3Ngo6QxtM7VcNa5nBQU/xDvVhRvg4OFk8pL0Cs=;
X-UUID: 840ae44ff2504a20af1dcdd0b94d30ae-20210130
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 502012696; Sat, 30 Jan 2021 22:12:54 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 30 Jan
 2021 22:12:30 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 30 Jan 2021 22:12:30 +0800
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
Subject: [PATCH v2 1/3] pwm: mtk_disp: clear the clock operations
Date:   Sat, 30 Jan 2021 22:12:24 +0800
Message-ID: <20210130141226.25357-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20210130141226.25357-1-jitao.shi@mediatek.com>
References: <20210130141226.25357-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F34A494F3A7982D95875365C4E294044EF602491AE2604A69FF106C2BD7392CD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

UmVtb3ZlIHRoZSBjbGtfcHJlcGFyZSBmcm9tIG10a19kaXNwX3B3bV9wcm9iZS4NClJlbW92ZSB0
aGUgY2xrX3VucHJlcGFyZSBmcm9tIG10a19kaXNwX3B3bV9yZW1vdmUuDQoNClNpZ25lZC1vZmYt
Ynk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcHdt
L3B3bS1tdGstZGlzcC5jIHwgMjMgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIGIvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMNCmlu
ZGV4IDg3YzZiNGJjNWQ0My4uMjE0MTZhOGI2YjQ3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wd20v
cHdtLW10ay1kaXNwLmMNCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQpAQCAtMTky
LDE0ICsxOTIsNiBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoSVNfRVJSKG1kcC0+Y2xrX21tKSkNCiAJCXJldHVybiBQ
VFJfRVJSKG1kcC0+Y2xrX21tKTsNCiANCi0JcmV0ID0gY2xrX3ByZXBhcmUobWRwLT5jbGtfbWFp
bik7DQotCWlmIChyZXQgPCAwKQ0KLQkJcmV0dXJuIHJldDsNCi0NCi0JcmV0ID0gY2xrX3ByZXBh
cmUobWRwLT5jbGtfbW0pOw0KLQlpZiAocmV0IDwgMCkNCi0JCWdvdG8gZGlzYWJsZV9jbGtfbWFp
bjsNCi0NCiAJbWRwLT5jaGlwLmRldiA9ICZwZGV2LT5kZXY7DQogCW1kcC0+Y2hpcC5vcHMgPSAm
bXRrX2Rpc3BfcHdtX29wczsNCiAJbWRwLT5jaGlwLmJhc2UgPSAtMTsNCkBAIC0yMDgsNyArMjAw
LDcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiAJcmV0ID0gcHdtY2hpcF9hZGQoJm1kcC0+Y2hpcCk7DQogCWlmIChyZXQgPCAw
KSB7DQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJwd21jaGlwX2FkZCgpIGZhaWxlZDogJWRcbiIs
IHJldCk7DQotCQlnb3RvIGRpc2FibGVfY2xrX21tOw0KKwkJcmV0dXJuIHJldDsNCiAJfQ0KIA0K
IAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBtZHApOw0KQEAgLTIyNywyNCArMjE5LDEzIEBA
IHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQogCX0NCiANCiAJcmV0dXJuIDA7DQotDQotZGlzYWJsZV9jbGtfbW06DQotCWNsa191bnBy
ZXBhcmUobWRwLT5jbGtfbW0pOw0KLWRpc2FibGVfY2xrX21haW46DQotCWNsa191bnByZXBhcmUo
bWRwLT5jbGtfbWFpbik7DQotCXJldHVybiByZXQ7DQogfQ0KIA0KIHN0YXRpYyBpbnQgbXRrX2Rp
c3BfcHdtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0
IG10a19kaXNwX3B3bSAqbWRwID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQotCWludCBy
ZXQ7DQotDQotCXJldCA9IHB3bWNoaXBfcmVtb3ZlKCZtZHAtPmNoaXApOw0KLQljbGtfdW5wcmVw
YXJlKG1kcC0+Y2xrX21tKTsNCi0JY2xrX3VucHJlcGFyZShtZHAtPmNsa19tYWluKTsNCiANCi0J
cmV0dXJuIHJldDsNCisJcmV0dXJuIHB3bWNoaXBfcmVtb3ZlKCZtZHAtPmNoaXApOw0KIH0NCiAN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19wd21fZGF0YSBtdDI3MDFfcHdtX2RhdGEgPSB7DQot
LSANCjIuMTIuNQ0K

