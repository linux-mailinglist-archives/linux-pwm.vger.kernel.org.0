Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF838243C
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 08:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhEQGY2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 02:24:28 -0400
Received: from mail-eopbgr1310110.outbound.protection.outlook.com ([40.107.131.110]:12523
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233718AbhEQGY1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 02:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDve0js6vKsounasuCsx9pJJcTwCICyRWOA0gORySUTXycSIx2lQOvfKsQ4PxcAFZ9ybm6b2LC+ojpEQPDWZHcnvd6N5uV2EKE4mICtX9hiXSaXs3sAr4WdLOdkSVj9U3rsgkt28+nzcJ+3joAjUYTJ85aYm+c1pwhekE2OrYQEGW0v8XGxvKg1Oc1aNY4SqO6Wva/Sjg6JplCT3dPiuquiHuUY7d/wAEnEKCrbKGFp0P6VPTshlX/8r5UN8oRNoYk54SkwTaRXONlFLcomPgWDKWRCusb8IWWAvp636d7gGgwTszJ3UTmmeMYJrraFTASHk7ABxBJV5sWMsWfJdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjq9cFY7sC+rnmLi6EiEYJzH5nn8926sChNnEd8dU2Y=;
 b=MgVXFH6KoiIG9LL3AKrhvj8qigwAiCsT1cQ+ynAD2GrNopYkCTuTRubYBhHMTP9/9ZnOFJaN0UIBBf7OOPspXQZ+JhrLd3l9HS3fY5GxCgWSOWV4id2PHmdqWFcPKQc4TBOS6QWmwKdVCV3nifFJ3iTJYZf5IMRZql2FyM7P0jojpxprA1+0WIbNfNHg72OtCaf7pY6hSt9Z3QDT+X7l9UGcFwo3YQvkQpnUx/kLreyTr4IovlL7TR2mwNxI7RgG6uqzK/ydcWNZgMO9WnQmnoKSM6mDvEcotueiFoBCRPiCwFnynFziWJ48Fh5noJNbC9mKthHBLjYjo9UCz55MGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjq9cFY7sC+rnmLi6EiEYJzH5nn8926sChNnEd8dU2Y=;
 b=FbBnKgyx8sdI+z2X6yMqeaE6B66XWtIrNw8/2Jrgvj74kBjQdoC+xEwpZFQD7x6rSQQexFxa4P2vXArgWdWro4lyM3tLLVhuUGLF3L46BRVoWV4opsRU2/1Raq2N8VmgrsQZ3wpYE1gkI1wGvSGvDF3EDTD9EQ0xkU18VqY++K2QjS4VeKLC625asAehkwYn0D9GN0zXo9KUXuPQ5tKuW2u4883o3TbkxvJkHmssvvpGr9tCcwuXRVFuHvsKoNsN171iQXOD5USHcnNldHN3zLq8jTfO2m1Aw8FFZiCeVVabsmWz9A0vXVHg4GWrOWl2Qb8S7iexj2YkWbK8A0HsmA==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2290.apcprd06.prod.outlook.com (2603:1096:203:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 06:23:06 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 06:23:06 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXSGulcCg0aX8h/0K5uaOliF3ibarkqkSAgALasoD//6+vgIAAitIA
Date:   Mon, 17 May 2021 06:23:06 +0000
Message-ID: <C451B628-C0CC-47E9-84EF-42DB8518FE1E@aspeedtech.com>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
 <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
 <20210517060615.3hyifoebyrddsrta@pengutronix.de>
In-Reply-To: <20210517060615.3hyifoebyrddsrta@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beafbaf5-8e43-43e8-579e-08d918fc3c1e
x-ms-traffictypediagnostic: HK0PR06MB2290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB22904C4E4622C36B34D4E2C18B2D9@HK0PR06MB2290.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12GtHW4UiMMq/axYhlSc5NGVfNYtFJgELlPKwpnV3/dhdMu/pcIZr5ATlvHO/+hthEHKedwZXiUDPey9MAtnVmo6B/takgZgrfyEoY3Ru/t9DD+6rXczcvJe82keJAGjnUvsAB4BYNv3KSwB698PDriijcTpoyXgjszjPiWGdEhzK+B72QhzKr8q2N2ZWHsycsOdJx0oMwKeDcLIGHD5MPMvWv7URM8iIkEEQRnCFPRF4y9ZEf1gma6KzIW7upZfYQBXGa4AZFP+KJ+nHnpNpJBuSDWf3MHVysnCYxBN1YOh3YOBoeXXvhki4ylTFjnGoXj0+DkjKH+o74QNU8HjOgBi6M/VHuzXzasZADiTXNejNQ6wARoukTg/Sk68s1fCWLzIuy5lW21DCUZrRHb39mkCN7KI3F0mifyQHUtlxCWr0bhyJ8xJhJq/LldbRyOdrm7nibAB0ibssJ83oVPGvWPlk23KGXfsH7LQAO/NhIca9bfa5VNCZwpQiv95dBcmEnX9aOep7Ejlqr0+FSoc0n2glTaBEKg4MpUzb7SD8n5+xefXIl/ynu7WAuVgcfREBfhVLfTkUypfE9w7IAZzbDDVik33X40MBIOT+yPNWIq5jvXnWEIaYkw63k2s2dej94icPZe1cRSp6FQpLtqcu3JXmg0brkm6ThWNZS2uXqg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(39840400004)(136003)(54906003)(316002)(6512007)(8676002)(6506007)(66476007)(71200400001)(64756008)(55236004)(8936002)(5660300002)(478600001)(33656002)(38100700002)(122000001)(6486002)(76116006)(66946007)(66556008)(66446008)(86362001)(2906002)(36756003)(4326008)(83380400001)(6916009)(186003)(2616005)(7416002)(66574015)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGF4Z2Iwa3BkMEJmQyt0RzhYTnVsWG5CbGZaN04xcjk4TWlwMW9DNDV2Z2xj?=
 =?utf-8?B?bi9NS0Vhd0ZoUkVMQ0dpSlNyMXJWZ242SEZpK3NHMUlGdkw1VVpTUXJZRnBX?=
 =?utf-8?B?andoclBvRUdxN3NteDgzc1EyS1Q3UlN1ZTJOTzA1d0hCSzUycytLSUNYUTE3?=
 =?utf-8?B?ME15TnBKaXZlVWpiOUZPbkhKU3dNanZVL0xCWmxtcFdvSytSeC9TR3N2cElN?=
 =?utf-8?B?Rm12RTE2bzRLY0wyN1FONlhtWDBqSVAwL3YrYzA1SzJacmNvdDhPajlhTzZZ?=
 =?utf-8?B?a1hqRXZ2NUhVK0V4OTFFcktJNWRlTFZBbzNIOXhxVUNaeWl1a2l4Mkg0VWtL?=
 =?utf-8?B?dE9BZ0o3THRSL0g0dkhwclFlM0FFWkRFZVV5eG1EZFRMQnlsNmxrUC9nVzA5?=
 =?utf-8?B?cTdZZGQxVDA0QzJ4em5ZV3FPeWJCQS9XTEpzM0xFODhOQVJUckdvOE5mTXJZ?=
 =?utf-8?B?Y0d0NE1EUUd3UUpsejYrTHp4OW5WKzBxSVBQT3hHZVpOWnAwck9ZMm9YYWFY?=
 =?utf-8?B?bnI2dUdWemlDcUFRT1F0cmxPN2dVWllEQ2FuS3N1NnpQd3pDTi9JNzZKa2lU?=
 =?utf-8?B?c2hRTWgycWw4elZXZ2RoZnFscjFRUytDN0NtQ0lDODJsbDk4a3RiSkJaZ29G?=
 =?utf-8?B?OEFJbFJ2ZFEwbEdxQU1CdkdmcVN6eC8zQVB5RjB6WXlFeGxXS2RZUFVyN095?=
 =?utf-8?B?bTV0eGloS3dWZVRFeHpkc1ZnY3l2RzNRbEh0SVVjTXhTYnFLYTY0bFZrUkI0?=
 =?utf-8?B?Q2JidmV0VDVIaUxFTjZpZjhNTC9tcW93VGhBcDhlYXZnekRBN2JQalJCbE4x?=
 =?utf-8?B?MXVNNDIzRlhNZnRVMnZ0TmxXTlZ3S0o0N20xLzdkbTVxYjIvRTljeWk4Ym8x?=
 =?utf-8?B?eDhDK3g4SjRTN0FrVXg3a3hHQWRLc1U3aHFEZnJKNWJTNndUZE9lcWVnSmh2?=
 =?utf-8?B?Sm5EYWRneVRsbm1JSHo2eWZ3UWF4ZUM1d2hyWHlCNzVxRW51RjhKOGw2eng3?=
 =?utf-8?B?YTRBdjNvOG5hcTBHWVdURXM0SjYxb2ZlbkdCZ2l6R2JWMWFuZXF6QXpDeVZN?=
 =?utf-8?B?L3pUbkM1ZUdhZVEvM0IrWXlSTE1MdHVKbVhwZm1YUDdpZmhXVE42K2lRcUht?=
 =?utf-8?B?ODU4bkZ3VnpncGhCN0JzS0JjNGdienhyWGx4eGdOUFVnOHd3a3ErbUZtdElN?=
 =?utf-8?B?dkRtc29Za2luVmN0QUhSZFRMSmR0MDFSOFdkdFcrcmV4Q3RUYWxRd1p1Mm93?=
 =?utf-8?B?cEthdURSMFcrK1NsSnlsMGZMeVNVZzRWa25nKzhSbUdpZVIxWE5xd3kwVkt6?=
 =?utf-8?B?am1YcXpIUjAxd2gvazZmNTV3V2EvMXVTQnFLVERibGszUUNtK0pIaVlyUXJ3?=
 =?utf-8?B?RENjTVNkUlFyaWJ4cjB1TGFEN2xDRXRXYThZZWUrLzZLdHVYbWVKM013b1VR?=
 =?utf-8?B?eFpyQlZxdk41L0xDekZtMHlPaUtVamo2RUdHNlU3UXBMYVloYytRdEFDeldU?=
 =?utf-8?B?bEc5OGtvOG4yRnBzMU5Zcmh1UEV6NmRvQS9hcFRQbkhoVHNQSWpQbzJiZHpi?=
 =?utf-8?B?R05uc2dtd2xiaGxQTEJJV3lhUFQzMkRnVGxPaGI5VVhHRkZIaEFFcGRMUHJZ?=
 =?utf-8?B?WlFJWjNiZTBuVmtkcE1QTENlaC9jWGxseEFiM0wyTTlqWDd2SWFxaDdJVFhJ?=
 =?utf-8?B?UnVBV1ZyRUU0VTdnMHkwNzNHNWR0ZG1YUHo1WlAyKytyTm9oMEhXZVA5SVNQ?=
 =?utf-8?Q?18nPr4Iqzn9iSFUqInQPBt+7GPOp9fZsZVZXcWP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <179CBF95BAA3D1469BDCF120265919DC@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beafbaf5-8e43-43e8-579e-08d918fc3c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 06:23:06.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qapy5mYqU9zmW+G2PCm6avGhJ9fdgt5Io1RzUM+seYcP0R5CDIj3Jej/MUql2lPdFWo94aJh8G6vC03eBEfh0W/Zeicwkq5DQ6U+Z21QHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2290
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQrvu78JT24gMjAyMS81LzE3LCAyOjA2IFBNLFV3ZSBLbGVpbmUtS8O2bmlnd3JvdGU6DQoN
CglPbiBNb24sIE1heSAxNywgMjAyMSBhdCAwMjo1Mzo0NEFNICswMDAwLCBCaWxseSBUc2FpIHdy
b3RlOg0KCT4JPiDvu79PbiAyMDIxLzUvMTUsIDExOjU3IFBNLFV3ZSBLbGVpbmUtS8O2bmlnd3Jv
dGU6DQoJPgk+IA0KCT4JPiAJPgk+ICsJZGl2X2ggPSBESVZfUk9VTkRfRE9XTl9VTEwoZGl2X2gs
DQoJPgk+IAk+CT4gKwkJCQkgICAoRklFTERfTUFYKFBXTV9BU1BFRURfQ1RSTF9DTEtfRElWX0wp
ICsgMSkpOw0KCT4JPiAJPgk+ICsJZGl2X2ggPSBESVZfUk9VTkRfRE9XTl9VTEwoZGl2X2gsIE5T
RUNfUEVSX1NFQyk7DQoJPgk+IA0KCT4JPiAJPiBBcyBhIGRpdmlzaW9uIGlzIGFuIGV4cGVuc2l2
ZSBvcGVyYXRpb24geW91IGNhbiBiZXR0ZXIgZmlyc3QgbXVsdGlwbHkNCgk+CT4gCT4gTlNFQ19Q
RVJfU0VDIGFuZCBGSUVMRF9NQVgoUFdNX0FTUEVFRF9DVFJMX0NMS19ESVZfTCkgKyAxIGFuZCBk
aXZpZGUgYnkNCgk+CT4gCT4gdGhlIHJlc3VsdC4NCgk+CT4gDQoJPgk+IFdoZW4gSSBtdWx0aXBs
eSBOU0VDX1BFUl9TRUMgYW5kIEZJRUxEX01BWChQV01fQVNQRUVEX0NUUkxfQ0xLX0RJVl9MKSAr
IDEgdGhlIHJlc3VsdCB3aWxsIG92ZXJmbG93DQoJPgk+IGZvciAzMi1iaXRzIGFuZCB0aGUgZGl2
aXNvciB0eXBlIG9mIGRvX2RpdiBpcyAzMi1iaXRzIHNvIEkgbmVlZCB0byBkbyBkaXYgdHdpY2Ug
dG8gYXZvaWQgdGhlIGlzc3VlLg0KCT4JPiBDYW4geW91IGdpdmUgbWUgc29tZSBzdWdnZXN0cz8N
Cg0KCT4gSG1tLCB5b3UncmUgcmlnaHQuIFRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBiZSBhIGRpdjY0
XzY0LCBJIHRob3VnaHQgdGhlcmUNCgk+IHdhcyBvbmUuIEFueWhvdywgd2hpbGUgbG9va2luZyBh
dCB0aGUgdmFyaW91cyBkaXZpZGUgZnVuY3Rpb25zIEkgc2F3DQoJPiB0aGF0IGRpdmlkaW5nIGJ5
IGEgY29uc3RhbnQgc2hvdWxkbid0IGJlIHRoYXQgZXhwZW5zaXZlLCBzbyBJIHRoaW5rIHRoZQ0K
CT4gc2FuZSB3YXkgaXMgdG8ga2VlcCB0aGUgdHdvIGRpdmlzaW9ucyBhbmQgYWRkIGEgY29tbWVu
dCBkZXNjcmliaW5nIHRoZQ0KCT4gcHJvYmxlbS4NCkFjY29yZGluZyB0byBvdXIgZml4ZWQgdmFs
dWUsIEkgdGhpbmsgdGhhdCBJIGNhbiB1c2UgYml0IHNoaWZ0IHRvIHJlZHVjZSBvbmUgZGl2aWRl
IGZ1bmN0aW9uOg0KDQpyYXRlID0gY2xrX2dldF9yYXRlKHByaXYtPmNsayk7DQovKiBHZXQgdGhl
IHNtYWxsZXN0IHZhbHVlIGZvciBkaXZfaCAgKi8NCmRpdl9oID0gcmF0ZSAqIHN0YXRlLT5wZXJp
b2Q7DQpkaXZfaCA+Pj0gKF9fZmxzKFBXTV9BU1BFRURfRklYRURfUEVSSU9EICsgMSkgKw0KCSAg
IF9fZmxzKEZJRUxEX01BWChQV01fQVNQRUVEX0NUUkxfQ0xLX0RJVl9MKSArIDEpKTsNCmRpdl9o
ID0gRElWX1JPVU5EX0RPV05fVUxMKGRpdl9oLCBOU0VDX1BFUl9TRUMpOw0KDQpkaXZfaCA9IG9y
ZGVyX2Jhc2VfMihkaXZfaCk7DQppZiAoZGl2X2ggPiAweGYpDQoJZGl2X2ggPSAweGY7DQoNCmRp
dl9sID0gcmF0ZSAqIHN0YXRlLT5wZXJpb2Q7DQpkaXZfbCA+Pj0gKF9fZmxzKFBXTV9BU1BFRURf
RklYRURfUEVSSU9EICsgMSkgKyBkaXZfaCk7DQpkaXZfbCA9IERJVl9ST1VORF9ET1dOX1VMTChk
aXZfbCwgTlNFQ19QRVJfU0VDKTsNCg0KSG93IGFib3V0IHRoaXMgY2hhbmdlIG9mIHRoZSBkcml2
ZXI/DQoNClRoYW5rcw0KDQoNCg0K
