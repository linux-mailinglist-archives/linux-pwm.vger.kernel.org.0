Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389FBCB710
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfJDJKR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 05:10:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40344 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbfJDJKR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 05:10:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9496h28013482;
        Fri, 4 Oct 2019 11:09:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=7TARpab+GgoE0XBcyvsvh3bkT5vF11t+SCOxhdeo7fQ=;
 b=R1YBBAy55psjTN8CG/9ymKL/R7b8tlaSp8Wjzn3mltynAMswP9ewRPEupwriuQJK8lQ3
 aySdSt+GWiwmsCuJuMfUoqKoLbkZrsST4/k3HAAoLrEyB31XIRtTBD61uTmm84p0Eadr
 KfKXVdmR6tHBoTFMJ5cfgKjAReiEsCIpYcu7XS+qANk+h5uZshQL8pm6heXt19X/bVMd
 dsfxpgAD8vB4PSxgyCP+9SLaOSfjNR7pPB8a7uDAXM40q+NVea5eB0u+SOGK+Pye5jLy
 3Eg3f/4wmzaw3oAGjJL3O4WS/eMZ7rzagGPhlFj1O0mB17zI6TG+oXhKFdFAnLvkIVN/ vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vcem3esn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 11:09:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78F3510002A;
        Fri,  4 Oct 2019 11:09:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A5FD2B00C1;
        Fri,  4 Oct 2019 11:09:52 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 11:09:52 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 4 Oct 2019 11:09:51 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Yizhuo <yzhai003@ucr.edu>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Linux-stm32] [PATCH] pwm: stm32: Fix the usage of uninitialized
 variable in stm32_pwm_config()
Thread-Topic: [Linux-stm32] [PATCH] pwm: stm32: Fix the usage of uninitialized
 variable in stm32_pwm_config()
Thread-Index: AQHVenxIJtBrJYZdmEWJltaWtr2m56dKEG6A
Date:   Fri, 4 Oct 2019 09:09:51 +0000
Message-ID: <e6824330-d331-798d-0f0a-1952db028900@st.com>
References: <20191004044649.2405-1-yzhai003@ucr.edu>
 <20191004062336.jidzrytx4z5talro@pengutronix.de>
In-Reply-To: <20191004062336.jidzrytx4z5talro@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9356118905A9F942ADA617A804B4486F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_05:2019-10-03,2019-10-04 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAxMC80LzE5IDg6MjMgQU0sIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxsbywN
Cj4NCj4gT24gVGh1LCBPY3QgMDMsIDIwMTkgYXQgMDk6NDY6NDlQTSAtMDcwMCwgWWl6aHVvIHdy
b3RlOg0KPj4gSW5zaWRlIGZ1bmN0aW9uIHN0bTMyX3B3bV9jb25maWcoKSwgdmFyaWFibGUgInBz
YyIgYW5kICIgYXJyIg0KPj4gY291bGQgYmUgdW5pbml0aWFsaXplZCBpZiByZWdtYXBfcmVhZCgp
IHJldHVybnMgLUVJTlZBTHMuDQo+PiBIb3dldmVyLCB0aGV5IGFyZSB1c2VkIGxhdGVyIGluIHRo
ZSBpZiBzdGF0ZW1lbnQgdG8gZGVjaWRlDQo+PiB0aGUgcmV0dXJuIHZhbHVlIHdoaWNoIGlzIHBv
dGVudGlhbGx5IHVuc2FmZS4NCg0KSGkgWWl6aHVvLA0KDQpsaWtlIGZvciB0aGUgeW91ciBwYXRj
aCBpbiBJSU8gdHJpZ2dlciByZWdtYXBfcmVhZCBjb3VsZCBvbmx5IGZhaWxlZA0KaWYgdGhlIGhh
cmR3YXJlIGJsb2NrIGlzIG5vIG1vcmUgY2xvY2tlZCBhbmQgaW4gdGhpcyBjYXNlIHdlIHdvbid0
IA0KcmV0dXJuIG9mIHJlZ21hcF9yZWFkLg0KVGVzdGluZyByZWdtYXBfcmVhZCgpIHJldHVybiB2
YWx1ZSBqdXN0IGFkZCBjb2RlIGJ1dCBkb2Vzbid0IHByb3ZpZGUgYSANCnZhbGlkIGluZm9ybWF0
aW9uLg0KSWYgeW91IHJlYWxseSB3YW50IHRvIGxvZyBhbGwgdGhlIHBvc3NpYmxlIGVycm9ycyBj
YXNlcyBwbGVhc2UgZG8gaXQgaW4gDQpyZWdtYXAgY29kZSBpdHNlbGYgYW5kDQpub3QgaW4gKmFs
bCogdGhlIGRyaXZlcnMuDQoNClRoYW5rcywNCg0KQmVuamFtaW4NCg0KPj4NCj4+IFRoZSBzYW1l
IGNhc2UgaGFwcGVucyBpbiBmdW5jdGlvbiBzdG0zMl9wd21fZGV0ZWN0X2NoYW5uZWxzKCkNCj4+
IHdpdGggdmFyaWFibGUgImNjZXIiLCBidXQgd2UgY2Fubm90IGp1c3QgcmV0dXJuIC1FSU5WQUwg
YmVjYXVzZQ0KPj4gdGhlIGVycm9yIGNvZGUgaXMgbm90IGFjY2VwdGFibGUgYnkgdGhlIGNhbGxl
ci4gQXNsbywgdGhlIHZhcmlhYmxlDQo+IHMvQXNsby9BbHNvLw0KPg0KPj4gImNjZXIiIGluIGZ1
bmN0aW9uc3RtMzJfcHdtX2RldGVjdF9jb21wbGVtZW50YXJ5KCkgY291bGQgYWxzbyBiZQ0KPiBz
L2Z1bmN0aW9uc3RtMzJfcHdtX2RldGVjdF8vZnVuY3Rpb24gc3RtMzJfcHdtX2RldGVjdF8vDQo+
DQo+PiB1bmluaXRpYWxpemVkLCBzaW5jZSBzdG0zMl9wd21fZGV0ZWN0X2NvbXBsZW1lbnRhcnko
KSByZXR1cm5zIHZvaWQsDQo+PiB0aGUgcGF0Y2ggaXMgbm90IGVhc3kuDQo+IGFjdGl2ZV9jaGFu
bmVscygpIGlzIGFsc28gYWZmZWN0ZWQuIEFsc28gdGhlcmUgYXJlIGNhbGxzIHRvDQo+IHJlZ21h
cF91cGRhdGVfYml0cyB3aGljaCBzaG91bGQgaGF2ZSB0aGVpciByZXR1cm4gdmFsdWVzIGNoZWNr
ZWQuDQo+DQo+IFdoaWxlIGEgcGF0Y2ggdG8gZml4IHRoZXNlIGFsbCBpcyBub3QgdHJpdmlhbCBp
dCBpcyBjZXJ0YWlubHkgcG9zc2libGUNCj4gYW5kIEkgd291bGQgcHJlZmVyIHRvIGZpeCB0aGUg
cHJvYmxlbSBjb21wbGV0ZWx5Lg0KPg0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+
