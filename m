Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0D1773D8
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Mar 2020 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgCCKT1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Mar 2020 05:19:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgCCKT0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Mar 2020 05:19:26 -0500
X-UUID: 117aaee898884524a57a71c695fb40cc-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kNo7DFj3b9HktV/9EBruUcLqKxjTBFu6uKwuH9eM2VA=;
        b=fStkvVGfdODZUFXguzcaSao361mDB+EW3bBusAbnaUlGGE/VqKZLS5KuAaEyBY9TUxIXZXS5weqU0adXCsNkx6rOzkyQYQmMquvB2VF3631lmuQE71qIba/YVbK+YKby1XTp4ukN2F+CcXHcwjVWne3RcKqaERgSJw5JrlcgMCQ=;
X-UUID: 117aaee898884524a57a71c695fb40cc-20200303
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2000101293; Tue, 03 Mar 2020 18:19:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:18:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:19:16 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v2 1/1] pwm: mediatek: add longer period support
Date:   Tue, 3 Mar 2020 18:19:15 +0800
Message-ID: <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
References: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhlIHB3bSBjbG9jayBzb3VyY2UgY291bGQgYmUgZGl2aWRlZCBieSAxNjI1IHdpdGggUFdNX0NP
Tg0KQklUKDMpIHNldHRpbmcgaW4gbWVkaWF0ZWsgaGFyZHdhcmUuDQoNClRoaXMgcGF0Y2ggYWRk
IHN1cHBvcnQgZm9yIGxvbmdlciBwd20gcGVyaW9kIGNvbmZpZ3VyYXRpb24sDQp3aGljaCBhbGxv
d2luZyBibGlua2luZyBMRURzIHZpYSBwd20gaW50ZXJmYWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBT
YW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9wd20vcHdtLW1l
ZGlhdGVrLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYyBiL2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5j
DQppbmRleCBiOTRlMGQwOWMzMDAuLmM2NGVjZmY2YzU1MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
cHdtL3B3bS1tZWRpYXRlay5jDQorKysgYi9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYw0KQEAg
LTEyMSw4ICsxMjEsMTEgQEAgc3RhdGljIGludCBwd21fbWVkaWF0ZWtfY29uZmlnKHN0cnVjdCBw
d21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJCQkgICAgICAgaW50IGR1
dHlfbnMsIGludCBwZXJpb2RfbnMpDQogew0KIAlzdHJ1Y3QgcHdtX21lZGlhdGVrX2NoaXAgKnBj
ID0gdG9fcHdtX21lZGlhdGVrX2NoaXAoY2hpcCk7DQotCXUzMiBjbGtkaXYgPSAwLCBjbnRfcGVy
aW9kLCBjbnRfZHV0eSwgcmVnX3dpZHRoID0gUFdNRFdJRFRILA0KLQkgICAgcmVnX3RocmVzID0g
UFdNVEhSRVM7DQorCS8qIFRoZSBzb3VyY2UgY2xvY2sgaXMgZGl2aWRlZCBieSAyXmNsa2RpdiBv
ciBpZmYgdGhlIGNsa3NlbCBiaXQNCisJICogaXMgc2V0IGJ5ICgyXmNsa2RpdioxNjI1KQ0KKwkg
Ki8NCisJdTMyIGNsa2RpdiA9IDAsIGNsa3NlbCA9IDAsIGNudF9wZXJpb2QsIGNudF9kdXR5LA0K
KwkgICAgcmVnX3dpZHRoID0gUFdNRFdJRFRILCByZWdfdGhyZXMgPSBQV01USFJFUzsNCiAJdTY0
IHJlc29sdXRpb247DQogCWludCByZXQ7DQogDQpAQCAtMTMzLDEyICsxMzYsMzAgQEAgc3RhdGlj
IGludCBwd21fbWVkaWF0ZWtfY29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3
bV9kZXZpY2UgKnB3bSwNCiANCiAJLyogVXNpbmcgcmVzb2x1dGlvbiBpbiBwaWNvc2Vjb25kIGdl
dHMgYWNjdXJhY3kgaGlnaGVyICovDQogCXJlc29sdXRpb24gPSAodTY0KU5TRUNfUEVSX1NFQyAq
IDEwMDA7DQorCS8qIENhbGN1bGF0ZSByZXNvbHV0aW9uIGJhc2VkIG9uIGN1cnJlbnQgY2xvY2sg
ZnJlcXVlbmN5ICovDQogCWRvX2RpdihyZXNvbHV0aW9uLCBjbGtfZ2V0X3JhdGUocGMtPmNsa19w
d21zW3B3bS0+aHdwd21dKSk7DQotDQorCS8qIFVzaW5nIHJlc29sdXRpb24gdG8gY2FsY3VsYXRl
IGNudF9wZXJpb2Qgd2hpY2ggcmVwcmVzZW50cw0KKwkgKiB0aGUgZWZmZWN0aXZlIHJhbmdlIG9m
IHRoZSBQV00gcGVyaW9kIGNvdW50ZXINCisJICovDQogCWNudF9wZXJpb2QgPSBESVZfUk9VTkRf
Q0xPU0VTVF9VTEwoKHU2NClwZXJpb2RfbnMgKiAxMDAwLCByZXNvbHV0aW9uKTsNCiAJd2hpbGUg
KGNudF9wZXJpb2QgPiA4MTkxKSB7DQorCQkvKiBVc2luZyBjbGtkaXYgdG8gcmVkdWNlIGNsb2Nr
IGZyZXF1ZW5jeSBhbmQgY2FsY3VsYXRlDQorCQkgKiBuZXcgcmVzb2x1dGlvbiBiYXNlZCBvbiBu
ZXcgY2xvY2sgc3BlZWQNCisJCSAqLw0KIAkJcmVzb2x1dGlvbiAqPSAyOw0KIAkJY2xrZGl2Kys7
DQorCQlpZiAoY2xrZGl2ID4gUFdNX0NMS19ESVZfTUFYICYmICFjbGtzZWwpIHsNCisJCQkvKiBV
c2luZyBjbGtzZWwgdG8gZGl2aWRlIHRoZSBwd20gc291cmNlIGNsb2NrIGJ5DQorCQkJICogYW4g
YWRkaXRpb25hbCAxNjI1LCBhbmQgcmVjYWxjdWxhdGUgbmV3IGNsa2Rpdg0KKwkJCSAqIGFuZCBy
ZXNvbHV0aW9uDQorCQkJICovDQorCQkJY2xrc2VsID0gMTsNCisJCQljbGtkaXYgPSAwOw0KKwkJ
CXJlc29sdXRpb24gPSAodTY0KU5TRUNfUEVSX1NFQyAqIDEwMDAgKiAxNjI1Ow0KKwkJCWRvX2Rp
dihyZXNvbHV0aW9uLA0KKwkJCQljbGtfZ2V0X3JhdGUocGMtPmNsa19wd21zW3B3bS0+aHdwd21d
KSk7DQorCQl9DQorCQkvKiBDYWxjdWxhdGUgY250X3BlcmlvZCBiYXNlZCBvbiByZXNvbHV0aW9u
ICovDQogCQljbnRfcGVyaW9kID0gRElWX1JPVU5EX0NMT1NFU1RfVUxMKCh1NjQpcGVyaW9kX25z
ICogMTAwMCwNCiAJCQkJCQkgICByZXNvbHV0aW9uKTsNCiAJfQ0KQEAgLTE1OCw4ICsxNzksMTMg
QEAgc3RhdGljIGludCBwd21fbWVkaWF0ZWtfY29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwg
c3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAJCXJlZ190aHJlcyA9IFBXTTQ1VEhSRVNfRklYVVA7
DQogCX0NCiANCisJLyogQ2FsY3VsYXRlIGNudF9kdXR5IGJhc2VkIG9uIHJlc29sdXRpb24gKi8N
CiAJY250X2R1dHkgPSBESVZfUk9VTkRfQ0xPU0VTVF9VTEwoKHU2NClkdXR5X25zICogMTAwMCwg
cmVzb2x1dGlvbik7DQotCXB3bV9tZWRpYXRla193cml0ZWwocGMsIHB3bS0+aHdwd20sIFBXTUNP
TiwgQklUKDE1KSB8IGNsa2Rpdik7DQorCWlmIChjbGtzZWwpDQorCQlwd21fbWVkaWF0ZWtfd3Jp
dGVsKHBjLCBwd20tPmh3cHdtLCBQV01DT04sIEJJVCgxNSkgfCBCSVQoMykgfA0KKwkJCQkgICAg
Y2xrZGl2KTsNCisJZWxzZQ0KKwkJcHdtX21lZGlhdGVrX3dyaXRlbChwYywgcHdtLT5od3B3bSwg
UFdNQ09OLCBCSVQoMTUpIHwgY2xrZGl2KTsNCiAJcHdtX21lZGlhdGVrX3dyaXRlbChwYywgcHdt
LT5od3B3bSwgcmVnX3dpZHRoLCBjbnRfcGVyaW9kKTsNCiAJcHdtX21lZGlhdGVrX3dyaXRlbChw
YywgcHdtLT5od3B3bSwgcmVnX3RocmVzLCBjbnRfZHV0eSk7DQogDQotLSANCjIuMTcuMQ0K

