Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE371711A5
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2020 08:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgB0Hrn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 02:47:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48206 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728441AbgB0Hrn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 02:47:43 -0500
X-UUID: 90d4f71a89d54d7e8d5a493b1adcc2dc-20200227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=63YRAaFL+lbXvbtjs/mfmNkzxs9oDsAdzcTK8UHwzWA=;
        b=pxSou091h368wkBQ+0ZcyTn/etaoOycO7YaDYlfRpqAXa9X9FTmPeetTc8/Q13kqkk2brDwgorfEEW11G67VM5tTaDnZQgTbgh97Bm8sxjgz/8k3jW6FRWNfgPsoVxMj1/BkmLHEu8IEIZqqriANNicrz4f4PB05dQG/lZLjglY=;
X-UUID: 90d4f71a89d54d7e8d5a493b1adcc2dc-20200227
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1143352225; Thu, 27 Feb 2020 15:47:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Feb 2020 15:46:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Feb 2020 15:47:42 +0800
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
Subject: [PATCH 1/1] pwm: mediatek: add longer period support
Date:   Thu, 27 Feb 2020 15:46:50 +0800
Message-ID: <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
References: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
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
ZGlhdGVrLmMgfCAyMSArKysrKysrKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdt
L3B3bS1tZWRpYXRlay5jIGIvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMNCmluZGV4IGI5NGUw
ZDA5YzMwMC4uOWFmMzA5YmVhMDFhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wd20vcHdtLW1lZGlh
dGVrLmMNCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jDQpAQCAtMTIxLDggKzEyMSw4
IEBAIHN0YXRpYyBpbnQgcHdtX21lZGlhdGVrX2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAs
IHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQogCQkJICAgICAgIGludCBkdXR5X25zLCBpbnQgcGVy
aW9kX25zKQ0KIHsNCiAJc3RydWN0IHB3bV9tZWRpYXRla19jaGlwICpwYyA9IHRvX3B3bV9tZWRp
YXRla19jaGlwKGNoaXApOw0KLQl1MzIgY2xrZGl2ID0gMCwgY250X3BlcmlvZCwgY250X2R1dHks
IHJlZ193aWR0aCA9IFBXTURXSURUSCwNCi0JICAgIHJlZ190aHJlcyA9IFBXTVRIUkVTOw0KKwl1
MzIgY2xrZGl2ID0gMCwgY2xrc2VsID0gMCwgY250X3BlcmlvZCwgY250X2R1dHksDQorCSAgICBy
ZWdfd2lkdGggPSBQV01EV0lEVEgsIHJlZ190aHJlcyA9IFBXTVRIUkVTOw0KIAl1NjQgcmVzb2x1
dGlvbjsNCiAJaW50IHJldDsNCiANCkBAIC0xNDEsOSArMTQxLDE4IEBAIHN0YXRpYyBpbnQgcHdt
X21lZGlhdGVrX2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNl
ICpwd20sDQogCQljbGtkaXYrKzsNCiAJCWNudF9wZXJpb2QgPSBESVZfUk9VTkRfQ0xPU0VTVF9V
TEwoKHU2NClwZXJpb2RfbnMgKiAxMDAwLA0KIAkJCQkJCSAgIHJlc29sdXRpb24pOw0KKwkJaWYg
KGNsa2RpdiA+IFBXTV9DTEtfRElWX01BWCAmJiAhY2xrc2VsKSB7DQorCQkJY2xrc2VsID0gMTsN
CisJCQljbGtkaXYgPSAwOw0KKwkJCXJlc29sdXRpb24gPSAodTY0KU5TRUNfUEVSX1NFQyAqIDEw
MDAgKiAxNjI1Ow0KKwkJCWRvX2RpdihyZXNvbHV0aW9uLA0KKwkJCQljbGtfZ2V0X3JhdGUocGMt
PmNsa19wd21zW3B3bS0+aHdwd21dKSk7DQorCQkJY250X3BlcmlvZCA9IERJVl9ST1VORF9DTE9T
RVNUX1VMTCgNCisJCQkJCSh1NjQpcGVyaW9kX25zICogMTAwMCwgcmVzb2x1dGlvbik7DQorCQl9
DQogCX0NCiANCi0JaWYgKGNsa2RpdiA+IFBXTV9DTEtfRElWX01BWCkgew0KKwlpZiAoY2xrZGl2
ID4gUFdNX0NMS19ESVZfTUFYICYmIGNsa3NlbCkgew0KIAkJcHdtX21lZGlhdGVrX2Nsa19kaXNh
YmxlKGNoaXAsIHB3bSk7DQogCQlkZXZfZXJyKGNoaXAtPmRldiwgInBlcmlvZCAlZCBub3Qgc3Vw
cG9ydGVkXG4iLCBwZXJpb2RfbnMpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQpAQCAtMTU5LDcgKzE2
OCwxMSBAQCBzdGF0aWMgaW50IHB3bV9tZWRpYXRla19jb25maWcoc3RydWN0IHB3bV9jaGlwICpj
aGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KIAl9DQogDQogCWNudF9kdXR5ID0gRElWX1JP
VU5EX0NMT1NFU1RfVUxMKCh1NjQpZHV0eV9ucyAqIDEwMDAsIHJlc29sdXRpb24pOw0KLQlwd21f
bWVkaWF0ZWtfd3JpdGVsKHBjLCBwd20tPmh3cHdtLCBQV01DT04sIEJJVCgxNSkgfCBjbGtkaXYp
Ow0KKwlpZiAoY2xrc2VsKQ0KKwkJcHdtX21lZGlhdGVrX3dyaXRlbChwYywgcHdtLT5od3B3bSwg
UFdNQ09OLCBCSVQoMTUpIHwgQklUKDMpIHwNCisJCQkJICAgIGNsa2Rpdik7DQorCWVsc2UNCisJ
CXB3bV9tZWRpYXRla193cml0ZWwocGMsIHB3bS0+aHdwd20sIFBXTUNPTiwgQklUKDE1KSB8IGNs
a2Rpdik7DQogCXB3bV9tZWRpYXRla193cml0ZWwocGMsIHB3bS0+aHdwd20sIHJlZ193aWR0aCwg
Y250X3BlcmlvZCk7DQogCXB3bV9tZWRpYXRla193cml0ZWwocGMsIHB3bS0+aHdwd20sIHJlZ190
aHJlcywgY250X2R1dHkpOw0KIA0KLS0gDQoyLjE3LjENCg==

