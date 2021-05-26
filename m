Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF34390E72
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhEZCu3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 22:50:29 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:49423 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230157AbhEZCu3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 22:50:29 -0400
X-UUID: 25d36622d6c44af498e08984b3cf9757-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1U46B7Bl7bjwl0Eqjg0kYMe2AujHOPWtzQx1mw4esww=;
        b=JJ/GiDbjmIh2aVThmSl95Dq6s/4d5g+OWxwCJf0ePJ4yNdc3b/PejNSvAklyZOy1+k49moxTyxaljFMkVfYCdrAFKVEmqTdw5YJnra9VWpaUJa9P2OzC/nQZDbuovEeJ9sSTZksu3MDY5Wz9jF/8vzE8o7j29bcYOwqQzK+8AHI=;
X-UUID: 25d36622d6c44af498e08984b3cf9757-20210526
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 261370762; Wed, 26 May 2021 10:48:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 10:48:51 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 26 May 2021 10:48:50 +0800
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
Subject: [PATCH v3 3/3] pwm: mtk_disp: implement atomic API .get_state()
Date:   Wed, 26 May 2021 10:48:46 +0800
Message-ID: <20210526024846.120838-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210526024846.120838-1-jitao.shi@mediatek.com>
References: <20210526024846.120838-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4FDB6116F4B55DB7826D226E8689B2C78A0F2CC440C7A178632882E9BB30287C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlLUlkOiBJZTE2MThiOTBlNzc5ODlhZTU1OGY1OTU1NGQ1NWQwZDE4NzU0YjA5MQ0KU2ln
bmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlz
cC5jDQppbmRleCA5Yzk1YjlhZjQxN2YuLmQ3NTM1ZjI0MzY0YSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYw0K
QEAgLTE3OSw4ICsxNzksNTIgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fYXBwbHkoc3RydWN0
IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KIAlyZXR1cm4gbXRrX2Rp
c3BfcHdtX2VuYWJsZShjaGlwLCBzdGF0ZSk7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIG10a19kaXNw
X3B3bV9nZXRfc3RhdGUoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KKwkJCQkgICBzdHJ1Y3QgcHdt
X2RldmljZSAqcHdtLA0KKwkJCQkgICBzdHJ1Y3QgcHdtX3N0YXRlICpzdGF0ZSkNCit7DQorCXN0
cnVjdCBtdGtfZGlzcF9wd20gKm1kcCA9IHRvX210a19kaXNwX3B3bShjaGlwKTsNCisJdTMyIGNs
a19kaXYsIHBlcmlvZCwgaGlnaF93aWR0aCwgY29uMCwgY29uMTsNCisJdTY0IHJhdGU7DQorCWlu
dCBlcnI7DQorDQorCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShtZHAtPmNsa19tYWluKTsNCisJ
aWYgKGVyciA8IDApIHsNCisJCWRldl9lcnIoY2hpcC0+ZGV2LCAiQ2FuJ3QgZW5hYmxlIG1kcC0+
Y2xrX21haW46ICVkXG4iLCBlcnIpOw0KKwkJcmV0dXJuOw0KKwl9DQorCWVyciA9IGNsa19wcmVw
YXJlX2VuYWJsZShtZHAtPmNsa19tbSk7DQorCWlmIChlcnIgPCAwKSB7DQorCQlkZXZfZXJyKGNo
aXAtPmRldiwgIkNhbid0IGVuYWJsZSBtZHAtPmNsa19tbTogJWRcbiIsIGVycik7DQorCQljbGtf
ZGlzYWJsZV91bnByZXBhcmUobWRwLT5jbGtfbWFpbik7DQorCQlyZXR1cm47DQorCX0NCisNCisJ
cmF0ZSA9IGNsa19nZXRfcmF0ZShtZHAtPmNsa19tYWluKTsNCisNCisJY29uMCA9IHJlYWRsKG1k
cC0+YmFzZSArIG1kcC0+ZGF0YS0+Y29uMCk7DQorCWNvbjEgPSByZWFkbChtZHAtPmJhc2UgKyBt
ZHAtPmRhdGEtPmNvbjEpOw0KKw0KKwlzdGF0ZS0+cG9sYXJpdHkgPSBjb24wICYgUFdNX1BPTEFS
SVRZID8NCisJCQkgIFBXTV9QT0xBUklUWV9JTlZFUlNFRCA6IFBXTV9QT0xBUklUWV9OT1JNQUw7
DQorCXN0YXRlLT5lbmFibGVkID0gISEoY29uMCAmIEJJVCgwKSk7DQorDQorCWNsa19kaXYgPSAo
Y29uMCAmIFBXTV9DTEtESVZfTUFTSykgPj4gUFdNX0NMS0RJVl9TSElGVDsNCisJcGVyaW9kID0g
Y29uMSAmIFBXTV9QRVJJT0RfTUFTSzsNCisJc3RhdGUtPnBlcmlvZCA9IGRpdl91NjQocGVyaW9k
ICogKGNsa19kaXYgKyAxKSAqIE5TRUNfUEVSX1NFQywgcmF0ZSk7DQorCWhpZ2hfd2lkdGggPSAo
Y29uMSAmIFBXTV9ISUdIX1dJRFRIX01BU0spID4+IFBXTV9ISUdIX1dJRFRIX1NISUZUOw0KKwlz
dGF0ZS0+ZHV0eV9jeWNsZSA9IGRpdl91NjQoaGlnaF93aWR0aCAqIChjbGtfZGl2ICsgMSkgKiBO
U0VDX1BFUl9TRUMsDQorCQkJCSAgICByYXRlKTsNCisNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KG1kcC0+Y2xrX21tKTsNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0K
Kw0KKwltZHAtPmVuYWJsZWQgPSBzdGF0ZS0+ZW5hYmxlZDsNCit9DQorDQogc3RhdGljIGNvbnN0
IHN0cnVjdCBwd21fb3BzIG10a19kaXNwX3B3bV9vcHMgPSB7DQogCS5hcHBseSA9IG10a19kaXNw
X3B3bV9hcHBseSwNCisJLmdldF9zdGF0ZSA9IG10a19kaXNwX3B3bV9nZXRfc3RhdGUsDQogCS5v
d25lciA9IFRISVNfTU9EVUxFLA0KIH07DQogDQotLSANCjIuMjUuMQ0K

