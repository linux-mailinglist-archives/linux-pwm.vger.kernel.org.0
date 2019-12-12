Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B122E11C6E3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Dec 2019 09:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfLLIRA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Dec 2019 03:17:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63288 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbfLLIRA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Dec 2019 03:17:00 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC8DAAo003441;
        Thu, 12 Dec 2019 09:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=KsOBRBxWPhArWs9FKdG6YL4u5JqiyaVQsva4ZRyLfUM=;
 b=l+U2Sw+3S5Qt8f6sZFDqdyII+hJpuDX71t7BGx1q2JiXki9K5UtQWlpu6h75hNa/+OdO
 3nfKh7vB7tbzKpFhMfKFbC95L1IWb6OnOCRlzrUgC5x+2fYuQu7vwgS3xK1r+a6cpxPD
 XnnLku/CZqnWnpjgwdHBepA7sVKInP1xAvLfbHVygG1Cvy3LbWx1EuyVaH5ZLNSw2b/e
 TW6m6xp/kjxXqq/Z6rPgKvUJ/wsHCqGSUmQVgul6SrKs7obanfHU/abC8GSHXyC/ZMJt
 ZIeiwvw9TsxjRgzhz4xEh/UGTCCP/14G3xPP8h4V9Opy5DnPufSDRHT4wndvo0yDxhpR kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wt5wv3dpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 09:16:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1A75100048;
        Thu, 12 Dec 2019 09:16:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 749142A96FD;
        Thu, 12 Dec 2019 09:16:48 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Dec
 2019 09:16:48 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 12 Dec 2019 09:16:47 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
Thread-Topic: [PATCH] dt-bindings: pwm: fix nodename pattern
Thread-Index: AQHVsDO3MV8l3Qp4hkSb3+FMjTJqHqe1R/UAgADP3oA=
Date:   Thu, 12 Dec 2019 08:16:47 +0000
Message-ID: <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
 <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
In-Reply-To: <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
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
Content-ID: <F6BB0E9CA0FA9F408718F9859B2DA2E8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-12 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAxMi8xMS8xOSA4OjUyIFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gV2VkLCBEZWMg
MTEsIDIwMTkgYXQgOTowMCBBTSBCZW5qYW1pbiBHYWlnbmFyZA0KPiA8YmVuamFtaW4uZ2FpZ25h
cmRAc3QuY29tPiB3cm90ZToNCj4+IFR5cGljYWwgcHdtIG5vZGVzIHNob3VsZCBiZSBuYW1lZCBw
d21AeHh4Lg0KPj4gVGhlIHBhdHRlcm4gc2hvdWxkbid0IG1hdGNoIG5vZGVzIG5hbWVkIHB3bS14
eHggdG8gYXZvaWQNCj4+IGNvbmZsaWN0cyB3aXRoIHBpbm11eCBvciBwd20tZmFuIG5vZGVzLg0K
PiBJdCBvbmx5IG1hdGNoZXMgcHdtLSQoYS1oZXgtbnVtYmVyKSwgbm90IGFueSBzdHJpbmcsIHNv
IHRoYXQgc2hvdWxkbid0DQo+IGJlIGEgcHJvYmxlbS4gVGhpcyBpcyBuZWVkZWQgZm9yIHRoaW5n
cyBsaWtlIEdQSU8gYmFzZWQgZGV2aWNlcyAobm90DQo+IGp1c3QgUFdNcykgd2hpY2ggZG9uJ3Qg
aGF2ZSBhbnkgYWRkcmVzcy4NCj4NCj4gUGlubXV4IG5vZGVzIGFyZSBnb2luZyB0byBuZWVkIHRv
IGFkb3B0IHNvbWUgc29ydCBvZiBzdGFuZGFyZCBwYXR0ZXJuDQo+IHdlIGNhbiBtYXRjaCBvbi4N
CkkgaGF2ZSBwdXNoIGEgcGF0Y2ggdG8gc3RvcCB1c2luZyAnQCcgYW5kICdfJyBpbiBwaW5tdXgg
Z3JvdXBzIG5hbWVzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEx
NjI1OTEvDQpJdCByZW1vdmUgdGhlIHdhcm5pbmdzIHdoZW4gY29tcGlsaW5nIHRoZSBkZXZpY2V0
cmUgd2l0aCBXPTEyIGJ1dCBwd20ueWFtbA0KY29tcGxhaW4gYmVjYXVzZSBwd20gcGlubXV4IGlz
IG5hbWVkIHB3bS0xLg0KDQpIb3cgY2FuIEkgc29sdmUgdGhlc2UgaXNzdWVzIGF0IHRoZSBzYW1l
IHRpbWUgPw0KDQpCZW5qYW1pbg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWln
bmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcHdtLnlhbWwgfCAyICstDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3B3bS55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9wd20ueWFtbA0KPj4gaW5kZXggZmE0Zjlk
ZTkyMDkwLi4yOWI4Njg4NmMyODIgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcHdtL3B3bS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcHdtL3B3bS55YW1sDQo+PiBAQCAtMTEsNyArMTEsNyBAQCBtYWludGFp
bmVyczoNCj4+DQo+PiAgIHByb3BlcnRpZXM6DQo+PiAgICAgJG5vZGVuYW1lOg0KPj4gLSAgICBw
YXR0ZXJuOiAiXnB3bShALip8LVswLTlhLWZdKSokIg0KPj4gKyAgICBwYXR0ZXJuOiAiXnB3bShA
LipbMC05YS1mXSkqJCINCj4+DQo+PiAgICAgIiNwd20tY2VsbHMiOg0KPj4gICAgICAgZGVzY3Jp
cHRpb246DQo+PiAtLQ0KPj4gMi4xNS4wDQo+Pg==
