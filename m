Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5604B399E75
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jun 2021 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFCKHa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Jun 2021 06:07:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:38307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229791AbhFCKHa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Jun 2021 06:07:30 -0400
X-UUID: 80ce672385754bf4af30b64404ffd570-20210603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=06lOdyJesgw3Ooiw5oPXaeUKODYaDOyrgb6IOsMSdH4=;
        b=vH3QKPMK1OX3lEnRYABwZlinwY4pRO4M9ocOUhjIg0qae5MhLPz8sHhcw9Xck7cD5xc3EWDncRwAZMNDVcdSBIZZxt6du3r2HkSTLptOJBJ9M48pxjG08wcyPNCthForF0howu16tFGubIU/Bl/BaRw6PWNVfnSQl6uu9z6hD74=;
X-UUID: 80ce672385754bf4af30b64404ffd570-20210603
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 161314996; Thu, 03 Jun 2021 18:05:42 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 18:05:37 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 3 Jun 2021 18:05:37 +0800
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
Subject: [PATCH v4 2/3] pwm: mtk-disp: move the commit to clock enabled
Date:   Thu, 3 Jun 2021 18:05:30 +0800
Message-ID: <20210603100531.161901-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603100531.161901-1-jitao.shi@mediatek.com>
References: <20210603100531.161901-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CCA6C023A3EFF0A3175B51CEFD19560F63E90FE79329200CEBC50557668EE3ED2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RHVlIHRvIHRoZSBjbG9jayBzZXF1ZW5jZSBjaGFuZ2luZywgc28gbW92ZSB0aGUgcmVnIGNvbW1p
dCB0bw0KY29uZmlnKCkuDQoNClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwgMjAgKysrKysr
Ky0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIGIvZHJp
dmVycy9wd20vcHdtLW10ay1kaXNwLmMNCmluZGV4IGI1NzcxZTJjNTRiOC4uYjg3YjNjMDBhNjg1
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMNCisrKyBiL2RyaXZlcnMv
cHdtL3B3bS1tdGstZGlzcC5jDQpAQCAtMTM1LDYgKzEzNSwxMyBAQCBzdGF0aWMgaW50IG10a19k
aXNwX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAq
cHdtLA0KIAkJbXRrX2Rpc3BfcHdtX3VwZGF0ZV9iaXRzKG1kcCwgbWRwLT5kYXRhLT5jb21taXQs
DQogCQkJCQkgbWRwLT5kYXRhLT5jb21taXRfbWFzaywNCiAJCQkJCSAweDApOw0KKwl9IGVsc2Ug
ew0KKwkJbXRrX2Rpc3BfcHdtX3VwZGF0ZV9iaXRzKG1kcCwgbWRwLT5kYXRhLT5ibHNfZGVidWcs
DQorCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzaywNCisJCQkJCSBtZHAtPmRhdGEtPmJs
c19kZWJ1Z19tYXNrKTsNCisJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0
YS0+Y29uMCwNCisJCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsLA0KKwkJCQkJIG1kcC0+ZGF0YS0+
Y29uMF9zZWwpOw0KIAl9DQogDQogCXJldHVybiAwOw0KQEAgLTIwOCwxOSArMjE1LDYgQEAgc3Rh
dGljIGludCBtdGtfZGlzcF9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWRwKTsNCiANCi0JLyoNCi0JICogRm9y
IE1UMjcwMSwgZGlzYWJsZSBkb3VibGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVyDQot
CSAqIGFuZCBzZWxlY3QgbWFudWFsIG1vZGUgYW5kIHVzZSBQV01fUEVSSU9EL1BXTV9ISUdIX1dJ
RFRILg0KLQkgKi8NCi0JaWYgKCFtZHAtPmRhdGEtPmhhc19jb21taXQpIHsNCi0JCW10a19kaXNw
X3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0KLQkJCQkJIG1kcC0+
ZGF0YS0+YmxzX2RlYnVnX21hc2ssDQotCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7
DQotCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAsDQotCQkJ
CQkgbWRwLT5kYXRhLT5jb24wX3NlbCwNCi0JCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCi0J
fQ0KLQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotLSANCjIuMjUuMQ0K

