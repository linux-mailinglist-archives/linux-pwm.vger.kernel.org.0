Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC913A956A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jun 2021 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFPI43 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Jun 2021 04:56:29 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28442 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231335AbhFPI42 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Jun 2021 04:56:28 -0400
X-UUID: 6ee28432b9144a47bf92933e8c4d3a35-20210616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/JVhARZuJ57Dw+4fOKCsb1YM6XDl38WEyUL7iSXsfVA=;
        b=QHJtbg7pH7rFxB3eveIDrlrstxBedPKc92FUKpsCPtFJvJEGc788/XvzDYtsjuKStB1BS1+G0+jlMeT1XzoeKvmwO5EfCxK3vlFMGWpDiP7eM/LmmAuR2SbemF5o/WNAuNybtrZQZX0aAaOTgKmyA86G50S6P3tKA7mtDMzi4zY=;
X-UUID: 6ee28432b9144a47bf92933e8c4d3a35-20210616
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 472236657; Wed, 16 Jun 2021 16:54:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 16:54:17 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 16 Jun 2021 16:54:16 +0800
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
Subject: [PATCH v5 2/3] pwm: mtk_disp: implement atomic API .apply()
Date:   Wed, 16 Jun 2021 16:52:23 +0800
Message-ID: <20210616085224.157318-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616085224.157318-1-jitao.shi@mediatek.com>
References: <20210616085224.157318-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8778E6DC5881AEC1A3423F979C3A06474028CD6F8F10002821B84EE58CF337632000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

U3dpdGNoIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgLmFwcGx5KCkgbWV0aG9kLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyB8IDY5ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgYi9kcml2ZXJz
L3B3bS9wd20tbXRrLWRpc3AuYw0KaW5kZXggMjA0ZDc2YmVlYjI2Li5hNDc2NmU5MzFiNjggMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYw0KKysrIGIvZHJpdmVycy9wd20v
cHdtLW10ay1kaXNwLmMNCkBAIC02NywxNCArNjcsMjUgQEAgc3RhdGljIHZvaWQgbXRrX2Rpc3Bf
cHdtX3VwZGF0ZV9iaXRzKHN0cnVjdCBtdGtfZGlzcF9wd20gKm1kcCwgdTMyIG9mZnNldCwNCiAJ
d3JpdGVsKHZhbHVlLCBhZGRyZXNzKTsNCiB9DQogDQotc3RhdGljIGludCBtdGtfZGlzcF9wd21f
Y29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCi0J
CQkgICAgICAgaW50IGR1dHlfbnMsIGludCBwZXJpb2RfbnMpDQorc3RhdGljIGludCBtdGtfZGlz
cF9wd21fYXBwbHkoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdt
LA0KKwkJCSAgICAgIGNvbnN0IHN0cnVjdCBwd21fc3RhdGUgKnN0YXRlKQ0KIHsNCiAJc3RydWN0
IG10a19kaXNwX3B3bSAqbWRwID0gdG9fbXRrX2Rpc3BfcHdtKGNoaXApOw0KIAl1MzIgY2xrX2Rp
diwgcGVyaW9kLCBoaWdoX3dpZHRoLCB2YWx1ZTsNCiAJdTY0IGRpdiwgcmF0ZTsNCiAJaW50IGVy
cjsNCiANCisJaWYgKCFzdGF0ZS0+ZW5hYmxlZCkgew0KKwkJbXRrX2Rpc3BfcHdtX3VwZGF0ZV9i
aXRzKG1kcCwgRElTUF9QV01fRU4sIG1kcC0+ZGF0YS0+ZW5hYmxlX21hc2ssDQorCQkJCQkgMHgw
KTsNCisJCWlmIChtZHAtPmVuYWJsZWQpIHsNCisJCQljbGtfZGlzYWJsZV91bnByZXBhcmUobWRw
LT5jbGtfbW0pOw0KKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19tYWluKTsNCisJ
CX0NCisJCW1kcC0+ZW5hYmxlZCA9IGZhbHNlOw0KKwkJcmV0dXJuIDA7DQorCX0NCisNCiAJaWYg
KCFtZHAtPmVuYWJsZWQpIHsNCiAJCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShtZHAtPmNsa19t
YWluKTsNCiAJCWlmIChlcnIgPCAwKSB7DQpAQCAtMTAyLDcgKzExMyw3IEBAIHN0YXRpYyBpbnQg
bXRrX2Rpc3BfcHdtX2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2
aWNlICpwd20sDQogCSAqIGhpZ2hfd2lkdGggPSAoUFdNX0NMS19SQVRFICogZHV0eV9ucykgLyAo
MTBeOSAqIChjbGtfZGl2ICsgMSkpDQogCSAqLw0KIAlyYXRlID0gY2xrX2dldF9yYXRlKG1kcC0+
Y2xrX21haW4pOw0KLQljbGtfZGl2ID0gZGl2X3U2NChyYXRlICogcGVyaW9kX25zLCBOU0VDX1BF
Ul9TRUMpID4+DQorCWNsa19kaXYgPSBkaXZfdTY0KHJhdGUgKiBzdGF0ZS0+cGVyaW9kLCBOU0VD
X1BFUl9TRUMpID4+DQogCQkJICBQV01fUEVSSU9EX0JJVF9XSURUSDsNCiAJaWYgKGNsa19kaXYg
PiBQV01fQ0xLRElWX01BWCkgew0KIAkJaWYgKCFtZHAtPmVuYWJsZWQpIHsNCkBAIC0xMTIsMTEg
KzEyMywxMSBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlw
ICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0N
CiAJZGl2ID0gTlNFQ19QRVJfU0VDICogKGNsa19kaXYgKyAxKTsNCi0JcGVyaW9kID0gZGl2NjRf
dTY0KHJhdGUgKiBwZXJpb2RfbnMsIGRpdik7DQorCXBlcmlvZCA9IGRpdjY0X3U2NChyYXRlICog
c3RhdGUtPnBlcmlvZCwgZGl2KTsNCiAJaWYgKHBlcmlvZCA+IDApDQogCQlwZXJpb2QtLTsNCiAN
Ci0JaGlnaF93aWR0aCA9IGRpdjY0X3U2NChyYXRlICogZHV0eV9ucywgZGl2KTsNCisJaGlnaF93
aWR0aCA9IGRpdjY0X3U2NChyYXRlICogc3RhdGUtPmR1dHlfY3ljbGUsIGRpdik7DQogCXZhbHVl
ID0gcGVyaW9kIHwgKGhpZ2hfd2lkdGggPDwgUFdNX0hJR0hfV0lEVEhfU0hJRlQpOw0KIA0KIAlt
dGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAsDQpAQCAtMTQxLDM2
ICsxNTIsNiBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlw
ICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KIAkJCQkJIG1kcC0+ZGF0YS0+Y29uMF9z
ZWwsDQogCQkJCQkgbWRwLT5kYXRhLT5jb24wX3NlbCk7DQogCX0NCi0NCi0JaWYgKCFtZHAtPmVu
YWJsZWQpIHsNCi0JCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19tbSk7DQotCQljbGtf
ZGlzYWJsZV91bnByZXBhcmUobWRwLT5jbGtfbWFpbik7DQotCX0NCi0NCi0JcmV0dXJuIDA7DQot
fQ0KLQ0KLXN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX2VuYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNo
aXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20pDQotew0KLQlzdHJ1Y3QgbXRrX2Rpc3BfcHdtICpt
ZHAgPSB0b19tdGtfZGlzcF9wd20oY2hpcCk7DQotCWludCBlcnI7DQotDQotCWlmICghbWRwLT5l
bmFibGVkKSB7DQotCQllcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUobWRwLT5jbGtfbWFpbik7DQot
CQlpZiAoZXJyIDwgMCkgew0KLQkJCWRldl9lcnIoY2hpcC0+ZGV2LCAiQ2FuJ3QgZW5hYmxlIG1k
cC0+Y2xrX21haW46ICVwZVxuIiwNCi0JCQkJRVJSX1BUUihlcnIpKTsNCi0JCQlyZXR1cm4gZXJy
Ow0KLQkJfQ0KLQkJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKG1kcC0+Y2xrX21tKTsNCi0JCWlm
IChlcnIgPCAwKSB7DQotCQkJZGV2X2VycihjaGlwLT5kZXYsICJDYW4ndCBlbmFibGUgbWRwLT5j
bGtfbW06ICVwZVxuIiwNCi0JCQkJRVJSX1BUUihlcnIpKTsNCi0JCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUobWRwLT5jbGtfbWFpbik7DQotCQkJcmV0dXJuIGVycjsNCi0JCX0NCi0JfQ0KLQ0KIAlt
dGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBESVNQX1BXTV9FTiwgbWRwLT5kYXRhLT5lbmFi
bGVfbWFzaywNCiAJCQkJIG1kcC0+ZGF0YS0+ZW5hYmxlX21hc2spOw0KIAltZHAtPmVuYWJsZWQg
PSB0cnVlOw0KQEAgLTE3OCwyNCArMTU5LDggQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fZW5h
YmxlKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSkNCiAJcmV0
dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIG10a19kaXNwX3B3bV9kaXNhYmxlKHN0cnVjdCBw
d21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSkNCi17DQotCXN0cnVjdCBtdGtf
ZGlzcF9wd20gKm1kcCA9IHRvX210a19kaXNwX3B3bShjaGlwKTsNCi0NCi0JbXRrX2Rpc3BfcHdt
X3VwZGF0ZV9iaXRzKG1kcCwgRElTUF9QV01fRU4sIG1kcC0+ZGF0YS0+ZW5hYmxlX21hc2ssDQot
CQkJCSAweDApOw0KLQ0KLQlpZiAobWRwLT5lbmFibGVkKSB7DQotCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUobWRwLT5jbGtfbW0pOw0KLQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21h
aW4pOw0KLQl9DQotCW1kcC0+ZW5hYmxlZCA9IGZhbHNlOw0KLX0NCi0NCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHB3bV9vcHMgbXRrX2Rpc3BfcHdtX29wcyA9IHsNCi0JLmNvbmZpZyA9IG10a19kaXNw
X3B3bV9jb25maWcsDQotCS5lbmFibGUgPSBtdGtfZGlzcF9wd21fZW5hYmxlLA0KLQkuZGlzYWJs
ZSA9IG10a19kaXNwX3B3bV9kaXNhYmxlLA0KKwkuYXBwbHkgPSBtdGtfZGlzcF9wd21fYXBwbHks
DQogCS5vd25lciA9IFRISVNfTU9EVUxFLA0KIH07DQogDQotLSANCjIuMjUuMQ0K

