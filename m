Return-Path: <linux-pwm+bounces-4540-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8CA02659
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 14:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82392188582F
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8141F5E6;
	Mon,  6 Jan 2025 13:18:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6323A6;
	Mon,  6 Jan 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169515; cv=fail; b=kNJmEHcD1xt131bcWL/2mB0Y1h+G+toJegnneFgUjQqpKU5lvJpKmpwqbrtoVM4IhOdeBKNfYIkgEfcETEidHiOfvH4c5QxP73wGbqFGtxaBL4TMm4mwB5YKbucnjvF7uU/fOOW9mKsYCMFlrm5hkcqHiYCgoOnSct3copGi8/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169515; c=relaxed/simple;
	bh=5kUlc9DkfJSzXH5S27n2joPPaiayI1CeGIKlAZE7NDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gy/qIkjRwJEDnyJ4xZWNtjac8bA9zA4mq1+43GAZz8B5HplzK4fI2LVtGcb5FKhXrilfL82PbWuyX5swGDqm3TMESLWbT3aSEdWxAiuySmPYsoCmi9ppnbTVIAwsU1zRMV7edUeIGLEQr3oSeGkGM7BQp6MbdVcdIScGpNPmhpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ0PR01MB1223.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::8) by ZQ2PR01MB1225.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 13:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNjRR/8gmRCKeA4EZMzw/XHIlBRR5v2Af2XTmNnfO6aMfg92qMqCtsQ5M7Xki0mmugfK4LTFr4GgFG0jV6QvJS3aT8H/Jm02jZkQazZ3hcX658k0kqtykBDDyXHKr9Mr+6ztYysUyEnpnqcSqfYPxVYmph2tXHc2hMJana6JUOhB5VKt4oHaeyVPxpALtCTOh1f7q+g/JKm/rtk17oSQaEz7agtfhlxyK1QeF0JS2eEsPzzSoyiMpMKzCghBQg23645/TuWBd9DhcO5Ei+qGojOtXePGpNJoBOby9dDcyzHGX6bDOcHQItiPgsb+1XLh9tqT84CgzBaOwH+lmNoeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kUlc9DkfJSzXH5S27n2joPPaiayI1CeGIKlAZE7NDk=;
 b=mX+Q0ckM0o9/3HwU06cV3RYQ6gYyB5aHCglZdW7dWewwBncQR0TQTyoY8bRGrs5Ge82KYx7jww45Ey7c5rF8b/K14NUjSOc4swy2RAcw5C1y4PiPCseNmEk4EbiWqONaA1vDtlO1YGdPuq51Y6/cK5uweTH3fQoxwS/X8kXXyK/MwHTAtlCkTJw6yA5jQoCjnB/SKXtPR39OatEWJ4EXcjqSd2TxGzyiOYdmUmZcgpDZkrqIWwDZokd88kv3sNZ1irjOpxP8yWRrHfbnQDHAH59wPEzmTfmv4wuwE6TJVqViQ4duDe2boVCsXwJbwQ0iUqnTp4oPuGX7X29SEJgLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1223.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 10:08:21 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%5])
 with mapi id 15.20.8314.015; Mon, 6 Jan 2025 10:08:20 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Maud Spierings <maud_spierings@hotmail.com>
CC: Hal Feng <hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "ukleinek@kernel.org" <ukleinek@kernel.org>
Subject: RE: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Index: AQHbKNsymVbYlUSgHUKyRrqbTLJ87bMIsNsAgAFCl4A=
Date: Mon, 6 Jan 2025 10:08:20 +0000
Message-ID:
 <ZQ0PR01MB1253510046CF4C521A9B6ADB9F10A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
 <AM7P189MB100935C2EB7BC185C6567A7AE3172@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <AM7P189MB100935C2EB7BC185C6567A7AE3172@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ0PR01MB1253:EE_|ZQ0PR01MB1223:EE_|ZQ2PR01MB1225:EE_
x-ms-office365-filtering-correlation-id: de9526ef-64cb-4622-96bf-08dd2e3a0c81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 7hTzN9MfIPbkyHSVGXwFVOchD3ePQdJ5smwuIW7dPuQ+hr+NA7GEzgvowsEGFaYSP8gg9JyZeOvRY68fLRmzLoukvZdZcd7Y7LF03zmse3xzHu+pJv1+XFDUUugEKuzDLmilqtvB/WmX/TS9ZeOTlMfVR9j3sP1fjz1RjQm0iDTicBbMvqKL37KsKwr/ijFrV4xwmbXYQ6+PrZ4XC0+hxz+c8e41FXrH4bkwd3N84yj0I05ORmSdpskfvW6b09jN/2H66HnfRG/62Awl9NCeA7BPihztmbi540uIprh2ZCOF8GglKi1wrogunjCsrckaOZmSJUzlpCGQiUMfNnEf15BgE5NkAeaQ3oV+C4XblC1j04LdajjppCIN120SxJ5H1z6E9n3vWGcTzAfTIZ9nYSBMmwfkg/cur4toFCfSyfjeirbLTWKroyDmdzItVMrD+VaK0hdWzklUr16oQFW6mc3lJRwvhb9/m7KiTI9QKj8CL2BiQayzcMFrXHG0pDcY/ONj4W5A7nZ1gvyaWLpIgac4D45plq+i1Oh43ZzzYXSYC2Sp4jmFOYFxdwXr5x4ylniCTAwcgc75Tlv5vOlaYA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjEzTUsvRlo2dzhvMGlHaU1DQUVKQVVOb0ZiejlWR3NhRFdzUWJWSUs3NWUr?=
 =?utf-8?B?NEVnUmkwZTA5UWw0alBxSC8zekNwbnNPZ0ttWDFibC9FaFhlWG96SnZVUkIw?=
 =?utf-8?B?NUoxc1dGS1N3T1VyYlJOeDJYWnYxZG1keENaN3AyUk41UFZwK1NXczBHcUlo?=
 =?utf-8?B?ZnFRaW5LeFFFYWlDRENLbXhKeWVuRGFnWFNpcXpTNjAvakR3MUpZUERaRitt?=
 =?utf-8?B?a3hqSCtTcWFsd2VMd2s2aFNYTk0wSUhmbUR0TThMQ2VuM2pXbVJCTk5XV0M3?=
 =?utf-8?B?aWc0SURFOXdYMHFFZ1VmbWl1RUJ2dGF6LzQ3QzU4TFA0aE9iaDRkRHdrMUxj?=
 =?utf-8?B?UVQrWVUyNGFQMkxQTHF2WUp0WU80aTdIbS9LZlVWdGxKMWNxUWhoTFNpZHFy?=
 =?utf-8?B?RlpCNVVRNzU3MUdDYWttOXRwU1dldXQ4WC9jUXhKNTViTlpDVkpMMHV1c2Vx?=
 =?utf-8?B?V3VzMnpGTFMwQ3FPUTZHNXNNSkRVU2w0Rkc4VkpvTmtZOWw2TmRjdnVQQllI?=
 =?utf-8?B?ZTFrWDJyWGJ4SkVWTXBEd3I3Ris3blhuQ3A3OHZKNTlqVHdscm8rR29RSmdz?=
 =?utf-8?B?a2lkbVcrSmlNUDRSNWJmSFZFR3BLQTFkRGVSU0MxYXNwYXg0Y1U3YTBHY092?=
 =?utf-8?B?MDBZY0FVME4ramVkNElFYk5sMFZHYnNYcFpsM0QwbEhCS2tybDdJR3BJQWps?=
 =?utf-8?B?R3pNeUc0YkplMmk1WEZtN1RUZmtuVllDeDBjY0hEM3F3eVlPUVhpRmJBVGpn?=
 =?utf-8?B?dlhtWm04M3VjYmliOG1vekM4UUJ6R2hlbUVQak9ldThzNGxYeFZXbFlId3NB?=
 =?utf-8?B?L2F2c1NnT2RIRS80a2xKQUpoQ2tGWUhzNlpWclgwTUxsUmU4Wk5OYmN6bGRI?=
 =?utf-8?B?eGlLSnRFbVdVQlVMam9vbXkyN2c4Tzd0dVNwaTBSZmRzRUV6Qmkzdll2dGJU?=
 =?utf-8?B?WWYwcnhKOWVuSkdoQUpOTC9SVy81RDA1NWVVejVHeE93bWUybWtvNlBuVS9T?=
 =?utf-8?B?VmtUTXJDK3RhdkkxaU1rMitPSzZyam5rVmd2RXgwTXdtOTNYRXJTYUlMS1BI?=
 =?utf-8?B?WUFESEdpbzF0RzcxanFGYmpvUGY4NXFDbDRVSGNKM0lycFFkY2VGODRyOUlG?=
 =?utf-8?B?SkdSbEllZXl1bms3enJwRmtiK21DenR6b1hjRnJnRWxXVjNDeGNzYUlwdmha?=
 =?utf-8?B?NlRCYURkL2tZWGh2L2JmV3pUc0hEYjM1WDE5VXY2SElFajFlM1M3aW9ud241?=
 =?utf-8?B?YUF3NTRZQVhnVndBY0pSSDJRN1g2R1ZUYTYrMzF3YWRaaUp4RC9mUE5lb3F2?=
 =?utf-8?B?WDJ0WjZHdjA5MWJ6U3hGL01GNDlWejcyaGRFZVNmeE9GZHd0U09qcXY0SC9G?=
 =?utf-8?B?MDk1KzdOTXFkRkZrZ2RBTnlYR2ZUQUZMSEtSQXBKd1FNOExzTE5qZzd2VWN3?=
 =?utf-8?B?UmVsRStoQjUzN2xLMFlpSTBWN2IvRzNLb1dZa29lK3VDcEt5UjhXUmdvUjlv?=
 =?utf-8?B?VG5rR2xrZ2FpaHRKemlhNk51c0xBaGFiZEdQaUt3U2k0UXVybHBxbDFmUnFN?=
 =?utf-8?B?YnZEVnRUamh5bGY3bGM3ZmNKS3BRalpOOFIvWmx0TGhLNHZPWmRwcHo1T3gr?=
 =?utf-8?B?M3BZRHNIZnZBQTl0OVlybVI1REZmVGNhczd6TkNGVW4vb0hTZnpqbGZpNTJu?=
 =?utf-8?B?bXBzOXJ2UEY2S0RHZE83dW9YYUExVlUvbmNKeDRBQUY2OWRvR3V1Vytyb2xv?=
 =?utf-8?B?Z3dMK1RBbkxhWk9SUExXem5xUS9KQTV6RHMrdTZzVTAwSEhoZWxUUUQ5R2J1?=
 =?utf-8?B?VjhzSTI5dEg5TGdLRWV1R01TUVE3a0VhcEFibWQvSklUM1h0NW5IM2RDNWly?=
 =?utf-8?B?UUcrME1WTmhOMlhJdm1uRkRCQXk3MFBMWHpKOXBYZGtsQkVlR1JSbjlIYTI5?=
 =?utf-8?B?OVRjazlRdmNOcjFoclhSVDIxWnB6bG5WM2oyd0RsZG94MVFkeTBiamt1UlFR?=
 =?utf-8?B?RU5XR2sveEgzTStVbU5LeS9GWHRDeHBJRmJCdWppc0VubzE0QWc2ME5WdGh2?=
 =?utf-8?B?aWhkcGpPeW9Qd0ovU05KTEpyYXlEY2NDT1Z1KzVqdDN4aHdMUnJvWk9mMzVI?=
 =?utf-8?B?ZXZrSnhIMm9HcGVVTjRKdmtmMEozcmJrMGRkUFVSQ0ZoRDhVU214dEpabmNj?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: de9526ef-64cb-4622-96bf-08dd2e3a0c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 10:08:20.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMZpcPHU2LJecAz3TrriO/ASP7eumbJxnyzNq/kQSYuDVPWedyXkJLX3XTD8mAdAfqEep7dehZlVtjcuhQt0mOZQaxgoLEOQVpGXrZc0DBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1223
X-OriginatorOrg: starfivetech.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF1ZCBTcGllcmluZ3Mg
PG1hdWRfc3BpZXJpbmdzQGhvdG1haWwuY29tPg0KPiBTZW50OiAyMDI15bm0MeaciDXml6UgMjI6
NTENCj4gVG86IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0KPiBD
YzogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1
dHJvbml4LmRlOyB1a2xlaW5la0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE2
XSBwd206IG9wZW5jb3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVsbG8gV2ls
bGlhbSwNCj4gDQo+IA0KPiBJIHRlc3RlZCB0aGlzIHBhdGNoIG9uIG15IGRlZXBjb21wdXRpbmcg
Zm1sMTN2MDEgd2l0aCBhIHB3bS1iYWNrbGlnaHQgYW5kIEkNCj4gYW0gZ2V0dGluZyBhbiBvb3Bz
Og0KPiANCj4gWyDCoMKgMTAuMzA4MjkwXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBhY2Nlc3Mg
dG8gdXNlciBtZW1vcnkgd2l0aG91dA0KPiB1YWNjZXNzIHJvdXRpbmVzIGF0IHZpcnR1YWwgYWRk
cmVzcyAwMDAwMDAwMjAwMDAwMDAxIFsgwqDCoDEwLjMxOTAzOF0gT29wcw0KPiBbIzFdIFsgwqDC
oDEwLjMyMTMxOF0gTW9kdWxlcyBsaW5rZWQgaW46IHB3bV9ibCgrKSBzZmN0ZW1wIGRlc2lnbndh
cmVfaTJzDQo+IHNuZF9zb2Nfc3BkaWZfdHggZG1fbW9kIGNvbmZpZ2ZzIGlwX3RhYmxlcyB4X3Rh
YmxlcyB2c19kcm0gZHJtX2RtYV9oZWxwZXINCj4gc3RtbWFjIHBjc194cGNzIHBjaWVfc3RhcmZp
dmUgcGh5X2poNzExMF91c2IgcGh5X2poNzExMF9wY2llIHBoeV9qaA0KPiA3MTEwX2RwaHlfcngg
cGh5X2dlbmVyaWMgb3ZlcmxheSBqaDcxMTBfdHJuZyBqaDcxMTBfdGRtIGpoNzExMF9wd21kYWMN
Cj4gaW5ub19oZG1pIGRybV9rbXNfaGVscGVyIGkyY19oaWRfb2YgaTJjX2hpZCBoaWRfbXVsdGl0
b3VjaCBoY2lfdWFydCBkcm0NCj4gZHJtX3BhbmVsX29yaWVudGF0aW9uX3F1aXJrcyBjbGtfc3Rh
cmZpdmVfamg3MTEwX3ZvdXQgY2xrX3N0YXJmaXZlDQo+IF9qaDcxMTBfc3RnIGNsa19zdGFyZml2
ZV9qaDcxMTBfaXNwIGNsa19zdGFyZml2ZV9qaDcxMTBfYW9uDQo+IGNsa19zdGFyZml2ZV9qaDcx
MDBfYXVkaW8gY2RuczNfc3RhcmZpdmUgY2RuczMgY2Ruc191c2JfY29tbW9uIHJvbGVzIGJ0aW50
ZWwNCj4gYnJpZGdlIHN0cCBsbGMgYmx1ZXRvb3RoIGxpYmFlcyBlY2RoX2dlbmVyaWMgZWNjIGJh
Y2tsaWdodCBlZml2YXJmcw0KPiBbIMKgwqAxMC4zNzU0ODNdIENQVTogMyBVSUQ6IDAgUElEOiAz
MDcgQ29tbTogKHVkZXYtd29ya2VyKSBOb3QgdGFpbnRlZA0KPiA2LjEzLjAtcmM0LTAwMDMyLWdh
MjdhMzQ2NGU2YWItZGlydHkgIzE2IFsgwqDCoDEwLjM4NTIyN10gSGFyZHdhcmUgbmFtZToNCj4g
VW5rbm93biBVbmtub3duIFByb2R1Y3QvVW5rbm93biBQcm9kdWN0LCBCSU9TIDIwMjEuMTAgMTAv
MDEvMjAyMQ0KPiBbIMKgwqAxMC4zOTM1NzZdIGVwYyA6IG9jb3Jlc19wd21fZ2V0X3N0YXRlKzB4
MjIvMHhjYSBbIMKgwqAxMC4zOTgyMDRdIMKgcmEgOg0KPiBwd21fZ2V0X3N0YXRlX2h3KzB4MTBj
LzB4MTMyIFsgwqDCoDEwLjQwMjY1MV0gZXBjIDogZmZmZmZmZmY4MDRmOGQ0OCByYSA6DQo+IGZm
ZmZmZmZmODA0ZjgxZjQgc3AgOg0KPiBmZmZmZmZjNjAwZjFiNWMwDQo+IFsgwqDCoDEwLjQwOTg3
NV0gwqBncCA6IGZmZmZmZmZmODE0Zjg2NTggdHAgOiBmZmZmZmZkNmMzZWZlNDAwIHQwIDoNCj4g
MDAwMDAwMDAwMDAwMDAwMA0KPiBbIMKgwqAxMC40MTcwOTZdIMKgdDEgOiAwMDAwMDAwMDAwMDAw
MDQwIHQyIDogZmZmZmZmZmY4MTRhMDQ5OCBzMCA6DQo+IGZmZmZmZmM2MDBmMWI2MDANCj4gWyDC
oMKgMTAuNDI0MzE3XSDCoHMxIDogZmZmZmZmZDZjMGI5YjgwMCBhMCA6IGZmZmZmZmM2MDA3YjAw
MDAgYTEgOg0KPiBmZmZmZmZkNmMwYjliYmI4DQo+IFsgwqDCoDEwLjQzMTUzOV0gwqBhMiA6IGZm
ZmZmZmM2MDBmMWI2OTAgYTMgOiAwMDAwMDAwMDAwMDAwMDAwIGE0IDoNCj4gMDAwMDAwMDAwMDAw
MDAwMA0KPiBbIMKgwqAxMC40Mzg3NjBdIMKgYTUgOiAwMDAwMDAwMjAwMDAwMDAxIGE2IDogZmZm
ZmZmZDZjMDdmZDkxOCBhNyA6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gWyDCoMKgMTAuNDQ1OTgy
XSDCoHMyIDogZmZmZmZmZmY4MGU2YjJjMCBzMyA6IGZmZmZmZmQ2YzBiOWJlYzAgczQgOg0KPiBm
ZmZmZmZjNjAwZjFiNjkwDQo+IFsgwqDCoDEwLjQ1MzIwNF0gwqBzNSA6IGZmZmZmZmQ2YzBiOWJi
YjggczYgOiAwMDAwMDAwMDAwMDAwMDAwIHM3IDoNCj4gZmZmZmZmZDZjMGI5YmI3OA0KPiBbIMKg
wqAxMC40NjA0MjZdIMKgczggOiBmZmZmZmZjNjAwZjFiYzkwIHM5IDogMDAwMDAwMDAwMDAwMDAw
MCBzMTA6DQo+IGZmZmZmZmM2MDBmMWJjNDANCj4gWyDCoMKgMTAuNDY3NjQ4XSDCoHMxMTogMDAw
MDAwMDAwMDAwMDAwMSB0MyA6IDAwMDAwMDAwMDAwMDAwMDAgdDQgOg0KPiAwMDAwMDAwMDAwMDAw
MDAyDQo+IFsgwqDCoDEwLjQ3NDg2OF0gwqB0NSA6IDAwMDAwMDAwMDAwMDAwMDAgdDYgOiAwMDAw
MDAwMDAwMDAwNDAyDQo+IFsgwqDCoDEwLjQ4MDE3OV0gc3RhdHVzOiAwMDAwMDAwMjAwMDAwMTIw
IGJhZGFkZHI6IDAwMDAwMDAyMDAwMDAwMDENCj4gY2F1c2U6DQo+IDAwMDAwMDAwMDAwMDAwMGQN
Cj4gWyDCoMKgMTAuNDg4MDk2XSBbPGZmZmZmZmZmODA0ZjhkNDg+XSBvY29yZXNfcHdtX2dldF9z
dGF0ZSsweDIyLzB4Y2ENCj4gWyDCoMKgMTAuNDk0MDE5XSBbPGZmZmZmZmZmODA0ZjgxZjQ+XSBw
d21fZ2V0X3N0YXRlX2h3KzB4MTBjLzB4MTMyDQo+IFsgwqDCoDEwLjQ5OTc2OF0gWzxmZmZmZmZm
ZjgwNGY4MzM4Pl0NCj4gcHdtX3JlcXVlc3RfZnJvbV9jaGlwLnBhcnQuMCsweDExZS8weDE4Mg0K
PiBbIMKgwqAxMC41MDY1NTZdIFs8ZmZmZmZmZmY4MDRmODY0MD5dIG9mX3B3bV94bGF0ZV93aXRo
X2ZsYWdzKzB4MjYvMHg2NA0KPiBbIMKgwqAxMC41MTI3MzldIFs8ZmZmZmZmZmY4MDRmNzA4ND5d
IG9mX3B3bV9nZXQrMHgxNDYvMHgxZWEgWyDCoMKgMTAuNTE3OTY3XQ0KPiBbPGZmZmZmZmZmODA0
Zjg0ZTg+XSBwd21fZ2V0KzB4MTRjLzB4MWQ0IFsgwqDCoDEwLjUyMjkzNF0gWzxmZmZmZmZmZjgw
NGY4NTgyPl0NCj4gZGV2bV9wd21fZ2V0KzB4MTIvMHg0ZSBbIMKgwqAxMC41MjgxNjZdIFs8ZmZm
ZmZmZmYwMThhYjJhZT5dDQo+IHB3bV9iYWNrbGlnaHRfcHJvYmUrMHgxMDIvMHg4NGEgW3B3bV9i
bF0gWyDCoMKgMTAuNTM0OTYzXQ0KPiBbPGZmZmZmZmZmODA1YTA1YzQ+XSBwbGF0Zm9ybV9wcm9i
ZSsweDRlLzB4YjIgWyDCoMKgMTAuNTQwMzY5XQ0KPiBbPGZmZmZmZmZmODA1OWUwYjA+XSByZWFs
bHlfcHJvYmUrMHg4NC8weDIyYSBbIMKgwqAxMC41NDU2ODRdDQo+IFs8ZmZmZmZmZmY4MDU5ZTJi
Mj5dIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweDVjLzB4ZGMgWyDCoMKgMTAuNTUxNjk0XQ0KPiBb
PGZmZmZmZmZmODA1OWUzZjQ+XSBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MmMvMHhiMiBbIMKgwqAx
MC41NTc1MjldDQo+IFs8ZmZmZmZmZmY4MDU5ZTU3ND5dIF9fZHJpdmVyX2F0dGFjaCsweDZjLzB4
MTFhIFsgwqDCoDEwLjU2MzEwNF0NCj4gWzxmZmZmZmZmZjgwNTljMWM0Pl0gYnVzX2Zvcl9lYWNo
X2RldisweDYyLzB4YjAgWyDCoMKgMTAuNTY4Njc5XQ0KPiBbPGZmZmZmZmZmODA1OWRhZjI+XSBk
cml2ZXJfYXR0YWNoKzB4MWEvMHgyMiBbIMKgwqAxMC41NzM5OTNdDQo+IFs8ZmZmZmZmZmY4MDU5
ZDNlOD5dIGJ1c19hZGRfZHJpdmVyKzB4Y2UvMHgxZDYgWyDCoMKgMTAuNTc5NDgxXQ0KPiBbPGZm
ZmZmZmZmODA1OWYxMTQ+XSBkcml2ZXJfcmVnaXN0ZXIrMHg0MC8weGRhIFsgwqDCoDEwLjU4NDk3
MF0NCj4gWzxmZmZmZmZmZjgwNWEwMzRjPl0gX19wbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIrMHgx
Yy8weDI0DQo+IFsgwqDCoDEwLjU5MTQxNV0gWzxmZmZmZmZmZjAxOGIxMDIwPl0NCj4gcHdtX2Jh
Y2tsaWdodF9kcml2ZXJfaW5pdCsweDIwLzB4MTAwMCBbcHdtX2JsXSBbIMKgwqAxMC41OTg3MzBd
DQo+IFs8ZmZmZmZmZmY4MDAwZjEyYz5dIGRvX29uZV9pbml0Y2FsbCsweDVjLzB4MWFhIFsgwqDC
oDEwLjYwNDMwNl0NCj4gWzxmZmZmZmZmZjgwMDlmOTkyPl0gZG9faW5pdF9tb2R1bGUrMHg1Mi8w
eDFiMiBbIMKgwqAxMC42MDk3OTZdDQo+IFs8ZmZmZmZmZmY4MDBhMTBmMj5dIGxvYWRfbW9kdWxl
KzB4MTM3NC8weDE3N2UgWyDCoMKgMTAuNjE1Mjg0XQ0KPiBbPGZmZmZmZmZmODAwYTE2YzA+XSBp
bml0X21vZHVsZV9mcm9tX2ZpbGUrMHg3Ni8weGFlIFsgwqDCoDEwLjYyMTI5Ml0NCj4gWzxmZmZm
ZmZmZjgwMGExOGU0Pl0gX19yaXNjdl9zeXNfZmluaXRfbW9kdWxlKzB4MWI0LzB4MzFjDQo+IFsg
wqDCoDEwLjYyNzczNV0gWzxmZmZmZmZmZjgwOTgzY2Y0Pl0gZG9fdHJhcF9lY2FsbF91KzB4MWE4
LzB4MWQ0DQo+IFsgwqDCoDEwLjYzMzM5OV0gWzxmZmZmZmZmZjgwOThkOGEyPl0NCj4gX25ld192
bWFsbG9jX3Jlc3RvcmVfY29udGV4dF9hMCsweGMyLzB4Y2UNCj4gWyDCoMKgMTAuNjQwMjg1XSBD
b2RlOiBlYzRlIDAwODAgMzk4MyAwNzg1IDhhYWUgOGEzMiBiNzgzIDAwMDkgYjUwMyAwMDg5DQo+
ICg2MzljKSBjMzk5DQo+IFsgwqDCoDEwLjY0Nzc3Ml0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAw
MDAwMDAwMCBdLS0tDQo+IA0KPiANCj4ga2luZCByZWdhcmRzLA0KPiBNYXVkIFNwaWVyaW5ncw0K
DQoNCkhpIE1hdWQsDQpUaGFua3MgZm9yIHlvdXIgZW1haWwsIEknbGwgZml4IGl0IGluIG5leHQg
dmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzLA0KV2lsbGlhbQ0K

