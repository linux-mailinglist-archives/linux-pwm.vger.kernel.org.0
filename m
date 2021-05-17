Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97D4382522
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 09:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhEQHOa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 03:14:30 -0400
Received: from mail-eopbgr1310098.outbound.protection.outlook.com ([40.107.131.98]:5952
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235095AbhEQHOQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 03:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gac2hiSEM/a3y4f4NKVSm0wOCNcz+5Zn1ExhWjb33Myg5FbZgx1YuvBUl4UNfCCVbyo4UgSfJnBiZNcUJ0tEvTtoLezBRXCvDmxNUGlKgAgZGBxzV9P+wwJ2+XtFnO33STe0dC0mzmQBIO2KNNx84lemu8eZ4q0BsWnMBAnB3n2qjcXpTws4Iz6ZbDoBrH47HUYsqIN35r8jrRC1S2xDmtajVsVIjQCEVqoNAvWEw049p1fNbXrL4Pwo8o5mSCFXS109RY3+udnM+tkKfp9yWsBiAirD6UqkYtASK5mgrXEuiW9wKEuPLCwxiR9oYsFhYFntImLK05TtPWZBrTh4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjWAJB3Sq6ldgyto6JTqgke2SxwcyR8PwIsEPtbbL3k=;
 b=F5WjvNsjckfXXnhZY+DJJ1DSzb0o5kPGaHc3SX+0rJ8NFxncPrsIhPZAEg+Ryyjiug1dKtpDslD6OPfdbVebi8OHHfXGCmivAx2oEmpIpnK4tvCHNaoMGu0IrBD5jqvzImk/GeF5kDotRJGqXqzwxklh7ijho4EjS1x6UX2LZHwJURlIFfdLLc7U70X1uc6Q0MkGSmJ9+XVsP9BVe1fay8xw8h2lkDuUHgkt1tPA+pPfLcZ/Zd6BwO4oXAvS8kSEWXGEehJPY64n0N6Fz2nZ4TSzPaQbFaq0HbKopHziMmETaKu2nKkxXhE7BiHjTXaIYUHQYwyG8eUb/xga6v54Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjWAJB3Sq6ldgyto6JTqgke2SxwcyR8PwIsEPtbbL3k=;
 b=uJJnxH8LGMag2jW4e9GDI2uQfAzIIH+OKCw+RaDyj05LcL8rG9Odv4W8eTuFMpmJxkKlmjylUXYJ+dSIRUXHZohJ6Sxgy/XWShwKgwZIfdR0vSj0GYfEh27j1aaDUVHWa1Q0xudTIX546AEhI6gY+ABeu3YXe4i2HjBNECSU5Ds8a7fzHWgcY5Ys48g0AMAyiDnMLquCFTfzbXXyOAma9fxYJDBoyUWLwfcoRryNUDOXkYZ+sV1VY4fCTc4ZwBmsy7YAyB0xXYhCM4wS7lpCJh+EqNfoxbPuLmsjrr7mp/P3pCA5tuCqXwOmJtCZeBFbF3QjXo3ch8728FMfNce32A==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3043.apcprd06.prod.outlook.com (2603:1096:203:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 07:12:53 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:12:53 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXSGulcCg0aX8h/0K5uaOliF3ibarkqkSAgALasoD//6+vgIAAitIA//99NwCAAJCxgA==
Date:   Mon, 17 May 2021 07:12:53 +0000
Message-ID: <52C0ED72-65A7-4C39-820F-D4368191878B@aspeedtech.com>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
 <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
 <20210517060615.3hyifoebyrddsrta@pengutronix.de>
 <C451B628-C0CC-47E9-84EF-42DB8518FE1E@aspeedtech.com>
 <20210517063500.toxlb2wbtbqpczwl@pengutronix.de>
In-Reply-To: <20210517063500.toxlb2wbtbqpczwl@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3667090-d01f-4c06-4185-08d919033088
x-ms-traffictypediagnostic: HK0PR06MB3043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB304329CE1A9A232C52A48F848B2D9@HK0PR06MB3043.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZyeK+Lz/G+xGOueXPs97fNBR9dtjDjA82jWqm5JluAJ/3bbChjFewQqXTmLcq2ybv96LIn7HGs5uIh39ybT8mO8Hz2GQRVF208LLfSeH+1LJQbyrcCYUaPLjiqpM08oKP6uYjLhd5SR7V/XYD+mn18Wt96/eM8jr5KaWDO8liyVXmIJ9hXyOjfg9ag7e7Z0vQuyEVb/5KZqm2tWO5OWuwn2kMy705tPYrE6YDkA0kyofbwkA/MCuSG8lX5a8ZQpQNRcGCSiBgnlBFffSzKAuNDMh8cUnaDnAEZIOIPCAKwOfprI99RajwXrsxTaDS9RmxU+RTOjqwYHrvk4FMGk+9OOxHhv42SHszqn/8nJbMCaO8KQCkyya51wolgrIDlS01Ozz9Tajq6pM6+R0fVQdUDrDQZlxE/NQxXKoMOaKtqvitsDvT+z0OUuV5PTMIOipBSp/gPkBze52PYrmbg50inwW98BEkpIu/f45jfpkjqZ63ATNIH4p4IFI8uFVH7e+zGdM8d0S37nqdRct0UK6GAyVFaY/EL1eD5/9mSUlpUShRPjc7uiEFQ9qIydXGoT3cHiIIQT3xG6SO7j/v9PuvY0LLRLHgmDIDGotn4O3Cqd80nHiXOZnHMQeAdhWAJyBFpkeCpSUttXmZuMlE4bnZIJJfd7pZEfE9G8aIllxWo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39840400004)(478600001)(6512007)(8676002)(2616005)(54906003)(5660300002)(122000001)(71200400001)(66446008)(6916009)(86362001)(186003)(66476007)(36756003)(66556008)(8936002)(66574015)(6486002)(33656002)(7416002)(2906002)(316002)(38100700002)(26005)(66946007)(4326008)(83380400001)(6506007)(64756008)(76116006)(55236004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TWFqMHB0TFdRNEc1SEVLbTF2dzM1MHFURjhmK3hZL0lVWUtXSGcraHpLNU84?=
 =?utf-8?B?WGpNNXhkcEtnbnorR1pBMVNxSXpGamhJTmtPd3QyODQzSG8rVzZReXVKT2pw?=
 =?utf-8?B?ZlcweGFMWXo0VS9jaVMxMy93bmYwUUY5aEZnWXNoNHpOSkxQYVpQZ3JQT3kr?=
 =?utf-8?B?b3Y0ZHlkSjNJZzA5QnlaazNWTjB0SnRKVHZhMjRyYXNKY0E1WHptc2JpTXp3?=
 =?utf-8?B?Yk1NOVdFd3dtRE1lSzM1eTRTWW5iK01Zc1ZxV2JYSEhZWS9xUGFPMCtzcDlG?=
 =?utf-8?B?WWpZSmVxNUZobHFzdENjNEhmMWlUY0NWbGFobU1HQW41b2xrR09vaEhrc1pF?=
 =?utf-8?B?bERGa2FDZDFYdWhLdnorak9GZ21BV3FWTmtBa0sxM3k3dlpOTVV5MWhieGhH?=
 =?utf-8?B?dWoxM1UyWHRtTHBXc2hIeFRta2hybXNxUFNNTlhJdmljc3JERlFBaVJiL2Y1?=
 =?utf-8?B?R05UMXArRnhNeWtsT3pINDZ1MmNqU3JvdGQrYlZMU3VjT3pySll1SElyc21i?=
 =?utf-8?B?cWtEVDdjQUtKMHVEMnRsdmo3bzFKcllRY1Z2S1hqTEk5UU1NOE5LWERrc1Fj?=
 =?utf-8?B?VXM1ejAxNC9hR2hubjF6aEVOREFDaFgwM1RtOTg2NlJ4bjh0ODRqWUwyVzRY?=
 =?utf-8?B?aFlGSnJQUld0VFRJWTFRRXUyVlJ0cy9aYjl3VVdPcy94a2tjcVlETy9NbVJO?=
 =?utf-8?B?WmZxVGhtQTV1cUg0S0ZzNGZMNDBTTXcxVHZ0VWxWUkR4cUpIOTZtcEtBNjNu?=
 =?utf-8?B?N3ZocWt2WGhVeDFhSFRJT3IrbTFwTTBlMTRLSS9vNkFkU1N5SlIzcm4rbnlQ?=
 =?utf-8?B?NlJzMTlpMm13YjU3WEVjWlVYWkNDQ2ZsYXlzdTBDd0w0TG56eDBzQmxTT2Qr?=
 =?utf-8?B?RFBpVXdnTE5KajM1UmM3emJQVE1XdHl2N002TDlTOUE4WmR3VzZUMk5yQStj?=
 =?utf-8?B?TUdBMmRPNW9JTnJ6clZMTnBrS3Y1MENxcmtCRnk1UTQwNjZtYlpqc2dlbEJL?=
 =?utf-8?B?TVFWaTJQNE9xdjFaa1A4ZlBmVVRTNHI1VDdmMWphZ2RYbVVadmlocGdNRG1m?=
 =?utf-8?B?ZUw0d0Jsd00wR214WjNRSTBXWGlCb1NPTE5NdWtBSWZvcWp3S012ZG9aeGVB?=
 =?utf-8?B?UTAxdS96aGdLaEo5QU5wdmY4REFuL3pUZVZGb2lLT3Q1UWZvQURIV0Z5UTBX?=
 =?utf-8?B?OG4yRnZBZThITi9tckprUG1FeDNLQ2plMlhEeEZUQ2VzeldvYmNOQU10U2lW?=
 =?utf-8?B?Qk1BK1RkR0tIU2I4RG1jbzdocGNKR25tdTFQNEZ6akdXUnNnQlhEZUorYnZG?=
 =?utf-8?B?cWR1VUQ1T3p2K3hvZEFaS05HeWNjVDByZ0lOd25reUVjL1pWOHRjaXQ3RFFV?=
 =?utf-8?B?QXlYaGZ3TERKQm03cTNGQnBGRHdDeGNCRlhRTWZZaUdqQ0hidWpYYUY2QWtj?=
 =?utf-8?B?bnRFV05UcHUrVEFPSHQwdFlPK2tPVExUcmdIZ3cvUmtST29zd2gwRjJFOWZw?=
 =?utf-8?B?ODZUS2lVZ2NNU25jUFh4Y24vajBxUFp0Y0wyZlRrSHBuYUdyV3k4OUFKeWk5?=
 =?utf-8?B?dDdpc1lsdFNyblgydm02SlRlaUJBMmhyOE9QQkJ6SEFZd0lrVHRrNGFDRVBH?=
 =?utf-8?B?VXVGbWVTa002V2RvUDl1alBuT1NNeGcwZzZHajF3RytDb3AyRnJDamJTelBV?=
 =?utf-8?B?aGN4TTFrQjdjNzhIZVV2ZHNxYzZDRVd6Q0FiUGhLSmo5S3h5cEY3Vzd3RFVY?=
 =?utf-8?Q?gZ44n/BB+Px7KuIo1saKbGX2iC+g0rDey/1McwX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B67970252F4BC4D994AEBB11FDA86BE@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3667090-d01f-4c06-4185-08d919033088
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 07:12:53.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHIVQHlJl5+kn3mgvTeMAJxPt96IkogzKVqYGHWnFfjBUkgggTU3wFUF58EIhUF3GttaxUG63rJJpnNYWaXaQ2m1Px8RF3sq/HGzpM77564=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3043
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQoNCiAgICA+IE9uIDIwMjEvNS8xNywgMjozNSBQTSxVd2UgS2xlaW5lLUvDtm5pZ3dyb3Rl
Og0KDQogICAgPiAgIE9uIE1vbiwgTWF5IDE3LCAyMDIxIGF0IDA2OjIzOjA2QU0gKzAwMDAsIEJp
bGx5IFRzYWkgd3JvdGU6DQogICAgPiAgID4gSGksDQogICAgPiAgID4gCU9uIDIwMjEvNS8xNywg
MjowNiBQTSxVd2UgS2xlaW5lLUvDtm5pZ3dyb3RlOg0KICAgID4gICA+IA0KICAgID4gICA+IAlP
biBNb24sIE1heSAxNywgMjAyMSBhdCAwMjo1Mzo0NEFNICswMDAwLCBCaWxseSBUc2FpIHdyb3Rl
Og0KICAgID4gICA+IAk+CT4gT24gMjAyMS81LzE1LCAxMTo1NyBQTSxVd2UgS2xlaW5lLUvDtm5p
Z3dyb3RlOg0KICAgID4gICA+IAk+CT4gDQogICAgPiAgID4gCT4JPiAJPgk+ICsJZGl2X2ggPSBE
SVZfUk9VTkRfRE9XTl9VTEwoZGl2X2gsDQogICAgPiAgID4gCT4JPiAJPgk+ICsJCQkJICAgKEZJ
RUxEX01BWChQV01fQVNQRUVEX0NUUkxfQ0xLX0RJVl9MKSArIDEpKTsNCiAgICA+ICAgPiAJPgk+
IAk+CT4gKwlkaXZfaCA9IERJVl9ST1VORF9ET1dOX1VMTChkaXZfaCwgTlNFQ19QRVJfU0VDKTsN
CiAgICA+ICAgPiAJPgk+IA0KICAgID4gICA+IAk+CT4gCT4gQXMgYSBkaXZpc2lvbiBpcyBhbiBl
eHBlbnNpdmUgb3BlcmF0aW9uIHlvdSBjYW4gYmV0dGVyIGZpcnN0IG11bHRpcGx5DQogICAgPiAg
ID4gCT4JPiAJPiBOU0VDX1BFUl9TRUMgYW5kIEZJRUxEX01BWChQV01fQVNQRUVEX0NUUkxfQ0xL
X0RJVl9MKSArIDEgYW5kIGRpdmlkZSBieQ0KICAgID4gICA+IAk+CT4gCT4gdGhlIHJlc3VsdC4N
CiAgICA+ICAgPiAJPgk+IA0KICAgID4gICA+IAk+CT4gV2hlbiBJIG11bHRpcGx5IE5TRUNfUEVS
X1NFQyBhbmQgRklFTERfTUFYKFBXTV9BU1BFRURfQ1RSTF9DTEtfRElWX0wpICsgMSB0aGUgcmVz
dWx0IHdpbGwgb3ZlcmZsb3cNCiAgICA+ICAgPiAJPgk+IGZvciAzMi1iaXRzIGFuZCB0aGUgZGl2
aXNvciB0eXBlIG9mIGRvX2RpdiBpcyAzMi1iaXRzIHNvIEkgbmVlZCB0byBkbyBkaXYgdHdpY2Ug
dG8gYXZvaWQgdGhlIGlzc3VlLg0KICAgID4gICA+IAk+CT4gQ2FuIHlvdSBnaXZlIG1lIHNvbWUg
c3VnZ2VzdHM/DQogICAgPiAgID4gDQogICAgPiAgID4gCT4gSG1tLCB5b3UncmUgcmlnaHQuIFRo
ZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIGRpdjY0XzY0LCBJIHRob3VnaHQgdGhlcmUNCiAgICA+
ICAgPiAJPiB3YXMgb25lLiBBbnlob3csIHdoaWxlIGxvb2tpbmcgYXQgdGhlIHZhcmlvdXMgZGl2
aWRlIGZ1bmN0aW9ucyBJIHNhdw0KICAgID4gICA+IAk+IHRoYXQgZGl2aWRpbmcgYnkgYSBjb25z
dGFudCBzaG91bGRuJ3QgYmUgdGhhdCBleHBlbnNpdmUsIHNvIEkgdGhpbmsgdGhlDQogICAgPiAg
ID4gCT4gc2FuZSB3YXkgaXMgdG8ga2VlcCB0aGUgdHdvIGRpdmlzaW9ucyBhbmQgYWRkIGEgY29t
bWVudCBkZXNjcmliaW5nIHRoZQ0KICAgID4gICA+IAk+IHByb2JsZW0uDQogICAgPiAgID4gQWNj
b3JkaW5nIHRvIG91ciBmaXhlZCB2YWx1ZSwgSSB0aGluayB0aGF0IEkgY2FuIHVzZSBiaXQgc2hp
ZnQgdG8gcmVkdWNlIG9uZSBkaXZpZGUgZnVuY3Rpb246DQogICAgPiAgID4gDQogICAgPiAgID4g
cmF0ZSA9IGNsa19nZXRfcmF0ZShwcml2LT5jbGspOw0KICAgID4gICA+IC8qIEdldCB0aGUgc21h
bGxlc3QgdmFsdWUgZm9yIGRpdl9oICAqLw0KICAgID4gICA+IGRpdl9oID0gcmF0ZSAqIHN0YXRl
LT5wZXJpb2Q7DQogICAgPiAgID4gZGl2X2ggPj49IChfX2ZscyhQV01fQVNQRUVEX0ZJWEVEX1BF
UklPRCArIDEpICsNCiAgICA+ICAgPiAJICAgX19mbHMoRklFTERfTUFYKFBXTV9BU1BFRURfQ1RS
TF9DTEtfRElWX0wpICsgMSkpOw0KICAgID4gICA+IGRpdl9oID0gRElWX1JPVU5EX0RPV05fVUxM
KGRpdl9oLCBOU0VDX1BFUl9TRUMpOw0KDQogICAgPiBEaWQgeW91IGNoZWNrIGhvdyB0aGlzIGlz
IGNvbXBpbGVkIHRvIGNvZGU/IEknZCBleHBlY3QgdGhhdCBpdCBkb2Vzbid0DQogICAgPiByZXN1
bHQgaW4gYmV0dGVyIGNvZGUgdGhhbiB3cml0aW5nIGl0IGFzIGEgZGl2aXNpb24uIEdpdmVuIHRo
YXQgYQ0KICAgID4gZGl2aXNpb24gaXMgZWFzaWVyIHRvIHVuZGVyc3RhbmQgZm9yIGEgaHVtYW4g
cmVhZGVyLCBJJ2Qgc3RpY2sgdG8gdGhhdC4NCg0KSSBmb3VuZCB0aGF0IEkgY2FuIHVzZSBkaXY2
NF82NCB0aHJvdWdoICNpbmNsdWRlIDxsaW51eC9tYXRoNjQuaD4gYW5kIHVzZSAiZGl2NjRfdTY0
IjoNCg0KdTY0IGRpdl9oLCBkaXZfbCwgZGl2aXNvcjsNCnUzMiBpbmRleCA9IHB3bS0+aHdwd207
DQoNCnJhdGUgPSBjbGtfZ2V0X3JhdGUocHJpdi0+Y2xrKTsNCi8qIEdldCB0aGUgc21hbGxlc3Qg
dmFsdWUgZm9yIGRpdl9oICAqLw0KZGl2X2ggPSByYXRlICogc3RhdGUtPnBlcmlvZDsNCmRpdmlz
b3IgPSAodTY0KU5TRUNfUEVSX1NFQyAqIChQV01fQVNQRUVEX0ZJWEVEX1BFUklPRCArIDEpICoN
CiAgICAgICAgICAgICAgICAoRklFTERfTUFYKFBXTV9BU1BFRURfQ1RSTF9DTEtfRElWX0wpICsg
MSk7DQpkaXZfaCA9IGRpdjY0X3U2NChkaXZfaCwgZGl2aXNvcik7DQpkaXZfaCA9IG9yZGVyX2Jh
c2VfMihkaXZfaCk7DQppZiAoZGl2X2ggPiAweGYpDQogICAgICAgIGRpdl9oID0gMHhmOw0KDQpk
aXZfbCA9IHJhdGUgKiBzdGF0ZS0+cGVyaW9kOw0KZGl2aXNvciA9ICh1NjQpTlNFQ19QRVJfU0VD
ICogKFBXTV9BU1BFRURfRklYRURfUEVSSU9EICsgMSkgKg0KICAgICAgICAgICAgICAgIEJJVChk
aXZfaCk7DQpkaXZfbCA9IGRpdjY0X3U2NChkaXZfbCwgZGl2aXNvcik7DQoNCkNhbiBJIHVzZSB0
aGlzIG9uZT8NCg0KVGhhbmtzDQoNCg==
