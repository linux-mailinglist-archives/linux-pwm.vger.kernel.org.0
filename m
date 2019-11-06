Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0AF1F70
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 21:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfKFUA7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Nov 2019 15:00:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6910 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfKFUA6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Nov 2019 15:00:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6Jvkil015972;
        Wed, 6 Nov 2019 20:58:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=UUgh3Lo+qJDaOFvLiwrfPtl8yZf8yXbRZxfUc/25B9k=;
 b=hV6Qq7ATFv/8SsV9FqDv6wBDql0Y1AzlHZtF/pE7cBOUhEnHCNjNPQ7/rC1dW/nPwKUB
 a0OzrCjvqCSA4SOt4sy3nHKKVtvfPjHPVpZrqJLS4NlojDMcHuVIZ/FWXr/HRZTgrks/
 BlbLa6VY7mFYiredqke+l/zYKVBlHsdW09g1cQgTDiuxMx09Xgyyo+Vfj/qo30XzR5m2
 P14QcPUq5kQ2voYcxgPhN+sVMJyIG2rB6T+zIwFjszb1By9+GtEK4jXjKuXk3WdRqEJ/
 UpaKfnZbH5gT01tK+1VHarybQjZgLMwlpOcdGHGHEq4XqJposqZxXqr7c4J4X5zBYyqs Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w41vdrs0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 20:58:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3794C10002A;
        Wed,  6 Nov 2019 20:58:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1BA882BEC50;
        Wed,  6 Nov 2019 20:58:09 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Nov
 2019 20:58:08 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 6 Nov 2019 20:58:08 +0100
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
Subject: Re: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings
 to json-schema
Thread-Topic: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings
 to json-schema
Thread-Index: AQHVj+cHKYpjTBsaoUanlMQvDBdoeKd9f6aAgAABnACAAQcxAA==
Date:   Wed, 6 Nov 2019 19:58:08 +0000
Message-ID: <29d97cd1-4dc2-24a1-182f-d1bf6956ee5b@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-2-benjamin.gaignard@st.com>
 <20191106041023.GB5294@bogus> <20191106041608.GA24747@bogus>
In-Reply-To: <20191106041608.GA24747@bogus>
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
Content-ID: <9AC39F460CE5B44394ED8C7013DF655A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_07:2019-11-06,2019-11-06 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAxMS82LzE5IDU6MTYgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAw
NSwgMjAxOSBhdCAxMDoxMDoyM1BNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4+IE9uIFRo
dSwgT2N0IDMxLCAyMDE5IGF0IDAxOjMwOjM3UE0gKzAxMDAsIEJlbmphbWluIEdhaWduYXJkIHdy
b3RlOg0KPj4+IENvbnZlcnQgdGhlIFNUTTMyIGNvdW50ZXIgYmluZGluZyB0byBEVCBzY2hlbWEg
Zm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hDQo+PiBQcm9iYWJseSB0aGlzIHNob3VsZCBhbGwgYmUg
MSBmaWxlIGluc3RlYWQuDQo+IEFsc28sIGNoZWNrcGF0Y2ggcmVwb3J0cyB0cmFpbGluZyB3aGl0
ZXNwYWNlIGluIHNldmVyYWwgb2YgeW91ciBwYXRjaGVzLg0KDQpJIHdpbGwgd3JpdGUgYWxsIGlu
IG9uZSBmaWxlIGFuZCBmaXggdHJhaWxpbmcgd2hpdGVzcGFjZSBpbiB2Mg0KDQpUaGFua3MgZm9y
IHlvdXIgcmV2aWV3DQoNCkJlbmphbWluDQoNCj4gLg0KPg0KPiBSb2I=
