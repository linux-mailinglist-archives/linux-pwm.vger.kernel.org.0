Return-Path: <linux-pwm+bounces-4526-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380B9FD21F
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ABB1882907
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE36154456;
	Fri, 27 Dec 2024 08:41:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36C14B06E;
	Fri, 27 Dec 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735288899; cv=fail; b=umI3AJp/9mifJ1SxJuTr1DP/vmO/Vk/MeigGaDGujKmHiVGoJhfRkU0l6RhW7yyIC2Xq6zek3iHWajbHss630+wPJLct37rvNzLVc3TDP9U811sKLEIQAt0yKoyhuSKjvhoo01PTkbUt13Sa13WLGRGLz3/aazgfKBpqj38Yqoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735288899; c=relaxed/simple;
	bh=Wqylw7jXJdg7Vid3VzlPbzaqKdC1wmalArsYVBWIoeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpaiQYh6kjyiXLpb+oe1eXZMVb23Apg29KpJsp55br1kJ9GZ30UBBQ4m/JT+2iQPdNI/C1Rs8thaBYOYno5CWDAWfTAzD7ND5tvbdbJqXZhkBtfJFP8vzyd8sCzT9894I8YfANrZrZfE+L9PMkl2/coNTx3SdNXMCKFRF6cRTL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxmL+K4N9/aPQW3mDkL0iBzNCYRNBUNg+Px5rajxLyIpsziuAYxW92WnNOJdbgIENQZg3S7JC107HTCkx+Pv+yK0MCXG1D6nwQgNmf02fsCvAskNqpsUxSrSOLHHmLMdbWr4UOSVNlx/N1J4mrnd55glXfhiDknKxDBy2soZqtFfYqdcXqHA5ddb2VAf2x0gJrssAARaBPZrZDetGjkXfEv0Dfl9o0QKdwRzbdebIKcmtXSLIAPdBrs1+v1KrPZ5ss7LWIZ+JTUP7ytIso+DAh4zKjk3p7X+qvsdlXhKMXCoRUf2YyducfSwJahi5BeDtcL07vfuPOa7E+kFWaFTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqylw7jXJdg7Vid3VzlPbzaqKdC1wmalArsYVBWIoeI=;
 b=NNU1+j8TSu/vHvWvuCBgDQP9S+hNLDQzi1G4rcIo9lKxfUR3JoKrkqh0RYTpYeN447YaIF7173rrgyugA2H4yjJ9nlnqLAKXH8/GdjeA3AGOrctDJE2jq25I3hvR6Yu+iQt41OSm65y9RSE4Zc78lN1pnS+yN1CHMV4akW4tJwcQevZowMU9T5JYk/dpkb2ouBSbRZ+G4TeuTBaOfOvS2mWwIuEanRUx/wL/Lv/WCcBNI/oOPxy8JxYTOoZaYQet8LPCEcAg7sxiYNPXLLQseEf7gvw+cOQKrvNdzulhzKwqUAC1g5Hn4tEhHWPaYxC4M25IDrNhYAK2ohDVqRBY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1221.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.22; Fri, 27 Dec
 2024 08:42:01 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%5])
 with mapi id 15.20.8272.013; Fri, 27 Dec 2024 08:42:01 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Index:
 AQHbKNsymVbYlUSgHUKyRrqbTLJ87bLuYDMAgAUWdxCAAPMzgIAAkMTggAUo9QCAAACyUA==
Date: Fri, 27 Dec 2024 08:42:01 +0000
Message-ID:
 <ZQ0PR01MB1253F2D9469337E68CE501C19F0EA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
 <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
 <ZQ0PR01MB1253A5B870FF90900A2643009F02A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <52j6gtyzf4uwfkxxlfschygnvuwl2l4iaf7mzbi2nbzxtmlemf@dktywu73nldg>
 <ZQ0PR01MB12530DDB9AF830296773C7AF9F03A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <qz2i2xxjwvsxhsdnlsvkj4mjylgzfnhnums4miu6d3t2lu3ff3@msfcx55gialu>
In-Reply-To: <qz2i2xxjwvsxhsdnlsvkj4mjylgzfnhnums4miu6d3t2lu3ff3@msfcx55gialu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1221:EE_
x-ms-office365-filtering-correlation-id: 96ced305-d8fc-4399-6797-08dd2652554b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 gH/27sF4vVvuUM4BY8S65dpcvdMvBj+goZI5o+Yp0cmILNf7yVC1wC28jvdqueqM5/9RyFa85VpiLnh0ru1cHI79ZSSQiuS87rm7gFnvx1i5y4XPC0OR0M+gGQucXFp6sWeVzm8WZM+LEizO6ZYCkyiws8O9jmrVcF0RnqflRmav8JIYQQ3LBDRzp+rk2zpIC6UErx8Fk3sTwWfjczFX1sPkfZtF1pgUyA2g3qoIL7H0pVdGs+chnOJc75mo0Jfd8d8bDunQvp/CFnHpUjxZXXxau64dWkGa0JC8LZqSK9AjAnn+j7SL/QzDwUf5iuCIh9mM0Xyi+oMbsDhRF/oGUbAwxpps01lTKHL4h4jl8qifkQgHx14iLIGoQNxPKTLvWelEeoblmk+0Aki+UewruWO49uxUKHrnMX1K3371w/yYLomKopSkd85Jhx5lOuG1obz1DJWfgpGV3iRRw9S57LSb7w279qlO6R5WdjqsCNHWvmzOFldaZDDoXeLWSgw6yuRiThK0g6WuT1adT3ec8zE19UOjoubzCW1MGZsEnga7wBWHXw4qPy+n4egoOBcqXPc0G5fnKWJo+DROAsTatAv9EBZJEwFKQyvZV3BpJrs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXdic3ZRbDJ4YnhTS1YyK2c0bFFsWXpuRzYxTXBQamRGQnlaRDZMUkpCbHV4?=
 =?utf-8?B?UzRqWXJHTXJzRkZaZURaVmQrSTZLVWRrZmdja2hjSHR4Q0wxbXdxTXBNaXVm?=
 =?utf-8?B?aTNOdGZ1NUIvRkp3VSs5QnZKZCtrNGZyTVljRldyQ3lwQkVUOXhwemZwdXVR?=
 =?utf-8?B?K0RTVGpubUk1dDVhWVE0K2lwMEh0aVZIYTBjVjFuR1hiL0Z6eElVYWE1TlVC?=
 =?utf-8?B?aEU3U3l1R21UYXE3eXlFb1hnWjFUa2pGZEVBOE0zR1NNRURqb2gvVHYzTlhX?=
 =?utf-8?B?QWF5aUt1amxJQ2o0cFZOUldqWnk3N1MxYThFdkhqdGcvYmoxQzd1cmxsYWlk?=
 =?utf-8?B?QUxjUkk2Qm9oaVZRWDZ1dzBLa21JMStGN1ozTElzaElKUC9uRXJ1bStHeXJa?=
 =?utf-8?B?SlZybUVuajdnM013Z2dYMzFKU2pIend5a0tpZHJZaUFXVlJhZDluNjd1SEFi?=
 =?utf-8?B?L05EL29acWYrQkVRaGZUYkRzYmExUDNPZDl6czZrc3RWdVVQOUMyMnhneEUr?=
 =?utf-8?B?ZlNMRFhud0UyeU1VVHlUR0RJL09VZjBuZkhJRUV1RWF3QmRuTi9Vd1NPejRG?=
 =?utf-8?B?bitVbnZqY05QdTdVUGlsUytpQVFTd01YcXU4b2NicEtnaXRaTzdCZWhGRzE2?=
 =?utf-8?B?YnpuNDRlUXl1aDczb1Z2R3c2eXpNQndjOS9MYlo1RzZhM0VpZ0JMZ0pYY3lO?=
 =?utf-8?B?aHVMcGhKMlRKdzhRenFHRzNDdHFCYzUwbk9vNFVTRWRBa3hBYVpiU21rRW5G?=
 =?utf-8?B?OUtGVkw1TWlmVnNKU1JlbWkwQ28wQVZmT1ZpTjhHYkF6OTd5ZmlNVlBTZExs?=
 =?utf-8?B?N3Q3WENJNXhUUHROV2V4ZmlON1VXdGlyeU02aCtOWExBbmtkbzhFd0JHMlNi?=
 =?utf-8?B?SVBVN2xpdHFLcGR6aDRoSG1xa0Rwd1d0UmQ3WGswTWgwM2Ixd3g0RUZudXZX?=
 =?utf-8?B?RTJPS0FVQ1FnV3dTRE1PUHJHWmlOTjlLQ1RCNG15Q2FiME5JclhFOCtlaHlk?=
 =?utf-8?B?NGhpMWVqd1FYWi81WHVWbUNNZ2k5ZXZuMDFYWmhlek1udlh4YTFkU1ErSHBI?=
 =?utf-8?B?cXF6UTZ1aHVwa3VsVHpnT21TYS9WWmVPWW5oN1B4UkJFY2JnNWF5ZDJzUC83?=
 =?utf-8?B?VWxvMjJRZXdSM2I1cWlvTEJVRlBVeVRYOE5VZmxtd1BJbU9OYnBCaVdabjMv?=
 =?utf-8?B?QUNmU1NXT2lJUG9MY1YrSENVaC9nNDgrN29KWGxPdWVmY0hsTHovdDdMUnRN?=
 =?utf-8?B?ckpIdFdGNnBLdWo0Qk15Zytnd3BiS3F0ZUwvYzkraEd5V1dTQmVYc3NhWDhN?=
 =?utf-8?B?S1gvNmV2T0JON2hhaDZGNHlCWnZGeWhKbmJiQlF1eG8raVhEUms4T0JtZWJB?=
 =?utf-8?B?eHYrV2tQZHJ1Zi9JZFJvcXc5aXJ2RXJ3ZU1TV29ndHdYTmYvUnl6SnZjYTdV?=
 =?utf-8?B?NG1MY0ozZWppNjM3bjliY1hqdGl5T1MwMndKQ2w3aVFxSFpTcllYK2tjalNt?=
 =?utf-8?B?SlZuU0xSNmsxV2gva0F3QVNaeWhWWEZONUUyMUhWcUR4VDRDK0ptVmZwdVUr?=
 =?utf-8?B?eFBlZlBpN3dGZ2lrNTkvd1ppRkYwTzJoWTlVbE1tcEtFdjA1clNUeVhHdFRH?=
 =?utf-8?B?SEx5aERuS1N4aUNlOEl0VnhhNlVWOHJjS3Z0TmwybWlDRURrZC9sNGpsMis0?=
 =?utf-8?B?aUx4MlBoN2tQNFhtVzhId3EzcmFJVTZiQ1UvanZRNnhsYVFsV2xGNmY5TGRX?=
 =?utf-8?B?Tlp4cWRrWlg5VWpUZDdZTjVGOTBrRlBKVVZkTzF2L3g2bXlOSWwwTmdDRCtr?=
 =?utf-8?B?VTgrYVB1TVlrNXNJRkV4QndXVEtqRWY5Z1VjdnE2cUQ5dEJkWHNTVXA2czhL?=
 =?utf-8?B?cmkvL25XUWtwNTVRVnJ4R2phTGE2aHFSRHUrQ1Y5WUw0NEJoQUw4RDRsSW9n?=
 =?utf-8?B?RVBIbEZQaVhZOXRvMmV1VG9DNjVhV2YxVDV3TUMwVzI3WDhNRU9wYVRKdXlW?=
 =?utf-8?B?dGpDaFU5b24xS00vQmZRTTcxYmFMMkJES0hXM1hwY2lFWEl3b0xOY1E5eTlU?=
 =?utf-8?B?MGhFK1pGRGtvbHNGcGozdzJvMkJueHArdmdWdXI5U0tSTXp3TWZqWm92ZWNO?=
 =?utf-8?B?Qmhlb0Y5ZzMvaFVXTXFCTTNweWtYdE1ndE85dUNTTmM3alpuSFQ5dnI1NjV5?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ced305-d8fc-4399-6797-08dd2652554b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 08:42:01.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4PNymYhRY+X3dqeb//aJtctMQytr/wBbaXqCktYYu2q93CntOGA5KvkSpJOffIK/XelSnSmT+wS+6oyGLg4jDz1IKAZxQEObDRig6jYavQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1221

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHVrbGVpbmVrQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQxMuaciDI35pelIDE2OjM4
DQo+IFRvOiBXaWxsaWFtIFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7
IEhhbCBGZW5nDQo+IDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPjsgUGhpbGlwcCBaYWJlbCA8
cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTZdIHB3bTog
b3BlbmNvcmVzOiBBZGQgUFdNIGRyaXZlciBzdXBwb3J0DQo+IA0KPiBPbiBUdWUsIERlYyAyNCwg
MjAyNCBhdCAwMTo1MzowM0FNICswMDAwLCBXaWxsaWFtIFFpdSB3cm90ZToNCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dWts
ZWluZWtAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjTlubQxMuaciDI05pelIDE6MTINCj4g
PiA+IFRvOiBXaWxsaWFtIFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwu
b3JnOyBIYWwNCj4gPiA+IEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBQaGlsaXBw
IFphYmVsDQo+ID4gPiA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjE2XSBwd206IG9wZW5jb3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiA+
ID4NCj4gPiA+IEhlbGxvIFdpbGxpYW0sDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBEZWMgMjMsIDIw
MjQgYXQgMDI6NDc6NTlBTSArMDAwMCwgV2lsbGlhbSBRaXUgd3JvdGU6DQo+ID4gPiA+ID4gPiAr
CWR1dHlfZGF0YSA9IG11bF91NjRfdTMyX2RpdihzdGF0ZS0+ZHV0eV9jeWNsZSwNCj4gPiA+ID4g
PiA+ICtkZGF0YS0+Y2xrX3JhdGUsDQo+ID4gPiA+ID4gTlNFQ19QRVJfU0VDKTsNCj4gPiA+ID4g
PiA+ICsJaWYgKCFkdXR5X2RhdGEpDQo+ID4gPiA+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEkgY2FuIHVuZGVyc3RhbmQgdGhhdCBwZXJpb2RfZGF0YSA9PSAw
IGlzIGFuIGVycm9yLCBidXQNCj4gPiA+ID4gPiBkdXR5X2RhdGEgPT0NCj4gPiA+ID4gPiAwIGNv
dWxkL3Nob3VsZCBqdXN0IHdvcms/IQ0KPiA+ID4gPg0KPiA+ID4gPiBJdCBtZWFucyBubyBuZWVk
IHRvIGNoZWNrIHdoZXRoZXIgdGhlIGR1dHkgaXMgdmFsaWQ/DQo+ID4gPg0KPiA+ID4gTm8sIGl0
IG1lYW5zIHRoYXQgSSBleHBlY3QgdGhhdCBkdXR5X2RhdGEgPT0gMCBpcyBhIHZhbGlkIHNldHRp
bmcNCj4gPiA+IGFuZCBtb3N0IGNvbnRyb2xsZXJzIHN1cHBvcnQgaXQuDQo+ID4gPg0KPiA+ID4g
QmVzdCByZWdhcmRzDQo+ID4gPiBVd2UNCj4gPg0KPiA+IFNvIHdlIGp1c3QgbmVlZCB0byBjaGVj
ayBkdXR5IDwgMD8NCj4gDQo+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcyBxdWVzdGlv
bi4gWW91IGNhbiBhc3N1bWUgdGhhdA0KPiBzdGF0ZS0+ZHV0eV9jeWNsZSBpcyA+PSAwIGluIHRo
ZSBkcml2ZXIgY2FsbGJhY2suDQo+IA0KPiBJZiB0aGUgaGFyZHdhcmUgZG9lc24ndCBzdXBwb3J0
IGR1dHlfY3ljbGUgPT0gMCwgYWRkIGEgY29tbWVudCBhbmQgcHJvcGVyDQo+IGVycm9yIGhhbmRs
aW5nLiAoaS5lLiByZXR1cm4gd2l0aCAtRUlOVkFMIGlmIHRoZSByZXF1ZXN0ZWQgZHV0eV9jeWNs
ZSBpcyB0b28gbG93DQo+IHRvIGJlIGltcGxlbWVudGVkLikNCj4gDQo+IEJlc3QgcmVnYXJkcw0K
PiBVd2UNCg0KSSBzZWUuIEknbGwgY2hlY2sgaXQgYW5kIHNlbmQgdjE3IHNvb24uDQoNClRoYW5r
cywNCldpbGxpYW0NCg==

