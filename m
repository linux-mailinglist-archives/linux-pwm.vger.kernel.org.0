Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556961222CF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2019 05:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLQECk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 23:02:40 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:55599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727089AbfLQECk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 23:02:40 -0500
X-UUID: 7094b7437bbe449a9a45173f66eee083-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tZYQtktGRy8Who+pLVHW/cHqPk4WeYEvryM79MNiedY=;
        b=e6H7lO7zW+21JvQCmHwBvWYy+w3pSqnwPNF5tYSlMt827/aLAi21rkazOIrHYVzJdeY0LZDBuCulCx7nAlcMDKQibOtjTAqCIxJajOlLtXbpIWzyr/ymJLJgZE2aM8n3d3IybrJolHridRzOVNuEn2CZ1QnJIS8X4NaXnQ9rwpY=;
X-UUID: 7094b7437bbe449a9a45173f66eee083-20191217
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1127974747; Tue, 17 Dec 2019 12:02:35 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Dec
 2019 12:02:54 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 17 Dec 2019 12:02:12 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 2/2] pwm: mtk_disp: keep the trigger register after pwm setting.
Date:   Tue, 17 Dec 2019 12:02:37 +0800
Message-ID: <20191217040237.28238-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217040237.28238-1-jitao.shi@mediatek.com>
References: <20191217040237.28238-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3E0F6F0913388D23C7EBEF8FEBBD9736E8493E1439D04217FAD8B691804CC4792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

TW92ZSB0aGUgdHJpZ2dlciBhZnRlciBwd20gc2V0dGluZyB0byBhdm9pZCB0aGUgcHdtIHdyb25n
IHNpZ25hbA0Kb3V0cHV0Lg0KDQpSZW1vdmUgdGhlIHJlZ2lzdCBlbmFibGUgdHJpZ2dlciBzZXR0
aW5nIGluIHByb2JlLg0KTW92ZSB0aGUgdHJpZ2dlciB0byBlbmQgb2YgbXRrX2Rpc3BfcHdtX2Nv
bmZpZygpLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyB8IDIwICsrKysrKystLS0tLS0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZlcnMvcHdt
L3B3bS1tdGstZGlzcC5jDQppbmRleCBjN2IxNGFjYzkzMTYuLmMxYWFlNWI1NjkzYiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20t
bXRrLWRpc3AuYw0KQEAgLTEyMiw2ICsxMjIsMTMgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21f
Y29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJ
CW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+Y29tbWl0LA0KIAkJCQkJ
IG1kcC0+ZGF0YS0+Y29tbWl0X21hc2ssDQogCQkJCQkgMHgwKTsNCisJfSBlbHNlIHsNCisJCW10
a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0KKwkJCQkJ
IG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21hc2ssDQorCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdf
bWFzayk7DQorCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmNvbjAs
DQorCQkJCQkgbWRwLT5kYXRhLT5jb24wX3NlbCwNCisJCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2Vs
KTsNCiAJfQ0KIA0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUobWRwLT5jbGtfbW0pOw0KQEAgLTIw
NywxOSArMjE0LDYgQEAgc3RhdGljIGludCBtdGtfZGlzcF9wd21fcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWRwKTsN
CiANCi0JLyoNCi0JICogRm9yIE1UMjcwMSwgZGlzYWJsZSBkb3VibGUgYnVmZmVyIGJlZm9yZSB3
cml0aW5nIHJlZ2lzdGVyDQotCSAqIGFuZCBzZWxlY3QgbWFudWFsIG1vZGUgYW5kIHVzZSBQV01f
UEVSSU9EL1BXTV9ISUdIX1dJRFRILg0KLQkgKi8NCi0JaWYgKCFtZHAtPmRhdGEtPmhhc19jb21t
aXQpIHsNCi0JCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+YmxzX2Rl
YnVnLA0KLQkJCQkJIG1kcC0+ZGF0YS0+YmxzX2RlYnVnX21hc2ssDQotCQkJCQkgbWRwLT5kYXRh
LT5ibHNfZGVidWdfbWFzayk7DQotCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBtZHAt
PmRhdGEtPmNvbjAsDQotCQkJCQkgbWRwLT5kYXRhLT5jb24wX3NlbCwNCi0JCQkJCSBtZHAtPmRh
dGEtPmNvbjBfc2VsKTsNCi0JfQ0KLQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotLSANCjIuMjEuMA0K

