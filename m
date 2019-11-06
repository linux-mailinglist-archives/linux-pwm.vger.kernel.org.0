Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63551F1F5D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 20:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfKFT5d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Nov 2019 14:57:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35376 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726713AbfKFT5d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Nov 2019 14:57:33 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6JptN7005880;
        Wed, 6 Nov 2019 20:57:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=1CNNscptave/lqyrM0vWi7IpPuigDr/RT5NEfJL41FQ=;
 b=Fcdm62Ktp46Y/3LYYjtSxMRrvFQp4GYMyrRi+iset1jAuVX3iFh/tFbP/CkL4MdMYJ4G
 g9+k/y3ak7z6W4mBnvIkafNIXHb86pUJSLczFSIpVz9W+BvbUQwM1zGNibmLD0vX4/KM
 grsaJNycvyIloP56dhfcZw10tG4yZps5haoAXmv9Qkpz70xyuKbuzOoiyxGL5786f3tK
 jJOLeUEUwBcUwc4Od/hpyv4x849CC+NlqD/lfZ+qB7a/y6wnlCPF0uZvHG7GFJxnY6r+
 5zKcg/nuEMz8Q+pXaKmpKsg4QdXmo2/ZQS8lm8QKi/XJ0aDGCQDTN5J61Bpxh0FBRzEv 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vgrs27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 20:57:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 598EC10002A;
        Wed,  6 Nov 2019 20:57:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 372512C64DA;
        Wed,  6 Nov 2019 20:57:07 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Nov
 2019 20:57:06 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 6 Nov 2019 20:57:06 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Thread-Topic: [PATCH 4/4] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Thread-Index: AQHVj+cLo82I5KV3I0iahvx4EoqxqKd9gQYAgAEHIoA=
Date:   Wed, 6 Nov 2019 19:57:06 +0000
Message-ID: <41c43d09-9371-8b23-a3dd-e43f5df5c5bc@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-5-benjamin.gaignard@st.com>
 <20191106041518.GC5294@bogus>
In-Reply-To: <20191106041518.GC5294@bogus>
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
Content-ID: <1FEAA25580E4C446BBC3EF2B74C20D0E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_07:2019-11-06,2019-11-06 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAxMS82LzE5IDU6MTUgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUaHUsIE9jdCAz
MSwgMjAxOSBhdCAwMTozMDo0MFBNICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+
IENvbnZlcnQgdGhlIFNUTTMyIHRpbWVycyBiaW5kaW5nIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNp
bmcganNvbi1zY2hlbWENCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8
YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9zdCxzdG0zMi10aW1lcnMueWFtbCAgIHwgOTEgKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3RtMzItdGltZXJzLnR4dCAg
ICAgICB8IDczIC0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgOTEgaW5z
ZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3N0LHN0bTMyLXRpbWVycy55YW1sDQo+
PiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWZkL3N0bTMyLXRpbWVycy50eHQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zdCxzdG0zMi10aW1lcnMueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3Qsc3RtMzItdGltZXJzLnlhbWwNCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjNmMGE2NWZiMmJjMA0KPj4g
LS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9zdCxzdG0zMi10aW1lcnMueWFtbA0KPj4gQEAgLTAsMCArMSw5MSBAQA0KPj4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4g
KyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvbWZkL3N0LHN0bTMyLXRpbWVycy55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBTVE1pY3Jv
ZWxlY3Ryb25pY3MgU1RNMzIgVGltZXJzIGJpbmRpbmdzDQo+PiArDQo+PiArZGVzY3JpcHRpb246
IHwNCj4+ICsgIFRoaXMgaGFyZHdhcmUgYmxvY2sgcHJvdmlkZXMgMyB0eXBlcyBvZiB0aW1lciBh
bG9uZyB3aXRoIFBXTSBmdW5jdGlvbmFsaXR5OiBcDQo+IERvbid0IG5lZWQgdGhlIFwNCm9rDQo+
DQo+PiArICAgIC0gYWR2YW5jZWQtY29udHJvbCB0aW1lcnMgY29uc2lzdCBvZiBhIDE2LWJpdCBh
dXRvLXJlbG9hZCBjb3VudGVyIGRyaXZlbiBieSBhIHByb2dyYW1tYWJsZSBcDQo+PiArICAgICAg
cHJlc2NhbGVyLCBicmVhayBpbnB1dCBmZWF0dXJlLCBQV00gb3V0cHV0cyBhbmQgY29tcGxlbWVu
dGFyeSBQV00gb3VwdXRzIGNoYW5uZWxzLiBcDQo+PiArICAgIC0gZ2VuZXJhbC1wdXJwb3NlIHRp
bWVycyBjb25zaXN0IG9mIGEgMTYtYml0IG9yIDMyLWJpdCBhdXRvLXJlbG9hZCBjb3VudGVyIGRy
aXZlbiBieSBhIFwNCj4+ICsgICAgICBwcm9ncmFtbWFibGUgcHJlc2NhbGVyIGFuZCBQV00gb3V0
cHV0cy5cDQo+PiArICAgIC0gYmFzaWMgdGltZXJzIGNvbnNpc3Qgb2YgYSAxNi1iaXQgYXV0by1y
ZWxvYWQgY291bnRlciBkcml2ZW4gYnkgYSBwcm9ncmFtbWFibGUgcHJlc2NhbGVyLg0KPj4gKw0K
Pj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2Fp
Z25hcmRAc3QuY29tPg0KPj4gKyAgLSBGYWJyaWNlIEdhc25pZXIgPGZhYnJpY2UuZ2FzbmllckBz
dC5jb20+DQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6ICIuLi9wd20vc3Qsc3RtMzIt
cHdtLnlhbWwjIg0KPj4gKyAgLSAkcmVmOiAiLi4vaWlvL3RpbWVyL3N0LHN0bTMyLXRpbWVyLXRy
aWdnZXIueWFtbCMiDQo+PiArICAtICRyZWY6ICIuLi9jb3VudGVyL3N0LHN0bTMyLXRpbWVyLWNu
dC55YW1sIyINCj4gVGhpcyB3b3JrcywgYnV0IEkgcHJlZmVyIHRoZSBjaGlsZCBub2RlIG5hbWVz
IGJlIGxpc3RlZCB1bmRlciBwcm9wZXJ0aWVzDQo+IGhlcmUgd2l0aCBhIHJlZjoNCj4NCj4gY291
bnRlcjoNCj4gICAgJHJlZjogIi4uL2NvdW50ZXIvc3Qsc3RtMzItdGltZXItY250LnlhbWwjIg0K
SWYgSSB3cm90ZSBldmVyeXRoaW5nIGluIG9uZSBmaWxlIEkgZ3Vlc3Mgd2hhdCB3b24ndCBiZSBu
ZWVkZWQgYW55bW9yZQ0KPg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxl
Og0KPj4gKyAgICBjb25zdDogc3Qsc3RtMzItdGltZXJzDQo+PiArDQo+PiArICByZWc6DQo+PiAr
ICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBjbG9ja3M6DQo+PiArICAgIG1heEl0ZW1zOiAx
DQo+PiArDQo+PiArICBjbG9jay1uYW1lczoNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBj
b25zdDogaW50DQo+PiArDQo+PiArICByZXNldDoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsN
Cj4+ICsgIGRtYXM6IHRydWUNCj4gSG93IG1hbnk/DQoNCmZyb20gMCB1cCB0byA4LCBidXQgSSBk
b24ndCBrbm93IHRoZSBzeW50YXggZm9yIHRoYXQuIG1pbkl0ZW1zID0gMCBpc24ndCANCmFjY2Vw
dGVkLg0KDQpBbnkgaGludHMgZm9yIG1lID8NCg0KPg0KPj4gKw0KPj4gKyAgZG1hLW5hbWVzOiB0
cnVlDQo+IFdoYXQgYXJlIHRoZSBuYW1lcz8NCg0KaXQgY291bGQgYmUgY2gxIC4uLiBjaDgsICJ0
cmlnIiBvciAidXAiIGluIGFueSBvcmRlci4NCg0KQWdhaW4gSSBoYXZlbid0IGJlIGFibGUgdG8g
ZmluZCBhIHN5bnRheCB0aGF0IGFsbG93IHRvIGxpc3QgdGhlIG5hbWVzIA0KYW5kIHVzZSB0aGVt
IGluIGFueSBvcmRlcnMuDQoNCkJlbmphbWluDQoNCj4NCj4+ICsNCj4+ICsgICIjYWRkcmVzcy1j
ZWxscyI6DQo+PiArICAgIGNvbnN0OiAxDQo+PiArDQo+PiArICAiI3NpemUtY2VsbHMiOg0KPj4g
KyAgICBjb25zdDogMA0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSAiI2FkZHJlc3MtY2Vs
bHMiDQo+PiArICAtICIjc2l6ZS1jZWxscyINCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSBy
ZWcNCj4+ICsgIC0gY2xvY2tzDQo+PiArICAtIGNsb2NrLW5hbWVzDQo+PiArDQo+PiArZXhhbXBs
ZXM6DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0bTMy
bXAxLWNsa3MuaD4NCj4+ICsgICAgdGltZXJzMjogdGltZXJANDAwMDAwMDAgew0KPj4gKyAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4g
KyAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RtMzItdGltZXJzIjsNCj4+ICsgICAgICByZWcgPSA8
MHg0MDAwMDAwMCAweDQwMD47DQo+PiArICAgICAgY2xvY2tzID0gPCZyY2MgVElNMl9LPjsNCj4+
ICsgICAgICBjbG9jay1uYW1lcyA9ICJpbnQiOw0KPj4gKyAgICAgIGRtYXMgPSA8JmRtYW11eDEg
MTggMHg0MDAgMHgxPiwNCj4+ICsgICAgICAgICAgICAgPCZkbWFtdXgxIDE5IDB4NDAwIDB4MT4s
DQo+PiArICAgICAgICAgICAgIDwmZG1hbXV4MSAyMCAweDQwMCAweDE+LA0KPj4gKyAgICAgICAg
ICAgICA8JmRtYW11eDEgMjEgMHg0MDAgMHgxPiwNCj4+ICsgICAgICAgICAgICAgPCZkbWFtdXgx
IDIyIDB4NDAwIDB4MT47DQo+PiArICAgICAgZG1hLW5hbWVzID0gImNoMSIsICJjaDIiLCAiY2gz
IiwgImNoNCIsICJ1cCI7DQo+PiArICAgICAgcHdtIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUg
PSAic3Qsc3RtMzItcHdtIjsNCj4+ICsgICAgICAgICNwd20tY2VsbHMgPSA8Mz47DQo+PiArICAg
ICAgICBzdCxicmVha2lucHV0ID0gPDAgMSA1PjsNCj4+ICsgICAgICB9Ow0KPj4gKyAgICAgIHRp
bWVyQDAgew0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxzdG0zMi10aW1lci10cmlnZ2Vy
IjsNCj4+ICsgICAgICAgIHJlZyA9IDwwPjsNCj4+ICsgICAgICB9Ow0KPj4gKyAgICAgIGNvdW50
ZXIgew0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxzdG0zMi10aW1lci1jb3VudGVyIjsN
Cj4+ICsgICAgICB9Ow0KPj4gKyAgICB9Ow0KPj4gKw0KPj4gKy4uLg==
