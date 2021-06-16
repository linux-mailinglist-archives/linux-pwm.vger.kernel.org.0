Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F333A956D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jun 2021 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhFPI4d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Jun 2021 04:56:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55379 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231335AbhFPI4d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Jun 2021 04:56:33 -0400
X-UUID: a6071b1f0abe432a9cfe1a05c72d3c7c-20210616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AXElBXbtTIV7kOa1ImSC9TOOYMbfTQra4QqOyt/B34E=;
        b=Sfn8m/wsndP1rMUaUFBldHiM72/UDJ7pHpZyTb+MJcz2FtPl64RUQ4f7eF2u5NUSx1blqtSeKash3zjqma4BkMmoPYH+2h1Zpg0KWn6EIbIhQbYWsFOa9zCNywRGRikPv42ng3llETaBLuEIVKgLhDw9Ngr866dao/PwPCV0svc=;
X-UUID: a6071b1f0abe432a9cfe1a05c72d3c7c-20210616
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1140021566; Wed, 16 Jun 2021 16:54:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 16:54:20 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 16 Jun 2021 16:54:19 +0800
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
Subject: [PATCH v5 3/3] pwm: mtk_disp: implement atomic API .get_state()
Date:   Wed, 16 Jun 2021 16:52:24 +0800
Message-ID: <20210616085224.157318-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616085224.157318-1-jitao.shi@mediatek.com>
References: <20210616085224.157318-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0C37CFED5B1E1D54DFBEC98F011F3896F16D2A5E4F950A0C8F029A10444253912000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

U3dpdGNoIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgLmdldF9zdGF0ZSgpIG1ldGhvZC4NCg0K
U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdtL3B3bS1tdGst
ZGlzcC5jDQppbmRleCBhNDc2NmU5MzFiNjguLmQ2MGE2YjM3OTY4MyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3Au
Yw0KQEAgLTE1OSw4ICsxNTksNDcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fYXBwbHkoc3Ry
dWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KIAlyZXR1cm4gMDsN
CiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2Rpc3BfcHdtX2dldF9zdGF0ZShzdHJ1Y3QgcHdtX2No
aXAgKmNoaXAsDQorCQkJCSAgIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQorCQkJCSAgIHN0cnVj
dCBwd21fc3RhdGUgKnN0YXRlKQ0KK3sNCisJc3RydWN0IG10a19kaXNwX3B3bSAqbWRwID0gdG9f
bXRrX2Rpc3BfcHdtKGNoaXApOw0KKwl1MzIgY2xrX2RpdiwgY29uMCwgY29uMTsNCisJdTY0IHJh
dGUsIHBlcmlvZCwgaGlnaF93aWR0aDsNCisJaW50IGVycjsNCisNCisJaWYgKCFtZHAtPmVuYWJs
ZWQpIHsNCisJCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShtZHAtPmNsa19tYWluKTsNCisJCWlm
IChlcnIgPCAwKSB7DQorCQkJZGV2X2VycihjaGlwLT5kZXYsICJDYW4ndCBlbmFibGUgbWRwLT5j
bGtfbWFpbjogJXBlXG4iLCBFUlJfUFRSKGVycikpOw0KKwkJCXJldHVybjsNCisJCX0NCisJCWVy
ciA9IGNsa19wcmVwYXJlX2VuYWJsZShtZHAtPmNsa19tbSk7DQorCQlpZiAoZXJyIDwgMCkgew0K
KwkJCWRldl9lcnIoY2hpcC0+ZGV2LCAiQ2FuJ3QgZW5hYmxlIG1kcC0+Y2xrX21tOiAlcGVcbiIs
IEVSUl9QVFIoZXJyKSk7DQorCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4p
Ow0KKwkJCXJldHVybjsNCisJCX0NCisJfQ0KKwlyYXRlID0gY2xrX2dldF9yYXRlKG1kcC0+Y2xr
X21haW4pOw0KKwljb24wID0gcmVhZGwobWRwLT5iYXNlICsgbWRwLT5kYXRhLT5jb24wKTsNCisJ
Y29uMSA9IHJlYWRsKG1kcC0+YmFzZSArIG1kcC0+ZGF0YS0+Y29uMSk7DQorCXN0YXRlLT5lbmFi
bGVkID0gISEoY29uMCAmIEJJVCgwKSk7DQorCWNsa19kaXYgPSBGSUVMRF9HRVQoUFdNX0NMS0RJ
Vl9NQVNLLCBjb24wKTsNCisJcGVyaW9kID0gY29uMSAmIFBXTV9QRVJJT0RfTUFTSzsNCisJc3Rh
dGUtPnBlcmlvZCA9IERJVjY0X1U2NF9ST1VORF9VUChwZXJpb2QgKiAoY2xrX2RpdiArIDEpICog
TlNFQ19QRVJfU0VDLCByYXRlKTsNCisJaGlnaF93aWR0aCA9IEZJRUxEX0dFVChQV01fSElHSF9X
SURUSF9NQVNLLCBjb24xKTsNCisJc3RhdGUtPmR1dHlfY3ljbGUgPSBESVY2NF9VNjRfUk9VTkRf
VVAoaGlnaF93aWR0aCAqIChjbGtfZGl2ICsgMSkgKiBOU0VDX1BFUl9TRUMsDQorCQkJCQkgICAg
ICAgcmF0ZSk7DQorCWlmICghbWRwLT5lbmFibGVkKSB7DQorCQljbGtfZGlzYWJsZV91bnByZXBh
cmUobWRwLT5jbGtfbW0pOw0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4p
Ow0KKwl9DQorfQ0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHdtX29wcyBtdGtfZGlzcF9wd21f
b3BzID0gew0KIAkuYXBwbHkgPSBtdGtfZGlzcF9wd21fYXBwbHksDQorCS5nZXRfc3RhdGUgPSBt
dGtfZGlzcF9wd21fZ2V0X3N0YXRlLA0KIAkub3duZXIgPSBUSElTX01PRFVMRSwNCiB9Ow0KIA0K
LS0gDQoyLjI1LjENCg==

