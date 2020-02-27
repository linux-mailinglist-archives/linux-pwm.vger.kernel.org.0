Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D378C171492
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2020 10:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgB0J7z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Feb 2020 04:59:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31747 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728627AbgB0J7z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 04:59:55 -0500
X-UUID: 77da96573f4642a78da32690f8465f85-20200227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eLO7gTFF1vCEAIYROkM8MZuVGCM3sjjAWL8M+r6/05Y=;
        b=BakoIO05e70F2zY4x9CluisQoeR2XSAUbzcWYoBfojDKRB1rabr2ND/3Fc3BDv/lMD4vRzT0evUdvNnSw44hiIW09QV1L/mWtF9KgXsXt6kEnc3NHimSorPXgazAkfYlCxf4yMFJ+Pp2FT2IrCe9OAS7dVxONIKUsyBrzLxNMj0=;
X-UUID: 77da96573f4642a78da32690f8465f85-20200227
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1065449779; Thu, 27 Feb 2020 17:59:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Feb 2020 17:59:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Feb 2020 17:59:53 +0800
Message-ID: <1582797590.25607.10.camel@mtksdccf07>
Subject: Re: [PATCH 1/1] pwm: mediatek: add longer period support
From:   Sam Shih <sam.shih@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 27 Feb 2020 17:59:50 +0800
In-Reply-To: <20200227080450.rkvwfjx6vikn5ls3@pengutronix.de>
References: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
         <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
         <20200227080450.rkvwfjx6vikn5ls3@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTI3IGF0IDA5OjA0ICswMTAwLCBVd2UgS2xlaW5lLUv2bmlnIHdyb3Rl
Og0KT24gVGh1LCBGZWIgMjcsIDIwMjAgYXQgMDM6NDY6NTBQTSArMDgwMCwgU2FtIFNoaWggd3Jv
dGU6DQo+ID4gVGhlIHB3bSBjbG9jayBzb3VyY2UgY291bGQgYmUgZGl2aWRlZCBieSAxNjI1IHdp
dGggUFdNX0NPTg0KPiA+IEJJVCgzKSBzZXR0aW5nIGluIG1lZGlhdGVrIGhhcmR3YXJlLg0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggYWRkIHN1cHBvcnQgZm9yIGxvbmdlciBwd20gcGVyaW9kIGNvbmZp
Z3VyYXRpb24sDQo+ID4gd2hpY2ggYWxsb3dpbmcgYmxpbmtpbmcgTEVEcyB2aWEgcHdtIGludGVy
ZmFjZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYyB8IDIxICsr
KysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdt
LW1lZGlhdGVrLmMgYi9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYw0KPiA+IGluZGV4IGI5NGUw
ZDA5YzMwMC4uOWFmMzA5YmVhMDFhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1t
ZWRpYXRlay5jDQo+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMNCj4gPiBAQCAt
MTIxLDggKzEyMSw4IEBAIHN0YXRpYyBpbnQgcHdtX21lZGlhdGVrX2NvbmZpZyhzdHJ1Y3QgcHdt
X2NoaXANCipjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPiA+ICAJCQkgICAgICAgaW50
IGR1dHlfbnMsIGludCBwZXJpb2RfbnMpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBwd21fbWVkaWF0
ZWtfY2hpcCAqcGMgPSB0b19wd21fbWVkaWF0ZWtfY2hpcChjaGlwKTsNCj4gPiAtCXUzMiBjbGtk
aXYgPSAwLCBjbnRfcGVyaW9kLCBjbnRfZHV0eSwgcmVnX3dpZHRoID0gUFdNRFdJRFRILA0KPiA+
IC0JICAgIHJlZ190aHJlcyA9IFBXTVRIUkVTOw0KPiA+ICsJdTMyIGNsa2RpdiA9IDAsIGNsa3Nl
bCA9IDAsIGNudF9wZXJpb2QsIGNudF9kdXR5LA0KPiA+ICsJICAgIHJlZ193aWR0aCA9IFBXTURX
SURUSCwgcmVnX3RocmVzID0gUFdNVEhSRVM7DQo+ID4gIAl1NjQgcmVzb2x1dGlvbjsNCj4gPiAg
CWludCByZXQ7DQo+ID4gIA0KPiBBZGRpbmcgc29tZSBtb3JlIGNvbnRleHQ6DQo+IA0KDQorIC8q
IFRoZSBwd20gc291cmNlIGNsb2NrIGNhbiBiZSBkaXZpZGVkIGJ5IDJeY2xrZGl2LiBXaGVuIHRo
ZSBjbGtzZWwgICsNCiogYml0IGlzIHNldCB0byAxLCBUaGUgZmluYWwgY2xvY2sgb3V0cHV0IG5l
ZWRzIHRvIGJlIGRpdmlkZWQgYnkgYW4gKyAgKg0KZXh0cmEgMTYyNS4NCisgICovDQoNCklzIHRo
aXMgb2sgPw0KDQoNCj4gPiBAQCAtMTM5LDExICsxMzksMjAgQEAgc3RhdGljIGludCBwd21fbWVk
aWF0ZWtfY29uZmlnKHN0cnVjdCBwd21fY2hpcA0KKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpw
d20sDQo+ID4gCXdoaWxlIChjbnRfcGVyaW9kID4gODE5MSkgew0KPiA+ICAJCXJlc29sdXRpb24g
Kj0gMjsNCj4gPiAgCQljbGtkaXYrKzsNCj4gPiAgCQljbnRfcGVyaW9kID0gRElWX1JPVU5EX0NM
T1NFU1RfVUxMKCh1NjQpcGVyaW9kX25zICogMTAwMCwNCj4gPiAgCQkJCQkJICAgcmVzb2x1dGlv
bik7DQo+ID4gKwkJaWYgKGNsa2RpdiA+IFBXTV9DTEtfRElWX01BWCAmJiAhY2xrc2VsKSB7DQo+
ID4gKwkJCWNsa3NlbCA9IDE7DQo+ID4gKwkJCWNsa2RpdiA9IDA7DQo+ID4gKwkJCXJlc29sdXRp
b24gPSAodTY0KU5TRUNfUEVSX1NFQyAqIDEwMDAgKiAxNjI1Ow0KPiA+ICsJCQlkb19kaXYocmVz
b2x1dGlvbiwNCj4gPiArCQkJCWNsa19nZXRfcmF0ZShwYy0+Y2xrX3B3bXNbcHdtLT5od3B3bV0p
KTsNCj4gPiArCQkJY250X3BlcmlvZCA9IERJVl9ST1VORF9DTE9TRVNUX1VMTCgNCj4gPiArCQkJ
CQkodTY0KXBlcmlvZF9ucyAqIDEwMDAsIHJlc29sdXRpb24pOw0KPiANCj4gVGhlIGFzc2lnbm1l
bnQgaXMgYSByZXBldGl0aW9uIGZyb20ganVzdCBhYm92ZSB0aGUgaWYuIE1heWJlIGp1c3QgcHV0
DQppdA0KPiBvbmNlIGFmdGVyIHRoaXMgaWYgYmxvY2s/DQoNClRoZSBjbnRfcGVyaW9kIHJlcHJl
c2VudHMgdGhlIGVmZmVjdGl2ZSByYW5nZSBvZiB0aGUgUFdNIHBlcmlvZCBjb3VudGVyLA0Kd2hl
biB3ZSBuZWVkIGNoYW5naW5nIHRoZSBwd20gb3V0cHV0IHBlcmlvZCB0byBhIGxvbmdlciB2YWx1
ZSBhdCB0aGUNCnNhbWUgY2xvY2sgZnJlcXVlbmN5LCB3ZSBjYW4gc2V0dGluZyBhIGxhcmdlciBj
bnRfcGVyaW9kLCBidXQgdGhlIHdpZHRoDQpvZiB0aGUgY250X3Blcm9pZCByZWdpc3RlciBpcyAx
MiBiaXRzLA0KV2hlbiB0aGUgcmVxdWVzdCBwZXJpb2QgaXMgdG9vIGxvbmcsIHdlIG5lZWQgdG8g
ZGl2aWRlIHRoZSBjbG9jayBzb3VyY2UNCmFuZCB0aGVuIHJlY2FsY3VsYXRlIGNudF9wZXJpb2Qg
b3V0cHV0cyB0aGUgY29ycmVjdCB3YXZlZm9ybS4NCkFzIG1lbnRpb25lZCBhYm92ZSwgd2hlbiBj
aGFuZ2luZyBjbGtkaXYsIHdlIG5lZWQgdG8gcmVjYWxjdWxhdGUNCmNudF9wZXJpb2QgaW1tZWRp
YXRlbHkuDQoNCklmIHRoZSByZXF1ZXN0IHBlcmlvZCBpcyB2ZXJ5IGxvbmcgKGZvciBleGFtcGxl
LCBMRUQgYmxpbmtpbmcpLCBjbGtkaXYNCm1heSBiZSBpbnN1ZmZpY2llbnQuIA0KSW4gdGhpcyBj
YXNlLCB3ZSB3aWxsIHVzZSBjbGtzZWwgdG8gZGl2aWRlIHRoZSBwd20gc291cmNlIGNsb2NrIGJ5
IGFuDQphZGRpdGlvbmFsIDE2MjUsIGFuZCByZWNhbGN1bGF0ZSBjbGtkaXYgYW5kIGNudF9wZXJp
b2QuDQoNCkkgZG9uJ3QgdGhpbmsgd2UgY2FuIGp1c3QgcGxhY2UgYXNzaWdubWVudHMgYWZ0ZXIg
dGhlIGlmIGJsb2NrLg0KDQo+IA0KPiA+ICsJCX0NCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlpZiAo
Y2xrZGl2ID4gUFdNX0NMS19ESVZfTUFYKSB7DQo+ID4gKwlpZiAoY2xrZGl2ID4gUFdNX0NMS19E
SVZfTUFYICYmIGNsa3NlbCkgew0KPiANCj4gSXMgdGhpcyBjaGFuZ2UgYWN0dWFsbHkgcmVsZXZh
bnQ/IElmIHRoZSB3aGlsZSBsb29wIHRoYXQgc3RhcnRzIGF0DQpsaW5lDQo+IDEzOSBpcyBuZXZl
ciBydW4gKGJlY2F1c2UgY250X3BlcmlvZCBpcyA8PSA4MTkxKSBjbGtkaXYgaXMgemVybyBhbmQg
c28NCj4gdGhlIGNvbmRpdGlvbiBpcyBmYWxzZSB3aXRoIGFuZCB3aXRob3V0ICImJiBjbGtzZWwi
LiBJZiBob3dldmVyIHRoZQ0KPiB3aGlsZSBsb29wIGlzIGVudGVyZWQgYW5kIGNsa2RpdiBiZWNv
bWVzIGJpZ2dlciB0aGFuIFBXTV9DTEtfRElWX01BWA0KPiBjbGtzZWwgaXMgMSBhbmQgdGhlICIm
JiBjbGtzZWwiIGRvZXNuJ3QgbWFrZSBhIGRpZmZlcmVuY2UsIHRvby4NCj4gDQoNCllvdSBhcmUg
cmlnaHQsIEkgd2lsbCByZW1vdmUgdGhpcy4NCg0KPiBUaGUgY29kZSBpcyBoYXJkIHRvIGZvbGxv
dywgSSB3b25kZXIgaWYgdGhpcyBjb3VsZCBiZSBjbGVhbmVkIHVwIHdpdGgNCj4gc29tZSBjb21t
ZW50cyBhZGRlZCB0aGF0IGV4cGxhaW4gdGhlIGhhcmR3YXJlIGRldGFpbHMgZW5vdWdoIHRvIGJl
DQphYmxlDQo+IHRvIGFjdHVhbGx5IHVuZGVyc3RhbmQgdGhlIGNvZGUgd2l0aG91dCBoYXZpbmcg
dGhlIGhhcmR3YXJlIHJlZmVyZW5jZQ0KPiBtYW51YWwgaGFuZHkuDQo+IA0KDQpJcyBpdCBzdWZm
aWNpZW50IHRvIGFkZCBzb21lIGNvbnRleHQgaW50byBjb21tZW50IGxpa2UgdGhlIHJlc3BvbnNl
IG9mDQp0aGUgc2Vjb25kIHF1ZXN0aW9uPw0KDQoNCj4gPiAgCQlwd21fbWVkaWF0ZWtfY2xrX2Rp
c2FibGUoY2hpcCwgcHdtKTsNCj4gPiAgCQlkZXZfZXJyKGNoaXAtPmRldiwgInBlcmlvZCAlZCBu
b3Qgc3VwcG9ydGVkXG4iLCBwZXJpb2RfbnMpOw0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+
IEBAIC0xNTksNyArMTY4LDExIEBAIHN0YXRpYyBpbnQgcHdtX21lZGlhdGVrX2NvbmZpZyhzdHJ1
Y3QgcHdtX2NoaXANCipjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPiA+ICAJfQ0KPiA+
ICANCj4gPiAgCWNudF9kdXR5ID0gRElWX1JPVU5EX0NMT1NFU1RfVUxMKCh1NjQpZHV0eV9ucyAq
IDEwMDAsIHJlc29sdXRpb24pOw0KPiA+IC0JcHdtX21lZGlhdGVrX3dyaXRlbChwYywgcHdtLT5o
d3B3bSwgUFdNQ09OLCBCSVQoMTUpIHwgY2xrZGl2KTsNCj4gPiArCWlmIChjbGtzZWwpDQo+ID4g
KwkJcHdtX21lZGlhdGVrX3dyaXRlbChwYywgcHdtLT5od3B3bSwgUFdNQ09OLCBCSVQoMTUpIHwg
QklUKDMpIHwNCj4gPiArCQkJCSAgICBjbGtkaXYpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXB3bV9t
ZWRpYXRla193cml0ZWwocGMsIHB3bS0+aHdwd20sIFBXTUNPTiwgQklUKDE1KSB8IGNsa2Rpdik7
DQo+ID4gIAlwd21fbWVkaWF0ZWtfd3JpdGVsKHBjLCBwd20tPmh3cHdtLCByZWdfd2lkdGgsIGNu
dF9wZXJpb2QpOw0KPiA+ICAJcHdtX21lZGlhdGVrX3dyaXRlbChwYywgcHdtLT5od3B3bSwgcmVn
X3RocmVzLCBjbnRfZHV0eSk7DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiANCj4gQmVz
dCByZWdhcmRzDQo+IFV3ZQ0KPiANCj4NCg0KQmVzdCBSZWdhcmRzLA0KU2FtDQo=

