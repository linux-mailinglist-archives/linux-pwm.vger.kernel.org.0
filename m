Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EBC3D464F
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jul 2021 10:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhGXHig (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Jul 2021 03:38:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234853AbhGXHif (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Jul 2021 03:38:35 -0400
X-UUID: 66f4895c0d4b45ce8ae2212ca1067df7-20210724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oz8R6JzK/dsLcXIYjmpTj+oBt2JJQ5u816nXyN6D10Q=;
        b=IInVGTfxFKK/kwhZh6NBWauSj7SH+RAMxhrDQxjLoAuFOr/MIWapDZ5uNQTlIcnXjWh0sFMVDmRch/hwFAcB0GrKGxc+hLdnfdVfLs0Hf9w9JnBbdd94v3yDspoGykawCOOw1B8M2uEegY7Ka3BLcRrQTECOAlt/r65ohM5nn0w=;
X-UUID: 66f4895c0d4b45ce8ae2212ca1067df7-20210724
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 555332565; Sat, 24 Jul 2021 16:19:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 24 Jul
 2021 16:18:55 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 24 Jul 2021 16:18:54 +0800
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
Subject: [PATCH v6 4/5] pwm: mtk_disp: fix overflow in period and duty calcalation
Date:   Sat, 24 Jul 2021 16:18:48 +0800
Message-ID: <20210724081849.182108-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724081849.182108-1-jitao.shi@mediatek.com>
References: <20210724081849.182108-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 00542DEEE62E7D67BBB1D34FA5DE6387FF294617A841F8A5F6153D1AF11FE15A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q3VycmVudCBjYWxjdWxhdGlvbiBmb3IgcGVyaW9kIGFuZCBoaWdoX3dpZHRoIG1heSBoYXZlDQo2
NC1iaXQgb3ZlcmZsb3cuIHN0YXRlLT5wZXJpb2QgYW5kIHJhdGUgYXJlIHU2NC4NCnJhdGUgKiBz
dGF0ZS0+cGVyaW9kIHdpbGwgb3ZlcmZsb3cuDQoNCmNsa19kaXYgPSBkaXZfdTY0KHJhdGUgKiBz
dGF0ZS0+cGVyaW9kLCBOU0VDX1BFUl9TRUMpDQpwZXJpb2QgPSBkaXY2NF91NjQocmF0ZSAqIHN0
YXRlLT5wZXJpb2QsIGRpdik7DQpoaWdoX3dpZHRoID0gZGl2NjRfdTY0KHJhdGUgKiBzdGF0ZS0+
ZHV0eV9jeWNsZSwgZGl2KTsNCg0KVGhpcyBwYXRjaCBpcyB0byByZXNvbHZlIGl0IGJ5IHVzaW5n
IG11bF91NjRfdTY0X2Rpdl91NjQoKS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRh
by5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCA2
ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdt
L3B3bS1tdGstZGlzcC5jDQppbmRleCA1OTlkN2RkOGVjYWIuLjRmNmRlNmYyNDQ4NCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20t
bXRrLWRpc3AuYw0KQEAgLTExNiw3ICsxMTYsNyBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9h
cHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQogCSAq
IGhpZ2hfd2lkdGggPSAoUFdNX0NMS19SQVRFICogZHV0eV9ucykgLyAoMTBeOSAqIChjbGtfZGl2
ICsgMSkpDQogCSAqLw0KIAlyYXRlID0gY2xrX2dldF9yYXRlKG1kcC0+Y2xrX21haW4pOw0KLQlj
bGtfZGl2ID0gZGl2X3U2NChyYXRlICogc3RhdGUtPnBlcmlvZCwgTlNFQ19QRVJfU0VDKSA+Pg0K
KwljbGtfZGl2ID0gbXVsX3U2NF91NjRfZGl2X3U2NChzdGF0ZS0+cGVyaW9kLCByYXRlLCBOU0VD
X1BFUl9TRUMpID4+DQogCQkJICBQV01fUEVSSU9EX0JJVF9XSURUSDsNCiAJaWYgKGNsa19kaXYg
PiBQV01fQ0xLRElWX01BWCkgew0KIAkJaWYgKCFtZHAtPmVuYWJsZWQpIHsNCkBAIC0xMjcsMTEg
KzEyNywxMSBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9hcHBseShzdHJ1Y3QgcHdtX2NoaXAg
KmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQogCX0NCiANCiAJZGl2ID0gTlNFQ19QRVJf
U0VDICogKGNsa19kaXYgKyAxKTsNCi0JcGVyaW9kID0gZGl2NjRfdTY0KHJhdGUgKiBzdGF0ZS0+
cGVyaW9kLCBkaXYpOw0KKwlwZXJpb2QgPSBtdWxfdTY0X3U2NF9kaXZfdTY0KHN0YXRlLT5wZXJp
b2QsIHJhdGUsIGRpdik7DQogCWlmIChwZXJpb2QgPiAwKQ0KIAkJcGVyaW9kLS07DQogDQotCWhp
Z2hfd2lkdGggPSBkaXY2NF91NjQocmF0ZSAqIHN0YXRlLT5kdXR5X2N5Y2xlLCBkaXYpOw0KKwlo
aWdoX3dpZHRoID0gbXVsX3U2NF91NjRfZGl2X3U2NChzdGF0ZS0+ZHV0eV9jeWNsZSwgcmF0ZSwg
ZGl2KTsNCiAJdmFsdWUgPSBwZXJpb2QgfCAoaGlnaF93aWR0aCA8PCBQV01fSElHSF9XSURUSF9T
SElGVCk7DQogDQogCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+Y29u
MCwNCi0tIA0KMi4yNS4xDQo=

