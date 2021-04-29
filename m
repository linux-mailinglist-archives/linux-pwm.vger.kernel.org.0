Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5128236F2A1
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 00:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhD2WjI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 18:39:08 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:48190 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhD2WjI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 18:39:08 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 13TMc5be003963; Fri, 30 Apr 2021 07:38:06 +0900
X-Iguazu-Qid: 2wHHssSnc6fLFRDx3q
X-Iguazu-QSIG: v=2; s=0; t=1619735885; q=2wHHssSnc6fLFRDx3q; m=XM6FWSkpWeA/yKJ5FPT/96mDutjD1s6tTnqUnaKEf9Y=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 13TMc44n003108
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Apr 2021 07:38:04 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 81130100134;
        Fri, 30 Apr 2021 07:38:04 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13TMc4AV005348;
        Fri, 30 Apr 2021 07:38:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHBJFA5EDfvm5p3Oggr0QhXKnJ06k5oUovIDK5K4IscaHRWyRKuxCjLzmFtJNVKUVRFtFi4EGEiz2bwtlDDf6vmkY5oHiZs+TqhWv+wcIideCcp8OQEEXbDIe+0+xvtq/w0qb10hcDYO4NrDxwxgpPWD8xB7GHXoO88qrwZgSEff0xOkCN+uc8MR3I2lg5OnZXJidlRTn0Z6oINenls6AFWMcvlOsjyp7xFViSes2J/UpunYhFWmLoceZxFIdtKj7voAKqCZEjK1TzW7T+5lnYL4+gy8/Wl+eFlEpbJZT9N4JA8ZPMtFt87bs39fJ3IlbgchFy9TOfR9FGSTnOx0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYGB5VvAR53+5+Hu/sjqGVnByfOIje/QvuWUigcKH9U=;
 b=Xo/rAElcEMkV+KaNbkQ/A6DQaMNoGFrtL0au9qmTWM27O9/L7JOQmfU6zr3jS6fTp81LaFQhUZaIFi3MRUH2bOdiyDLQEKK19ZtZiB6aneTaTf+vpJ27a40AVucuVL+rsM0fGYixwhMLgtMjlLm7ir4VsJgLf2qJJfBqM741a1pPILWoKB2afZmCd6udu5aXfNZ3i9YtwFY4SDzzuU8LTZLwZhLjk7UOkC8gUAx77ogs81inJ7AtrbUaIaFDMz6AwEzS7zpQRoTAuoRoWAa+gu8FubWLzQfA3mkZPgmj7GZJnM8YZA6syLkOoHHsoSIl0bdWjeYXmLO7ymkSah5/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <linux-pwm@vger.kernel.org>, <kernel@pengutronix.de>
Subject: RE: [PATCH] pwm: visconti: Fix and simplify period calculation
Thread-Topic: [PATCH] pwm: visconti: Fix and simplify period calculation
Thread-Index: AQHXOq1w/pHKq9u/Zk2dmzPaViGY2arJiT3g
Date:   Thu, 29 Apr 2021 22:37:55 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252B479FBE5A1F8E00CF464925F9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210426150350.2829255-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210426150350.2829255-1-u.kleine-koenig@pengutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=toshiba.co.jp;
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e234a276-0574-4950-3cb1-08d90b5f6ed5
x-ms-traffictypediagnostic: TYAPR01MB6106:
x-microsoft-antispam-prvs: <TYAPR01MB610646850B4D9F71AD9672CA925F9@TYAPR01MB6106.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Hvuw0huqQs7dyQYRm8YjieHrSTRosmN2Iu/qqSZS7bCIY6kxPbefu42koftsdXTO1Kp8CGWr8TDGMzW67ZafReth1KNNWz+JRbDldh4Ro0PmQux+R2LB+vZEV0FZs0XKg0BjnwahXH63noHI9fkJ2HmVF8kdpPOZyuAfgdK6GmPQ7uRNVO2ap/DWmdEQ7sZX6MB6Saokqv/nnzzYAXtJYMn5T1maMOgCbk4L3pMIj+Uqdd6SH6LGrcQVMdJHa0V357aeh8lDXBpZg5CPTl+O0H24Vs6YLHs2GspZe1KoKooMVKV1dTGBsBarpw1dekpkCDr677YQyDbeM18cV8EufOYr1wkVbNJfBU2Nlun2t6kZ7G4tQSF7dtKszWHIqCDH8e5HHF1pv1Es6NHA5CCkU2laBJT9pqgyW0B0Z72k8NGTyjftK93OdsX0c3cgmrVxo15d6AVaw/kZUrnaofLQskH9NcaIfEHs5lAOWUWuUksOKWWCf/DcCNy4hMKvsmfPXvojZ/wHmb9KpoTLsA8TVmGX8i7T+t9+ko38ifSDLOxjCC6o/65LFvhFsCZq42kNM/Gb8wXUGXq/1h6GPmYd/kuVqyLuWrkPSxVn6vDdNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(76116006)(53546011)(71200400001)(8676002)(52536014)(186003)(6506007)(5660300002)(316002)(7696005)(478600001)(8936002)(55016002)(66476007)(64756008)(66556008)(66446008)(110136005)(26005)(9686003)(2906002)(86362001)(66574015)(4326008)(54906003)(33656002)(122000001)(38100700002)(83380400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RWYwdVpQQVlTTTYreVlHOW42VlBLaENhSHlhSkhCQ1JVbklVV2VybTl3aDdh?=
 =?utf-8?B?bEl5Q0JQMnQ4WWIweWQvNkJIbHRKWVRyTlhKdnFOc2xDeXNvTFBqejlrcXM0?=
 =?utf-8?B?S2lTa0dZdnlrcy9Bd2Y2Zms3cjFkemN6MkRYd05NcStvcVRxVnJZMnI2UXQz?=
 =?utf-8?B?WXBmaHBzUjJOOW1QWEpTN1NUTG4xVGpXUHBLeExvdG02TktCNE03NzM4S1A4?=
 =?utf-8?B?RnVYcU5mTmtUcnFBeDZhZEtEU3lRb1ZWb2hhdWl3ZUg3aC83Y1FmUEVVd3Qx?=
 =?utf-8?B?akZhYUh3VzZZejNoajAwZ0d2ekVmcDhqcDZBMlNlZmkzekViQzdDall2czJs?=
 =?utf-8?B?am9yN1NyZkNVSXRVaHZJTnR3NjNoT0JpOFVzZUFDaGI3ak5Rcm16SjFEYTdu?=
 =?utf-8?B?ODg3dTE5b3ZpaklRNDJrczNBUEd6eGg1MmJmb3pJNnE2VlB6cnU0QVZzZTh1?=
 =?utf-8?B?dVNnMGtXK1UrMkRTUW5MdVExbXk5cERwNlJXYWs0YlhzNnNVOGovWkw1b1BU?=
 =?utf-8?B?ZENKN0owVGUrS3JWT1Z2M29uMDQxVE9BeGljZ3JRRTRKMitoT0F2cXByUzBD?=
 =?utf-8?B?ek1WZnJuZ3NFbENsUjQwSkZkQlpVSXl0b2ZwUkNXT2t3eno0VjdSZ3o2TXE5?=
 =?utf-8?B?TzE0Rjd2Q2M5LzJsQmtIeVJXZTJvWmhRL0NFUm50VlJIOCttWjNHeGJFK3c2?=
 =?utf-8?B?YnU0NFA2dm1wNEZQcGcxbkpxYjYzRTRzRVo3L0RBMGgwbVBjekVZSEs5TFd5?=
 =?utf-8?B?MGRDNzF5cUZJSEFUR3FtM3lwZHNibkhtQ2IyUGFvc0xuNnVhNGRGbGluQWhY?=
 =?utf-8?B?NDFYMkxwd3BLTWozS1dzS0xOZ3dJZk9HY0cxaXpPMjZxSVZBcDlaZ1ZSQm8y?=
 =?utf-8?B?NzNBRUtGZ2YxZEVIWUNTZ1czL1k2YnFvM045NmxzRTRMc3ZIdmJTdHcyY2hK?=
 =?utf-8?B?VlhlT0JEQWpMSHdVbVlDNDVMSVRWc2FkMlVBemUrbUZNdFRhQlJSaHFGeFN0?=
 =?utf-8?B?QXBydktuODRuVzQwYWlpYVFWOE9RNmhJYi9lV3pMWVR0eEh3Yy9TWXAwaEwz?=
 =?utf-8?B?WEdLL2xQektsYWwxNFJWbmt0TFFYVzZ3SUpMOGRRdkVmSERGN2wyY0VDNlVn?=
 =?utf-8?B?ZHlDYUZQbmh6R3MrVitxZmlFcUtkZW5oaUFqZnZ2YmZZMWV1S3UxQVhtZzli?=
 =?utf-8?B?bHNRRTZTb0NYcHp1U3ZDQlNRbnBuS1FZNllldENEVi91MjkraVl6cFNuMDJY?=
 =?utf-8?B?MzlibTV5c2JGbU1TbkhXY1ZVUGZhM2tqYTgwTmJKa3ZmK3Q2K0FpcUhoNkwx?=
 =?utf-8?B?Ym1xNmI0MkhDeGdjQWJRajR2MW9tb1VRQTlsV0ZET29IM2lVeWdXOXdNdUs4?=
 =?utf-8?B?OE1qSjlGdjJzcUxKSXVla1BabGM1SjE2bEUvK2l6ekU2dE1qOU5jMlkvZkVO?=
 =?utf-8?B?cEViOUhlTTZVYWo0Ukc4bTIwSmtWNDNlWlBBSFE1ZTNnamxxSEF4RktSYkZx?=
 =?utf-8?B?SHNZaW1mZ2hZUlFpNVdWekJyd21IZzE3Z1UrN3hBY2Z5blFIeEtBeVJHTkNH?=
 =?utf-8?B?TmpLcGlaRnY3NjFGZmxUUVUvS0JEa05IZWJiWUFIMHJRYkZjQUF4Y3BvK2x3?=
 =?utf-8?B?NXpVYnhoaEk5RVhONnVqTjJEZHZPQXJyODUrVUFNQWtqMm9KWk5kYUJqVzJk?=
 =?utf-8?B?UURlSFJLaFdlYS8xeExkUFROc2pLK1JldG5PbElrWkt6MkJvTXRaaUZrL3RI?=
 =?utf-8?Q?LPV5Qqhhso3GluBwGU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e234a276-0574-4950-3cb1-08d90b5f6ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 22:37:55.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vadTmb1Vla60C0E5Cf5Xy5wGugSi+1Mp22ksVk6Hs/4L/xt4/wtcykgH9OdrketWN0FEB4lzMWYtLZSdqq7gCK4NA9+G7ILFmi0ZIMwSEittEkieqQiA6YY+VtToXtmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6106
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVp
bmUtS8O2bmlnIFttYWlsdG86dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50
OiBUdWVzZGF5LCBBcHJpbCAyNywgMjAyMSAxMjowNCBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhp
cm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdh
bWF0c3VAdG9zaGliYS5jby5qcD47IFRoaWVycnkgUmVkaW5nDQo+IDx0aGllcnJ5LnJlZGluZ0Bn
bWFpbC5jb20+OyBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KPiBDYzogbGludXgt
cHdtQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFtQ
QVRDSF0gcHdtOiB2aXNjb250aTogRml4IGFuZCBzaW1wbGlmeSBwZXJpb2QgY2FsY3VsYXRpb24N
Cj4gDQo+IFdpdGggdGhlIG9yaWdpbmFsIGNvZGUgYSByZXF1ZXN0IGZvciBwZXJpb2QgPSA2NTUz
NjAwMCBucyBhbmQgcGVyaW9kID0NCj4gMzI3NjgwMDAgbnMgeWllbGRzIHRoZSBzYW1lIHJlZ2lz
dGVyIHNldHRpbmdzICh3aGljaCByZXN1bHRzIGluIDMyNzY4MDAwDQo+IG5zKSBiZWNhdXNlIHRo
ZSB2YWx1ZSBmb3IgcHdtYzAgd2FzIG1pc2NhbGN1bGF0ZWQuDQo+IA0KDQpJIHNlZSwgdGhlIGN1
cnJlbnQgY29kZSB1c2VzIGlsb2cyKCksIHdoaWNoIGNhdXNlcyB0aGlzIHByb2JsZW0uDQpUaGFu
ayBmb3IgZml4aW5nLg0KDQo+IEFsc28gc2ltcGxpZnkgdXNpbmcgdGhhdCBmbHMoMCkgaXMgMC4N
Cj4gDQo+IEZpeGVzOiA3MjFiNTk1NzQ0ZjEgKCJwd206IHZpc2NvbnRpOiBBZGQgVG9zaGliYSBW
aXNjb250aSBTb0MgUFdNIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvD
tm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KDQpBY2tlZC1ieTogTm9idWhp
cm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9wd20vcHdtLXZpc2NvbnRpLmMgfCAxNyArKysrKysrLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLXZpc2NvbnRpLmMgYi9kcml2ZXJzL3B3bS9wd20t
dmlzY29udGkuYw0KPiBpbmRleCA0NmQ5MDM3ODYzNjYuLmFmNGUzN2QzZTNhNiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wd20vcHdtLXZpc2NvbnRpLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdt
LXZpc2NvbnRpLmMNCj4gQEAgLTgyLDE3ICs4MiwxNCBAQCBzdGF0aWMgaW50IHZpc2NvbnRpX3B3
bV9hcHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQo+
ICAJCXJldHVybiAtRVJBTkdFOw0KPiANCj4gIAkvKg0KPiAtCSAqIFBXTUMgY29udHJvbHMgYSBk
aXZpZGVyIHRoYXQgZGl2aWRlcyB0aGUgaW5wdXQgY2xrIGJ5IGENCj4gLQkgKiBwb3dlciBvZiB0
d28gYmV0d2VlbiAxIGFuZCA4LiBBcyBhIHNtYWxsZXIgZGl2aWRlciB5aWVsZHMNCj4gLQkgKiBo
aWdoZXIgcHJlY2lzaW9uLCBwaWNrIHRoZSBzbWFsbGVzdCBwb3NzaWJsZSBvbmUuDQo+ICsJICog
UFdNQyBjb250cm9scyBhIGRpdmlkZXIgdGhhdCBkaXZpZGVzIHRoZSBpbnB1dCBjbGsgYnkgYSBw
b3dlciBvZiB0d28NCj4gKwkgKiBiZXR3ZWVuIDEgYW5kIDguIEFzIGEgc21hbGxlciBkaXZpZGVy
IHlpZWxkcyBoaWdoZXIgcHJlY2lzaW9uLCBwaWNrDQo+ICsJICogdGhlIHNtYWxsZXN0IHBvc3Np
YmxlIG9uZS4gQXMgcGVyaW9kIGlzIGF0IG1vc3QgMHhmZmZmIDw8IDMsIHB3bWMwIGlzDQo+ICsJ
ICogaW4gdGhlIGludGVuZGVkIHJhbmdlIFswLi4zXS4NCj4gIAkgKi8NCj4gLQlpZiAocGVyaW9k
ID4gMHhmZmZmKSB7DQo+IC0JCXB3bWMwID0gaWxvZzIocGVyaW9kID4+IDE2KTsNCj4gLQkJaWYg
KFdBUk5fT04ocHdtYzAgPiAzKSkNCj4gLQkJCXJldHVybiAtRUlOVkFMOw0KPiAtCX0gZWxzZSB7
DQo+IC0JCXB3bWMwID0gMDsNCj4gLQl9DQo+ICsJcHdtYzAgPSBmbHMocGVyaW9kID4+IDE2KTsN
Cj4gKwlpZiAoV0FSTl9PTihwd21jMCA+IDMpKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+
ICAJcGVyaW9kID4+PSBwd21jMDsNCj4gIAlkdXR5X2N5Y2xlID4+PSBwd21jMDsNCj4gLS0NCj4g
Mi4zMC4yDQoNCg==
