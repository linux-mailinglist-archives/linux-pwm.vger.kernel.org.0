Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06D3529FA
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Apr 2021 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhDBKzT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Apr 2021 06:55:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27244 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBKzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Apr 2021 06:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617360917; x=1648896917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C4V1GGFVBgoggRMb32cMR8TwGsZm88g7GrsZ6bh+8X8=;
  b=iYr2oHiSnIBbSnXndYAGwhsfXpZ71jBLlaC2M/SpyGUC6A/DUROmZxj3
   UCtjdTAXbsYG3TpKx9oa8fBZum1YSpeCsdfZ28o/t3TPrg6b41c403xdq
   M6wWA8mCDK+hW6FKGOGSS1eOe7DgYjWBnVNjD8uVCNjyuLcuqy1inhs7R
   rCkveF/SldjhsLJS6ECKvi5nmPSG21R00dx+Ta4gf3kYv6Ax3y9O0xWcE
   tbHf+z8gSD18mEhqZXdvFtQAiM03VYv4qPbHp/V+Yt0AI31jh4Gun/e4p
   KQ4B697dp1qiNl5I2jCxGn2NnsFqV/AU38+EKedBF6Hg3BPQMSBpXX+7g
   A==;
IronPort-SDR: tva1DMiA2BqwB1ogX08L2tWqTYxFkzRwT7FGWScLluUY3oPX1kx6TX3VJrLOHzBCpGUT55Rt7m
 xB8s5NMNtvYiB7zK11A21KiQ2Bya+mgxNN0EreKK6QQMztBgF302xOSXiagoz9RoCfYsbA9KL2
 qef8cPUfmEeWwY1lERifNGG7OBYV9rMQ6tBW3HW30ZWlekVdWQMpfkakFDy05FvkwEOfgUrm1A
 uvpg2SgSumsAHo68ewQzNnAjMJ5Je1k08XEkDBSG9+toZtkdEanwTuq8Mx13i7VmugXie4jW+G
 uds=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="112251503"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 03:55:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 03:55:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 2 Apr 2021 03:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFhJIVfZv5PqZSL0SS/wUskS/h6Xf2VJQojm15gUq+xgv7l2qKcWOUM/k1/6UpH+DsilEBwW4I432RTnCjaCye/eg8hRLvc7XIs+FPIlu9wwU9jyQI+XggnzWP//afnWH3MWNpJhfw966lPcN1KkhWI7HDKo2A49OiMarci6q1pkcxzv0uTh3qZGzQrSBEz9EVtDqhVVRmxfe6SE4Dj4yombeWZpcEoKMs9eJsDHzZyHM3kqI9RuqdPi/fa9DqEfgUWjGopTmvCNbHaSil4beQSnEcv/r8/J6330U+Ey/VZcw1vkEs/s34Z47/x1oaM9jVwa1a7L6YmGf/JVGEHgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4V1GGFVBgoggRMb32cMR8TwGsZm88g7GrsZ6bh+8X8=;
 b=H9hV2h6jFpLWYq/Wu1ZYFuC5A1l20rTo5JFU7xJmNewXxTfTbiv+19F7PKwrQfG/LmDej1s/xZJd1IhS6LT8nlX/nctJJX4v6Y5A2quAC5J/FMNq4x5LSfDFlol/FWc1HcynEDzVmIijj7NX21xEDm/ZO+DFU3LFP6ZSCdrJtzOVmyUFwUV09upyhBJQQ3kmmVhHvTxizS2IygZUUhBjTm/lKQT3tXvevFCg7/IzVrDM+BXpW5ZMOFT5lZV69jGPEHUGc0fv/+2ioPChfAUW8bNDh7aONGraw9Zlvzsfs5yEgTxd4aaeePV0eGOxgwkeVo+HVt6X9MkbgaxR7WAyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4V1GGFVBgoggRMb32cMR8TwGsZm88g7GrsZ6bh+8X8=;
 b=tcKUK5acDlID1BqsUbVFupKSostqSg8S8qYIkAg1MxYovU2pAnZYcvrGmw/Z5ZQUR5M30SslvlyCTpTXykNXvd5bYxrbcFtamHTPdPcs3YGvQS1SL43PUR2kDyDD3VQfaobiEm42L+kTsou9Yg5S497ae4NCeVprYhjBsFF1JWM=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR1101MB2187.namprd11.prod.outlook.com (2603:10b6:4:51::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Fri, 2 Apr 2021 10:55:14 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Fri, 2 Apr 2021
 10:55:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-pwm@vger.kernel.org>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Thread-Topic: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Thread-Index: AQHXJ66otA5Ww2ByYEm53NIC/+uwhg==
Date:   Fri, 2 Apr 2021 10:55:14 +0000
Message-ID: <34080c7a-71d3-334c-498e-cb65dad9f817@microchip.com>
References: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.76.227.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68d0d09a-451b-4f0e-8011-08d8f5c5cb74
x-ms-traffictypediagnostic: DM5PR1101MB2187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21875CC7606573A1103723F2877A9@DM5PR1101MB2187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5lKFDcR1H6LxtGV9KE2MUipBKMGLEk6VLJcuHMTZnGSQX3YFbsrx4xOJtkbqrqJQMirjGufgm/WrxZqwXsPWX5yZZL6HoHXNZc+8bm8U+Daycsa/DBnJj6ujFiWBL7t//Q/alq/Sw0mLkovHpFODShq7Go6WgeGpBteOsukKBJsf9OkQDfGTwk/YRwfsRN1JuYTmBnc94/Kr9ALZt9Db6cAz/Ys/jHSRY+dmJOWJjkb9CBEepom7xOyjy0BvlSEhZb9ua8hT52RSpkGh2vb5G9dpnMJsy1FLPe0bVT++BO9XSe67cOpxVJMrT1SdsoPcZ1FYt4QbCQyy/lsIe/d0yh9zjRquqbB+34h+xt7sSjKJ5CgL7ezcQcqVWoSebCiTfknSC5MQSncGT2PLZYAUXfb46CWquW06aVlJ8uCmqFfPHnwG/lpCICTUM7f5eQ6h7D9Wz6CRI9Udl9ml3ZFI+WNRwYK6U5lT1zwoVUvJxa7Xis2FiOqDjCAg6PyBkkaeCsdFmeP9GJ+eiYQawGlSSZO9gHXRPzPy0wzDlhkBB+/D/ubz7GbDZx5RF/eOlGQIGPpGNENAALzDignNq6+UwwQxxYSk7P4GJePo5JpUCwVTwmD5rURgNqPePtLK+pe+cGPfUjiYISOFear8Xg3tXXkgCg9P/IpBnWI+T9WiPyQj/Hw8DOihtX7c5ZF87rI41kcXRTQd4CmWRvP7TEtDkg/uUJgcIJUawAtbBgxPeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39860400002)(86362001)(6506007)(316002)(110136005)(8676002)(54906003)(8936002)(66476007)(2906002)(36756003)(71200400001)(6486002)(478600001)(53546011)(38100700001)(6512007)(91956017)(31696002)(186003)(76116006)(66446008)(4326008)(5660300002)(2616005)(64756008)(66556008)(66946007)(31686004)(66574015)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUtBSks2cjlWVnJndzg0cXUzaVRFTSt3RmJqcW8wSmtjOEJ6YlRJMkEwM0d3?=
 =?utf-8?B?eExTRFM4ZVNyQnhZUk4xbDZpSkQ2T09NeWw4QjlBTnBqMGQ2eFpqQWIwaC8v?=
 =?utf-8?B?RXhyTVVFdHplbVpXMnk0NFRqYk5wNjYyeG1kRFk2QmNUVFNZYU5McDdTTS95?=
 =?utf-8?B?dXBERjd0VmJydTV4VUNjOGU5ci9oZHZtNlZvbEw1T2lhSEt6THMzZWF0cCty?=
 =?utf-8?B?cmpabnRYOHBYQ2pEZkdHTEI0eUtLWVVTbHkwN3lTQkZxR0VsbkdQY1A5TGto?=
 =?utf-8?B?Z0tDVUdkR01KN0pmR1JlVFcrTVliQlNLR2FsWnlOVC9xNmxuSzl1NGxubTBH?=
 =?utf-8?B?UEtnS0RZSmhodkQreFFRYm13M0NrcWxyVFdOWVBrUXdiY1BUNkRmWGFQL2tK?=
 =?utf-8?B?Ynpocit0OE1RTFNxZHoyMzB0UnJrazdSSnJPYXpXMzRraXdzQnd6QTM0Q1ZL?=
 =?utf-8?B?NytiNzFhWnhxSVFQcndMNDAxRFlSbjRyUHcyTk5JMk1oK05wZVVGQ1dBSWtU?=
 =?utf-8?B?OG1tdXlrZGw3clVzRkpwdDlWS1VySjFBMlEwNDZteU5JQTZOZEFhc0lzUXdy?=
 =?utf-8?B?cUJrNWhPZG1HRVV6RW5CQ3VJNEU5dHB4b0R0eW5xZ3lCeHIrbkFtalNKZTNF?=
 =?utf-8?B?bE14dVJKM3FSd21McGJadDdmSkxpRGFramlMU3dic2dKL3VoK1h6c3R4bmpN?=
 =?utf-8?B?NHVDYUdYR09zb3hMWVg4c3lvbVhjZlZIUkFiOS9OT2FPYVFhNmZQcHpCVElV?=
 =?utf-8?B?RGF3ZkFZWjNDKzZYdVVaak1DWjJFdFdMaDA2VytNTUNmc1c0YmNEMGxkTENW?=
 =?utf-8?B?YW03Ui93TjVNckRLMjBFS0NjSDJRbTdPZnBRWitXVFFFWHdyaEx4ekhnbm1i?=
 =?utf-8?B?bmZ2Y3VVRnlDdC9BTXk5OU1sTnlmV2txR091cjA2RTNUUlZyYXpJNFEwQzN2?=
 =?utf-8?B?S1JiOHBRMkZJc09VcTk5ZVFjUXpWRTJkWXNoU3VTay80RmJBdUJSa3NqeU1i?=
 =?utf-8?B?b1daV0x3UWRWcWljNjIzbU5zbEhCMENXejNsTlB0cFNJbnZLZzlUZjg2TlBB?=
 =?utf-8?B?Ymc2Q1lZRWw0VXd3aUhkYzR0dTdWc0hQdERHcEdsU0N6MC8wYzJsamZTblV5?=
 =?utf-8?B?THpHQmpGVytOVk03Sk1nQ2MrZUgrUDRwc0lPcExIQWxYbnZGaWtrRloxTjg0?=
 =?utf-8?B?MURZV3F0ZE03MDNsOGRseFhBWDUzUmUyZ0ZuVzlIbnNieU5KSXUyU2o2Tmo0?=
 =?utf-8?B?a0dkZG5KQ2pUWkNvSmFJTFpmcE1iSE5wOGRLcnU4b1FiTzc5d3hGZXlHTmJw?=
 =?utf-8?B?Vy9zUy9UZ1VFTllvSGJJamowbitXWVhQOUdiRDRNY29WYXVlVUxKTnBWUmZH?=
 =?utf-8?B?UWVWRGtlRDZEbGFJZTZQWGlRUFNJQi8vZmxwZmw3aTBhZmU5V21xSFpOL08y?=
 =?utf-8?B?T05XbE1jSUFscE9OTTMyb2F2dkNOWm12WDBaMTdvbmk0UGgyWjN5NEdsMG9i?=
 =?utf-8?B?RnJrMFRRRHFYaTV5aWFLVHAyTlhBOTR6QkhqbFpWOE55SlFHT1dlU1BtRlpR?=
 =?utf-8?B?Q1l2UHk4dytmNTFjT2ZCZks0c3lnanArUkxJR1pFYlBTREFFL0M2alBmdDdh?=
 =?utf-8?B?bGdrWHZWNndFejhybUliV2E2Z1E3MHZ6ZXhUVmFUZ1JSTjVjQk9WWVhSejlo?=
 =?utf-8?B?UEpITUVEU0NZQ2Fhc01kZkIrWTFBQVFBNjBZR1pZNW41RG8xOEp3TWU3UmU3?=
 =?utf-8?Q?QyjLZQpru+zJqROpsqDJbTTFQgHrboCmULLWuo0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683694CD988BDE4E962536AC18DE7011@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d0d09a-451b-4f0e-8011-08d8f5c5cb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 10:55:14.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+nBMUjE5jGyuCqpYzTwA6X3+rwchXapvPVRWHF1ooftS1HdwKGOGLRfM69z2l9e8S1f22YBI/BX5ihkfI97tlTbDgrPodqakaFk/drtEWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2187
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQpPbiAyNC4wMy4yMDIxIDIxOjU2LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBCZWZvcmUgcHdtY2hp
cF9yZW1vdmUoKSByZXR1cm5zIHRoZSBQV00gaXMgZXhwZWN0ZWQgdG8gYmUgZnVuY3Rpb25hbC4g
U28NCj4gcmVtb3ZlIHRoZSBwd21jaGlwIGJlZm9yZSBkaXNhYmxpbmcgdGhlIGNsb2NrLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT4+IC0tLQ0KDQpEb2VzIHRoaXMgbmVlZCBhIGZpeGVzIHRhZz8NCg0KT3RoZXIg
dGhhbiB0aGlzOg0KQWNrLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9j
aGlwLmNvbT4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0KDQo+ICBkcml2ZXJzL3B3bS9wd20tYXRt
ZWwuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jIGIvZHJp
dmVycy9wd20vcHdtLWF0bWVsLmMNCj4gaW5kZXggYTRkMGJlNmIyNjViLi5kNDlkYTcwODMzN2Yg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jDQo+ICsrKyBiL2RyaXZlcnMv
cHdtL3B3bS1hdG1lbC5jDQo+IEBAIC00NTAsMTAgKzQ1MCwxMiBAQCBzdGF0aWMgaW50IGF0bWVs
X3B3bV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gICAgICAg
ICBzdHJ1Y3QgYXRtZWxfcHdtX2NoaXAgKmF0bWVsX3B3bSA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiANCj4gKyAgICAgICBwd21jaGlwX3JlbW92ZSgmYXRtZWxfcHdtLT5jaGlwKTsN
Cj4gKw0KPiAgICAgICAgIGNsa191bnByZXBhcmUoYXRtZWxfcHdtLT5jbGspOw0KPiAgICAgICAg
IG11dGV4X2Rlc3Ryb3koJmF0bWVsX3B3bS0+aXNyX2xvY2spOw0KPiANCj4gLSAgICAgICByZXR1
cm4gcHdtY2hpcF9yZW1vdmUoJmF0bWVsX3B3bS0+Y2hpcCk7DQo+ICsgICAgICAgcmV0dXJuIDA7
DQo+ICB9DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXRtZWxfcHdtX2Ry
aXZlciA9IHsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
