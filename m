Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB711FEB2
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 08:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLPHB3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 02:01:29 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52398 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbfLPHB3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 02:01:29 -0500
X-UUID: 69b6c4e6f95545c5ae37d3163a9b228c-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+cszjkyUuOZ7eflxtlQe0Jp08sHDi2pjkZ4Zw/w5l98=;
        b=VWrMdcQn8i+h5Vn4cJxZSK6SLn/lPi44Y2uW2VJCSD8wY7MqXu1Vt8e0oU+UxT4YG82ENcK0gT5pKKXNrBcQcSAoworRMK9fs9TCLtsSBQJ+su9D2Mz4XR45njmcNbB/a+8TbRE4L9lW/FoiCQ3p8TuToSXFKBnUQGRnLzwgz3o=;
X-UUID: 69b6c4e6f95545c5ae37d3163a9b228c-20191216
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 344917482; Mon, 16 Dec 2019 15:01:23 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Dec
 2019 15:00:26 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Dec 2019 15:01:03 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 1/2] pwm: fine tune pwm-mtk-disp clock control flow
Date:   Mon, 16 Dec 2019 15:01:22 +0800
Message-ID: <20191216070123.114719-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216070123.114719-1-jitao.shi@mediatek.com>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1BAE11332BEABED0D832FD48DEEE92CF296B6C98B0B23F7CECA64A1ED7C9141E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

TWF0Y2ggcHdtIGNsb2NrIHdoZW4gc3VzcGVuZCBhbmQgcmVzdW1lLg0KUHJlcGFyZSBhbmQgZW5h
YmxlIGRpc3BfcHdtIGNsb2NrIHdoZW4gZGlzcF9wd20gZW5hYmxlLg0KRGlzYWJsZSBhbmQgdW5w
cmVwYXJlIGRpc3BfcHdtIGNsb2NrIHdoZW4gZGlzcF9wd20gZGlzYWJsZS4NCg0KU2lnbmVkLW9m
Zi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9w
d20vcHdtLW10ay1kaXNwLmMgfCA0MyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIGIvZHJpdmVycy9wd20v
cHdtLW10ay1kaXNwLmMNCmluZGV4IDgzYjhiZTAyMDliNy4uYzdiMTRhY2M5MzE2IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMNCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1t
dGstZGlzcC5jDQpAQCAtOTgsMTMgKzk4LDEzIEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX2Nv
bmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQogCWhp
Z2hfd2lkdGggPSBkaXY2NF91NjQocmF0ZSAqIGR1dHlfbnMsIGRpdik7DQogCXZhbHVlID0gcGVy
aW9kIHwgKGhpZ2hfd2lkdGggPDwgUFdNX0hJR0hfV0lEVEhfU0hJRlQpOw0KIA0KLQllcnIgPSBj
bGtfZW5hYmxlKG1kcC0+Y2xrX21haW4pOw0KKwllcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUobWRw
LT5jbGtfbWFpbik7DQogCWlmIChlcnIgPCAwKQ0KIAkJcmV0dXJuIGVycjsNCiANCi0JZXJyID0g
Y2xrX2VuYWJsZShtZHAtPmNsa19tbSk7DQorCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShtZHAt
PmNsa19tbSk7DQogCWlmIChlcnIgPCAwKSB7DQotCQljbGtfZGlzYWJsZShtZHAtPmNsa19tYWlu
KTsNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19tYWluKTsNCiAJCXJldHVybiBl
cnI7DQogCX0NCiANCkBAIC0xMjQsOCArMTI0LDggQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21f
Y29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJ
CQkJCSAweDApOw0KIAl9DQogDQotCWNsa19kaXNhYmxlKG1kcC0+Y2xrX21tKTsNCi0JY2xrX2Rp
c2FibGUobWRwLT5jbGtfbWFpbik7DQorCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19t
bSk7DQorCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19tYWluKTsNCiANCiAJcmV0dXJu
IDA7DQogfQ0KQEAgLTEzNSwxMyArMTM1LDEzIEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX2Vu
YWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20pDQogCXN0
cnVjdCBtdGtfZGlzcF9wd20gKm1kcCA9IHRvX210a19kaXNwX3B3bShjaGlwKTsNCiAJaW50IGVy
cjsNCiANCi0JZXJyID0gY2xrX2VuYWJsZShtZHAtPmNsa19tYWluKTsNCisJZXJyID0gY2xrX3By
ZXBhcmVfZW5hYmxlKG1kcC0+Y2xrX21haW4pOw0KIAlpZiAoZXJyIDwgMCkNCiAJCXJldHVybiBl
cnI7DQogDQotCWVyciA9IGNsa19lbmFibGUobWRwLT5jbGtfbW0pOw0KKwllcnIgPSBjbGtfcHJl
cGFyZV9lbmFibGUobWRwLT5jbGtfbW0pOw0KIAlpZiAoZXJyIDwgMCkgew0KLQkJY2xrX2Rpc2Fi
bGUobWRwLT5jbGtfbWFpbik7DQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUobWRwLT5jbGtfbWFp
bik7DQogCQlyZXR1cm4gZXJyOw0KIAl9DQogDQpAQCAtMTU4LDggKzE1OCw4IEBAIHN0YXRpYyB2
b2lkIG10a19kaXNwX3B3bV9kaXNhYmxlKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3
bV9kZXZpY2UgKnB3bSkNCiAJbXRrX2Rpc3BfcHdtX3VwZGF0ZV9iaXRzKG1kcCwgRElTUF9QV01f
RU4sIG1kcC0+ZGF0YS0+ZW5hYmxlX21hc2ssDQogCQkJCSAweDApOw0KIA0KLQljbGtfZGlzYWJs
ZShtZHAtPmNsa19tbSk7DQotCWNsa19kaXNhYmxlKG1kcC0+Y2xrX21haW4pOw0KKwljbGtfZGlz
YWJsZV91bnByZXBhcmUobWRwLT5jbGtfbW0pOw0KKwljbGtfZGlzYWJsZV91bnByZXBhcmUobWRw
LT5jbGtfbWFpbik7DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHdtX29wcyBtdGtfZGlz
cF9wd21fb3BzID0gew0KQEAgLTE5NCwxNCArMTk0LDYgQEAgc3RhdGljIGludCBtdGtfZGlzcF9w
d21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKElTX0VSUihtZHAt
PmNsa19tbSkpDQogCQlyZXR1cm4gUFRSX0VSUihtZHAtPmNsa19tbSk7DQogDQotCXJldCA9IGNs
a19wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0KLQlpZiAocmV0IDwgMCkNCi0JCXJldHVybiByZXQ7
DQotDQotCXJldCA9IGNsa19wcmVwYXJlKG1kcC0+Y2xrX21tKTsNCi0JaWYgKHJldCA8IDApDQot
CQlnb3RvIGRpc2FibGVfY2xrX21haW47DQotDQogCW1kcC0+Y2hpcC5kZXYgPSAmcGRldi0+ZGV2
Ow0KIAltZHAtPmNoaXAub3BzID0gJm10a19kaXNwX3B3bV9vcHM7DQogCW1kcC0+Y2hpcC5iYXNl
ID0gLTE7DQpAQCAtMjEwLDcgKzIwMiw3IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldCA9IHB3bWNoaXBfYWRkKCZtZHAt
PmNoaXApOw0KIAlpZiAocmV0IDwgMCkgew0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAicHdtY2hp
cF9hZGQoKSBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KLQkJZ290byBkaXNhYmxlX2Nsa19tbTsNCisJ
CXJldHVybiByZXQ7DQogCX0NCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWRwKTsN
CkBAIC0yMjksMjQgKzIyMSwxMyBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAl9DQogDQogCXJldHVybiAwOw0KLQ0KLWRpc2Fi
bGVfY2xrX21tOg0KLQljbGtfdW5wcmVwYXJlKG1kcC0+Y2xrX21tKTsNCi1kaXNhYmxlX2Nsa19t
YWluOg0KLQljbGtfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0KLQlyZXR1cm4gcmV0Ow0KIH0N
CiANCiBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiB7DQogCXN0cnVjdCBtdGtfZGlzcF9wd20gKm1kcCA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHBkZXYpOw0KLQlpbnQgcmV0Ow0KLQ0KLQlyZXQgPSBwd21jaGlwX3JlbW92ZSgmbWRw
LT5jaGlwKTsNCi0JY2xrX3VucHJlcGFyZShtZHAtPmNsa19tbSk7DQotCWNsa191bnByZXBhcmUo
bWRwLT5jbGtfbWFpbik7DQogDQotCXJldHVybiByZXQ7DQorCXJldHVybiBwd21jaGlwX3JlbW92
ZSgmbWRwLT5jaGlwKTsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfcHdtX2RhdGEg
bXQyNzAxX3B3bV9kYXRhID0gew0KLS0gDQoyLjIxLjANCg==

