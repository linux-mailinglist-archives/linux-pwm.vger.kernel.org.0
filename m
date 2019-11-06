Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3323FF1F4C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 20:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfKFTw3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Nov 2019 14:52:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727143AbfKFTw2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Nov 2019 14:52:28 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6JpwtI006207;
        Wed, 6 Nov 2019 20:51:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=dXWQhy/QZEcGaBhSm66JXjcU12XRc8OvLvAzH4r41mg=;
 b=oXEuQU4S3LfBHVDUf3lnpLWDhxs5Hb8uYs8V0tVEKxlMQs9coghHmU+r/W2Vo6KlURK9
 pCe9dGrTEtHM2dAenD4IGpDlV2ShZURN9ieLyVA0ow6ZA4gP7hinFmBuSBcBBluGuOV8
 vdrv4A04m2sobVgVwMkgkD0UD57KKx4J1Bt85r0rgQpf1kjj0ZlfQ8z2qmM1K7t5u9YS
 C8+ZzuEcBm2V3Lz2NAarxLWtaL1apkPby8aFaUIf7rvUFYJ7a/XZv4axUvv7LcVG1qYT
 iDXO60vXVrI4q/nhQk98kJp6ILppi13xl3fpNTLLO+jewsQcKDCS7jk6E/xc9PkBcAft eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vgrrfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 20:51:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 331D710002A;
        Wed,  6 Nov 2019 20:51:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EADAA2B59BA;
        Wed,  6 Nov 2019 20:51:56 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Nov
 2019 20:51:56 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 6 Nov 2019 20:51:56 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Thread-Topic: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Thread-Index: AQHVj+cJH/57OeJDpUmui1hejwyMnqd5PYeAgAMTgQCAAS2pgIABCAWA
Date:   Wed, 6 Nov 2019 19:51:56 +0000
Message-ID: <d0196570-9140-c775-742c-89092056e651@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com>
 <20191103110841.3ad3ecfb@archlinux>
 <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
 <20191106040657.GA5294@bogus>
In-Reply-To: <20191106040657.GA5294@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <24C3780FC5D0044A86C0AFBAA270E024@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_07:2019-11-06,2019-11-06 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAxMS82LzE5IDU6MDYgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAw
NSwgMjAxOSBhdCAxMTowNzoxNkFNICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+
IExlIGRpbS4gMyBub3YuIDIwMTkgw6AgMTI6MDgsIEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtl
cm5lbC5vcmc+IGEgw6ljcml0IDoNCj4+PiBPbiBUaHUsIDMxIE9jdCAyMDE5IDEzOjMwOjM4ICsw
MTAwDQo+Pj4gQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4gd3Jv
dGU6DQo+Pj4NCj4+Pj4gQ29udmVydCB0aGUgU1RNMzIgSUlPIHRyaWdnZXIgYmluZGluZyB0byBE
VCBzY2hlbWEgZm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+Pj4gSSdt
IGZhciBmcm9tIGdyZWF0IG9uIHRoZXNlIGFzIHN0aWxsIGhhdmVuJ3QgdGFrZW4gdGhlIHRpbWUg
SSBzaG91bGQgdG8gbGVhcm4NCj4+PiB0aGUgeWFtbCBzeW50YXggcHJvcGVybHkuICBBIGZldyBj
b21tZW50cyBpbmxpbmUgaG93ZXZlciBiYXNlZCBtb3N0bHkgb24gdGhpcw0KPj4+IGRvZXNuJ3Qg
cXVpdGUgbG9vayBsaWtlIG90aGVyIG9uZXMgSSd2ZSBzZWVuIHJlY2VudGx5Lg0KPj4+DQo+Pj4g
VGhhbmtzLA0KPj4+DQo+Pj4gSm9uYXRoYW4NCj4+Pg0KPj4+PiAtLS0NCj4+Pj4gICAuLi4vYmlu
ZGluZ3MvaWlvL3RpbWVyL3N0LHN0bTMyLXRpbWVyLXRyaWdnZXIueWFtbCB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysNCj4+Pj4gICAuLi4vYmluZGluZ3MvaWlvL3RpbWVyL3N0bTMyLXRpbWVy
LXRyaWdnZXIudHh0ICAgICB8IDI1IC0tLS0tLS0tLS0tLQ0KPj4+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNDQgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+Pj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGltZXIvc3Qsc3Rt
MzItdGltZXItdHJpZ2dlci55YW1sDQo+Pj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGltZXIvc3RtMzItdGltZXItdHJpZ2dlci50
eHQNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9paW8vdGltZXIvc3Qsc3RtMzItdGltZXItdHJpZ2dlci55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90aW1lci9zdCxzdG0zMi10aW1lci10cmlnZ2VyLnlh
bWwNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi4x
YzhjOGI1NWU4Y2QNCj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL3RpbWVyL3N0LHN0bTMyLXRpbWVyLXRyaWdnZXIueWFt
bA0KPj4+PiBAQCAtMCwwICsxLDQ0IEBADQo+Pj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+Pj4gKyVZQU1MIDEuMg0KPj4+PiAr
LS0tDQo+Pj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby90aW1lci9z
dCxzdG0zMi10aW1lci10cmlnZ2VyLnlhbWwjDQo+Pj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+Pj4gKw0KPj4+PiArdGl0bGU6IFNU
TWljcm9lbGVjdHJvbmljcyBTVE0zMiBUaW1lcnMgSUlPIHRpbWVyIGJpbmRpbmdzDQo+Pj4+ICsN
Cj4+Pj4gK21haW50YWluZXJzOg0KPj4+PiArICAtIEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1p
bi5nYWlnbmFyZEBzdC5jb20+DQo+Pj4+ICsgIC0gRmFicmljZSBHYXNuaWVyIDxmYWJyaWNlLmdh
c25pZXJAc3QuY29tPg0KPj4+PiArDQo+Pj4+ICtwcm9wZXJ0aWVzOg0KPj4+PiArICAkbm9kZW1h
bmU6DQo+Pj4gbm9kZW5hbWU/DQo+PiBUaGF0IHdpbGwgYmUgaW4gdjINCj4gTm8sICRub2RlbmFt
ZSBpcyBjb3JyZWN0LiBUaGUgJyQnIHNpZ25pZmllcyBzb21ldGhpbmcgd2UgZ2VuZXJhdGUgYW5k
DQo+IGFkZCBpbi4gSU9XLCBub3QgYSByZWFsIHByb3BlcnR5LiBJIGd1ZXNzIHdlIGNvdWxkIGhh
dmUgdXNlZCAnbmFtZScgaGVyZQ0KPiBhbmQgc3R1Y2sgd2l0aCB0cmFkaXRpb25hbCBPcGVuRmly
bXdhcmUuDQpsZXQncyBnbyBmb3IgJG5hbWUNCj4+Pj4gKyAgICBwYXR0ZXJuOiAiXnRpbWVyQFsw
LTldKyQiDQo+Pj4+ICsgICAgdHlwZTogb2JqZWN0DQo+Pj4+ICsNCj4+Pj4gKyAgICBkZXNjcmlw
dGlvbjoNCj4+Pj4gKyAgICAgIG11c3QgYmUgYSBzdWItbm9kZSBvZiBhbiBTVE0zMiBUaW1lciBk
ZXZpY2UgdHJlZSBub2RlDQo+Pj4+ICsNCj4+Pj4gKyAgICBwcm9wZXJ0aWVzOg0KPj4+PiArICAg
ICAgY29tcGF0aWJsZToNCj4+Pj4gKyAgICAgICAgb25lT2Y6DQo+Pj4gZW51bSBpcyBJIHRoaW5r
IHByZWZlcnJlZCBmb3IgdGhlc2UuDQo+PiBhcyB5b3UgbGlrZSBpdCB3aWxsIGJlIGluIHYyDQo+
Pg0KPj4+PiArICAgICAgICAgIC0gY29uc3Q6IHN0LHN0bTMyLXRpbWVyLXRyaWdnZXINCj4+Pj4g
KyAgICAgICAgICAtIGNvbnN0OiBzdCxzdG0zMmg3LXRpbWVyLXRyaWdnZXINCj4+Pj4gKw0KPj4+
PiArICAgICAgcmVnOiB0cnVlDQo+Pj4gTm9ybWFsbHkgc29tZSBpbmZvIGZvciB3aGF0IHRoZSBy
ZWcgdmFsdWUgaXMuLg0KPj4gSSBjYW4ndCBwdXQgImRlc2NyaXB0aW9uIiBvbiB0aGlzIGZpZWxk
IGJlY2F1c2UgdGhlIHN5bnRheCBkb2Vzbid0IGFsbG93IGl0Lg0KPj4gSSB3aWxsIGFkZCBhIGNv
bW1lbnQgaW4gdjIgdG8gZXhwbGFpbiB3aGF0IHJlZyBpcy4NCj4gaXRlbXM6DQo+ICAgIC0gbWF4
aW11bTogPG1heCB0aW1lciBudW1iZXI+DQoNCnJlZyBpcyBhbiBpbmRleCBmcm9tIDAgdXAgdG8g
WCwgSSB3aWxsIHRyeSB3aXRoIHlvdXIgc3ludGF4Lg0KDQpUaGFua3MsDQoNCkJlbmphbWluDQoN
Cj4NCj4gUm9i
