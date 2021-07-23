Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD13C3D3386
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jul 2021 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhGWDm5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 23:42:57 -0400
Received: from mail-eopbgr1320137.outbound.protection.outlook.com ([40.107.132.137]:48735
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233659AbhGWDmx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 23:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajmv4LkbGGinNmLzK1vjFurmWl+9N/W/RpI6HSxXm2ktD2GJiQN+rlmr212k8Z9zVIrIn3mRFKeRsPIxnwypvEALyvhB2ibj2/uKJ2CBtgyQFhGdGWptwp1pfWHKXIP8sNxbE0ecI9oquXlDjEEpxW53wvVRBSDnz3EgIBmy7pvyHJ/IdZSO52CohjdMi/wlyT4mYBM2avGHBTWT2jt2DjDB0OiY86rD1NxX7DYRGwNU0yKGR62LSQqUsl7kek71Oi3ohJaZaNYVvLu/XGR2JcZKIXqHIotdxWPkMb1IvaRM+k/yZd18Oi+rF/IUhlfGu+EAgWmPn0K2D1lc4GS6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PvYSatSjdHA1AWKKhQsgG5wWdbToZsFrdpMXiqs16o=;
 b=nLDiIADgeG8CZN58iOmZxHDS7CMPzo0m5ffklq3+LZa6QaGPRCoWaldXAB73o1RbELLDGsjF5gTtonw88s9s9a4wZlf+b58g8ptTR6lcGAJrobwOIGXjorTmbcQoIffDIaqE2PnlOD+6dLbdfJ6alxF8igNU4OCEtUj+vZSfvR7Ag26YzyaihXTVfMW6fy9mEjKbuJle3QrjWXXXSxCrkJmIj60WO1eMziCKmrZpBRb5Ox05nRMlGxnXl4BOHz2Y5hUMBapyW3CNou14LagQrYI1k0i3xpZqMCHGpDhiCyTcqTgs4XuHyeeDv1e5fVFtoc0yeZ366V9vLO0oQIa0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PvYSatSjdHA1AWKKhQsgG5wWdbToZsFrdpMXiqs16o=;
 b=zBb9vrDzogDZLmhAdfllPVPSWK+e2Y0IxtzHrHJCm2phMrD4Hze2rBKChjGDvwuGQ2xsFmlX2RGfHohjFMM7fUdMbQ5NozISryKDnCL31pRgO4o6Ul4uMaIVl3hIvIzESYwG6i80TXhhlAUs1lABTHRiQBE1gH+yNcQs9woLBxYkqoJqHdW6RB1LJOF9g37+83pCCELmRkERrCv7mJpOiA3mwHFz83wvTIT1/oxckYs+FXArnoQsmDKkMXDAHSuTXE2sDGuFOPZd9qkBPLrXe2uW5XiSlsQHiKr+LKpWnOBBIkgcrntNfzZg5AD5eSHhx8UPPp84O7Ojj8QFbQb4Jg==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3091.apcprd06.prod.outlook.com (2603:1096:203:89::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 23 Jul
 2021 04:23:23 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4331.035; Fri, 23 Jul 2021
 04:23:23 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXdI70LATZWzg1kUKYrs9wZPLHOKtELJmAgAE5s4D//9OwgIAAqykA//+IDYCAAJI6gIAH2oiA//+aeoAAY7A+AA==
Date:   Fri, 23 Jul 2021 04:23:23 +0000
Message-ID: <7F794DD8-0FC6-491D-B071-CAD6C216E044@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
 <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
 <3F12A498-DF5C-4954-8BCE-8C0C66BC9734@aspeedtech.com>
 <4BC9AEF6-31EA-4EDA-BCB2-7E4D44B6D5D2@aspeedtech.com>
 <20210721124859.clv6qlitbyomdz6s@pengutronix.de>
In-Reply-To: <20210721124859.clv6qlitbyomdz6s@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cadd8076-e7b1-4ec7-f243-08d94d919c15
x-ms-traffictypediagnostic: HK0PR06MB3091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB3091D4B3D1ADED61392AC3518BE59@HK0PR06MB3091.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oh8JZNrraLsOQbONl8w3FEOtJHXC5cipg+5QRtmvFy1YbuwBQ37TP3f2CB/qLbqJ3KUTIP6Ye/A6YXdv44KpmoofA7FXlNMl39E51F0801eAXiKahsMBvpfEqH+XRos8wLncPFH6Q3d2/Pi2c9Tf3Pe7u3tAwXqCtUzPZbwQErU2CScEDNwzrxzw51THSj16cMHjJGBQq1LzzYAPsrg7wv6ODNYKpExmJHpKZZ4w4mykwIbvy19I2bdDjMWXhZl9HXbG6BiqX3sTyE5+S6SuviUoNYZApMjVLJLpM/jh0BrzvBN97KIYXckvY38lcSbB2cSU10LJoMXxHLcnBw+u/CxZXbbNZVTyRgc0w/gFkZsiQaNGN/PnM1XSGna9P/Lkyo0HUEgLHvpnOwzIjHaPdUgm7U3RXJJ77sfxSSjYi2GBKrTdp9ujU5Bc6gfnOSi54r7AnNt6IsHb3jk8Qt/bPOGgfz1oXVHYMOf95BzLXvkRWOZF+LSX/FiU/zEjJQpWL0CD7WFKR35xsSuFN3Mfsb8H2RCEiUbf/SrUyVJYezofvVvuRhwBUTrQ1r5vUHfkp6NGoGmr6N4AqWWgSaiOzX7LF/oPzbN5GvHUhEEXeg1LVnP0ECst3zNaZKvX+eduNEThaI7KhmNNr84dyaWbX+qFlIKWNbaY3tV1iwxQlvS0SJUXcaj9oTYkvvkO/1yHmSGGGs/oPgx/z8igiy2EGv1n70yKXzUXrGK+UEkyZQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(136003)(396003)(376002)(346002)(76116006)(186003)(38100700002)(66574015)(122000001)(86362001)(33656002)(26005)(83380400001)(36756003)(8936002)(316002)(54906003)(2616005)(8676002)(508600001)(107886003)(4326008)(71200400001)(66446008)(5660300002)(7416002)(6486002)(53546011)(6512007)(66476007)(66946007)(6916009)(66556008)(64756008)(2906002)(6506007)(55236004)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFRWOThwNitJMjFWYTZLbUsxb0ZwaTEvMFpCODhqQ0w2TFhqeG52V3lLZFhW?=
 =?utf-8?B?bW1FRSs5ZFZvd3BMblpveFFuaXBpZG1oT2I2Skg1L0xTWFRvdytDcHhUQk5j?=
 =?utf-8?B?OEltV3FFc2ZSSFRxMDQ4dGdTU1hBbEhHczZqc2EyRmdBM1I2c3N6ZDBDL2tZ?=
 =?utf-8?B?a2VYOVZCTVBDU3ZPdHFxR3hlZlVIaTd0eW5RSHo2eHBuTjcvNEdJcXIraEVz?=
 =?utf-8?B?bXdxOGNRTnUwUWMrVTJxVTlTVnFHcmFJQ1B6TjhrOGJwRXgxYlk5SDdURm4y?=
 =?utf-8?B?dUxvQkNSUHhRTzk4NlpvZWRzM1NhR0RBNWc2OFgwSmVycGdpRjhQbStoNnNx?=
 =?utf-8?B?RHh1WTAxODhSNXJySmZ4VkJ0RjdPSFdpb080Q1BsWjVUZWR2NW5wTTgvMkQr?=
 =?utf-8?B?VzlEWG16Kzk4dDlqQXlLbnNyQXUyanEwWmIwSXdGejhhNmJBazc3N3d0L0Ux?=
 =?utf-8?B?N2kxSmVHRFdNaG5SemJTS2hEVk9FWkRiM25wTXJHUG5pa0w0MGpuU25jTWNt?=
 =?utf-8?B?aXNGellUTmZBbVJJZGp2cmZVMWJLcm41YXpuNGtPb0Rsd3ludkk2dDhaSUF3?=
 =?utf-8?B?Q3BwdC94Yjk5RUlDZFRsTkxRN1UvQkNHblZZM0J4TExvUEUvK1ozL3FTZkZz?=
 =?utf-8?B?cklld3h5a0JxeXpkMEwwUWdiQTZGdWR5d1A2cG1QWnM5RzF1THUyVmNMTE9D?=
 =?utf-8?B?eDJNWGwvcldKWElORVgwU2ptZFl5TlhqSUtDa0pqcU84NGxqcW1VZ1Y2Y0dT?=
 =?utf-8?B?NSt4aGhSZHRGMFNvcUZDZUZ3amQvZFZWRFJ5VW1FR0pHOWRGcWFzcFUzUE9W?=
 =?utf-8?B?cG4vRUZETndMZW96RlRCMXVxRHNWaUREd1ZIUGk2OVArR3l5dWtkUG9ZN2hw?=
 =?utf-8?B?SXY1cXFHRmFVNHdGL2ZoVkU2Rk9JTjJTU0lvQytVV011WmVDMXdCeUNQWVJY?=
 =?utf-8?B?SnRuR3VwMWhuN3gxMmFWNDEwM1YwajRnSjJUN0JRY3hXazBoU3UrdXNJZWNk?=
 =?utf-8?B?eDg3bHk2NWE5QzVhWnRhbGJVclY0Q01CZnFBaWVCTE9TZzlsU1lWM3lKSWkx?=
 =?utf-8?B?aVB6d0lVMUtveWZneithREdsRTRCdWRFOUpZbGQxK3JjckNNTE1mR3RlcXZ3?=
 =?utf-8?B?TFRjUE5lOWRuYXd6U2RxVjYrUUdkQVJsajlaMis2MGhYcDlsaXRCS1R4MWd2?=
 =?utf-8?B?eUVrWnFwMCsxQ0dMY2cvYVlUdWJmL09FelE4V2FqZjNvbngwODhyWjZhM01L?=
 =?utf-8?B?bFVzcTNuYUNkTnYxZk4xZS8zckhORDlibDFxazZ0ZGE4Y2VQSnZuR0hCUHFi?=
 =?utf-8?B?S1lMQWlzSGMxNG5zTGlzNURIZ2JVdjBrM2ZrdVJkK2REVVZSSEdjTDlvWlVn?=
 =?utf-8?B?RS9nNGhJTW1yQXNSYlRMb3d1Y3dvblJ4eUR3SEpQMW9SaFJVVEE4MldkSkxM?=
 =?utf-8?B?QWMvaERnc09rSGUxZUtKK3gyUCtGOGlpZjZrZEJkL2pvNTVFY0JHakJZWjk5?=
 =?utf-8?B?c3Q3dVZMT0FKNVJOMGRtZVVjeXRwcXAxN0FoaWkxM0RZczRTdkY0cjJ5TlZZ?=
 =?utf-8?B?QStSdkNpUjd2NVB0THozNFU4b29WMVJUaGRSdCtHQVpId2JmOEpid1pQdHRG?=
 =?utf-8?B?V1JwSVBldVZuN3lMSzRYK3RCVjVJWkRldlpYNmRCNUhUeStHQjdvSSthaHZN?=
 =?utf-8?B?TVhRaEE1QzZ4bnBFdGFJS2piMVcwQit0NDc5R2k3VUMrVEJXV0JQK3Voa0tR?=
 =?utf-8?Q?Pxkt6vsD6jhUiPMdCwXpos/xXtfmH0ecejfh3En?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <136FE9BBAA7838469A0D03097B61451E@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadd8076-e7b1-4ec7-f243-08d94d919c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 04:23:23.2897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3P9Nl9Us0ax8pUiKEdOzCqdARWJAkZcUl6KQmSmwMbXt5Yng7ji2/JNo+ZO5vyESOiM2tjTLO1e+fUU5RatZ1gU4IvBJF67WJERpTTVhvHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3091
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMjAyMS83LzIzLCAzOjE3IEFNLCAiVXdlIEtsZWluZS1Lw7ZuaWciIDx1LmtsZWluZS1rb2Vu
aWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KDQogICAgT24gV2VkLCBKdWwgMjEsIDIwMjEgYXQg
MTA6NTI6MjFBTSArMDAwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+PiBIaSBVd2UsDQogICAg
Pj4gDQogICAgPj4gICAgIE9uIDIwMjEvNy8xNiwgNjoxMyBQTSwgIlV3ZSBLbGVpbmUtS8O2bmln
IiA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCiAgICA+PiANCiAgICA+
PiAgICAgICAgIE9uIEZyaSwgSnVsIDE2LCAyMDIxIGF0IDA5OjIyOjIyQU0gKzAwMDAsIEJpbGx5
IFRzYWkgd3JvdGU6DQogICAgPj4gICAgICAgICA+PiBPbiAyMDIxLzcvMTYsIDM6MTAgUE0sICJV
d2UgS2xlaW5lLUvDtm5pZyIgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6
DQogICAgPj4gICAgICAgICA+PiANCiAgICA+PiAgICAgICAgID4+ICAgICBPbiBGcmksIEp1bCAx
NiwgMjAyMSBhdCAwMTo0ODoyMEFNICswMDAwLCBCaWxseSBUc2FpIHdyb3RlOg0KICAgID4+ICAg
ICAgICAgPj4gICAgID4+IE9uIDIwMjEvNy8xNSwgMTE6MDYgUE0sICJVd2UgS2xlaW5lLUvDtm5p
ZyIgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4+IHdyb3RlOg0KICAgID4+ICAgICAg
ICAgPj4gICAgID4+ICAgICA+IEFub3RoZXIgaXM6IFRoZSBQV00gZG9lc24ndCBzdXBwb3J0IGR1
dHlfY3ljbGUgMCwgb24gc3VjaCBhIHJlcXVlc3QgdGhlDQogICAgPj4gICAgICAgICA+PiAgICAg
Pj4gICAgID4gUFdNIGlzIGRpc2FibGVkIHdoaWNoIHJlc3VsdHMgaW4gYSBjb25zdGFudCBpbmFj
dGl2ZSBsZXZlbC4NCiAgICA+PiAgICAgICAgID4+ICAgICA+PiANCiAgICA+PiAgICAgICAgID4+
ICAgICA+PiAgICAgPiAoVGhpcyBpcyBjb3JyZWN0LCBpcyBpdD8gT3IgZG9lcyBpdCB5aWVsZCBh
IGNvbnN0YW50IDAgbGV2ZWw/KQ0KICAgID4+ICAgICAgICAgPj4gICAgID4+IA0KICAgID4+ICAg
ICAgICAgPj4gICAgID4+IE91ciBwd20gY2FuIHN1cHBvcnQgZHV0eV9jeWNsZSAwIGJ5IHVuc2V0
IENMS19FTkFCTEUuDQogICAgPj4gICAgICAgICA+PiANCiAgICA+PiAgICAgICAgID4+ICAgICA+
IFRoaXMgaGFzIGEgc2xpZ2h0bHkgZGlmZmVyZW50IHNlbWFudGljIHRob3VnaC4gU29tZSBjb25z
dW1lciBtaWdodA0KICAgID4+ICAgICAgICAgPj4gICAgID4gZXhwZWN0IHRoYXQgdGhlIGZvbGxv
d2luZyBzZXF1ZW5jZToNCiAgICA+PiAgICAgICAgID4+IA0KICAgID4+ICAgICAgICAgPj4gICAg
ID4JcHdtX2FwcGx5KG15cHdtLCB7IC5wZXJpb2QgPSAxMDAwMCwgLmR1dHlfY3ljbGUgPSAxMDAw
MCwgLmVuYWJsZWQgPSB0cnVlIH0pDQogICAgPj4gICAgICAgICA+PiAgICAgPglwd21fYXBwbHko
bXlwd20sIHsgLnBlcmlvZCA9IDEwMDAwLCAuZHV0eV9jeWNsZSA9IDAsIC5lbmFibGVkID0gdHJ1
ZSB9KQ0KICAgID4+ICAgICAgICAgPj4gICAgID4JcHdtX2FwcGx5KG15cHdtLCB7IC5wZXJpb2Qg
PSAxMDAwMCwgLmR1dHlfY3ljbGUgPSAxMDAwMCwgLmVuYWJsZWQgPSB0cnVlIH0pDQogICAgPj4g
ICAgICAgICA+PiANCiAgICA+PiAgICAgICAgID4+ICAgICA+IHJlc3VsdHMgaW4gdGhlIG91dHB1
dCBiZWluZyBsb3cgZm9yIGFuIGludGVnZXIgbXVsdGlwbGUgb2YgMTAgwrVzLiBUaGlzDQogICAg
Pj4gICAgICAgICA+PiAgICAgPiBpc24ndCBnaXZlbiB3aXRoIHNldHRpbmcgQ0xLX0VOQUJMRSB0
byB6ZXJvLCBpcyBpdD8gKEkgZGlkbid0IHJlY2hlY2ssDQogICAgPj4gICAgICAgICA+PiAgICAg
PiBpZiB0aGUgUFdNIGRvZXNuJ3QgY29tcGxldGUgcGVyaW9kcyBvbiByZWNvbmZpZ3VyYXRpb24g
dGhpcyBkb2Vzbid0DQogICAgPj4gICAgICAgICA+PiAgICAgPiBtYXR0ZXIgbXVjaCB0aG91Z2gu
KQ0KICAgID4+ICAgICAgICAgPj4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uDQogICAgPj4g
ICAgICAgICA+PiBPdXIgaGFyZHdhcmUgYWN0dWFsbHkgY2FuIG9ubHkgc3VwcG9ydCBkdXR5IGZy
b20gMS8yNTYgdG8gMjU2LzI1Ni4NCiAgICA+PiAgICAgICAgID4+IEZvciB0aGlzIHNpdHVhdGlv
biBJIGNhbiBkbyBwb3NzaWJsZSBzb2x1dGlvbjoNCiAgICA+PiAgICAgICAgID4+IFdlIGNhbiB0
aG91Z2ggY2hhbmdlIHBvbGFyaXR5IHRvIG1lZXQgdGhpcyByZXF1aXJlbWVudC4gSW52ZXJzZSB0
aGUgcGluIGFuZCB1c2UNCiAgICA+PiAgICAgICAgID4+IGR1dHlfY3ljbGUgMTAwLiANCiAgICA+
PiAgICAgICAgID4+IEJ1dCBJIHRoaW5rIHRoaXMgaXMgbm90IGEgZ29vZCBzb2x1dGlvbiBmb3Ig
dGhpcyBwcm9ibGVtIHJpZ2h0Pw0KICAgID4+IA0KICAgID4+ICAgICAgICAgPiBJZiB0aGlzIGRv
ZXNuJ3QgcmVzdWx0IGluIG1vcmUgZ2xpdGNoZXMgdGhhdCB3b3VsZCBiZSBmaW5lIGZvciBtZS4N
CiAgICA+PiAgICAgICAgID4gKEFzc3VtaW5nIGl0IGlzIGRvY3VtZW50ZWQgZ29vZCBlbm91Z2gg
aW4gdGhlIGNvZGUgdG8gYmUNCiAgICA+PiAgICAgICAgID4gdW5kZXJzdGFuZGFibGUuKQ0KICAg
ID4+IA0KICAgID4+ICAgICA+IFRoZSBwb2xhcml0eSBvZiBvdXIgcHdtIGNvbnRyb2xsZXIgd2ls
bCBhZmZlY3QgdGhlIGR1dHkgY3ljbGUgcmFuZ2U6DQogICAgPj4gICAgID4gUFdNX1BPTEFSSVRZ
X0lOVkVSU0VEIDogU3VwcG9ydCBkdXR5X2N5Y2xlIGZyb20gMCUgdG8gOTklDQogICAgPj4gICAg
ID4gUFdNX1BPTEFSSVRZX05PUk1BTDogU3VwcG9ydCBkdXR5X2N5Y2xlIGZyb20gMSUgdG8gMTAw
JQ0KICAgID4+ICAgICA+IER5bmFtaWMgY2hhbmdlIHBvbGFyaXR5IHdpbGwgcmVzdWx0IGluIG1v
cmUgZ2xpdGNoZXMuIFRodXMsIHRoaXMgd2lsbCBiZWNvbWUNCiAgICA+PiAgICAgPiBhIHRyYWRl
LW9mZiBiZXR3ZWVuIDEwMCUgYW5kIDAlIGR1dHlfY3ljbGUgc3VwcG9ydCBmb3IgdXNlciB0byB1
c2Ugb3VyIHB3bSBkZXZpY2UuDQogICAgPj4gICAgID4gSSB3aWxsIGRvY3VtZW50IGl0IGFuZCBz
ZW5kIG5leHQgcGF0Y2guDQogICAgPj4gDQogICAgPj4gRm9yIGhhbmRsaW5nIHRoZSBzaXR1YXRp
b24gdGhhdCB0aGUgdXNlciB3YW50IHRvIHNldCB0aGUgZHV0eSBjeWNsZSB0byAwJSwgdGhlIGRy
aXZlciBjYW46DQogICAgPj4gMS4gSnVzdCByZXR1cm4gdGhlIGVycm9yLg0KICAgID4+IDIuIFVz
ZSB0aGUgbWluaW11bSBkdXR5IGN5Y2xlIHZhbHVlLg0KICAgID4+IEkgZG9uJ3Qga25vdyB3aGlj
aCBzb2x1dGlvbiB3aWxsIGJlIHRoZSBiZXR0ZXIgd2F5IG9yIG90aGVycy4NCiAgICA+PiBJIHdv
dWxkIGJlIGdyYXRlZnVsIGlmIHlvdSBjYW4gZ2l2ZSBtZSBzb21lIHN1Z2dlc3Rpb24gYWJvdXQg
dGhpcyBwcm9ibGVtLg0KDQogICAgPiBJIHRob3VnaHQgaWYgeW91IGRpc2FibGUgdGhlIFBXTSBp
dCBlbWl0cyB0aGUgaW5hY3RpdmUgbGV2ZWw/IFRoZW4gdGhpcw0KICAgID4gaXMgdGhlIGJlc3Qg
eW91IGNhbiBkbyBpZiBkdXR5X2N5Y2xlID0gMCBpcyByZXF1ZXN0ZWQuDQoNClRoYW5rcyBmb3Ig
eW91ciBxdWljayByZXBseS4NCldoZW4gZHV0eV9jeWNsZSA9IDAgaXMgcmVxdWVzdGVkIG15IGRy
aXZlciBjdXJyZW50bHkgd2lsbCBlbWl0IHRoZSBpbmFjdGl2ZSBsZXZlbC4NClNvLCB0aGUgbmV4
dCBwYXRjaCBJIG5lZWQgdG8gZG8gaXMgdG8gYWRkIHRoZSBjb21tZW50IGFib3V0IHRoaXM/DQoN
CkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkNCg0K
