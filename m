Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615BB11E28B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2019 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLMLMG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Dec 2019 06:12:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16232 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726608AbfLMLMG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Dec 2019 06:12:06 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDB9en6024382;
        Fri, 13 Dec 2019 12:09:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=kn47bweEcRXjNdyx35wkLzXPiXE55ZWSwCRUAHvHXbA=;
 b=Dz5wO7vZTR3jxun7AaF48i5y0oFQ2pc7iZZlcyCCMeEoJin3Bpr6/iMy3UkCYKt/ZWhQ
 FnZweSWH/7Z+75WlrB0Nv/PaYOaTctPY/lJeJK7XWfivA3LkclQTOj0XdVWBVEoG8kqg
 Hu5En5eAQ443ZWw24bS3/KmdLOnlMX2xdv+Jscv6hMMc6aDrHjHGXm8zt4SUx8fl56Y+
 k5LGLR/wSWPEfXHBoIAouty4/WnpjAucLQXa1OYl2PH5Aoud0m63qvG61hMwRjXFIqZR
 kXp3fj/NXokm2BmWU4zdAm02br9XtEkBSQl1VqzBi0Q45nZDkXOJm5NRjnTQyS0+Jbcj 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wrbrfvrut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 12:09:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0406A100034;
        Fri, 13 Dec 2019 12:09:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BDC572AB94E;
        Fri, 13 Dec 2019 12:09:52 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Dec
 2019 12:09:52 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 13 Dec 2019 12:09:51 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
Thread-Topic: [PATCH] dt-bindings: pwm: fix nodename pattern
Thread-Index: AQHVsDO3MV8l3Qp4hkSb3+FMjTJqHqe1R/UAgADP3oCAALXMAIABDOQA
Date:   Fri, 13 Dec 2019 11:09:51 +0000
Message-ID: <7b0167ca-6797-b89a-dd61-fa6db30022f7@st.com>
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
 <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
 <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
 <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
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
Content-ID: <AD768ADD1075174EBB9969B3FA46AC4C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAxMi8xMi8xOSA4OjA3IFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MTIsIDIwMTkgYXQgMjoxNiBBTSBCZW5qYW1pbiBHQUlHTkFSRA0KPiA8YmVuamFtaW4uZ2FpZ25h
cmRAc3QuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAxMi8xMS8xOSA4OjUyIFBNLCBSb2IgSGVycmlu
ZyB3cm90ZToNCj4+PiBPbiBXZWQsIERlYyAxMSwgMjAxOSBhdCA5OjAwIEFNIEJlbmphbWluIEdh
aWduYXJkDQo+Pj4gPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4gd3JvdGU6DQo+Pj4+IFR5cGlj
YWwgcHdtIG5vZGVzIHNob3VsZCBiZSBuYW1lZCBwd21AeHh4Lg0KPj4+PiBUaGUgcGF0dGVybiBz
aG91bGRuJ3QgbWF0Y2ggbm9kZXMgbmFtZWQgcHdtLXh4eCB0byBhdm9pZA0KPj4+PiBjb25mbGlj
dHMgd2l0aCBwaW5tdXggb3IgcHdtLWZhbiBub2Rlcy4NCj4+PiBJdCBvbmx5IG1hdGNoZXMgcHdt
LSQoYS1oZXgtbnVtYmVyKSwgbm90IGFueSBzdHJpbmcsIHNvIHRoYXQgc2hvdWxkbid0DQo+Pj4g
YmUgYSBwcm9ibGVtLiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhpbmdzIGxpa2UgR1BJTyBiYXNlZCBk
ZXZpY2VzIChub3QNCj4+PiBqdXN0IFBXTXMpIHdoaWNoIGRvbid0IGhhdmUgYW55IGFkZHJlc3Mu
DQo+Pj4NCj4+PiBQaW5tdXggbm9kZXMgYXJlIGdvaW5nIHRvIG5lZWQgdG8gYWRvcHQgc29tZSBz
b3J0IG9mIHN0YW5kYXJkIHBhdHRlcm4NCj4+PiB3ZSBjYW4gbWF0Y2ggb24uDQo+PiBJIGhhdmUg
cHVzaCBhIHBhdGNoIHRvIHN0b3AgdXNpbmcgJ0AnIGFuZCAnXycgaW4gcGlubXV4IGdyb3VwcyBu
YW1lczoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMTYyNTkx
Lw0KPj4gSXQgcmVtb3ZlIHRoZSB3YXJuaW5ncyB3aGVuIGNvbXBpbGluZyB0aGUgZGV2aWNldHJl
IHdpdGggVz0xMiBidXQgcHdtLnlhbWwNCj4+IGNvbXBsYWluIGJlY2F1c2UgcHdtIHBpbm11eCBp
cyBuYW1lZCBwd20tMS4NCj4+DQo+PiBIb3cgY2FuIEkgc29sdmUgdGhlc2UgaXNzdWVzIGF0IHRo
ZSBzYW1lIHRpbWUgPw0KPiBOYW1lIHRoZSBub2RlcyAqLXBpbnMgb3IgKi1waW5zLVswLTldLiBZ
b3UncmUgcHJvYmFibHkgZ29pbmcgdG8gbmVlZA0KPiBzb21lIHBhdHRlcm4gYW55d2F5cyB3aGVu
IHlvdSBkbyBhIHBpbm11eCBzY2hlbWEuDQorIEFsZXggYmVjYXVzZSB0aGF0IGltcGFjdCBwaW4g
bm9kZSBwYXR0ZXJuIGluIHN0LHN0bTMyLXBpbmN0cmwueWFtbA0KDQpCZW5qYW1pbg0KDQo+IFJv
Yg==
