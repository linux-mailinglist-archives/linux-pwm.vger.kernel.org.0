Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A33D464C
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jul 2021 10:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhGXHib (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Jul 2021 03:38:31 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:2186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234793AbhGXHia (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Jul 2021 03:38:30 -0400
X-UUID: 9bd6a979b1874e549f03da57daf8adf3-20210724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ENyCwb/7RINa8CoCnsCtByjxuCTyi7XHVsTTA3kw24I=;
        b=o0WJgx3SExaBXOPlzP9PGlrTNuN63iXlRhLec4rE4RP0zzsi/gd8UA7wt1c/2UtDSsBhxYwwvVhorR9igAPU3kk8+oWgij4GoAFZajvzZfzAI5slM3gtbnwjoddKwTuXzKnvBi5IXzKrV0p9+C0SRdRraCPBK4wyp4Ta1b7XBvU=;
X-UUID: 9bd6a979b1874e549f03da57daf8adf3-20210724
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1595944699; Sat, 24 Jul 2021 16:18:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 24 Jul
 2021 16:18:56 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 24 Jul 2021 16:18:55 +0800
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
Subject: [PATCH v6 5/5] pwm: mtk_disp: implement atomic API .get_state()
Date:   Sat, 24 Jul 2021 16:18:49 +0800
Message-ID: <20210724081849.182108-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724081849.182108-1-jitao.shi@mediatek.com>
References: <20210724081849.182108-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 62DD677CB2F76DA59506D1D71FBF7A101F136D9A8F1C01B6B8916A98881FA1962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

U3dpdGNoIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgLmdldF9zdGF0ZSgpIG1ldGhvZC4NCg0K
U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdtL3B3bS1tdGst
ZGlzcC5jDQppbmRleCA0ZjZkZTZmMjQ0ODQuLmExY2Q3YzIwODc0MyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3Au
Yw0KQEAgLTE2Nyw4ICsxNjcsNDkgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fYXBwbHkoc3Ry
dWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KIAlyZXR1cm4gMDsN
CiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2Rpc3BfcHdtX2dldF9zdGF0ZShzdHJ1Y3QgcHdtX2No
aXAgKmNoaXAsDQorCQkJCSAgIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQorCQkJCSAgIHN0cnVj
dCBwd21fc3RhdGUgKnN0YXRlKQ0KK3sNCisJc3RydWN0IG10a19kaXNwX3B3bSAqbWRwID0gdG9f
bXRrX2Rpc3BfcHdtKGNoaXApOw0KKwl1MzIgY2xrX2RpdiwgY29uMCwgY29uMTsNCisJdTY0IHJh
dGUsIHBlcmlvZCwgaGlnaF93aWR0aDsNCisJaW50IGVycjsNCisNCisJZXJyID0gY2xrX3ByZXBh
cmVfZW5hYmxlKG1kcC0+Y2xrX21haW4pOw0KKwlpZiAoZXJyIDwgMCkgew0KKwkJZGV2X2Vycihj
aGlwLT5kZXYsICJDYW4ndCBlbmFibGUgbWRwLT5jbGtfbWFpbjogJXBlXG4iLCBFUlJfUFRSKGVy
cikpOw0KKwkJcmV0dXJuOw0KKwl9DQorCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShtZHAtPmNs
a19tbSk7DQorCWlmIChlcnIgPCAwKSB7DQorCQlkZXZfZXJyKGNoaXAtPmRldiwgIkNhbid0IGVu
YWJsZSBtZHAtPmNsa19tbTogJXBlXG4iLCBFUlJfUFRSKGVycikpOw0KKwkJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0KKwkJcmV0dXJuOw0KKwl9DQorDQorCXJhdGUgPSBj
bGtfZ2V0X3JhdGUobWRwLT5jbGtfbWFpbik7DQorCWNvbjAgPSByZWFkbChtZHAtPmJhc2UgKyBt
ZHAtPmRhdGEtPmNvbjApOw0KKwljb24xID0gcmVhZGwobWRwLT5iYXNlICsgbWRwLT5kYXRhLT5j
b24xKTsNCisJc3RhdGUtPmVuYWJsZWQgPSAhIShjb24wICYgQklUKDApKTsNCisJY2xrX2RpdiA9
IEZJRUxEX0dFVChQV01fQ0xLRElWX01BU0ssIGNvbjApOw0KKwlwZXJpb2QgPSBGSUVMRF9HRVQo
UFdNX1BFUklPRF9NQVNLLCBjb24xKTsNCisJLyoNCisJICogcGVyaW9kIGhhcyAxMiBiaXRzLCBj
bGtfZGl2IDExIGFuZCBOU0VDX1BFUl9TRUMgaGFzIDMwLA0KKwkgKiBzbyBwZXJpb2QgKiAoY2xr
X2RpdiArIDEpICogTlNFQ19QRVJfU0VDIGRvZXNuJ3Qgb3ZlcmZsb3cuDQorCSAqLw0KKwlzdGF0
ZS0+cGVyaW9kID0gRElWNjRfVTY0X1JPVU5EX1VQKHBlcmlvZCAqIChjbGtfZGl2ICsgMSkgKiBO
U0VDX1BFUl9TRUMsIHJhdGUpOw0KKwloaWdoX3dpZHRoID0gRklFTERfR0VUKFBXTV9ISUdIX1dJ
RFRIX01BU0ssIGNvbjEpOw0KKwlzdGF0ZS0+ZHV0eV9jeWNsZSA9IERJVjY0X1U2NF9ST1VORF9V
UChoaWdoX3dpZHRoICogKGNsa19kaXYgKyAxKSAqIE5TRUNfUEVSX1NFQywNCisJCQkJCSAgICAg
ICByYXRlKTsNCisJc3RhdGUtPnBvbGFyaXR5ID0gUFdNX1BPTEFSSVRZX05PUk1BTDsNCisJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21tKTsNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KG1kcC0+Y2xrX21haW4pOw0KK30NCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IHB3bV9vcHMgbXRr
X2Rpc3BfcHdtX29wcyA9IHsNCiAJLmFwcGx5ID0gbXRrX2Rpc3BfcHdtX2FwcGx5LA0KKwkuZ2V0
X3N0YXRlID0gbXRrX2Rpc3BfcHdtX2dldF9zdGF0ZSwNCiAJLm93bmVyID0gVEhJU19NT0RVTEUs
DQogfTsNCiANCi0tIA0KMi4yNS4xDQo=

