Return-Path: <linux-pwm+bounces-2483-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD1990A2A4
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 04:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C81F20F2E
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 02:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A131758D;
	Mon, 17 Jun 2024 02:51:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C9433B3;
	Mon, 17 Jun 2024 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592690; cv=fail; b=uEWPOYAES7DWweNGp5l7evbPyxyaS3++RuiI+D5El5O9m4bhd8uMtlk19ek7hJZQHVqjzsTMB9b24M1m3PB29aX+WVbhmOHRhDNC+2xaasdK2iypFWFM0ot2qOjyKprA2r1az0Jo4hNKoOWmAJqEV+/AGWQneadglUKLK8rH2x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592690; c=relaxed/simple;
	bh=QsS1A2emE3LKGxpD7ZkTQOd0xk5rloPQwgtujo401Kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1vdRD1jUjosN35U2iXfRxQ1DhB30ZvTNkP6wrM2/27+/HDM4YhxtxfVo4HLJ8CtpGj5vls9/aDZWrfgqxbjZPYzrmdPSA4yQQC4PMNY7L8Yf99yQ1mh7k3kb0+EYtXceALbEy5nFnWyxMGGGaY0D+8Z96ynVQIgqg6soZKKcXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXZCm5TOarY8RVu718Lbr5UTayyP06R4yRdQSYIjgpLA8x9x9/u74hwqLybpAvpGv1hDEwcKaVpNqM0d6L9RuILyAa5zeNj3Opnb2C9ak2fmg4P75nTTXMhfg5gyjd59ZEtOJIHbL96DW7V/JIrPQRe0LIoTMzjvY6fEtHRxE8RPTQDZ/qAqUNnpE/+1aHHsWX8HDlWWqlt66S6TUNJB0nWQ2ltr227wMlpiBFgSwJWUlJ1P1NwVa4dAgWnDO9RDEOnB+sfcf2EeBjThQWJc2DLSFBcztKl//dC2LmyslLa+Z3M7y+Q4xVOwiqe2YM5FjuXqkvL1aBjBfPUhkXPDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsS1A2emE3LKGxpD7ZkTQOd0xk5rloPQwgtujo401Kk=;
 b=bksypvWHga0r8MOz5neVm4rFTvQyHdgWkkVG603o5iymY8h9/SWrT2nG8X0k/6aOiHH4yZqDSzSLhLca9O6Cpu4XH1tp5DmnhSemr3ZLckAooKHXKi4X6xQ3RMPwx5PN/axyzo428WXNWaU9nxXnvCIFJwJeX0NY2vFoJ3HzGsIgPpajvCClK/etgpKfFfABK/5sp3O8ii0H6Gh12XdkgMFwAtcfqFpCDPPHHpeVNk7/Yxtynctji7h6Vqa8BWyEBsANbWFdb8Y4zqvNiFa2trs7sBwRq/Rl9Z5e1w3omMaz0NpomjRgIVkGz3Iniu/TD2c4MOFK3QBX6uoMwwchsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.42; Mon, 17 Jun
 2024 02:36:33 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::a565:fd37:bf9c:8cb7]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::a565:fd37:bf9c:8cb7%7])
 with mapi id 15.20.7656.033; Mon, 17 Jun 2024 02:36:33 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v12] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v12] pwm: opencores: Add PWM driver support
Thread-Index: AQHamgoV3Fe+kr6NVk6m2eWXa5jgA7HHWZyAgAQuoVA=
Date: Mon, 17 Jun 2024 02:36:33 +0000
Message-ID:
 <ZQ0PR01MB125399D22E07CACF6E9CF39B9FCD2@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240429075140.56867-1-william.qiu@starfivetech.com>
 <6hbj4uua442il6koeaypkqapctlwrhrmsbguyx74hwqzkycepf@7zpqo6mojqvn>
In-Reply-To: <6hbj4uua442il6koeaypkqapctlwrhrmsbguyx74hwqzkycepf@7zpqo6mojqvn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1208:EE_
x-ms-office365-filtering-correlation-id: fe687c5d-3cf6-4b33-a45d-08dc8e764d33
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|366013|41320700010|38070700015;
x-microsoft-antispam-message-info:
 4iAOiqVGib06QaZciSx3j5t2Bz/XB5gLcnlUYyRfkmtZnLrTVO+A2pcE8eD68l7PaNDPLHKs/jA100VgM8w+P2r4TJI6xmuBb9dfmofD/5g8pr+a46X75dTGEArqTcmacXJgitaAd/x8hiyWBsf48vqpqjDZezPm+uq5KWLZtFxd+gA0+Ubg08jr+FToJW2K/F4xaj03gdPUR4C5kCkMG0XKysFg2IGYytrbDQy7M511AMfP9XZ5Vgege2qwbkUdsPazci7xcvqxKwvB6mhOnNY0RStwNftW+lbB9bPjxZPfBOSpT1+RPw0IjxbDe9V0P4yx/5g76CSIkC7dp5/3JFOT9W9EvqG8NJ0WmbB+ktkO1i87jLrNs734Zy2upA7MELhVEmwDJuX9tXW5h0RwgoBJX8lFk/VLpftZU/IiV5ajcUyXmHtw29iTxzP0r6IQPh0XiKkdVO1zH2nTC4NMVbC4xEvNpinKqvcFiZkWl+gd2EkfK8XZVpeLGbCDxypF3UuqC7EAsC4Ri6YUATaWiVsesX484K10OSVbo1Rz8H69rMSQd36oTCW7Yj8yPr6Sqc0lEHqlfP53YF0UKFWsQ5eW99eXAv+UY81hh6Haxo/FIerIsf8vo7zUrE/fFAB3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(41320700010)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NURheGFUb3FtMWIxakxtNkttM25oeFl6dXE1L1NnQks0d01HWkFYb0p1Y0xW?=
 =?utf-8?B?VHJJbkpRSEV3aGh5RXB2TnBwNHhDWUJoUGJQSjl0dUp0WXhLQzc5dm9wQjkr?=
 =?utf-8?B?dGNoMndhcEpGS0V6a0FiSTF1REl0bjc1S25UYno0VU1URWlNSWFBMitkMHNl?=
 =?utf-8?B?THJ4MzExcWE1U3dvTllQNnpvT3hGbUU4ekZzZVZXWEVBTzROaSs2K0VuTk0r?=
 =?utf-8?B?elI1Zm9XZ0VmZExtUVBoMXJCUUlJUUxKRFdXQ3hmQW5qQjg0SE8yRllBd0Vs?=
 =?utf-8?B?U1ZKWmdHTEhLV1NmVGpReFdyb3ZORHNaczg4eERNSElKRDY2ejAvSlhiK3RI?=
 =?utf-8?B?STN4djhRczRxNENHTytFL3JkdE9YSmxmSGpqeG1GY2JsQ2Zic0dPdGI3TVNk?=
 =?utf-8?B?U2NBK0t5WTdxZVZvazd5c1d3S3ZUWUJlM1pJeWFhRUxkOTd3T0Y0c0VjcFFP?=
 =?utf-8?B?ZG9TNDVHY3kzYU1lQVBxWFoxam5nYkR0aTFpUjVvYlJzQkd0N1ZnV3J6b1I4?=
 =?utf-8?B?QUxNNzNtcm5qSVdWTU1ZZ1VOVktxNzhaVVlJaVloQ1p4QWY2bGJsNjZvYURV?=
 =?utf-8?B?cUxVUlJiTFR1SEdZM3VMSTZ4d0FMRWtvb2RqL216Tm50M0pnaWszYVBMQzl1?=
 =?utf-8?B?OWkvNUNEcC9mbVErM3pXTXc2V3hHeFR3dE43L21FN2xYK0hSWUdheUE3S0ZH?=
 =?utf-8?B?VENaMGhQMnpqU1BHTC9WZldlVmdpZk9PWms0eHRzTTBHem03NHN0VE8xem9Z?=
 =?utf-8?B?UmRURjNYWHgrMW1CMXlQaXBURTNlYjVFN2hrMExacGN2SnpVdGlPV3NKNkds?=
 =?utf-8?B?b0ZvMEh3bmw0VjhYbjJMeHY0K2c1ZzNpbi9zMHhqeEdCZURrYjFDVlROaWE3?=
 =?utf-8?B?dTlsQUlKN3lyNW9saUVyLys2SkNVSklmM2JOQ2tLZ1pqd2RsVlBrTjhoeW5D?=
 =?utf-8?B?YXovRmIvWmNvamRQQytJU25XbXZLQXl5RlpycGpVeXROL0FvcDI2d3h2amZG?=
 =?utf-8?B?V1ZsTlRJZ09iZThTU1M4enhRSFQza3pwT1BRWlkvY3Y1NGduWHBQU0NoT205?=
 =?utf-8?B?UjlPVFFLZTVhZXJPZ3NxclF6QzJPRGFwbXZrVXNSd0xOSkNLUWtua01ueXBM?=
 =?utf-8?B?NTNpTEYwbzFmTkI0NXF1NnpxY1ZxamhBa1RUM3E0bUd5d0dqMDlXS2xyZWlE?=
 =?utf-8?B?ZjI4VFFFVGtCQ1I4di9BdEROWkhSYUI2VWxUSTFWNWd2UU9HM1l0UGhIMmdv?=
 =?utf-8?B?M0JqQ215TzNIaFVRRWVaT01IRDJDdSsxTWtkV056NnF6UGhiU0VwY1RPZlRO?=
 =?utf-8?B?NkczK1lnM2FqSTNLOFgyR3NEZ2xBN0pSN1E3dUhOVXBWUzIzMktyN1R0TlNT?=
 =?utf-8?B?ODVVRzNhRWp5WlFiYytraVlDMHB4YWlKdmttVTlJaXg1RlJjMzdtNWZWekEy?=
 =?utf-8?B?MjF2UTI5eCs1VHdwM0hxZXZ4THl6Rm80bHBmUVpTS3grbzJCeExtbEhtTFFz?=
 =?utf-8?B?T1dBR1o5YVg5ajBteW0xaEgvN3cvYnBMMlFTcGpCNVFqblhoQzB1QlhnT3Mx?=
 =?utf-8?B?dVc2L0IrdCtBeVlXWmJrTUtFcWszcXg1RDVjK1VXK2srSzRrSGh6dUNkUWt5?=
 =?utf-8?B?TXN0cUV0WGR2aWttMDZCL3o5cUhDOHltM05PZUFMODN6OGtBSkt2WnpEa3hl?=
 =?utf-8?B?VDdZMjVjSFp3Vzd0d2p5alpXWk04NVV3MWx2Q1RLVTN4UFhhdEpjVnJYMldS?=
 =?utf-8?B?blMyZ29kTlJSYSt1YktNellrN0VzNENTU0R5MzJscEt4SUJLRmc0MWxqN1FI?=
 =?utf-8?B?dndGeEdBMVIvUHpUNEh5a2JMNkkwek9Mc3A1QjhMZFl1THNiVDd0MEFPSTFO?=
 =?utf-8?B?ZjBSeTVqR2g0amZucDlDR1RnWDJFMU9DeXVxbmdQNDQweHZjemNFd0k5YS9x?=
 =?utf-8?B?Umt5ZUZYOWp0eU5OanF4aW5yZVhnRVg0WnJJajdmUmJqWFJNeGJybk5FOXY0?=
 =?utf-8?B?NE5oUzRVSml4NTVobEVsQzFPalhvaGljdmJLTHFFb2daVVc1THJ6TXlORHRt?=
 =?utf-8?B?WktzaFJMdFNKTEgxK3JPTmJiYTRmR05sTm9zOTh0OUhZYjVVUVJvdzVzcGhp?=
 =?utf-8?B?cWprRFZ1SXRjblY5bU1HVEVnQ1Nzb1djYnJGSGozNmtwWFNvMjdrR09uclBS?=
 =?utf-8?B?d0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe687c5d-3cf6-4b33-a45d-08dc8e764d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 02:36:33.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GN263MAj1Xv/vsMxCx5LCMLNM2T2mRefuo5c6Q4/JY7i4rVA5Jnm+07vYJYXXQpAbsrAJktxuo647p7wOJPfXHH5ZGByyg3yIiQGsXKwmzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1208

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNvbT4NCj4gU2VudDogMjAyNOW5tDbmnIgxNOaXpSAx
ODozNw0KPiBUbzogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwu
b3JnOyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFBoaWxpcHAgWmFi
ZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEyXSBw
d206IG9wZW5jb3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVsbG8gV2lsbGlh
bSwNCj4gDQo+IHRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZSBhbmQgc29ycnkgZm9yIHRha2luZyBz
byBsb25nIHVudGlsIEkgY2FtZSBhcm91bmQgdG8NCj4gcmV2aWV3IHRoaXMuDQo+IA0KPiBPbiBN
b24sIEFwciAyOSwgMjAyNCBhdCAwMzo1MTo0MFBNICswODAwLCBXaWxsaWFtIFFpdSB3cm90ZToN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLW9jb3Jlcy5jIGIvZHJpdmVycy9wd20v
cHdtLW9jb3Jlcy5jIG5ldw0KPiA+IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMDAw
Li4wMzlmYjNjNTI2YTcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9wd20v
cHdtLW9jb3Jlcy5jDQo+ID4gQEAgLTAsMCArMSwyNDAgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogT3BlbkNvcmVzIFBXTSBEcml2
ZXINCj4gPiArICoNCj4gPiArICogaHR0cHM6Ly9vcGVuY29yZXMub3JnL3Byb2plY3RzL3B0Yw0K
PiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTgtMjAyMyBTdGFyRml2ZSBUZWNobm9s
b2d5IENvLiwgTHRkLg0KPiA+ICsgKg0KPiA+ICsgKiBMaW1pdGF0aW9uczoNCj4gPiArICogLSBU
aGUgaGFyZHdhcmUgb25seSBkbyBpbnZlcnRlZCBwb2xhcml0eS4NCj4gDQo+IHMvZG8vZG9lcy8N
Cj4gDQpXaWxsIHVwZGF0ZS4NCj4gPiArICogLSBUaGUgaGFyZHdhcmUgbWluaW11bSBwZXJpb2Qg
LyBkdXR5X2N5Y2xlIGlzICgxIC8gcHdtX2FwYiBjbG9jaw0KPiBmcmVxdWVuY3kpIG5zLg0KPiA+
ICsgKiAtIFRoZSBoYXJkd2FyZSBtYXhpbXVtIHBlcmlvZCAvIGR1dHlfY3ljbGUgaXMgKFUzMl9N
QVggLyBwd21fYXBiDQo+IGNsb2NrIGZyZXF1ZW5jeSkgbnMuDQo+IA0KPiBIb3cgZG9lcyB0aGUg
aGFyZHdhcmUgYmVoYXZlIG9uIGRpc2FibGU/IERvZXMgaXQgY29tcGxldGUgdGhlIGN1cnJlbnRs
eQ0KPiBydW5uaW5nIHBlcmlvZCB3aGVuIHJlY29uZmlndXJpbmcgb3IgZGlzYWJsaW5nPyBBcmUg
Z2xpdGNoZXMgZXhwZWN0ZWQgaW4gLmFwcGx5KCk/DQo+IFBsZWFzZSBhbnN3ZXIgdGhlc2UgcXVl
c3Rpb25zIGluIHRoZSBMaW1pdGF0aW9ucyBwYXJhZ3JhcGguDQo+IA0KV2lsbCB1cGRhdGUuDQo+
ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvaW8uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+
ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9wd20uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+DQo+ID4gKw0KPiA+ICsvKiBPcGVuQ29yZXMgUmVnaXN0ZXIgb2Zmc2V0cyAq
Lw0KPiA+ICsjZGVmaW5lIFJFR19PQ1BXTV9DTlRSICAgIDB4MA0KPiA+ICsjZGVmaW5lIFJFR19P
Q1BXTV9IUkMgICAgIDB4NA0KPiA+ICsjZGVmaW5lIFJFR19PQ1BXTV9MUkMgICAgIDB4OA0KPiA+
ICsjZGVmaW5lIFJFR19PQ1BXTV9DVFJMICAgIDB4Qw0KPiA+ICsNCj4gPiArLyogT0NQV01fQ1RS
TCByZWdpc3RlciBiaXRzKi8NCj4gPiArI2RlZmluZSBSRUdfT0NQV01fRU4gICAgICBCSVQoMCkN
Cj4gDQo+IEkgd291bGQgcHJlZmVyIHRoaXMgb25lIHRvIGJlIGNhbGxlZCBSRUdfT0NQV01fQ05U
Ul9FTi4gRGl0dG8gZm9yIHRoZQ0KPiBmb2xsb3dpbmcgZGVmaW5pdGlvbnMuDQo+IA0KV2lsbCB1
cGRhdGUuDQo+ID4gKyNkZWZpbmUgUkVHX09DUFdNX0VDTEsgICAgQklUKDEpDQo+ID4gKyNkZWZp
bmUgUkVHX09DUFdNX05FQyAgICAgQklUKDIpDQo+ID4gKyNkZWZpbmUgUkVHX09DUFdNX09FICAg
ICAgQklUKDMpDQo+ID4gKyNkZWZpbmUgUkVHX09DUFdNX1NJR05MRSAgQklUKDQpDQo+ID4gKyNk
ZWZpbmUgUkVHX09DUFdNX0lOVEUgICAgQklUKDUpDQo+ID4gKyNkZWZpbmUgUkVHX09DUFdNX0lO
VCAgICAgQklUKDYpDQo+ID4gKyNkZWZpbmUgUkVHX09DUFdNX0NOVFJSU1QgQklUKDcpDQo+ID4g
KyNkZWZpbmUgUkVHX09DUFdNX0NBUFRFICAgQklUKDgpDQo+ID4gKw0KPiA+IFsuLi5dDQo+ID4g
K3N0YXRpYyBpbnQgb2NvcmVzX3B3bV9hcHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsDQo+ID4g
KwkJCSAgICBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPiA+ICsJCQkgICAgY29uc3Qgc3RydWN0
IHB3bV9zdGF0ZSAqc3RhdGUpIHsNCj4gPiArCXN0cnVjdCBvY29yZXNfcHdtX2RldmljZSAqZGRh
dGEgPSBjaGlwX3RvX29jb3JlcyhjaGlwKTsNCj4gPiArCXUzMiBjdHJsX2RhdGEgPSAwOw0KPiA+
ICsJdTY0IHBlcmlvZF9kYXRhLCBkdXR5X2RhdGE7DQo+ID4gKw0KPiA+ICsJaWYgKHN0YXRlLT5w
b2xhcml0eSAhPSBQV01fUE9MQVJJVFlfSU5WRVJTRUQpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKw0KPiA+ICsJY3RybF9kYXRhID0gb2NvcmVzX3B3bV9yZWFkbChkZGF0YSwgcHdtLT5o
d3B3bSwNCj4gUkVHX09DUFdNX0NUUkwpOw0KPiA+ICsJb2NvcmVzX3B3bV93cml0ZWwoZGRhdGEs
IHB3bS0+aHdwd20sIFJFR19PQ1BXTV9DVFJMLCAwKTsNCj4gPiArDQo+ID4gKwlwZXJpb2RfZGF0
YSA9IG11bF91NjRfdTMyX2RpdihzdGF0ZS0+cGVyaW9kLCBkZGF0YS0+Y2xrX3JhdGUsDQo+IE5T
RUNfUEVSX1NFQyk7DQo+ID4gKwlpZiAocGVyaW9kX2RhdGEgPiBVMzJfTUFYKQ0KPiA+ICsJCXBl
cmlvZF9kYXRhID0gVTMyX01BWDsNCj4gDQo+IFRoaXMgYXNzaWdubWVudCBpcyB1c2VsZXNzLCB0
aGUgdmFsdWUgb2YgcGVyaW9kX2RhdGEgaXNuJ3QgdXNlZCBsYXRlciwNCj4gDQo+IEkgdGhpbmsg
eW91IHdhbnQ6DQo+IA0KPiAJcGVyaW9kX2RhdGEgPSAuLi4NCj4gDQo+IAlpZiAoIXBlcmlvZF9k
YXRhKQ0KPiAJCXJldHVybiAtRUlOVkFMDQo+IA0KPiAJaWYgKHBlcmlvZF9kYXRhID4gVTMyX01B
WCkNCj4gCQlwZXJpb2RfZGF0YSA9IFUzMl9NQVg7DQo+IA0KPiAJb2NvcmVzX3B3bV93cml0ZWwo
ZGRhdGEsIHB3bS0+aHdwd20sIDB4OCwgKHUzMilwZXJpb2RfZGF0YSk7DQo+IA0KPg0KSSdsbCB0
cnkgaXQgdGhlbi4NCj4gPiArCWVsc2UgaWYgKHBlcmlvZF9kYXRhID4gMCkNCj4gPiArCQlvY29y
ZXNfcHdtX3dyaXRlbChkZGF0YSwgcHdtLT5od3B3bSwgMHg4LCAodTMyKXBlcmlvZF9kYXRhKTsN
Cj4gPiArCWVsc2UNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlkdXR5X2Rh
dGEgPSBtdWxfdTY0X3UzMl9kaXYoc3RhdGUtPmR1dHlfY3ljbGUsIGRkYXRhLT5jbGtfcmF0ZSwN
Cj4gTlNFQ19QRVJfU0VDKTsNCj4gPiArCWlmIChkdXR5X2RhdGEgPD0gVTMyX01BWCkNCj4gPiAr
CQlvY29yZXNfcHdtX3dyaXRlbChkZGF0YSwgcHdtLT5od3B3bSwgUkVHX09DUFdNX0hSQywNCj4g
KHUzMilkdXR5X2RhdGEpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAN
Cj4gZHV0eV9kYXRhID4gVTMyX01BWCBzaG91bGQgYmUgaGFuZGxlZCBpbiB0aGUgc2FtZSB3YXkg
YXMgcGVyaW9kX2RhdGEgPg0KPiBVMzJfTUFYLg0KPiANCj4gPiArCW9jb3Jlc19wd21fd3JpdGVs
KGRkYXRhLCBwd20tPmh3cHdtLCBSRUdfT0NQV01fQ05UUiwgMCk7DQo+ID4gKw0KPiA+ICsJaWYg
KHN0YXRlLT5lbmFibGVkKSB7DQo+ID4gKwkJY3RybF9kYXRhID0gb2NvcmVzX3B3bV9yZWFkbChk
ZGF0YSwgcHdtLT5od3B3bSwNCj4gUkVHX09DUFdNX0NUUkwpOw0KPiA+ICsJCW9jb3Jlc19wd21f
d3JpdGVsKGRkYXRhLCBwd20tPmh3cHdtLCBSRUdfT0NQV01fQ1RSTCwNCj4gPiArCQkJCSAgY3Ry
bF9kYXRhIHwgUkVHX09DUFdNX0VOIHwgUkVHX09DUFdNX09FKTsNCj4gPiArCX0NCj4gDQo+IFdv
dWxkbid0IGl0IG1ha2Ugc2Vuc2UgdG8gdW5zZXQgUkVHX09DUFdNX0VOIHwgUkVHX09DUFdNX09F
IGlmDQo+ICghc3RhdGUtPmVuYWJsZWQpPw0KPiANCldpbGwgdXBkYXRlLg0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcHdtX29wcyBvY29y
ZXNfcHdtX29wcyA9IHsNCj4gPiArCS5nZXRfc3RhdGUJPSBvY29yZXNfcHdtX2dldF9zdGF0ZSwN
Cj4gPiArCS5hcHBseQkJPSBvY29yZXNfcHdtX2FwcGx5LA0KPiANCj4gSW4gb3RoZXIgc3RydWN0
cyB5b3UncmUgdXNpbmcgYSBzaW5nbGUgc3BhY2UgYmVmb3JlID0uIEknZCBwcmVmZXIgdGhhdCBo
ZXJlLCB0b28uDQo+IA0KV2lsbCBhZGQuDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9jb3Jlc19wd21fZGF0YSBqaDcxMDBfcHdtX2RhdGEgPSB7DQo+ID4gKwkuZ2V0
X2NoX2Jhc2UgPSBzdGFyZml2ZV9qaDcxeDBfZ2V0X2NoX2Jhc2UsIH07DQo+ID4gKw0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IG9jb3Jlc19wd21fZGF0YSBqaDcxMTBfcHdtX2RhdGEgPSB7DQo+
ID4gKwkuZ2V0X2NoX2Jhc2UgPSBzdGFyZml2ZV9qaDcxeDBfZ2V0X2NoX2Jhc2UsIH07DQo+IA0K
PiBUaGVzZSB0d28gYXJlIGlkZW50aWNhbC4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIHVzZSBvbmx5
IG9uZSBpbnN0YW5jZSBvZiB0aGVzZT8NCj4gDQpXaWxsIHVwZGF0ZS4NCj4gPiBbLi4uXQ0KPiA+
ICtzdGF0aWMgaW50IG9jb3Jlc19wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikgew0KPiA+ICsJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqaWQ7DQo+ID4gKwlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IG9jb3Jlc19wd21fZGV2aWNl
ICpkZGF0YTsNCj4gPiArCXN0cnVjdCBwd21fY2hpcCAqY2hpcDsNCj4gPiArCXN0cnVjdCBjbGsg
KmNsazsNCj4gPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3Q7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArCWlkID0gb2ZfbWF0Y2hfZGV2aWNlKG9jb3Jlc19wd21fb2ZfbWF0Y2gsIGRl
dik7DQo+ID4gKwlpZiAoIWlkKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAr
CWNoaXAgPSBkZXZtX3B3bWNoaXBfYWxsb2MoJnBkZXYtPmRldiwgOCwgc2l6ZW9mKCpkZGF0YSkp
Ow0KPiA+ICsJaWYgKElTX0VSUihjaGlwKSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAr
DQo+ID4gKwlkZGF0YSA9IGNoaXBfdG9fb2NvcmVzKGNoaXApOw0KPiA+ICsJZGRhdGEtPmRhdGEg
PSBpZC0+ZGF0YTsNCj4gPiArCWNoaXAtPm9wcyA9ICZvY29yZXNfcHdtX29wczsNCj4gPiArDQo+
ID4gKwlkZGF0YS0+cmVncyA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAw
KTsNCj4gPiArCWlmIChJU19FUlIoZGRhdGEtPnJlZ3MpKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJy
X3Byb2JlKGRldiwgUFRSX0VSUihkZGF0YS0+cmVncyksDQo+ID4gKwkJCQkgICAgICJVbmFibGUg
dG8gbWFwIElPIHJlc291cmNlc1xuIik7DQo+ID4gKw0KPiA+ICsJY2xrID0gZGV2bV9jbGtfZ2V0
X2VuYWJsZWQoZGV2LCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIoY2xrKSkNCj4gPiArCQlyZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoY2xrKSwNCj4gPiArCQkJCSAgICAgIlVuYWJs
ZSB0byBnZXQgcHdtJ3MgY2xvY2tcbiIpOw0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fY2xrX3Jh
dGVfZXhjbHVzaXZlX2dldChkZXYsIGNsayk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVy
biByZXQ7DQo+ID4gKw0KPiA+ICsJcnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25h
bF9leGNsdXNpdmUoZGV2LCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIocnN0KSkNCj4gPiArCQly
ZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIocnN0KSwNCj4gPiArCQkJCSAgICAgIlVu
YWJsZSB0byBnZXQgcHdtJ3MgcmVzZXRcbiIpOw0KPiA+ICsNCj4gPiArCXJlc2V0X2NvbnRyb2xf
ZGVhc3NlcnQocnN0KTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVz
ZXQoZGV2LCBvY29yZXNfcHdtX3Jlc2V0X2NvbnRyb2xfYXNzZXJ0LA0KPiByc3QpOw0KPiA+ICsJ
aWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWRkYXRhLT5jbGtfcmF0
ZSA9IGNsa19nZXRfcmF0ZShjbGspOw0KPiA+ICsJaWYgKGRkYXRhLT5jbGtfcmF0ZSA8PSAwIHx8
IGRkYXRhLT5jbGtfcmF0ZSA+IE5TRUNfUEVSX1NFQykNCj4gDQo+IGNsa19yYXRlIGlzIGFuIHUz
Mi4gU28gZGRhdGEtPmNsa19yYXRlIDw9IDAgd2lsbCBuZXZlciBiZSB0cnVlLiBBbHNvIG9uIDY0
Yml0DQo+IGFyY2hzIGNsa19nZXRfcmF0ZSgpIG1pZ2h0IHJldHVybiA0Mjk0OTY3Mjk3IHdoaWNo
IHJlc3VsdHMgaW4NCj4gZGRhdGEtPmNsa19yYXRlIGJlaW5nIGFzc2lnbmVkIDEgYW5kIHRoZW4g
cGFzc2luZyB0aGlzIHRlc3QuDQo+IA0KV2lsbCBmaXggaXQuDQo+ID4gKwkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCBkZGF0YS0+Y2xrX3JhdGUsDQo+ID4gKwkJCQkgICAgICJVbmFibGUgdG8g
Z2V0IGNsb2NrJ3MgcmF0ZVxuIik7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2bV9wd21jaGlwX2Fk
ZChkZXYsIGNoaXApOw0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCByZXQsICJDb3VsZCBub3QgcmVnaXN0ZXIgUFdNIGNoaXBcbiIpOw0KPiA+ICsN
Cj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQoNCg0K
VGhhbmsgeW91IGZvciB0YWtpbmcgdGltZSB0byByZXZpZXcgdGhpcyBwYXRjaC4NCg0KQmVzdCBS
ZWdhcmRzDQpXaWxsaWFtDQoNCg==

