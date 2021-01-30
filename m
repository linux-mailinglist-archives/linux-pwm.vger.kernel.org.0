Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03A3095D2
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Jan 2021 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhA3OOg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Jan 2021 09:14:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:59723 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231666AbhA3ONo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Jan 2021 09:13:44 -0500
X-UUID: fac2dfdd45ae48ccab3eadd4c5120212-20210130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DyzlMt+ZRsFBAamZ/P7DPnw9Tzbiso9sA1OiSGy7Xek=;
        b=aQMk6qXDKIs6a9p3jtmaMOjMed+bTH1nJqB5brc5CQHQOuZct5GNvMlBay5qtgLmiOJgMhT24DurCbFGMGRo3RiBccstrePAp2IZEcw7u9NEsUNFuS7Y9iFaQKW/Ko/iUevzEJ8Nhrjr9ou0SdtXe5NzyXqk9QSXXrrMATKNNVg=;
X-UUID: fac2dfdd45ae48ccab3eadd4c5120212-20210130
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 501370062; Sat, 30 Jan 2021 22:12:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 30 Jan
 2021 22:12:33 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 30 Jan 2021 22:12:32 +0800
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
Subject: [PATCH v2 3/3] pwm: mtk_disp: implement .get_state()
Date:   Sat, 30 Jan 2021 22:12:26 +0800
Message-ID: <20210130141226.25357-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20210130141226.25357-1-jitao.shi@mediatek.com>
References: <20210130141226.25357-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 05FF14DABF24935074C7B5A197E4A8FAE17711D2C7A914C6F6F525F957A904C82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIGIvZHJpdmVycy9wd20v
cHdtLW10ay1kaXNwLmMNCmluZGV4IDUwMjIyOGFkZjcxOC4uMTY2ZTBhOGNhNzAzIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMNCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1t
dGstZGlzcC5jDQpAQCAtMTc5LDggKzE3OSw1NCBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9h
cHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQogCXJl
dHVybiBtdGtfZGlzcF9wd21fZW5hYmxlKGNoaXAsIHN0YXRlKTsNCiB9DQogDQorc3RhdGljIHZv
aWQgbXRrX2Rpc3BfcHdtX2dldF9zdGF0ZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsDQorCQkJCSAg
IHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQorCQkJCSAgIHN0cnVjdCBwd21fc3RhdGUgKnN0YXRl
KQ0KK3sNCisJc3RydWN0IG10a19kaXNwX3B3bSAqbWRwID0gdG9fbXRrX2Rpc3BfcHdtKGNoaXAp
Ow0KKwl1MzIgY2xrX2RpdiwgcGVyaW9kLCBoaWdoX3dpZHRoLCBjb24wLCBjb24xOw0KKwl1NjQg
cmF0ZTsNCisJaW50IGVycjsNCisNCisJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKG1kcC0+Y2xr
X21haW4pOw0KKwlpZiAoZXJyIDwgMCkgew0KKwkJZGV2X2VycihjaGlwLT5kZXYsICJDYW4ndCBl
bmFibGUgbWRwLT5jbGtfbWFpbjogJWRcbiIsIGVycik7DQorCQlyZXR1cm47DQorCX0NCisJZXJy
ID0gY2xrX3ByZXBhcmVfZW5hYmxlKG1kcC0+Y2xrX21tKTsNCisJaWYgKGVyciA8IDApIHsNCisJ
CWRldl9lcnIoY2hpcC0+ZGV2LCAiQ2FuJ3QgZW5hYmxlIG1kcC0+Y2xrX21tOiAlZFxuIiwgZXJy
KTsNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtZHAtPmNsa19tYWluKTsNCisJCXJldHVybjsN
CisJfQ0KKw0KKwlyYXRlID0gY2xrX2dldF9yYXRlKG1kcC0+Y2xrX21haW4pOw0KKw0KKwljb24w
ID0gcmVhZGwobWRwLT5iYXNlICsgbWRwLT5kYXRhLT5jb24wKTsNCisJY29uMSA9IHJlYWRsKG1k
cC0+YmFzZSArIG1kcC0+ZGF0YS0+Y29uMSk7DQorDQorCXN0YXRlLT5wb2xhcml0eSA9IGNvbjAg
JiBQV01fUE9MQVJJVFkgPw0KKwkJCSAgUFdNX1BPTEFSSVRZX0lOVkVSU0VEIDogUFdNX1BPTEFS
SVRZX05PUk1BTDsNCisJc3RhdGUtPmVuYWJsZWQgPSAhIShjb24wICYgQklUKDApKTsNCisNCisJ
Y2xrX2RpdiA9IChjb24wICYgUFdNX0NMS0RJVl9NQVNLKSA+PiBQV01fQ0xLRElWX1NISUZUOw0K
KwlwZXJpb2QgPSBjb24xICYgUFdNX1BFUklPRF9NQVNLOw0KKwlzdGF0ZS0+cGVyaW9kID0gZGl2
X3U2NChwZXJpb2QgKiAoY2xrX2RpdiArIDEpICogTlNFQ19QRVJfU0VDLCByYXRlKTsNCisJaGln
aF93aWR0aCA9IChjb24xICYgUFdNX0hJR0hfV0lEVEhfTUFTSykgPj4gUFdNX0hJR0hfV0lEVEhf
U0hJRlQ7DQorCXN0YXRlLT5kdXR5X2N5Y2xlID0gZGl2X3U2NChoaWdoX3dpZHRoICogKGNsa19k
aXYgKyAxKSAqIE5TRUNfUEVSX1NFQywNCisJCQkJICAgIHJhdGUpOw0KKw0KKwlpZiAoIXN0YXRl
LT5lbmFibGVkKSB7DQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUobWRwLT5jbGtfbW0pOw0KKwkJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKG1kcC0+Y2xrX21haW4pOw0KKwl9DQorDQorCW1kcC0+ZW5h
YmxlZCA9IHN0YXRlLT5lbmFibGVkOw0KK30NCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IHB3bV9v
cHMgbXRrX2Rpc3BfcHdtX29wcyA9IHsNCiAJLmFwcGx5ID0gbXRrX2Rpc3BfcHdtX2FwcGx5LA0K
KwkuZ2V0X3N0YXRlID0gbXRrX2Rpc3BfcHdtX2dldF9zdGF0ZSwNCiAJLm93bmVyID0gVEhJU19N
T0RVTEUsDQogfTsNCiANCi0tIA0KMi4xMi41DQo=

