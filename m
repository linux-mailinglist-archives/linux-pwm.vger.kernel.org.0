Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65AB22A534
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgGWCXg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Jul 2020 22:23:36 -0400
Received: from mail-db8eur05on2047.outbound.protection.outlook.com ([40.107.20.47]:22497
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728914AbgGWCXf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 22 Jul 2020 22:23:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8p9NOn/NiMAFZ2ZsGIAHPEBkspVMfJOPjQmxXfE5dYTcWwtCscCy+CE9TPAFAjBEjtsqRbFAyvV4R0BPQQ2j8Gx1qqIuIKFVbR4NRa2w6IrzsJg+fBZ3zghsVvLVyJDGR+Po0xv9xjMSwbwtjoxC00lzBZ9FZlV786lzC8S45N3W+FnDdT5x8eB03xUf/KojxjFkjrUIu+EV+xJCJLHgDuWjJR08gh7HAiPdqwbtHnwKumm0EKJkjrYV8mmBlPczqBXyT/ONlF55MtUaGmVymAHborbKOK7LhmfgUDdQwckz8b6MuMa577Iq39vFjTmFngR2m4SzM97MHI4IMLeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YACC/pCp8Pexd0ymROU7/FNDqjjZyW1maXtosY5YRM=;
 b=Bso/M/Yra4H84MYHFwyV2evgiqP0hURSp7+Da1/mHet5NfR3+qbHT52SAvygsWic09S9uz8IvwB0SVYUIa5uX7YJbjROjVs5VnMwimBJlzfcaGJzeejx0pjfSWy0QvGjfeXurYhJiVW8WoAjwOX1xwHj+uK92Pf9wG8+FxhRoaIafyQ22SfZFqT8a2jcLiVRVbcUvkOTSoU5+ZVy4C2wdRHPupJs/AGaLc6WFXubfJpFW+MSgGoOhI/ETGo1Bu/P13MhUdGAOVgGsEEinbRpH8JUV1C1jLd/VPD0nnCdCEAqdlU9ORDT1JnsJ7CCjX8VaxludMq8qrHrcv4v7h2iQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YACC/pCp8Pexd0ymROU7/FNDqjjZyW1maXtosY5YRM=;
 b=kc2y10NTQ5SedZ8JrdNG0jBd3TGWzcbzw0QfJBDfVHFjS3LTfveLBE9lcRNFbnLEkwU9imK5N5PlKSCbldzXuKfJGcwP8D4OMNx3YcJY1ndJC3zoHUlWcSE1JmDVokVqGdVf1Niv0Yc9BKZ/EugX2WHRTROJhTCerLHH7LqAMzU=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DB6PR1001MB1238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 02:23:29 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 02:23:29 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Jes Sorensen <jes.sorensen@gmail.com>,
        Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v16 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v16 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWVcxyCdY0W8WVH0SKFGBEWuheuqkTzJSAgACTV9A=
Date:   Thu, 23 Jul 2020 02:23:29 +0000
Message-ID: <DB8PR10MB34362941F9428B498ED4B94E85760@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1594279649.git.Roy.Im@diasemi.com>
 <b02ba5b5dbd3d58f27440ba639d32e4405061df3.1594279649.git.Roy.Im@diasemi.com>
 <bdc76da9-9223-b6d9-1fc1-2ef6e3b7afa7@gmail.com>
In-Reply-To: <bdc76da9-9223-b6d9-1fc1-2ef6e3b7afa7@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.240.7.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 713a70f6-1f14-4fae-5637-08d82eaf6344
x-ms-traffictypediagnostic: DB6PR1001MB1238:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR1001MB1238E9E7E3785B12D831D9AEA2760@DB6PR1001MB1238.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JSEF3BiRpuISVqVVE2V2W5azw3Y92wfEtNY5Y+FHqNKEKfQQ8z/eO1rYdmday+u32qitgEzaNXgOsh0LjB6NPslkatn7AfS/vLZjOO48Usg54Yu2cZWddtHmzb9IMY2QmpW5okKbIO99mwVGbUP/BoX0ekygClk1hwNooFSHSKcfFesnQQMffFnLxP4U9hUJjXxBVlMeb7FQCAchXzVye29x/fUjxv3C2cKMWELE1BX2QqI+iaaQMbmGYziysxlYeGWdZmpGk+5r88w+eA1p0NeYHnCdn4ZeZK8C6JFzk7tAD9OpGYGxeSwyYGC+zf1SK9/3yV5oB28xrObiOxK/aG8cDiZc/Um/NboNryAJXdyeZFbE0h7F7lB6jWpa7ke
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(52536014)(4326008)(478600001)(33656002)(83380400001)(5660300002)(7416002)(9686003)(55016002)(71200400001)(76116006)(8936002)(7696005)(66946007)(66446008)(66556008)(66476007)(64756008)(26005)(8676002)(54906003)(86362001)(316002)(6506007)(53546011)(186003)(2906002)(110136005)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lp2MBMvKkoukiLWE4o/R6RDFVdT07BmpAcoIWGvuJIchzl/Vuby+JMILRLeldyMhJjhX4NlKcSc6yWzhK47TaXK5rxSFbY/hxzhC60Fwa/7UeYTQ5SU1+1/9OxLY1KdZXst3xgK7tJLXcnlC5ARle9P4gff6Nrm8T4TaWgwpC0WE5z0REw/AXrIq6XmMZE+9IM64qW/rFfivpnNUos8WG+NJ2uCaT4qAvf2Z7uIMRKBzmyiL1/AHe8AaENhKpOfLdvB4iGKTdAL0ENuW/MXI/Vetj1q/GY54vjZAtEYZu7LFB4U1xfOPoK1Gi6/6gur83dZ+w+NzsB8jdUCdLyqj4ocTtKdUrik32lk9tvHB2x+eY+/YG9gn/G0h2LQBN6vlhIUU4Bsrmt69E8tTZMBe/M6RVzywZBjY0V6RcSmD5yAS7cFP922Y4sNk+40jLoqToc2udIQwM2J8xlYsWrsLIxlFP4U+UYNSid0+yr13+qY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a70f6-1f14-4fae-5637-08d82eaf6344
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 02:23:29.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1W+2Ch25RXGgSWm5tcqRm6pcUpluif7tUPGPqkEXb7/cYNZvz/EsxC+jdc9pclZiLnl9VGpsSJOvavBt5Ej2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1238
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gVGh1cnNkYXksIEp1bHkgMjMsIDIwMjAgMTI6MjQgQU0sIEplcyBTb3JlbnNlbiB3cm90ZToN
Cj4gT24gNy85LzIwIDM6MjcgQU0sIFJveSBJbSB3cm90ZToNCj4gPiBBZGRzIHN1cHBvcnQgZm9y
IHRoZSBEaWFsb2cgREE3MjgwIExSQS9FUk0gSGFwdGljIERyaXZlciB3aXRoIG11bHRpcGxlDQo+
ID4gbW9kZSBhbmQgaW50ZWdyYXRlZCB3YXZlZm9ybSBtZW1vcnkgYW5kIHdpZGViYW5kIHN1cHBv
cnQuDQo+ID4gSXQgY29tbXVuaWNhdGVzIHZpYSBhbiBJMkMgYnVzIHRvIHRoZSBkZXZpY2UuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb3kgSW0gPHJveS5pbS5vcGVuc291cmNlQGRpYXNlbWku
Y29tPg0KPiA+IC0tLQ0KPiA+IHYxNjoNCj4gPiAJLSBDb3JyZWN0ZWQgc29tZSBjb2RlIGFuZCB1
cGRhdGVkIGRlc2NyaXB0aW9uIGluIEtjb25maWcuDQo+ID4gdjE1Og0KPiA+IAktIFJlbW92ZWQg
c29tZSBkZWZpbmVzIGFuZCB1cGRhdGVkIHNvbWUgY29tbWVudHMuDQo+ID4gdjE0Og0KPiA+IAkt
IFVwZGF0ZWQgcHdtIHJlbGF0ZWQgY29kZSwgYWxpZ25tZW50cyBhbmQgY29tbWVudHMuDQo+ID4g
djEzOg0KPiA+IAktIFVwZGF0ZWQgc29tZSBjb25kaXRpb25zIGluIHB3bSBmdW5jdGlvbiBhbmQg
YWxpZ25tZW50cy4NCj4gPiB2MTI6IE5vIGNoYW5nZXMuDQo+ID4gdjExOg0KPiA+IAktIFVwZGF0
ZWQgdGhlIHB3bSByZWxhdGVkIGNvZGUsIGNvbW1lbnRzIGFuZCB0eXBvLg0KPiA+IHYxMDoNCj4g
PiAJLSBVcGRhdGVkIHRoZSBwd20gcmVsYXRlZCBmdW5jdGlvbiBhbmQgYWRkZWQgc29tZSBjb21t
ZW50cy4NCj4gPiB2OToNCj4gPiAJLSBSZW1vdmVkIHRoZSBoZWFkZXIgZmlsZSBhbmQgcHV0IHRo
ZSBkZWZpbml0aW9ucyBpbnRvIHRoZSBjIGZpbGUuDQo+ID4gCS0gVXBkYXRlZCB0aGUgcHdtIGNv
ZGUgYW5kIGVycm9yIGxvZ3Mgd2l0aCAlcEUNCj4gPiB2ODoNCj4gPiAJLSBBZGRlZCBjaGFuZ2Vz
IHRvIHN1cHBvcnQgRkZfUEVSSU9ESUMvRkZfQ1VTVE9NIGFuZCBGRl9DT05TVEFOVC4NCj4gPiAJ
LSBVcGRhdGVkIHRoZSBkdC1yZWxhdGVkIGNvZGUuDQo+ID4gCS0gUmVtb3ZlZCBtZW1sZXNzIHJl
bGF0ZWQgZnVuY3Rpb25zLg0KPiA+IHY3Og0KPiA+IAktIEFkZGVkIG1vcmUgYXR0cmlidXRlcyB0
byBoYW5kbGUgb25lIHZhbHVlIHBlciBmaWxlLg0KPiA+IAktIFJlcGxhY2VkIGFuZCB1cGRhdGVk
IHRoZSBkdC1yZWxhdGVkIGNvZGUgYW5kIGZ1bmN0aW9ucyBjYWxsZWQuDQo+ID4gCS0gRml4ZWQg
ZXJyb3IvZnVuY3Rpb25zLg0KPiA+IHY2OiBObyBjaGFuZ2VzLg0KPiA+IHY1OiBGaXhlZCBlcnJv
cnMgaW4gS2NvbmZpZyBmaWxlLg0KPiA+IHY0OiBVcGRhdGVkIGNvZGUgYXMgZHQtYmluZGluZ3Mg
YXJlIGNoYW5nZWQuDQo+ID4gdjM6IE5vIGNoYW5nZXMuDQo+ID4gdjI6IEZpeGVkIGtidWlsZCBl
cnJvci93YXJuaW5nDQo+ID4NCj4gPg0KPiA+ICBkcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZyAg
fCAgIDEzICsNCj4gPiAgZHJpdmVycy9pbnB1dC9taXNjL01ha2VmaWxlIHwgICAgMSArDQo+ID4g
IGRyaXZlcnMvaW5wdXQvbWlzYy9kYTcyODAuYyB8IDE4NDANCj4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTg1NCBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L21pc2Mv
ZGE3MjgwLmMNCj4gDQo+IEhpIFJveSwNCj4gDQo+IE92ZXJhbGwgdGhlIGRyaXZlciBsb29rcyBw
cmV0dHkgZ29vZCBub3cuIEkgZGlkIGZpbmQgb25lIGlzc3VlLCBzZWUgYmVsb3cuIElmIHlvdSBm
aXggdGhhdCBJIGFtIGhhcHB5IHRvIGFkZCBhIFJldmlld2VkLWJ5IGxpbmUuDQo+IA0KPiBSZXZp
ZXdlZC1CeTogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPg0KDQpUaGFua3Mg
YSBsb3QgYW5kIEkgd2lsbCBmaXggYXMgeW91IGFkdmlzZWQgYmVsb3csIHRoZW4gSSB3aWxsIGFk
ZCBhIFJldmlld2VkLWxpbmUgaW4gdGhlIG5leHQgcGF0Y2guDQoNCj4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5wdXQvbWlzYy9kYTcyODAuYyBiL2RyaXZlcnMvaW5wdXQvbWlzYy9kYTcy
ODAuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAuLmM4YzQyYWMNCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9pbnB1dC9taXNjL2RhNzI4MC5jDQo+
IA0KPiBbc25pcF0NCj4gDQo+ID4gK3N0YXRpYyBpbnQgZGE3MjgwX2hhcHRpY19zZXRfcHdtKHN0
cnVjdCBkYTcyODBfaGFwdGljICpoYXB0aWNzLCBib29sIGVuYWJsZWQpDQo+ID4gK3sNCj4gPiAr
CXN0cnVjdCBwd21fc3RhdGUgc3RhdGU7DQo+ID4gKwl1NjQgcGVyaW9kX21hZ19tdWx0aTsNCj4g
PiArCWludCBlcnJvcjsNCj4gPiArDQo+ID4gKwlpZiAoIWhhcHRpY3MtPmdhaW4gJiYgZW5hYmxl
ZCkgew0KPiA+ICsJCWRldl9lcnIoaGFwdGljcy0+ZGV2LA0KPiA+ICsJCQkiUGxlYXNlIHNldCB0
aGUgZ2FpbiBmaXJzdCBmb3IgdGhlIHB3bSBtb2RlXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlwd21fZ2V0X3N0YXRlKGhhcHRpY3MtPnB3bV9kZXYs
ICZzdGF0ZSk7DQo+ID4gKwlzdGF0ZS5lbmFibGVkID0gZW5hYmxlZDsNCj4gPiArCWlmIChlbmFi
bGVkKSB7DQo+ID4gKwkJcGVyaW9kX21hZ19tdWx0aSA9IHN0YXRlLnBlcmlvZCAqIGhhcHRpY3Mt
PmdhaW47DQo+IA0KPiBZb3UgYXJlIG11bHRpcGx5aW5nIGFuIHVuc2lnbmVkIGludCB0byBhIHUx
NiBhbmQgc3RvcmluZyBpdCBpbiBhIHU2NC4NCj4gSG93ZXZlciwgQyBkb2Vzbid0IHByb21vdGUg
dGhlIHR5cGVzLCBzbyB5b3UnbGwgZW5kIHVwIHdpdGggYW4NCj4gdW5leHBlY3RlZCByZXN1bHQg
aGVyZS4gWW91IGNhbiBmaXggaXQgYnkgcHJvbW90aW5nIHN0YXRlLnBlcmlvZCB0byB1NjQsIGll
Og0KPiANCj4gCQlwZXJpb2RfbWFnZV9tdWx0aSA9ICh1NjQpc3RhdGUucGVyaW9kICogaGFwdGlj
cy0+Z2FpbjsNCj4gDQo+IFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGUgY29kZSB3aGljaCBkZW1v
bnN0cmF0ZXMgdGhlIHByb2JsZW0uDQo+IA0KPiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4gI2luY2x1
ZGUgPHN0ZGludC5oPg0KPiANCj4gdWludDY0X3QgZm9vKHVuc2lnbmVkIGludCBhLCB1aW50MTZf
dCBiKQ0KPiB7DQo+IAl1aW50NjRfdCB0bXAgPSBhICogYjsNCj4gCXJldHVybiB0bXA7DQo+IH0N
Cj4gDQo+IHVpbnQ2NF90IGJhcih1bnNpZ25lZCBpbnQgYSwgdWludDE2X3QgYikNCj4gew0KPiAJ
dWludDY0X3QgdG1wID0gKHVpbnQ2NF90KWEgKiBiOw0KPiAJcmV0dXJuIHRtcDsNCj4gfQ0KPiAN
Cj4gaW50IG1haW4oKQ0KPiB7DQo+IAl1aW50NjRfdCB2YWw7DQo+IAl1bnNpZ25lZCBpbnQgYSA9
IDB4ZmYwMGZmMDA7DQo+IAl1aW50MTZfdCBiID0gMHgyMDA7DQo+IA0KPiAJdmFsID0gZm9vKGEs
IGIpOw0KPiAJcHJpbnRmKCJyZXN1bHQoJTB4LCAlMHgpID0gJTBsbHhcbiIsIGEsIGIsIHZhbCk7
DQo+IA0KPiAJdmFsID0gYmFyKGEsIGIpOw0KPiAJcHJpbnRmKCJyZXN1bHQoJTB4LCAlMHgpID0g
JTBsbHhcbiIsIGEsIGIsIHZhbCk7DQo+IH0NCj4gDQo+IENoZWVycywNCj4gSmVzDQoNClllcywg
eW91IGFyZSByaWdodCwgSSBzZWUgdGhlIGRpZmZlcmVudCByZXN1bHQsIEkgd2lsbCBmaXggdGhp
cy4NCg0KS2luZCByZWdhcmRzLA0KUm95DQoNCg==
