Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2E3A39C2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jun 2021 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFKCb0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Jun 2021 22:31:26 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:63458 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230212AbhFKCbZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jun 2021 22:31:25 -0400
X-UUID: 0b3cc9ed3c49425a9fce4c3b35d12a1c-20210611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dv+Qz7VgPb4x8JJap2AVvlVH5e24mB3GpvI0kMdk/as=;
        b=ImfLLzSfXqSsI/W+nq19GD0P+/DtoHMryCGaZU/5JXwuGBUmLLDTpimb8Z0u5sQ4FZRNwa+VleCpiacAu1AOeSc2oMnNaJGlPYoPcCioAoBTvOxTztZFfW64MkMbn2oRtWPEI3MLx+LqkBAmsCvssDNMoqw9jrYUa2U/lh4dQzo=;
X-UUID: 0b3cc9ed3c49425a9fce4c3b35d12a1c-20210611
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 511477463; Fri, 11 Jun 2021 10:29:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Jun
 2021 10:29:21 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 10:29:20 +0800
Message-ID: <1623378559.24490.12.camel@mszsdaap41>
Subject: Re: [PATCH v4 2/3] pwm: mtk-disp: move the commit to clock enabled
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>
Date:   Fri, 11 Jun 2021 10:29:19 +0800
In-Reply-To: <20210606211457.ya5nbp6fqevuhzwa@pengutronix.de>
References: <20210603100531.161901-1-jitao.shi@mediatek.com>
         <20210603100531.161901-3-jitao.shi@mediatek.com>
         <20210606211457.ya5nbp6fqevuhzwa@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2B4009F64EB28FF746E2C443C376190B28D238414B49AA5C781DE84D5A2B3E672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gU3VuLCAyMDIxLTA2LTA2IGF0IDIzOjE0ICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMDMsIDIwMjEgYXQgMDY6MDU6MzBQTSArMDgwMCwgSml0YW8gU2hp
IHdyb3RlOg0KPiA+IER1ZSB0byB0aGUgY2xvY2sgc2VxdWVuY2UgY2hhbmdpbmcsIHNvIG1vdmUg
dGhlIHJlZyBjb21taXQgdG8NCj4gDQo+IFdoaWNoIGNoYW5nZSBkbyB5b3UgcmVmZXIgdG8sIGhl
cmU/IFRoZSBwcmV2aW91cyBwYXRjaD8gSWYgc28sIEkgYXNzdW1lDQo+IHRoaXMgbWVhbnMgdGhl
IHNlcmllcyBpcyBub3QgYmlzZWN0YWJsZSBiZWNhdXNlIHRoZSBkcml2ZXIgaXMgYnJva2VuDQo+
IHdoZW4gb25seSB0aGUgZmlyc3QgcGF0Y2ggaXMgYXBwbGllZD8NCj4gDQpZZXMsIHRoaXMgcGF0
Y2ggaXMgZGVwZW5kIHRoZSBwcmV2aW91cyBwYXRjaC4NCkknbGwgc3F1YXNoIGl0IHRvIHRoZSBw
cmV2aW91cyBwYXRjaCBpbiBuZXh0IHZlcnNpb24uDQoNCg0KPiA+IGNvbmZpZygpLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCAyMCArKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMg
Yi9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYw0KPiA+IGluZGV4IGI1NzcxZTJjNTRiOC4uYjg3
YjNjMDBhNjg1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jDQo+
ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMNCj4gPiBAQCAtMTM1LDYgKzEzNSwx
MyBAQCBzdGF0aWMgaW50IG10a19kaXNwX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlw
LCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPiA+ICAJCW10a19kaXNwX3B3bV91cGRhdGVfYml0
cyhtZHAsIG1kcC0+ZGF0YS0+Y29tbWl0LA0KPiA+ICAJCQkJCSBtZHAtPmRhdGEtPmNvbW1pdF9t
YXNrLA0KPiA+ICAJCQkJCSAweDApOw0KPiA+ICsJfSBlbHNlIHsNCj4gDQo+IFlvdSBkcm9wcGVk
IHRoZSBjb2RlIGNvbW1lbnQ/IElzIGl0IHdyb25nPyBPciBpcyBpdCB0b28gb2J2aW91cyB0byBi
ZQ0KPiBtZW50aW9uZWQ/DQo+IA0KDQpJJ2xsIGZpeCB0aGVtIG5leHQgdmVyaXNvbi4NCg0KPiA+
ICsJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+YmxzX2RlYnVnLA0K
PiA+ICsJCQkJCSBtZHAtPmRhdGEtPmJsc19kZWJ1Z19tYXNrLA0KPiA+ICsJCQkJCSBtZHAtPmRh
dGEtPmJsc19kZWJ1Z19tYXNrKTsNCj4gPiArCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRw
LCBtZHAtPmRhdGEtPmNvbjAsDQo+ID4gKwkJCQkJIG1kcC0+ZGF0YS0+Y29uMF9zZWwsDQo+ID4g
KwkJCQkJIG1kcC0+ZGF0YS0+Y29uMF9zZWwpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCXJldHVy
biAwOw0KPiA+IEBAIC0yMDgsMTkgKzIxNSw2IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdtX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIA0KPiA+ICAJcGxhdGZvcm1f
c2V0X2RydmRhdGEocGRldiwgbWRwKTsNCj4gPiAgDQo+ID4gLQkvKg0KPiA+IC0JICogRm9yIE1U
MjcwMSwgZGlzYWJsZSBkb3VibGUgYnVmZmVyIGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVyDQo+ID4g
LQkgKiBhbmQgc2VsZWN0IG1hbnVhbCBtb2RlIGFuZCB1c2UgUFdNX1BFUklPRC9QV01fSElHSF9X
SURUSC4NCj4gPiAtCSAqLw0KPiA+IC0JaWYgKCFtZHAtPmRhdGEtPmhhc19jb21taXQpIHsNCj4g
PiAtCQltdGtfZGlzcF9wd21fdXBkYXRlX2JpdHMobWRwLCBtZHAtPmRhdGEtPmJsc19kZWJ1ZywN
Cj4gPiAtCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzaywNCj4gPiAtCQkJCQkgbWRwLT5k
YXRhLT5ibHNfZGVidWdfbWFzayk7DQo+ID4gLQkJbXRrX2Rpc3BfcHdtX3VwZGF0ZV9iaXRzKG1k
cCwgbWRwLT5kYXRhLT5jb24wLA0KPiA+IC0JCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsLA0KPiA+
IC0JCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiAgfQ0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiANCg0KQmVzdCBSZWdh
cmRzDQpKaXRhbw0KDQo=

