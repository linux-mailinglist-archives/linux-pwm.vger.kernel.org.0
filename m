Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E441F4B743
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 13:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfFSLmp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 07:42:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44688 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbfFSLmp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 07:42:45 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JBfBx0001850;
        Wed, 19 Jun 2019 13:42:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=jAayPybMAxCHXtDmLft/T64tgWULV2g7e3s0ys/xt7c=;
 b=WTev4s7P/RCeq68dfxKoEPTgP9Bu7gbgDy+JYF9OEUdefIGTl9aNQ7UStjd8GSgen5Ca
 S19TE4IInepLFPfSV1l319VpIXdOHwhEyh1oQr98Jj5BagdyWQ47swgj6IoEbTXM8B54
 gUdZFzYlJvjbCpOgNfuoqGf8SzVcbG89clmuriaSYu2OxcAh9bMCfQQkNeId5K34gby5
 L4qdHbzzuVs+LXlTEKq4ZC1ATUILfD6qqAZsapjsq1CBCrtAzwXXHYkDSMQfnmj2li4v
 6sYjb425JJGipZeGXggc030pb7IiR0K7woGZj7DhMavWYjJ9yH4WY7QDP2e98etQOj9p Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813bm3k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 13:42:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AEF331;
        Wed, 19 Jun 2019 11:42:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3DCAF26D5;
        Wed, 19 Jun 2019 11:42:23 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 13:42:23 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 19 Jun 2019 13:42:22 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Fabrice GASNIER <fabrice.gasnier@st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/5] pwm: stm32: use 3 cells ->of_xlate()
Thread-Topic: [PATCH 2/5] pwm: stm32: use 3 cells ->of_xlate()
Thread-Index: AQHVJoSsYAMsPXn+akirjvBTdUuqe6aiuYoA
Date:   Wed, 19 Jun 2019 11:42:22 +0000
Message-ID: <c583094f-2429-d5f1-09df-fff54ab33af1@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
 <1560937925-8990-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1560937925-8990-3-git-send-email-fabrice.gasnier@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <25284ABC327AEA4991DCD1504D64AD22@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiA2LzE5LzE5IDExOjUyIEFNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IFNUTTMyIFRp
bWVycyBzdXBwb3J0IGdlbmVyaWMgMyBjZWxscyBQV00gdG8gZW5jb2RlIFBXTSBudW1iZXIsIHBl
cmlvZCBhbmQNCj4gcG9sYXJpdHkuDQo+DQo+IEZpeGVzOiA3ZWRmNzM2OTIwNWIgKCJwd206IEFk
ZCBkcml2ZXIgZm9yIFNUTTMyIHBsYWZ0b3JtIikNClJldmlld2VkLWJ5OiBCZW5qYW1pbiBHYWln
bmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJy
aWNlIEdhc25pZXIgPGZhYnJpY2UuZ2FzbmllckBzdC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
cHdtL3B3bS1zdG0zMi5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1zdG0zMi5jIGIvZHJpdmVycy9w
d20vcHdtLXN0bTMyLmMNCj4gaW5kZXggNGY4NDI1NS4uNzQwZTJkZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9wd20vcHdtLXN0bTMyLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdtLXN0bTMyLmMN
Cj4gQEAgLTYwOCw2ICs2MDgsOCBAQCBzdGF0aWMgaW50IHN0bTMyX3B3bV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAlwcml2LT5yZWdtYXAgPSBkZGF0YS0+cmVnbWFw
Ow0KPiAgIAlwcml2LT5jbGsgPSBkZGF0YS0+Y2xrOw0KPiAgIAlwcml2LT5tYXhfYXJyID0gZGRh
dGEtPm1heF9hcnI7DQo+ICsJcHJpdi0+Y2hpcC5vZl94bGF0ZSA9IG9mX3B3bV94bGF0ZV93aXRo
X2ZsYWdzOw0KPiArCXByaXYtPmNoaXAub2ZfcHdtX25fY2VsbHMgPSAzOw0KPiAgIA0KPiAgIAlp
ZiAoIXByaXYtPnJlZ21hcCB8fCAhcHJpdi0+Y2xrKQ0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7
